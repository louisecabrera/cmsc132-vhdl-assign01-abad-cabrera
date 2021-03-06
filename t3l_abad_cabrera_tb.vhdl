library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_buzzer is
	constant MAX_COMB: integer := 64;
	constant DELAY: time := 10 ns;
end entity;

architecture tb_buzzer_arch of tb_buzzer is

	component buzzer is
			port (valid : out std_logic; 
		 	encoded : out std_logic;
		   i1, o1, i2, o2, i3, o3 : in std_logic);
	end component;
	
	signal valid: std_logic;
	signal encoded: std_logic;
	signal  i1, o1, i2, o2, i3, o3: std_logic;
	
begin --architecture

	uut: component buzzer port map(valid, encoded, i1, o1, i2, o2, i3, o3);
	main: process is
	
			variable temp: unsigned(5 downto 0);
			variable expected_valid: std_logic;
			variable expected_encoded: std_logic;
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
			--assign each input a value from temp
			o3 <= temp(5);
			i3 <= temp(4);
			o2 <= temp(3);
			i2 <= temp(2);
			o1 <= temp(1);
			i1 <= temp(0);
			
			if (i=0 or i=1 or i=2 or i=4 or i=5 or i=8 or i=10 or i=16 or i=17 or i=20 or i=21 or i=32 or i=34 or i=40 or i=42) then 
					expected_valid := '0';
					expected_encoded := '0';
			else
				expected_valid := '1';
				expected_encoded := '1';
				
			end if;
			wait for DELAY;
			
			assert((expected_valid = valid) and (expected_encoded = encoded))
				report "ERROR: Expected Valid " & std_logic'image(expected_valid)& " and encoded " &
					std_logic'image(expected_encoded) & " /= actual valid " & 
					std_logic'image(valid) & " and encoded " & std_logic'image(encoded) &
					" at time " & time'image(now);
				
			if  ((expected_valid /= valid) and (expected_encoded /= encoded))
				then error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
			if(error_count = 0)
				then report "Simulation completed with NO errors.";
			end if;
		wait;
	end process;
end architecture tb_buzzer_arch;

