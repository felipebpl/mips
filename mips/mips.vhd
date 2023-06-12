library ieee;
use ieee.std_logic_1164.all;

entity mips is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 32;
        larguraEnderecos : natural := 32;
        simulacao : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLOCK_50 : in std_logic;
	 KEY: in std_logic_vector(3 downto 0); 
	 LEDR  : out std_logic_vector(7 downto 0);
	 HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
	 SW  : in std_logic_vector(8 downto 0)
	 
  );
end entity;


architecture arquitetura of mips is

	signal CLK, tipoR : std_logic;

	signal Entrada_ROM : std_logic_vector(31 downto 0);
	signal Saida_ROM : std_logic_vector(31 downto 0);
	
	signal proxPC, proxPC2, proxPC3, proxPC4 : std_logic_vector (31 downto 0);	
	
	signal opCode, funct : std_logic_vector (5 downto 0);
	signal Rs, Rt, Rd, shamt : std_logic_vector (4 downto 0); -- Rd = Rs op Rt
	
	signal dadoRs, dadoRt, dadoRd, Dado_Lido  : std_logic_vector(31 downto 0);
	
	signal habwr, habrd, BEQ, BNE, muxRtIm, WrRegd, Z, muxBEQJMP, JR, saidaBEQBNE : std_logic;
	signal muxULA, muxRtRd : std_logic_vector(1 downto 0);
	signal ULActrl : std_logic_vector (2 downto 0);
	
	signal saidaMUXRTRD : std_logic_vector (4 downto 0);
	signal sigExt, entradaULA_B, saidaULA, saidaMuxM, saidaInc2, saidamuxHEX  : std_logic_vector(31 downto 0);
	
	signal display0, display1, display2, display3, display4, display5	: std_logic_vector(6 downto 0);
	
	signal Sinais_Controle: std_logic_vector(13 downto 0);
	
	signal ORIANDI: std_logic;
	
	signal saidaLUI: std_logic_vector(31 downto 0);
	

begin
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50,
		  entrada => (not KEY(0)),
		  saida => CLK);
end generate;			


PC : entity work.registradorGenerico   generic map (larguraDados => larguraEnderecos)
          port map (DIN => proxPC4, 
			 DOUT => Entrada_ROM, 
			 ENABLE => '1', 
			 CLK => CLK, 
			 RST => '0');
			 

incrementaPC :  entity work.somaConstante  generic map (larguraDados => larguraEnderecos, constante => 4)
        port map( entrada => Entrada_ROM, 
		  saida => proxPC);
		  
soma2 :  entity work.somaEntradas  generic map (larguraDados => larguraEnderecos)
        port map( entrada1 => proxPC, 
						entrada2 => sigExt(29 downto 0)&"00",
						saida => saidaInc2);

ROM : entity work.ROMMIPS   generic map (dataWidth => 32, addrWidth => 32)
          port map (Endereco => Entrada_ROM,
			 Dado => Saida_ROM);			 

REGS : entity work.bancoRegistradores   generic map (larguraDados => 32, larguraEndBancoRegs => 5)
          port map (clk => CLK,
              enderecoA => Rs,
				  enderecoB => Rt,
				  enderecoC => saidaMUXRTRD,
              dadoEscritaC => saidaMuxM,
				  escreveC => WrRegd, 
				  saidaA => dadoRs, 
				  saidaB => dadoRt);
				  
			 
DEC : entity work.decoderInstru
		port map (opcode => opCode, 
		funct => funct, 
		saida => Sinais_Controle);	


ULA1 : entity work.ULA  generic map(larguraDados => 32)
          port map (entradaA => dadoRs, 
			 entradaB => entradaULA_B, 
			 invB => Ulactrl(2), 
			 resultado => saidaULA,
			 sel => ULActrl(1 downto 0),
			 flagZero => Z);

			 
MUXREG :  entity work.muxGenerico4x1  generic map (larguraDados => 5)
			 port map( entradaA_MUX => Rt,
			 entradaB_MUX => Rd,
			 entradaC_MUX => "11111",
			 entradaD_MUX => "00000",
			 seletor_MUX => muxRtRd,
			 saida_MUX => saidaMUXRTRD);	
			
MUXIM :  entity work.muxGenerico2x1  generic map (larguraDados => 32)
			 port map( entradaA_MUX => dadoRt,
			 entradaB_MUX => sigExt,
			 seletor_MUX => muxRtIm,
			 saida_MUX => entradaULA_B);	
			 
		
MUXMEM :  entity work.muxGenerico4x1  generic map (larguraDados => 32)
			 port map( entradaA_MUX => saidaULA,
			 entradaB_MUX => Dado_Lido,
			 entradaC_MUX => proxPC,
			 entradaD_MUX => saidaLUI,
			 seletor_MUX => muxULA,
			 saida_MUX => saidaMuxM);	
			 
