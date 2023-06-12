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
  constant ADDI : std_logic_vector(5 downto 0) := "001000";
  constant ANDI : std_logic_vector(5 downto 0) := "001100";
  constant ORI: std_logic_vector(5 downto 0) := "001101";
  constant SLTI : std_logic_vector(5 downto 0) := "001010";
  constant BNE : std_logic_vector(5 downto 0) := "000101";
  

  begin
saida <= "001" when opcode = ORI else
			"010" when (opcode = ADDI) or (opcode = SW) or (opcode = LW) else
         "110" when (opcode = BEQ) or (opcode = BNE) else
			"111" when opcode = SLTI else
         "000";  -- NOP 
end architecture;