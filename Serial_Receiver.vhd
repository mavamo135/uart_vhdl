-------------------------------------------------------------------------------
--
-- Title       : Serial_Receiver
-- Design      : Serial_Receiver
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

entity Serial_Receiver is
	generic(
		N:integer:=8
		);
	port(
		CLK		:in std_logic:='U';
		ARST	:in std_logic:='U'; 
		RX		:in std_logic:='U';	
		DAT		:out std_logic_vector(N-1 downto 0):=(others=>'0');
		EOT		:out std_logic:='0'
		);	   
end Serial_Receiver;	 

architecture structural of Serial_Receiver is	 
	signal COMP:std_logic:='0';	  
	signal EOTB:std_logic:='0';
	signal STTB:std_logic:='0';	   
	signal EN  :std_logic:='0';
	signal DEL :std_logic:='0';
	signal OPC1:std_logic:='0';
	signal OPC2:std_logic_vector(1 downto 0):=(others=>'0');
	signal Q   :std_logic_vector(3 downto 0):=(others=>'0'); 
	signal DR  :std_logic_vector(9 downto 0):=(others=>'0');
begin
	
	U0:entity work.FSM_RX port map(CLK,ARST,RX,COMP,EOTB,OPC1,OPC2,STTB,EN,DEL,EOT);
	U1:entity work.Time_Base_RX generic map(16) port map(CLK,ARST,STTB,DEL,"0000101000101100",EOTB);--9600/2=0000101000101100
	U2:entity work.Up_Counter_Synchronous_Clear generic map(4) port map(CLK,ARST,OPC2,Q);
	U3:entity work.Comparator generic map(4) port map(Q,"1010",COMP);--10 bits=8 bits dato+1 bit parada+1 bit inicio
	U4:entity work.Hold_Right_Shift_Register generic map(10) port map(CLK,ARST,OPC1,RX,DR);	
	--U4:entity work.Hold_Left_Shift_Register generic map(10) port map(CLK,ARST,OPC1,RX,DR);
	U5:entity work.Hold_Register generic map(8) port map(CLK,ARST,EN,DR(8 downto 1),DAT);
	
end structural;				 


