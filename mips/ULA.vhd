library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity ULA is
	
	generic ( 
			larguraDados : natural := 32
			);
	
	port (
		entradaA, entradaB  : in std_logic_vector (larguraDados-1 downto 0);
		sel : in std_logic_vector (1 downto 0);
		invB : in std_logic;
		resultado : out std_logic_vector (larguraDados-1 downto 0);
		flagZero: out std_logic
	);
end entity;

architecture arquitetura of ULA is

	signal carryOut0 : std_logic;
	signal carryOut1 : std_logic;
	signal carryOut2 : std_logic;
	signal carryOut3 : std_logic;
	signal carryOut4 : std_logic;
	signal carryOut5 : std_logic;
	signal carryOut6 : std_logic;
	signal carryOut7 : std_logic;
	signal carryOut8 : std_logic;
	signal carryOut9 : std_logic;
	signal carryOut10 : std_logic;
	signal carryOut11 : std_logic;
	signal carryOut12 : std_logic;
	signal carryOut13 : std_logic;
	signal carryOut14 : std_logic;
	signal carryOut15 : std_logic;
	signal carryOut16 : std_logic;
	signal carryOut17 : std_logic;
	signal carryOut18 : std_logic;
	signal carryOut19 : std_logic;
	signal carryOut20 : std_logic;
	signal carryOut21 : std_logic;
	signal carryOut22 : std_logic;
	signal carryOut23 : std_logic;
	signal carryOut24 : std_logic;
	signal carryOut25 : std_logic;
	signal carryOut26 : std_logic;
	signal carryOut27 : std_logic;
	signal carryOut28 : std_logic;
	signal carryOut29 : std_logic;
	signal carryOut30 : std_logic;
	signal carryOut31 : std_logic;
	
	signal overflow : std_logic;
	signal saidaSomador: std_logic;
	
