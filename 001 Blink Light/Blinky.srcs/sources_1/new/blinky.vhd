
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Allows us to use standard logic types like '0' and '1'
use IEEE.numeric_std.all;    -- Allows us to do math (like counting and addition) on bit vectors


entity LED_blink is
    Port (
        clk : in std_logic;  -- INPUT: The high-speed heartbeat of the FPGA (e.g., 50 MHz)
        led : out std_logic  -- OUTPUT: The wire connected to the physical LED on our board
    
  );
end LED_blink;

architecture Behavioral of LED_blink is

 -- STATE MACHINE SETUP: Create a custom data type with two easy-to-read names
 type state is (LED_ON, LED_OFF);
 
    -- INTERNAL SIGNALS: These act like invisible wires inside the chip
    signal  s: state; -- Keeps track of our current state (ON or OFF)
    signal counter: unsigned(24 downto 0);  -- A 25-bit wire wide enough to count up to 33,554,431
begin

    blinker : process (clk)
    begin
       
        if rising_edge(clk) then -- ONLY update values at the exact moment the clock ticks from 0 to 1 (Rising Edge)
        -- PART A: Output Logic (Drive the physical pin based on our current state)
            case (s) is
            when LED_ON =>
            led <= '1';  -- Send voltage to turn the LED on
            when LED_OFF=>
            led <= '0';  -- Cut voltage to turn the LED off
        end case; 
    -- PART B: Timing & Transition Logic (When should we switch states?)
            
            -- If we are currently ON and have waited for 30 million clock ticks...
            if ( counter >= 30000000 and s = LED_ON ) then
                -- Reset the counter to exactly 25 zeros (using Hexadecimal padding)
                counter <= '0' & X"000000"; 
                -- Switch the state to OFF so the LED turns off on the next tick
                s <= LED_OFF;
                
            -- If we are currently OFF and have waited for 30 million clock ticks...
            elsif ( counter >= 30000000 and s = LED_OFF ) then
                -- Reset the counter to exactly 25 zeros
                counter <= '0' & X"000000";
                -- Switch the state to ON so the LED turns on on the next tick
                s <= LED_ON;
                
            -- If we haven't reached 30 million yet...
            else
                -- Just add 1 to the counter and keep holding the current state
                counter <= counter + 1;
            end if;
            
        end if;
    end process;


end Behavioral;
