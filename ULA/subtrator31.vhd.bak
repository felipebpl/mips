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
	signal inverte_B: std_logic;
	signal saida_muxB: std_logic;
	signal saida_soma: std_logic;
	
	signal saida_carry_out: std_logic;
	signal saida_carry_in: std_logic;
	
	
begin

muxB: entity work.mux1bit generic map (larguraDados => 1)
        port map( entradaA_MUX => entradaB,
                 entradaB_MUX =>  inverte_B,
                 seletor_MUX => invB,
                 saida_MUX => saida_muxB);

somador: entity work.somadorCompleto
        port map( entradaA => entradaA,
                 entradaB =>  saida_muxB,
					  vemUm => carryIn,
                 saida => soma_out,
                 vaiUm => carryOut);
					  
					  
muxResultado :  entity work.mux1bit4x1
        port map( entradaA_MUX => saida_muxB and entradaA,
                 entradaB_MUX =>  saida_muxB or entradaA,
					  entradaC_MUX => saida_soma,
					  entradaD_MUX => slt,
                 seletor_MUX => sel,
                 saida_MUX => resultado);
					  
					  
					  
inverte_B <= not entradaB;

saida_carry_out <= carryOut;
saida_carry_in <= carryIn;

overflow <= saida_carry_out xor saida_carry_in;
saida_soma <= soma_out;

end architecture;