library ieee;
use ieee.std_logic_1164.all;

entity spi is
Port(
	clk_1MHz :in std_logic;
	dac_reg :in std_logic_vector(7 downto 0);
	adc_reg :out std_logic_vector(7 downto 0);
	sclk :out std_logic;
	mosi :out std_logic;
	miso :in std_logic);
	
end spi;
	
architecture Behavioral of spi is
	
begin
	process(clk_1MHz)
	variable adc_reg_tmp :std_logic_vector(7 downto 0) := "00000000";
	variable miso_cnt :integer range 0 to 8 := 0; 
	begin
		if clk_1MHz'event and clk_1MHz = '1' then
			adc_reg_tmp(7 - miso_cnt) := miso; 
			miso_cnt := miso_cnt + 1;
			if miso_cnt > 7 then
				miso_cnt := 0;
				adc_reg <= adc_reg_tmp;
				adc_reg_tmp := "00000000";
			else null;
			end if;
		else null;
		end if;
	end process;
	
	process(clk_1MHz)
	variable mosi_cnt :integer range 0 to 8 := 0;
	
	begin
		if clk_1MHz'event and clk_1MHz = '1' then
			mosi <= dac_reg(7 - mosi_cnt);
			mosi_cnt := mosi_cnt + 1;
			if mosi_cnt > 7 then 
				mosi_cnt := 0;
			else null;
			end if;
			end if;
	end process;

	sclk <= clk_1MHz;
end Behavioral;
