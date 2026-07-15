--
-- Synopsys
-- Vhdl wrapper for top level design, written on Wed Jul 15 07:20:42 2026
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wrapper_for_double_flop is
   port (
      RESETN_I : in std_logic;
      SYS_CLK_I : in std_logic;
      PCLK_I : in std_logic;
      DATA_I : in std_logic_vector(7 downto 0);
      HREF_I : in std_logic;
      PCLK_O : out std_logic;
      DATA_O : out std_logic_vector(7 downto 0);
      HREF_O : out std_logic
   );
end wrapper_for_double_flop;

architecture double_flop of wrapper_for_double_flop is

component double_flop
 port (
   RESETN_I : in std_logic;
   SYS_CLK_I : in std_logic;
   PCLK_I : in std_logic;
   DATA_I : in std_logic_vector (7 downto 0);
   HREF_I : in std_logic;
   PCLK_O : out std_logic;
   DATA_O : out std_logic_vector (7 downto 0);
   HREF_O : out std_logic
 );
end component;

signal tmp_RESETN_I : std_logic;
signal tmp_SYS_CLK_I : std_logic;
signal tmp_PCLK_I : std_logic;
signal tmp_DATA_I : std_logic_vector (7 downto 0);
signal tmp_HREF_I : std_logic;
signal tmp_PCLK_O : std_logic;
signal tmp_DATA_O : std_logic_vector (7 downto 0);
signal tmp_HREF_O : std_logic;

begin

tmp_RESETN_I <= RESETN_I;

tmp_SYS_CLK_I <= SYS_CLK_I;

tmp_PCLK_I <= PCLK_I;

tmp_DATA_I <= DATA_I;

tmp_HREF_I <= HREF_I;

PCLK_O <= tmp_PCLK_O;

DATA_O <= tmp_DATA_O;

HREF_O <= tmp_HREF_O;



u1:   double_flop port map (
		RESETN_I => tmp_RESETN_I,
		SYS_CLK_I => tmp_SYS_CLK_I,
		PCLK_I => tmp_PCLK_I,
		DATA_I => tmp_DATA_I,
		HREF_I => tmp_HREF_I,
		PCLK_O => tmp_PCLK_O,
		DATA_O => tmp_DATA_O,
		HREF_O => tmp_HREF_O
       );
end double_flop;
