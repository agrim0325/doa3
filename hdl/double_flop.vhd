--=================================================================================================
-- File Name                           : double_flop.vhd

-- Description                         : This module implements a double flop for incoming camera 
--                                      signals

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
--=================================================================================================
--=================================================================================================
-- Libraries
--=================================================================================================
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--=================================================================================================
-- double_flop entity declaration
--=================================================================================================
ENTITY double_flop IS
PORT (
-- Port List
    -- System reset
    RESETN_I                           : IN STD_LOGIC;
    
    -- System clock
    SYS_CLK_I                          : IN STD_LOGIC;
	
	-- Pixel clock
    PCLK_I                             : IN STD_LOGIC;

    DATA_I                             : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    HREF_I                             : IN STD_LOGIC;

	-- Pixel clock
    PCLK_O                             : OUT STD_LOGIC;

    DATA_O                             : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    HREF_O                             : OUT STD_LOGIC
    
);
END double_flop;


--=================================================================================================
-- double_flop architecture body
--=================================================================================================
ARCHITECTURE double_flop OF double_flop IS

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
SIGNAL s_data  : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL s_data2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL s_href  : STD_LOGIC;
SIGNAL s_href2 : STD_LOGIC;
SIGNAL s_pclk  : STD_LOGIC;
SIGNAL s_pclk2 : STD_LOGIC;


BEGIN

--=================================================================================================
-- Top level output port assignments
--=================================================================================================
PCLK_O      <= s_pclk2;
DATA_O      <= s_data2;
HREF_O      <= s_href2;
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
--------------------------------------------------------------------------
-- Name       : DOUBLE_FF
-- Description: Double flops the input signals
--------------------------------------------------------------------------
DOUBLE_FF:PROCESS (RESETN_I,SYS_CLK_I)
	BEGIN
        IF(RESETN_I = '0')THEN
            s_data    <= (OTHERS => '0');
            s_pclk    <= '0';
            s_href    <= '0';
            s_href2   <= '0';
            s_pclk2   <= '0';
        ELSIF(rising_edge(SYS_CLK_I))THEN
            s_data       <= DATA_I;
            s_pclk       <= PCLK_I;	
            s_href       <= HREF_I;
            s_pclk2      <= s_pclk;			
            s_data2      <= s_data;
            s_href2      <= s_href;		
        END IF;
    END PROCESS;

--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE double_flop;
