library ieee;
use ieee.std_logic_1164.all;

entity decoderInstru is
  port ( opcode : in std_logic_vector(5 downto 0);
			funct : in std_logic_vector(5 downto 0); 
         saida : out std_logic_vector(15 downto 0)
  );
end entity;

architecture comportamento of decoderInstru is

  constant tipo_R : std_logic_vector(5 downto 0) := "000000";
  constant LW  : std_logic_vector(5 downto 0) := "100011";
  constant SW  : std_logic_vector(5 downto 0) := "101011";
  constant BEQ : std_logic_vector(5 downto 0) := "000100";
  constant JMP : std_logic_vector(5 downto 0) := "000010";
  constant LUI : std_logic_vector(5 downto 0) := "001111";
  constant ADDI : std_logic_vector(5 downto 0) := "001000";
  constant ANDI : std_logic_vector(5 downto 0) := "001100";
  constant ORI : std_logic_vector(5 downto 0) := "001101";
  constant SLTI : std_logic_vector(5 downto 0) := "001010";
  constant BNE : std_logic_vector(5 downto 0) := "000101";
  constant JAL : std_logic_vector(5 downto 0) := "000011";
  constant JR: std_logic_vector(5 downto 0) := "001000"; 
  constant OP_SLL: std_logic_vector(5 downto 0) := "000000";
  constant OP_SLR: std_logic_vector(5 downto 0) := "000010";
  

  begin

saida <= "0000010101000000" when (opcode = tipo_R ) AND NOT (funct=JR) else
			"0000000110010010" when (opcode = LW) else
			"0000000010000001" when (opcode = SW) else
			"0000000000001000" when (opcode = BEQ) else
			"0001000000000000" when (opcode = JMP) else
			"0000000100110000" when (opcode = LUI) else
			"0000000110000000" when (opcode = ADDI) else
			"0000001110000000" when (opcode = ANDI) else
			"0000001110000000" when (opcode = ORI) else
			"0000000110000000" when (opcode = SLTI) else
			"0000000000000100" when (opcode = BNE) else
			"0001100100100000" when (opcode = JAL) else
			"1000010101000000" when (opcode = tipo_R AND funct = OP_SLL) else
			"0100010101000000" when (opcode = tipo_R AND funct = OP_SLR) else
			"0010010001000000" when (opcode = tipo_R AND funct = JR) else
			"0000000000000000";
end architecture;