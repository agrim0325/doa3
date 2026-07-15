--=================================================================================================
-- File Name                           : Write_LSRAM.vhd

-- Description                         : This module aligns incoming camera data and writes it 
--                                      into a RAM for storage. The incoming signal is scaled down.

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
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

--=================================================================================================
-- WRITE_LSRAM entity declaration
--=================================================================================================
ENTITY WRITE_LSRAM IS
GENERIC(
-- Generic List
	-- Specifies the data width
	G_DATA_WIDTH        : INTEGER RANGE 0 To 16 := 8;
	
	-- Specifies the ram address bit width
	G_ADDRESS_WIDTH     : INTEGER RANGE 0 To 32 := 10
);
PORT (
-- Port List
    -- System reset
    RESETN_I                           : IN STD_LOGIC;
    
    -- System clock
    SYS_CLK_I                          : IN STD_LOGIC;
	
	-- Pixel clock
    PCLK_I                             : IN STD_LOGIC;
    
    -- Specifies the input data is valid or not
    H_REF_I                            : IN STD_LOGIC;
	
	-- Specifies end of frame
    V_SYNC_I                           : IN STD_LOGIC;
    
    -- Data input
    DATA_I                        	   : IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
	
	-- Enable RAM write
    RAM_WR_EN_O                        : OUT STD_LOGIC;
	
	-- RAM data 
    DATA_O                			   : OUT STD_LOGIC_VECTOR(2*G_DATA_WIDTH-1 DOWNTO 0);
	
	-- Specifies the horizontal counter value
    RAM_ADDRESS_O                      : OUT STD_LOGIC_VECTOR(G_ADDRESS_WIDTH-1 DOWNTO 0)
);
END WRITE_LSRAM;

--=================================================================================================
-- WRITE_LSRAM Architecture body
--=================================================================================================
ARCHITECTURE WRITE_LSRAM OF WRITE_LSRAM IS

--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--

--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--

--=================================================================================================
-- Function declarations
--=================================================================================================
--NA--

--=================================================================================================
-- Signal declarations
--=================================================================================================										  

SIGNAL s_ram_address            : STD_LOGIC_VECTOR(G_ADDRESS_WIDTH-1 DOWNTO 0);
SIGNAL s_data            		: STD_LOGIC_VECTOR(2*G_DATA_WIDTH-1 DOWNTO 0);
SIGNAL s_h_counter              : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s_v_counter              : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s_h_ref_dly              : STD_LOGIC;
SIGNAL s_h_ref_dly1             : STD_LOGIC;
SIGNAL s_h_ref_fe               : STD_LOGIC;
SIGNAL s_pclk_dly             	: STD_LOGIC;
SIGNAL s_pclk_dly1             	: STD_LOGIC;
SIGNAL s_pclk_re             	: STD_LOGIC;
SIGNAL s_v_write             	: STD_LOGIC;
SIGNAL s_h_write             	: STD_LOGIC;

BEGIN


--=================================================================================================
-- Top level output port assignments
--=================================================================================================
RAM_WR_EN_O        	<= '1' WHEN ((s_h_write = '1') AND (s_v_write = '1')
						AND (H_REF_I = '1') AND (s_pclk_re = '1')) ELSE '0';

RAM_ADDRESS_O 	   	<= s_ram_address;
DATA_O				<= s_data;

--=================================================================================================
-- GENERATE blocks
--=================================================================================================
--NA--

--=================================================================================================
-- Asynchronous blocks
--=================================================================================================

s_h_ref_fe  <= s_h_ref_dly1 AND (NOT(s_h_ref_dly));
s_pclk_re	<= s_pclk_dly AND (NOT(s_pclk_dly1));
s_v_write   <= '1' WHEN ((s_v_counter = "00"&x"00")OR(s_v_counter = "00"&x"01")) ELSE '0';
s_h_write   <= '1' WHEN ((s_h_counter = "00"&x"00") OR (s_h_counter = "00"&x"02") OR (s_h_counter = "00"&x"04")) ELSE '0';
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
	
--------------------------------------------------------------------------
-- Name       : H_COUNTER_GEN
-- Description: Generates the horizontal counter
--------------------------------------------------------------------------
H_COUNTER_GEN:PROCESS (RESETN_I,SYS_CLK_I)
	BEGIN
        IF(RESETN_I = '0')THEN
            s_h_counter      <= (OTHERS=>'0');  
			s_h_ref_dly      <= '0';
			s_h_ref_dly1     <= '0';
			s_pclk_dly       <= '0';
			s_pclk_dly1      <= '0';
        ELSIF(rising_edge(SYS_CLK_I))THEN
			s_h_ref_dly      <= H_REF_I;
			s_h_ref_dly1     <= s_h_ref_dly;
			s_pclk_dly       <= PCLK_I;
			s_pclk_dly1      <= s_pclk_dly;
            IF(V_SYNC_I = '1' OR H_REF_I = '0')THEN
                s_h_counter <= (OTHERS=>'0');
                s_data  	<= (OTHERS=>'0');                
			ELSE
				IF(s_pclk_re = '1') THEN
					IF(s_h_counter = "00"&x"07")THEN
                       s_h_counter       	<= (OTHERS=>'0');
                    ELSE
                        s_h_counter  <= s_h_counter + 1; 
                    END IF; 
					s_data(7 DOWNTO 0)  <= DATA_I; 
					s_data(15 DOWNTO 8) <= s_data(7 DOWNTO 0);
				END IF;
			END IF;			
        END IF;
    END PROCESS;

--------------------------------------------------------------------------
-- Name       : V_COUNTER_GEN
-- Description: Generates the vertical counter
--------------------------------------------------------------------------
V_COUNTER_GEN:PROCESS (RESETN_I,SYS_CLK_I)
	BEGIN
        IF(RESETN_I = '0')THEN
            s_v_counter       	<= (OTHERS=>'0'); 
        ELSIF(rising_edge(SYS_CLK_I))THEN
			IF(V_SYNC_I = '1')THEN
				s_v_counter       	<= (OTHERS=>'0');
			ELSE
				IF(s_h_ref_fe = '1')THEN
                    IF(s_v_counter = "00"&x"02")THEN
                       s_v_counter       	<= (OTHERS=>'0');
                    ELSE
                        s_v_counter  <= s_v_counter + 1; 
                    END IF;
				END IF;	
			END IF;
        END IF;
    END PROCESS;
	
--------------------------------------------------------------------------
-- Name       : RAM_ADDRESS_GEN
-- Description: Generates the RAM address
--------------------------------------------------------------------------
RAM_ADDRESS_GEN:PROCESS (RESETN_I,SYS_CLK_I)
	BEGIN
        IF(RESETN_I = '0')THEN
            s_ram_address       	<= (OTHERS=>'0'); 
        ELSIF(rising_edge(SYS_CLK_I))THEN
			IF(H_REF_I = '0' OR V_SYNC_I = '1') THEN
				s_ram_address  <= (OTHERS=>'0');					
			ELSIF((s_h_write = '1') AND (s_v_write = '1') AND (s_pclk_re = '1'))THEN
				s_ram_address  <= s_ram_address + 1; 
			END IF;
        END IF;
    END PROCESS;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
 --NA--
  
END WRITE_LSRAM;
