library ieee;
use ieee.std_logic_1164.all;

--  entity of core D-FlipFlop  --

entity dff is
	port(
		CLK, D : in std_logic;
		Q : out std_logic 
	);
end entity;

architecture behavioral of dff is
begin

---- clock sensetive process that activates on the clocks rising edge ----
	dff1: process (CLK) is
	begin 
		if rising_edge(CLK) then
		Q <= D;
		end if;
	end process dff1;
end behavioral;
