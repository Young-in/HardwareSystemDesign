onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib floating_MAC_opt

do {wave.do}

view wave
view structure
view signals

do {floating_MAC.udo}

run -all

quit -force
