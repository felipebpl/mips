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
        saida <= (entradaA xor entradaB) xor vemUm;
		  vaiUm <= (entradaA and entradaB) or ((entradaA xor entradaB) and vemUm); 
end architecture;