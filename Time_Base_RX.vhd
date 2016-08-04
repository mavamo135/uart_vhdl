-------------------------------------------------------------------------------
--
-- Title       : Time_Base
-- Design      : Time_Base
-- Author      : Maximiliano Valencia Moctezuma
-- Company     : Universidad Autonoma de Queretaro
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\Electronica_Avanzada_2\Up_Down_Counter_Synchronous_Clear\Up_Down_Counter_Synchronous_Clear\Up_Down_Counter_Synchronous_Clear\src\Up_Down_Counter_Synchronous_Clear.vhd
-- Generated   : Tue Aug  4 16:51:42 2015
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;   
use ieee.std_logic_unsigned.all;

entity Time_Base_RX is	
	generic(
		N:integer:=8
		);
	port(
		CLK		:in std_logic:='U';
		ARST	:in std_logic:='U';
		OPC		:in std_logic:='U';	 
		DEL		:in std_logic:='U';
		D		:in std_logic_vector(N-1 downto 0):=(others=>'U');
		EOTB	:out std_logic:='0'
		);	   
end Time_Base_RX;	 

architecture structural of Time_Base_RX is	 
	signal Q:std_logic:='0';
	signal OPC1:std_logic_vector(1 downto 0):=(others=>'0');
	signal Count:std_logic_vector(N-1 downto 0):=(others=>'0');	
begin
	
	EOTB <= Q;
	
	U0:entity work.OPC_Gen_RX port map(OPC,Q,DEL,OPC1);
	U1:entity work.Up_Counter_Synchronous_Clear generic map(N) port map(CLK,ARST,OPC1,Count); 
	U2:entity work.Comparator generic map(N) port map(Count,D,Q);	
		
end structural;				 
