LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DATA_BUFFERING_SYSTEM is
 port(
 
 DIN : in std_logic_vector(7 downto 0);
 reset, fill_fifo, empty_fifo, iclk, oclk : in std_logic;
 
 DOUT : out std_logic_vector(7 downto 0);
 ready_to_fill, fill_done, ready_to_empty, empty_done : out std_logic);

end DATA_BUFFERING_SYSTEM;

architecture behaviour of DATA_BUFFERING_SYSTEM is

component FIFO_BLOCK is
 port(
 
 DIN : in std_logic_vector(7 downto 0);
 reset, fill, empty, iclk, oclk : in std_logic;

 DOUT : out std_logic_vector(7 downto 0);
 fifo_full, fifo_empty : out std_logic);
 
end component; 

signal fifo_full1 : std_logic;
signal fifo_full2 : std_logic;
signal fifo_full3 : std_logic;
signal fifo_empty1 : std_logic;
signal fifo_empty2 : std_logic;
signal fifo_empty3 : std_logic;
signal fill1 : std_logic;
signal fill2 : std_logic;
signal fill3 : std_logic;
signal empty1 : std_logic;
signal empty2 : std_logic;
signal empty3 : std_logic;
signal reset1 : std_logic;
signal reset2 : std_logic;
signal reset3 : std_logic;
signal DOUT1 : std_logic_vector(7 downto 0);
signal DOUT2 : std_logic_vector(7 downto 0);
signal DOUT3 : std_logic_vector(7 downto 0);
signal ready_to_fill2 : std_logic;
signal ready_to_empty2 : std_logic;
signal data_bus_system_full : std_logic;
signal data_bus_system_empty : std_logic;
signal fill_done1 : std_logic;
signal fill_done2 : std_logic;
signal fill_done3 : std_logic;
signal fill_done_demo1 : std_logic;
signal fill_done_demo2 : std_logic;
signal fill_done_demo3 : std_logic;
signal empty_done1 : std_logic;
signal empty_done2 : std_logic;
signal empty_done3 : std_logic;
signal empty_done_demo1 : std_logic;
signal empty_done_demo2 : std_logic;
signal empty_done_demo3 : std_logic;

begin

FIFO1 : FIFO_BLOCK port map(
 DIN => DIN,
 reset => reset1,
 fill => fill1,
 empty => empty1,
 iclk => iclk,
 oclk => oclk,
 DOUT => DOUT1,
 fifo_full => fifo_full1,
 fifo_empty => fifo_empty1);

FIFO2 : FIFO_BLOCK port map(
 DIN => DIN,
 reset => reset2,
 fill => fill2,
 empty => empty2,
 iclk => iclk,
 oclk => oclk,
 DOUT => DOUT2,
 fifo_full => fifo_full2,
 fifo_empty => fifo_empty2);

FIFO3 : FIFO_BLOCK port map(
 DIN => DIN,
 reset => reset3,
 fill => fill3,
 empty => empty3,
 iclk => iclk,
 oclk => oclk,
 DOUT => DOUT3,
 fifo_full => fifo_full3,
 fifo_empty => fifo_empty3);


process(reset, fill_fifo, empty_fifo, iclk, oclk)
begin 


-- The Reset Part --


 if (reset = '1') then
  
  reset1 <= '1';
  reset2 <= '1';
  reset3 <= '1';
  
  DOUT <= DOUT1;
  ready_to_fill <= '0';

 else

  reset1 <= '0';
  reset2 <= '0';
  reset3 <= '0';
  

-- The Filling Part -- 
  
-- The 'ready_to_fill' Section -- 

 
  if (fifo_empty1 = '1') or (fifo_empty2 = '1') or (fifo_empty3 = '1') then
  
   if (rising_edge(iclk)) then
   
    ready_to_fill <= '1';
    ready_to_fill2 <= '1';
  
   end if;

  end if;

  if (rising_edge(iclk)) and (ready_to_fill2 = '1') then

   ready_to_fill <= '0'; 
   ready_to_fill2 <= '0';

  end if;

  
-- The 'fill_fifo' Section --
  
 
  if (fill_fifo = '1') then
      
   if (fifo_empty1 = '1') then
   
    fill1 <= '1';
    fill2 <= '0';
    fill3 <= '0';
   
   elsif (fifo_empty2 = '1') and (fifo_empty1 = '0') then

    fill1 <= '0';
    fill2 <= '1';
    fill3 <= '0';

   elsif (fifo_empty3 = '1') and (fifo_empty2 = '0') and (fifo_empty1 = '0') then

    fill1 <= '0';
    fill2 <= '0';
    fill3 <= '1';
    
   end if;

  end if;

-- The 'Stop Filling' Section --
  
   if (fifo_full1 = '1') then

    fill1 <= '0';

   end if;


  if (fifo_full2 = '1') then

   fill2 <= '0';

  end if;


  if (fifo_full3 = '1') then

   fill3 <= '0';

  end if;


