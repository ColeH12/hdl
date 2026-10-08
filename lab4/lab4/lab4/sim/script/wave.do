onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate /add_sub_tb/clk
add wave -noupdate /add_sub_tb/reset
add wave -noupdate -radix unsigned /add_sub_tb/a
add wave -noupdate -radix unsigned /add_sub_tb/b
add wave -noupdate -radix unsigned /add_sub_tb/uut/a_sync
add wave -noupdate -radix unsigned /add_sub_tb/uut/b_sync
add wave -noupdate /add_sub_tb/add_btn
add wave -noupdate /add_sub_tb/uut/add_en
add wave -noupdate /add_sub_tb/sub_btn
add wave -noupdate /add_sub_tb/uut/sub_en
add wave -noupdate /add_sub_tb/uut/flag
add wave -noupdate -radix unsigned /add_sub_tb/uut/result
add wave -noupdate /add_sub_tb/a_bcd
add wave -noupdate /add_sub_tb/b_bcd
add wave -noupdate /add_sub_tb/result_bcd

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 200
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2