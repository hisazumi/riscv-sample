CC=riscv32-unknown-elf-gcc

FLAGS=-static -DNHARTS=1 -march=rv32imac -mabi=ilp32 -T spike32.lds -nostartfiles -DXLEN=32 
SPIKE_FLAGS= -p1 --isa RV32IMAFDC -m0x10000000:0x10000000

all: interrupt interrupt.sym

run: interrupt interrupt.sym
	spike $(SPIKE_FLAGS) -d interrupt

modifiedrun: interrupt interrupt.sym
	 (cd ../riscv-isa-sim-modified/build && make -j 8)
	../riscv-isa-sim-modified/build/spike $(SPIKE_FLAGS) -d interrupt

interrupt.sym: interrupt
	riscv32-unknown-elf-objdump -t interrupt > interrupt.sym

interrupt: entry.S init.c interrupt.c
	$(CC) -g -Og entry.S init.c interrupt.c $(FLAGS) -o interrupt
