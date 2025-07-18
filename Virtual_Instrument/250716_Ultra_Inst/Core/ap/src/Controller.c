/*
 * Controller.c
 *
 *  Created on: Jun 24, 2025
 *      Author: rhoblack
 */
#include "Controller.h"


typedef enum {S_LOG_IN, S_SECURITY} safeModeState_t;

void Controller_Mode();

stateControl_t stateData = {0};
inputData_TypeDef controlData = {};
static safeModeState_t modeState = S_LOG_IN;


void Controller_Excute()
{
	Controller_Mode();
}

void Controller_SetInputData(inputData_TypeDef inputData)
{
	if (inputData.id == MODE) {
		controlData.id = MODE;
		controlData.data = MODE_ACT;
	}
}


void Controller_Mode()
{
	switch(modeState)
	{
	case S_LOG_IN:
		if (controlData.id == MODE) {
			controlData.id = NO_CONTROL;
			modeState = S_SECURITY;
			stateData.state = P_LOG;
			 Presenter_UL_StateData(stateData);
		}
		Login_Execute();
		break;

	case S_SECURITY:
		if (controlData.id == MODE) {
			controlData.id = NO_CONTROL;
			modeState = S_LOG_IN;
			stateData.state = P_SEC;
			Presenter_UL_StateData(stateData);
		}
		Security_Excute();
		break;

	}
}
