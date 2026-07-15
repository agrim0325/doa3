--=================================================================================================
-- File Name                           : addr_decoder.vhd

-- Description                         : This module decodes the data based on register addresses

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

--=================================================================================================
-- addr_decoder entity declaration
--=================================================================================================
ENTITY addr_decoder IS
GENERIC (
-- Generic list
    -- Specifies the width of constants
    g_CONST_WIDTH                      : INTEGER := 8
);
PORT (
-- Port list
    -- Reset
    reset_i                             : IN  STD_LOGIC;
    -- System clock
    sys_clk_i                           : IN  STD_LOGIC;

    --UART interface
    --Data ready
    data_rdy_i                          : IN STD_LOGIC;
    
    --Address input
    addr_i                              : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    --Data input
    data_i                              : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

    --Red Constant
    red_const_o                         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);

    --Green Constant
    green_const_o                       : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);

    --Blue Constant
    blue_const_o                        : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);

    --Common Constant
    common_const_o                      : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)

);
END addr_decoder;

--=================================================================================================
-- addr_decoder architecture body
--=================================================================================================

ARCHITECTURE addr_decoder OF addr_decoder IS

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
--ADC Register Addresses

CONSTANT C_RED_CONST_ADDR              : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"03";
CONSTANT C_GREEN_CONST_ADDR            : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"04";
CONSTANT C_BLUE_CONST_ADDR             : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"05";
CONSTANT C_COMMON_CONST_ADDR           : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"06";


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
--NA--
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : WRITE_DECODE_PROC
-- Description: Process implements the APB write operation
--------------------------------------------------------------------------
WRITE_DECODE_PROC:
    PROCESS (reset_i, sys_clk_i)
    BEGIN
        IF(reset_i = '0')THEN
            red_const_o                          <= "00"&x"80";
            green_const_o                        <= "00"&x"80";
            blue_const_o                         <= "00"&x"80";
            common_const_o                       <= x"00000";
        ELSIF (RISING_EDGE(sys_clk_i)) THEN
            IF (data_rdy_i = '1') THEN
                CASE addr_i(7 DOWNTO 0)  IS

--------------------
-- C_RED_CONST_ADDR
--------------------
                    WHEN C_RED_CONST_ADDR =>
                        red_const_o <= data_i(9 DOWNTO 0);

--------------------
-- C_GREEN_CONST_ADDR
--------------------
                    WHEN C_GREEN_CONST_ADDR =>
                        green_const_o <= data_i(9 DOWNTO 0);

--------------------
-- C_BLUE_CONST_ADDR
--------------------
                    WHEN C_BLUE_CONST_ADDR =>
                        blue_const_o <= data_i(9 DOWNTO 0);

--------------------
-- C_COMMON_CONST_ADDR
--------------------
                    WHEN C_COMMON_CONST_ADDR =>
                        common_const_o <= data_i(19 DOWNTO 0);

--------------------
-- OTHERS
--------------------
                    WHEN OTHERS =>
                        NULL;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--

END ARCHITECTURE addr_decoder;