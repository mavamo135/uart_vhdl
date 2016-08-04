-------------------------------------------------------------------------------
--
-- Title       : UART
-- Design      : Universal Asynchronous Receiver Transmitter
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

entity UART is
	generic(
		N:integer:=8
		);
	port(
		CLK		:in std_logic:='U';
		ARST	:in std_logic:='U';
		RX		:in std_logic:='U';
		ST		:in std_logic:='U';
		DAT_IN	:in std_logic_vector(N-1 downto 0):=(others=>'U'); 	
		TX		:out std_logic:='0';
		EOTR	:out std_logic:='0';
		EOTT	:out std_logic:='0';
		DAT_OUT	:out std_logic_vector(N-1 downto 0):=(others=>'0')
		);	   
end UART;	 

architecture structural of UART is	 

begin
	
	U0:entity work.Serial_Receiver generic map(8) port map(CLK,ARST,RX,DAT_OUT,EOTR);
	U1:entity work.Serial_Transmitter generic map(8) port map(CLK,ARST,DAT_IN,ST,TX,EOTT);
	
end structural;				 

