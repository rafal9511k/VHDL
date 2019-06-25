-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "12/07/2018 16:08:06"
                                                            
-- Vhdl Test Bench template for design  :  spi
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY spi_vhd_tst IS
END spi_vhd_tst;
ARCHITECTURE spi_arch OF spi_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL adc_reg : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL clk_1MHz : STD_LOGIC;
SIGNAL dac_reg : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL miso : STD_LOGIC;
SIGNAL mosi : STD_LOGIC;
SIGNAL sclk : STD_LOGIC;
COMPONENT spi
	PORT (
	adc_reg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	clk_1MHz : IN STD_LOGIC;
	dac_reg : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	miso : IN STD_LOGIC;
	mosi : OUT STD_LOGIC;
	sclk : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : spi
	PORT MAP (

	adc_reg => adc_reg,
	clk_1MHz => clk_1MHz,
	dac_reg => dac_reg,
	miso => miso,
	mosi => mosi,
	sclk => sclk
	);
init : PROCESS                                               
                                  
BEGIN                                                        
                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              

BEGIN                                                         
   clk_1MHz <= '0';
	wait for 500 ns;
	clk_1MHz <= '1';
	wait for 500 ns; 
                                           
END PROCESS always;  

process
	
begin
	dac_reg <= "11001100"; -- wyslanie do DAC 11001100
	
	miso <= '1';			-- odbieranie od ADC szeregowo
	wait for 1000 ns;		-- 11001100
	miso <= '1';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '1';
	wait for 1000 ns;
	miso <= '1';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;		-- koniec
	
	dac_reg <= "10000001"; -- wyslanie do DAC 10000001
	
	miso <= '1';			-- odbieranie od ADC szeregowo
	wait for 1000 ns;		-- 10000001
	miso <= '0';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '0';
	wait for 1000 ns;
	miso <= '1';
	wait for 1000 ns;		

	
end process;      
												
END spi_arch;
