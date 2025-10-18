library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

entity blinky is
 
    port(
            clk : in std_logic;
            led : out std_logic            
     );
end blinky;

architecture behavioral of blinky is
    type state is (LED_ON, LED_OFF);
    signal  s: state;
    signal counter: unsigned(24 downto 0); 
begin

    blinker : process (clk)
    begin
        if rising_edge(clk) then
        case (s) is
            when LED_ON =>
            led <= '1';
            when LED_OFF=>
            led <= '0';
        end case; 
    if ( counter >= 30000000 and s = LED_ON ) then
        counter <= '0' & X"000000";
        s <= LED_OFF;
    elsif ( counter >= 30000000 and s = LED_OFF ) then
        counter <= '0' & X"000000";
        s <= LED_ON;
    else
        counter <= counter + 1;
    end if;
    end if;
    end process;

end behavioral;
