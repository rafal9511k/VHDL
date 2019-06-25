library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity keyboard is
	generic(
			N 	:integer := 4);
	port(	clk1Hz	:in std_logic;
			up			:in std_logic;
			down		:in std_logic;
			enter		:in std_logic;
			write_out		:out std_logic;
			function_addr	:out std_logic_vector(N - 1 downto 0);
			function_data	:out std_logic_vector(N - 1 downto 0));
end keyboard;


architecture arch of keyboard is
type keyboard_state is ( select_function, set_data, reset);
	signal state :keyboard_state := reset;
begin
	process(clk1Hz)
	variable key_cnt :integer range 0 to 2**N-1:= 0;
	variable time_cnt :integer range 0 to 10:= 0;
	begin
		if(clk1Hz'event and clk1Hz = '1') then
			case state is
				when select_function =>
					write_out <= '0';
					if up = '1' and key_cnt < 2**N-1 and down = '0' and enter ='0' then 
						key_cnt := key_cnt + 1;
						function_addr <= std_logic_vector(to_unsigned(key_cnt, function_addr'length));
					elsif up = '1' and down ='0' and enter ='0' then
						key_cnt := 0;
						function_addr <= std_logic_vector(to_unsigned(key_cnt, function_addr'length));
					elsif down = '1' and key_cnt > 0 and up ='0' and enter ='0' then
						key_cnt := key_cnt - 1;	
						function_addr <= std_logic_vector(to_unsigned(key_cnt, function_addr'length));
					elsif down = '1' and up = '0' and enter ='0' then
						key_cnt := 2**N-1;
						function_addr <= std_logic_vector(to_unsigned(key_cnt, function_addr'length));
					elsif enter = '1' and up = '0' and down ='0' then 
						function_addr <= std_logic_vector(to_unsigned(key_cnt, function_addr'length));
						key_cnt := 0;
						state <= set_data;
					else null;
					end if;
		
				when set_data =>
					if up = '1' and key_cnt < 2**N-1 and down = '0' and enter ='0' then 
						key_cnt := key_cnt + 1;
						function_data <= std_logic_vector(to_unsigned(key_cnt, function_data'length));
					elsif up = '1' and down = '0' and enter ='0'then
						key_cnt := 0;
						function_data <= std_logic_vector(to_unsigned(key_cnt, function_data'length));
					elsif down = '1' and key_cnt > 0 and up = '0' and enter ='0'then
						key_cnt := key_cnt - 1;	
						function_data <= std_logic_vector(to_unsigned(key_cnt, function_data'length));
					elsif down = '1' and up = '0' and enter ='0'then
						key_cnt := 2**N-1;
						function_data <= std_logic_vector(to_unsigned(key_cnt, function_data'length));
					elsif enter = '1' and up = '0' and down = '0' then 
						write_out <= '1';
						function_data <= std_logic_vector(to_unsigned(key_cnt, function_data'length));
						key_cnt := 0;
						state <= reset;
					else null;
					end if;
					
				when reset => 
					key_cnt := 0;
					function_addr <= std_logic_vector(to_unsigned(0, function_addr'length));
					function_data <= std_logic_vector(to_unsigned(0, function_data'length));
					write_out <= '0';
					state <= select_function;
			end case;
			if up = '1' or down = '1' or enter = '1' then
				time_cnt := 0;
			elsif time_cnt = 10 then 
				time_cnt := 0;
				state <= reset;
			else
				time_cnt := time_cnt + 1;
			end if;
		else null;
		end if;
	end process;

end arch;