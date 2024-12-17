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

entity compteur2 is
Generic (
             N : integer := 16
             );
    Port ( IN_100    : in STD_LOGIC;
           Reset     : in STD_LOGIC;
           Selout     : out STD_LOGIC_vector (1 downto 0)
           );
end compteur2;

architecture Behavioral of compteur2 is

signal sel : std_logic_vector (1 downto 0);
signal seq : STD_LOGIC; 
signal compt_1 : STD_LOGIC_VECTOR ((N-1) downto 0);
constant compt_1_max : STD_lOGIC_VECTOR ((N-1) downto 0) := X"C34F"; -- demi periode pour 1 sec

begin

process (IN_100) is 
begin 

if reset ='1' then 
        compt_1 <= (others => '0');
elsif reset ='0' then 
    if IN_100'event and IN_100 = '1' then 
        if compt_1 = "0000000000000000" then
            if Sel = "11" then
                Sel <= "00";
            elsif Sel = "00" then
                Sel <= "01";
            elsif Sel = "01" then
                Sel <= "10";
            else
                Sel <= "11";
            end if;
        end if;
        if compt_1 < compt_1_max -'1' then 
            compt_1 <= compt_1 + '1';
        elsif  compt_1 > compt_1_max -"10" and compt_1 < (compt_1_max*"10") - '1' then 
            compt_1 <= compt_1 + '1'; 
        elsif compt_1 = (compt_1_max*"10") - '1' then 
            compt_1 <= (others => '0');
            
        end if;
    end if;
end if; 
Selout <= Sel;
end process;

end Behavioral;
