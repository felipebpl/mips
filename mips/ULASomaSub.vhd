library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULASomaSub is
    generic ( larguraDados : natural := 32 );
    port (
      entradaA, entradaB:  in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      seletor:  in STD_LOGIC_VECTOR(2 downto 0);
      saida:    out STD_LOGIC_VECTOR((larguraDados-1) downto 0);
		saida_Z: out std_logic
    );
end entity;

architecture comportamento of ULASomaSub is
   signal soma :      STD_LOGIC_VECTOR((larguraDados-1) downto 0);
   signal subtracao : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
   signal passa : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
	signal dados : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
    begin
      soma      <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
      subtracao <= STD_LOGIC_VECTOR(unsigned(entradaA) - unsigned(entradaB));
		passa <= entradaB;
      dados <= soma when (seletor = "0001") else
					subtracao when (seletor = "0000") else passa;
		saida_Z <= NOT(dados(0) or dados(1) or dados(2) or dados(3) or dados(4) or dados(5) or dados(6) or dados(7) or dados(8) or dados(9) or dados(10) or dados(11) or dados(12) or dados(13) or dados(14) or dados(15) or dados(16) or dados(17) or dados(18) or dados(19) or dados(20) or dados(21) or dados(22) or dados(23) or dados(24) or dados(25) or dados(26) or dados(27) or dados(28) or dados(29) or dados(30) or dados(31));
		saida <= dados;

end architecture;