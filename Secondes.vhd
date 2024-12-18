----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2024 00:06:46
-- Design Name: 
-- Module Name: Secondes - Behavioral
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

entity Secondes is
  Port (Reset : in std_logic;
        IN_100 : in std_logic;
        Sept_segout : out std_logic_vector (7 downto 0);
        Anodex : out std_logic_vector (3 downto 0));
end Secondes;

architecture Behavioral of Secondes is
    component Decodeur_7seg is
        Port ( valeur : in STD_LOGIC_VECTOR (3 downto 0);
           sept_seg : out STD_LOGIC_VECTOR (7 downto 0)
           );
    end component;
    
    component compteur_sec is
        Generic (
             N : integer := 28
             );
             
        Port ( IN_100    : in STD_LOGIC;
           Reset     : in STD_LOGIC;
           OUT_1     : out STD_LOGIC
           );
    end component;
    
    component compteur2 is
        Generic (
             N : integer := 16
             );
             
        Port ( IN_100    : in STD_LOGIC;
           Reset     : in STD_LOGIC;
           Selout     : out STD_LOGIC_vector (1 downto 0)
           );
    end component;
    
    component mux is
        Port ( a,b,c,d : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out STD_LOGIC_VECTOR (3 downto 0)
           );
    end component;
    
    component registre_raz_rau is
        generic ( N : integer := 4
          );
        port ( d : in STD_LOGIC_VECTOR (N-1 downto 0);
         clk, rau, raz : in std_logic;
         q : out  STD_LOGIC_VECTOR (N-1 downto 0) 
         );
    end component;
    
    component CompCodageBCD is
        Port (u,d,c,m : out std_logic_vector (3 downto 0);
              out1Hz : in std_logic;
              reset : in std_logic);
    end component;
    
signal Out_1_1Hz : std_logic;
signal U,D,C,M,OUT_4,An_out : std_logic_vector (3 downto 0);
signal Sel : std_logic_vector (1 downto 0);
signal Out_7 : std_logic_vector (7 downto 0);
signal sclk : std_logic_vector (1 downto 0);
constant Tclk : time:= 10ns;


begin

    Compt_1 : compteur_sec port map(IN_100=>IN_100,Reset=>Reset,Out_1=>Out_1_1Hz);
    Compt_2 : compteur2 port map(IN_100=>IN_100,Reset=>'0',Selout=>Sel);
    Decod_7_seg : Decodeur_7seg port map(valeur=>OUT_4,sept_seg=>out_7);
    Mux_1 : mux port map(A=>U,B=>D,C=>C,D=>M,Sel=>Sel,mux_out=>out_4);
    Mux_2 : mux port map(A=>"1110",B=>"1101",C=>"1011",D=>"0111",Sel=>Sel,mux_out=>an_out);
    Reg_7 : registre_raz_rau generic map(N=>8) port map(d=>out_7,clk=>in_100,rau=>'0',raz=>'0',q=>Sept_segout);
    Reg_4 : registre_raz_rau generic map(N=>4) port map(d=>an_out,clk=>in_100,rau=>'0',raz=>'0',q=>Anodex);
    BCDM : CompCodageBCD port map(u=>u,d=>d,c=>c,m=>m,out1hz=>Out_1_1Hz,reset=>reset);

end Behavioral;
