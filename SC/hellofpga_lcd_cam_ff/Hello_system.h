/*
 * Hello_system.h
 *
 *  Created on: 06-Jun-2019
 *      Author: I30392
 */

#ifndef MOTORCONTROL_APP_HELLO_SYSTEM_H_
#define MOTORCONTROL_APP_HELLO_SYSTEM_H_

#include "hal.h"
#define BASE_ADDR_0             					(addr_t)(0x30000000U)
#define BASE_ADDR_1             					(addr_t)(0x30001000U)


addr_t g_base_addr;

#define C_SPI_TX_DONE_ADDR        				    (addr_t)(0x00000704U)
#define C_DC_ADDR        				    		(addr_t)(0x00000708U)
#define C_DATA_ADDR        				   			(addr_t)(0x0000070CU)
#define C_CS_ADDR                   	    		(addr_t)(0x00000710U)
#define C_LCD_WR_ADDR                   	    	(addr_t)(0x00000714U)
#define C_LCD_RD_ADDR                   	    	(addr_t)(0x00000718U)
#define C_INIT_DONE_ADDR                   	        (addr_t)(0x00000728U)
#define C_SATURATION_ADDR							(addr_t)(0x00000020U)
#define C_CONTRAST_ADDR								(addr_t)(0x00000030U)
#define C_BRIGHTNESS_ADDR							(addr_t)(0x00000034U)
#endif /* MOTORCONTROL_APP_HELLO_SYSTEM_H_ */