MUXBEQBNE : entity work.mux1bit generic map (larguraDados => 1)
				port map(entradaA_MUX => not Z,
							entradaB_MUX => Z,
							seletor_MUX => Sinais_Controle(3),
							saida_MUX => saidaBEQBNE);
			 
MUXINC :  entity work.muxGenerico2x1  generic map (larguraDados => 32)
			 port map(entradaA_MUX => proxPC,
			 entradaB_MUX => saidaInc2,
			 seletor_MUX => ((Sinais_Controle(3) or Sinais_Controle(2)) and saidaBEQBNE),
			 saida_MUX => proxPC2);	
			 
MUXJMP :  entity work.muxGenerico2x1  generic map (larguraDados => 32)
			 port map( entradaA_MUX => proxPC2,
			 entradaB_MUX => proxPC(31 downto 28) & Saida_ROM(25 downto 0) & "00",
			 seletor_MUX => muxBEQJMP,
			 saida_MUX => proxPC3);
			 
MUXJR : entity work.muxGenerico2x1 generic map (larguraDados => 32)
			port map (entradaA_MUX => proxPC3,
						entradaB_MUX => dadoRs,
						seletor_MUX => JR, 
						saida_MUX => proxPC4);
			 
RAM : entity work.RAMMIPS
		generic map (dataWidth => 32, addrWidth => 32)
		port map (Endereco => saidaULA, 
		we => habwr, 
		re => habrd, 
		habilita => '1',
		clk => CLK,
		Dado_in => dadoRt,
		Dado_out => Dado_Lido
		);
		
ExtSig : entity work.estendeSinalGenerico   generic map (larguraDadoEntrada => 16, larguraDadoSaida => 32)
          port map (estendeSinal_IN => Saida_ROM(15 downto 0),
							ORIANDI => ORIANDI,
						  estendeSinal_OUT =>  sigExt);
	
ExtLUI : entity work.estendeSinalLUI
			port map (estendeSinalLUI_IN => Saida_ROM(15 downto 0),
							estendeSinalLUI_OUT => saidaLUI);
	
ULA_UC: entity work.ucULA  
			 port map( opCode => opCode,
			 funct => funct,
			 tipo_r => tipoR,
			 saida => ULActrl);
			 
MuxF_PGA :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map(entradaA_MUX => Entrada_ROM,
                 entradaB_MUX =>  saidaULA,
                 seletor_MUX => SW(0),
                 saida_MUX => saidamuxHEX);
	
	
H0 :  entity work.conversorHex7Seg
        port map(dadoHex => saidamuxHEX(3 downto 0),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => display0);
					  
H1 :  entity work.conversorHex7Seg
        port map(dadoHex => saidamuxHEX(7 downto 4),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => display1);
				
H2 :  entity work.conversorHex7Seg
        port map(dadoHex => saidamuxHEX(11 downto 8),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => display2);
				
H3 :  entity work.conversorHex7Seg
        port map(dadoHex => saidamuxHEX(15 downto 12),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => display3);
				
H4 :  entity work.conversorHex7Seg
        port map(dadoHex => saidamuxHEX(19 downto 16),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => display4);
				
H5 :  entity work.conversorHex7Seg
        port map(dadoHex => saidamuxHEX(23 downto 20),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => display5);
		

opCode <= Saida_ROM(31 downto 26); 
Rs <= Saida_ROM(25 downto 21); 
Rt <= Saida_ROM(20 downto 16); 
Rd <= Saida_ROM(15 downto 11); 
shamt <= Saida_ROM(10 downto 6);
funct <= Saida_ROM(5 downto 0);
			 
habwr <= Sinais_Controle(0);
habrd <= Sinais_Controle(1);
BNE <= Sinais_Controle(2);
BEQ <= Sinais_Controle(3);
muxULA <= Sinais_Controle(5 downto 4);
tipoR <= Sinais_Controle(6);
muxRtIm <= Sinais_Controle(7);
WrRegd <= Sinais_Controle(8);
ORIANDI <= Sinais_Controle(9);
muxRtRd <= Sinais_Controle(11 downto 10);
muxBEQJMP <= Sinais_Controle(12);
JR <= Sinais_Controle(13);
   
LEDR(3 downto 0) <= saidamuxHEX(27 downto 24);
LEDR(7 downto 4) <= saidamuxHEX(31 downto 28);

HEX0 <= display0;
HEX1 <= display1;
HEX2 <= display2;
HEX3 <= display3;
HEX4 <= display4;
HEX5 <= display5;


end architecture;