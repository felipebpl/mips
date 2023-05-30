library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  --Soma (esta biblioteca =ieee)

entity decoderFunct is
  port ( funct : in std_logic_vector(5 downto 0);
         saida : out std_logic_vector(2 downto 0)
  );
end entity;

architecture comportamento of decoderFunct is

  
  constant funct_AND : std_logic_vector(5 downto 0) := "100100";
  constant funct_OR  : std_logic_vector(5 downto 0) := "100101";
  constant funct_SOMA  : std_logic_vector(5 downto 0) := "100000";
  constant funct_SUB   : std_logic_vector(5 downto 0) := "100010";
  constant funct_SLT   : std_logic_vector(5 downto 0) := "101010";
  

  begin
saida <= "000" when funct = funct_AND else
         "001" when funct = funct_OR else
         "010" when funct = funct_SOMA else
			"110" when funct = funct_SUB else
			"111" when funct = funct_SLT else
         "000";  -- NOP para os entradas Indefinidas
end architecture;