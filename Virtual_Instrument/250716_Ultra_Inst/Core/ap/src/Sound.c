#include "Sound.h"


//static void Sound_Delay(uint32_t half);

void Sound_Init()
{
	Buzzer_Init(&htim3, TIM_CHANNEL_1);
}


void Sound_Warning()
{
	Buzzer_SetFreq(1047); //mi
	Buzzer_Start();
	HAL_Delay(100);
	Buzzer_Stop();
}

void Sound_PowerOn()
{
	Buzzer_SetFreq(1047); //do
	Buzzer_Start();
	HAL_Delay(100);
	Buzzer_SetFreq(1319); //mi
	HAL_Delay(100);
	Buzzer_SetFreq(1568); //sol
	HAL_Delay(100);
	Buzzer_SetFreq(2039); //do
	HAL_Delay(100);
	Buzzer_Stop();
}

void Sound_PowerOff()
{
	Buzzer_SetFreq(2039); //do
	Buzzer_Start();
	HAL_Delay(200);
	Buzzer_SetFreq(1568); //mi
	HAL_Delay(200);
	Buzzer_SetFreq(1319); //sol
	HAL_Delay(200);
	Buzzer_SetFreq(1047); //do
	HAL_Delay(200);
	Buzzer_Stop();
}

void Sound_Do()
{
	Buzzer_SetFreq(261); //do
	Buzzer_Start();
	HAL_Delay(100);
	Buzzer_Stop();
}

void Sound_Re()
{
	Buzzer_SetFreq(293); //re
	Buzzer_Start();
	HAL_Delay(100);
	Buzzer_Stop();
}


void Sound_Mi()
{
	Buzzer_SetFreq(329); //mi
	Buzzer_Start();
	HAL_Delay(100);
	Buzzer_Stop();
}

void Sound_Pa()
{
	Buzzer_SetFreq(349); //pa
	Buzzer_Start();
	HAL_Delay(100);
	Buzzer_Stop();
}

//void Sound_Delay(uint32_t half)
//{
//	static uint32_t counter = 0;
//	counter++;
//	if (counter > HALF) return;
//	counter = 0;
//}


