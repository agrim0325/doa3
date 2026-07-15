--=================================================================================================
-- File Name                           : Image_Enhancement.vhd

-- Description                         : This module allows user control of Brightness, Contrast,
--                                       and color balance on incoming pixel data.

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
USE IEEE.STD_LOGIC_SIGNED.ALL;

--=================================================================================================
-- Image_Enhancement entity declaration
--=================================================================================================
ENTITY Image_Enhancement IS
GENERIC(
-- Generic List
                -- Specifies the bit width of each pixel
    G_PIXEL_WIDTH               : INTEGER := 8
);
PORT(
-- Port list
    -- System reset
    RESETN_I                             : IN STD_LOGIC;
                                                                                                                                                  
    -- System clock                      
    SYS_CLK_I                                           : IN STD_LOGIC;
                                                                                                                                                  
    --Data valid                                     
    DATA_VALID_I                                                                                                 : IN STD_LOGIC;
    
    --Enable input
    ENABLE_I                                                                                                                : IN STD_LOGIC;
 
    -- Channel 1 data
    DATA_I                                          : IN STD_LOGIC_VECTOR(3*G_PIXEL_WIDTH-1 DOWNTO 0);
 
    RAM_ADDR_I                          : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    
 
    --R-constant input
    R_CONST_I                                                                                                                : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    
    --G-constant input
    G_CONST_I                                                                                                                : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    
    --B-constant input
    B_CONST_I                                                                                                                : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    
    --Second constant input
    COMMON_CONST_I                                                                                                : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    
    --Output valid
    DATA_VALID_O                                                                                                : OUT STD_LOGIC;                
    
    --RAM Address Output
    RAM_ADDR_O                          : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);                                
 
    -- Alpha blended output
    DATA_O                                                                                                                                : OUT STD_LOGIC_VECTOR(3*G_PIXEL_WIDTH-1 DOWNTO 0)
   
);
END Image_Enhancement;

--=================================================================================================
-- Image_Enhancement architecture body
--=================================================================================================

ARCHITECTURE Image_Enhancement OF Image_Enhancement IS

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
                                
SIGNAL s_dvalid             : STD_LOGIC;
SIGNAL s_dvalid2            : STD_LOGIC;
SIGNAL s_ram_addr           : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s_ram_addr_dly       : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s_r_const            : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL s_g_const            : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL s_b_const            : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL s_term1_r            : STD_LOGIC_VECTOR(43 DOWNTO 0);
SIGNAL s_term1_g            : STD_LOGIC_VECTOR(43 DOWNTO 0);
SIGNAL s_term1_b            : STD_LOGIC_VECTOR(43 DOWNTO 0);

SIGNAL s_data_r             : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL s_data_g             : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL s_data_b             : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL s_rout               : STD_LOGIC_VECTOR(G_PIXEL_WIDTH-1 DOWNTO 0);
SIGNAL s_gout               : STD_LOGIC_VECTOR(G_PIXEL_WIDTH-1 DOWNTO 0);
SIGNAL s_bout               : STD_LOGIC_VECTOR(G_PIXEL_WIDTH-1 DOWNTO 0);
SIGNAL s_common_const       : STD_LOGIC_VECTOR(43 DOWNTO 0);
                



BEGIN

--=================================================================================================
-- Top level output port assignments
--=================================================================================================
DATA_VALID_O                                    <= s_dvalid2;
DATA_O                                          <= s_rout(6) & s_rout(7) & s_rout(5 DOWNTO 0)& s_gout(7 DOWNTO 5)&s_gout(3) & s_gout(4)&s_gout(2 DOWNTO 0)  & s_bout;
RAM_ADDR_O                                      <= s_ram_addr_dly;
--=================================================================================================
-- Generate blocks
--=================================================================================================


--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
s_r_const                                       <= x"00" & R_CONST_I;

s_g_const                                       <= x"00" & G_CONST_I;

s_b_const                                       <= x"00" & B_CONST_I;


s_data_r(G_PIXEL_WIDTH-1 DOWNTO 0)              <= DATA_I(3*G_PIXEL_WIDTH-1 DOWNTO 2*G_PIXEL_WIDTH);
s_data_r(17 DOWNTO G_PIXEL_WIDTH)               <= (OTHERS => '0');

