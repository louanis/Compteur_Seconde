----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2024 20:54:03
-- Design Name: 
-- Module Name: CompCodageBCD - Behavioral
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

entity CompCodageBCD is
  Port (u,d,c,m : out std_logic_vector (3 downto 0);
        out1Hz : in std_logic;
        reset : in std_logic);
end CompCodageBCD;

architecture Behavioral of CompCodageBCD is

signal usig,dsig,csig,msig: std_logic_vector(3 downto 0);

begin
    comptage : process(out1Hz) is
        begin
            if reset = '0' then
                if out1Hz'event and out1Hz = '1' then
                ifusig : if usig = "1001" then
                    usig <= "0000";
                    
                    ifdsig : if dsig = "1001" then
                        dsig <= "0000";
                
                    ifcsig : if csig = "1001" then
                        csig <= "0000";
                        
                    ifmsig : if msig = "1001" then
                        msig <= "0000";
                        csig <= "0000";
                        dsig <= "0000";
                        usig <= "0000";
                    else
                        msig <= msig + '1';
                    
                    end if ifmsig;
                    
                    else
                        
                        csig <= csig + '1';
                
                    end if ifcsig;
                    else
                        
                    dsig <= dsig + '1';
                    end if ifdsig;
                
                else
                    usig <= usig + '1';
                end if ifusig;
                
                end if;
                
                else
                    usig <= "0000";
                    dsig <= "0000";
                    csig <= "0000";
                    msig <= "0000";
                end if;
                
            
        end process comptage;
        
    u<=usig;
    d<=dsig;
    c<=csig;
    m<=msig;

end Behavioral;
