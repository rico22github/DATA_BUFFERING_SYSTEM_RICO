view wave 
wave clipboard store
wave create -driver freeze -pattern counter -startvalue 00000000 -endvalue 11111111 -type Range -direction Up -period 10ps -step 1 -repeat forever -range 7 0 -starttime 0ps -endtime 10000ps sim:/data_buffering_system/DIN 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 10000ps sim:/data_buffering_system/reset 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 80ps Edit:/data_buffering_system/reset 
wave create -driver freeze -pattern clock -initialvalue U -period 10ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/data_buffering_system/iclk 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 10000ps sim:/data_buffering_system/fill_fifo 
wave modify -driver freeze -pattern constant -value 1 -starttime 210ps -endtime 300ps Edit:/data_buffering_system/fill_fifo 
wave modify -driver freeze -pattern constant -value 1 -starttime 350ps -endtime 440ps Edit:/data_buffering_system/fill_fifo 
wave modify -driver freeze -pattern constant -value 1 -starttime 490ps -endtime 580ps Edit:/data_buffering_system/fill_fifo 
wave create -driver freeze -pattern clock -initialvalue U -period 40ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/data_buffering_system/oclk 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 10000ps sim:/data_buffering_system/empty_fifo 
wave modify -driver freeze -pattern constant -value 1 -starttime 1320ps -endtime 1360ps Edit:/data_buffering_system/empty_fifo 
wave modify -driver freeze -pattern constant -value 1 -starttime 760ps -endtime 800ps Edit:/data_buffering_system/empty_fifo 
wave modify -driver freeze -pattern constant -value 1 -starttime 1960ps -endtime 2000ps Edit:/data_buffering_system/empty_fifo 
WaveCollapseAll -1
wave clipboard restore
