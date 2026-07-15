--=================================================================================================
-- File Name                           : apb3_if.vhd

-- Description                         : This module implements the APB3 slave Interface to
--                                       communicate with APB3 Master

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
-- apb3_if entity declaration
--=================================================================================================
ENTITY apb3_if IS
GENERIC (
-- Generic list
    -- Specifies pwdata_i,prdata_o signal width
    g_APB3_IF_DATA_WIDTH               : INTEGER := 32;

    -- Specifies the width of constants
    g_CONST_WIDTH                      : INTEGER := 12
);
PORT (
-- Port list
    -- APB reset
    preset_i                           : IN  STD_LOGIC;
    -- APB clock
    pclk_i                             : IN  STD_LOGIC;

    -- APB slave interface
    psel_i                             : IN  STD_LOGIC;
    pwrite_i                           : IN  STD_LOGIC;
    penable_i                          : IN  STD_LOGIC;
    paddr_i                            : IN  STD_LOGIC_VECTOR(g_APB3_IF_DATA_WIDTH-1 DOWNTO 0);
    pwdata_i                           : IN  STD_LOGIC_VECTOR(g_APB3_IF_DATA_WIDTH-1 DOWNTO 0);
    pready_o                           : OUT STD_LOGIC;
    pslverr_o                          : OUT STD_LOGIC;
   -- prdata_o                           : OUT STD_LOGIC_VECTOR(g_APB3_IF_DATA_WIDTH-1 DOWNTO 0);
	
    dc_o                               : OUT STD_LOGIC;
    cs_o                               : OUT STD_LOGIC;
    lcd_wr_o                           : OUT STD_LOGIC;
    lcd_rd_o                           : OUT STD_LOGIC;
    data_o                             : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

    init_done_o                        : OUT STD_LOGIC
	
	
);
END apb3_if;

--=================================================================================================
-- apb3_if architecture body
--=================================================================================================

ARCHITECTURE apb3_if OF apb3_if IS

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


--Input Addresses
--CONSTANT C_SPI_TX_DONE_ADDR            : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"704";
--Output Addresses
CONSTANT C_DATA_ADDR                   : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"70C";
CONSTANT C_CS_ADDR                     : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"710";
CONSTANT C_LCD_WR_ADDR                 : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"714";
CONSTANT C_LCD_RD_ADDR                 : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"718";
CONSTANT C_INIT_DONE_ADDR              : STD_LOGIC_VECTOR(g_CONST_WIDTH-1 DOWNTO 0) := x"728";

BEGIN


--=================================================================================================
-- Top level output port assignments
--=================================================================================================
pready_o                              <= '1';  -- pready_o Is always ready,there will not be any
                                               -- latency from the Fabric modules
pslverr_o                             <= '0';  -- Slave error is always '0' as there will not be
                                               --any slave error.


--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--

--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA

--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : WRITE_DECODE_PROC
-- Description: Process implements the APB write operation
--------------------------------------------------------------------------
WRITE_DECODE_PROC:
    PROCESS (preset_i, pclk_i)
    BEGIN
        IF(preset_i = '0')THEN
            dc_o                                 <= '0';
            cs_o                                 <= '0';
            lcd_wr_o                             <= '0';
            lcd_rd_o                             <= '0';
            init_done_o                          <= '0';
			data_o                               <=	(OTHERS => '0');
        ELSIF (pclk_i'EVENT AND pclk_i = '1') THEN
            IF ((psel_i = '1') AND (pwrite_i = '1') AND (penable_i = '1')) THEN
                CASE paddr_i(11 DOWNTO 0)  IS

--------------------
-- C_LCD_RD_ADDR
--------------------
                    WHEN C_LCD_RD_ADDR =>
                        lcd_rd_o <= pwdata_i(0);

--------------------
-- C_CS_ADDR
--------------------
                    WHEN C_CS_ADDR =>
                        cs_o <= pwdata_i(0);

--------------------
-- C_LCD_WR_ADDR
--------------------
                    WHEN C_LCD_WR_ADDR =>
                        lcd_wr_o <= pwdata_i(0);
                        dc_o        <= pwdata_i(1);

--------------------
-- C_INIT_DONE_ADDR
--------------------
                    WHEN C_INIT_DONE_ADDR =>
                        init_done_o <= pwdata_i(0);



--------------------
-- C_DATA_ADDR
--------------------
                    WHEN C_DATA_ADDR =>
                        data_o <= pwdata_i(7 DOWNTO 0);


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

END ARCHITECTURE apb3_if;