library ieee;
use ieee.std_logic_1164.all;

entity decoderInstru is
  port ( opcode : in std_logic_vector(5 downto 0);
			funct : in std_logic_vector(5 downto 0);
         saida : out std_logic_vector(8 downto 0)
  );
end entity;

architecture comportamento of decoderInstru is

	constant tipo_R  : std_logic_vector(5 downto 0) := "000000";
	constant ADD  : std_logic_vector(5 downto 0) := "100000";
	constant SUB  : std_logic_vector(5 downto 0) := "100010";
	constant BEQ : std_logic_vector := "000100";
	constant LW : std_logic_vector(5 downto 0) := "100011";
	constant SW : std_logic_vector(5 downto 0) := "101011";
	constant tipo_J : std_logic_vector(5 downto 0) := "000010";
	
	alias habwr : std_logic is saida(0);
	alias habrd : std_logic is saida(1);
	alias habDesvio : std_logic is saida(2);
	alias muxULA : std_logic is saida(3);
	alias tipoR : std_logic is saida(4);
	alias muxRtIm : std_logic is saida(5);
	alias WrRegd : std_logic is saida(6);  
	alias muxRtRd : std_logic is saida(7);
	alias muxBEQJMP : std_logic is saida(8);

	
  begin
  
habwr <= '1' when (opcode = SW) else
						'0';
						
habrd <= '1' when (opcode = LW) else
						'0';
					
habDesvio <= '1' when (opcode = BEQ) else
		'0';
  
muxULA <= '1' when (opcode = LW) else
				'0';
				
tipoR <= '1' when (opcode = tipo_R) else
			'0';
			
muxRtIm <= '0' when (opcode = tipo_R) or (opcode = BEQ) else
				'1';
			
WrRegd <= '1' when (opcode = tipo_R) or (opcode = LW) else
						'0'; 

muxRtRd <= '1' when (opcode = tipo_R) else
				'0';
			
muxBEQJMP <= '1' when (opcode = tipo_J) else '0';
end architecture;