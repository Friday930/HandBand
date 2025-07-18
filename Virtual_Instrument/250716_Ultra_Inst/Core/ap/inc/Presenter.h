/*
 * Presenter.h
 *
 *  Created on: Jun 24, 2025
 *      Author: rhoblack
 */

#ifndef AP_PRESENTER_H_
#define AP_PRESENTER_H_

#include "Model_mode.h"
#include "Model_Watch.h"
#include "FND.h"
#include "lcd.h"
#include "LedBar.h"
#include "Buzzer.h"
#include "Sound.h"
#include "Controller.h"
#include "Listener.h"
#include "Login.h"
#include "MotorRun.h"


void Presenter_OutData(watch_t watchData);
void Presenter_Excute();

//additional
void Presenter_Init();
void Presenter_UL_OutData(ultra_t ultraDst);
void Presenter_UL_Excute();
void Presenter_Delay(uint32_t half);
void Presenter_UL_StateData();

/////
void Presenter_LOG_Excute();
void Presenter_ResetStateMessageFlags();

/////
#endif /* AP_PRESENTER_H_ */

