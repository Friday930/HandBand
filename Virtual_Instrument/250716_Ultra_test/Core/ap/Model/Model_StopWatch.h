#ifndef AP_MODEL_MODEL_STOPWATCH_H_
#define AP_MODEL_MODEL_STOPWATCH_H_

#include <stdint.h>
#include "cmsis_os.h"


 typedef enum {  //Listener, Controller, Presenter에 전달하기 위해
	 S_STOPWATCH_STOP, S_STOPWATCH_RUN, S_STOPWATCH_CLEAR
 }estopWatchState_t;


 typedef enum{
	 EVENT_RUN_STOP, EVENT_CLEAR
 }eStopWatchEvent_t;


 typedef struct{
 	uint16_t msec;
 	uint8_t sec;
 	uint8_t min;
 	uint8_t hour;
 }stopWatch_t;


 extern osMessageQId stopWatchEventMsgBox; //공유 Q생성 -> 버튼 입력 정보
 extern osMailQId stopWatchDataMailBox; //공유 Q 생성 -> 시간정보

 void Model_StopWatch_Init();
 void Model_Set_StopWatchState(estopWatchState_t state);
 estopWatchState_t Model_Get_StopWatchState();


#endif /* AP_MODEL_MODEL_STOPWATCH_H_ */
