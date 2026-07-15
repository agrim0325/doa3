/*
 * ili9488.c
 *
 *  Created on: 06-Jun-2019
 *      Author: I30392
 */

#include "hal.h"
#include "Hello_system.h"
#include "ili9488.h"

void write_data16(uint8_t usData_msb,uint8_t usData_lsb)
{


	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
							(uint32_t)ZERO);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_RD_ADDR),
								(uint32_t)ONE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
							(uint32_t)TWO);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_DATA_ADDR),
							(uint32_t)usData_msb);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
								(uint32_t)THREE);


	delay1(2);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
									(uint32_t)ONE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
								(uint32_t)TWO);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
										(uint32_t)ZERO);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_DATA_ADDR),
							(uint32_t)usData_lsb);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
								(uint32_t)THREE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
								(uint32_t)ONE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
								(uint32_t)TWO);
}

void write_data8(uint8_t usData)
{

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
							(uint32_t)ZERO);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_RD_ADDR),
								(uint32_t)ONE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
							(uint32_t)TWO);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_DATA_ADDR),
							(uint32_t)usData);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
								(uint32_t)THREE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
								(uint32_t)ONE);

	delay1(200);
}

void write_cmd(uint8_t usData)
{

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
								(uint32_t)ZERO);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_RD_ADDR),
								(uint32_t)ONE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
								(uint32_t)ZERO);


	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_DATA_ADDR),
							(uint32_t)usData);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_LCD_WR_ADDR),
								(uint32_t)ONE);

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_CS_ADDR),
									(uint32_t)ONE);

	delay1(200);

}

void ILI9488_init(void)
{
	write_cmd(0x01); //software reset
	       delay1(500);
	SetReg(0x36, 0x68); // memory access control MY=0, MX=1, MV=1, BGR=1
	SetReg(0x3A,0x55);  //Interface Pixel Format  ( DPI[3:0] - DBI[2:0] )    16 bit/pixel, CPU interface format

	SetReg2Param(0xC1,0x41,0x00); //(0100 0 BT[2:0]) (0000 0 VC[2:0])
	SetReg3Param(0xC5,0x00,0x53,0x00);
	SetReg(0xC2, 0x33); //extra
	SetReg(0x35, 0x00); // enable tearing effect line

	//Gamma Setting_10323
	write_cmd(0xE0);
	write_data8(0x0F);
	write_data8(0x1B);
	write_data8(0x18);
	write_data8(0x0B);
	write_data8(0x0E);
	write_data8(0x09);
	write_data8(0x47);
	write_data8(0x94);
	write_data8(0x35);
	write_data8(0x0A);
	write_data8(0x13);
	write_data8(0x05);
	write_data8(0x08);
	write_data8(0x03);
	write_data8(0x00);

	write_cmd(0xE1);
	write_data8(0x0F);
	write_data8(0x3A);
	write_data8(0x37);
	write_data8(0x0B);

	write_data8(0x0C);
	write_data8(0x05);
	write_data8(0x4A);
	write_data8(0x24);

	write_data8(0x39);
	write_data8(0x07);
	write_data8(0x10);
	write_data8(0x04);

	write_data8(0x27);
	write_data8(0x25);
	write_data8(0x00);

	write_cmd(0x2a); // column set
	write_data8(0x00);
	write_data8(0x00);
	write_data8(0x01);
	write_data8(0xDF);

    write_cmd(0x2b); // page address set

    write_data8(0x00);
    write_data8(0x00);
    write_data8(0x01);
    write_data8(0x3F);


   write_cmd(0x11); //sleep out
   delay1(100);
   write_cmd(0x29); // display on
   delay1(100);
   write_cmd(0x2c); //memory write
   delay1(200);
   for(int iy=0;iy<480;iy++) {
	   for(int ix=0;ix<320;ix++)
   			write_data16(0x00,0x00);
   			delay1(2000);
   				}

	HW_set_32bit_reg((BASE_ADDR_0 + (addr_t) C_INIT_DONE_ADDR),(uint32_t)ONE);
}
void delay1(uint64_t x)
{
	for(uint64_t j; j<x; j++)
	{
		for(int i =0; i<10; i++)
		{
			asm("NOP\n");
		}
	}
}
void SetReg(uint8_t cmd, uint8_t data)
{
	write_cmd(cmd);
	delay1(200);
	write_data8(data);
}
void SetReg2Param(uint8_t cmd, uint8_t data1,uint8_t data2)
{
	write_cmd(cmd);
	delay1(200);
	write_data8(data1);
	delay1(200);
	write_data8(data2);
}
void SetReg3Param(uint8_t cmd, uint8_t data1,uint8_t data2,uint8_t data3)
{
	write_cmd(cmd);
	delay1(200);
	write_data8(data1);
	delay1(200);
	write_data8(data2);
	delay1(200);
	write_data8(data3);
}
