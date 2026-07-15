--=================================================================================================
-- File Name                           : mux_2_1.vhd

-- Description                         : This module implements a multiplexer for LCD signals

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
USE IEEE.STD_LOGIC_ARITH.ALL;
--=================================================================================================
-- mux_2_1 entity declaration
--=================================================================================================
ENTITY mux_2_1 IS
PORT(
    -- Selection line
                sel_i                      : IN STD_LOGIC;

    -- start signal 1
                wr1_i                      : IN STD_LOGIC;

    -- start signal 2
                wr2_i                      : IN STD_LOGIC;

    -- start signal 1
                cs1_i                      : IN STD_LOGIC;

    -- start signal 2
                cs2_i                      : IN STD_LOGIC;

    -- start signal 1
                dc1_i                      : IN STD_LOGIC;

    -- start signal 2
                dc2_i                      : IN STD_LOGIC;

    -- start signal 1
                rd1_i                      : IN STD_LOGIC;

    -- start signal 2
                rd2_i                      : IN STD_LOGIC;
                
    -- Input data 1
                data1_i                    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                
    -- Input data 2
                data2_i                    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                
    -- 8bit data output in 5x6x5 format
                data_o                     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- start output
                wr_o                       : OUT STD_LOGIC;

    -- start output
                cs_o                       : OUT STD_LOGIC;

    -- start output
                dc_o                       : OUT STD_LOGIC;

    -- start output
                rd_o                       : OUT STD_LOGIC
    
);
END mux_2_1;
--=================================================================================================
-- mux_2_1 architecture body
--=================================================================================================
ARCHITECTURE mux_2_1 OF mux_2_1 IS

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
SIGNAL s_data   : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL s_dc     : STD_LOGIC;

BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
dc_o   <= s_dc;
data_o <= s_data; 
wr_o <= wr2_i WHEN (sel_i = '1') ELSE wr1_i;
rd_o <= rd2_i WHEN (sel_i = '1') ELSE rd1_i;
cs_o <= cs2_i WHEN (sel_i = '1') ELSE cs1_i;
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--

--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
s_dc <= dc2_i WHEN (sel_i = '1') ELSE dc1_i;
s_data <= data2_i WHEN (sel_i = '1') ELSE data1_i;
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE mux_2_1;