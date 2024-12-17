----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2023 05:47:57 PM
-- Design Name: 
-- Module Name: compteur_sec - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compteur_sec is
Generic (
             N : integer := 28
             );
    Port ( IN_100    : in STD_LOGIC;
           Reset     : in STD_LOGIC;
           OUT_1     : out STD_LOGIC
           );
end compteur_sec;

architecture Behavioral of compteur_sec is

signal seq : STD_LOGIC; 
signal compt_1 : STD_LOGIC_VECTOR ((N-1) downto 0);
constant compt_1_max : STD_lOGIC_VECTOR ((N-1) downto 0) := X"2FAF07F"; -- demi periode pour 1 sec

begin

process (IN_100) is 
begin 

if reset ='1' then 
        compt_1 <= (others => '0');
        OUT_1 <= '0'; 
elsif reset ='0' then 
    if IN_100'event and IN_100 = '1' then 
        if compt_1 < compt_1_max -'1' then 
            compt_1 <= compt_1 + '1'; 
            OUT_1 <= '1'; 
        elsif  compt_1 > compt_1_max -"10" and compt_1 < (compt_1_max*"10") - '1' then 
            compt_1 <= compt_1 + '1'; 
            OUT_1 <= '0';
        elsif compt_1 = (compt_1_max*"10") - '1' then 
            compt_1 <= (others => '0');
        end if;
    end if;
end if; 
end process;


end Behavioral;
