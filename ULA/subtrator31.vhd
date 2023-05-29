library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- Biblioteca IEEE para funções aritméticas

entity subtrator31 is
    port
    (
        entradaA, entradaB, slt, carryIn, invB: in STD_LOGIC;
		  sel: in std_logic_vector(1 downto 0);
		  resultado, carryOut, overflow, soma_out: out std_logic
		  
    );
end entity;

architecture comportamento of subtrator31 is
	signal saidaMuxB: std_logic;
	signal saidaSomador: std_logic;
	
begin

muxB: entity work.mux1bit generic map (larguraDados => 1)
        port map( entradaA_MUX => entradaB,
                 entradaB_MUX =>  not (entradaB),
                 seletor_MUX => invB,
                 saida_MUX => saidaMuxB);

somador: entity work.somadorCompleto
        port map( entradaA => entradaA,
                 entradaB =>  saidaMuxB,
					  vemUm => carryIn,
                 saida => saidaSomador,
                 vaiUm => carryOut);
					  
					  
muxResultado :  entity work.mux1bit4x1
        port map( entradaA_MUX => saidaMuxB and entradaA,
                 entradaB_MUX =>  saidaMuxB or entradaA,
					  entradaC_MUX => saidaSomador,
					  entradaD_MUX => slt,
                 seletor_MUX => sel,
                 saida_MUX => resultado);
					  
					  

overflow <= carryIn xor carryOut;
soma_out <= saidaSomador;

end architecture;