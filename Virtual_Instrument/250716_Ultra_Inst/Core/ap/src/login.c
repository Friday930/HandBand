#include "login.h"
#include "Model_mode.h"
#include "Controller.h"
//
//typedef struct{
//   uint8_t login_state;
//}stateControl_login_t;
//enum {WAIT_INPUT,ING_INPUT, OPEN, FAIL}

stateControl_login_t login_stateData = {0};
watch_t stopWatch;
login_input_TypeDef login_controldata;
int password_input;
bool is_timeout(uint32_t *startTick, uint32_t interval_ms);
static uint32_t openStartTick = 0;
static uint32_t failStartTick = 0;

static void wait_input();
static void input_ING();

static void SAFE_IncTime();


void safe_IncTimeCallBack()
{
   if (login_stateData.login_state == ING_INPUT) {
      SAFE_IncTime();
   }
}

void SAFE_IncTime()
{
   if (stopWatch.msec < 1000-1) {
      stopWatch.msec++;
      return;
   }
   stopWatch.msec = 0;
}

void Login_Execute()
{

   switch (login_stateData.login_state) {
   case WAIT_INPUT:   wait_input();   break;
   case ING_INPUT:   input_ING();   break;
   case OPEN:     Login_Open();    break;
   case FAIL:     Login_Fail();    break;
   case W_CLEAR :  Login_Clear();  break;
   }
}

void wait_input(void)
{
    if(login_controldata.data_pw_input)
    {
        login_stateData.login_state = ING_INPUT;
    }
}


void input_ING(void)
{
   if(login_controldata.data_pw_correct == 1)   login_stateData.login_state = OPEN;
   else if (login_controldata.data_pw_correct == 2) login_stateData.login_state = FAIL;

}

//void Login_Open(void)
//{
//
////    char msg1[50];
////    sprintf(msg1,"success Opening\n");
////    HAL_UART_Transmit(&huart2, (uint8_t*)msg1, strlen(msg1),1000);
//   if (is_timeout(&openStartTick, 60000U)) {
//
//      login_stateData.login_state = WAIT_INPUT;
//   }
//}
//
//void Login_Fail(void)
//{
////       char msg1[50];
////       sprintf(msg1,"fail Opening\n");
////       HAL_UART_Transmit(&huart2, (uint8_t*)msg1, strlen(msg1),1000);
//   HAL_Delay(3000);
//   login_stateData.login_state= WAIT_INPUT;
//}
//

// login.c 에 선언


void Login_Open(void)
{
    if (openStartTick == 0) {
        openStartTick = HAL_GetTick();
    }
    else if ((HAL_GetTick() - openStartTick) >= 60000U) {
        openStartTick = 0;
        Presenter_ResetStateMessageFlags();
        login_stateData.login_state = W_CLEAR;
    }
    // 그 외에는 아무것도 하지 않고, 계속 OPEN 상태 유지
}

void Login_Fail(void)
{
    if (failStartTick == 0) {
        failStartTick = HAL_GetTick();
    }
    else if ((HAL_GetTick() - failStartTick) >= 3000U) {
        failStartTick = 0;
        Presenter_ResetStateMessageFlags();
        login_stateData.login_state = W_CLEAR;
    }
}

void Login_Clear(void)
{
    if (failStartTick == 0) {
        failStartTick = HAL_GetTick();
    }
    else if ((HAL_GetTick() - failStartTick) >= 1000U) {
        failStartTick = 0;

        // 여기서 초기화
        login_controldata.data_pw_correct = 0;
        login_controldata.data_pw_input = 0;

        Presenter_ResetStateMessageFlags();
        login_stateData.login_state = WAIT_INPUT;
    }
}


////////////////////////////////////

bool is_timeout(uint32_t *startTick, uint32_t interval_ms)
{
   uint32_t now = HAL_GetTick();

   if (*startTick == 0) {
      *startTick = now;
      return false;
   }

   if ((now - *startTick) >= interval_ms) {
      *startTick = 0;
      return true;
   }

   return false;
}




