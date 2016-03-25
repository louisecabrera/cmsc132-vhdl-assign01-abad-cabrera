library IEEE; use IEEE.std_logic_1164.all;
library IEEE; use IEEE.numeric_std.all;

entity buzzer is
	port (valid : out std_logic; 
		  encoded : out std_logic;
		  i1, o1, i2, o2, i3, o3 : in std_logic);
end entity;

architecture buzzer_behav of buzzer is
begin
	encoded <= (o2 and i3) or (i1 and o2) or (i1 and o1) or ((not o2) and i3 and o3) or (i1 and (not o2) and o3) or ((not i1) and i2 and o2) or ((not i1) and o1 and i2) or ((not i1) and o1 and (not o2) and i3) or ((not i1) and i2 and (not o2) and o3);
	
	valid <= (o2 and i3) or (i1 and o2) or (i1 and o1) or ((not o2) and i3 and o3) or (i1 and (not o2) and o3) or ((not i1) and i2 and o2) or ((not i1) and o1 and i2) or ((not i1) and o1 and (not o2) and i3) or ((not i1) and i2 and (not o2) and o3);
end architecture buzzer_behav;
