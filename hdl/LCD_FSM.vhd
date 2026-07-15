--=================================================================================================
-- File Name                           : LCD_FSM.vhd

-- Description                         : This module implements an FSM to transmit data to the LCD

-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--
-- SVN Revision Information            :
-- SVN $Revision                       :
-- SVN $Date                           :
--
-- COPYRIGHT 2019 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--=================================================================================================
--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
--=================================================================================================
-- LCD_FSM entity declaration
--=================================================================================================
ENTITY LCD_FSM IS
PORT(
                -- System Clock
                sys_clk_i                  : IN STD_LOGIC;
                
                -- Reset 
                reset_i                    : IN STD_LOGIC;
                
                -- Softconsole SPI init done
                init_done_i                : IN STD_LOGIC;
                
                -- Vsync from camera
                v_sync_i                   : IN STD_LOGIC;
                
                -- RAM write address
                RAM_WRITE_ADDR_I           : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                
                -- Data from LSRAM
                ram_data_i                 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                
                -- Start SPI Transaction
                lcd_wr_o                   : OUT STD_LOGIC;
                
                -- Start SPI Transaction
                cs_o                       : OUT STD_LOGIC;
                
                -- Data/Command
                dc_o                       : OUT STD_LOGIC;
                
                -- Ram read enable
                ram_read_en_o              : OUT STD_LOGIC;
                
                -- ram address
                ram_addr_o                 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
                
                -- 16 bit pixel data in 565 format
                data_o                     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END LCD_FSM;
--=================================================================================================
-- LCD_FSM architecture declaration
--=================================================================================================
ARCHITECTURE LCD_FSM of LCD_FSM IS

--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--

--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- signal declaration
--=================================================================================================
TYPE SPLIT_FSM IS  (IDLE,
                   AFTER_VSYNC,
                   RAM_RESET,
                   RAM_RESET1,
                   RAM_RESET2,
                   RAM_RESET3,
                   RAM_RESET4,
                   RAM_RESET5,
                   RAM_RESET6,
                   RAM_RESET7,
                   RAM_RESET8,
                   RAM_RESET9,
                   RAM_RESET10,
                   RAM_RESET11,
                   RAM_RESET12,
                   RAM_RESET13,
                   RAM_RESET14,
                   RAM_RESET15,
                   RAM_RESET16,
                   RAM_RESET17,
                   RAM_RESET18,
                   RAM_RESET19,
                   RAM_RESET20,
                   RAM_RESET21,
                   RAM_RESET22,
                   RAM_RESET23,
                   RAM_RESET24,
                   RAM_RESET25,
                   RAM_RESET26,
                   RAM_RESET27,
                   RAM_RESET28,
                   RAM_RESET29,
                   RAM_RESET30,
                   RAM_RESET31,
                   WAITING,
                   WRITING,
                   WRITING1,
                   WRITING1_I,
                   WRITING2,
                   WRITING3,
                   WRITING4,
                   WRITING5,
                   WRITING6,
                   WRITING7,
                   WRITING8);
SIGNAL s_state                                        : SPLIT_FSM;

SIGNAL s_v_sync_dly                                   : STD_LOGIC;
SIGNAL s_v_sync_dly2                                  : STD_LOGIC;
SIGNAL s_v_sync_re                                    : STD_LOGIC;
SIGNAL s_dc                                           : STD_LOGIC;
SIGNAL s_ram_address                                  : STD_LOGIC_VECTOR(9 DOWNTO 0);
--SIGNAL s_red                                        : STD_LOGIC_VECTOR(4 DOWNTO 0);
--SIGNAL s_green                                      : STD_LOGIC_VECTOR(5 DOWNTO 0);
--SIGNAL s_blue                                       : STD_LOGIC_VECTOR(4 DOWNTO 0);
--SIGNAL s_msb                                        : STD_LOGIC_VECTOR(7 DOWNTO 0);
--SIGNAL s_lsb                                        : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

--=================================================================================================
-- Top level output port assignments
--=================================================================================================
dc_o                      <= s_dc;
ram_addr_o                <= s_ram_address;
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
s_v_sync_re               <= s_v_sync_dly AND (NOT(s_v_sync_dly2));

--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : H_COUNT
-- Description: Counter
--------------------------------------------------------------------------
H_COUNT:PROCESS(reset_i,sys_clk_i)
BEGIN
                IF(reset_i = '0')THEN                 
                                s_v_sync_dly    <= '0';
                                s_v_sync_dly2   <= '0';
                ELSIF(RISING_EDGE(sys_clk_i)) THEN
                                s_v_sync_dly    <= v_sync_i;
                                s_v_sync_dly2   <= s_v_sync_dly;
                END IF;
END PROCESS;
--------------------------------------------------------------------------
-- Name       : START_GEN
-- Description: Generates FSM to transmit data to the LCD
--------------------------------------------------------------------------
START_GEN:PROCESS(reset_i,sys_clk_i)
BEGIN
                IF(reset_i = '0')THEN 
                                lcd_wr_o        <= '1';
                                s_state         <= IDLE;
                                data_o          <= (OTHERS=>'0');
                                cs_o            <= '1';
                                s_dc            <= '1';
                                ram_read_en_o   <= '1';
                                s_ram_address   <= (OTHERS=>'0');
                ELSIF(RISING_EDGE(sys_clk_i)) THEN
                                CASE s_state IS
                                                WHEN IDLE =>                                                                
                                                                lcd_wr_o    <= '1';
                                                                cs_o        <= '1';
                                                                IF((v_sync_i = '1') AND (init_done_i = '1')) THEN
                                                                    s_state     <= AFTER_VSYNC;
                                                                    s_dc        <= '0';
                                                                    cs_o            <= '0';
                                                                END IF;
                                                WHEN AFTER_VSYNC =>                                                                                 
                                                                lcd_wr_o    <= '0';
                                                                data_o      <= x"2A";
                                                                s_state     <= RAM_RESET;
                                                WHEN RAM_RESET =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET1;
                                                WHEN RAM_RESET1 =>
                                                                s_state     <= RAM_RESET2;
                                                                s_dc        <= '1';
                                                WHEN RAM_RESET2 =>
                                                                s_state     <= RAM_RESET3;
                                                                data_o      <= x"00";
                                                                lcd_wr_o    <= '0';
                                                                
                                                WHEN RAM_RESET3 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET4;
                                                WHEN RAM_RESET4 =>
                                                                s_state     <= RAM_RESET5;
                                                WHEN RAM_RESET5 =>
                                                                s_state     <= RAM_RESET6;
                                                                data_o      <= x"00";
                                                                lcd_wr_o    <= '0';
                                                WHEN RAM_RESET6 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET7;
                                                WHEN RAM_RESET7 =>
                                                                s_state     <= RAM_RESET8;
                                                WHEN RAM_RESET8 =>
                                                                s_state     <= RAM_RESET9;
                                                                data_o      <= x"01";
                                                                lcd_wr_o    <= '0';
                                                WHEN RAM_RESET9 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET10;
                                                WHEN RAM_RESET10 =>
                                                                s_state     <= RAM_RESET11;
                                                WHEN RAM_RESET11 =>
                                                                s_state     <= RAM_RESET12;
                                                                data_o      <= x"DF";
                                                                lcd_wr_o    <= '0';
                                                WHEN RAM_RESET12 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET13;
                                                WHEN RAM_RESET13 =>
                                                                s_state     <= RAM_RESET14;
                                                                s_dc        <= '0';
                                                WHEN RAM_RESET14 =>
                                                                s_state     <= RAM_RESET15;
                                                                data_o      <= x"2B";
                                                                lcd_wr_o    <= '0';
                                                                
                                                WHEN RAM_RESET15 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET16;
                                                WHEN RAM_RESET16 =>
                                                                s_state     <= RAM_RESET17;
                                                                s_dc        <= '1';
                                                WHEN RAM_RESET17 =>
                                                                s_state     <= RAM_RESET18;
                                                                data_o      <= x"00";
                                                                lcd_wr_o    <= '0';
                                                                
                                                WHEN RAM_RESET18 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET19;
                                                WHEN RAM_RESET19 =>
                                                                s_state     <= RAM_RESET20;
                                                WHEN RAM_RESET20 =>
                                                                s_state     <= RAM_RESET21;
                                                                data_o      <= x"00";
                                                                lcd_wr_o    <= '0';
                                                WHEN RAM_RESET21 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET22;
                                                WHEN RAM_RESET22 =>
                                                                s_state     <= RAM_RESET23;
                                                WHEN RAM_RESET23 =>
                                                                s_state     <= RAM_RESET24;
                                                                data_o      <= x"01";
                                                                lcd_wr_o    <= '0';
                                                WHEN RAM_RESET24 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET25;
                                                WHEN RAM_RESET25 =>
                                                                s_state     <= RAM_RESET26;
                                                WHEN RAM_RESET26 =>
                                                                s_state     <= RAM_RESET27;
                                                                data_o      <= x"3F";
                                                                lcd_wr_o    <= '0';
                                                WHEN RAM_RESET27 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET28;
                                                WHEN RAM_RESET28 =>
                                                                s_state     <= RAM_RESET29;
                                                                s_dc        <= '0';
                                                WHEN RAM_RESET29 =>
                                                                s_state     <= RAM_RESET30;
                                                                data_o      <= x"2C";
                                                                lcd_wr_o    <= '0';
                                                                
                                                WHEN RAM_RESET30 =>
                                                                lcd_wr_o    <= '1';
                                                                s_state     <= RAM_RESET31;
                                                WHEN RAM_RESET31 =>
                                                                s_state     <= WAITING;
                                                WHEN WAITING =>                                                                
                                                                IF(s_v_sync_re = '1') THEN
                                                                    s_state        <= AFTER_VSYNC;
                                                                    s_dc           <= '0';                                                                                
                                                                ELSIF(RAM_WRITE_ADDR_I = "00"&x"A0")THEN
                                                                    s_state        <= WRITING;
                                                                    s_ram_address  <= (OTHERS=>'0');
                                                                    s_dc           <= '1';
                                                                END IF;
                                                WHEN WRITING =>
                                                                IF(s_v_sync_re = '1') THEN
                                                                     s_state       <= AFTER_VSYNC;
                                                                     s_dc          <= '0';                
                                                                ELSE
                                                                     lcd_wr_o      <= '1';
                                                                     cs_o          <= '1';
                                                                     IF(s_ram_address = "01"&x"E0")THEN
                                                                          s_state       <= WAITING;                                                                                
                                                                     ELSE
                                                                          s_state       <= WRITING1;
                                                                          ram_read_en_o <= '1';
                                                                          cs_o          <= '0';                                                                
                                                                     END IF;                
                                                                END IF;
                                                WHEN WRITING1 =>
                                                                IF(s_v_sync_re = '1') THEN
                                                                       s_state       <= AFTER_VSYNC;
                                                                       s_dc          <= '0';                
                                                                ELSE
                                                                       ram_read_en_o  <= '0';
                                                                       s_state        <= WRITING1_I;                
				                                                END IF;
                                                WHEN WRITING1_I =>
                                                                IF(s_v_sync_re = '1') THEN
                                                                        s_state       <= AFTER_VSYNC;
                                                                        s_dc          <= '0';                
                                                                ELSE
                                                                        lcd_wr_o      <= '0';
                                                                        s_state       <= WRITING2;
                                                                        data_o        <= ram_data_i(15 DOWNTO 8);
																END IF;
                                                WHEN WRITING2 =>
			                                                    IF(s_v_sync_re = '1') THEN
                                                                        s_state       <= AFTER_VSYNC;
                                                                        s_dc          <= '0';
																ELSE
														                lcd_wr_o      <= '1';
																        s_state       <= WRITING3;
																END IF;
                                                WHEN WRITING3 =>
                                                                IF(s_v_sync_re = '1') THEN
                                                                        s_state       <= AFTER_VSYNC;
                                                                        s_dc          <= '0';                
                                                                ELSE
                                                                        s_state       <= WRITING4;
                                                                END IF;
                                                WHEN WRITING4 =>
                                                                IF(s_v_sync_re = '1') THEN
                                                                        s_state       <= AFTER_VSYNC;
                                                                        s_dc          <= '0';                
                                                                ELSE
                                                                        s_state       <= WRITING5;
                                                                        data_o        <= ram_data_i(7 DOWNTO 0);
                                                                        lcd_wr_o      <= '0';
                                                                END IF;
                                                WHEN WRITING5 =>
                                                                IF(s_v_sync_re = '1') THEN
                                                                         s_state      <= AFTER_VSYNC;
                                                                         s_dc         <= '0';                
                                                                ELSE
                                                                         lcd_wr_o     <= '1';
                                                                         s_state      <= WRITING6;
                                                                END IF;
                                                WHEN WRITING6 =>
                                                                IF(v_sync_i = '1') THEN
                                                                         s_state      <= AFTER_VSYNC;
                                                                ELSE
                                                                         s_state      <= WRITING;                                                                                                
                                                                         s_ram_address<= s_ram_address + '1';
                                                                END IF;
                                                WHEN OTHERS => 
                                                                s_state     <= IDLE;
                                END CASE;
                END IF;
END PROCESS;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END LCD_FSM;