library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;

entity hexTo7Seg is
	port(
		clock_200Hz :in std_logic;
		enable	:in std_logic;
		hex_data_0, hex_data_1, hex_data_2, hex_data_3	:in std_logic_vector (3 downto 0);
		segments :out std_logic_vector (6 downto 0);
		dot		:in std_logic;
		dot_seg	:out	std_logic;
		display	:out std_logic_vector(3 downto 0)
		);
end entity;		
		
architecture arch_1 of hexTo7Seg is
	type display_cnt is (dis0, dis1, dis2, dis3);
	signal state:display_cnt; 
	signal data :std_logic_vector(3 downto 0);
	begin
		process (enable, clock_200Hz) begin
			if (enable = '0') then
				segments <= "1111111";
				state <= dis0;
			elsif (enable = '1') then
				if(clock_200Hz'EVENT and clock_200Hz = '1') then
					case data is
						when "0000" => segments(6 downto 0) <= "1000000";
						when "0001" => segments(6 downto 0) <= "1111001";
						when "0010" => segments(6 downto 0) <= "0100100";
						when "0011" => segments(6 downto 0) <= "0110000";
						when "0100" => segments(6 downto 0) <= "0011001";
						when "0101" => segments(6 downto 0) <= "0010010";
						when "0110" => segments(6 downto 0) <= "0000010";
						when "0111" => segments(6 downto 0) <= "1111000";
						when "1000" => segments(6 downto 0) <= "0000000";
						when "1001" => segments(6 downto 0) <= "0010000";
						when "1010" => segments(6 downto 0) <= "0001000";
						when "1011" => segments(6 downto 0) <= "0000011";
						when "1100" => segments(6 downto 0) <= "1000110";
						when "1101" => segments(6 downto 0) <= "0100001";
						when "1110" => segments(6 downto 0) <= "0000110";
						when "1111" => segments(6 downto 0) <= "0001110";
						when others => report "unreachable" severity failure;
					end case;
					if (dot = '1') then 
						dot_seg <= '0';
					else 
						dot_seg <= '1';
					end if;
					case state is
						when dis0 => 
							display(3 downto 0) <= "1110";
							state <= dis1;
							data <= hex_data_0;
						when dis1 => 
							display(3 downto 0) <= "1101";
							state <= dis2;
							data <= hex_data_1;
						when dis2 => 
							display(3 downto 0) <= "1011";
							state <= dis3;
							data <= hex_data_2;
						when dis3 => 
							display(3 downto 0) <= "0111";
							state <= dis0;
							data <= hex_data_3;
					end case;
				end if;
			end if;
		end process;
end architecture;










