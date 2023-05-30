library ieee;
use ieee.std_logic_1164.all;

entity ucULA is

	port (
		opcode : in std_logic_vector (5 downto 0);
		funct : in std_logic_vector (5 downto 0);
		tipo_r : in std_logic;
		saida : out std_logic_vector (2 downto 0)
	);
end entity;

architecture comportamento of ucULA is
	signal opOut : std_logic_vector (2 downto 0);
	signal functOut : std_logic_vector (2 downto 0);

begin
	DECODER_OPCODE :	entity work.decoderOpcode
		port map (opcode => opcode, saida => opOut);

	DECODER_FUNCT  :	entity work.decoderFunct
		port map (funct => funct, saida => functOut);

	MUX : entity work.muxGenerico2x1  generic map (larguraDados => 3)
		port map (entradaA_MUX => opOut, entradaB_MUX => functOut, seletor_MUX => tipo_r,
						saida_MUX => saida);

end architecture;