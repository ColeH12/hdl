vlib work

# Compile VHDL Files
vcom -2008 ../src/synchronizer_3bit.vhd
vcom -2008 ../src/rising_edge_synchronizer.vhd
vcom -2008 ../src/generic_add_sub.vhd
vcom -2008 ../src/seven_seg.vhd
vcom -2008 ../src/add_sub.vhd
vcom -2008 ../src/add_sub_tb.vhd

# Load Testbench
vsim work.add_sub_tb

# Setup Waveform Window
do wave.do

# Run Simulation
run 2500 ns