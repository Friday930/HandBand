#ifndef AP_INC_LOGIN_H_
#define AP_INC_LOGIN_H_

#include "stm32f4xx_hal.h"
#include <stdbool.h>
#include "Model_Watch.h"
#include "Model_mode.h"
#include "Controller.h"

void Login_Execute();
void safe_IncTimeCallBack();
void Controller_HandlePasswordByte(int b);

#endif /* AP_INC_LOGIN_H_ */
