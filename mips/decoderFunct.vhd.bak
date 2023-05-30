library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  --Soma (esta biblioteca =ieee)

entity decoderFunct is
  port ( funct : in std_logic_vector(5 downto 0);
         saida : out std_logic_vector(2 downto 0)
  );
end entity;

architecture comportamento of decoderFunct is

  
  --FUNCTS
  constant ANDD : std_logic_vector(5 downto 0) := "100100";
  constant ORR  : std_logic_vector(5 downto 0) := "100101";
  constant SOMA  : std_logic_vector(5 downto 0) := "100000";
  constant SUB   : std_logic_vector(5 downto 0) := "100010";
  constant SLT   : std_logic_vector(5 downto 0) := "101010";
  

  begin
saida <= "000" when funct = ANDD else
         "001" when funct = ORR else
         "010" when funct = SOMA else
			"110" when funct = SUB else
			"111" when funct = SLT else
         "000";  -- NOP para os entradas Indefinidas
end architecture;