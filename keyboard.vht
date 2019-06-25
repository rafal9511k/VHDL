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
-- Generated on "11/16/2018 16:14:22"
                                                            
-- Vhdl Test Bench template for design  :  keyboard
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY keyboard_vhd_tst IS
END keyboard_vhd_tst;
ARCHITECTURE keyboard_arch OF keyboard_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk1Hz : STD_LOGIC;
SIGNAL down : STD_LOGIC;
SIGNAL enter : STD_LOGIC;
SIGNAL function_addr : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL function_data : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL up : STD_LOGIC;
SIGNAL write_out :STD_LOGIC;
COMPONENT keyboard
	PORT (
	clk1Hz : IN STD_LOGIC;
	down : IN STD_LOGIC;
	enter : IN STD_LOGIC;
	up : IN STD_LOGIC;
	function_addr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	function_data : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	write_out :OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : keyboard
	PORT MAP (
-- list connections between master ports and signals
	clk1Hz => clk1Hz,
	down => down,
	enter => enter,
	function_addr => function_addr,
	function_data => function_data,
	up => up,
	write_out => write_out
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once
	up <= '0';				-- test 1 
	down <= '0';			-- tetsowanie podstawowej funkcjonalonści
	enter <= '0';			
	wait for 100 ns;
	up <= '1';
	wait for 60 ns;
	up <= '0';
	wait for 5 ns;
	enter <= '1';
	wait for 20 ns;
	enter <= '0';
	down <= '1';
	wait for 100 ns;
	down <= '0';
	wait for 60 ns;
	enter <= '1';
	wait for 30 ns;
	enter <= '0';			-- test 1 
	
	up <= '0';				-- test 2
	down <= '0';			-- tetsowanie podstawowej funkcjonalonści
	enter <= '0';			
	wait for 100 ns;
	up <= '1';
	wait for 60 ns;
	up <= '0';
	wait for 5 ns;
	down <= '1';
	wait for 40 ns;
	down <= '0';
	wait for 40 ns;
	up <= '1';
	wait for 60 ns;
	up <= '0';
	wait for 30 ns;
	enter <= '1';
	wait for 20 ns;
	enter <= '0';
	wait for 20 ns;
	up <= '1';
	wait for 40 ns;
	up <= '0';
	wait for 30 ns;
	up <= '1';
	wait for 40 ns;
	up <= '0';
	wait for 10 ns;
	down <= '1';
	wait for 40 ns;
	down <= '0';
	wait for 20 ns;
	enter <= '1';
	wait for 20 ns;
	enter <= '0';			-- test 2
	
	
	up <= '0';				-- test 3
	down <= '0';			-- tetsowanie przepełnienia licznika adresu funkcji 
	enter <= '0';			-- i jej wartiści
	wait for 20 ns;
	up <= '1';
	wait for 360 ns;
	up <= '0';
	wait for 5 ns;
	enter <= '1';
	wait for 20 ns;
	enter <= '0';
	down <= '1';
	wait for 360 ns;
	down <= '0';
	wait for 60 ns;
	enter <= '1';
	wait for 20 ns;
	enter <= '0';			-- test 3
	
	up <= '0';				-- test 4
	down <= '0';			-- tetsowanie resetowania po 10 sekdundach
	enter <= '0';			-- bezczynności
	wait for 100 ns;
	up <= '1';
	wait for 80 ns;
	up <= '0';
	wait for 380 ns;
	up <= '1';
	wait for 60 ns;
	up <= '0';
	wait for 10 ns;
	enter <= '1';
	wait for 20 ns;
	enter <= '0';
	down <= '1';
	wait for 30 ns;
	down <= '0';
	wait for 400 ns;
	up <= '1';
	wait for 30 ns;
	up <= '0';				-- test 4
	
	up <= '0';				-- test 5
	down <= '0';			-- testowanie zachowania podczas jednoczesnego wciśnięcia 
	enter <= '0';			-- UP, DOWN
	wait for 400 ns;
	up <= '1';
	wait for 40 ns;
	down <= '1';
	wait for 80 ns;
	up <= '0';
	down <= '0';
	wait for 20 ns;
	enter <= '1';
	wait for 20 ns;
	enter <= '0';
	wait for 20 ns;		-- DOWN, ENTER
	enter <= '1';
	down <= '1';
	wait for 80 ns;
	down <= '0';
	wait for 20 ns;
	enter <= '0';			-- test 5


	
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
	clk1Hz <= '1';
	wait for 10 ns;
	clk1Hz <= '0';
	wait for 10 ns;
END PROCESS always;                                          
END keyboard_arch;
