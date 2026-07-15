--=================================================================================================
-- File Name                           : FF_GENERATOR.vhd

-- Description                         : This module implements a power down signal for the camera
--                                       module based on flash freeze signals.

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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.std_logic_1164.ALL;

--=================================================================================================
-- FF_GENERATOR entity declaration
--=================================================================================================
ENTITY FF_GENERATOR IS
PORT (
    -- Reset signal
	reset_i 	    : IN STD_LOGIC;
    -- System reset
    sys_clk_i 	    : IN STD_LOGIC;

    --FF to start
    ff_to_start_i   : IN STD_LOGIC;

    --FF done
    ff_done_i       : IN STD_LOGIC;

    --CAM PWDN
    cam_pwdn_o      : OUT STD_LOGIC
);
END FF_GENERATOR;

--=================================================================================================
--FF_GENERATOR Architecture body
--=================================================================================================
ARCHITECTURE FF_GENERATOR OF FF_GENERATOR IS
--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--

--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--

--=================================================================================================
-- Signal declarations
--=================================================================================================

SIGNAL s_ff_to_start        : STD_LOGIC;
SIGNAL s_ff_to_start_dly    : STD_LOGIC;
SIGNAL s_ff_done            : STD_LOGIC;
SIGNAL s_ff_done_dly        : STD_LOGIC;


BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
--NA--

--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--

--=================================================================================================
-- Asynchronous blocks
--=================================================================================================

--=================================================================================================
-- Synchronous blocks
--=================================================================================================
OUTPUT_GEN_PROC:
    PROCESS(reset_i,sys_clk_i)
    BEGIN
        IF (reset_i = '0') THEN
            cam_pwdn_o  <= '0';
        ELSIF rising_edge(sys_clk_i) THEN
            IF(ff_to_start_i = '1')THEN
               cam_pwdn_o   <= '1'; 
            ELSE
               cam_pwdn_o   <= '0'; 
            END IF;
        END IF;
    END PROCESS;


DELAY_PROC:
    PROCESS(reset_i,sys_clk_i)
    BEGIN
        IF (reset_i = '0') THEN
            s_ff_to_start       <= '0'; 
            s_ff_to_start_dly   <= '0';
            s_ff_done           <= '0'; 
            s_ff_done_dly       <= '0';
        ELSIF rising_edge(sys_clk_i) THEN
            s_ff_to_start       <= ff_to_start_i; 
            s_ff_to_start_dly   <= s_ff_to_start;
            s_ff_done           <= ff_done_i; 
            s_ff_done_dly       <= s_ff_done;
        END IF;
    END PROCESS;


--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE FF_GENERATOR;