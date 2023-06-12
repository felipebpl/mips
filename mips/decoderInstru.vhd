library ieee;
use ieee.std_logic_1164.all;

entity decoderInstru is
  port ( opcode : in std_logic_vector(5 downto 0);
			funct : in std_logic_vector(5 downto 0);
         saida : out std_logic_vector(13 downto 0)
  );
end entity;

architecture comportamento of decoderInstru is

	constant tipo_R  : std_logic_vector(5 downto 0) := "000000";
	constant BEQ : std_logic_vector(5 downto 0) := "000100";
	constant LW : std_logic_vector(5 downto 0) := "100011";
	constant SW : std_logic_vector(5 downto 0) := "101011";
	constant JUMP : std_logic_vector(5 downto 0) := "000010";
	constant ADDI : std_logic_vector(5 downto 0) := "001000";
	constant ANDI : std_logic_vector(5 downto 0) := "001100";
	constant ORI: std_logic_vector(5 downto 0) := "001101";
	constant SLTI : std_logic_vector(5 downto 0) := "001010";
	constant LUI : std_logic_vector(5 downto 0) := "001111";
	constant JAL : std_logic_vector(5 downto 0) := "000011";
	constant JR : std_logic_vector(5 downto 0) := "001000";
	constant BNE : std_logic_vector(5 downto 0) := "000101";
	
	alias habwr : std_logic is saida(0);
	alias habrd : std_logic is saida(1);
	alias habBNE : std_logic is saida(2);
	alias habBEQ : std_logic is saida(3);
	alias muxULA : std_logic_vector(1 downto 0) is saida(5 downto 4);
	alias tipoR : std_logic is saida(6);
	alias muxRtIm : std_logic is saida(7);
	alias WrRegd : std_logic is saida(8);  
	alias ORIANDI : std_logic is saida(9);
	alias muxRtRd : std_logic_vector(1 downto 0) is saida(11 downto 10);
	alias muxBEQJMP : std_logic is saida(12);
	alias muxJR : std_logic is saida(13);
	
  begin
  
habwr <= '1' when (opcode = SW) else
						'0';
						
habrd <= '1' when (opcode = LW) else
						'0';
							
habBEQ <= '1' when opcode = BEQ else
		'0';
		
habBNE <= '1' when opcode = BNE else
		'0';
  
muxULA <= "11" when (opcode = LUI) else
				"10" when (opcode = JAL) else
				"01" when (opcode = LW) else
				"00";
				
tipoR <= '1' when (opcode = tipo_R) else
			'0';
			
muxRtIm <= '0' when (opcode = tipo_R) or (opcode = BEQ) or (opcode = BNE) else
				'1';
			
WrRegd <= '1' when (opcode = tipo_R and funct = not(JR)) or (opcode = LW) or (opcode = ADDI) or (opcode = ANDI) or (opcode = ORI) or (opcode = SLTI) or (opcode = JAL) else
						'0'; 
						
ORIANDI <= '1' when (opcode = ANDI) or (opcode = ORI) else
				'0';
						
muxRtRd <= "01" when (opcode = tipo_R) else
				"10" when (opcode = JAL) else
				"00";
			
muxBEQJMP <= '1' when (opcode = JUMP) or (opcode = JAL) else '0';

muxJR <= '1' when (opcode = tipo_R) and (funct = JR) else '0';
end architecture;