LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity FIFO_BLOCK is
 port(

 DIN : in std_logic_vector(7 downto 0);
 reset, fill, empty, iclk, oclk : in std_logic;

 DOUT : out std_logic_vector(7 downto 0) := "ZZZZZZZZ";
 fifo_full : out std_logic := '0';
 fifo_empty : out std_logic := '1');

end FIFO_BLOCK;

architecture behaviour of FIFO_BLOCK is


 type depth is array (0 to 7) of std_logic_vector (7 downto 0);
 signal fifo_size : depth;

 signal din_address : integer range 0 to 9 := 0;
 signal dout_address : integer range 0 to 9 := 0;


begin
 
process (reset, fill, empty, iclk, oclk)
begin

 if (reset='1') then
  
  DOUT <= "ZZZZZZZZ";
  fifo_full <= '0'; 
  fifo_empty <= '1';
  
  for i in 0 to 7 loop 
  
   fifo_size(0) <= "UUUUUUUU";
	
  end loop;

  din_address <= 0;
  dout_address <= 0;

 else

  if (rising_edge(iclk)) then
  
   if (fill = '1') and (din_address < 8) then
  
    fifo_size(din_address) <= DIN;
    din_address <= din_address + 1;
	 
   end if;

  end if;	

  if (din_address = 8) then

   fifo_empty <= '0';
   fifo_full <= '1';
   din_address <= 9;

  end if;

  if (din_address = 9) then

   din_address <= 0;

  end if;
  
  
  if (rising_edge(oclk)) then

   if (empty = '1') and (dout_address < 8)then 

    DOUT <= fifo_size(dout_address);
    dout_address <= dout_address + 1;
	 
   end if; 
	
  end if;

  if (dout_address = 8) then

   fifo_full <= '0';
   fifo_empty <= '1';
   dout_address <= 9;

  end if;

  if (dout_address = 9) then

   dout_address <= 0;

  end if;

 end if;
 
end process;

end behaviour; 