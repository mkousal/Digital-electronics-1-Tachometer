library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_state_machine is
end entity tb_state_machine;

architecture testbench of tb_state_machine is

	signal s_startstop  : std_logic;
    signal s_clk       	: std_logic;
    signal s_rst      	: std_logic;
    signal s_up_i		: std_logic;
    signal s_down_i		: std_logic;
    signal s_data_1 	: unsigned(15 downto 0);
    signal s_data_2 	: unsigned(15 downto 0);
    signal s_data_3 	: unsigned(15 downto 0);
    
    signal s_data_o 	: unsigned(15 downto 0);
    signal s_mode_o		: std_logic;
    signal s_enable_o	: std_logic;
    signal s_reset_1	: std_logic;
    signal s_reset_2	: std_logic;
    signal s_reset_3	: std_logic;
    signal s_reset_4	: std_logic;
    signal s_LED_1		: std_logic;
    signal s_LED_2		: std_logic;
    signal s_LED_3		: std_logic;
    signal s_LED_4		: std_logic;
    
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    signal s_clk_100MHz : std_logic;

begin
    uut_state_machine : entity work.state_machine
        port map(
        	startstop	=> s_startstop,
        	clk			=> s_clk,
        	rst			=> s_rst,
        	up_i		=> s_up_i,
        	down_i		=> s_down_i,
 			data_1		=> s_data_1,
        	data_2		=> s_data_2,
        	data_3		=> s_data_3,
        
        	data_o 		=> s_data_o,
            mode_o		=> s_mode_o,
            enable_o	=> s_enable_o,
        	reset_1		=> s_reset_1,
        	reset_2		=> s_reset_2,
        	reset_3		=> s_reset_3,
       		reset_4		=> s_reset_4,
        	LED_1		=> s_LED_1,
        	LED_2		=> s_LED_2,
        	LED_3		=> s_LED_3,
        	LED_4		=> s_LED_4
        );
	p_clock : process
    begin
    	while now < 1000 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
        s_clk <= '1'; wait;
    end process p_clock;
    
    p_stimulus : process
    begin

        report "---start---" severity note;
        s_data_1 <= "0010100100110000";
        s_data_2 <= "0000011000010101";
        s_data_3 <= "0011010101100010";
        s_up_i <= '0'; s_down_i <= '0';
        s_startstop <= '0'; s_rst <= '0';
        wait for 10 ns;
       
        --reset data1
        s_rst <= '1'; wait for 1 ns;
        s_rst <= '0'; wait for 10 ns;
        --move to data2 and reset
        s_up_i <= '1'; wait for 1 ns;
        s_up_i <= '0'; wait for 10 ns;
        s_rst <= '1'; wait for 1 ns;
        s_rst <= '0'; wait for 10 ns;
        --move to data3 and reset
        s_up_i <= '1'; wait for 1 ns;
        s_up_i <= '0'; wait for 10 ns;
        s_rst <= '1'; wait for 1 ns;
        s_rst <= '0'; wait for 10 ns;
        --move to data4
        s_up_i <= '1'; wait for 1 ns;
        s_up_i <= '0'; wait for 10 ns;
        --start trip
        s_startstop <= '1'; wait for 1 ns;
        s_startstop <= '0'; wait for 10 ns;
        --move to data 3
        s_down_i <= '1'; wait for 1 ns;
        s_down_i <= '0'; wait for 10 ns;
        --move to data 4
        s_up_i <= '1'; wait for 1 ns;
        s_up_i <= '0'; wait for 10 ns;
        -- pause trip
        s_startstop <= '1'; wait for 1 ns;
        s_startstop <= '0'; wait for 10 ns;
        --reset trip
        s_rst <= '1'; wait for 1 ns;
        s_rst <= '0'; wait for 10 ns;
        --move to data1
        s_up_i <= '1'; wait for 1 ns;
        s_up_i <= '0'; wait for 10 ns;
        
        
        
        
        

        wait;       
        report "---stop---" severity note;
    end process p_stimulus;

end architecture testbench;