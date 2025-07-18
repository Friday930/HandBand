/*
 * Presenter.c
 *
 *  Created on: Jun 24, 2025
 *      Author: rhoblack
 */
#include "Presenter.h"
#include <string.h>
#include <stdio.h>
#include "usart.h"
#include "Ultra.h"
#include "stdbool.h"


//additional
#include "UltraRun.h"

#define HALF 5000

static void Presenter_DispTimeWatch(watch_t watchData);
static void Presenter_DispStopWatch(watch_t watchData);
static void Presenter_DispFndTimeWatch(watch_t watchData);
static void Presenter_DispFndStopWatch(watch_t watchData);
static void Presenter_DispMonitorTimeWatch(watch_t watchData);
static void Presenter_DispMonitorStopWatch(watch_t watchData);

static void Presenter_UL_WarningLED_ON();
static void Presenter_UL_WarningLED_OFF();
static void Presenter_UL_LoginLED_ON();
static void Presenter_UL_LoginLED_OFF();
static void Presenter_UL_ModeLOGIN();

static void Presenter_UL_ModeWarning();


static void Presenter_DispMonitorPasswordUart(const char *uartBuffer);
static void Present_Disp_UART_InsertPwMESSAGE();
static void Present_Disp_UART_state_messege();

static watch_t dispData = {TIME_WATCH, 12, 0, 0, 0};

static stateControl_t ultraState1;

static ultra_t ultraData;

static shown_ing  = false;
static shown_open = false;
static shown_fail = false;


void Presenter_Init()
{
   LCD_Init(&hi2c1);
   Buzzer_Init(&htim3, TIM_CHANNEL_1);
   MotorRun_Init();
}

void Presenter_OutData(watch_t watchData)
{
   memcpy(&dispData, &watchData, sizeof(watch_t));
}



///additional //////////////////////////////////

void Presenter_UL_StateData()
{
   memcpy(&ultraState1, &stateData, sizeof(stateControl_t));
}


void Presenter_UL_OutData(ultra_t ultraDst)
{
   memcpy(&ultraData, &ultraDst, sizeof(ultra_t));
}

//UL
void Presenter_UL_Detected() //ultra_t ultraDst
{

      char str[50];
      sprintf(str,"!!Safe is not Safe!! \n");
      HAL_UART_Transmit(&huart2, (uint8_t *)str, strlen(str), 1000);

}

void Presenter_UL_NotDetected() //ultra_t ultraDst
{
      char str[50];
      sprintf(str,"Distance : %03d cm\n", ultraData.ultra_data);
      HAL_UART_Transmit(&huart2, (uint8_t *)str, strlen(str), 1000);
}


void Presenter_UL_WarningLED_ON()
{
   HAL_GPIO_WritePin(GPIOA, GPIO_PIN_9, GPIO_PIN_SET);
   HAL_Delay(1);
}

void Presenter_UL_WarningLED_OFF()
{
   HAL_GPIO_WritePin(GPIOA, GPIO_PIN_9, GPIO_PIN_RESET);
   HAL_Delay(1);
}

void Presenter_UL_LoginLED_ON()
{
   HAL_GPIO_WritePin(GPIOC, GPIO_PIN_7, GPIO_PIN_SET);
   HAL_Delay(1);
}

void Presenter_UL_LoginLED_OFF()
{
   HAL_GPIO_WritePin(GPIOC, GPIO_PIN_7, GPIO_PIN_RESET);
   HAL_Delay(1);
}

void Presenter_UL_ModeWarning()
{
   HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_SET);
}

void Presenter_UL_ModeLOGIN()
{
   HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_RESET);
}


void Presenter_UL_Excute()
{
   if(ultraState1.state == P_SEC){
      Presenter_UL_LoginLED_OFF();
      Presenter_UL_ModeWarning();
      if(1 <= ultraData.ultra_data && ultraData.ultra_data < 10){
         Sound_Do();
         Presenter_UL_NotDetected;
      }
      else if(11 <= ultraData.ultra_data && ultraData.ultra_data < 20){
    	  Sound_Re();
    	  Presenter_UL_NotDetected;
      }
      else if(21 <= ultraData.ultra_data && ultraData.ultra_data < 30){
    	  Sound_Mi();
    	  Presenter_UL_NotDetected;
      }
      else if(35 <= ultraData.ultra_data && ultraData.ultra_data < 40){
    	  Sound_Pa();
    	  Presenter_UL_NotDetected;
      }
   }
   else
	  Presenter_UL_NotDetected;
      Presenter_LOG_Excute();
   	  Presenter_UL_ModeLOGIN();

}


////////////////////////////////////////
////////////////////////////////////////


void Presenter_LOG_Excute()
{
	if(login_stateData.login_state == WAIT_INPUT)
		{
		Present_Disp_UART_InsertPwMESSAGE();
		}

   Present_Disp_UART_state_messege();

}

