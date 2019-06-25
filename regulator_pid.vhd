library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.numeric_std.all;


entity regulator is 

	generic(
		Kp_przeskalowane	:integer := 32768; -- Kp = 0.5
		Ki_przeskalowane	:integer := 19005; -- Kp = 0.29
		Kd_przeskalowane	:integer := 7864); -- Kd = 0.12 
	
	Port(	zad	:in std_logic_vector(15 downto 0);
			zwr	:in std_logic_vector(15 downto 0);
			wy		:out std_logic_vector(15 downto 0));
end regulator;

architecture Behavioral of regulator is
signal E :integer range -65535 to 65535 := 0;
signal E_poprzedni :integer range -65535 to 65535:= 0;
signal rozniczka :integer range -65535 to 65535:= 0;
signal calka :integer range -65535 to 65535:= 0;
signal P :integer range -65535 to 65535:= 0;
signal I :integer range -65535 to 65535:= 0;
signal D :integer range -65535 to 65535:= 0;

begin
	process(zad)
	begin
		E <= conv_integer(signed(zad)) - conv_integer(signed(zwr));
	end process;
	
	process(E)
	begin
		P <= E * Kp_przeskalowane;
	end process;

	process(E)
	begin
		calka <= (calka + E) / 2;
		I <= calka * Ki_przeskalowane;
	end process;
	
	process(E)
	begin
		rozniczka <= E_poprzedni - E;
		D <= E_poprzedni - E;
		E_poprzedni <= E;
	end process;
	
	process(P, I, D)
	variable PID :integer range -65535 to 65535 := 0;
	begin
		PID := (P + I + D) / 65536;
	end process;
end Behavioral;
	