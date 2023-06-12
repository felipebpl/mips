library ieee;
use ieee.std_logic_1164.all;

entity estendeSinalGenerico is
    generic
    (
        larguraDadoEntrada : natural  :=    16;
        larguraDadoSaida   : natural  :=    32
    );
    port
    (
        -- Input ports
        estendeSinal_IN : in  std_logic_vector(larguraDadoEntrada-1 downto 0);
		  ORIANDI : in std_logic;
        -- Output ports
        estendeSinal_OUT: out std_logic_vector(larguraDadoSaida-1 downto 0)
    );
end entity;

architecture comportamento of estendeSinalGenerico is
begin

    estendeSinal_OUT <= (larguraDadoSaida-1 downto larguraDadoEntrada => estendeSinal_IN(larguraDadoEntrada-1) ) & estendeSinal_IN 
	 when ORIANDI = '0' else 
	 "0000000000000000" & estendeSinal_IN;

end architecture;