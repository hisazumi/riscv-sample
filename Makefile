CC=riscv32-unknown-elf-gcc

FLAGS=-static -DNHARTS=1 -march=rv32imac -mabi=ilp32 -T spike32.lds -nostartfiles -DXLEN=32 
#  -mcmodel=medany

all: interrupt interrupt.sym

run: interrupt interrupt.sym
	spike -p1 --isa RV32IMAFDC -d -m0x10000000:0x10000000 interrupt

interrupt.sym: interrupt
	riscv32-unknown-elf-objdump -t interrupt > interrupt.sym

interrupt: entry.S init.c interrupt.c
	$(CC) -g -Og entry.S init.c interrupt.c $(FLAGS) -o interrupt
