CC=riscv32-unknown-elf-gcc

FLAGS=-static -DNHARTS=1 -march=rv32imac -mabi=ilp32 -T spike32.lds -nostartfiles -DXLEN=32 
SPIKE_PATH=../riscv-isa-sim/build
SPIKE_FLAGS=-l -d -p1 --isa RV32IMAFDC -m0x10000000:0x00100000

all: interrupt interrupt.sym memmapio

run: interrupt interrupt.sym
	spike $(SPIKE_FLAGS) -d interrupt

rinterrupt: interrupt interrupt.sym makespike
	LD_LIBRARY_PATH=$(SPIKE_PATH) $(SPIKE_PATH)/spike $(SPIKE_FLAGS) interrupt

rmemmapio: memmapio makespike
	LD_LIBRARY_PATH=$(SPIKE_PATH) $(SPIKE_PATH)/spike $(SPIKE_FLAGS) memmapio

rmemmapioread: memmapioread makespike
	LD_LIBRARY_PATH=$(SPIKE_PATH) $(SPIKE_PATH)/spike $(SPIKE_FLAGS) memmapioread

makespike:
	 (cd ../riscv-isa-sim/build && make -j 8)

interrupt.sym: interrupt
	riscv32-unknown-elf-objdump -t interrupt > interrupt.sym

interrupt: entry.S init.c interrupt.c spike32.lds
	$(CC) -g -Og entry.S init.c interrupt.c $(FLAGS) -o interrupt

memmapio: entry.S init.c memmapio.c spike32.lds
	$(CC) -g -Og entry.S init.c memmapio.c $(FLAGS) -o memmapio

memmapioread: entry.S init.c memmapioread.c spike32.lds
	$(CC) -g -Og entry.S init.c memmapioread.c $(FLAGS) -o memmapioread

clean:
	rm -f memmapio interrupt interrupt.sym
	