begin
	BIT0 : entity work.subtrator
		port map (entradaA => entradaA(0), entradaB => entradaB(0), sel => sel,
				invB => invB, carryIn => invB, 
				slt => overflow xor saidaSomador, carryOut => carryOut0, resultado => resultado(0));

	BIT1 : entity work.subtrator
		port map (entradaA => entradaA(1), entradaB => entradaB(1), sel => sel,
				invB => invB, carryIn => carryOut0, 
				slt => '0', carryOut => carryOut1, resultado => resultado(1));
				
				
	BIT2 : entity work.subtrator
		port map (entradaA => entradaA(2), entradaB => entradaB(2), sel => sel,
				invB => invB, carryIn => carryOut1, 
				slt => '0', carryOut => carryOut2, resultado => resultado(2));
				
				
				
	BIT3 : entity work.subtrator
		port map (entradaA => entradaA(3), entradaB => entradaB(3), sel => sel,
				invB => invB, carryIn => carryOut2, 
				slt => '0', carryOut => carryOut3, resultado => resultado(3));
				
							
	BIT4 : entity work.subtrator
		port map (entradaA => entradaA(4), entradaB => entradaB(4), sel => sel,
				invB => invB, carryIn => carryOut3, 
				slt => '0', carryOut => carryOut4, resultado => resultado(4));
				
				
					
	BIT5 : entity work.subtrator
		port map (entradaA => entradaA(5), entradaB => entradaB(5), sel => sel,
				invB => invB, carryIn => carryOut4, 
				slt => '0', carryOut => carryOut5, resultado => resultado(5));
				
				
				
				

	BIT6 : entity work.subtrator
		port map (entradaA => entradaA(6), entradaB => entradaB(6), sel => sel,
				invB => invB, carryIn => carryOut5, 
				slt => '0', carryOut => carryOut6, resultado => resultado(6));

	BIT7 : entity work.subtrator
		port map (entradaA => entradaA(7), entradaB => entradaB(7), sel => sel,
				invB => invB, carryIn => carryOut6, 
				slt => '0', carryOut => carryOut7, resultado => resultado(7));
				
				
				
				
				
				
	BIT8 : entity work.subtrator
		port map (entradaA => entradaA(8), entradaB => entradaB(8), sel => sel,
				invB => invB, carryIn => carryOut7, 
				slt => '0', carryOut => carryOut8, resultado => resultado(8));
			
			
			
			

	BIT9 : entity work.subtrator
		port map (entradaA => entradaA(9), entradaB => entradaB(9), sel => sel,
				invB => invB, carryIn => carryOut8, 
				slt => '0', carryOut => carryOut9, resultado => resultado(9));
			
			
			
			
			
			
			

	BIT10 : entity work.subtrator
		port map (entradaA => entradaA(10), entradaB => entradaB(10), sel => sel,
				invB => invB, carryIn => carryOut9, 
				slt => '0', carryOut => carryOut10, resultado => resultado(10));
			
			
		

	BIT11 : entity work.subtrator
		port map (entradaA => entradaA(11), entradaB => entradaB(11), sel => sel,
				invB => invB, carryIn => carryOut10, 
				slt => '0', carryOut => carryOut11, resultado => resultado(11));
			
			
			

	BIT12 : entity work.subtrator
		port map (entradaA => entradaA(12), entradaB => entradaB(12), sel => sel,
				invB => invB, carryIn => carryOut11, 
				slt => '0', carryOut => carryOut12, resultado => resultado(12));
			
			
			
			
			

	BIT13 : entity work.subtrator
		port map (entradaA => entradaA(13), entradaB => entradaB(13), sel => sel,
				invB => invB, carryIn => carryOut12, 
				slt => '0', carryOut => carryOut13, resultado => resultado(13));
			
			
	BIT14 : entity work.subtrator
		port map (entradaA => entradaA(14), entradaB => entradaB(14), sel => sel,
				invB => invB, carryIn => carryOut13, 
				slt => '0', carryOut => carryOut14, resultado => resultado(14));

		
			
			
	BIT15 : entity work.subtrator
		port map (entradaA => entradaA(15), entradaB => entradaB(15), sel => sel,
				invB => invB, carryIn => carryOut14, 
				slt => '0', carryOut => carryOut15, resultado => resultado(15));

			
			
			
			
	BIT16 : entity work.subtrator
		port map (entradaA => entradaA(16), entradaB => entradaB(16), sel => sel,
				invB => invB, carryIn => carryOut15, 
				slt => '0', carryOut => carryOut16, resultado => resultado(16));

			
			
			
			
			
	BIT17 : entity work.subtrator
		port map (entradaA => entradaA(17), entradaB => entradaB(17), sel => sel,
				invB => invB, carryIn => carryOut16, 
				slt => '0', carryOut => carryOut17, resultado => resultado(17));

			
			
			
			
			
	BIT18 : entity work.subtrator
		port map (entradaA => entradaA(18), entradaB => entradaB(18), sel => sel,
				invB => invB, carryIn => carryOut17, 
				slt => '0', carryOut => carryOut18, resultado => resultado(18));

			
			
			
			
	BIT19 : entity work.subtrator
		port map (entradaA => entradaA(19), entradaB => entradaB(19), sel => sel,
				invB => invB, carryIn => carryOut18, 
				slt => '0', carryOut => carryOut19, resultado => resultado(19));

			
			
			
			
			
	BIT20 : entity work.subtrator
		port map (entradaA => entradaA(20), entradaB => entradaB(20), sel => sel,
				invB => invB, carryIn => carryOut19, 
				slt => '0', carryOut => carryOut20, resultado => resultado(20));

			
			
			
			
			
	BIT21 : entity work.subtrator
		port map (entradaA => entradaA(21), entradaB => entradaB(21), sel => sel,
				invB => invB, carryIn => carryOut20, 
				slt => '0', carryOut => carryOut21, resultado => resultado(21));

			
			
			
			
	BIT22 : entity work.subtrator
		port map (entradaA => entradaA(22), entradaB => entradaB(22), sel => sel,
				invB => invB, carryIn => carryOut21, 
				slt => '0', carryOut => carryOut22, resultado => resultado(22));
			
			
			
			
			
			

	BIT23 : entity work.subtrator
		port map (entradaA => entradaA(23), entradaB => entradaB(23), sel => sel,
				invB => invB, carryIn => carryOut22, 
				slt => '0', carryOut => carryOut23, resultado => resultado(23));
			
			
			
			
			
			

	BIT24 : entity work.subtrator
		port map (entradaA => entradaA(24), entradaB => entradaB(24), sel => sel,
				invB => invB, carryIn => carryOut23, 
				slt => '0', carryOut => carryOut24, resultado => resultado(24));
			
			
			
			
			

	BIT25 : entity work.subtrator
		port map (entradaA => entradaA(25), entradaB => entradaB(25), sel => sel,
				invB => invB, carryIn => carryOut24, 
				slt => '0', carryOut => carryOut25, resultado => resultado(25));
			
			
			
			
			
			
			

	BIT26 : entity work.subtrator
		port map (entradaA => entradaA(26), entradaB => entradaB(26), sel => sel,
				invB => invB, carryIn => carryOut25, 
				slt => '0', carryOut => carryOut26, resultado => resultado(26));
			
			
			
			
			
			
			

	BIT27 : entity work.subtrator
		port map (entradaA => entradaA(27), entradaB => entradaB(27), sel => sel,
				invB => invB, carryIn => carryOut26, 
				slt => '0', carryOut => carryOut27, resultado => resultado(27));
			
			
			
			
			
			

	BIT28 : entity work.subtrator
		port map (entradaA => entradaA(28), entradaB => entradaB(28), sel => sel,
				invB => invB, carryIn => carryOut27, 
				slt => '0', carryOut => carryOut28, resultado => resultado(28));
			
			
			
			
			
			

	BIT29 : entity work.subtrator
		port map (entradaA => entradaA(29), entradaB => entradaB(29), sel => sel,
				invB => invB, carryIn => carryOut28, 
				slt => '0', carryOut => carryOut29, resultado => resultado(29));
			
			
			
			
			

	BIT30 : entity work.subtrator
		port map (entradaA => entradaA(30), entradaB => entradaB(30), sel => sel,
				invB => invB, carryIn => carryOut29, 
				slt => '0', carryOut => carryOut30, resultado => resultado(30));
			
			
			

	BIT31 : entity work.subtrator31
		port map (entradaA => entradaA(31), entradaB => entradaB(31), sel => sel,
				invB => invB, carryIn => carryOut30, 
				slt => '0', carryOut => carryOut31, resultado => resultado(31), overflow => overflow, 
				soma_out => saidaSomador);
	
flagZero <= '1' when not (resultado(31) or resultado(30) or resultado(29) or resultado(28) or resultado(27) or resultado(26) or resultado(25) or resultado(24) or resultado(23) or resultado(22) or resultado(21) or resultado(20) or resultado(19) or resultado(18) or resultado(17) or resultado(16) or resultado(15) or resultado(14) or resultado(13) or resultado(12) or resultado(11) or resultado(10) or resultado (9) or resultado(8) or resultado(7) or resultado(6) or resultado(5) or resultado(4) or resultado(3) or resultado(2) or resultado(1) or resultado(0)) 
					else '0';
				
	

end architecture;