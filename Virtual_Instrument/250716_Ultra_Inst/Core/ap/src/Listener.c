#include "Listener.h"
#include "usart.h"
#include "string.h"

static void Listener_CheckButton();
static void Listener_CheckUart();

static uint8_t rcvData = 0;
static Que_TypeDef uartRxQue;


static inputData_TypeDef inputData;
int            bufPos = 0;
static const char     correctPassword[PASS_LEN + 1] = "1234";
char           uartBuffer[PASS_LEN + 1];


void Listener_Init()
{
   Button_Init(&hBtnMode, GPIOB, GPIO_PIN_5);
   Que_Init(&uartRxQue);
   HAL_UART_Receive_IT(&huart2, &rcvData, 1); // uart recv interrupt enable
   //additional
}

void Listener_Excute()
{
   Listener_CheckButton();
   Listener_CheckUart();
}

void Listener_CheckButton()
{
   static uint32_t prevChkBtnTime = 0;
   uint32_t curTick = HAL_GetTick();
   if (curTick - prevChkBtnTime < 100) {
      return;
   }
   prevChkBtnTime = curTick;



   if (Button_GetState(&hBtnMode) == ACT_RELEASED) {
      inputData.id = MODE;
      inputData.data = MODE_ACT;
      Controller_SetInputData(inputData);
   }

}


void Listener_CheckUart() {
    int byte;

    while (!isQueEmpty(&uartRxQue)) {
        byte = deQue(&uartRxQue);

        if (byte == 'm') {
            inputData.id = MODE;
            inputData.data = MODE_ACT;
            Controller_SetInputData(inputData);
            continue;
        }

        if (byte == 'i') {
            login_controldata.data_pw_input = 1;
            bufPos = 0;
            char msg[50];
            sprintf(msg, "input success: %d\n", login_controldata.data_pw_input);
            HAL_UART_Transmit(&huart2, (uint8_t*)msg, strlen(msg), 1000);
            continue;  // <- 중요! 'i'가 숫자로도 처리되지 않게 방지
        }

        // 숫자 처리
        if (login_controldata.data_pw_input) {
            if (byte >= '0' && byte <= '9' && bufPos < PASS_LEN) {
                uartBuffer[bufPos++] = byte;
                char msg4[50];
                sprintf(msg4, "Password Input: %d\n", byte-48);
                HAL_UART_Transmit(&huart2, (uint8_t*)msg4, strlen(msg4), 1000);
            }
            if (bufPos == PASS_LEN) {
                ComparePassword();
                //login_controldata.data_pw_input = 0;
                bufPos = 0;
            }
        }
    }
}



void Listener_UartCallBack()
{
   enQue(&uartRxQue, rcvData);
   HAL_UART_Receive_IT(&huart2, &rcvData, 1); // interrupt enable
}


void ComparePassword() {
   uartBuffer[PASS_LEN] = '\0';
   if (strcmp(uartBuffer, correctPassword) == 0) {
      login_controldata.data_pw_correct = 1;
      //additional///
//        char msg1[50];
//        sprintf(msg1,"Success Opening\n");
//        HAL_UART_Transmit(&huart2, (uint8_t*)msg1, strlen(msg1),1000);
        ////
   } else {
      login_controldata.data_pw_correct = 2;
      //additional///
        //char msg2[50];
        //sprintf(msg2,"FAIL Opening\n");
        //HAL_UART_Transmit(&huart2, (uint8_t*)msg2, strlen(msg2),1000);
        ////
   }
}
