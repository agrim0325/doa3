/*
 * ili9488.h
 *
 *  Created on: 06-Jun-2019
 *      Author: I30392
 */

#ifndef MOTORCONTROL_APP_ILI9488_H_
#define MOTORCONTROL_APP_ILI9488_H_

#define ONE   0x00000001
#define ZERO  0x00000000
#define THREE 0x00000003
#define TWO   0x00000002

void write_data16(uint8_t,uint8_t);
void write_data8(uint8_t);
void write_cmd(uint8_t);
void ILI9488_init(void);
void SetReg3Param(uint8_t cmd, uint8_t data1,uint8_t data2,uint8_t data3);
void SetReg2Param(uint8_t cmd, uint8_t data1,uint8_t data2);
void SetReg(uint8_t cmd, uint8_t data);


void delay1(uint64_t x);

#endif /* MOTORCONTROL_APP_ILI9488_H_ */