-- The 'fill_done' Section --
  

  if (fifo_empty1 = '1') and (fifo_empty2 = '1') and (fifo_empty3 = '1') then

   data_bus_system_empty <= '1';    
	
  end if;
  
 
  if (data_bus_system_empty = '1') then

   if (fifo_full1 = '1') then
 
    if (rising_edge(iclk)) then
  
     fill_done1 <= '1';
	  fill_done_demo1 <= '1';
   
    end if;
  
   end if; 
 
   if (rising_edge(iclk)) and (fill_done_demo1 = '1') then

    fill_done1 <= '0'; 
	 
   end if;
	
	if (fifo_full1 = '1') then
 
    fill_done <= fill_done1;
  
   end if;
	
  
   if (fifo_full2 = '1') then
 
    if (rising_edge(iclk)) then

     fill_done2 <= '1'; 
	  fill_done_demo2 <= '1'; 

    end if;
 
   end if; 
 
   if (rising_edge(iclk)) and (fill_done_demo2 = '1') then

    fill_done2 <= '0'; 
	 
   end if;
	
	if (fifo_full2 = '1') then
 
    fill_done <= fill_done2; 
  
   end if; 
	
  
   if (fifo_full3 = '1') then

    if (rising_edge(iclk)) then
  
     fill_done3 <= '1';
	  fill_done_demo3 <= '1';
   
    end if;
  
   end if;

   if (rising_edge(iclk)) and (fill_done_demo3 = '1') then

    fill_done3 <= '0'; 
	 
   end if;
 
   if (fifo_full3 = '1') then

    fill_done <= fill_done3;
    
	end if;

  end if;


-- The Emptying Part --  

-- The 'ready_to_empty' Section
  

  if (fifo_full1 = '1') or (fifo_full2 = '1') or (fifo_full3 = '1') then
  
   if (rising_edge(oclk)) then
   
    ready_to_empty <= '1';
    ready_to_empty2 <= '1';
  
   end if;

  end if;

  if (rising_edge(oclk)) and (ready_to_empty2 = '1') then

   ready_to_empty <= '0'; 
   ready_to_empty2 <= '0';

  end if;
  

-- The 'empty_fifo' Part -- 
  
  
  if (empty_fifo = '1') then
 
   if (fifo_full1 = '1') then
   
    empty1 <= '1';
    empty2 <= '0';
    empty3 <= '0';
   
   elsif (fifo_full2 = '1') and (fifo_full1 = '0') then

    empty1 <= '0';
    empty2 <= '1';
    empty3 <= '0';

   elsif (fifo_full3 = '1') and (fifo_full2 = '0') and (fifo_full1 = '0') then

    empty1 <= '0';
    empty2 <= '0';
    empty3 <= '1';

   end if;
   
  end if; 
 

 -- The 'DOUT' Section -- 
 

  if (empty1 = '1') then
 
   DOUT <= DOUT1;

  end if;
  

  if (empty2 = '1') then
 
   DOUT <= DOUT2;

  end if;
  

  if (empty3 = '1') then
 
   DOUT <= DOUT3;

  end if;
  
 
-- The 'Stop Emptying' Section -- 

 
  if (fifo_empty1 = '1') then

   empty1 <= '0';

  end if;


  if (fifo_empty2 = '1') then

   empty2 <= '0';  

  end if;
 
 
  if (fifo_empty3 = '1') then

   empty3 <= '0'; 

  end if;
 
 
-- The 'empty_done' Section 
  
 
  if (fifo_full1 = '1') and (fifo_full2 = '1') and (fifo_full3 = '1') then

   data_bus_system_full <= '1';
   
  end if;

 
  if (data_bus_system_full = '1') then
 
   if (fifo_empty1 = '1') then

    if (rising_edge(oclk))  then

     empty_done1 <= '1';
     empty_done_demo1 <= '1';    
	
    end if;
  
   end if;
 
   if (rising_edge(oclk)) and (empty_done_demo1 = '1') then

    empty_done1 <= '0';   

   end if;
	
	if (fifo_empty1 = '1') then
 
    empty_done <= empty_done1;
 
   end if;
	
 
   if (fifo_empty2 = '1') then

    if (rising_edge(oclk))  then

     empty_done2 <= '1';
     empty_done_demo2 <= '1';    
	
    end if;
  
   end if;
 
   if (rising_edge(oclk)) and (empty_done_demo2 = '1') then
   
    empty_done2 <= '0'; 

   end if;
	
	if (fifo_empty2 = '1') then
 
    empty_done <= empty_done2; 
  
   end if;
	
 
   if (fifo_empty3 = '1') then

    if (rising_edge(oclk))  then

     empty_done3 <= '1';
     empty_done_demo3 <= '1';    
	
    end if;
  
   end if;

   if (rising_edge(oclk)) and (empty_done_demo3 = '1') then

    empty_done3 <= '0';   

   end if;	
 
   if (fifo_empty3 = '1') then

    empty_done <= empty_done3;
	 
	end if;
	
  end if;
  

 end if;

end process;

end behaviour;