library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- Biblioteca IEEE para funções aritméticas

entity somadorCompleto is
    port
    (
        entradaA, entradaB, vemUm: in STD_LOGIC;
        saida, vaiUm:  out STD_LOGIC
    );
end entity;

architecture comportamento of somadorCompleto is
    begin
        saida <= vemUm xor (entradaA xor entradaB);
		  vaiUm <= (entradaA and entradaB) or (vemUm and (entradaA xor entradaB)); 
end architecture;
