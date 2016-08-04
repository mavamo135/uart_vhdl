-------------------------------------------------------------------------------
--
-- Title       : FSM
-- Design      : FSM
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
-- Description : Finite State Machine
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Up_Down_Counter_Synchronous_Clear} architecture {Counter}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FSM_RX is
	port( 
		CLK	:in	std_logic:='U';
		ARST:in	std_logic:='U';
		RX	:in	std_logic:='U';
		COMP:in	std_logic:='U';
		EOTB:in std_logic:='U';	
		OPC1:out std_logic:='0';
		OPC2:out std_logic_vector(1 downto 0):=(others=>'0');	
		STTB:out std_logic:='0';
		EN	:out std_logic:='0';
		DEL	:out std_logic:='0';
		EOT :out std_logic:='0'
		);
end FSM_RX;

architecture Finite_State_Machine of FSM_RX is
	signal Qn:std_logic_vector(2 downto 0):=(others=>'0'); 
	signal Qp:std_logic_vector(2 downto 0):=(others=>'0');   
begin
	
	P1:process(Qp,RX,COMP,EOTB)
	begin
		case Qp is
			when "000" =>
				OPC1 <= '0';
				OPC2 <= "00";	
				STTB <= '0';
				EN	 <= '0';
				DEL  <= '0';
				EOT  <= '1';
				if (RX='0') then
					Qn <= "001";	
				else
					Qn <= Qp;
				end if;
			when "001" => 
				OPC1 <= '0';
				OPC2 <= "00";	
				STTB <= '1';
				EN	 <= '0';
				DEL  <= '0';
				EOT  <= '0';
				if (EOTB='1') then
					Qn <= "010";	
				else
					Qn <= Qp;
				end if;
			when "010" =>  
				OPC1 <= '1';
				OPC2 <= "01";	
				STTB <= '1';
				EN	 <= '0';
				EOT  <= '0';
				DEL  <= '0';
				Qn <= "011";	
			when "011" =>  
				OPC1 <= '0';
				OPC2 <= "00";	
				STTB <= '1';
				EN	 <= '0';
				DEL  <= '0';
				EOT  <= '0'; 
				if (EOTB='1') then
					Qn <= "100";	
				else
					Qn <= Qp;
				end if;
			when "100" =>
				OPC1 <= '0';
				OPC2 <= "00";	
				STTB <= '1';
				EN	 <= '0'; 
				DEL  <= '0';
				EOT  <= '0';
				if (COMP='1') then
					Qn <= "101";	
				else
					Qn <= "001";
				end if;	
			when others => 
				OPC1 <= '0';
				OPC2 <= "11";	
				STTB <= '0';
				EN	 <= '1';
				EOT  <= '1';
				DEL  <= '1';
				Qn   <= "000";	
		end case;
	end process P1;  
	
	P2:process(CLK,ARST)
	begin
		if (ARST='0') then
			Qp <= (others=>'0');
		elsif (CLK'event and CLK='1') then
			Qp <= Qn;
		end if;
	end process P2;  	
	
end Finite_State_Machine;
