library ieee;
use ieee.std_logic_1164.all;

entity decoderOpcode is
  port ( opcode : in std_logic_vector(5 downto 0);
         saida : out std_logic_vector(2 downto 0)
  );
end entity;

architecture comportamento of decoderOpcode is

  constant SW  : std_logic_vector(5 downto 0) := "101011";
  constant LW  : std_logic_vector(5 downto 0) := "100011";
  constant BEQ : std_logic_vector(5 downto 0) := "000100";
  

  begin
saida <= "010" when opcode = SW else
         "010" when opcode = LW else
         "110" when opcode = BEQ else
         "000";  -- NOP para os entradas Indefinidas
end architecture;