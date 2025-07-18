`timescale 1ns / 1ps

module Top_UART (
    input  clk,
    input  rst,
    input  rx,
    output tx
);
    wire       w_rx_done;
    wire [7:0] w_rx_data;

    uart U_UART (
        .clk       (clk),
        .rst       (rst),
        .btn_start (w_rx_done),
        .tx_data_in(w_rx_data),
        .tx_done   (),
        .tx        (tx),
        .rx        (rx),
        .rx_done   (w_rx_done),
        .rx_data   (w_rx_data)
    );


endmodule

module uart #(
    parameter DATA_WIDTH = 32
) (
    input clk,
    input rst,

    input                   btn_start,
    input  [DATA_WIDTH-1:0] tx_data_in,
    output                  tx_done,
    output                  tx,

    input  [DATA_WIDTH-1:0] rx,
    output                  rx_done,
    output [DATA_WIDTH-1:0] rx_data
);
    wire w_tick;

    uart_tx #(
        .DATA_WIDTH(DATA_WIDTH)
    ) U_UART_TX (
        .clk          (clk),
        .rst          (rst),
        .tick         (w_tick),
        .start_trigger(btn_start),
        .data_in      (tx_data_in),
        .o_tx_done    (tx_done),
        .o_tx         (tx)
    );

    baud_tick_gen U_BAUD_Tick_Gen (
        .clk      (clk),
        .rst      (rst),
        .baud_tick(w_tick)
    );

    uart_rx #(
        .DATA_WIDTH(DATA_WIDTH)
    ) U_UART_RX (
        .clk    (clk),
        .rst    (rst),
        .tick   (w_tick),
        .rx     (rx[0]),    // 첫 번째 비트만 사용
        .rx_done(rx_done),
        .rx_data(rx_data)
    );

endmodule

// ========== 32비트 UART TX ==========
module uart_tx #(
    parameter DATA_WIDTH = 32
) (
    input                   clk,
    input                   rst,
    input                   tick,
    input                   start_trigger,
    input  [DATA_WIDTH-1:0] data_in,
    output                  o_tx,
    output                  o_tx_done
);

    localparam BIT_COUNT_WIDTH = $clog2(DATA_WIDTH);

    // fsm state
    parameter IDLE = 0, SEND = 1, START = 2, DATA = 3, STOP = 4;

    reg [3:0] state, next;
    reg tx_reg, tx_next;
    reg                       tx_done_reg;
    reg                       tx_done_next;
    reg [BIT_COUNT_WIDTH-1:0] bit_count_reg;
    reg [BIT_COUNT_WIDTH-1:0] bit_count_next;
    reg [                3:0] tick_count_reg;
    reg [                3:0] tick_count_next;

    reg [DATA_WIDTH-1:0] temp_data_reg, temp_data_next;  // tx data in buffer

    assign o_tx      = tx_reg;
    assign o_tx_done = tx_done_reg;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state <= 0;
            tx_reg <= 1'b1;
            tx_done_reg <= 0;
            bit_count_reg <= 0;
            tick_count_reg <= 0;
        end else begin
            state <= next;
            tx_reg <= tx_next;
            tx_done_reg <= tx_done_next;
            bit_count_reg <= bit_count_next;
            tick_count_reg <= tick_count_next;
            temp_data_reg <= temp_data_next;
        end
    end

    // next
    always @(*) begin
        next = state;
        tx_next = tx_reg;
        tx_done_next = tx_done_reg;
        bit_count_next = bit_count_reg;
        tick_count_next = tick_count_reg;
        temp_data_next = temp_data_reg;
        case (state)
            IDLE: begin
                tx_next = 1'b1;
                tx_done_next = 1'b0;
                tick_count_next = 4'h0;
                if (start_trigger) begin
                    next = START;
                    temp_data_next = data_in;
                end
            end

            SEND: begin
                if (tick == 1'b1) begin
                    next = START;
                end
            end

            START: begin
                tx_done_next = 1'b1;
                tx_next = 1'b0;
                if (tick == 1'b1) begin
                    if (tick_count_reg == 15) begin
                        next = DATA;
                        bit_count_next = 0;
                        tick_count_next = 0;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
            end

            DATA: begin
                tx_next = temp_data_reg[bit_count_reg];  // LSB first
                if (tick) begin
                    if (tick_count_reg == 15) begin
                        tick_count_next = 0;
                        if (bit_count_reg == DATA_WIDTH-1) begin  // 32비트 완료
                            next = STOP;
                        end else begin
                            next = DATA;
                            bit_count_next = bit_count_reg + 1;
                        end
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
            end

            STOP: begin
                tx_next = 1'b1;
                if (tick == 1'b1) begin
                    if (tick_count_reg == 15) begin
                        next = IDLE;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
            end
        endcase
    end

endmodule

// ========== 32비트 UART RX ==========
module uart_rx #(
    parameter DATA_WIDTH = 32
) (
    input                   clk,
    input                   rst,
    input                   tick,
    input                   rx,
    output                  rx_done,
    output [DATA_WIDTH-1:0] rx_data
);

    localparam BIT_COUNT_WIDTH = $clog2(DATA_WIDTH);

    localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg [1:0] state, next;
    reg rx_done_reg, rx_done_next;
    reg [BIT_COUNT_WIDTH-1:0] bit_count_reg_rx, bit_count_next_rx;
    reg [4:0] tick_count_reg_rx, tick_count_next_rx;
    reg [DATA_WIDTH-1:0] rx_data_reg, rx_data_next;

    // output
    assign rx_done = rx_done_reg;
    assign rx_data = rx_data_reg;

    // state
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state <= 0;
            rx_done_reg <= 0;
            rx_data_reg <= 0;
            bit_count_reg_rx <= 0;
            tick_count_reg_rx <= 0;
        end else begin
            state <= next;
            rx_done_reg <= rx_done_next;
            rx_data_reg <= rx_data_next;
            bit_count_reg_rx <= bit_count_next_rx;
            tick_count_reg_rx <= tick_count_next_rx;
        end
    end

    // next
    always @(*) begin
        next = state;
        rx_data_next = rx_data_reg;
        tick_count_next_rx = tick_count_reg_rx;
        bit_count_next_rx = bit_count_reg_rx;
        rx_done_next = 1'b0;
        case (state)
            IDLE: begin
                tick_count_next_rx = 0;
                bit_count_next_rx = 0;
                rx_done_next = 1'b0;
                if (rx == 0) begin
                    next = START;
                end
            end
            START: begin
                if (tick == 1'b1) begin
                    if (tick_count_reg_rx == 7) begin
                        next = DATA;
                        tick_count_next_rx = 0;
                    end else begin
                        tick_count_next_rx = tick_count_reg_rx + 1;
                    end
                end
            end
            DATA: begin
                if (tick == 1'b1) begin
                    if (tick_count_reg_rx == 15) begin
                        // read data
                        rx_data_next[bit_count_reg_rx] = rx;
                        if (bit_count_reg_rx == DATA_WIDTH-1) begin  // 32비트 완료
                            next = STOP;
                            tick_count_next_rx = 0;
                        end else begin
                            next = DATA;
                            bit_count_next_rx = bit_count_reg_rx + 1;
                            tick_count_next_rx = 0;
                        end
                    end else begin
                        tick_count_next_rx = tick_count_reg_rx + 1;
                    end
                end
            end
            STOP: begin
                if (tick == 1'b1) begin
                    if (tick_count_reg_rx == 23) begin
                        rx_done_next = 1'b1;
                        next = IDLE;
                    end else begin
                        tick_count_next_rx = tick_count_reg_rx + 1;
                    end
                end
            end
        endcase
    end

endmodule

// ========== Baud Tick Generator (기존 그대로) ==========
module baud_tick_gen (
    input  clk,
    input  rst,
    output baud_tick
);
    parameter BAUD_RATE = 9600;

    localparam BAUD_COUNT = (100_000_000 / BAUD_RATE) / 16;
    reg [$clog2(BAUD_COUNT) - 1:0] count_reg;
    reg [$clog2(BAUD_COUNT) - 1:0] count_next;
    reg tick_reg, tick_next;
    assign baud_tick = tick_reg;

    always @(posedge clk, posedge rst) begin
        if (rst == 1) begin
            count_reg <= 0;
            tick_reg  <= 0;
        end else begin
            count_reg <= count_next;
            tick_reg  <= tick_next;
        end
    end

    always @(*) begin
        count_next = count_reg;
        tick_next  = tick_reg;

        if (count_reg == BAUD_COUNT - 1) begin
            count_next = 0;
            tick_next  = 1'b1;
        end else begin
            count_next = count_reg + 1;
            tick_next  = 1'b0;
        end
    end

endmodule
