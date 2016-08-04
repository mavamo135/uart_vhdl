-------------------------------------------------------------------------------
--
-- Title       : Serial_Transmitter
-- Design      : Serial_Transmitter
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

entity Serial_Transmitter is
	generic(
		N:integer:=8
		);
	port(
		CLK		:in std_logic:='U';
		ARST	:in std_logic:='U';
		D		:in std_logic_vector(N-1 downto 0):=(others=>'U'); 
		ST		:in std_logic:='U';	
		TX		:out std_logic:='0';
		EOT		:out std_logic:='0'
		);	   
end Serial_Transmitter;	 

architecture structural of Serial_Transmitter is	 
	signal COMP:std_logic:='0';	  
	signal EOTB:std_logic:='0';
	signal OPC:std_logic_vector(1 downto 0):=(others=>'0');
	signal Q:std_logic_vector(3 downto 0):=(others=>'0');
begin
	
	U0:entity work.FSM_TX port map(CLK,ARST,ST,COMP,EOTB,OPC,EOT);
	U1:entity work.Time_Base_TX generic map(16) port map(CLK,ARST,'1',"0001010001011000",EOTB);
	U2:entity work.Up_Counter_Synchronous_Clear generic map(4) port map(CLK,ARST,OPC,Q);
	U3:entity work.Comparator generic map(4) port map(Q,"1010",COMP);
	U4:entity work.MUX generic map(8) port map(D,Q,TX);
	
end structural;				 