void Presenter_DispMonitorPasswordUart(const char *uartBuffer)
{
   static int Uart_count = 0;
      static bool shown = false;
   Uart_count++;
   if(Uart_count < 100000) return;
   Uart_count = 0;
   char str[50];
   //   if(!shown && login_controldata.data_pw_input )
   //   {

   sprintf(str,"password:%s\n",uartBuffer);
   HAL_UART_Transmit(&huart2, (uint8_t *)str, strlen(str), 1000);
   //      shown = true;
   //login_controldata.data_pw_input = 0;
   //   }
   //3초 딜레이


}

void Present_Disp_UART_InsertPwMESSAGE()
{

   static int  uart_count    = 0;
   static bool prompt_shown  = false;

   uart_count++;
   if (uart_count < 10000) return;
   uart_count = 0;

   if (!login_controldata.data_pw_input && !prompt_shown) {
      const char *msg = "insert 'i' if you want insert password\n";
      HAL_UART_Transmit(&huart2, (uint8_t*)msg, strlen(msg), 1000);
      prompt_shown = true;
   }
   else if (login_controldata.data_pw_input) {
      // 'i' 모드 진입하면 다음에 또 보여줄 수 있도록 리셋
      prompt_shown = false;
   }
}

// state 확인 메세지 출력용

void Present_Disp_UART_state_messege()
{
     static int  uart_count    = 0;
       static bool shown_ing     = false;
       static bool shown_open    = false;
       static bool shown_fail    = false;

       uart_count++;
       if (uart_count < 10000) return;
       uart_count = 0;

       switch (login_stateData.login_state)
       {
       case ING_INPUT:
           if (!shown_ing) {
               const char *msg = "Please enter a 4-digit password\n";
               HAL_UART_Transmit(&huart2, (uint8_t*)msg, strlen(msg), 1000);
               shown_ing = true;
               shown_open = shown_fail = false;
           }
           break;

       case OPEN:
           if (!shown_open) {
               const char *msg = "The password is correct. The safe has been unlocked.\n";
               HAL_UART_Transmit(&huart2, (uint8_t*)msg, strlen(msg), 1000);
               Sound_PowerOn();
               MotorRUN_PowerOn();
               shown_open = true;
               shown_ing = shown_fail = false;
           }
           break;

       case FAIL:
           if (!shown_fail) {
               const char *msg = "The password is wrong.\n";
               HAL_UART_Transmit(&huart2, (uint8_t*)msg, strlen(msg), 1000);
               Sound_PowerOff();
               shown_fail = true;
               shown_ing = shown_open = false;
           }
           break;

       }

}


void Presenter_ResetStateMessageFlags() {
    shown_ing  = false;
    shown_open = false;
    shown_fail = false;
}

///////////////////////////////////////////
///////////////////////////////////////////






void Presenter_Excute()
{
   if (dispData.id == TIME_WATCH){
      Presenter_DispTimeWatch(dispData);
   }
   else { // STOP_WATCH
      Presenter_DispStopWatch(dispData);
   }
}



void Presenter_DispTimeWatch(watch_t watchData)
{
   Presenter_DispFndTimeWatch(watchData);
   Presenter_DispMonitorTimeWatch(watchData);
}

void Presenter_DispStopWatch(watch_t watchData)
{
   Presenter_DispFndStopWatch(watchData);
   Presenter_DispMonitorStopWatch(watchData);
}



void Presenter_DispFndTimeWatch(watch_t watchData)
{
   FND_WriteData(watchData.hour*100 + watchData.min);

   FND_WriteDp(FND_DP_1000|FND_DP_10|FND_DP_1, FND_DP_OFF);

   if (watchData.msec < 500) {
      FND_WriteDp(FND_DP_100, FND_DP_ON);
   }
   else {
      FND_WriteDp(FND_DP_100, FND_DP_OFF);
   }
}

void Presenter_DispFndStopWatch(watch_t watchData)
{
   FND_WriteData((watchData.min % 10 * 1000) + (watchData.sec * 10) + (watchData.msec/100));

   FND_WriteDp(FND_DP_100|FND_DP_1, FND_DP_OFF);

   if (watchData.msec%100 < 50) {
      FND_WriteDp(FND_DP_10, FND_DP_ON);
   }
   else {
      FND_WriteDp(FND_DP_10, FND_DP_OFF);
   }

   if (watchData.msec < 500) {
      FND_WriteDp(FND_DP_1000, FND_DP_ON);
   }
   else {
      FND_WriteDp(FND_DP_1000, FND_DP_OFF);
   }
}

void Presenter_DispMonitorTimeWatch(watch_t watchData)
{
   char str[50];
   sprintf(str,"Time Watch : %02d:%02d:%02d.%03d\n", watchData.hour, watchData.min, watchData.sec, watchData.msec);
   HAL_UART_Transmit(&huart2, (uint8_t *)str, strlen(str), 1000);
}

void Presenter_DispMonitorStopWatch(watch_t watchData)
{
   char str[50];
   sprintf(str,"Stop Watch : %02d:%02d:%02d.%03d\n", watchData.hour, watchData.min, watchData.sec, watchData.msec);
   HAL_UART_Transmit(&huart2, (uint8_t *)str, strlen(str), 1000);
}
