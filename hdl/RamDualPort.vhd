--=================================================================================================
-- File Name                           : ramDualPort.vhd

-- Description                         : This module infers a Dual Port RAM

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
USE IEEE.STD_LOGIC_ARITH.ALL;                                                                                         
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


--=================================================================================================
-- ramDualPort entity declaration
--=================================================================================================
ENTITY ramDualPort IS                                                                                           
  GENERIC ( DATA_WIDTH    : integer := 16;                                                                            
            ADDRESS_WIDTH : integer := 10;                                                                             
            BUFF_DEPTH   : integer := 1024                                                                            
          );                                                                                                          
  PORT(                                                                                                               
  --Inputs                                                                                                            
    clk       :  IN   STD_LOGIC;                                                                                      
    we_a      :  IN   STD_LOGIC;                                                                                      
    we_b      :  IN   STD_LOGIC;                                                                                      
    addr_a    :  IN   STD_LOGIC_VECTOR ((ADDRESS_WIDTH -1) DOWNTO 0);                                                 
    addr_b    :  IN   STD_LOGIC_VECTOR ((ADDRESS_WIDTH -1) DOWNTO 0);                                                 
    data_a    :  IN   STD_LOGIC_VECTOR ((DATA_WIDTH -1) DOWNTO 0);

  --Outputs
    q_b       :  OUT   STD_LOGIC_VECTOR ((DATA_WIDTH -1) DOWNTO 0)
  );
END ramDualPort;

--=================================================================================================
-- ramDualPort architecture body
--=================================================================================================
ARCHITECTURE ramDualPort OF ramDualPort IS

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
--Declare the RAM variable
  type t_ram_reg is array((BUFF_DEPTH-1) downto 0) of std_logic_vector ((DATA_WIDTH -1) downto 0);
  signal ram   : t_ram_reg;  

  attribute syn_ramstyle : string;
  attribute syn_ramstyle of ram : signal is "lsram"; 
  
  signal q_b_reg : std_logic_vector ((DATA_WIDTH -1) downto 0);

BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
  q_b <= q_b_reg;
  
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
-------------------------------------------------------------------------------------
-------------------------------Process to write in to RAM array----------------------
-------------------------------------------------------------------------------------
  p_WrRam: PROCESS(clk)
  BEGIN
    IF rising_edge(clk) THEN 
      IF (we_a = '1') THEN
	    IF (conv_integer(addr_a) <= (BUFF_DEPTH-1)) THEN
          ram (conv_integer(addr_a)) <= data_a;
		ELSE
		  null;
		END IF;
      END IF;
    END IF;
  END PROCESS p_WrRam;
 
-------------------------------------------------------------------------------------
-------------------------------Process to Read from RAM array------------------------
-------------------------------------------------------------------------------------
  p_RdRam: PROCESS(clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF (we_b = '0') THEN
        NULL; 
      ELSE
	    IF (conv_integer(addr_b) <= (BUFF_DEPTH-1)) THEN
          q_b_reg <= ram (conv_integer(addr_b));
		ELSE
		  q_b_reg <= (OTHERS => '0'); 
        END IF;
      END IF;
    END IF;
  END PROCESS p_RdRam;

END ramDualPort; 