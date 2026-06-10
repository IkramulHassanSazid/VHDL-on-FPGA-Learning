library ieee;
use ieee.std_logic_1164.all;

entity tb_dff is
end entity;

architecture testbench of tb_dff is

	signal CLK : std_logic := '0';
	signal D : std_logic := '0';
	signal Q : std_logic;

begin

	clk <= not clk after 5 ns; --setting up the clock, it alternates between high and low every 5 second	
	--- T = 10ns, frequency = 100 MHz

-- instantiation -- 
dff1 : entity work.dff
port map(
	CLK => CLK,
	D => D,
	Q => Q);


 --- process to drive and alternate data value
	process is
	begin
		wait for 20 ns;
		d <= '1';
		wait for 80 ns;
		d <= '0';
		wait;
	end process;

end testbench;