s_data_g(G_PIXEL_WIDTH-1 DOWNTO 0)              <= DATA_I(2*G_PIXEL_WIDTH-1 DOWNTO G_PIXEL_WIDTH);
s_data_g(17 DOWNTO G_PIXEL_WIDTH)               <= (OTHERS => '0');

s_data_b(G_PIXEL_WIDTH-1 DOWNTO 0)              <= DATA_I(G_PIXEL_WIDTH-1 DOWNTO 0);
s_data_b(17 DOWNTO G_PIXEL_WIDTH)                                                      <= (OTHERS => '0');

s_common_const(43 DOWNTO 20)                    <= (OTHERS => COMMON_CONST_I(19));
s_common_const(19 DOWNTO 0)                     <= COMMON_CONST_I;

--=================================================================================================
-- Synchronous blocks
--=================================================================================================
                
--------------------------------------------------------------------------
-- Name       : DELAY
-- Description: Process delays input signals
--------------------------------------------------------------------------
DELAY:
    PROCESS(SYS_CLK_I,RESETN_I)
     BEGIN
        IF RESETN_I = '0' THEN
            s_dvalid        <= '0';
            s_dvalid2       <= '0';
            s_ram_addr      <= (OTHERS => '0');
            s_ram_addr_dly  <= (OTHERS => '0');
        ELSIF rising_edge(SYS_CLK_I) THEN
            s_dvalid        <= DATA_VALID_I;
            s_dvalid2       <= s_dvalid;
            s_ram_addr      <= RAM_ADDR_I;
            s_ram_addr_dly  <= s_ram_addr;
        END IF;
    END PROCESS;

--------------------------------------------------------------------------
-- Name       : H_COUNTER
-- Description: Counter to count horizontal pixels
--------------------------------------------------------------------------
H_COUNTER:
                PROCESS(SYS_CLK_I,RESETN_I)
                BEGIN
                    IF RESETN_I = '0' THEN
                            s_term1_r                <= (OTHERS => '0');
                            s_term1_g                <= (OTHERS => '0');
                            s_term1_b                <= (OTHERS => '0');
                            s_rout                   <= (OTHERS => '0');
                            s_gout                   <= (OTHERS => '0');
                            s_bout                   <= (OTHERS => '0');
                    ELSIF rising_edge(SYS_CLK_I) THEN
                        IF(ENABLE_I = '1')THEN
                            IF(DATA_VALID_I = '1')THEN
                                            s_term1_r                <= s_common_const + s_r_const * s_data_r;
                                            s_term1_g                <= s_common_const + s_g_const * s_data_g;
                                            s_term1_b                <= s_common_const + s_b_const * s_data_b;
                            END IF;
                            IF(s_dvalid = '1')THEN
                                   IF(s_term1_r(G_PIXEL_WIDTH+10 DOWNTO G_PIXEL_WIDTH+7) = x"0")THEN
											s_rout                  <= (s_term1_r(G_PIXEL_WIDTH+6 DOWNTO 7));
					               ELSIF(s_term1_r(43) = '1')THEN
                                            s_rout      <= (OTHERS => '0');
                                   ELSE
                                            s_rout      <= (OTHERS => '1');
                                   END IF;
                                   IF(s_term1_g(G_PIXEL_WIDTH+10 DOWNTO G_PIXEL_WIDTH+7) = x"0")THEN
                                       s_gout                    <= (s_term1_g(G_PIXEL_WIDTH+6 DOWNTO 7));
                                   ELSIF(s_term1_g(43) = '1')THEN
                                       s_gout      <= (OTHERS => '0');
                                   ELSE
                                       s_gout      <= (OTHERS => '1');
                                   END IF;
                                   IF(s_term1_b(G_PIXEL_WIDTH+10 DOWNTO G_PIXEL_WIDTH+7) = x"0")THEN
                                       s_bout                    <= (s_term1_b(G_PIXEL_WIDTH+6 DOWNTO 7));
                                   ELSIF(s_term1_b(43) = '1')THEN
                                       s_bout      <= (OTHERS => '0');
                                   ELSE
                                       s_bout      <= (OTHERS => '1');
                                   END IF;
                            END IF;
                        END IF;
                    END IF;
                END PROCESS; 
                

--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE Image_Enhancement;