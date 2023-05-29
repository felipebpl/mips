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
--	 Sinais_Controle: out std_logic_vector(14 downto 0);
	 KEY: in std_logic_vector(3 downto 0); 
--	 ResultOp: out std_logic_vector(31 downto 0); 
--	 Dado_Lido1_Rs: out std_logic_vector(31 downto 0);
--	 Dado_Lido2_Rt: out std_logic_vector(31 downto 0); 
--	 Program_Counter: out std_logic_vector(31 downto 0); 
--	 EntradaB_ULA: out std_logic_vector(31 downto 0);
	 LEDR  : out std_logic_vector(7 downto 0);
	 HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
	 SW  : in std_logic_vector(8 downto 0)
	 
  );
end entity;


architecture arquitetura of mips is

	signal CLK, tipoR : std_logic;

	signal Entrada_ROM : std_logic_vector(31 downto 0);
	signal Saida_ROM : std_logic_vector(31 downto 0);
	
	signal proxPC, proxPC2, proxPC3 : std_logic_vector (31 downto 0);	
	
	signal opCode, funct, opcode_out : std_logic_vector (5 downto 0);
	signal Rs, Rt, Rd, shamt : std_logic_vector (4 downto 0); -- Rd = Rs op Rt
	
	signal dadoRs, dadoRt, dadoRd, Dado_Lido  : std_logic_vector(31 downto 0);
	
	signal habwr, habrd, BEQ, muxULA, muxRtIm, WrRegd, muxRtRd, Z, muxBEQJMP : std_logic;
	signal ULActrl : std_logic_vector (2 downto 0);
	
	signal saidaMUXRTRD : std_logic_vector (4 downto 0);
	signal sigExt, entradaULA_B, saidaULA, saidaMuxM, saidaInc2, saidamuxHEX  : std_logic_vector(31 downto 0);
	
	signal display0, display1, display2, display3, display4, display5	: std_logic_vector(6 downto 0);
	
	signal Sinais_Controle: std_logic_vector(14 downto 0);


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
          port map (DIN => proxPC3, 
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
			 zero => Z);

			 
			 
MUXREG :  entity work.muxGenerico2x1  generic map (larguraDados => 5)
			 port map( entradaA_MUX => Rt,
			 entradaB_MUX => Rd,
			 seletor_MUX => muxRtRd,
			 saida_MUX => saidaMUXRTRD);	
			
MUXIM :  entity work.muxGenerico2x1  generic map (larguraDados => 32)
			 port map( entradaA_MUX => dadoRt,
			 entradaB_MUX => sigExt,
			 seletor_MUX => muxRtIm,
			 saida_MUX => entradaULA_B);	
			 
		
MUXMEM :  entity work.muxGenerico2x1  generic map (larguraDados => 32)
			 port map( entradaA_MUX => saidaULA,
			 entradaB_MUX => Dado_Lido,
			 seletor_MUX => muxULA,
			 saida_MUX => saidaMuxM);	
			 
MUXINC :  entity work.muxGenerico2x1  generic map (larguraDados => 32)
			 port map( entradaA_MUX => proxPC,
			 entradaB_MUX => saidaInc2,
			 seletor_MUX => BEQ and Z,
			 saida_MUX => proxPC2);	
			 
MUXJMP :  entity work.muxGenerico2x1  generic map (larguraDados => 32)
			 port map( entradaA_MUX => proxPC2,
			 entradaB_MUX => proxPC(31 downto 28) & Saida_ROM(25 downto 0) & "00",
			 seletor_MUX => muxBEQJMP,
			 saida_MUX => proxPC3);
			 
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
						  estendeSinal_OUT =>  sigExt);
						  
ULA_UC: entity work.ucULA  
			 port map( opCode => opCode_out,
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
BEQ <= Sinais_Controle(2);
muxULA <= Sinais_Controle(3);
tipoR <= Sinais_Controle(4);
opcode_out <= Sinais_Controle(10 downto 5); 
muxRtIm <= Sinais_Controle(11);
WrRegd <= Sinais_Controle(12);
muxRtRd <= Sinais_Controle(13);
muxBEQJMP <= Sinais_Controle(14);
   
--ResultOp <= saidaULA; 
--Dado_Lido1_Rs <= dadoRs; 
--Dado_Lido2_Rt <= dadoRt; 
--Program_Counter <= Entrada_ROM;
--EntradaB_ULA <= entradaULA_B; 

LEDR(3 downto 0) <= saidamuxHEX(27 downto 24);
LEDR(7 downto 4) <= saidamuxHEX(31 downto 28);

HEX0 <= display0;
HEX1 <= display1;
HEX2 <= display2;
HEX3 <= display3;
HEX4 <= display4;
HEX5 <= display5;


end architecture;