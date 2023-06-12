library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shifter is
    generic(
        larguraDados : natural  :=    32
    );
    port(
		  Entrada : in std_logic_vector((larguraDados - 1) DOWNTO 0);
		  Shamt	 : in std_logic_vector(4 DOWNTO 0);
		  SIG_SLL : in std_logic;
		  SIG_SRL : in std_logic;
		  Saida 	 : out std_logic_vector((larguraDados - 1) DOWNTO 0)
    );
end entity;

architecture comportamento of Shifter is
	
	signal leftShift : std_logic_vector((larguraDados - 1) DOWNTO 0);
	signal rightShift : std_logic_vector((larguraDados - 1) DOWNTO 0);

begin

	
	leftShift <= std_logic_vector(unsigned(Entrada) sll to_integer(unsigned(Shamt)));
	rightShift <= std_logic_vector(unsigned(Entrada) srl to_integer(unsigned(Shamt)));
	
	Saida <= leftShift when SIG_SLL = '1' else rightShift when SIG_SRL = '1' else x"00000000";

end architecture;