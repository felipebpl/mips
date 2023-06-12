library ieee;
use ieee.std_logic_1164.all;

entity estendeSinalLUI is
    generic
    (
        larguraDadoEntrada : natural  :=    16;
        larguraDadoSaida   : natural  :=    32
    );
    port
    (
        -- Input ports
        estendeSinalLUI_IN : in  std_logic_vector(larguraDadoEntrada-1 downto 0);
        -- Output ports
        estendeSinalLUI_OUT: out std_logic_vector(larguraDadoSaida-1 downto 0)
    );
end entity;

architecture comportamento of estendeSinalLUI is
begin

    estendeSinalLUI_OUT <= (larguraDadoSaida-1 downto larguraDadoEntrada => estendeSinalLUI_IN(larguraDadoEntrada-1) )
	 & "0000000000000000";

end architecture;