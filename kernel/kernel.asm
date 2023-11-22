
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	90813103          	ld	sp,-1784(sp) # 8000b908 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	1a4000ef          	jal	ra,800001ba <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <r_mhartid>:
#ifndef __ASSEMBLER__

// which hart (core) is this?
static inline uint64
r_mhartid()
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec22                	sd	s0,24(sp)
    80000020:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
    80000026:	fef43423          	sd	a5,-24(s0)
  return x;
    8000002a:	fe843783          	ld	a5,-24(s0)
}
    8000002e:	853e                	mv	a0,a5
    80000030:	6462                	ld	s0,24(sp)
    80000032:	6105                	addi	sp,sp,32
    80000034:	8082                	ret

0000000080000036 <r_mstatus>:
#define MSTATUS_MPP_U (0L << 11)
#define MSTATUS_MIE (1L << 3)    // machine-mode interrupt enable.

static inline uint64
r_mstatus()
{
    80000036:	1101                	addi	sp,sp,-32
    80000038:	ec22                	sd	s0,24(sp)
    8000003a:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000003c:	300027f3          	csrr	a5,mstatus
    80000040:	fef43423          	sd	a5,-24(s0)
  return x;
    80000044:	fe843783          	ld	a5,-24(s0)
}
    80000048:	853e                	mv	a0,a5
    8000004a:	6462                	ld	s0,24(sp)
    8000004c:	6105                	addi	sp,sp,32
    8000004e:	8082                	ret

0000000080000050 <w_mstatus>:

static inline void 
w_mstatus(uint64 x)
{
    80000050:	1101                	addi	sp,sp,-32
    80000052:	ec22                	sd	s0,24(sp)
    80000054:	1000                	addi	s0,sp,32
    80000056:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000005a:	fe843783          	ld	a5,-24(s0)
    8000005e:	30079073          	csrw	mstatus,a5
}
    80000062:	0001                	nop
    80000064:	6462                	ld	s0,24(sp)
    80000066:	6105                	addi	sp,sp,32
    80000068:	8082                	ret

000000008000006a <w_mepc>:
// machine exception program counter, holds the
// instruction address to which a return from
// exception will go.
static inline void 
w_mepc(uint64 x)
{
    8000006a:	1101                	addi	sp,sp,-32
    8000006c:	ec22                	sd	s0,24(sp)
    8000006e:	1000                	addi	s0,sp,32
    80000070:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mepc, %0" : : "r" (x));
    80000074:	fe843783          	ld	a5,-24(s0)
    80000078:	34179073          	csrw	mepc,a5
}
    8000007c:	0001                	nop
    8000007e:	6462                	ld	s0,24(sp)
    80000080:	6105                	addi	sp,sp,32
    80000082:	8082                	ret

0000000080000084 <r_sie>:
#define SIE_SEIE (1L << 9) // external
#define SIE_STIE (1L << 5) // timer
#define SIE_SSIE (1L << 1) // software
static inline uint64
r_sie()
{
    80000084:	1101                	addi	sp,sp,-32
    80000086:	ec22                	sd	s0,24(sp)
    80000088:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000008a:	104027f3          	csrr	a5,sie
    8000008e:	fef43423          	sd	a5,-24(s0)
  return x;
    80000092:	fe843783          	ld	a5,-24(s0)
}
    80000096:	853e                	mv	a0,a5
    80000098:	6462                	ld	s0,24(sp)
    8000009a:	6105                	addi	sp,sp,32
    8000009c:	8082                	ret

000000008000009e <w_sie>:

static inline void 
w_sie(uint64 x)
{
    8000009e:	1101                	addi	sp,sp,-32
    800000a0:	ec22                	sd	s0,24(sp)
    800000a2:	1000                	addi	s0,sp,32
    800000a4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sie, %0" : : "r" (x));
    800000a8:	fe843783          	ld	a5,-24(s0)
    800000ac:	10479073          	csrw	sie,a5
}
    800000b0:	0001                	nop
    800000b2:	6462                	ld	s0,24(sp)
    800000b4:	6105                	addi	sp,sp,32
    800000b6:	8082                	ret

00000000800000b8 <r_mie>:
#define MIE_MEIE (1L << 11) // external
#define MIE_MTIE (1L << 7)  // timer
#define MIE_MSIE (1L << 3)  // software
static inline uint64
r_mie()
{
    800000b8:	1101                	addi	sp,sp,-32
    800000ba:	ec22                	sd	s0,24(sp)
    800000bc:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mie" : "=r" (x) );
    800000be:	304027f3          	csrr	a5,mie
    800000c2:	fef43423          	sd	a5,-24(s0)
  return x;
    800000c6:	fe843783          	ld	a5,-24(s0)
}
    800000ca:	853e                	mv	a0,a5
    800000cc:	6462                	ld	s0,24(sp)
    800000ce:	6105                	addi	sp,sp,32
    800000d0:	8082                	ret

00000000800000d2 <w_mie>:

static inline void 
w_mie(uint64 x)
{
    800000d2:	1101                	addi	sp,sp,-32
    800000d4:	ec22                	sd	s0,24(sp)
    800000d6:	1000                	addi	s0,sp,32
    800000d8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mie, %0" : : "r" (x));
    800000dc:	fe843783          	ld	a5,-24(s0)
    800000e0:	30479073          	csrw	mie,a5
}
    800000e4:	0001                	nop
    800000e6:	6462                	ld	s0,24(sp)
    800000e8:	6105                	addi	sp,sp,32
    800000ea:	8082                	ret

00000000800000ec <w_medeleg>:
  return x;
}

static inline void 
w_medeleg(uint64 x)
{
    800000ec:	1101                	addi	sp,sp,-32
    800000ee:	ec22                	sd	s0,24(sp)
    800000f0:	1000                	addi	s0,sp,32
    800000f2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000f6:	fe843783          	ld	a5,-24(s0)
    800000fa:	30279073          	csrw	medeleg,a5
}
    800000fe:	0001                	nop
    80000100:	6462                	ld	s0,24(sp)
    80000102:	6105                	addi	sp,sp,32
    80000104:	8082                	ret

0000000080000106 <w_mideleg>:
  return x;
}

static inline void 
w_mideleg(uint64 x)
{
    80000106:	1101                	addi	sp,sp,-32
    80000108:	ec22                	sd	s0,24(sp)
    8000010a:	1000                	addi	s0,sp,32
    8000010c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80000110:	fe843783          	ld	a5,-24(s0)
    80000114:	30379073          	csrw	mideleg,a5
}
    80000118:	0001                	nop
    8000011a:	6462                	ld	s0,24(sp)
    8000011c:	6105                	addi	sp,sp,32
    8000011e:	8082                	ret

0000000080000120 <w_mtvec>:
}

// Machine-mode interrupt vector
static inline void 
w_mtvec(uint64 x)
{
    80000120:	1101                	addi	sp,sp,-32
    80000122:	ec22                	sd	s0,24(sp)
    80000124:	1000                	addi	s0,sp,32
    80000126:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000012a:	fe843783          	ld	a5,-24(s0)
    8000012e:	30579073          	csrw	mtvec,a5
}
    80000132:	0001                	nop
    80000134:	6462                	ld	s0,24(sp)
    80000136:	6105                	addi	sp,sp,32
    80000138:	8082                	ret

000000008000013a <w_pmpcfg0>:

// Physical Memory Protection
static inline void
w_pmpcfg0(uint64 x)
{
    8000013a:	1101                	addi	sp,sp,-32
    8000013c:	ec22                	sd	s0,24(sp)
    8000013e:	1000                	addi	s0,sp,32
    80000140:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80000144:	fe843783          	ld	a5,-24(s0)
    80000148:	3a079073          	csrw	pmpcfg0,a5
}
    8000014c:	0001                	nop
    8000014e:	6462                	ld	s0,24(sp)
    80000150:	6105                	addi	sp,sp,32
    80000152:	8082                	ret

0000000080000154 <w_pmpaddr0>:

static inline void
w_pmpaddr0(uint64 x)
{
    80000154:	1101                	addi	sp,sp,-32
    80000156:	ec22                	sd	s0,24(sp)
    80000158:	1000                	addi	s0,sp,32
    8000015a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    8000015e:	fe843783          	ld	a5,-24(s0)
    80000162:	3b079073          	csrw	pmpaddr0,a5
}
    80000166:	0001                	nop
    80000168:	6462                	ld	s0,24(sp)
    8000016a:	6105                	addi	sp,sp,32
    8000016c:	8082                	ret

000000008000016e <w_satp>:

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
    8000016e:	1101                	addi	sp,sp,-32
    80000170:	ec22                	sd	s0,24(sp)
    80000172:	1000                	addi	s0,sp,32
    80000174:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80000178:	fe843783          	ld	a5,-24(s0)
    8000017c:	18079073          	csrw	satp,a5
}
    80000180:	0001                	nop
    80000182:	6462                	ld	s0,24(sp)
    80000184:	6105                	addi	sp,sp,32
    80000186:	8082                	ret

0000000080000188 <w_mscratch>:
  return x;
}

static inline void 
w_mscratch(uint64 x)
{
    80000188:	1101                	addi	sp,sp,-32
    8000018a:	ec22                	sd	s0,24(sp)
    8000018c:	1000                	addi	s0,sp,32
    8000018e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000192:	fe843783          	ld	a5,-24(s0)
    80000196:	34079073          	csrw	mscratch,a5
}
    8000019a:	0001                	nop
    8000019c:	6462                	ld	s0,24(sp)
    8000019e:	6105                	addi	sp,sp,32
    800001a0:	8082                	ret

00000000800001a2 <w_tp>:
  return x;
}

static inline void 
w_tp(uint64 x)
{
    800001a2:	1101                	addi	sp,sp,-32
    800001a4:	ec22                	sd	s0,24(sp)
    800001a6:	1000                	addi	s0,sp,32
    800001a8:	fea43423          	sd	a0,-24(s0)
  asm volatile("mv tp, %0" : : "r" (x));
    800001ac:	fe843783          	ld	a5,-24(s0)
    800001b0:	823e                	mv	tp,a5
}
    800001b2:	0001                	nop
    800001b4:	6462                	ld	s0,24(sp)
    800001b6:	6105                	addi	sp,sp,32
    800001b8:	8082                	ret

00000000800001ba <start>:
extern void timervec();

// entry.S jumps here in machine mode on stack0.
void
start()
{
    800001ba:	1101                	addi	sp,sp,-32
    800001bc:	ec06                	sd	ra,24(sp)
    800001be:	e822                	sd	s0,16(sp)
    800001c0:	1000                	addi	s0,sp,32
  // set M Previous Privilege mode to Supervisor, for mret.
  unsigned long x = r_mstatus();
    800001c2:	00000097          	auipc	ra,0x0
    800001c6:	e74080e7          	jalr	-396(ra) # 80000036 <r_mstatus>
    800001ca:	fea43423          	sd	a0,-24(s0)
  x &= ~MSTATUS_MPP_MASK;
    800001ce:	fe843703          	ld	a4,-24(s0)
    800001d2:	77f9                	lui	a5,0xffffe
    800001d4:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ffd98cf>
    800001d8:	8ff9                	and	a5,a5,a4
    800001da:	fef43423          	sd	a5,-24(s0)
  x |= MSTATUS_MPP_S;
    800001de:	fe843703          	ld	a4,-24(s0)
    800001e2:	6785                	lui	a5,0x1
    800001e4:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    800001e8:	8fd9                	or	a5,a5,a4
    800001ea:	fef43423          	sd	a5,-24(s0)
  w_mstatus(x);
    800001ee:	fe843503          	ld	a0,-24(s0)
    800001f2:	00000097          	auipc	ra,0x0
    800001f6:	e5e080e7          	jalr	-418(ra) # 80000050 <w_mstatus>

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);
    800001fa:	00001797          	auipc	a5,0x1
    800001fe:	6b878793          	addi	a5,a5,1720 # 800018b2 <main>
    80000202:	853e                	mv	a0,a5
    80000204:	00000097          	auipc	ra,0x0
    80000208:	e66080e7          	jalr	-410(ra) # 8000006a <w_mepc>

  // disable paging for now.
  w_satp(0);
    8000020c:	4501                	li	a0,0
    8000020e:	00000097          	auipc	ra,0x0
    80000212:	f60080e7          	jalr	-160(ra) # 8000016e <w_satp>

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
    80000216:	67c1                	lui	a5,0x10
    80000218:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    8000021c:	00000097          	auipc	ra,0x0
    80000220:	ed0080e7          	jalr	-304(ra) # 800000ec <w_medeleg>
  w_mideleg(0xffff);
    80000224:	67c1                	lui	a5,0x10
    80000226:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    8000022a:	00000097          	auipc	ra,0x0
    8000022e:	edc080e7          	jalr	-292(ra) # 80000106 <w_mideleg>
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80000232:	00000097          	auipc	ra,0x0
    80000236:	e52080e7          	jalr	-430(ra) # 80000084 <r_sie>
    8000023a:	87aa                	mv	a5,a0
    8000023c:	2227e793          	ori	a5,a5,546
    80000240:	853e                	mv	a0,a5
    80000242:	00000097          	auipc	ra,0x0
    80000246:	e5c080e7          	jalr	-420(ra) # 8000009e <w_sie>

  // configure Physical Memory Protection to give supervisor mode
  // access to all of physical memory.
  w_pmpaddr0(0x3fffffffffffffull);
    8000024a:	57fd                	li	a5,-1
    8000024c:	00a7d513          	srli	a0,a5,0xa
    80000250:	00000097          	auipc	ra,0x0
    80000254:	f04080e7          	jalr	-252(ra) # 80000154 <w_pmpaddr0>
  w_pmpcfg0(0xf);
    80000258:	453d                	li	a0,15
    8000025a:	00000097          	auipc	ra,0x0
    8000025e:	ee0080e7          	jalr	-288(ra) # 8000013a <w_pmpcfg0>

  // ask for clock interrupts.
  timerinit();
    80000262:	00000097          	auipc	ra,0x0
    80000266:	032080e7          	jalr	50(ra) # 80000294 <timerinit>

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
    8000026a:	00000097          	auipc	ra,0x0
    8000026e:	db2080e7          	jalr	-590(ra) # 8000001c <r_mhartid>
    80000272:	87aa                	mv	a5,a0
    80000274:	fef42223          	sw	a5,-28(s0)
  w_tp(id);
    80000278:	fe442783          	lw	a5,-28(s0)
    8000027c:	853e                	mv	a0,a5
    8000027e:	00000097          	auipc	ra,0x0
    80000282:	f24080e7          	jalr	-220(ra) # 800001a2 <w_tp>

  // switch to supervisor mode and jump to main().
  asm volatile("mret");
    80000286:	30200073          	mret
}
    8000028a:	0001                	nop
    8000028c:	60e2                	ld	ra,24(sp)
    8000028e:	6442                	ld	s0,16(sp)
    80000290:	6105                	addi	sp,sp,32
    80000292:	8082                	ret

0000000080000294 <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80000294:	1101                	addi	sp,sp,-32
    80000296:	ec06                	sd	ra,24(sp)
    80000298:	e822                	sd	s0,16(sp)
    8000029a:	1000                	addi	s0,sp,32
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    8000029c:	00000097          	auipc	ra,0x0
    800002a0:	d80080e7          	jalr	-640(ra) # 8000001c <r_mhartid>
    800002a4:	87aa                	mv	a5,a0
    800002a6:	fef42623          	sw	a5,-20(s0)

  // ask the CLINT for a timer interrupt.
  int interval = 100000; // cycles; about 1/100th second in qemu.
    800002aa:	67e1                	lui	a5,0x18
    800002ac:	6a07879b          	addiw	a5,a5,1696
    800002b0:	fef42423          	sw	a5,-24(s0)
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800002b4:	0200c7b7          	lui	a5,0x200c
    800002b8:	17e1                	addi	a5,a5,-8
    800002ba:	6398                	ld	a4,0(a5)
    800002bc:	fe842783          	lw	a5,-24(s0)
    800002c0:	fec42683          	lw	a3,-20(s0)
    800002c4:	0036969b          	slliw	a3,a3,0x3
    800002c8:	2681                	sext.w	a3,a3
    800002ca:	8636                	mv	a2,a3
    800002cc:	020046b7          	lui	a3,0x2004
    800002d0:	96b2                	add	a3,a3,a2
    800002d2:	97ba                	add	a5,a5,a4
    800002d4:	e29c                	sd	a5,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800002d6:	fec42703          	lw	a4,-20(s0)
    800002da:	87ba                	mv	a5,a4
    800002dc:	078a                	slli	a5,a5,0x2
    800002de:	97ba                	add	a5,a5,a4
    800002e0:	078e                	slli	a5,a5,0x3
    800002e2:	00013717          	auipc	a4,0x13
    800002e6:	66e70713          	addi	a4,a4,1646 # 80013950 <timer_scratch>
    800002ea:	97ba                	add	a5,a5,a4
    800002ec:	fef43023          	sd	a5,-32(s0)
  scratch[3] = CLINT_MTIMECMP(id);
    800002f0:	fec42783          	lw	a5,-20(s0)
    800002f4:	0037979b          	slliw	a5,a5,0x3
    800002f8:	2781                	sext.w	a5,a5
    800002fa:	873e                	mv	a4,a5
    800002fc:	020047b7          	lui	a5,0x2004
    80000300:	973e                	add	a4,a4,a5
    80000302:	fe043783          	ld	a5,-32(s0)
    80000306:	07e1                	addi	a5,a5,24
    80000308:	e398                	sd	a4,0(a5)
  scratch[4] = interval;
    8000030a:	fe043783          	ld	a5,-32(s0)
    8000030e:	02078793          	addi	a5,a5,32 # 2004020 <_entry-0x7dffbfe0>
    80000312:	fe842703          	lw	a4,-24(s0)
    80000316:	e398                	sd	a4,0(a5)
  w_mscratch((uint64)scratch);
    80000318:	fe043783          	ld	a5,-32(s0)
    8000031c:	853e                	mv	a0,a5
    8000031e:	00000097          	auipc	ra,0x0
    80000322:	e6a080e7          	jalr	-406(ra) # 80000188 <w_mscratch>

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);
    80000326:	00008797          	auipc	a5,0x8
    8000032a:	63a78793          	addi	a5,a5,1594 # 80008960 <timervec>
    8000032e:	853e                	mv	a0,a5
    80000330:	00000097          	auipc	ra,0x0
    80000334:	df0080e7          	jalr	-528(ra) # 80000120 <w_mtvec>

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000338:	00000097          	auipc	ra,0x0
    8000033c:	cfe080e7          	jalr	-770(ra) # 80000036 <r_mstatus>
    80000340:	87aa                	mv	a5,a0
    80000342:	0087e793          	ori	a5,a5,8
    80000346:	853e                	mv	a0,a5
    80000348:	00000097          	auipc	ra,0x0
    8000034c:	d08080e7          	jalr	-760(ra) # 80000050 <w_mstatus>

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000350:	00000097          	auipc	ra,0x0
    80000354:	d68080e7          	jalr	-664(ra) # 800000b8 <r_mie>
    80000358:	87aa                	mv	a5,a0
    8000035a:	0807e793          	ori	a5,a5,128
    8000035e:	853e                	mv	a0,a5
    80000360:	00000097          	auipc	ra,0x0
    80000364:	d72080e7          	jalr	-654(ra) # 800000d2 <w_mie>
}
    80000368:	0001                	nop
    8000036a:	60e2                	ld	ra,24(sp)
    8000036c:	6442                	ld	s0,16(sp)
    8000036e:	6105                	addi	sp,sp,32
    80000370:	8082                	ret

0000000080000372 <consputc>:
// called by printf(), and to echo input characters,
// but not from write().
//
void
consputc(int c)
{
    80000372:	1101                	addi	sp,sp,-32
    80000374:	ec06                	sd	ra,24(sp)
    80000376:	e822                	sd	s0,16(sp)
    80000378:	1000                	addi	s0,sp,32
    8000037a:	87aa                	mv	a5,a0
    8000037c:	fef42623          	sw	a5,-20(s0)
  if(c == BACKSPACE){
    80000380:	fec42783          	lw	a5,-20(s0)
    80000384:	0007871b          	sext.w	a4,a5
    80000388:	10000793          	li	a5,256
    8000038c:	02f71363          	bne	a4,a5,800003b2 <consputc+0x40>
    // if the user typed backspace, overwrite with a space.
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000390:	4521                	li	a0,8
    80000392:	00001097          	auipc	ra,0x1
    80000396:	b66080e7          	jalr	-1178(ra) # 80000ef8 <uartputc_sync>
    8000039a:	02000513          	li	a0,32
    8000039e:	00001097          	auipc	ra,0x1
    800003a2:	b5a080e7          	jalr	-1190(ra) # 80000ef8 <uartputc_sync>
    800003a6:	4521                	li	a0,8
    800003a8:	00001097          	auipc	ra,0x1
    800003ac:	b50080e7          	jalr	-1200(ra) # 80000ef8 <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    800003b0:	a801                	j	800003c0 <consputc+0x4e>
    uartputc_sync(c);
    800003b2:	fec42783          	lw	a5,-20(s0)
    800003b6:	853e                	mv	a0,a5
    800003b8:	00001097          	auipc	ra,0x1
    800003bc:	b40080e7          	jalr	-1216(ra) # 80000ef8 <uartputc_sync>
}
    800003c0:	0001                	nop
    800003c2:	60e2                	ld	ra,24(sp)
    800003c4:	6442                	ld	s0,16(sp)
    800003c6:	6105                	addi	sp,sp,32
    800003c8:	8082                	ret

00000000800003ca <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800003ca:	7179                	addi	sp,sp,-48
    800003cc:	f406                	sd	ra,40(sp)
    800003ce:	f022                	sd	s0,32(sp)
    800003d0:	1800                	addi	s0,sp,48
    800003d2:	87aa                	mv	a5,a0
    800003d4:	fcb43823          	sd	a1,-48(s0)
    800003d8:	8732                	mv	a4,a2
    800003da:	fcf42e23          	sw	a5,-36(s0)
    800003de:	87ba                	mv	a5,a4
    800003e0:	fcf42c23          	sw	a5,-40(s0)
  int i;

  for(i = 0; i < n; i++){
    800003e4:	fe042623          	sw	zero,-20(s0)
    800003e8:	a0a1                	j	80000430 <consolewrite+0x66>
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800003ea:	fec42703          	lw	a4,-20(s0)
    800003ee:	fd043783          	ld	a5,-48(s0)
    800003f2:	00f70633          	add	a2,a4,a5
    800003f6:	fdc42703          	lw	a4,-36(s0)
    800003fa:	feb40793          	addi	a5,s0,-21
    800003fe:	4685                	li	a3,1
    80000400:	85ba                	mv	a1,a4
    80000402:	853e                	mv	a0,a5
    80000404:	00003097          	auipc	ra,0x3
    80000408:	398080e7          	jalr	920(ra) # 8000379c <either_copyin>
    8000040c:	87aa                	mv	a5,a0
    8000040e:	873e                	mv	a4,a5
    80000410:	57fd                	li	a5,-1
    80000412:	02f70863          	beq	a4,a5,80000442 <consolewrite+0x78>
      break;
    uartputc(c);
    80000416:	feb44783          	lbu	a5,-21(s0)
    8000041a:	2781                	sext.w	a5,a5
    8000041c:	853e                	mv	a0,a5
    8000041e:	00001097          	auipc	ra,0x1
    80000422:	a1c080e7          	jalr	-1508(ra) # 80000e3a <uartputc>
  for(i = 0; i < n; i++){
    80000426:	fec42783          	lw	a5,-20(s0)
    8000042a:	2785                	addiw	a5,a5,1
    8000042c:	fef42623          	sw	a5,-20(s0)
    80000430:	fec42703          	lw	a4,-20(s0)
    80000434:	fd842783          	lw	a5,-40(s0)
    80000438:	2701                	sext.w	a4,a4
    8000043a:	2781                	sext.w	a5,a5
    8000043c:	faf747e3          	blt	a4,a5,800003ea <consolewrite+0x20>
    80000440:	a011                	j	80000444 <consolewrite+0x7a>
      break;
    80000442:	0001                	nop
  }

  return i;
    80000444:	fec42783          	lw	a5,-20(s0)
}
    80000448:	853e                	mv	a0,a5
    8000044a:	70a2                	ld	ra,40(sp)
    8000044c:	7402                	ld	s0,32(sp)
    8000044e:	6145                	addi	sp,sp,48
    80000450:	8082                	ret

0000000080000452 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000452:	7179                	addi	sp,sp,-48
    80000454:	f406                	sd	ra,40(sp)
    80000456:	f022                	sd	s0,32(sp)
    80000458:	1800                	addi	s0,sp,48
    8000045a:	87aa                	mv	a5,a0
    8000045c:	fcb43823          	sd	a1,-48(s0)
    80000460:	8732                	mv	a4,a2
    80000462:	fcf42e23          	sw	a5,-36(s0)
    80000466:	87ba                	mv	a5,a4
    80000468:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    8000046c:	fd842783          	lw	a5,-40(s0)
    80000470:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    80000474:	00013517          	auipc	a0,0x13
    80000478:	61c50513          	addi	a0,a0,1564 # 80013a90 <cons>
    8000047c:	00001097          	auipc	ra,0x1
    80000480:	eae080e7          	jalr	-338(ra) # 8000132a <acquire>
  while(n > 0){
    80000484:	a23d                	j	800005b2 <consoleread+0x160>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(killed(myproc())){
    80000486:	00002097          	auipc	ra,0x2
    8000048a:	492080e7          	jalr	1170(ra) # 80002918 <myproc>
    8000048e:	87aa                	mv	a5,a0
    80000490:	853e                	mv	a0,a5
    80000492:	00003097          	auipc	ra,0x3
    80000496:	256080e7          	jalr	598(ra) # 800036e8 <killed>
    8000049a:	87aa                	mv	a5,a0
    8000049c:	cb99                	beqz	a5,800004b2 <consoleread+0x60>
        release(&cons.lock);
    8000049e:	00013517          	auipc	a0,0x13
    800004a2:	5f250513          	addi	a0,a0,1522 # 80013a90 <cons>
    800004a6:	00001097          	auipc	ra,0x1
    800004aa:	ee8080e7          	jalr	-280(ra) # 8000138e <release>
        return -1;
    800004ae:	57fd                	li	a5,-1
    800004b0:	aa25                	j	800005e8 <consoleread+0x196>
      }
      sleep(&cons.r, &cons.lock);
    800004b2:	00013597          	auipc	a1,0x13
    800004b6:	5de58593          	addi	a1,a1,1502 # 80013a90 <cons>
    800004ba:	00013517          	auipc	a0,0x13
    800004be:	66e50513          	addi	a0,a0,1646 # 80013b28 <cons+0x98>
    800004c2:	00003097          	auipc	ra,0x3
    800004c6:	018080e7          	jalr	24(ra) # 800034da <sleep>
    while(cons.r == cons.w){
    800004ca:	00013797          	auipc	a5,0x13
    800004ce:	5c678793          	addi	a5,a5,1478 # 80013a90 <cons>
    800004d2:	0987a703          	lw	a4,152(a5)
    800004d6:	00013797          	auipc	a5,0x13
    800004da:	5ba78793          	addi	a5,a5,1466 # 80013a90 <cons>
    800004de:	09c7a783          	lw	a5,156(a5)
    800004e2:	faf702e3          	beq	a4,a5,80000486 <consoleread+0x34>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800004e6:	00013797          	auipc	a5,0x13
    800004ea:	5aa78793          	addi	a5,a5,1450 # 80013a90 <cons>
    800004ee:	0987a783          	lw	a5,152(a5)
    800004f2:	2781                	sext.w	a5,a5
    800004f4:	0017871b          	addiw	a4,a5,1
    800004f8:	0007069b          	sext.w	a3,a4
    800004fc:	00013717          	auipc	a4,0x13
    80000500:	59470713          	addi	a4,a4,1428 # 80013a90 <cons>
    80000504:	08d72c23          	sw	a3,152(a4)
    80000508:	07f7f793          	andi	a5,a5,127
    8000050c:	2781                	sext.w	a5,a5
    8000050e:	00013717          	auipc	a4,0x13
    80000512:	58270713          	addi	a4,a4,1410 # 80013a90 <cons>
    80000516:	1782                	slli	a5,a5,0x20
    80000518:	9381                	srli	a5,a5,0x20
    8000051a:	97ba                	add	a5,a5,a4
    8000051c:	0187c783          	lbu	a5,24(a5)
    80000520:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    80000524:	fe842783          	lw	a5,-24(s0)
    80000528:	0007871b          	sext.w	a4,a5
    8000052c:	4791                	li	a5,4
    8000052e:	02f71963          	bne	a4,a5,80000560 <consoleread+0x10e>
      if(n < target){
    80000532:	fd842703          	lw	a4,-40(s0)
    80000536:	fec42783          	lw	a5,-20(s0)
    8000053a:	2781                	sext.w	a5,a5
    8000053c:	08f77163          	bgeu	a4,a5,800005be <consoleread+0x16c>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    80000540:	00013797          	auipc	a5,0x13
    80000544:	55078793          	addi	a5,a5,1360 # 80013a90 <cons>
    80000548:	0987a783          	lw	a5,152(a5)
    8000054c:	37fd                	addiw	a5,a5,-1
    8000054e:	0007871b          	sext.w	a4,a5
    80000552:	00013797          	auipc	a5,0x13
    80000556:	53e78793          	addi	a5,a5,1342 # 80013a90 <cons>
    8000055a:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    8000055e:	a085                	j	800005be <consoleread+0x16c>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000560:	fe842783          	lw	a5,-24(s0)
    80000564:	0ff7f793          	andi	a5,a5,255
    80000568:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000056c:	fe740713          	addi	a4,s0,-25
    80000570:	fdc42783          	lw	a5,-36(s0)
    80000574:	4685                	li	a3,1
    80000576:	863a                	mv	a2,a4
    80000578:	fd043583          	ld	a1,-48(s0)
    8000057c:	853e                	mv	a0,a5
    8000057e:	00003097          	auipc	ra,0x3
    80000582:	1aa080e7          	jalr	426(ra) # 80003728 <either_copyout>
    80000586:	87aa                	mv	a5,a0
    80000588:	873e                	mv	a4,a5
    8000058a:	57fd                	li	a5,-1
    8000058c:	02f70b63          	beq	a4,a5,800005c2 <consoleread+0x170>
      break;

    dst++;
    80000590:	fd043783          	ld	a5,-48(s0)
    80000594:	0785                	addi	a5,a5,1
    80000596:	fcf43823          	sd	a5,-48(s0)
    --n;
    8000059a:	fd842783          	lw	a5,-40(s0)
    8000059e:	37fd                	addiw	a5,a5,-1
    800005a0:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    800005a4:	fe842783          	lw	a5,-24(s0)
    800005a8:	0007871b          	sext.w	a4,a5
    800005ac:	47a9                	li	a5,10
    800005ae:	00f70c63          	beq	a4,a5,800005c6 <consoleread+0x174>
  while(n > 0){
    800005b2:	fd842783          	lw	a5,-40(s0)
    800005b6:	2781                	sext.w	a5,a5
    800005b8:	f0f049e3          	bgtz	a5,800004ca <consoleread+0x78>
    800005bc:	a031                	j	800005c8 <consoleread+0x176>
      break;
    800005be:	0001                	nop
    800005c0:	a021                	j	800005c8 <consoleread+0x176>
      break;
    800005c2:	0001                	nop
    800005c4:	a011                	j	800005c8 <consoleread+0x176>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    800005c6:	0001                	nop
    }
  }
  release(&cons.lock);
    800005c8:	00013517          	auipc	a0,0x13
    800005cc:	4c850513          	addi	a0,a0,1224 # 80013a90 <cons>
    800005d0:	00001097          	auipc	ra,0x1
    800005d4:	dbe080e7          	jalr	-578(ra) # 8000138e <release>

  return target - n;
    800005d8:	fd842783          	lw	a5,-40(s0)
    800005dc:	fec42703          	lw	a4,-20(s0)
    800005e0:	40f707bb          	subw	a5,a4,a5
    800005e4:	2781                	sext.w	a5,a5
    800005e6:	2781                	sext.w	a5,a5
}
    800005e8:	853e                	mv	a0,a5
    800005ea:	70a2                	ld	ra,40(sp)
    800005ec:	7402                	ld	s0,32(sp)
    800005ee:	6145                	addi	sp,sp,48
    800005f0:	8082                	ret

00000000800005f2 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800005f2:	1101                	addi	sp,sp,-32
    800005f4:	ec06                	sd	ra,24(sp)
    800005f6:	e822                	sd	s0,16(sp)
    800005f8:	1000                	addi	s0,sp,32
    800005fa:	87aa                	mv	a5,a0
    800005fc:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    80000600:	00013517          	auipc	a0,0x13
    80000604:	49050513          	addi	a0,a0,1168 # 80013a90 <cons>
    80000608:	00001097          	auipc	ra,0x1
    8000060c:	d22080e7          	jalr	-734(ra) # 8000132a <acquire>

  switch(c){
    80000610:	fec42783          	lw	a5,-20(s0)
    80000614:	0007871b          	sext.w	a4,a5
    80000618:	07f00793          	li	a5,127
    8000061c:	0cf70763          	beq	a4,a5,800006ea <consoleintr+0xf8>
    80000620:	fec42783          	lw	a5,-20(s0)
    80000624:	0007871b          	sext.w	a4,a5
    80000628:	07f00793          	li	a5,127
    8000062c:	10e7c363          	blt	a5,a4,80000732 <consoleintr+0x140>
    80000630:	fec42783          	lw	a5,-20(s0)
    80000634:	0007871b          	sext.w	a4,a5
    80000638:	47d5                	li	a5,21
    8000063a:	06f70163          	beq	a4,a5,8000069c <consoleintr+0xaa>
    8000063e:	fec42783          	lw	a5,-20(s0)
    80000642:	0007871b          	sext.w	a4,a5
    80000646:	47d5                	li	a5,21
    80000648:	0ee7c563          	blt	a5,a4,80000732 <consoleintr+0x140>
    8000064c:	fec42783          	lw	a5,-20(s0)
    80000650:	0007871b          	sext.w	a4,a5
    80000654:	47a1                	li	a5,8
    80000656:	08f70a63          	beq	a4,a5,800006ea <consoleintr+0xf8>
    8000065a:	fec42783          	lw	a5,-20(s0)
    8000065e:	0007871b          	sext.w	a4,a5
    80000662:	47c1                	li	a5,16
    80000664:	0cf71763          	bne	a4,a5,80000732 <consoleintr+0x140>
  case C('P'):  // Print process list.
    procdump();
    80000668:	00003097          	auipc	ra,0x3
    8000066c:	1a8080e7          	jalr	424(ra) # 80003810 <procdump>
    break;
    80000670:	aad9                	j	80000846 <consoleintr+0x254>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
      cons.e--;
    80000672:	00013797          	auipc	a5,0x13
    80000676:	41e78793          	addi	a5,a5,1054 # 80013a90 <cons>
    8000067a:	0a07a783          	lw	a5,160(a5)
    8000067e:	37fd                	addiw	a5,a5,-1
    80000680:	0007871b          	sext.w	a4,a5
    80000684:	00013797          	auipc	a5,0x13
    80000688:	40c78793          	addi	a5,a5,1036 # 80013a90 <cons>
    8000068c:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000690:	10000513          	li	a0,256
    80000694:	00000097          	auipc	ra,0x0
    80000698:	cde080e7          	jalr	-802(ra) # 80000372 <consputc>
    while(cons.e != cons.w &&
    8000069c:	00013797          	auipc	a5,0x13
    800006a0:	3f478793          	addi	a5,a5,1012 # 80013a90 <cons>
    800006a4:	0a07a703          	lw	a4,160(a5)
    800006a8:	00013797          	auipc	a5,0x13
    800006ac:	3e878793          	addi	a5,a5,1000 # 80013a90 <cons>
    800006b0:	09c7a783          	lw	a5,156(a5)
    800006b4:	18f70463          	beq	a4,a5,8000083c <consoleintr+0x24a>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800006b8:	00013797          	auipc	a5,0x13
    800006bc:	3d878793          	addi	a5,a5,984 # 80013a90 <cons>
    800006c0:	0a07a783          	lw	a5,160(a5)
    800006c4:	37fd                	addiw	a5,a5,-1
    800006c6:	2781                	sext.w	a5,a5
    800006c8:	07f7f793          	andi	a5,a5,127
    800006cc:	2781                	sext.w	a5,a5
    800006ce:	00013717          	auipc	a4,0x13
    800006d2:	3c270713          	addi	a4,a4,962 # 80013a90 <cons>
    800006d6:	1782                	slli	a5,a5,0x20
    800006d8:	9381                	srli	a5,a5,0x20
    800006da:	97ba                	add	a5,a5,a4
    800006dc:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    800006e0:	873e                	mv	a4,a5
    800006e2:	47a9                	li	a5,10
    800006e4:	f8f717e3          	bne	a4,a5,80000672 <consoleintr+0x80>
    }
    break;
    800006e8:	aa91                	j	8000083c <consoleintr+0x24a>
  case C('H'): // Backspace
  case '\x7f': // Delete key
    if(cons.e != cons.w){
    800006ea:	00013797          	auipc	a5,0x13
    800006ee:	3a678793          	addi	a5,a5,934 # 80013a90 <cons>
    800006f2:	0a07a703          	lw	a4,160(a5)
    800006f6:	00013797          	auipc	a5,0x13
    800006fa:	39a78793          	addi	a5,a5,922 # 80013a90 <cons>
    800006fe:	09c7a783          	lw	a5,156(a5)
    80000702:	12f70f63          	beq	a4,a5,80000840 <consoleintr+0x24e>
      cons.e--;
    80000706:	00013797          	auipc	a5,0x13
    8000070a:	38a78793          	addi	a5,a5,906 # 80013a90 <cons>
    8000070e:	0a07a783          	lw	a5,160(a5)
    80000712:	37fd                	addiw	a5,a5,-1
    80000714:	0007871b          	sext.w	a4,a5
    80000718:	00013797          	auipc	a5,0x13
    8000071c:	37878793          	addi	a5,a5,888 # 80013a90 <cons>
    80000720:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000724:	10000513          	li	a0,256
    80000728:	00000097          	auipc	ra,0x0
    8000072c:	c4a080e7          	jalr	-950(ra) # 80000372 <consputc>
    }
    break;
    80000730:	aa01                	j	80000840 <consoleintr+0x24e>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80000732:	fec42783          	lw	a5,-20(s0)
    80000736:	2781                	sext.w	a5,a5
    80000738:	10078663          	beqz	a5,80000844 <consoleintr+0x252>
    8000073c:	00013797          	auipc	a5,0x13
    80000740:	35478793          	addi	a5,a5,852 # 80013a90 <cons>
    80000744:	0a07a703          	lw	a4,160(a5)
    80000748:	00013797          	auipc	a5,0x13
    8000074c:	34878793          	addi	a5,a5,840 # 80013a90 <cons>
    80000750:	0987a783          	lw	a5,152(a5)
    80000754:	40f707bb          	subw	a5,a4,a5
    80000758:	2781                	sext.w	a5,a5
    8000075a:	873e                	mv	a4,a5
    8000075c:	07f00793          	li	a5,127
    80000760:	0ee7e263          	bltu	a5,a4,80000844 <consoleintr+0x252>
      c = (c == '\r') ? '\n' : c;
    80000764:	fec42783          	lw	a5,-20(s0)
    80000768:	0007871b          	sext.w	a4,a5
    8000076c:	47b5                	li	a5,13
    8000076e:	00f70563          	beq	a4,a5,80000778 <consoleintr+0x186>
    80000772:	fec42783          	lw	a5,-20(s0)
    80000776:	a011                	j	8000077a <consoleintr+0x188>
    80000778:	47a9                	li	a5,10
    8000077a:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    8000077e:	fec42783          	lw	a5,-20(s0)
    80000782:	853e                	mv	a0,a5
    80000784:	00000097          	auipc	ra,0x0
    80000788:	bee080e7          	jalr	-1042(ra) # 80000372 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000078c:	00013797          	auipc	a5,0x13
    80000790:	30478793          	addi	a5,a5,772 # 80013a90 <cons>
    80000794:	0a07a783          	lw	a5,160(a5)
    80000798:	2781                	sext.w	a5,a5
    8000079a:	0017871b          	addiw	a4,a5,1
    8000079e:	0007069b          	sext.w	a3,a4
    800007a2:	00013717          	auipc	a4,0x13
    800007a6:	2ee70713          	addi	a4,a4,750 # 80013a90 <cons>
    800007aa:	0ad72023          	sw	a3,160(a4)
    800007ae:	07f7f793          	andi	a5,a5,127
    800007b2:	2781                	sext.w	a5,a5
    800007b4:	fec42703          	lw	a4,-20(s0)
    800007b8:	0ff77713          	andi	a4,a4,255
    800007bc:	00013697          	auipc	a3,0x13
    800007c0:	2d468693          	addi	a3,a3,724 # 80013a90 <cons>
    800007c4:	1782                	slli	a5,a5,0x20
    800007c6:	9381                	srli	a5,a5,0x20
    800007c8:	97b6                	add	a5,a5,a3
    800007ca:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    800007ce:	fec42783          	lw	a5,-20(s0)
    800007d2:	0007871b          	sext.w	a4,a5
    800007d6:	47a9                	li	a5,10
    800007d8:	02f70d63          	beq	a4,a5,80000812 <consoleintr+0x220>
    800007dc:	fec42783          	lw	a5,-20(s0)
    800007e0:	0007871b          	sext.w	a4,a5
    800007e4:	4791                	li	a5,4
    800007e6:	02f70663          	beq	a4,a5,80000812 <consoleintr+0x220>
    800007ea:	00013797          	auipc	a5,0x13
    800007ee:	2a678793          	addi	a5,a5,678 # 80013a90 <cons>
    800007f2:	0a07a703          	lw	a4,160(a5)
    800007f6:	00013797          	auipc	a5,0x13
    800007fa:	29a78793          	addi	a5,a5,666 # 80013a90 <cons>
    800007fe:	0987a783          	lw	a5,152(a5)
    80000802:	40f707bb          	subw	a5,a4,a5
    80000806:	2781                	sext.w	a5,a5
    80000808:	873e                	mv	a4,a5
    8000080a:	08000793          	li	a5,128
    8000080e:	02f71b63          	bne	a4,a5,80000844 <consoleintr+0x252>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80000812:	00013797          	auipc	a5,0x13
    80000816:	27e78793          	addi	a5,a5,638 # 80013a90 <cons>
    8000081a:	0a07a703          	lw	a4,160(a5)
    8000081e:	00013797          	auipc	a5,0x13
    80000822:	27278793          	addi	a5,a5,626 # 80013a90 <cons>
    80000826:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    8000082a:	00013517          	auipc	a0,0x13
    8000082e:	2fe50513          	addi	a0,a0,766 # 80013b28 <cons+0x98>
    80000832:	00003097          	auipc	ra,0x3
    80000836:	d24080e7          	jalr	-732(ra) # 80003556 <wakeup>
      }
    }
    break;
    8000083a:	a029                	j	80000844 <consoleintr+0x252>
    break;
    8000083c:	0001                	nop
    8000083e:	a021                	j	80000846 <consoleintr+0x254>
    break;
    80000840:	0001                	nop
    80000842:	a011                	j	80000846 <consoleintr+0x254>
    break;
    80000844:	0001                	nop
  }
  
  release(&cons.lock);
    80000846:	00013517          	auipc	a0,0x13
    8000084a:	24a50513          	addi	a0,a0,586 # 80013a90 <cons>
    8000084e:	00001097          	auipc	ra,0x1
    80000852:	b40080e7          	jalr	-1216(ra) # 8000138e <release>
}
    80000856:	0001                	nop
    80000858:	60e2                	ld	ra,24(sp)
    8000085a:	6442                	ld	s0,16(sp)
    8000085c:	6105                	addi	sp,sp,32
    8000085e:	8082                	ret

0000000080000860 <consoleinit>:

void
consoleinit(void)
{
    80000860:	1141                	addi	sp,sp,-16
    80000862:	e406                	sd	ra,8(sp)
    80000864:	e022                	sd	s0,0(sp)
    80000866:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000868:	0000a597          	auipc	a1,0xa
    8000086c:	79858593          	addi	a1,a1,1944 # 8000b000 <etext>
    80000870:	00013517          	auipc	a0,0x13
    80000874:	22050513          	addi	a0,a0,544 # 80013a90 <cons>
    80000878:	00001097          	auipc	ra,0x1
    8000087c:	a82080e7          	jalr	-1406(ra) # 800012fa <initlock>

  uartinit();
    80000880:	00000097          	auipc	ra,0x0
    80000884:	540080e7          	jalr	1344(ra) # 80000dc0 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000888:	00023797          	auipc	a5,0x23
    8000088c:	3a878793          	addi	a5,a5,936 # 80023c30 <devsw>
    80000890:	00000717          	auipc	a4,0x0
    80000894:	bc270713          	addi	a4,a4,-1086 # 80000452 <consoleread>
    80000898:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000089a:	00023797          	auipc	a5,0x23
    8000089e:	39678793          	addi	a5,a5,918 # 80023c30 <devsw>
    800008a2:	00000717          	auipc	a4,0x0
    800008a6:	b2870713          	addi	a4,a4,-1240 # 800003ca <consolewrite>
    800008aa:	ef98                	sd	a4,24(a5)
}
    800008ac:	0001                	nop
    800008ae:	60a2                	ld	ra,8(sp)
    800008b0:	6402                	ld	s0,0(sp)
    800008b2:	0141                	addi	sp,sp,16
    800008b4:	8082                	ret

00000000800008b6 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800008b6:	7139                	addi	sp,sp,-64
    800008b8:	fc06                	sd	ra,56(sp)
    800008ba:	f822                	sd	s0,48(sp)
    800008bc:	0080                	addi	s0,sp,64
    800008be:	87aa                	mv	a5,a0
    800008c0:	86ae                	mv	a3,a1
    800008c2:	8732                	mv	a4,a2
    800008c4:	fcf42623          	sw	a5,-52(s0)
    800008c8:	87b6                	mv	a5,a3
    800008ca:	fcf42423          	sw	a5,-56(s0)
    800008ce:	87ba                	mv	a5,a4
    800008d0:	fcf42223          	sw	a5,-60(s0)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800008d4:	fc442783          	lw	a5,-60(s0)
    800008d8:	2781                	sext.w	a5,a5
    800008da:	c78d                	beqz	a5,80000904 <printint+0x4e>
    800008dc:	fcc42783          	lw	a5,-52(s0)
    800008e0:	01f7d79b          	srliw	a5,a5,0x1f
    800008e4:	0ff7f793          	andi	a5,a5,255
    800008e8:	fcf42223          	sw	a5,-60(s0)
    800008ec:	fc442783          	lw	a5,-60(s0)
    800008f0:	2781                	sext.w	a5,a5
    800008f2:	cb89                	beqz	a5,80000904 <printint+0x4e>
    x = -xx;
    800008f4:	fcc42783          	lw	a5,-52(s0)
    800008f8:	40f007bb          	negw	a5,a5
    800008fc:	2781                	sext.w	a5,a5
    800008fe:	fef42423          	sw	a5,-24(s0)
    80000902:	a029                	j	8000090c <printint+0x56>
  else
    x = xx;
    80000904:	fcc42783          	lw	a5,-52(s0)
    80000908:	fef42423          	sw	a5,-24(s0)

  i = 0;
    8000090c:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    80000910:	fc842783          	lw	a5,-56(s0)
    80000914:	fe842703          	lw	a4,-24(s0)
    80000918:	02f777bb          	remuw	a5,a4,a5
    8000091c:	0007861b          	sext.w	a2,a5
    80000920:	fec42783          	lw	a5,-20(s0)
    80000924:	0017871b          	addiw	a4,a5,1
    80000928:	fee42623          	sw	a4,-20(s0)
    8000092c:	0000b697          	auipc	a3,0xb
    80000930:	ea468693          	addi	a3,a3,-348 # 8000b7d0 <digits>
    80000934:	02061713          	slli	a4,a2,0x20
    80000938:	9301                	srli	a4,a4,0x20
    8000093a:	9736                	add	a4,a4,a3
    8000093c:	00074703          	lbu	a4,0(a4)
    80000940:	ff040693          	addi	a3,s0,-16
    80000944:	97b6                	add	a5,a5,a3
    80000946:	fee78423          	sb	a4,-24(a5)
  } while((x /= base) != 0);
    8000094a:	fc842783          	lw	a5,-56(s0)
    8000094e:	fe842703          	lw	a4,-24(s0)
    80000952:	02f757bb          	divuw	a5,a4,a5
    80000956:	fef42423          	sw	a5,-24(s0)
    8000095a:	fe842783          	lw	a5,-24(s0)
    8000095e:	2781                	sext.w	a5,a5
    80000960:	fbc5                	bnez	a5,80000910 <printint+0x5a>

  if(sign)
    80000962:	fc442783          	lw	a5,-60(s0)
    80000966:	2781                	sext.w	a5,a5
    80000968:	cf85                	beqz	a5,800009a0 <printint+0xea>
    buf[i++] = '-';
    8000096a:	fec42783          	lw	a5,-20(s0)
    8000096e:	0017871b          	addiw	a4,a5,1
    80000972:	fee42623          	sw	a4,-20(s0)
    80000976:	ff040713          	addi	a4,s0,-16
    8000097a:	97ba                	add	a5,a5,a4
    8000097c:	02d00713          	li	a4,45
    80000980:	fee78423          	sb	a4,-24(a5)

  while(--i >= 0)
    80000984:	a831                	j	800009a0 <printint+0xea>
    consputc(buf[i]);
    80000986:	fec42783          	lw	a5,-20(s0)
    8000098a:	ff040713          	addi	a4,s0,-16
    8000098e:	97ba                	add	a5,a5,a4
    80000990:	fe87c783          	lbu	a5,-24(a5)
    80000994:	2781                	sext.w	a5,a5
    80000996:	853e                	mv	a0,a5
    80000998:	00000097          	auipc	ra,0x0
    8000099c:	9da080e7          	jalr	-1574(ra) # 80000372 <consputc>
  while(--i >= 0)
    800009a0:	fec42783          	lw	a5,-20(s0)
    800009a4:	37fd                	addiw	a5,a5,-1
    800009a6:	fef42623          	sw	a5,-20(s0)
    800009aa:	fec42783          	lw	a5,-20(s0)
    800009ae:	2781                	sext.w	a5,a5
    800009b0:	fc07dbe3          	bgez	a5,80000986 <printint+0xd0>
}
    800009b4:	0001                	nop
    800009b6:	0001                	nop
    800009b8:	70e2                	ld	ra,56(sp)
    800009ba:	7442                	ld	s0,48(sp)
    800009bc:	6121                	addi	sp,sp,64
    800009be:	8082                	ret

00000000800009c0 <printptr>:

static void
printptr(uint64 x)
{
    800009c0:	7179                	addi	sp,sp,-48
    800009c2:	f406                	sd	ra,40(sp)
    800009c4:	f022                	sd	s0,32(sp)
    800009c6:	1800                	addi	s0,sp,48
    800009c8:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    800009cc:	03000513          	li	a0,48
    800009d0:	00000097          	auipc	ra,0x0
    800009d4:	9a2080e7          	jalr	-1630(ra) # 80000372 <consputc>
  consputc('x');
    800009d8:	07800513          	li	a0,120
    800009dc:	00000097          	auipc	ra,0x0
    800009e0:	996080e7          	jalr	-1642(ra) # 80000372 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009e4:	fe042623          	sw	zero,-20(s0)
    800009e8:	a81d                	j	80000a1e <printptr+0x5e>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800009ea:	fd843783          	ld	a5,-40(s0)
    800009ee:	93f1                	srli	a5,a5,0x3c
    800009f0:	0000b717          	auipc	a4,0xb
    800009f4:	de070713          	addi	a4,a4,-544 # 8000b7d0 <digits>
    800009f8:	97ba                	add	a5,a5,a4
    800009fa:	0007c783          	lbu	a5,0(a5)
    800009fe:	2781                	sext.w	a5,a5
    80000a00:	853e                	mv	a0,a5
    80000a02:	00000097          	auipc	ra,0x0
    80000a06:	970080e7          	jalr	-1680(ra) # 80000372 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000a0a:	fec42783          	lw	a5,-20(s0)
    80000a0e:	2785                	addiw	a5,a5,1
    80000a10:	fef42623          	sw	a5,-20(s0)
    80000a14:	fd843783          	ld	a5,-40(s0)
    80000a18:	0792                	slli	a5,a5,0x4
    80000a1a:	fcf43c23          	sd	a5,-40(s0)
    80000a1e:	fec42783          	lw	a5,-20(s0)
    80000a22:	873e                	mv	a4,a5
    80000a24:	47bd                	li	a5,15
    80000a26:	fce7f2e3          	bgeu	a5,a4,800009ea <printptr+0x2a>
}
    80000a2a:	0001                	nop
    80000a2c:	0001                	nop
    80000a2e:	70a2                	ld	ra,40(sp)
    80000a30:	7402                	ld	s0,32(sp)
    80000a32:	6145                	addi	sp,sp,48
    80000a34:	8082                	ret

0000000080000a36 <printf>:

// Print to the console. only understands %d, %x, %p, %s.
void
printf(char *fmt, ...)
{
    80000a36:	7119                	addi	sp,sp,-128
    80000a38:	fc06                	sd	ra,56(sp)
    80000a3a:	f822                	sd	s0,48(sp)
    80000a3c:	0080                	addi	s0,sp,64
    80000a3e:	fca43423          	sd	a0,-56(s0)
    80000a42:	e40c                	sd	a1,8(s0)
    80000a44:	e810                	sd	a2,16(s0)
    80000a46:	ec14                	sd	a3,24(s0)
    80000a48:	f018                	sd	a4,32(s0)
    80000a4a:	f41c                	sd	a5,40(s0)
    80000a4c:	03043823          	sd	a6,48(s0)
    80000a50:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, c, locking;
  char *s;

  locking = pr.locking;
    80000a54:	00013797          	auipc	a5,0x13
    80000a58:	0e478793          	addi	a5,a5,228 # 80013b38 <pr>
    80000a5c:	4f9c                	lw	a5,24(a5)
    80000a5e:	fcf42e23          	sw	a5,-36(s0)
  if(locking)
    80000a62:	fdc42783          	lw	a5,-36(s0)
    80000a66:	2781                	sext.w	a5,a5
    80000a68:	cb89                	beqz	a5,80000a7a <printf+0x44>
    acquire(&pr.lock);
    80000a6a:	00013517          	auipc	a0,0x13
    80000a6e:	0ce50513          	addi	a0,a0,206 # 80013b38 <pr>
    80000a72:	00001097          	auipc	ra,0x1
    80000a76:	8b8080e7          	jalr	-1864(ra) # 8000132a <acquire>

  if (fmt == 0)
    80000a7a:	fc843783          	ld	a5,-56(s0)
    80000a7e:	eb89                	bnez	a5,80000a90 <printf+0x5a>
    panic("null fmt");
    80000a80:	0000a517          	auipc	a0,0xa
    80000a84:	58850513          	addi	a0,a0,1416 # 8000b008 <etext+0x8>
    80000a88:	00000097          	auipc	ra,0x0
    80000a8c:	204080e7          	jalr	516(ra) # 80000c8c <panic>

  va_start(ap, fmt);
    80000a90:	04040793          	addi	a5,s0,64
    80000a94:	fcf43023          	sd	a5,-64(s0)
    80000a98:	fc043783          	ld	a5,-64(s0)
    80000a9c:	fc878793          	addi	a5,a5,-56
    80000aa0:	fcf43823          	sd	a5,-48(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000aa4:	fe042623          	sw	zero,-20(s0)
    80000aa8:	a24d                	j	80000c4a <printf+0x214>
    if(c != '%'){
    80000aaa:	fd842783          	lw	a5,-40(s0)
    80000aae:	0007871b          	sext.w	a4,a5
    80000ab2:	02500793          	li	a5,37
    80000ab6:	00f70a63          	beq	a4,a5,80000aca <printf+0x94>
      consputc(c);
    80000aba:	fd842783          	lw	a5,-40(s0)
    80000abe:	853e                	mv	a0,a5
    80000ac0:	00000097          	auipc	ra,0x0
    80000ac4:	8b2080e7          	jalr	-1870(ra) # 80000372 <consputc>
      continue;
    80000ac8:	aaa5                	j	80000c40 <printf+0x20a>
    }
    c = fmt[++i] & 0xff;
    80000aca:	fec42783          	lw	a5,-20(s0)
    80000ace:	2785                	addiw	a5,a5,1
    80000ad0:	fef42623          	sw	a5,-20(s0)
    80000ad4:	fec42783          	lw	a5,-20(s0)
    80000ad8:	fc843703          	ld	a4,-56(s0)
    80000adc:	97ba                	add	a5,a5,a4
    80000ade:	0007c783          	lbu	a5,0(a5)
    80000ae2:	fcf42c23          	sw	a5,-40(s0)
    if(c == 0)
    80000ae6:	fd842783          	lw	a5,-40(s0)
    80000aea:	2781                	sext.w	a5,a5
    80000aec:	16078e63          	beqz	a5,80000c68 <printf+0x232>
      break;
    switch(c){
    80000af0:	fd842783          	lw	a5,-40(s0)
    80000af4:	0007871b          	sext.w	a4,a5
    80000af8:	07800793          	li	a5,120
    80000afc:	08f70963          	beq	a4,a5,80000b8e <printf+0x158>
    80000b00:	fd842783          	lw	a5,-40(s0)
    80000b04:	0007871b          	sext.w	a4,a5
    80000b08:	07800793          	li	a5,120
    80000b0c:	10e7cc63          	blt	a5,a4,80000c24 <printf+0x1ee>
    80000b10:	fd842783          	lw	a5,-40(s0)
    80000b14:	0007871b          	sext.w	a4,a5
    80000b18:	07300793          	li	a5,115
    80000b1c:	0af70563          	beq	a4,a5,80000bc6 <printf+0x190>
    80000b20:	fd842783          	lw	a5,-40(s0)
    80000b24:	0007871b          	sext.w	a4,a5
    80000b28:	07300793          	li	a5,115
    80000b2c:	0ee7cc63          	blt	a5,a4,80000c24 <printf+0x1ee>
    80000b30:	fd842783          	lw	a5,-40(s0)
    80000b34:	0007871b          	sext.w	a4,a5
    80000b38:	07000793          	li	a5,112
    80000b3c:	06f70863          	beq	a4,a5,80000bac <printf+0x176>
    80000b40:	fd842783          	lw	a5,-40(s0)
    80000b44:	0007871b          	sext.w	a4,a5
    80000b48:	07000793          	li	a5,112
    80000b4c:	0ce7cc63          	blt	a5,a4,80000c24 <printf+0x1ee>
    80000b50:	fd842783          	lw	a5,-40(s0)
    80000b54:	0007871b          	sext.w	a4,a5
    80000b58:	02500793          	li	a5,37
    80000b5c:	0af70d63          	beq	a4,a5,80000c16 <printf+0x1e0>
    80000b60:	fd842783          	lw	a5,-40(s0)
    80000b64:	0007871b          	sext.w	a4,a5
    80000b68:	06400793          	li	a5,100
    80000b6c:	0af71c63          	bne	a4,a5,80000c24 <printf+0x1ee>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
    80000b70:	fd043783          	ld	a5,-48(s0)
    80000b74:	00878713          	addi	a4,a5,8
    80000b78:	fce43823          	sd	a4,-48(s0)
    80000b7c:	439c                	lw	a5,0(a5)
    80000b7e:	4605                	li	a2,1
    80000b80:	45a9                	li	a1,10
    80000b82:	853e                	mv	a0,a5
    80000b84:	00000097          	auipc	ra,0x0
    80000b88:	d32080e7          	jalr	-718(ra) # 800008b6 <printint>
      break;
    80000b8c:	a855                	j	80000c40 <printf+0x20a>
    case 'x':
      printint(va_arg(ap, int), 16, 1);
    80000b8e:	fd043783          	ld	a5,-48(s0)
    80000b92:	00878713          	addi	a4,a5,8
    80000b96:	fce43823          	sd	a4,-48(s0)
    80000b9a:	439c                	lw	a5,0(a5)
    80000b9c:	4605                	li	a2,1
    80000b9e:	45c1                	li	a1,16
    80000ba0:	853e                	mv	a0,a5
    80000ba2:	00000097          	auipc	ra,0x0
    80000ba6:	d14080e7          	jalr	-748(ra) # 800008b6 <printint>
      break;
    80000baa:	a859                	j	80000c40 <printf+0x20a>
    case 'p':
      printptr(va_arg(ap, uint64));
    80000bac:	fd043783          	ld	a5,-48(s0)
    80000bb0:	00878713          	addi	a4,a5,8
    80000bb4:	fce43823          	sd	a4,-48(s0)
    80000bb8:	639c                	ld	a5,0(a5)
    80000bba:	853e                	mv	a0,a5
    80000bbc:	00000097          	auipc	ra,0x0
    80000bc0:	e04080e7          	jalr	-508(ra) # 800009c0 <printptr>
      break;
    80000bc4:	a8b5                	j	80000c40 <printf+0x20a>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80000bc6:	fd043783          	ld	a5,-48(s0)
    80000bca:	00878713          	addi	a4,a5,8
    80000bce:	fce43823          	sd	a4,-48(s0)
    80000bd2:	639c                	ld	a5,0(a5)
    80000bd4:	fef43023          	sd	a5,-32(s0)
    80000bd8:	fe043783          	ld	a5,-32(s0)
    80000bdc:	e79d                	bnez	a5,80000c0a <printf+0x1d4>
        s = "(null)";
    80000bde:	0000a797          	auipc	a5,0xa
    80000be2:	43a78793          	addi	a5,a5,1082 # 8000b018 <etext+0x18>
    80000be6:	fef43023          	sd	a5,-32(s0)
      for(; *s; s++)
    80000bea:	a005                	j	80000c0a <printf+0x1d4>
        consputc(*s);
    80000bec:	fe043783          	ld	a5,-32(s0)
    80000bf0:	0007c783          	lbu	a5,0(a5)
    80000bf4:	2781                	sext.w	a5,a5
    80000bf6:	853e                	mv	a0,a5
    80000bf8:	fffff097          	auipc	ra,0xfffff
    80000bfc:	77a080e7          	jalr	1914(ra) # 80000372 <consputc>
      for(; *s; s++)
    80000c00:	fe043783          	ld	a5,-32(s0)
    80000c04:	0785                	addi	a5,a5,1
    80000c06:	fef43023          	sd	a5,-32(s0)
    80000c0a:	fe043783          	ld	a5,-32(s0)
    80000c0e:	0007c783          	lbu	a5,0(a5)
    80000c12:	ffe9                	bnez	a5,80000bec <printf+0x1b6>
      break;
    80000c14:	a035                	j	80000c40 <printf+0x20a>
    case '%':
      consputc('%');
    80000c16:	02500513          	li	a0,37
    80000c1a:	fffff097          	auipc	ra,0xfffff
    80000c1e:	758080e7          	jalr	1880(ra) # 80000372 <consputc>
      break;
    80000c22:	a839                	j	80000c40 <printf+0x20a>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
    80000c24:	02500513          	li	a0,37
    80000c28:	fffff097          	auipc	ra,0xfffff
    80000c2c:	74a080e7          	jalr	1866(ra) # 80000372 <consputc>
      consputc(c);
    80000c30:	fd842783          	lw	a5,-40(s0)
    80000c34:	853e                	mv	a0,a5
    80000c36:	fffff097          	auipc	ra,0xfffff
    80000c3a:	73c080e7          	jalr	1852(ra) # 80000372 <consputc>
      break;
    80000c3e:	0001                	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000c40:	fec42783          	lw	a5,-20(s0)
    80000c44:	2785                	addiw	a5,a5,1
    80000c46:	fef42623          	sw	a5,-20(s0)
    80000c4a:	fec42783          	lw	a5,-20(s0)
    80000c4e:	fc843703          	ld	a4,-56(s0)
    80000c52:	97ba                	add	a5,a5,a4
    80000c54:	0007c783          	lbu	a5,0(a5)
    80000c58:	fcf42c23          	sw	a5,-40(s0)
    80000c5c:	fd842783          	lw	a5,-40(s0)
    80000c60:	2781                	sext.w	a5,a5
    80000c62:	e40794e3          	bnez	a5,80000aaa <printf+0x74>
    80000c66:	a011                	j	80000c6a <printf+0x234>
      break;
    80000c68:	0001                	nop
    }
  }
  va_end(ap);

  if(locking)
    80000c6a:	fdc42783          	lw	a5,-36(s0)
    80000c6e:	2781                	sext.w	a5,a5
    80000c70:	cb89                	beqz	a5,80000c82 <printf+0x24c>
    release(&pr.lock);
    80000c72:	00013517          	auipc	a0,0x13
    80000c76:	ec650513          	addi	a0,a0,-314 # 80013b38 <pr>
    80000c7a:	00000097          	auipc	ra,0x0
    80000c7e:	714080e7          	jalr	1812(ra) # 8000138e <release>
}
    80000c82:	0001                	nop
    80000c84:	70e2                	ld	ra,56(sp)
    80000c86:	7442                	ld	s0,48(sp)
    80000c88:	6109                	addi	sp,sp,128
    80000c8a:	8082                	ret

0000000080000c8c <panic>:

void
panic(char *s)
{
    80000c8c:	1101                	addi	sp,sp,-32
    80000c8e:	ec06                	sd	ra,24(sp)
    80000c90:	e822                	sd	s0,16(sp)
    80000c92:	1000                	addi	s0,sp,32
    80000c94:	fea43423          	sd	a0,-24(s0)
  pr.locking = 0;
    80000c98:	00013797          	auipc	a5,0x13
    80000c9c:	ea078793          	addi	a5,a5,-352 # 80013b38 <pr>
    80000ca0:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000ca4:	0000a517          	auipc	a0,0xa
    80000ca8:	37c50513          	addi	a0,a0,892 # 8000b020 <etext+0x20>
    80000cac:	00000097          	auipc	ra,0x0
    80000cb0:	d8a080e7          	jalr	-630(ra) # 80000a36 <printf>
  printf(s);
    80000cb4:	fe843503          	ld	a0,-24(s0)
    80000cb8:	00000097          	auipc	ra,0x0
    80000cbc:	d7e080e7          	jalr	-642(ra) # 80000a36 <printf>
  printf("\n");
    80000cc0:	0000a517          	auipc	a0,0xa
    80000cc4:	36850513          	addi	a0,a0,872 # 8000b028 <etext+0x28>
    80000cc8:	00000097          	auipc	ra,0x0
    80000ccc:	d6e080e7          	jalr	-658(ra) # 80000a36 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000cd0:	0000b797          	auipc	a5,0xb
    80000cd4:	c5078793          	addi	a5,a5,-944 # 8000b920 <panicked>
    80000cd8:	4705                	li	a4,1
    80000cda:	c398                	sw	a4,0(a5)
  for(;;)
    80000cdc:	a001                	j	80000cdc <panic+0x50>

0000000080000cde <panic_concat>:
    ;
}

void
panic_concat(int count, ...)
{
    80000cde:	7119                	addi	sp,sp,-128
    80000ce0:	fc06                	sd	ra,56(sp)
    80000ce2:	f822                	sd	s0,48(sp)
    80000ce4:	0080                	addi	s0,sp,64
    80000ce6:	e40c                	sd	a1,8(s0)
    80000ce8:	e810                	sd	a2,16(s0)
    80000cea:	ec14                	sd	a3,24(s0)
    80000cec:	f018                	sd	a4,32(s0)
    80000cee:	f41c                	sd	a5,40(s0)
    80000cf0:	03043823          	sd	a6,48(s0)
    80000cf4:	03143c23          	sd	a7,56(s0)
    80000cf8:	87aa                	mv	a5,a0
    80000cfa:	fcf42623          	sw	a5,-52(s0)
  pr.locking = 0;
    80000cfe:	00013797          	auipc	a5,0x13
    80000d02:	e3a78793          	addi	a5,a5,-454 # 80013b38 <pr>
    80000d06:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000d0a:	0000a517          	auipc	a0,0xa
    80000d0e:	31650513          	addi	a0,a0,790 # 8000b020 <etext+0x20>
    80000d12:	00000097          	auipc	ra,0x0
    80000d16:	d24080e7          	jalr	-732(ra) # 80000a36 <printf>
  va_list ap;
  va_start(ap, count);
    80000d1a:	04040793          	addi	a5,s0,64
    80000d1e:	fcf43023          	sd	a5,-64(s0)
    80000d22:	fc043783          	ld	a5,-64(s0)
    80000d26:	fc878793          	addi	a5,a5,-56
    80000d2a:	fcf43c23          	sd	a5,-40(s0)
  for(int i = 0; i < count; i++){
    80000d2e:	fe042623          	sw	zero,-20(s0)
    80000d32:	a02d                	j	80000d5c <panic_concat+0x7e>
    char *s = va_arg(ap, char*);
    80000d34:	fd843783          	ld	a5,-40(s0)
    80000d38:	00878713          	addi	a4,a5,8
    80000d3c:	fce43c23          	sd	a4,-40(s0)
    80000d40:	639c                	ld	a5,0(a5)
    80000d42:	fef43023          	sd	a5,-32(s0)
    printf(s);
    80000d46:	fe043503          	ld	a0,-32(s0)
    80000d4a:	00000097          	auipc	ra,0x0
    80000d4e:	cec080e7          	jalr	-788(ra) # 80000a36 <printf>
  for(int i = 0; i < count; i++){
    80000d52:	fec42783          	lw	a5,-20(s0)
    80000d56:	2785                	addiw	a5,a5,1
    80000d58:	fef42623          	sw	a5,-20(s0)
    80000d5c:	fec42703          	lw	a4,-20(s0)
    80000d60:	fcc42783          	lw	a5,-52(s0)
    80000d64:	2701                	sext.w	a4,a4
    80000d66:	2781                	sext.w	a5,a5
    80000d68:	fcf746e3          	blt	a4,a5,80000d34 <panic_concat+0x56>
  }
  va_end(ap);
  printf("\n");
    80000d6c:	0000a517          	auipc	a0,0xa
    80000d70:	2bc50513          	addi	a0,a0,700 # 8000b028 <etext+0x28>
    80000d74:	00000097          	auipc	ra,0x0
    80000d78:	cc2080e7          	jalr	-830(ra) # 80000a36 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000d7c:	0000b797          	auipc	a5,0xb
    80000d80:	ba478793          	addi	a5,a5,-1116 # 8000b920 <panicked>
    80000d84:	4705                	li	a4,1
    80000d86:	c398                	sw	a4,0(a5)
  for(;;)
    80000d88:	a001                	j	80000d88 <panic_concat+0xaa>

0000000080000d8a <printfinit>:
    ;
}

void
printfinit(void)
{
    80000d8a:	1141                	addi	sp,sp,-16
    80000d8c:	e406                	sd	ra,8(sp)
    80000d8e:	e022                	sd	s0,0(sp)
    80000d90:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80000d92:	0000a597          	auipc	a1,0xa
    80000d96:	29e58593          	addi	a1,a1,670 # 8000b030 <etext+0x30>
    80000d9a:	00013517          	auipc	a0,0x13
    80000d9e:	d9e50513          	addi	a0,a0,-610 # 80013b38 <pr>
    80000da2:	00000097          	auipc	ra,0x0
    80000da6:	558080e7          	jalr	1368(ra) # 800012fa <initlock>
  pr.locking = 1;
    80000daa:	00013797          	auipc	a5,0x13
    80000dae:	d8e78793          	addi	a5,a5,-626 # 80013b38 <pr>
    80000db2:	4705                	li	a4,1
    80000db4:	cf98                	sw	a4,24(a5)
}
    80000db6:	0001                	nop
    80000db8:	60a2                	ld	ra,8(sp)
    80000dba:	6402                	ld	s0,0(sp)
    80000dbc:	0141                	addi	sp,sp,16
    80000dbe:	8082                	ret

0000000080000dc0 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000dc0:	1141                	addi	sp,sp,-16
    80000dc2:	e406                	sd	ra,8(sp)
    80000dc4:	e022                	sd	s0,0(sp)
    80000dc6:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000dc8:	100007b7          	lui	a5,0x10000
    80000dcc:	0785                	addi	a5,a5,1
    80000dce:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000dd2:	100007b7          	lui	a5,0x10000
    80000dd6:	078d                	addi	a5,a5,3
    80000dd8:	f8000713          	li	a4,-128
    80000ddc:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000de0:	100007b7          	lui	a5,0x10000
    80000de4:	470d                	li	a4,3
    80000de6:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000dea:	100007b7          	lui	a5,0x10000
    80000dee:	0785                	addi	a5,a5,1
    80000df0:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000df4:	100007b7          	lui	a5,0x10000
    80000df8:	078d                	addi	a5,a5,3
    80000dfa:	470d                	li	a4,3
    80000dfc:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000e00:	100007b7          	lui	a5,0x10000
    80000e04:	0789                	addi	a5,a5,2
    80000e06:	471d                	li	a4,7
    80000e08:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000e0c:	100007b7          	lui	a5,0x10000
    80000e10:	0785                	addi	a5,a5,1
    80000e12:	470d                	li	a4,3
    80000e14:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  initlock(&uart_tx_lock, "uart");
    80000e18:	0000a597          	auipc	a1,0xa
    80000e1c:	22058593          	addi	a1,a1,544 # 8000b038 <etext+0x38>
    80000e20:	00013517          	auipc	a0,0x13
    80000e24:	d3850513          	addi	a0,a0,-712 # 80013b58 <uart_tx_lock>
    80000e28:	00000097          	auipc	ra,0x0
    80000e2c:	4d2080e7          	jalr	1234(ra) # 800012fa <initlock>
}
    80000e30:	0001                	nop
    80000e32:	60a2                	ld	ra,8(sp)
    80000e34:	6402                	ld	s0,0(sp)
    80000e36:	0141                	addi	sp,sp,16
    80000e38:	8082                	ret

0000000080000e3a <uartputc>:
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
void
uartputc(int c)
{
    80000e3a:	1101                	addi	sp,sp,-32
    80000e3c:	ec06                	sd	ra,24(sp)
    80000e3e:	e822                	sd	s0,16(sp)
    80000e40:	1000                	addi	s0,sp,32
    80000e42:	87aa                	mv	a5,a0
    80000e44:	fef42623          	sw	a5,-20(s0)
  acquire(&uart_tx_lock);
    80000e48:	00013517          	auipc	a0,0x13
    80000e4c:	d1050513          	addi	a0,a0,-752 # 80013b58 <uart_tx_lock>
    80000e50:	00000097          	auipc	ra,0x0
    80000e54:	4da080e7          	jalr	1242(ra) # 8000132a <acquire>

  if(panicked){
    80000e58:	0000b797          	auipc	a5,0xb
    80000e5c:	ac878793          	addi	a5,a5,-1336 # 8000b920 <panicked>
    80000e60:	439c                	lw	a5,0(a5)
    80000e62:	2781                	sext.w	a5,a5
    80000e64:	cf91                	beqz	a5,80000e80 <uartputc+0x46>
    for(;;)
    80000e66:	a001                	j	80000e66 <uartputc+0x2c>
      ;
  }
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    // buffer is full.
    // wait for uartstart() to open up space in the buffer.
    sleep(&uart_tx_r, &uart_tx_lock);
    80000e68:	00013597          	auipc	a1,0x13
    80000e6c:	cf058593          	addi	a1,a1,-784 # 80013b58 <uart_tx_lock>
    80000e70:	0000b517          	auipc	a0,0xb
    80000e74:	ac050513          	addi	a0,a0,-1344 # 8000b930 <uart_tx_r>
    80000e78:	00002097          	auipc	ra,0x2
    80000e7c:	662080e7          	jalr	1634(ra) # 800034da <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000e80:	0000b797          	auipc	a5,0xb
    80000e84:	ab078793          	addi	a5,a5,-1360 # 8000b930 <uart_tx_r>
    80000e88:	639c                	ld	a5,0(a5)
    80000e8a:	02078713          	addi	a4,a5,32
    80000e8e:	0000b797          	auipc	a5,0xb
    80000e92:	a9a78793          	addi	a5,a5,-1382 # 8000b928 <uart_tx_w>
    80000e96:	639c                	ld	a5,0(a5)
    80000e98:	fcf708e3          	beq	a4,a5,80000e68 <uartputc+0x2e>
  }
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000e9c:	0000b797          	auipc	a5,0xb
    80000ea0:	a8c78793          	addi	a5,a5,-1396 # 8000b928 <uart_tx_w>
    80000ea4:	639c                	ld	a5,0(a5)
    80000ea6:	8bfd                	andi	a5,a5,31
    80000ea8:	fec42703          	lw	a4,-20(s0)
    80000eac:	0ff77713          	andi	a4,a4,255
    80000eb0:	00013697          	auipc	a3,0x13
    80000eb4:	cc068693          	addi	a3,a3,-832 # 80013b70 <uart_tx_buf>
    80000eb8:	97b6                	add	a5,a5,a3
    80000eba:	00e78023          	sb	a4,0(a5)
  uart_tx_w += 1;
    80000ebe:	0000b797          	auipc	a5,0xb
    80000ec2:	a6a78793          	addi	a5,a5,-1430 # 8000b928 <uart_tx_w>
    80000ec6:	639c                	ld	a5,0(a5)
    80000ec8:	00178713          	addi	a4,a5,1
    80000ecc:	0000b797          	auipc	a5,0xb
    80000ed0:	a5c78793          	addi	a5,a5,-1444 # 8000b928 <uart_tx_w>
    80000ed4:	e398                	sd	a4,0(a5)
  uartstart();
    80000ed6:	00000097          	auipc	ra,0x0
    80000eda:	084080e7          	jalr	132(ra) # 80000f5a <uartstart>
  release(&uart_tx_lock);
    80000ede:	00013517          	auipc	a0,0x13
    80000ee2:	c7a50513          	addi	a0,a0,-902 # 80013b58 <uart_tx_lock>
    80000ee6:	00000097          	auipc	ra,0x0
    80000eea:	4a8080e7          	jalr	1192(ra) # 8000138e <release>
}
    80000eee:	0001                	nop
    80000ef0:	60e2                	ld	ra,24(sp)
    80000ef2:	6442                	ld	s0,16(sp)
    80000ef4:	6105                	addi	sp,sp,32
    80000ef6:	8082                	ret

0000000080000ef8 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000ef8:	1101                	addi	sp,sp,-32
    80000efa:	ec06                	sd	ra,24(sp)
    80000efc:	e822                	sd	s0,16(sp)
    80000efe:	1000                	addi	s0,sp,32
    80000f00:	87aa                	mv	a5,a0
    80000f02:	fef42623          	sw	a5,-20(s0)
  push_off();
    80000f06:	00000097          	auipc	ra,0x0
    80000f0a:	522080e7          	jalr	1314(ra) # 80001428 <push_off>

  if(panicked){
    80000f0e:	0000b797          	auipc	a5,0xb
    80000f12:	a1278793          	addi	a5,a5,-1518 # 8000b920 <panicked>
    80000f16:	439c                	lw	a5,0(a5)
    80000f18:	2781                	sext.w	a5,a5
    80000f1a:	c391                	beqz	a5,80000f1e <uartputc_sync+0x26>
    for(;;)
    80000f1c:	a001                	j	80000f1c <uartputc_sync+0x24>
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000f1e:	0001                	nop
    80000f20:	100007b7          	lui	a5,0x10000
    80000f24:	0795                	addi	a5,a5,5
    80000f26:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f2a:	0ff7f793          	andi	a5,a5,255
    80000f2e:	2781                	sext.w	a5,a5
    80000f30:	0207f793          	andi	a5,a5,32
    80000f34:	2781                	sext.w	a5,a5
    80000f36:	d7ed                	beqz	a5,80000f20 <uartputc_sync+0x28>
    ;
  WriteReg(THR, c);
    80000f38:	100007b7          	lui	a5,0x10000
    80000f3c:	fec42703          	lw	a4,-20(s0)
    80000f40:	0ff77713          	andi	a4,a4,255
    80000f44:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000f48:	00000097          	auipc	ra,0x0
    80000f4c:	538080e7          	jalr	1336(ra) # 80001480 <pop_off>
}
    80000f50:	0001                	nop
    80000f52:	60e2                	ld	ra,24(sp)
    80000f54:	6442                	ld	s0,16(sp)
    80000f56:	6105                	addi	sp,sp,32
    80000f58:	8082                	ret

0000000080000f5a <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void
uartstart()
{
    80000f5a:	1101                	addi	sp,sp,-32
    80000f5c:	ec06                	sd	ra,24(sp)
    80000f5e:	e822                	sd	s0,16(sp)
    80000f60:	1000                	addi	s0,sp,32
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000f62:	0000b797          	auipc	a5,0xb
    80000f66:	9c678793          	addi	a5,a5,-1594 # 8000b928 <uart_tx_w>
    80000f6a:	6398                	ld	a4,0(a5)
    80000f6c:	0000b797          	auipc	a5,0xb
    80000f70:	9c478793          	addi	a5,a5,-1596 # 8000b930 <uart_tx_r>
    80000f74:	639c                	ld	a5,0(a5)
    80000f76:	06f70a63          	beq	a4,a5,80000fea <uartstart+0x90>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000f7a:	100007b7          	lui	a5,0x10000
    80000f7e:	0795                	addi	a5,a5,5
    80000f80:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f84:	0ff7f793          	andi	a5,a5,255
    80000f88:	2781                	sext.w	a5,a5
    80000f8a:	0207f793          	andi	a5,a5,32
    80000f8e:	2781                	sext.w	a5,a5
    80000f90:	cfb9                	beqz	a5,80000fee <uartstart+0x94>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000f92:	0000b797          	auipc	a5,0xb
    80000f96:	99e78793          	addi	a5,a5,-1634 # 8000b930 <uart_tx_r>
    80000f9a:	639c                	ld	a5,0(a5)
    80000f9c:	8bfd                	andi	a5,a5,31
    80000f9e:	00013717          	auipc	a4,0x13
    80000fa2:	bd270713          	addi	a4,a4,-1070 # 80013b70 <uart_tx_buf>
    80000fa6:	97ba                	add	a5,a5,a4
    80000fa8:	0007c783          	lbu	a5,0(a5)
    80000fac:	fef42623          	sw	a5,-20(s0)
    uart_tx_r += 1;
    80000fb0:	0000b797          	auipc	a5,0xb
    80000fb4:	98078793          	addi	a5,a5,-1664 # 8000b930 <uart_tx_r>
    80000fb8:	639c                	ld	a5,0(a5)
    80000fba:	00178713          	addi	a4,a5,1
    80000fbe:	0000b797          	auipc	a5,0xb
    80000fc2:	97278793          	addi	a5,a5,-1678 # 8000b930 <uart_tx_r>
    80000fc6:	e398                	sd	a4,0(a5)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000fc8:	0000b517          	auipc	a0,0xb
    80000fcc:	96850513          	addi	a0,a0,-1688 # 8000b930 <uart_tx_r>
    80000fd0:	00002097          	auipc	ra,0x2
    80000fd4:	586080e7          	jalr	1414(ra) # 80003556 <wakeup>
    
    WriteReg(THR, c);
    80000fd8:	100007b7          	lui	a5,0x10000
    80000fdc:	fec42703          	lw	a4,-20(s0)
    80000fe0:	0ff77713          	andi	a4,a4,255
    80000fe4:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
  while(1){
    80000fe8:	bfad                	j	80000f62 <uartstart+0x8>
      return;
    80000fea:	0001                	nop
    80000fec:	a011                	j	80000ff0 <uartstart+0x96>
      return;
    80000fee:	0001                	nop
  }
}
    80000ff0:	60e2                	ld	ra,24(sp)
    80000ff2:	6442                	ld	s0,16(sp)
    80000ff4:	6105                	addi	sp,sp,32
    80000ff6:	8082                	ret

0000000080000ff8 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000ff8:	1141                	addi	sp,sp,-16
    80000ffa:	e422                	sd	s0,8(sp)
    80000ffc:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000ffe:	100007b7          	lui	a5,0x10000
    80001002:	0795                	addi	a5,a5,5
    80001004:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80001008:	0ff7f793          	andi	a5,a5,255
    8000100c:	2781                	sext.w	a5,a5
    8000100e:	8b85                	andi	a5,a5,1
    80001010:	2781                	sext.w	a5,a5
    80001012:	cb89                	beqz	a5,80001024 <uartgetc+0x2c>
    // input data is ready.
    return ReadReg(RHR);
    80001014:	100007b7          	lui	a5,0x10000
    80001018:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    8000101c:	0ff7f793          	andi	a5,a5,255
    80001020:	2781                	sext.w	a5,a5
    80001022:	a011                	j	80001026 <uartgetc+0x2e>
  } else {
    return -1;
    80001024:	57fd                	li	a5,-1
  }
}
    80001026:	853e                	mv	a0,a5
    80001028:	6422                	ld	s0,8(sp)
    8000102a:	0141                	addi	sp,sp,16
    8000102c:	8082                	ret

000000008000102e <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    8000102e:	1101                	addi	sp,sp,-32
    80001030:	ec06                	sd	ra,24(sp)
    80001032:	e822                	sd	s0,16(sp)
    80001034:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    80001036:	00000097          	auipc	ra,0x0
    8000103a:	fc2080e7          	jalr	-62(ra) # 80000ff8 <uartgetc>
    8000103e:	87aa                	mv	a5,a0
    80001040:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    80001044:	fec42783          	lw	a5,-20(s0)
    80001048:	0007871b          	sext.w	a4,a5
    8000104c:	57fd                	li	a5,-1
    8000104e:	00f70a63          	beq	a4,a5,80001062 <uartintr+0x34>
      break;
    consoleintr(c);
    80001052:	fec42783          	lw	a5,-20(s0)
    80001056:	853e                	mv	a0,a5
    80001058:	fffff097          	auipc	ra,0xfffff
    8000105c:	59a080e7          	jalr	1434(ra) # 800005f2 <consoleintr>
  while(1){
    80001060:	bfd9                	j	80001036 <uartintr+0x8>
      break;
    80001062:	0001                	nop
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80001064:	00013517          	auipc	a0,0x13
    80001068:	af450513          	addi	a0,a0,-1292 # 80013b58 <uart_tx_lock>
    8000106c:	00000097          	auipc	ra,0x0
    80001070:	2be080e7          	jalr	702(ra) # 8000132a <acquire>
  uartstart();
    80001074:	00000097          	auipc	ra,0x0
    80001078:	ee6080e7          	jalr	-282(ra) # 80000f5a <uartstart>
  release(&uart_tx_lock);
    8000107c:	00013517          	auipc	a0,0x13
    80001080:	adc50513          	addi	a0,a0,-1316 # 80013b58 <uart_tx_lock>
    80001084:	00000097          	auipc	ra,0x0
    80001088:	30a080e7          	jalr	778(ra) # 8000138e <release>
}
    8000108c:	0001                	nop
    8000108e:	60e2                	ld	ra,24(sp)
    80001090:	6442                	ld	s0,16(sp)
    80001092:	6105                	addi	sp,sp,32
    80001094:	8082                	ret

0000000080001096 <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    80001096:	1141                	addi	sp,sp,-16
    80001098:	e406                	sd	ra,8(sp)
    8000109a:	e022                	sd	s0,0(sp)
    8000109c:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    8000109e:	0000a597          	auipc	a1,0xa
    800010a2:	fa258593          	addi	a1,a1,-94 # 8000b040 <etext+0x40>
    800010a6:	00013517          	auipc	a0,0x13
    800010aa:	aea50513          	addi	a0,a0,-1302 # 80013b90 <kmem>
    800010ae:	00000097          	auipc	ra,0x0
    800010b2:	24c080e7          	jalr	588(ra) # 800012fa <initlock>
  freerange(end, (void*)PHYSTOP);
    800010b6:	08100793          	li	a5,129
    800010ba:	01879593          	slli	a1,a5,0x18
    800010be:	00024517          	auipc	a0,0x24
    800010c2:	e7250513          	addi	a0,a0,-398 # 80024f30 <end>
    800010c6:	00000097          	auipc	ra,0x0
    800010ca:	012080e7          	jalr	18(ra) # 800010d8 <freerange>
}
    800010ce:	0001                	nop
    800010d0:	60a2                	ld	ra,8(sp)
    800010d2:	6402                	ld	s0,0(sp)
    800010d4:	0141                	addi	sp,sp,16
    800010d6:	8082                	ret

00000000800010d8 <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    800010d8:	7179                	addi	sp,sp,-48
    800010da:	f406                	sd	ra,40(sp)
    800010dc:	f022                	sd	s0,32(sp)
    800010de:	1800                	addi	s0,sp,48
    800010e0:	fca43c23          	sd	a0,-40(s0)
    800010e4:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    800010e8:	fd843703          	ld	a4,-40(s0)
    800010ec:	6785                	lui	a5,0x1
    800010ee:	17fd                	addi	a5,a5,-1
    800010f0:	973e                	add	a4,a4,a5
    800010f2:	77fd                	lui	a5,0xfffff
    800010f4:	8ff9                	and	a5,a5,a4
    800010f6:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800010fa:	a829                	j	80001114 <freerange+0x3c>
    kfree(p);
    800010fc:	fe843503          	ld	a0,-24(s0)
    80001100:	00000097          	auipc	ra,0x0
    80001104:	030080e7          	jalr	48(ra) # 80001130 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001108:	fe843703          	ld	a4,-24(s0)
    8000110c:	6785                	lui	a5,0x1
    8000110e:	97ba                	add	a5,a5,a4
    80001110:	fef43423          	sd	a5,-24(s0)
    80001114:	fe843703          	ld	a4,-24(s0)
    80001118:	6785                	lui	a5,0x1
    8000111a:	97ba                	add	a5,a5,a4
    8000111c:	fd043703          	ld	a4,-48(s0)
    80001120:	fcf77ee3          	bgeu	a4,a5,800010fc <freerange+0x24>
}
    80001124:	0001                	nop
    80001126:	0001                	nop
    80001128:	70a2                	ld	ra,40(sp)
    8000112a:	7402                	ld	s0,32(sp)
    8000112c:	6145                	addi	sp,sp,48
    8000112e:	8082                	ret

0000000080001130 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80001130:	7179                	addi	sp,sp,-48
    80001132:	f406                	sd	ra,40(sp)
    80001134:	f022                	sd	s0,32(sp)
    80001136:	1800                	addi	s0,sp,48
    80001138:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    8000113c:	fd843703          	ld	a4,-40(s0)
    80001140:	6785                	lui	a5,0x1
    80001142:	17fd                	addi	a5,a5,-1
    80001144:	8ff9                	and	a5,a5,a4
    80001146:	e385                	bnez	a5,80001166 <kfree+0x36>
    80001148:	fd843703          	ld	a4,-40(s0)
    8000114c:	00024797          	auipc	a5,0x24
    80001150:	de478793          	addi	a5,a5,-540 # 80024f30 <end>
    80001154:	00f76963          	bltu	a4,a5,80001166 <kfree+0x36>
    80001158:	fd843703          	ld	a4,-40(s0)
    8000115c:	08100793          	li	a5,129
    80001160:	07e2                	slli	a5,a5,0x18
    80001162:	00f76a63          	bltu	a4,a5,80001176 <kfree+0x46>
    panic("kfree");
    80001166:	0000a517          	auipc	a0,0xa
    8000116a:	ee250513          	addi	a0,a0,-286 # 8000b048 <etext+0x48>
    8000116e:	00000097          	auipc	ra,0x0
    80001172:	b1e080e7          	jalr	-1250(ra) # 80000c8c <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80001176:	6605                	lui	a2,0x1
    80001178:	4585                	li	a1,1
    8000117a:	fd843503          	ld	a0,-40(s0)
    8000117e:	00000097          	auipc	ra,0x0
    80001182:	380080e7          	jalr	896(ra) # 800014fe <memset>

  r = (struct run*)pa;
    80001186:	fd843783          	ld	a5,-40(s0)
    8000118a:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    8000118e:	00013517          	auipc	a0,0x13
    80001192:	a0250513          	addi	a0,a0,-1534 # 80013b90 <kmem>
    80001196:	00000097          	auipc	ra,0x0
    8000119a:	194080e7          	jalr	404(ra) # 8000132a <acquire>
  r->next = kmem.freelist;
    8000119e:	00013797          	auipc	a5,0x13
    800011a2:	9f278793          	addi	a5,a5,-1550 # 80013b90 <kmem>
    800011a6:	6f98                	ld	a4,24(a5)
    800011a8:	fe843783          	ld	a5,-24(s0)
    800011ac:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    800011ae:	00013797          	auipc	a5,0x13
    800011b2:	9e278793          	addi	a5,a5,-1566 # 80013b90 <kmem>
    800011b6:	fe843703          	ld	a4,-24(s0)
    800011ba:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    800011bc:	00013517          	auipc	a0,0x13
    800011c0:	9d450513          	addi	a0,a0,-1580 # 80013b90 <kmem>
    800011c4:	00000097          	auipc	ra,0x0
    800011c8:	1ca080e7          	jalr	458(ra) # 8000138e <release>
}
    800011cc:	0001                	nop
    800011ce:	70a2                	ld	ra,40(sp)
    800011d0:	7402                	ld	s0,32(sp)
    800011d2:	6145                	addi	sp,sp,48
    800011d4:	8082                	ret

00000000800011d6 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    800011d6:	1101                	addi	sp,sp,-32
    800011d8:	ec06                	sd	ra,24(sp)
    800011da:	e822                	sd	s0,16(sp)
    800011dc:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    800011de:	00013517          	auipc	a0,0x13
    800011e2:	9b250513          	addi	a0,a0,-1614 # 80013b90 <kmem>
    800011e6:	00000097          	auipc	ra,0x0
    800011ea:	144080e7          	jalr	324(ra) # 8000132a <acquire>
  r = kmem.freelist;
    800011ee:	00013797          	auipc	a5,0x13
    800011f2:	9a278793          	addi	a5,a5,-1630 # 80013b90 <kmem>
    800011f6:	6f9c                	ld	a5,24(a5)
    800011f8:	fef43423          	sd	a5,-24(s0)
  if(r)
    800011fc:	fe843783          	ld	a5,-24(s0)
    80001200:	cb89                	beqz	a5,80001212 <kalloc+0x3c>
    kmem.freelist = r->next;
    80001202:	fe843783          	ld	a5,-24(s0)
    80001206:	6398                	ld	a4,0(a5)
    80001208:	00013797          	auipc	a5,0x13
    8000120c:	98878793          	addi	a5,a5,-1656 # 80013b90 <kmem>
    80001210:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001212:	00013517          	auipc	a0,0x13
    80001216:	97e50513          	addi	a0,a0,-1666 # 80013b90 <kmem>
    8000121a:	00000097          	auipc	ra,0x0
    8000121e:	174080e7          	jalr	372(ra) # 8000138e <release>

  if(r)
    80001222:	fe843783          	ld	a5,-24(s0)
    80001226:	cb89                	beqz	a5,80001238 <kalloc+0x62>
    memset((char*)r, 5, PGSIZE); // fill with junk
    80001228:	6605                	lui	a2,0x1
    8000122a:	4595                	li	a1,5
    8000122c:	fe843503          	ld	a0,-24(s0)
    80001230:	00000097          	auipc	ra,0x0
    80001234:	2ce080e7          	jalr	718(ra) # 800014fe <memset>
  return (void*)r;
    80001238:	fe843783          	ld	a5,-24(s0)
}
    8000123c:	853e                	mv	a0,a5
    8000123e:	60e2                	ld	ra,24(sp)
    80001240:	6442                	ld	s0,16(sp)
    80001242:	6105                	addi	sp,sp,32
    80001244:	8082                	ret

0000000080001246 <r_sstatus>:
{
    80001246:	1101                	addi	sp,sp,-32
    80001248:	ec22                	sd	s0,24(sp)
    8000124a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000124c:	100027f3          	csrr	a5,sstatus
    80001250:	fef43423          	sd	a5,-24(s0)
  return x;
    80001254:	fe843783          	ld	a5,-24(s0)
}
    80001258:	853e                	mv	a0,a5
    8000125a:	6462                	ld	s0,24(sp)
    8000125c:	6105                	addi	sp,sp,32
    8000125e:	8082                	ret

0000000080001260 <w_sstatus>:
{
    80001260:	1101                	addi	sp,sp,-32
    80001262:	ec22                	sd	s0,24(sp)
    80001264:	1000                	addi	s0,sp,32
    80001266:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000126a:	fe843783          	ld	a5,-24(s0)
    8000126e:	10079073          	csrw	sstatus,a5
}
    80001272:	0001                	nop
    80001274:	6462                	ld	s0,24(sp)
    80001276:	6105                	addi	sp,sp,32
    80001278:	8082                	ret

000000008000127a <intr_on>:
{
    8000127a:	1141                	addi	sp,sp,-16
    8000127c:	e406                	sd	ra,8(sp)
    8000127e:	e022                	sd	s0,0(sp)
    80001280:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001282:	00000097          	auipc	ra,0x0
    80001286:	fc4080e7          	jalr	-60(ra) # 80001246 <r_sstatus>
    8000128a:	87aa                	mv	a5,a0
    8000128c:	0027e793          	ori	a5,a5,2
    80001290:	853e                	mv	a0,a5
    80001292:	00000097          	auipc	ra,0x0
    80001296:	fce080e7          	jalr	-50(ra) # 80001260 <w_sstatus>
}
    8000129a:	0001                	nop
    8000129c:	60a2                	ld	ra,8(sp)
    8000129e:	6402                	ld	s0,0(sp)
    800012a0:	0141                	addi	sp,sp,16
    800012a2:	8082                	ret

00000000800012a4 <intr_off>:
{
    800012a4:	1141                	addi	sp,sp,-16
    800012a6:	e406                	sd	ra,8(sp)
    800012a8:	e022                	sd	s0,0(sp)
    800012aa:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800012ac:	00000097          	auipc	ra,0x0
    800012b0:	f9a080e7          	jalr	-102(ra) # 80001246 <r_sstatus>
    800012b4:	87aa                	mv	a5,a0
    800012b6:	9bf5                	andi	a5,a5,-3
    800012b8:	853e                	mv	a0,a5
    800012ba:	00000097          	auipc	ra,0x0
    800012be:	fa6080e7          	jalr	-90(ra) # 80001260 <w_sstatus>
}
    800012c2:	0001                	nop
    800012c4:	60a2                	ld	ra,8(sp)
    800012c6:	6402                	ld	s0,0(sp)
    800012c8:	0141                	addi	sp,sp,16
    800012ca:	8082                	ret

00000000800012cc <intr_get>:
{
    800012cc:	1101                	addi	sp,sp,-32
    800012ce:	ec06                	sd	ra,24(sp)
    800012d0:	e822                	sd	s0,16(sp)
    800012d2:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800012d4:	00000097          	auipc	ra,0x0
    800012d8:	f72080e7          	jalr	-142(ra) # 80001246 <r_sstatus>
    800012dc:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800012e0:	fe843783          	ld	a5,-24(s0)
    800012e4:	8b89                	andi	a5,a5,2
    800012e6:	00f037b3          	snez	a5,a5
    800012ea:	0ff7f793          	andi	a5,a5,255
    800012ee:	2781                	sext.w	a5,a5
}
    800012f0:	853e                	mv	a0,a5
    800012f2:	60e2                	ld	ra,24(sp)
    800012f4:	6442                	ld	s0,16(sp)
    800012f6:	6105                	addi	sp,sp,32
    800012f8:	8082                	ret

00000000800012fa <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800012fa:	1101                	addi	sp,sp,-32
    800012fc:	ec22                	sd	s0,24(sp)
    800012fe:	1000                	addi	s0,sp,32
    80001300:	fea43423          	sd	a0,-24(s0)
    80001304:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    80001308:	fe843783          	ld	a5,-24(s0)
    8000130c:	fe043703          	ld	a4,-32(s0)
    80001310:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80001312:	fe843783          	ld	a5,-24(s0)
    80001316:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    8000131a:	fe843783          	ld	a5,-24(s0)
    8000131e:	0007b823          	sd	zero,16(a5)
}
    80001322:	0001                	nop
    80001324:	6462                	ld	s0,24(sp)
    80001326:	6105                	addi	sp,sp,32
    80001328:	8082                	ret

000000008000132a <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    8000132a:	1101                	addi	sp,sp,-32
    8000132c:	ec06                	sd	ra,24(sp)
    8000132e:	e822                	sd	s0,16(sp)
    80001330:	1000                	addi	s0,sp,32
    80001332:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    80001336:	00000097          	auipc	ra,0x0
    8000133a:	0f2080e7          	jalr	242(ra) # 80001428 <push_off>
  if(holding(lk))
    8000133e:	fe843503          	ld	a0,-24(s0)
    80001342:	00000097          	auipc	ra,0x0
    80001346:	0a2080e7          	jalr	162(ra) # 800013e4 <holding>
    8000134a:	87aa                	mv	a5,a0
    8000134c:	cb89                	beqz	a5,8000135e <acquire+0x34>
    panic("acquire");
    8000134e:	0000a517          	auipc	a0,0xa
    80001352:	d0250513          	addi	a0,a0,-766 # 8000b050 <etext+0x50>
    80001356:	00000097          	auipc	ra,0x0
    8000135a:	936080e7          	jalr	-1738(ra) # 80000c8c <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000135e:	0001                	nop
    80001360:	fe843783          	ld	a5,-24(s0)
    80001364:	4705                	li	a4,1
    80001366:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    8000136a:	0007079b          	sext.w	a5,a4
    8000136e:	fbed                	bnez	a5,80001360 <acquire+0x36>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80001370:	0ff0000f          	fence

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    80001374:	00001097          	auipc	ra,0x1
    80001378:	56a080e7          	jalr	1386(ra) # 800028de <mycpu>
    8000137c:	872a                	mv	a4,a0
    8000137e:	fe843783          	ld	a5,-24(s0)
    80001382:	eb98                	sd	a4,16(a5)
}
    80001384:	0001                	nop
    80001386:	60e2                	ld	ra,24(sp)
    80001388:	6442                	ld	s0,16(sp)
    8000138a:	6105                	addi	sp,sp,32
    8000138c:	8082                	ret

000000008000138e <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    8000138e:	1101                	addi	sp,sp,-32
    80001390:	ec06                	sd	ra,24(sp)
    80001392:	e822                	sd	s0,16(sp)
    80001394:	1000                	addi	s0,sp,32
    80001396:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    8000139a:	fe843503          	ld	a0,-24(s0)
    8000139e:	00000097          	auipc	ra,0x0
    800013a2:	046080e7          	jalr	70(ra) # 800013e4 <holding>
    800013a6:	87aa                	mv	a5,a0
    800013a8:	eb89                	bnez	a5,800013ba <release+0x2c>
    panic("release");
    800013aa:	0000a517          	auipc	a0,0xa
    800013ae:	cae50513          	addi	a0,a0,-850 # 8000b058 <etext+0x58>
    800013b2:	00000097          	auipc	ra,0x0
    800013b6:	8da080e7          	jalr	-1830(ra) # 80000c8c <panic>

  lk->cpu = 0;
    800013ba:	fe843783          	ld	a5,-24(s0)
    800013be:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800013c2:	0ff0000f          	fence
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    800013c6:	fe843783          	ld	a5,-24(s0)
    800013ca:	0f50000f          	fence	iorw,ow
    800013ce:	0807a02f          	amoswap.w	zero,zero,(a5)

  pop_off();
    800013d2:	00000097          	auipc	ra,0x0
    800013d6:	0ae080e7          	jalr	174(ra) # 80001480 <pop_off>
}
    800013da:	0001                	nop
    800013dc:	60e2                	ld	ra,24(sp)
    800013de:	6442                	ld	s0,16(sp)
    800013e0:	6105                	addi	sp,sp,32
    800013e2:	8082                	ret

00000000800013e4 <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    800013e4:	7139                	addi	sp,sp,-64
    800013e6:	fc06                	sd	ra,56(sp)
    800013e8:	f822                	sd	s0,48(sp)
    800013ea:	f426                	sd	s1,40(sp)
    800013ec:	0080                	addi	s0,sp,64
    800013ee:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800013f2:	fc843783          	ld	a5,-56(s0)
    800013f6:	439c                	lw	a5,0(a5)
    800013f8:	cf89                	beqz	a5,80001412 <holding+0x2e>
    800013fa:	fc843783          	ld	a5,-56(s0)
    800013fe:	6b84                	ld	s1,16(a5)
    80001400:	00001097          	auipc	ra,0x1
    80001404:	4de080e7          	jalr	1246(ra) # 800028de <mycpu>
    80001408:	87aa                	mv	a5,a0
    8000140a:	00f49463          	bne	s1,a5,80001412 <holding+0x2e>
    8000140e:	4785                	li	a5,1
    80001410:	a011                	j	80001414 <holding+0x30>
    80001412:	4781                	li	a5,0
    80001414:	fcf42e23          	sw	a5,-36(s0)
  return r;
    80001418:	fdc42783          	lw	a5,-36(s0)
}
    8000141c:	853e                	mv	a0,a5
    8000141e:	70e2                	ld	ra,56(sp)
    80001420:	7442                	ld	s0,48(sp)
    80001422:	74a2                	ld	s1,40(sp)
    80001424:	6121                	addi	sp,sp,64
    80001426:	8082                	ret

0000000080001428 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80001428:	1101                	addi	sp,sp,-32
    8000142a:	ec06                	sd	ra,24(sp)
    8000142c:	e822                	sd	s0,16(sp)
    8000142e:	1000                	addi	s0,sp,32
  int old = intr_get();
    80001430:	00000097          	auipc	ra,0x0
    80001434:	e9c080e7          	jalr	-356(ra) # 800012cc <intr_get>
    80001438:	87aa                	mv	a5,a0
    8000143a:	fef42623          	sw	a5,-20(s0)

  intr_off();
    8000143e:	00000097          	auipc	ra,0x0
    80001442:	e66080e7          	jalr	-410(ra) # 800012a4 <intr_off>
  if(mycpu()->noff == 0)
    80001446:	00001097          	auipc	ra,0x1
    8000144a:	498080e7          	jalr	1176(ra) # 800028de <mycpu>
    8000144e:	87aa                	mv	a5,a0
    80001450:	5fbc                	lw	a5,120(a5)
    80001452:	eb89                	bnez	a5,80001464 <push_off+0x3c>
    mycpu()->intena = old;
    80001454:	00001097          	auipc	ra,0x1
    80001458:	48a080e7          	jalr	1162(ra) # 800028de <mycpu>
    8000145c:	872a                	mv	a4,a0
    8000145e:	fec42783          	lw	a5,-20(s0)
    80001462:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    80001464:	00001097          	auipc	ra,0x1
    80001468:	47a080e7          	jalr	1146(ra) # 800028de <mycpu>
    8000146c:	87aa                	mv	a5,a0
    8000146e:	5fb8                	lw	a4,120(a5)
    80001470:	2705                	addiw	a4,a4,1
    80001472:	2701                	sext.w	a4,a4
    80001474:	dfb8                	sw	a4,120(a5)
}
    80001476:	0001                	nop
    80001478:	60e2                	ld	ra,24(sp)
    8000147a:	6442                	ld	s0,16(sp)
    8000147c:	6105                	addi	sp,sp,32
    8000147e:	8082                	ret

0000000080001480 <pop_off>:

void
pop_off(void)
{
    80001480:	1101                	addi	sp,sp,-32
    80001482:	ec06                	sd	ra,24(sp)
    80001484:	e822                	sd	s0,16(sp)
    80001486:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    80001488:	00001097          	auipc	ra,0x1
    8000148c:	456080e7          	jalr	1110(ra) # 800028de <mycpu>
    80001490:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    80001494:	00000097          	auipc	ra,0x0
    80001498:	e38080e7          	jalr	-456(ra) # 800012cc <intr_get>
    8000149c:	87aa                	mv	a5,a0
    8000149e:	cb89                	beqz	a5,800014b0 <pop_off+0x30>
    panic("pop_off - interruptible");
    800014a0:	0000a517          	auipc	a0,0xa
    800014a4:	bc050513          	addi	a0,a0,-1088 # 8000b060 <etext+0x60>
    800014a8:	fffff097          	auipc	ra,0xfffff
    800014ac:	7e4080e7          	jalr	2020(ra) # 80000c8c <panic>
  if(c->noff < 1)
    800014b0:	fe843783          	ld	a5,-24(s0)
    800014b4:	5fbc                	lw	a5,120(a5)
    800014b6:	00f04a63          	bgtz	a5,800014ca <pop_off+0x4a>
    panic("pop_off");
    800014ba:	0000a517          	auipc	a0,0xa
    800014be:	bbe50513          	addi	a0,a0,-1090 # 8000b078 <etext+0x78>
    800014c2:	fffff097          	auipc	ra,0xfffff
    800014c6:	7ca080e7          	jalr	1994(ra) # 80000c8c <panic>
  c->noff -= 1;
    800014ca:	fe843783          	ld	a5,-24(s0)
    800014ce:	5fbc                	lw	a5,120(a5)
    800014d0:	37fd                	addiw	a5,a5,-1
    800014d2:	0007871b          	sext.w	a4,a5
    800014d6:	fe843783          	ld	a5,-24(s0)
    800014da:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    800014dc:	fe843783          	ld	a5,-24(s0)
    800014e0:	5fbc                	lw	a5,120(a5)
    800014e2:	eb89                	bnez	a5,800014f4 <pop_off+0x74>
    800014e4:	fe843783          	ld	a5,-24(s0)
    800014e8:	5ffc                	lw	a5,124(a5)
    800014ea:	c789                	beqz	a5,800014f4 <pop_off+0x74>
    intr_on();
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	d8e080e7          	jalr	-626(ra) # 8000127a <intr_on>
}
    800014f4:	0001                	nop
    800014f6:	60e2                	ld	ra,24(sp)
    800014f8:	6442                	ld	s0,16(sp)
    800014fa:	6105                	addi	sp,sp,32
    800014fc:	8082                	ret

00000000800014fe <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    800014fe:	7179                	addi	sp,sp,-48
    80001500:	f422                	sd	s0,40(sp)
    80001502:	1800                	addi	s0,sp,48
    80001504:	fca43c23          	sd	a0,-40(s0)
    80001508:	87ae                	mv	a5,a1
    8000150a:	8732                	mv	a4,a2
    8000150c:	fcf42a23          	sw	a5,-44(s0)
    80001510:	87ba                	mv	a5,a4
    80001512:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    80001516:	fd843783          	ld	a5,-40(s0)
    8000151a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    8000151e:	fe042623          	sw	zero,-20(s0)
    80001522:	a00d                	j	80001544 <memset+0x46>
    cdst[i] = c;
    80001524:	fec42783          	lw	a5,-20(s0)
    80001528:	fe043703          	ld	a4,-32(s0)
    8000152c:	97ba                	add	a5,a5,a4
    8000152e:	fd442703          	lw	a4,-44(s0)
    80001532:	0ff77713          	andi	a4,a4,255
    80001536:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    8000153a:	fec42783          	lw	a5,-20(s0)
    8000153e:	2785                	addiw	a5,a5,1
    80001540:	fef42623          	sw	a5,-20(s0)
    80001544:	fec42703          	lw	a4,-20(s0)
    80001548:	fd042783          	lw	a5,-48(s0)
    8000154c:	2781                	sext.w	a5,a5
    8000154e:	fcf76be3          	bltu	a4,a5,80001524 <memset+0x26>
  }
  return dst;
    80001552:	fd843783          	ld	a5,-40(s0)
}
    80001556:	853e                	mv	a0,a5
    80001558:	7422                	ld	s0,40(sp)
    8000155a:	6145                	addi	sp,sp,48
    8000155c:	8082                	ret

000000008000155e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000155e:	7139                	addi	sp,sp,-64
    80001560:	fc22                	sd	s0,56(sp)
    80001562:	0080                	addi	s0,sp,64
    80001564:	fca43c23          	sd	a0,-40(s0)
    80001568:	fcb43823          	sd	a1,-48(s0)
    8000156c:	87b2                	mv	a5,a2
    8000156e:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    80001572:	fd843783          	ld	a5,-40(s0)
    80001576:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    8000157a:	fd043783          	ld	a5,-48(s0)
    8000157e:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    80001582:	a0a1                	j	800015ca <memcmp+0x6c>
    if(*s1 != *s2)
    80001584:	fe843783          	ld	a5,-24(s0)
    80001588:	0007c703          	lbu	a4,0(a5)
    8000158c:	fe043783          	ld	a5,-32(s0)
    80001590:	0007c783          	lbu	a5,0(a5)
    80001594:	02f70163          	beq	a4,a5,800015b6 <memcmp+0x58>
      return *s1 - *s2;
    80001598:	fe843783          	ld	a5,-24(s0)
    8000159c:	0007c783          	lbu	a5,0(a5)
    800015a0:	0007871b          	sext.w	a4,a5
    800015a4:	fe043783          	ld	a5,-32(s0)
    800015a8:	0007c783          	lbu	a5,0(a5)
    800015ac:	2781                	sext.w	a5,a5
    800015ae:	40f707bb          	subw	a5,a4,a5
    800015b2:	2781                	sext.w	a5,a5
    800015b4:	a01d                	j	800015da <memcmp+0x7c>
    s1++, s2++;
    800015b6:	fe843783          	ld	a5,-24(s0)
    800015ba:	0785                	addi	a5,a5,1
    800015bc:	fef43423          	sd	a5,-24(s0)
    800015c0:	fe043783          	ld	a5,-32(s0)
    800015c4:	0785                	addi	a5,a5,1
    800015c6:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800015ca:	fcc42783          	lw	a5,-52(s0)
    800015ce:	fff7871b          	addiw	a4,a5,-1
    800015d2:	fce42623          	sw	a4,-52(s0)
    800015d6:	f7dd                	bnez	a5,80001584 <memcmp+0x26>
  }

  return 0;
    800015d8:	4781                	li	a5,0
}
    800015da:	853e                	mv	a0,a5
    800015dc:	7462                	ld	s0,56(sp)
    800015de:	6121                	addi	sp,sp,64
    800015e0:	8082                	ret

00000000800015e2 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800015e2:	7139                	addi	sp,sp,-64
    800015e4:	fc22                	sd	s0,56(sp)
    800015e6:	0080                	addi	s0,sp,64
    800015e8:	fca43c23          	sd	a0,-40(s0)
    800015ec:	fcb43823          	sd	a1,-48(s0)
    800015f0:	87b2                	mv	a5,a2
    800015f2:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  if(n == 0)
    800015f6:	fcc42783          	lw	a5,-52(s0)
    800015fa:	2781                	sext.w	a5,a5
    800015fc:	e781                	bnez	a5,80001604 <memmove+0x22>
    return dst;
    800015fe:	fd843783          	ld	a5,-40(s0)
    80001602:	a855                	j	800016b6 <memmove+0xd4>
  
  s = src;
    80001604:	fd043783          	ld	a5,-48(s0)
    80001608:	fef43423          	sd	a5,-24(s0)
  d = dst;
    8000160c:	fd843783          	ld	a5,-40(s0)
    80001610:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    80001614:	fe843703          	ld	a4,-24(s0)
    80001618:	fe043783          	ld	a5,-32(s0)
    8000161c:	08f77463          	bgeu	a4,a5,800016a4 <memmove+0xc2>
    80001620:	fcc46783          	lwu	a5,-52(s0)
    80001624:	fe843703          	ld	a4,-24(s0)
    80001628:	97ba                	add	a5,a5,a4
    8000162a:	fe043703          	ld	a4,-32(s0)
    8000162e:	06f77b63          	bgeu	a4,a5,800016a4 <memmove+0xc2>
    s += n;
    80001632:	fcc46783          	lwu	a5,-52(s0)
    80001636:	fe843703          	ld	a4,-24(s0)
    8000163a:	97ba                	add	a5,a5,a4
    8000163c:	fef43423          	sd	a5,-24(s0)
    d += n;
    80001640:	fcc46783          	lwu	a5,-52(s0)
    80001644:	fe043703          	ld	a4,-32(s0)
    80001648:	97ba                	add	a5,a5,a4
    8000164a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    8000164e:	a01d                	j	80001674 <memmove+0x92>
      *--d = *--s;
    80001650:	fe843783          	ld	a5,-24(s0)
    80001654:	17fd                	addi	a5,a5,-1
    80001656:	fef43423          	sd	a5,-24(s0)
    8000165a:	fe043783          	ld	a5,-32(s0)
    8000165e:	17fd                	addi	a5,a5,-1
    80001660:	fef43023          	sd	a5,-32(s0)
    80001664:	fe843783          	ld	a5,-24(s0)
    80001668:	0007c703          	lbu	a4,0(a5)
    8000166c:	fe043783          	ld	a5,-32(s0)
    80001670:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    80001674:	fcc42783          	lw	a5,-52(s0)
    80001678:	fff7871b          	addiw	a4,a5,-1
    8000167c:	fce42623          	sw	a4,-52(s0)
    80001680:	fbe1                	bnez	a5,80001650 <memmove+0x6e>
  if(s < d && s + n > d){
    80001682:	a805                	j	800016b2 <memmove+0xd0>
  } else
    while(n-- > 0)
      *d++ = *s++;
    80001684:	fe843703          	ld	a4,-24(s0)
    80001688:	00170793          	addi	a5,a4,1
    8000168c:	fef43423          	sd	a5,-24(s0)
    80001690:	fe043783          	ld	a5,-32(s0)
    80001694:	00178693          	addi	a3,a5,1
    80001698:	fed43023          	sd	a3,-32(s0)
    8000169c:	00074703          	lbu	a4,0(a4)
    800016a0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800016a4:	fcc42783          	lw	a5,-52(s0)
    800016a8:	fff7871b          	addiw	a4,a5,-1
    800016ac:	fce42623          	sw	a4,-52(s0)
    800016b0:	fbf1                	bnez	a5,80001684 <memmove+0xa2>

  return dst;
    800016b2:	fd843783          	ld	a5,-40(s0)
}
    800016b6:	853e                	mv	a0,a5
    800016b8:	7462                	ld	s0,56(sp)
    800016ba:	6121                	addi	sp,sp,64
    800016bc:	8082                	ret

00000000800016be <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800016be:	7179                	addi	sp,sp,-48
    800016c0:	f406                	sd	ra,40(sp)
    800016c2:	f022                	sd	s0,32(sp)
    800016c4:	1800                	addi	s0,sp,48
    800016c6:	fea43423          	sd	a0,-24(s0)
    800016ca:	feb43023          	sd	a1,-32(s0)
    800016ce:	87b2                	mv	a5,a2
    800016d0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    800016d4:	fdc42783          	lw	a5,-36(s0)
    800016d8:	863e                	mv	a2,a5
    800016da:	fe043583          	ld	a1,-32(s0)
    800016de:	fe843503          	ld	a0,-24(s0)
    800016e2:	00000097          	auipc	ra,0x0
    800016e6:	f00080e7          	jalr	-256(ra) # 800015e2 <memmove>
    800016ea:	87aa                	mv	a5,a0
}
    800016ec:	853e                	mv	a0,a5
    800016ee:	70a2                	ld	ra,40(sp)
    800016f0:	7402                	ld	s0,32(sp)
    800016f2:	6145                	addi	sp,sp,48
    800016f4:	8082                	ret

00000000800016f6 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    800016f6:	7179                	addi	sp,sp,-48
    800016f8:	f422                	sd	s0,40(sp)
    800016fa:	1800                	addi	s0,sp,48
    800016fc:	fea43423          	sd	a0,-24(s0)
    80001700:	feb43023          	sd	a1,-32(s0)
    80001704:	87b2                	mv	a5,a2
    80001706:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    8000170a:	a005                	j	8000172a <strncmp+0x34>
    n--, p++, q++;
    8000170c:	fdc42783          	lw	a5,-36(s0)
    80001710:	37fd                	addiw	a5,a5,-1
    80001712:	fcf42e23          	sw	a5,-36(s0)
    80001716:	fe843783          	ld	a5,-24(s0)
    8000171a:	0785                	addi	a5,a5,1
    8000171c:	fef43423          	sd	a5,-24(s0)
    80001720:	fe043783          	ld	a5,-32(s0)
    80001724:	0785                	addi	a5,a5,1
    80001726:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    8000172a:	fdc42783          	lw	a5,-36(s0)
    8000172e:	2781                	sext.w	a5,a5
    80001730:	c385                	beqz	a5,80001750 <strncmp+0x5a>
    80001732:	fe843783          	ld	a5,-24(s0)
    80001736:	0007c783          	lbu	a5,0(a5)
    8000173a:	cb99                	beqz	a5,80001750 <strncmp+0x5a>
    8000173c:	fe843783          	ld	a5,-24(s0)
    80001740:	0007c703          	lbu	a4,0(a5)
    80001744:	fe043783          	ld	a5,-32(s0)
    80001748:	0007c783          	lbu	a5,0(a5)
    8000174c:	fcf700e3          	beq	a4,a5,8000170c <strncmp+0x16>
  if(n == 0)
    80001750:	fdc42783          	lw	a5,-36(s0)
    80001754:	2781                	sext.w	a5,a5
    80001756:	e399                	bnez	a5,8000175c <strncmp+0x66>
    return 0;
    80001758:	4781                	li	a5,0
    8000175a:	a839                	j	80001778 <strncmp+0x82>
  return (uchar)*p - (uchar)*q;
    8000175c:	fe843783          	ld	a5,-24(s0)
    80001760:	0007c783          	lbu	a5,0(a5)
    80001764:	0007871b          	sext.w	a4,a5
    80001768:	fe043783          	ld	a5,-32(s0)
    8000176c:	0007c783          	lbu	a5,0(a5)
    80001770:	2781                	sext.w	a5,a5
    80001772:	40f707bb          	subw	a5,a4,a5
    80001776:	2781                	sext.w	a5,a5
}
    80001778:	853e                	mv	a0,a5
    8000177a:	7422                	ld	s0,40(sp)
    8000177c:	6145                	addi	sp,sp,48
    8000177e:	8082                	ret

0000000080001780 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80001780:	7139                	addi	sp,sp,-64
    80001782:	fc22                	sd	s0,56(sp)
    80001784:	0080                	addi	s0,sp,64
    80001786:	fca43c23          	sd	a0,-40(s0)
    8000178a:	fcb43823          	sd	a1,-48(s0)
    8000178e:	87b2                	mv	a5,a2
    80001790:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    80001794:	fd843783          	ld	a5,-40(s0)
    80001798:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000179c:	0001                	nop
    8000179e:	fcc42783          	lw	a5,-52(s0)
    800017a2:	fff7871b          	addiw	a4,a5,-1
    800017a6:	fce42623          	sw	a4,-52(s0)
    800017aa:	02f05e63          	blez	a5,800017e6 <strncpy+0x66>
    800017ae:	fd043703          	ld	a4,-48(s0)
    800017b2:	00170793          	addi	a5,a4,1
    800017b6:	fcf43823          	sd	a5,-48(s0)
    800017ba:	fd843783          	ld	a5,-40(s0)
    800017be:	00178693          	addi	a3,a5,1
    800017c2:	fcd43c23          	sd	a3,-40(s0)
    800017c6:	00074703          	lbu	a4,0(a4)
    800017ca:	00e78023          	sb	a4,0(a5)
    800017ce:	0007c783          	lbu	a5,0(a5)
    800017d2:	f7f1                	bnez	a5,8000179e <strncpy+0x1e>
    ;
  while(n-- > 0)
    800017d4:	a809                	j	800017e6 <strncpy+0x66>
    *s++ = 0;
    800017d6:	fd843783          	ld	a5,-40(s0)
    800017da:	00178713          	addi	a4,a5,1
    800017de:	fce43c23          	sd	a4,-40(s0)
    800017e2:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    800017e6:	fcc42783          	lw	a5,-52(s0)
    800017ea:	fff7871b          	addiw	a4,a5,-1
    800017ee:	fce42623          	sw	a4,-52(s0)
    800017f2:	fef042e3          	bgtz	a5,800017d6 <strncpy+0x56>
  return os;
    800017f6:	fe843783          	ld	a5,-24(s0)
}
    800017fa:	853e                	mv	a0,a5
    800017fc:	7462                	ld	s0,56(sp)
    800017fe:	6121                	addi	sp,sp,64
    80001800:	8082                	ret

0000000080001802 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80001802:	7139                	addi	sp,sp,-64
    80001804:	fc22                	sd	s0,56(sp)
    80001806:	0080                	addi	s0,sp,64
    80001808:	fca43c23          	sd	a0,-40(s0)
    8000180c:	fcb43823          	sd	a1,-48(s0)
    80001810:	87b2                	mv	a5,a2
    80001812:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    80001816:	fd843783          	ld	a5,-40(s0)
    8000181a:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    8000181e:	fcc42783          	lw	a5,-52(s0)
    80001822:	2781                	sext.w	a5,a5
    80001824:	00f04563          	bgtz	a5,8000182e <safestrcpy+0x2c>
    return os;
    80001828:	fe843783          	ld	a5,-24(s0)
    8000182c:	a0a1                	j	80001874 <safestrcpy+0x72>
  while(--n > 0 && (*s++ = *t++) != 0)
    8000182e:	fcc42783          	lw	a5,-52(s0)
    80001832:	37fd                	addiw	a5,a5,-1
    80001834:	fcf42623          	sw	a5,-52(s0)
    80001838:	fcc42783          	lw	a5,-52(s0)
    8000183c:	2781                	sext.w	a5,a5
    8000183e:	02f05563          	blez	a5,80001868 <safestrcpy+0x66>
    80001842:	fd043703          	ld	a4,-48(s0)
    80001846:	00170793          	addi	a5,a4,1
    8000184a:	fcf43823          	sd	a5,-48(s0)
    8000184e:	fd843783          	ld	a5,-40(s0)
    80001852:	00178693          	addi	a3,a5,1
    80001856:	fcd43c23          	sd	a3,-40(s0)
    8000185a:	00074703          	lbu	a4,0(a4)
    8000185e:	00e78023          	sb	a4,0(a5)
    80001862:	0007c783          	lbu	a5,0(a5)
    80001866:	f7e1                	bnez	a5,8000182e <safestrcpy+0x2c>
    ;
  *s = 0;
    80001868:	fd843783          	ld	a5,-40(s0)
    8000186c:	00078023          	sb	zero,0(a5)
  return os;
    80001870:	fe843783          	ld	a5,-24(s0)
}
    80001874:	853e                	mv	a0,a5
    80001876:	7462                	ld	s0,56(sp)
    80001878:	6121                	addi	sp,sp,64
    8000187a:	8082                	ret

000000008000187c <strlen>:

int
strlen(const char *s)
{
    8000187c:	7179                	addi	sp,sp,-48
    8000187e:	f422                	sd	s0,40(sp)
    80001880:	1800                	addi	s0,sp,48
    80001882:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    80001886:	fe042623          	sw	zero,-20(s0)
    8000188a:	a031                	j	80001896 <strlen+0x1a>
    8000188c:	fec42783          	lw	a5,-20(s0)
    80001890:	2785                	addiw	a5,a5,1
    80001892:	fef42623          	sw	a5,-20(s0)
    80001896:	fec42783          	lw	a5,-20(s0)
    8000189a:	fd843703          	ld	a4,-40(s0)
    8000189e:	97ba                	add	a5,a5,a4
    800018a0:	0007c783          	lbu	a5,0(a5)
    800018a4:	f7e5                	bnez	a5,8000188c <strlen+0x10>
    ;
  return n;
    800018a6:	fec42783          	lw	a5,-20(s0)
}
    800018aa:	853e                	mv	a0,a5
    800018ac:	7422                	ld	s0,40(sp)
    800018ae:	6145                	addi	sp,sp,48
    800018b0:	8082                	ret

00000000800018b2 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800018b2:	1141                	addi	sp,sp,-16
    800018b4:	e406                	sd	ra,8(sp)
    800018b6:	e022                	sd	s0,0(sp)
    800018b8:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800018ba:	00001097          	auipc	ra,0x1
    800018be:	000080e7          	jalr	ra # 800028ba <cpuid>
    800018c2:	87aa                	mv	a5,a0
    800018c4:	efe1                	bnez	a5,8000199c <main+0xea>
    consoleinit();
    800018c6:	fffff097          	auipc	ra,0xfffff
    800018ca:	f9a080e7          	jalr	-102(ra) # 80000860 <consoleinit>
    printfinit();
    800018ce:	fffff097          	auipc	ra,0xfffff
    800018d2:	4bc080e7          	jalr	1212(ra) # 80000d8a <printfinit>
    printf("\n");
    800018d6:	00009517          	auipc	a0,0x9
    800018da:	7aa50513          	addi	a0,a0,1962 # 8000b080 <etext+0x80>
    800018de:	fffff097          	auipc	ra,0xfffff
    800018e2:	158080e7          	jalr	344(ra) # 80000a36 <printf>
    printf("xv6 kernel is booting\n");
    800018e6:	00009517          	auipc	a0,0x9
    800018ea:	7a250513          	addi	a0,a0,1954 # 8000b088 <etext+0x88>
    800018ee:	fffff097          	auipc	ra,0xfffff
    800018f2:	148080e7          	jalr	328(ra) # 80000a36 <printf>
    printf("\n");
    800018f6:	00009517          	auipc	a0,0x9
    800018fa:	78a50513          	addi	a0,a0,1930 # 8000b080 <etext+0x80>
    800018fe:	fffff097          	auipc	ra,0xfffff
    80001902:	138080e7          	jalr	312(ra) # 80000a36 <printf>
    kinit();         // physical page allocator
    80001906:	fffff097          	auipc	ra,0xfffff
    8000190a:	790080e7          	jalr	1936(ra) # 80001096 <kinit>
    kvminit();       // create kernel page table
    8000190e:	00000097          	auipc	ra,0x0
    80001912:	22a080e7          	jalr	554(ra) # 80001b38 <kvminit>
    kvminithart();   // turn on paging
    80001916:	00000097          	auipc	ra,0x0
    8000191a:	248080e7          	jalr	584(ra) # 80001b5e <kvminithart>
    procinit();      // process table
    8000191e:	00001097          	auipc	ra,0x1
    80001922:	ece080e7          	jalr	-306(ra) # 800027ec <procinit>
    trapinit();      // trap vectors
    80001926:	00002097          	auipc	ra,0x2
    8000192a:	1d2080e7          	jalr	466(ra) # 80003af8 <trapinit>
    trapinithart();  // install kernel trap vector
    8000192e:	00002097          	auipc	ra,0x2
    80001932:	1f4080e7          	jalr	500(ra) # 80003b22 <trapinithart>
    plicinit();      // set up interrupt controller
    80001936:	00007097          	auipc	ra,0x7
    8000193a:	054080e7          	jalr	84(ra) # 8000898a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000193e:	00007097          	auipc	ra,0x7
    80001942:	07a080e7          	jalr	122(ra) # 800089b8 <plicinithart>
    binit();         // buffer cache
    80001946:	00003097          	auipc	ra,0x3
    8000194a:	bee080e7          	jalr	-1042(ra) # 80004534 <binit>
    iinit();         // inode table
    8000194e:	00003097          	auipc	ra,0x3
    80001952:	444080e7          	jalr	1092(ra) # 80004d92 <iinit>
    fileinit();      // file table
    80001956:	00005097          	auipc	ra,0x5
    8000195a:	e18080e7          	jalr	-488(ra) # 8000676e <fileinit>
    virtio_disk_init(VIRTIO0_ID, "program_disk"); // emulated hard disk 0, with programs
    8000195e:	00009597          	auipc	a1,0x9
    80001962:	74258593          	addi	a1,a1,1858 # 8000b0a0 <etext+0xa0>
    80001966:	4501                	li	a0,0
    80001968:	00007097          	auipc	ra,0x7
    8000196c:	1aa080e7          	jalr	426(ra) # 80008b12 <virtio_disk_init>
    virtio_disk_init(VIRTIO1_ID, "swap_disk"); // emulated hard disk 1, with swap
    80001970:	00009597          	auipc	a1,0x9
    80001974:	74058593          	addi	a1,a1,1856 # 8000b0b0 <etext+0xb0>
    80001978:	4505                	li	a0,1
    8000197a:	00007097          	auipc	ra,0x7
    8000197e:	198080e7          	jalr	408(ra) # 80008b12 <virtio_disk_init>

    userinit();      // first user process
    80001982:	00001097          	auipc	ra,0x1
    80001986:	316080e7          	jalr	790(ra) # 80002c98 <userinit>
    __sync_synchronize();
    8000198a:	0ff0000f          	fence
    started = 1;
    8000198e:	00012797          	auipc	a5,0x12
    80001992:	22278793          	addi	a5,a5,546 # 80013bb0 <started>
    80001996:	4705                	li	a4,1
    80001998:	c398                	sw	a4,0(a5)
    8000199a:	a0a9                	j	800019e4 <main+0x132>
  } else {
    while(started == 0)
    8000199c:	0001                	nop
    8000199e:	00012797          	auipc	a5,0x12
    800019a2:	21278793          	addi	a5,a5,530 # 80013bb0 <started>
    800019a6:	439c                	lw	a5,0(a5)
    800019a8:	2781                	sext.w	a5,a5
    800019aa:	dbf5                	beqz	a5,8000199e <main+0xec>
      ;
    __sync_synchronize();
    800019ac:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800019b0:	00001097          	auipc	ra,0x1
    800019b4:	f0a080e7          	jalr	-246(ra) # 800028ba <cpuid>
    800019b8:	87aa                	mv	a5,a0
    800019ba:	85be                	mv	a1,a5
    800019bc:	00009517          	auipc	a0,0x9
    800019c0:	70450513          	addi	a0,a0,1796 # 8000b0c0 <etext+0xc0>
    800019c4:	fffff097          	auipc	ra,0xfffff
    800019c8:	072080e7          	jalr	114(ra) # 80000a36 <printf>
    kvminithart();    // turn on paging
    800019cc:	00000097          	auipc	ra,0x0
    800019d0:	192080e7          	jalr	402(ra) # 80001b5e <kvminithart>
    trapinithart();   // install kernel trap vector
    800019d4:	00002097          	auipc	ra,0x2
    800019d8:	14e080e7          	jalr	334(ra) # 80003b22 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800019dc:	00007097          	auipc	ra,0x7
    800019e0:	fdc080e7          	jalr	-36(ra) # 800089b8 <plicinithart>
  }

  scheduler();        
    800019e4:	00002097          	auipc	ra,0x2
    800019e8:	8ca080e7          	jalr	-1846(ra) # 800032ae <scheduler>

00000000800019ec <w_satp>:
{
    800019ec:	1101                	addi	sp,sp,-32
    800019ee:	ec22                	sd	s0,24(sp)
    800019f0:	1000                	addi	s0,sp,32
    800019f2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    800019f6:	fe843783          	ld	a5,-24(s0)
    800019fa:	18079073          	csrw	satp,a5
}
    800019fe:	0001                	nop
    80001a00:	6462                	ld	s0,24(sp)
    80001a02:	6105                	addi	sp,sp,32
    80001a04:	8082                	ret

0000000080001a06 <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    80001a06:	1141                	addi	sp,sp,-16
    80001a08:	e422                	sd	s0,8(sp)
    80001a0a:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80001a0c:	12000073          	sfence.vma
}
    80001a10:	0001                	nop
    80001a12:	6422                	ld	s0,8(sp)
    80001a14:	0141                	addi	sp,sp,16
    80001a16:	8082                	ret

0000000080001a18 <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    80001a18:	1101                	addi	sp,sp,-32
    80001a1a:	ec06                	sd	ra,24(sp)
    80001a1c:	e822                	sd	s0,16(sp)
    80001a1e:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    80001a20:	fffff097          	auipc	ra,0xfffff
    80001a24:	7b6080e7          	jalr	1974(ra) # 800011d6 <kalloc>
    80001a28:	fea43423          	sd	a0,-24(s0)
  memset(kpgtbl, 0, PGSIZE);
    80001a2c:	6605                	lui	a2,0x1
    80001a2e:	4581                	li	a1,0
    80001a30:	fe843503          	ld	a0,-24(s0)
    80001a34:	00000097          	auipc	ra,0x0
    80001a38:	aca080e7          	jalr	-1334(ra) # 800014fe <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001a3c:	4719                	li	a4,6
    80001a3e:	6685                	lui	a3,0x1
    80001a40:	10000637          	lui	a2,0x10000
    80001a44:	100005b7          	lui	a1,0x10000
    80001a48:	fe843503          	ld	a0,-24(s0)
    80001a4c:	00000097          	auipc	ra,0x0
    80001a50:	2ae080e7          	jalr	686(ra) # 80001cfa <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80001a54:	4719                	li	a4,6
    80001a56:	6685                	lui	a3,0x1
    80001a58:	10001637          	lui	a2,0x10001
    80001a5c:	100015b7          	lui	a1,0x10001
    80001a60:	fe843503          	ld	a0,-24(s0)
    80001a64:	00000097          	auipc	ra,0x0
    80001a68:	296080e7          	jalr	662(ra) # 80001cfa <kvmmap>
  kvmmap(kpgtbl, VIRTIO1, VIRTIO1, PGSIZE, PTE_R | PTE_W);
    80001a6c:	4719                	li	a4,6
    80001a6e:	6685                	lui	a3,0x1
    80001a70:	10002637          	lui	a2,0x10002
    80001a74:	100025b7          	lui	a1,0x10002
    80001a78:	fe843503          	ld	a0,-24(s0)
    80001a7c:	00000097          	auipc	ra,0x0
    80001a80:	27e080e7          	jalr	638(ra) # 80001cfa <kvmmap>

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001a84:	4719                	li	a4,6
    80001a86:	004006b7          	lui	a3,0x400
    80001a8a:	0c000637          	lui	a2,0xc000
    80001a8e:	0c0005b7          	lui	a1,0xc000
    80001a92:	fe843503          	ld	a0,-24(s0)
    80001a96:	00000097          	auipc	ra,0x0
    80001a9a:	264080e7          	jalr	612(ra) # 80001cfa <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80001a9e:	00009717          	auipc	a4,0x9
    80001aa2:	56270713          	addi	a4,a4,1378 # 8000b000 <etext>
    80001aa6:	800007b7          	lui	a5,0x80000
    80001aaa:	97ba                	add	a5,a5,a4
    80001aac:	4729                	li	a4,10
    80001aae:	86be                	mv	a3,a5
    80001ab0:	4785                	li	a5,1
    80001ab2:	01f79613          	slli	a2,a5,0x1f
    80001ab6:	4785                	li	a5,1
    80001ab8:	01f79593          	slli	a1,a5,0x1f
    80001abc:	fe843503          	ld	a0,-24(s0)
    80001ac0:	00000097          	auipc	ra,0x0
    80001ac4:	23a080e7          	jalr	570(ra) # 80001cfa <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80001ac8:	00009597          	auipc	a1,0x9
    80001acc:	53858593          	addi	a1,a1,1336 # 8000b000 <etext>
    80001ad0:	00009617          	auipc	a2,0x9
    80001ad4:	53060613          	addi	a2,a2,1328 # 8000b000 <etext>
    80001ad8:	00009797          	auipc	a5,0x9
    80001adc:	52878793          	addi	a5,a5,1320 # 8000b000 <etext>
    80001ae0:	08100713          	li	a4,129
    80001ae4:	0762                	slli	a4,a4,0x18
    80001ae6:	40f707b3          	sub	a5,a4,a5
    80001aea:	4719                	li	a4,6
    80001aec:	86be                	mv	a3,a5
    80001aee:	fe843503          	ld	a0,-24(s0)
    80001af2:	00000097          	auipc	ra,0x0
    80001af6:	208080e7          	jalr	520(ra) # 80001cfa <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001afa:	00008797          	auipc	a5,0x8
    80001afe:	50678793          	addi	a5,a5,1286 # 8000a000 <_trampoline>
    80001b02:	4729                	li	a4,10
    80001b04:	6685                	lui	a3,0x1
    80001b06:	863e                	mv	a2,a5
    80001b08:	040007b7          	lui	a5,0x4000
    80001b0c:	17fd                	addi	a5,a5,-1
    80001b0e:	00c79593          	slli	a1,a5,0xc
    80001b12:	fe843503          	ld	a0,-24(s0)
    80001b16:	00000097          	auipc	ra,0x0
    80001b1a:	1e4080e7          	jalr	484(ra) # 80001cfa <kvmmap>

  // allocate and map a kernel stack for each process.
  proc_mapstacks(kpgtbl);
    80001b1e:	fe843503          	ld	a0,-24(s0)
    80001b22:	00001097          	auipc	ra,0x1
    80001b26:	c0e080e7          	jalr	-1010(ra) # 80002730 <proc_mapstacks>
  
  return kpgtbl;
    80001b2a:	fe843783          	ld	a5,-24(s0)
}
    80001b2e:	853e                	mv	a0,a5
    80001b30:	60e2                	ld	ra,24(sp)
    80001b32:	6442                	ld	s0,16(sp)
    80001b34:	6105                	addi	sp,sp,32
    80001b36:	8082                	ret

0000000080001b38 <kvminit>:

// Initialize the one kernel_pagetable
void
kvminit(void)
{
    80001b38:	1141                	addi	sp,sp,-16
    80001b3a:	e406                	sd	ra,8(sp)
    80001b3c:	e022                	sd	s0,0(sp)
    80001b3e:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001b40:	00000097          	auipc	ra,0x0
    80001b44:	ed8080e7          	jalr	-296(ra) # 80001a18 <kvmmake>
    80001b48:	872a                	mv	a4,a0
    80001b4a:	0000a797          	auipc	a5,0xa
    80001b4e:	dee78793          	addi	a5,a5,-530 # 8000b938 <kernel_pagetable>
    80001b52:	e398                	sd	a4,0(a5)
}
    80001b54:	0001                	nop
    80001b56:	60a2                	ld	ra,8(sp)
    80001b58:	6402                	ld	s0,0(sp)
    80001b5a:	0141                	addi	sp,sp,16
    80001b5c:	8082                	ret

0000000080001b5e <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80001b5e:	1141                	addi	sp,sp,-16
    80001b60:	e406                	sd	ra,8(sp)
    80001b62:	e022                	sd	s0,0(sp)
    80001b64:	0800                	addi	s0,sp,16
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();
    80001b66:	00000097          	auipc	ra,0x0
    80001b6a:	ea0080e7          	jalr	-352(ra) # 80001a06 <sfence_vma>

  w_satp(MAKE_SATP(kernel_pagetable));
    80001b6e:	0000a797          	auipc	a5,0xa
    80001b72:	dca78793          	addi	a5,a5,-566 # 8000b938 <kernel_pagetable>
    80001b76:	639c                	ld	a5,0(a5)
    80001b78:	00c7d713          	srli	a4,a5,0xc
    80001b7c:	57fd                	li	a5,-1
    80001b7e:	17fe                	slli	a5,a5,0x3f
    80001b80:	8fd9                	or	a5,a5,a4
    80001b82:	853e                	mv	a0,a5
    80001b84:	00000097          	auipc	ra,0x0
    80001b88:	e68080e7          	jalr	-408(ra) # 800019ec <w_satp>

  // flush stale entries from the TLB.
  sfence_vma();
    80001b8c:	00000097          	auipc	ra,0x0
    80001b90:	e7a080e7          	jalr	-390(ra) # 80001a06 <sfence_vma>
}
    80001b94:	0001                	nop
    80001b96:	60a2                	ld	ra,8(sp)
    80001b98:	6402                	ld	s0,0(sp)
    80001b9a:	0141                	addi	sp,sp,16
    80001b9c:	8082                	ret

0000000080001b9e <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80001b9e:	7139                	addi	sp,sp,-64
    80001ba0:	fc06                	sd	ra,56(sp)
    80001ba2:	f822                	sd	s0,48(sp)
    80001ba4:	0080                	addi	s0,sp,64
    80001ba6:	fca43c23          	sd	a0,-40(s0)
    80001baa:	fcb43823          	sd	a1,-48(s0)
    80001bae:	87b2                	mv	a5,a2
    80001bb0:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    80001bb4:	fd043703          	ld	a4,-48(s0)
    80001bb8:	57fd                	li	a5,-1
    80001bba:	83e9                	srli	a5,a5,0x1a
    80001bbc:	00e7f463          	bgeu	a5,a4,80001bc4 <walk+0x26>
    return 0;
    80001bc0:	4781                	li	a5,0
    80001bc2:	a85d                	j	80001c78 <walk+0xda>

  for(int level = 2; level > 0; level--) {
    80001bc4:	4789                	li	a5,2
    80001bc6:	fef42623          	sw	a5,-20(s0)
    80001bca:	a849                	j	80001c5c <walk+0xbe>
    pte_t *pte = &pagetable[PX(level, va)];
    80001bcc:	fec42703          	lw	a4,-20(s0)
    80001bd0:	87ba                	mv	a5,a4
    80001bd2:	0037979b          	slliw	a5,a5,0x3
    80001bd6:	9fb9                	addw	a5,a5,a4
    80001bd8:	2781                	sext.w	a5,a5
    80001bda:	27b1                	addiw	a5,a5,12
    80001bdc:	2781                	sext.w	a5,a5
    80001bde:	873e                	mv	a4,a5
    80001be0:	fd043783          	ld	a5,-48(s0)
    80001be4:	00e7d7b3          	srl	a5,a5,a4
    80001be8:	1ff7f793          	andi	a5,a5,511
    80001bec:	078e                	slli	a5,a5,0x3
    80001bee:	fd843703          	ld	a4,-40(s0)
    80001bf2:	97ba                	add	a5,a5,a4
    80001bf4:	fef43023          	sd	a5,-32(s0)
    if(*pte & PTE_V) {
    80001bf8:	fe043783          	ld	a5,-32(s0)
    80001bfc:	639c                	ld	a5,0(a5)
    80001bfe:	8b85                	andi	a5,a5,1
    80001c00:	cb89                	beqz	a5,80001c12 <walk+0x74>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001c02:	fe043783          	ld	a5,-32(s0)
    80001c06:	639c                	ld	a5,0(a5)
    80001c08:	83a9                	srli	a5,a5,0xa
    80001c0a:	07b2                	slli	a5,a5,0xc
    80001c0c:	fcf43c23          	sd	a5,-40(s0)
    80001c10:	a089                	j	80001c52 <walk+0xb4>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001c12:	fcc42783          	lw	a5,-52(s0)
    80001c16:	2781                	sext.w	a5,a5
    80001c18:	cb91                	beqz	a5,80001c2c <walk+0x8e>
    80001c1a:	fffff097          	auipc	ra,0xfffff
    80001c1e:	5bc080e7          	jalr	1468(ra) # 800011d6 <kalloc>
    80001c22:	fca43c23          	sd	a0,-40(s0)
    80001c26:	fd843783          	ld	a5,-40(s0)
    80001c2a:	e399                	bnez	a5,80001c30 <walk+0x92>
        return 0;
    80001c2c:	4781                	li	a5,0
    80001c2e:	a0a9                	j	80001c78 <walk+0xda>
      memset(pagetable, 0, PGSIZE);
    80001c30:	6605                	lui	a2,0x1
    80001c32:	4581                	li	a1,0
    80001c34:	fd843503          	ld	a0,-40(s0)
    80001c38:	00000097          	auipc	ra,0x0
    80001c3c:	8c6080e7          	jalr	-1850(ra) # 800014fe <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001c40:	fd843783          	ld	a5,-40(s0)
    80001c44:	83b1                	srli	a5,a5,0xc
    80001c46:	07aa                	slli	a5,a5,0xa
    80001c48:	0017e713          	ori	a4,a5,1
    80001c4c:	fe043783          	ld	a5,-32(s0)
    80001c50:	e398                	sd	a4,0(a5)
  for(int level = 2; level > 0; level--) {
    80001c52:	fec42783          	lw	a5,-20(s0)
    80001c56:	37fd                	addiw	a5,a5,-1
    80001c58:	fef42623          	sw	a5,-20(s0)
    80001c5c:	fec42783          	lw	a5,-20(s0)
    80001c60:	2781                	sext.w	a5,a5
    80001c62:	f6f045e3          	bgtz	a5,80001bcc <walk+0x2e>
    }
  }
  return &pagetable[PX(0, va)];
    80001c66:	fd043783          	ld	a5,-48(s0)
    80001c6a:	83b1                	srli	a5,a5,0xc
    80001c6c:	1ff7f793          	andi	a5,a5,511
    80001c70:	078e                	slli	a5,a5,0x3
    80001c72:	fd843703          	ld	a4,-40(s0)
    80001c76:	97ba                	add	a5,a5,a4
}
    80001c78:	853e                	mv	a0,a5
    80001c7a:	70e2                	ld	ra,56(sp)
    80001c7c:	7442                	ld	s0,48(sp)
    80001c7e:	6121                	addi	sp,sp,64
    80001c80:	8082                	ret

0000000080001c82 <walkaddr>:
// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pages.
uint64
walkaddr(pagetable_t pagetable, uint64 va)
{
    80001c82:	7179                	addi	sp,sp,-48
    80001c84:	f406                	sd	ra,40(sp)
    80001c86:	f022                	sd	s0,32(sp)
    80001c88:	1800                	addi	s0,sp,48
    80001c8a:	fca43c23          	sd	a0,-40(s0)
    80001c8e:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001c92:	fd043703          	ld	a4,-48(s0)
    80001c96:	57fd                	li	a5,-1
    80001c98:	83e9                	srli	a5,a5,0x1a
    80001c9a:	00e7f463          	bgeu	a5,a4,80001ca2 <walkaddr+0x20>
    return 0;
    80001c9e:	4781                	li	a5,0
    80001ca0:	a881                	j	80001cf0 <walkaddr+0x6e>

  pte = walk(pagetable, va, 0);
    80001ca2:	4601                	li	a2,0
    80001ca4:	fd043583          	ld	a1,-48(s0)
    80001ca8:	fd843503          	ld	a0,-40(s0)
    80001cac:	00000097          	auipc	ra,0x0
    80001cb0:	ef2080e7          	jalr	-270(ra) # 80001b9e <walk>
    80001cb4:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80001cb8:	fe843783          	ld	a5,-24(s0)
    80001cbc:	e399                	bnez	a5,80001cc2 <walkaddr+0x40>
    return 0;
    80001cbe:	4781                	li	a5,0
    80001cc0:	a805                	j	80001cf0 <walkaddr+0x6e>
  if((*pte & PTE_V) == 0)
    80001cc2:	fe843783          	ld	a5,-24(s0)
    80001cc6:	639c                	ld	a5,0(a5)
    80001cc8:	8b85                	andi	a5,a5,1
    80001cca:	e399                	bnez	a5,80001cd0 <walkaddr+0x4e>
    return 0;
    80001ccc:	4781                	li	a5,0
    80001cce:	a00d                	j	80001cf0 <walkaddr+0x6e>
  if((*pte & PTE_U) == 0)
    80001cd0:	fe843783          	ld	a5,-24(s0)
    80001cd4:	639c                	ld	a5,0(a5)
    80001cd6:	8bc1                	andi	a5,a5,16
    80001cd8:	e399                	bnez	a5,80001cde <walkaddr+0x5c>
    return 0;
    80001cda:	4781                	li	a5,0
    80001cdc:	a811                	j	80001cf0 <walkaddr+0x6e>
  pa = PTE2PA(*pte);
    80001cde:	fe843783          	ld	a5,-24(s0)
    80001ce2:	639c                	ld	a5,0(a5)
    80001ce4:	83a9                	srli	a5,a5,0xa
    80001ce6:	07b2                	slli	a5,a5,0xc
    80001ce8:	fef43023          	sd	a5,-32(s0)
  return pa;
    80001cec:	fe043783          	ld	a5,-32(s0)
}
    80001cf0:	853e                	mv	a0,a5
    80001cf2:	70a2                	ld	ra,40(sp)
    80001cf4:	7402                	ld	s0,32(sp)
    80001cf6:	6145                	addi	sp,sp,48
    80001cf8:	8082                	ret

0000000080001cfa <kvmmap>:
// add a mapping to the kernel page table.
// only used when booting.
// does not flush TLB or enable paging.
void
kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
    80001cfa:	7139                	addi	sp,sp,-64
    80001cfc:	fc06                	sd	ra,56(sp)
    80001cfe:	f822                	sd	s0,48(sp)
    80001d00:	0080                	addi	s0,sp,64
    80001d02:	fea43423          	sd	a0,-24(s0)
    80001d06:	feb43023          	sd	a1,-32(s0)
    80001d0a:	fcc43c23          	sd	a2,-40(s0)
    80001d0e:	fcd43823          	sd	a3,-48(s0)
    80001d12:	87ba                	mv	a5,a4
    80001d14:	fcf42623          	sw	a5,-52(s0)
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001d18:	fcc42783          	lw	a5,-52(s0)
    80001d1c:	873e                	mv	a4,a5
    80001d1e:	fd843683          	ld	a3,-40(s0)
    80001d22:	fd043603          	ld	a2,-48(s0)
    80001d26:	fe043583          	ld	a1,-32(s0)
    80001d2a:	fe843503          	ld	a0,-24(s0)
    80001d2e:	00000097          	auipc	ra,0x0
    80001d32:	026080e7          	jalr	38(ra) # 80001d54 <mappages>
    80001d36:	87aa                	mv	a5,a0
    80001d38:	cb89                	beqz	a5,80001d4a <kvmmap+0x50>
    panic("kvmmap");
    80001d3a:	00009517          	auipc	a0,0x9
    80001d3e:	39e50513          	addi	a0,a0,926 # 8000b0d8 <etext+0xd8>
    80001d42:	fffff097          	auipc	ra,0xfffff
    80001d46:	f4a080e7          	jalr	-182(ra) # 80000c8c <panic>
}
    80001d4a:	0001                	nop
    80001d4c:	70e2                	ld	ra,56(sp)
    80001d4e:	7442                	ld	s0,48(sp)
    80001d50:	6121                	addi	sp,sp,64
    80001d52:	8082                	ret

0000000080001d54 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001d54:	711d                	addi	sp,sp,-96
    80001d56:	ec86                	sd	ra,88(sp)
    80001d58:	e8a2                	sd	s0,80(sp)
    80001d5a:	1080                	addi	s0,sp,96
    80001d5c:	fca43423          	sd	a0,-56(s0)
    80001d60:	fcb43023          	sd	a1,-64(s0)
    80001d64:	fac43c23          	sd	a2,-72(s0)
    80001d68:	fad43823          	sd	a3,-80(s0)
    80001d6c:	87ba                	mv	a5,a4
    80001d6e:	faf42623          	sw	a5,-84(s0)
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80001d72:	fb843783          	ld	a5,-72(s0)
    80001d76:	eb89                	bnez	a5,80001d88 <mappages+0x34>
    panic("mappages: size");
    80001d78:	00009517          	auipc	a0,0x9
    80001d7c:	36850513          	addi	a0,a0,872 # 8000b0e0 <etext+0xe0>
    80001d80:	fffff097          	auipc	ra,0xfffff
    80001d84:	f0c080e7          	jalr	-244(ra) # 80000c8c <panic>
  
  a = PGROUNDDOWN(va);
    80001d88:	fc043703          	ld	a4,-64(s0)
    80001d8c:	77fd                	lui	a5,0xfffff
    80001d8e:	8ff9                	and	a5,a5,a4
    80001d90:	fef43423          	sd	a5,-24(s0)
  last = PGROUNDDOWN(va + size - 1);
    80001d94:	fc043703          	ld	a4,-64(s0)
    80001d98:	fb843783          	ld	a5,-72(s0)
    80001d9c:	97ba                	add	a5,a5,a4
    80001d9e:	fff78713          	addi	a4,a5,-1 # ffffffffffffefff <end+0xffffffff7ffda0cf>
    80001da2:	77fd                	lui	a5,0xfffff
    80001da4:	8ff9                	and	a5,a5,a4
    80001da6:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80001daa:	4605                	li	a2,1
    80001dac:	fe843583          	ld	a1,-24(s0)
    80001db0:	fc843503          	ld	a0,-56(s0)
    80001db4:	00000097          	auipc	ra,0x0
    80001db8:	dea080e7          	jalr	-534(ra) # 80001b9e <walk>
    80001dbc:	fca43c23          	sd	a0,-40(s0)
    80001dc0:	fd843783          	ld	a5,-40(s0)
    80001dc4:	e399                	bnez	a5,80001dca <mappages+0x76>
      return -1;
    80001dc6:	57fd                	li	a5,-1
    80001dc8:	a085                	j	80001e28 <mappages+0xd4>
    if(*pte & PTE_V)
    80001dca:	fd843783          	ld	a5,-40(s0)
    80001dce:	639c                	ld	a5,0(a5)
    80001dd0:	8b85                	andi	a5,a5,1
    80001dd2:	cb89                	beqz	a5,80001de4 <mappages+0x90>
      panic("mappages: remap");
    80001dd4:	00009517          	auipc	a0,0x9
    80001dd8:	31c50513          	addi	a0,a0,796 # 8000b0f0 <etext+0xf0>
    80001ddc:	fffff097          	auipc	ra,0xfffff
    80001de0:	eb0080e7          	jalr	-336(ra) # 80000c8c <panic>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001de4:	fb043783          	ld	a5,-80(s0)
    80001de8:	83b1                	srli	a5,a5,0xc
    80001dea:	00a79713          	slli	a4,a5,0xa
    80001dee:	fac42783          	lw	a5,-84(s0)
    80001df2:	8fd9                	or	a5,a5,a4
    80001df4:	0017e713          	ori	a4,a5,1
    80001df8:	fd843783          	ld	a5,-40(s0)
    80001dfc:	e398                	sd	a4,0(a5)
    if(a == last)
    80001dfe:	fe843703          	ld	a4,-24(s0)
    80001e02:	fe043783          	ld	a5,-32(s0)
    80001e06:	00f70f63          	beq	a4,a5,80001e24 <mappages+0xd0>
      break;
    a += PGSIZE;
    80001e0a:	fe843703          	ld	a4,-24(s0)
    80001e0e:	6785                	lui	a5,0x1
    80001e10:	97ba                	add	a5,a5,a4
    80001e12:	fef43423          	sd	a5,-24(s0)
    pa += PGSIZE;
    80001e16:	fb043703          	ld	a4,-80(s0)
    80001e1a:	6785                	lui	a5,0x1
    80001e1c:	97ba                	add	a5,a5,a4
    80001e1e:	faf43823          	sd	a5,-80(s0)
    if((pte = walk(pagetable, a, 1)) == 0)
    80001e22:	b761                	j	80001daa <mappages+0x56>
      break;
    80001e24:	0001                	nop
  }
  return 0;
    80001e26:	4781                	li	a5,0
}
    80001e28:	853e                	mv	a0,a5
    80001e2a:	60e6                	ld	ra,88(sp)
    80001e2c:	6446                	ld	s0,80(sp)
    80001e2e:	6125                	addi	sp,sp,96
    80001e30:	8082                	ret

0000000080001e32 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001e32:	715d                	addi	sp,sp,-80
    80001e34:	e486                	sd	ra,72(sp)
    80001e36:	e0a2                	sd	s0,64(sp)
    80001e38:	0880                	addi	s0,sp,80
    80001e3a:	fca43423          	sd	a0,-56(s0)
    80001e3e:	fcb43023          	sd	a1,-64(s0)
    80001e42:	fac43c23          	sd	a2,-72(s0)
    80001e46:	87b6                	mv	a5,a3
    80001e48:	faf42a23          	sw	a5,-76(s0)
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001e4c:	fc043703          	ld	a4,-64(s0)
    80001e50:	6785                	lui	a5,0x1
    80001e52:	17fd                	addi	a5,a5,-1
    80001e54:	8ff9                	and	a5,a5,a4
    80001e56:	cb89                	beqz	a5,80001e68 <uvmunmap+0x36>
    panic("uvmunmap: not aligned");
    80001e58:	00009517          	auipc	a0,0x9
    80001e5c:	2a850513          	addi	a0,a0,680 # 8000b100 <etext+0x100>
    80001e60:	fffff097          	auipc	ra,0xfffff
    80001e64:	e2c080e7          	jalr	-468(ra) # 80000c8c <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001e68:	fc043783          	ld	a5,-64(s0)
    80001e6c:	fef43423          	sd	a5,-24(s0)
    80001e70:	a045                	j	80001f10 <uvmunmap+0xde>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001e72:	4601                	li	a2,0
    80001e74:	fe843583          	ld	a1,-24(s0)
    80001e78:	fc843503          	ld	a0,-56(s0)
    80001e7c:	00000097          	auipc	ra,0x0
    80001e80:	d22080e7          	jalr	-734(ra) # 80001b9e <walk>
    80001e84:	fea43023          	sd	a0,-32(s0)
    80001e88:	fe043783          	ld	a5,-32(s0)
    80001e8c:	eb89                	bnez	a5,80001e9e <uvmunmap+0x6c>
      panic("uvmunmap: walk");
    80001e8e:	00009517          	auipc	a0,0x9
    80001e92:	28a50513          	addi	a0,a0,650 # 8000b118 <etext+0x118>
    80001e96:	fffff097          	auipc	ra,0xfffff
    80001e9a:	df6080e7          	jalr	-522(ra) # 80000c8c <panic>
    if((*pte & PTE_V) == 0)
    80001e9e:	fe043783          	ld	a5,-32(s0)
    80001ea2:	639c                	ld	a5,0(a5)
    80001ea4:	8b85                	andi	a5,a5,1
    80001ea6:	eb89                	bnez	a5,80001eb8 <uvmunmap+0x86>
      panic("uvmunmap: not mapped");
    80001ea8:	00009517          	auipc	a0,0x9
    80001eac:	28050513          	addi	a0,a0,640 # 8000b128 <etext+0x128>
    80001eb0:	fffff097          	auipc	ra,0xfffff
    80001eb4:	ddc080e7          	jalr	-548(ra) # 80000c8c <panic>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001eb8:	fe043783          	ld	a5,-32(s0)
    80001ebc:	639c                	ld	a5,0(a5)
    80001ebe:	3ff7f713          	andi	a4,a5,1023
    80001ec2:	4785                	li	a5,1
    80001ec4:	00f71a63          	bne	a4,a5,80001ed8 <uvmunmap+0xa6>
      panic("uvmunmap: not a leaf");
    80001ec8:	00009517          	auipc	a0,0x9
    80001ecc:	27850513          	addi	a0,a0,632 # 8000b140 <etext+0x140>
    80001ed0:	fffff097          	auipc	ra,0xfffff
    80001ed4:	dbc080e7          	jalr	-580(ra) # 80000c8c <panic>
    if(do_free){
    80001ed8:	fb442783          	lw	a5,-76(s0)
    80001edc:	2781                	sext.w	a5,a5
    80001ede:	cf99                	beqz	a5,80001efc <uvmunmap+0xca>
      uint64 pa = PTE2PA(*pte);
    80001ee0:	fe043783          	ld	a5,-32(s0)
    80001ee4:	639c                	ld	a5,0(a5)
    80001ee6:	83a9                	srli	a5,a5,0xa
    80001ee8:	07b2                	slli	a5,a5,0xc
    80001eea:	fcf43c23          	sd	a5,-40(s0)
      kfree((void*)pa);
    80001eee:	fd843783          	ld	a5,-40(s0)
    80001ef2:	853e                	mv	a0,a5
    80001ef4:	fffff097          	auipc	ra,0xfffff
    80001ef8:	23c080e7          	jalr	572(ra) # 80001130 <kfree>
    }
    *pte = 0;
    80001efc:	fe043783          	ld	a5,-32(s0)
    80001f00:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001f04:	fe843703          	ld	a4,-24(s0)
    80001f08:	6785                	lui	a5,0x1
    80001f0a:	97ba                	add	a5,a5,a4
    80001f0c:	fef43423          	sd	a5,-24(s0)
    80001f10:	fb843783          	ld	a5,-72(s0)
    80001f14:	00c79713          	slli	a4,a5,0xc
    80001f18:	fc043783          	ld	a5,-64(s0)
    80001f1c:	97ba                	add	a5,a5,a4
    80001f1e:	fe843703          	ld	a4,-24(s0)
    80001f22:	f4f768e3          	bltu	a4,a5,80001e72 <uvmunmap+0x40>
  }
}
    80001f26:	0001                	nop
    80001f28:	0001                	nop
    80001f2a:	60a6                	ld	ra,72(sp)
    80001f2c:	6406                	ld	s0,64(sp)
    80001f2e:	6161                	addi	sp,sp,80
    80001f30:	8082                	ret

0000000080001f32 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001f32:	1101                	addi	sp,sp,-32
    80001f34:	ec06                	sd	ra,24(sp)
    80001f36:	e822                	sd	s0,16(sp)
    80001f38:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001f3a:	fffff097          	auipc	ra,0xfffff
    80001f3e:	29c080e7          	jalr	668(ra) # 800011d6 <kalloc>
    80001f42:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80001f46:	fe843783          	ld	a5,-24(s0)
    80001f4a:	e399                	bnez	a5,80001f50 <uvmcreate+0x1e>
    return 0;
    80001f4c:	4781                	li	a5,0
    80001f4e:	a819                	j	80001f64 <uvmcreate+0x32>
  memset(pagetable, 0, PGSIZE);
    80001f50:	6605                	lui	a2,0x1
    80001f52:	4581                	li	a1,0
    80001f54:	fe843503          	ld	a0,-24(s0)
    80001f58:	fffff097          	auipc	ra,0xfffff
    80001f5c:	5a6080e7          	jalr	1446(ra) # 800014fe <memset>
  return pagetable;
    80001f60:	fe843783          	ld	a5,-24(s0)
}
    80001f64:	853e                	mv	a0,a5
    80001f66:	60e2                	ld	ra,24(sp)
    80001f68:	6442                	ld	s0,16(sp)
    80001f6a:	6105                	addi	sp,sp,32
    80001f6c:	8082                	ret

0000000080001f6e <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80001f6e:	7139                	addi	sp,sp,-64
    80001f70:	fc06                	sd	ra,56(sp)
    80001f72:	f822                	sd	s0,48(sp)
    80001f74:	0080                	addi	s0,sp,64
    80001f76:	fca43c23          	sd	a0,-40(s0)
    80001f7a:	fcb43823          	sd	a1,-48(s0)
    80001f7e:	87b2                	mv	a5,a2
    80001f80:	fcf42623          	sw	a5,-52(s0)
  char *mem;

  if(sz >= PGSIZE)
    80001f84:	fcc42783          	lw	a5,-52(s0)
    80001f88:	0007871b          	sext.w	a4,a5
    80001f8c:	6785                	lui	a5,0x1
    80001f8e:	00f76a63          	bltu	a4,a5,80001fa2 <uvmfirst+0x34>
    panic("uvmfirst: more than a page");
    80001f92:	00009517          	auipc	a0,0x9
    80001f96:	1c650513          	addi	a0,a0,454 # 8000b158 <etext+0x158>
    80001f9a:	fffff097          	auipc	ra,0xfffff
    80001f9e:	cf2080e7          	jalr	-782(ra) # 80000c8c <panic>
  mem = kalloc();
    80001fa2:	fffff097          	auipc	ra,0xfffff
    80001fa6:	234080e7          	jalr	564(ra) # 800011d6 <kalloc>
    80001faa:	fea43423          	sd	a0,-24(s0)
  memset(mem, 0, PGSIZE);
    80001fae:	6605                	lui	a2,0x1
    80001fb0:	4581                	li	a1,0
    80001fb2:	fe843503          	ld	a0,-24(s0)
    80001fb6:	fffff097          	auipc	ra,0xfffff
    80001fba:	548080e7          	jalr	1352(ra) # 800014fe <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001fbe:	fe843783          	ld	a5,-24(s0)
    80001fc2:	4779                	li	a4,30
    80001fc4:	86be                	mv	a3,a5
    80001fc6:	6605                	lui	a2,0x1
    80001fc8:	4581                	li	a1,0
    80001fca:	fd843503          	ld	a0,-40(s0)
    80001fce:	00000097          	auipc	ra,0x0
    80001fd2:	d86080e7          	jalr	-634(ra) # 80001d54 <mappages>
  memmove(mem, src, sz);
    80001fd6:	fcc42783          	lw	a5,-52(s0)
    80001fda:	863e                	mv	a2,a5
    80001fdc:	fd043583          	ld	a1,-48(s0)
    80001fe0:	fe843503          	ld	a0,-24(s0)
    80001fe4:	fffff097          	auipc	ra,0xfffff
    80001fe8:	5fe080e7          	jalr	1534(ra) # 800015e2 <memmove>
}
    80001fec:	0001                	nop
    80001fee:	70e2                	ld	ra,56(sp)
    80001ff0:	7442                	ld	s0,48(sp)
    80001ff2:	6121                	addi	sp,sp,64
    80001ff4:	8082                	ret

0000000080001ff6 <uvmalloc>:

// Allocate PTEs and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm)
{
    80001ff6:	7139                	addi	sp,sp,-64
    80001ff8:	fc06                	sd	ra,56(sp)
    80001ffa:	f822                	sd	s0,48(sp)
    80001ffc:	0080                	addi	s0,sp,64
    80001ffe:	fca43c23          	sd	a0,-40(s0)
    80002002:	fcb43823          	sd	a1,-48(s0)
    80002006:	fcc43423          	sd	a2,-56(s0)
    8000200a:	87b6                	mv	a5,a3
    8000200c:	fcf42223          	sw	a5,-60(s0)
  char *mem;
  uint64 a;

  if(newsz < oldsz)
    80002010:	fc843703          	ld	a4,-56(s0)
    80002014:	fd043783          	ld	a5,-48(s0)
    80002018:	00f77563          	bgeu	a4,a5,80002022 <uvmalloc+0x2c>
    return oldsz;
    8000201c:	fd043783          	ld	a5,-48(s0)
    80002020:	a87d                	j	800020de <uvmalloc+0xe8>

  oldsz = PGROUNDUP(oldsz);
    80002022:	fd043703          	ld	a4,-48(s0)
    80002026:	6785                	lui	a5,0x1
    80002028:	17fd                	addi	a5,a5,-1
    8000202a:	973e                	add	a4,a4,a5
    8000202c:	77fd                	lui	a5,0xfffff
    8000202e:	8ff9                	and	a5,a5,a4
    80002030:	fcf43823          	sd	a5,-48(s0)
  for(a = oldsz; a < newsz; a += PGSIZE){
    80002034:	fd043783          	ld	a5,-48(s0)
    80002038:	fef43423          	sd	a5,-24(s0)
    8000203c:	a849                	j	800020ce <uvmalloc+0xd8>
    mem = kalloc();
    8000203e:	fffff097          	auipc	ra,0xfffff
    80002042:	198080e7          	jalr	408(ra) # 800011d6 <kalloc>
    80002046:	fea43023          	sd	a0,-32(s0)
    if(mem == 0){
    8000204a:	fe043783          	ld	a5,-32(s0)
    8000204e:	ef89                	bnez	a5,80002068 <uvmalloc+0x72>
      uvmdealloc(pagetable, a, oldsz);
    80002050:	fd043603          	ld	a2,-48(s0)
    80002054:	fe843583          	ld	a1,-24(s0)
    80002058:	fd843503          	ld	a0,-40(s0)
    8000205c:	00000097          	auipc	ra,0x0
    80002060:	08c080e7          	jalr	140(ra) # 800020e8 <uvmdealloc>
      return 0;
    80002064:	4781                	li	a5,0
    80002066:	a8a5                	j	800020de <uvmalloc+0xe8>
    }
    memset(mem, 0, PGSIZE);
    80002068:	6605                	lui	a2,0x1
    8000206a:	4581                	li	a1,0
    8000206c:	fe043503          	ld	a0,-32(s0)
    80002070:	fffff097          	auipc	ra,0xfffff
    80002074:	48e080e7          	jalr	1166(ra) # 800014fe <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80002078:	fe043683          	ld	a3,-32(s0)
    8000207c:	fc442783          	lw	a5,-60(s0)
    80002080:	0127e793          	ori	a5,a5,18
    80002084:	2781                	sext.w	a5,a5
    80002086:	873e                	mv	a4,a5
    80002088:	6605                	lui	a2,0x1
    8000208a:	fe843583          	ld	a1,-24(s0)
    8000208e:	fd843503          	ld	a0,-40(s0)
    80002092:	00000097          	auipc	ra,0x0
    80002096:	cc2080e7          	jalr	-830(ra) # 80001d54 <mappages>
    8000209a:	87aa                	mv	a5,a0
    8000209c:	c39d                	beqz	a5,800020c2 <uvmalloc+0xcc>
      kfree(mem);
    8000209e:	fe043503          	ld	a0,-32(s0)
    800020a2:	fffff097          	auipc	ra,0xfffff
    800020a6:	08e080e7          	jalr	142(ra) # 80001130 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800020aa:	fd043603          	ld	a2,-48(s0)
    800020ae:	fe843583          	ld	a1,-24(s0)
    800020b2:	fd843503          	ld	a0,-40(s0)
    800020b6:	00000097          	auipc	ra,0x0
    800020ba:	032080e7          	jalr	50(ra) # 800020e8 <uvmdealloc>
      return 0;
    800020be:	4781                	li	a5,0
    800020c0:	a839                	j	800020de <uvmalloc+0xe8>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800020c2:	fe843703          	ld	a4,-24(s0)
    800020c6:	6785                	lui	a5,0x1
    800020c8:	97ba                	add	a5,a5,a4
    800020ca:	fef43423          	sd	a5,-24(s0)
    800020ce:	fe843703          	ld	a4,-24(s0)
    800020d2:	fc843783          	ld	a5,-56(s0)
    800020d6:	f6f764e3          	bltu	a4,a5,8000203e <uvmalloc+0x48>
    }
  }
  return newsz;
    800020da:	fc843783          	ld	a5,-56(s0)
}
    800020de:	853e                	mv	a0,a5
    800020e0:	70e2                	ld	ra,56(sp)
    800020e2:	7442                	ld	s0,48(sp)
    800020e4:	6121                	addi	sp,sp,64
    800020e6:	8082                	ret

00000000800020e8 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800020e8:	7139                	addi	sp,sp,-64
    800020ea:	fc06                	sd	ra,56(sp)
    800020ec:	f822                	sd	s0,48(sp)
    800020ee:	0080                	addi	s0,sp,64
    800020f0:	fca43c23          	sd	a0,-40(s0)
    800020f4:	fcb43823          	sd	a1,-48(s0)
    800020f8:	fcc43423          	sd	a2,-56(s0)
  if(newsz >= oldsz)
    800020fc:	fc843703          	ld	a4,-56(s0)
    80002100:	fd043783          	ld	a5,-48(s0)
    80002104:	00f76563          	bltu	a4,a5,8000210e <uvmdealloc+0x26>
    return oldsz;
    80002108:	fd043783          	ld	a5,-48(s0)
    8000210c:	a885                	j	8000217c <uvmdealloc+0x94>

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000210e:	fc843703          	ld	a4,-56(s0)
    80002112:	6785                	lui	a5,0x1
    80002114:	17fd                	addi	a5,a5,-1
    80002116:	973e                	add	a4,a4,a5
    80002118:	77fd                	lui	a5,0xfffff
    8000211a:	8f7d                	and	a4,a4,a5
    8000211c:	fd043683          	ld	a3,-48(s0)
    80002120:	6785                	lui	a5,0x1
    80002122:	17fd                	addi	a5,a5,-1
    80002124:	96be                	add	a3,a3,a5
    80002126:	77fd                	lui	a5,0xfffff
    80002128:	8ff5                	and	a5,a5,a3
    8000212a:	04f77763          	bgeu	a4,a5,80002178 <uvmdealloc+0x90>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000212e:	fd043703          	ld	a4,-48(s0)
    80002132:	6785                	lui	a5,0x1
    80002134:	17fd                	addi	a5,a5,-1
    80002136:	973e                	add	a4,a4,a5
    80002138:	77fd                	lui	a5,0xfffff
    8000213a:	8f7d                	and	a4,a4,a5
    8000213c:	fc843683          	ld	a3,-56(s0)
    80002140:	6785                	lui	a5,0x1
    80002142:	17fd                	addi	a5,a5,-1
    80002144:	96be                	add	a3,a3,a5
    80002146:	77fd                	lui	a5,0xfffff
    80002148:	8ff5                	and	a5,a5,a3
    8000214a:	40f707b3          	sub	a5,a4,a5
    8000214e:	83b1                	srli	a5,a5,0xc
    80002150:	fef42623          	sw	a5,-20(s0)
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80002154:	fc843703          	ld	a4,-56(s0)
    80002158:	6785                	lui	a5,0x1
    8000215a:	17fd                	addi	a5,a5,-1
    8000215c:	973e                	add	a4,a4,a5
    8000215e:	77fd                	lui	a5,0xfffff
    80002160:	8ff9                	and	a5,a5,a4
    80002162:	fec42703          	lw	a4,-20(s0)
    80002166:	4685                	li	a3,1
    80002168:	863a                	mv	a2,a4
    8000216a:	85be                	mv	a1,a5
    8000216c:	fd843503          	ld	a0,-40(s0)
    80002170:	00000097          	auipc	ra,0x0
    80002174:	cc2080e7          	jalr	-830(ra) # 80001e32 <uvmunmap>
  }

  return newsz;
    80002178:	fc843783          	ld	a5,-56(s0)
}
    8000217c:	853e                	mv	a0,a5
    8000217e:	70e2                	ld	ra,56(sp)
    80002180:	7442                	ld	s0,48(sp)
    80002182:	6121                	addi	sp,sp,64
    80002184:	8082                	ret

0000000080002186 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80002186:	7139                	addi	sp,sp,-64
    80002188:	fc06                	sd	ra,56(sp)
    8000218a:	f822                	sd	s0,48(sp)
    8000218c:	0080                	addi	s0,sp,64
    8000218e:	fca43423          	sd	a0,-56(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80002192:	fe042623          	sw	zero,-20(s0)
    80002196:	a88d                	j	80002208 <freewalk+0x82>
    pte_t pte = pagetable[i];
    80002198:	fec42783          	lw	a5,-20(s0)
    8000219c:	078e                	slli	a5,a5,0x3
    8000219e:	fc843703          	ld	a4,-56(s0)
    800021a2:	97ba                	add	a5,a5,a4
    800021a4:	639c                	ld	a5,0(a5)
    800021a6:	fef43023          	sd	a5,-32(s0)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800021aa:	fe043783          	ld	a5,-32(s0)
    800021ae:	8b85                	andi	a5,a5,1
    800021b0:	cb9d                	beqz	a5,800021e6 <freewalk+0x60>
    800021b2:	fe043783          	ld	a5,-32(s0)
    800021b6:	8bb9                	andi	a5,a5,14
    800021b8:	e79d                	bnez	a5,800021e6 <freewalk+0x60>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800021ba:	fe043783          	ld	a5,-32(s0)
    800021be:	83a9                	srli	a5,a5,0xa
    800021c0:	07b2                	slli	a5,a5,0xc
    800021c2:	fcf43c23          	sd	a5,-40(s0)
      freewalk((pagetable_t)child);
    800021c6:	fd843783          	ld	a5,-40(s0)
    800021ca:	853e                	mv	a0,a5
    800021cc:	00000097          	auipc	ra,0x0
    800021d0:	fba080e7          	jalr	-70(ra) # 80002186 <freewalk>
      pagetable[i] = 0;
    800021d4:	fec42783          	lw	a5,-20(s0)
    800021d8:	078e                	slli	a5,a5,0x3
    800021da:	fc843703          	ld	a4,-56(s0)
    800021de:	97ba                	add	a5,a5,a4
    800021e0:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffda0d0>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800021e4:	a829                	j	800021fe <freewalk+0x78>
    } else if(pte & PTE_V){
    800021e6:	fe043783          	ld	a5,-32(s0)
    800021ea:	8b85                	andi	a5,a5,1
    800021ec:	cb89                	beqz	a5,800021fe <freewalk+0x78>
      panic("freewalk: leaf");
    800021ee:	00009517          	auipc	a0,0x9
    800021f2:	f8a50513          	addi	a0,a0,-118 # 8000b178 <etext+0x178>
    800021f6:	fffff097          	auipc	ra,0xfffff
    800021fa:	a96080e7          	jalr	-1386(ra) # 80000c8c <panic>
  for(int i = 0; i < 512; i++){
    800021fe:	fec42783          	lw	a5,-20(s0)
    80002202:	2785                	addiw	a5,a5,1
    80002204:	fef42623          	sw	a5,-20(s0)
    80002208:	fec42783          	lw	a5,-20(s0)
    8000220c:	0007871b          	sext.w	a4,a5
    80002210:	1ff00793          	li	a5,511
    80002214:	f8e7d2e3          	bge	a5,a4,80002198 <freewalk+0x12>
    }
  }
  kfree((void*)pagetable);
    80002218:	fc843503          	ld	a0,-56(s0)
    8000221c:	fffff097          	auipc	ra,0xfffff
    80002220:	f14080e7          	jalr	-236(ra) # 80001130 <kfree>
}
    80002224:	0001                	nop
    80002226:	70e2                	ld	ra,56(sp)
    80002228:	7442                	ld	s0,48(sp)
    8000222a:	6121                	addi	sp,sp,64
    8000222c:	8082                	ret

000000008000222e <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000222e:	1101                	addi	sp,sp,-32
    80002230:	ec06                	sd	ra,24(sp)
    80002232:	e822                	sd	s0,16(sp)
    80002234:	1000                	addi	s0,sp,32
    80002236:	fea43423          	sd	a0,-24(s0)
    8000223a:	feb43023          	sd	a1,-32(s0)
  if(sz > 0)
    8000223e:	fe043783          	ld	a5,-32(s0)
    80002242:	c385                	beqz	a5,80002262 <uvmfree+0x34>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80002244:	fe043703          	ld	a4,-32(s0)
    80002248:	6785                	lui	a5,0x1
    8000224a:	17fd                	addi	a5,a5,-1
    8000224c:	97ba                	add	a5,a5,a4
    8000224e:	83b1                	srli	a5,a5,0xc
    80002250:	4685                	li	a3,1
    80002252:	863e                	mv	a2,a5
    80002254:	4581                	li	a1,0
    80002256:	fe843503          	ld	a0,-24(s0)
    8000225a:	00000097          	auipc	ra,0x0
    8000225e:	bd8080e7          	jalr	-1064(ra) # 80001e32 <uvmunmap>
  freewalk(pagetable);
    80002262:	fe843503          	ld	a0,-24(s0)
    80002266:	00000097          	auipc	ra,0x0
    8000226a:	f20080e7          	jalr	-224(ra) # 80002186 <freewalk>
}
    8000226e:	0001                	nop
    80002270:	60e2                	ld	ra,24(sp)
    80002272:	6442                	ld	s0,16(sp)
    80002274:	6105                	addi	sp,sp,32
    80002276:	8082                	ret

0000000080002278 <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    80002278:	711d                	addi	sp,sp,-96
    8000227a:	ec86                	sd	ra,88(sp)
    8000227c:	e8a2                	sd	s0,80(sp)
    8000227e:	1080                	addi	s0,sp,96
    80002280:	faa43c23          	sd	a0,-72(s0)
    80002284:	fab43823          	sd	a1,-80(s0)
    80002288:	fac43423          	sd	a2,-88(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8000228c:	fe043423          	sd	zero,-24(s0)
    80002290:	a0d9                	j	80002356 <uvmcopy+0xde>
    if((pte = walk(old, i, 0)) == 0)
    80002292:	4601                	li	a2,0
    80002294:	fe843583          	ld	a1,-24(s0)
    80002298:	fb843503          	ld	a0,-72(s0)
    8000229c:	00000097          	auipc	ra,0x0
    800022a0:	902080e7          	jalr	-1790(ra) # 80001b9e <walk>
    800022a4:	fea43023          	sd	a0,-32(s0)
    800022a8:	fe043783          	ld	a5,-32(s0)
    800022ac:	eb89                	bnez	a5,800022be <uvmcopy+0x46>
      panic("uvmcopy: pte should exist");
    800022ae:	00009517          	auipc	a0,0x9
    800022b2:	eda50513          	addi	a0,a0,-294 # 8000b188 <etext+0x188>
    800022b6:	fffff097          	auipc	ra,0xfffff
    800022ba:	9d6080e7          	jalr	-1578(ra) # 80000c8c <panic>
    if((*pte & PTE_V) == 0)
    800022be:	fe043783          	ld	a5,-32(s0)
    800022c2:	639c                	ld	a5,0(a5)
    800022c4:	8b85                	andi	a5,a5,1
    800022c6:	eb89                	bnez	a5,800022d8 <uvmcopy+0x60>
      panic("uvmcopy: page not present");
    800022c8:	00009517          	auipc	a0,0x9
    800022cc:	ee050513          	addi	a0,a0,-288 # 8000b1a8 <etext+0x1a8>
    800022d0:	fffff097          	auipc	ra,0xfffff
    800022d4:	9bc080e7          	jalr	-1604(ra) # 80000c8c <panic>
    pa = PTE2PA(*pte);
    800022d8:	fe043783          	ld	a5,-32(s0)
    800022dc:	639c                	ld	a5,0(a5)
    800022de:	83a9                	srli	a5,a5,0xa
    800022e0:	07b2                	slli	a5,a5,0xc
    800022e2:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    800022e6:	fe043783          	ld	a5,-32(s0)
    800022ea:	639c                	ld	a5,0(a5)
    800022ec:	2781                	sext.w	a5,a5
    800022ee:	3ff7f793          	andi	a5,a5,1023
    800022f2:	fcf42a23          	sw	a5,-44(s0)
    if((mem = kalloc()) == 0)
    800022f6:	fffff097          	auipc	ra,0xfffff
    800022fa:	ee0080e7          	jalr	-288(ra) # 800011d6 <kalloc>
    800022fe:	fca43423          	sd	a0,-56(s0)
    80002302:	fc843783          	ld	a5,-56(s0)
    80002306:	c3a5                	beqz	a5,80002366 <uvmcopy+0xee>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80002308:	fd843783          	ld	a5,-40(s0)
    8000230c:	6605                	lui	a2,0x1
    8000230e:	85be                	mv	a1,a5
    80002310:	fc843503          	ld	a0,-56(s0)
    80002314:	fffff097          	auipc	ra,0xfffff
    80002318:	2ce080e7          	jalr	718(ra) # 800015e2 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    8000231c:	fc843783          	ld	a5,-56(s0)
    80002320:	fd442703          	lw	a4,-44(s0)
    80002324:	86be                	mv	a3,a5
    80002326:	6605                	lui	a2,0x1
    80002328:	fe843583          	ld	a1,-24(s0)
    8000232c:	fb043503          	ld	a0,-80(s0)
    80002330:	00000097          	auipc	ra,0x0
    80002334:	a24080e7          	jalr	-1500(ra) # 80001d54 <mappages>
    80002338:	87aa                	mv	a5,a0
    8000233a:	cb81                	beqz	a5,8000234a <uvmcopy+0xd2>
      kfree(mem);
    8000233c:	fc843503          	ld	a0,-56(s0)
    80002340:	fffff097          	auipc	ra,0xfffff
    80002344:	df0080e7          	jalr	-528(ra) # 80001130 <kfree>
      goto err;
    80002348:	a005                	j	80002368 <uvmcopy+0xf0>
  for(i = 0; i < sz; i += PGSIZE){
    8000234a:	fe843703          	ld	a4,-24(s0)
    8000234e:	6785                	lui	a5,0x1
    80002350:	97ba                	add	a5,a5,a4
    80002352:	fef43423          	sd	a5,-24(s0)
    80002356:	fe843703          	ld	a4,-24(s0)
    8000235a:	fa843783          	ld	a5,-88(s0)
    8000235e:	f2f76ae3          	bltu	a4,a5,80002292 <uvmcopy+0x1a>
    }
  }
  return 0;
    80002362:	4781                	li	a5,0
    80002364:	a839                	j	80002382 <uvmcopy+0x10a>
      goto err;
    80002366:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80002368:	fe843783          	ld	a5,-24(s0)
    8000236c:	83b1                	srli	a5,a5,0xc
    8000236e:	4685                	li	a3,1
    80002370:	863e                	mv	a2,a5
    80002372:	4581                	li	a1,0
    80002374:	fb043503          	ld	a0,-80(s0)
    80002378:	00000097          	auipc	ra,0x0
    8000237c:	aba080e7          	jalr	-1350(ra) # 80001e32 <uvmunmap>
  return -1;
    80002380:	57fd                	li	a5,-1
}
    80002382:	853e                	mv	a0,a5
    80002384:	60e6                	ld	ra,88(sp)
    80002386:	6446                	ld	s0,80(sp)
    80002388:	6125                	addi	sp,sp,96
    8000238a:	8082                	ret

000000008000238c <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000238c:	7179                	addi	sp,sp,-48
    8000238e:	f406                	sd	ra,40(sp)
    80002390:	f022                	sd	s0,32(sp)
    80002392:	1800                	addi	s0,sp,48
    80002394:	fca43c23          	sd	a0,-40(s0)
    80002398:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000239c:	4601                	li	a2,0
    8000239e:	fd043583          	ld	a1,-48(s0)
    800023a2:	fd843503          	ld	a0,-40(s0)
    800023a6:	fffff097          	auipc	ra,0xfffff
    800023aa:	7f8080e7          	jalr	2040(ra) # 80001b9e <walk>
    800023ae:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    800023b2:	fe843783          	ld	a5,-24(s0)
    800023b6:	eb89                	bnez	a5,800023c8 <uvmclear+0x3c>
    panic("uvmclear");
    800023b8:	00009517          	auipc	a0,0x9
    800023bc:	e1050513          	addi	a0,a0,-496 # 8000b1c8 <etext+0x1c8>
    800023c0:	fffff097          	auipc	ra,0xfffff
    800023c4:	8cc080e7          	jalr	-1844(ra) # 80000c8c <panic>
  *pte &= ~PTE_U;
    800023c8:	fe843783          	ld	a5,-24(s0)
    800023cc:	639c                	ld	a5,0(a5)
    800023ce:	fef7f713          	andi	a4,a5,-17
    800023d2:	fe843783          	ld	a5,-24(s0)
    800023d6:	e398                	sd	a4,0(a5)
}
    800023d8:	0001                	nop
    800023da:	70a2                	ld	ra,40(sp)
    800023dc:	7402                	ld	s0,32(sp)
    800023de:	6145                	addi	sp,sp,48
    800023e0:	8082                	ret

00000000800023e2 <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800023e2:	715d                	addi	sp,sp,-80
    800023e4:	e486                	sd	ra,72(sp)
    800023e6:	e0a2                	sd	s0,64(sp)
    800023e8:	0880                	addi	s0,sp,80
    800023ea:	fca43423          	sd	a0,-56(s0)
    800023ee:	fcb43023          	sd	a1,-64(s0)
    800023f2:	fac43c23          	sd	a2,-72(s0)
    800023f6:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800023fa:	a055                	j	8000249e <copyout+0xbc>
    va0 = PGROUNDDOWN(dstva);
    800023fc:	fc043703          	ld	a4,-64(s0)
    80002400:	77fd                	lui	a5,0xfffff
    80002402:	8ff9                	and	a5,a5,a4
    80002404:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    80002408:	fe043583          	ld	a1,-32(s0)
    8000240c:	fc843503          	ld	a0,-56(s0)
    80002410:	00000097          	auipc	ra,0x0
    80002414:	872080e7          	jalr	-1934(ra) # 80001c82 <walkaddr>
    80002418:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    8000241c:	fd843783          	ld	a5,-40(s0)
    80002420:	e399                	bnez	a5,80002426 <copyout+0x44>
      return -1;
    80002422:	57fd                	li	a5,-1
    80002424:	a049                	j	800024a6 <copyout+0xc4>
    n = PGSIZE - (dstva - va0);
    80002426:	fe043703          	ld	a4,-32(s0)
    8000242a:	fc043783          	ld	a5,-64(s0)
    8000242e:	8f1d                	sub	a4,a4,a5
    80002430:	6785                	lui	a5,0x1
    80002432:	97ba                	add	a5,a5,a4
    80002434:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    80002438:	fe843703          	ld	a4,-24(s0)
    8000243c:	fb043783          	ld	a5,-80(s0)
    80002440:	00e7f663          	bgeu	a5,a4,8000244c <copyout+0x6a>
      n = len;
    80002444:	fb043783          	ld	a5,-80(s0)
    80002448:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    8000244c:	fc043703          	ld	a4,-64(s0)
    80002450:	fe043783          	ld	a5,-32(s0)
    80002454:	8f1d                	sub	a4,a4,a5
    80002456:	fd843783          	ld	a5,-40(s0)
    8000245a:	97ba                	add	a5,a5,a4
    8000245c:	873e                	mv	a4,a5
    8000245e:	fe843783          	ld	a5,-24(s0)
    80002462:	2781                	sext.w	a5,a5
    80002464:	863e                	mv	a2,a5
    80002466:	fb843583          	ld	a1,-72(s0)
    8000246a:	853a                	mv	a0,a4
    8000246c:	fffff097          	auipc	ra,0xfffff
    80002470:	176080e7          	jalr	374(ra) # 800015e2 <memmove>

    len -= n;
    80002474:	fb043703          	ld	a4,-80(s0)
    80002478:	fe843783          	ld	a5,-24(s0)
    8000247c:	40f707b3          	sub	a5,a4,a5
    80002480:	faf43823          	sd	a5,-80(s0)
    src += n;
    80002484:	fb843703          	ld	a4,-72(s0)
    80002488:	fe843783          	ld	a5,-24(s0)
    8000248c:	97ba                	add	a5,a5,a4
    8000248e:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    80002492:	fe043703          	ld	a4,-32(s0)
    80002496:	6785                	lui	a5,0x1
    80002498:	97ba                	add	a5,a5,a4
    8000249a:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    8000249e:	fb043783          	ld	a5,-80(s0)
    800024a2:	ffa9                	bnez	a5,800023fc <copyout+0x1a>
  }
  return 0;
    800024a4:	4781                	li	a5,0
}
    800024a6:	853e                	mv	a0,a5
    800024a8:	60a6                	ld	ra,72(sp)
    800024aa:	6406                	ld	s0,64(sp)
    800024ac:	6161                	addi	sp,sp,80
    800024ae:	8082                	ret

00000000800024b0 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    800024b0:	715d                	addi	sp,sp,-80
    800024b2:	e486                	sd	ra,72(sp)
    800024b4:	e0a2                	sd	s0,64(sp)
    800024b6:	0880                	addi	s0,sp,80
    800024b8:	fca43423          	sd	a0,-56(s0)
    800024bc:	fcb43023          	sd	a1,-64(s0)
    800024c0:	fac43c23          	sd	a2,-72(s0)
    800024c4:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800024c8:	a055                	j	8000256c <copyin+0xbc>
    va0 = PGROUNDDOWN(srcva);
    800024ca:	fb843703          	ld	a4,-72(s0)
    800024ce:	77fd                	lui	a5,0xfffff
    800024d0:	8ff9                	and	a5,a5,a4
    800024d2:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800024d6:	fe043583          	ld	a1,-32(s0)
    800024da:	fc843503          	ld	a0,-56(s0)
    800024de:	fffff097          	auipc	ra,0xfffff
    800024e2:	7a4080e7          	jalr	1956(ra) # 80001c82 <walkaddr>
    800024e6:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    800024ea:	fd843783          	ld	a5,-40(s0)
    800024ee:	e399                	bnez	a5,800024f4 <copyin+0x44>
      return -1;
    800024f0:	57fd                	li	a5,-1
    800024f2:	a049                	j	80002574 <copyin+0xc4>
    n = PGSIZE - (srcva - va0);
    800024f4:	fe043703          	ld	a4,-32(s0)
    800024f8:	fb843783          	ld	a5,-72(s0)
    800024fc:	8f1d                	sub	a4,a4,a5
    800024fe:	6785                	lui	a5,0x1
    80002500:	97ba                	add	a5,a5,a4
    80002502:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    80002506:	fe843703          	ld	a4,-24(s0)
    8000250a:	fb043783          	ld	a5,-80(s0)
    8000250e:	00e7f663          	bgeu	a5,a4,8000251a <copyin+0x6a>
      n = len;
    80002512:	fb043783          	ld	a5,-80(s0)
    80002516:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000251a:	fb843703          	ld	a4,-72(s0)
    8000251e:	fe043783          	ld	a5,-32(s0)
    80002522:	8f1d                	sub	a4,a4,a5
    80002524:	fd843783          	ld	a5,-40(s0)
    80002528:	97ba                	add	a5,a5,a4
    8000252a:	873e                	mv	a4,a5
    8000252c:	fe843783          	ld	a5,-24(s0)
    80002530:	2781                	sext.w	a5,a5
    80002532:	863e                	mv	a2,a5
    80002534:	85ba                	mv	a1,a4
    80002536:	fc043503          	ld	a0,-64(s0)
    8000253a:	fffff097          	auipc	ra,0xfffff
    8000253e:	0a8080e7          	jalr	168(ra) # 800015e2 <memmove>

    len -= n;
    80002542:	fb043703          	ld	a4,-80(s0)
    80002546:	fe843783          	ld	a5,-24(s0)
    8000254a:	40f707b3          	sub	a5,a4,a5
    8000254e:	faf43823          	sd	a5,-80(s0)
    dst += n;
    80002552:	fc043703          	ld	a4,-64(s0)
    80002556:	fe843783          	ld	a5,-24(s0)
    8000255a:	97ba                	add	a5,a5,a4
    8000255c:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    80002560:	fe043703          	ld	a4,-32(s0)
    80002564:	6785                	lui	a5,0x1
    80002566:	97ba                	add	a5,a5,a4
    80002568:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    8000256c:	fb043783          	ld	a5,-80(s0)
    80002570:	ffa9                	bnez	a5,800024ca <copyin+0x1a>
  }
  return 0;
    80002572:	4781                	li	a5,0
}
    80002574:	853e                	mv	a0,a5
    80002576:	60a6                	ld	ra,72(sp)
    80002578:	6406                	ld	s0,64(sp)
    8000257a:	6161                	addi	sp,sp,80
    8000257c:	8082                	ret

000000008000257e <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    8000257e:	711d                	addi	sp,sp,-96
    80002580:	ec86                	sd	ra,88(sp)
    80002582:	e8a2                	sd	s0,80(sp)
    80002584:	1080                	addi	s0,sp,96
    80002586:	faa43c23          	sd	a0,-72(s0)
    8000258a:	fab43823          	sd	a1,-80(s0)
    8000258e:	fac43423          	sd	a2,-88(s0)
    80002592:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    80002596:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    8000259a:	a0f1                	j	80002666 <copyinstr+0xe8>
    va0 = PGROUNDDOWN(srcva);
    8000259c:	fa843703          	ld	a4,-88(s0)
    800025a0:	77fd                	lui	a5,0xfffff
    800025a2:	8ff9                	and	a5,a5,a4
    800025a4:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    800025a8:	fd043583          	ld	a1,-48(s0)
    800025ac:	fb843503          	ld	a0,-72(s0)
    800025b0:	fffff097          	auipc	ra,0xfffff
    800025b4:	6d2080e7          	jalr	1746(ra) # 80001c82 <walkaddr>
    800025b8:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    800025bc:	fc843783          	ld	a5,-56(s0)
    800025c0:	e399                	bnez	a5,800025c6 <copyinstr+0x48>
      return -1;
    800025c2:	57fd                	li	a5,-1
    800025c4:	a87d                	j	80002682 <copyinstr+0x104>
    n = PGSIZE - (srcva - va0);
    800025c6:	fd043703          	ld	a4,-48(s0)
    800025ca:	fa843783          	ld	a5,-88(s0)
    800025ce:	8f1d                	sub	a4,a4,a5
    800025d0:	6785                	lui	a5,0x1
    800025d2:	97ba                	add	a5,a5,a4
    800025d4:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    800025d8:	fe843703          	ld	a4,-24(s0)
    800025dc:	fa043783          	ld	a5,-96(s0)
    800025e0:	00e7f663          	bgeu	a5,a4,800025ec <copyinstr+0x6e>
      n = max;
    800025e4:	fa043783          	ld	a5,-96(s0)
    800025e8:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    800025ec:	fa843703          	ld	a4,-88(s0)
    800025f0:	fd043783          	ld	a5,-48(s0)
    800025f4:	8f1d                	sub	a4,a4,a5
    800025f6:	fc843783          	ld	a5,-56(s0)
    800025fa:	97ba                	add	a5,a5,a4
    800025fc:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    80002600:	a891                	j	80002654 <copyinstr+0xd6>
      if(*p == '\0'){
    80002602:	fd843783          	ld	a5,-40(s0)
    80002606:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    8000260a:	eb89                	bnez	a5,8000261c <copyinstr+0x9e>
        *dst = '\0';
    8000260c:	fb043783          	ld	a5,-80(s0)
    80002610:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80002614:	4785                	li	a5,1
    80002616:	fef42223          	sw	a5,-28(s0)
        break;
    8000261a:	a081                	j	8000265a <copyinstr+0xdc>
      } else {
        *dst = *p;
    8000261c:	fd843783          	ld	a5,-40(s0)
    80002620:	0007c703          	lbu	a4,0(a5)
    80002624:	fb043783          	ld	a5,-80(s0)
    80002628:	00e78023          	sb	a4,0(a5)
      }
      --n;
    8000262c:	fe843783          	ld	a5,-24(s0)
    80002630:	17fd                	addi	a5,a5,-1
    80002632:	fef43423          	sd	a5,-24(s0)
      --max;
    80002636:	fa043783          	ld	a5,-96(s0)
    8000263a:	17fd                	addi	a5,a5,-1
    8000263c:	faf43023          	sd	a5,-96(s0)
      p++;
    80002640:	fd843783          	ld	a5,-40(s0)
    80002644:	0785                	addi	a5,a5,1
    80002646:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    8000264a:	fb043783          	ld	a5,-80(s0)
    8000264e:	0785                	addi	a5,a5,1
    80002650:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    80002654:	fe843783          	ld	a5,-24(s0)
    80002658:	f7cd                	bnez	a5,80002602 <copyinstr+0x84>
    }

    srcva = va0 + PGSIZE;
    8000265a:	fd043703          	ld	a4,-48(s0)
    8000265e:	6785                	lui	a5,0x1
    80002660:	97ba                	add	a5,a5,a4
    80002662:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    80002666:	fe442783          	lw	a5,-28(s0)
    8000266a:	2781                	sext.w	a5,a5
    8000266c:	e781                	bnez	a5,80002674 <copyinstr+0xf6>
    8000266e:	fa043783          	ld	a5,-96(s0)
    80002672:	f78d                	bnez	a5,8000259c <copyinstr+0x1e>
  }
  if(got_null){
    80002674:	fe442783          	lw	a5,-28(s0)
    80002678:	2781                	sext.w	a5,a5
    8000267a:	c399                	beqz	a5,80002680 <copyinstr+0x102>
    return 0;
    8000267c:	4781                	li	a5,0
    8000267e:	a011                	j	80002682 <copyinstr+0x104>
  } else {
    return -1;
    80002680:	57fd                	li	a5,-1
  }
}
    80002682:	853e                	mv	a0,a5
    80002684:	60e6                	ld	ra,88(sp)
    80002686:	6446                	ld	s0,80(sp)
    80002688:	6125                	addi	sp,sp,96
    8000268a:	8082                	ret

000000008000268c <r_sstatus>:
{
    8000268c:	1101                	addi	sp,sp,-32
    8000268e:	ec22                	sd	s0,24(sp)
    80002690:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002692:	100027f3          	csrr	a5,sstatus
    80002696:	fef43423          	sd	a5,-24(s0)
  return x;
    8000269a:	fe843783          	ld	a5,-24(s0)
}
    8000269e:	853e                	mv	a0,a5
    800026a0:	6462                	ld	s0,24(sp)
    800026a2:	6105                	addi	sp,sp,32
    800026a4:	8082                	ret

00000000800026a6 <w_sstatus>:
{
    800026a6:	1101                	addi	sp,sp,-32
    800026a8:	ec22                	sd	s0,24(sp)
    800026aa:	1000                	addi	s0,sp,32
    800026ac:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800026b0:	fe843783          	ld	a5,-24(s0)
    800026b4:	10079073          	csrw	sstatus,a5
}
    800026b8:	0001                	nop
    800026ba:	6462                	ld	s0,24(sp)
    800026bc:	6105                	addi	sp,sp,32
    800026be:	8082                	ret

00000000800026c0 <intr_on>:
{
    800026c0:	1141                	addi	sp,sp,-16
    800026c2:	e406                	sd	ra,8(sp)
    800026c4:	e022                	sd	s0,0(sp)
    800026c6:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800026c8:	00000097          	auipc	ra,0x0
    800026cc:	fc4080e7          	jalr	-60(ra) # 8000268c <r_sstatus>
    800026d0:	87aa                	mv	a5,a0
    800026d2:	0027e793          	ori	a5,a5,2
    800026d6:	853e                	mv	a0,a5
    800026d8:	00000097          	auipc	ra,0x0
    800026dc:	fce080e7          	jalr	-50(ra) # 800026a6 <w_sstatus>
}
    800026e0:	0001                	nop
    800026e2:	60a2                	ld	ra,8(sp)
    800026e4:	6402                	ld	s0,0(sp)
    800026e6:	0141                	addi	sp,sp,16
    800026e8:	8082                	ret

00000000800026ea <intr_get>:
{
    800026ea:	1101                	addi	sp,sp,-32
    800026ec:	ec06                	sd	ra,24(sp)
    800026ee:	e822                	sd	s0,16(sp)
    800026f0:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800026f2:	00000097          	auipc	ra,0x0
    800026f6:	f9a080e7          	jalr	-102(ra) # 8000268c <r_sstatus>
    800026fa:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800026fe:	fe843783          	ld	a5,-24(s0)
    80002702:	8b89                	andi	a5,a5,2
    80002704:	00f037b3          	snez	a5,a5
    80002708:	0ff7f793          	andi	a5,a5,255
    8000270c:	2781                	sext.w	a5,a5
}
    8000270e:	853e                	mv	a0,a5
    80002710:	60e2                	ld	ra,24(sp)
    80002712:	6442                	ld	s0,16(sp)
    80002714:	6105                	addi	sp,sp,32
    80002716:	8082                	ret

0000000080002718 <r_tp>:
{
    80002718:	1101                	addi	sp,sp,-32
    8000271a:	ec22                	sd	s0,24(sp)
    8000271c:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    8000271e:	8792                	mv	a5,tp
    80002720:	fef43423          	sd	a5,-24(s0)
  return x;
    80002724:	fe843783          	ld	a5,-24(s0)
}
    80002728:	853e                	mv	a0,a5
    8000272a:	6462                	ld	s0,24(sp)
    8000272c:	6105                	addi	sp,sp,32
    8000272e:	8082                	ret

0000000080002730 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80002730:	7139                	addi	sp,sp,-64
    80002732:	fc06                	sd	ra,56(sp)
    80002734:	f822                	sd	s0,48(sp)
    80002736:	0080                	addi	s0,sp,64
    80002738:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    8000273c:	00012797          	auipc	a5,0x12
    80002740:	87c78793          	addi	a5,a5,-1924 # 80013fb8 <proc>
    80002744:	fef43423          	sd	a5,-24(s0)
    80002748:	a061                	j	800027d0 <proc_mapstacks+0xa0>
    char *pa = kalloc();
    8000274a:	fffff097          	auipc	ra,0xfffff
    8000274e:	a8c080e7          	jalr	-1396(ra) # 800011d6 <kalloc>
    80002752:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80002756:	fe043783          	ld	a5,-32(s0)
    8000275a:	eb89                	bnez	a5,8000276c <proc_mapstacks+0x3c>
      panic("kalloc");
    8000275c:	00009517          	auipc	a0,0x9
    80002760:	a7c50513          	addi	a0,a0,-1412 # 8000b1d8 <etext+0x1d8>
    80002764:	ffffe097          	auipc	ra,0xffffe
    80002768:	528080e7          	jalr	1320(ra) # 80000c8c <panic>
    uint64 va = KSTACK((int) (p - proc));
    8000276c:	fe843703          	ld	a4,-24(s0)
    80002770:	00012797          	auipc	a5,0x12
    80002774:	84878793          	addi	a5,a5,-1976 # 80013fb8 <proc>
    80002778:	40f707b3          	sub	a5,a4,a5
    8000277c:	4037d713          	srai	a4,a5,0x3
    80002780:	00009797          	auipc	a5,0x9
    80002784:	b5078793          	addi	a5,a5,-1200 # 8000b2d0 <etext+0x2d0>
    80002788:	639c                	ld	a5,0(a5)
    8000278a:	02f707b3          	mul	a5,a4,a5
    8000278e:	2781                	sext.w	a5,a5
    80002790:	2785                	addiw	a5,a5,1
    80002792:	2781                	sext.w	a5,a5
    80002794:	00d7979b          	slliw	a5,a5,0xd
    80002798:	2781                	sext.w	a5,a5
    8000279a:	873e                	mv	a4,a5
    8000279c:	040007b7          	lui	a5,0x4000
    800027a0:	17fd                	addi	a5,a5,-1
    800027a2:	07b2                	slli	a5,a5,0xc
    800027a4:	8f99                	sub	a5,a5,a4
    800027a6:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800027aa:	fe043783          	ld	a5,-32(s0)
    800027ae:	4719                	li	a4,6
    800027b0:	6685                	lui	a3,0x1
    800027b2:	863e                	mv	a2,a5
    800027b4:	fd843583          	ld	a1,-40(s0)
    800027b8:	fc843503          	ld	a0,-56(s0)
    800027bc:	fffff097          	auipc	ra,0xfffff
    800027c0:	53e080e7          	jalr	1342(ra) # 80001cfa <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800027c4:	fe843783          	ld	a5,-24(s0)
    800027c8:	16878793          	addi	a5,a5,360 # 4000168 <_entry-0x7bfffe98>
    800027cc:	fef43423          	sd	a5,-24(s0)
    800027d0:	fe843703          	ld	a4,-24(s0)
    800027d4:	00017797          	auipc	a5,0x17
    800027d8:	1e478793          	addi	a5,a5,484 # 800199b8 <pid_lock>
    800027dc:	f6f767e3          	bltu	a4,a5,8000274a <proc_mapstacks+0x1a>
  }
}
    800027e0:	0001                	nop
    800027e2:	0001                	nop
    800027e4:	70e2                	ld	ra,56(sp)
    800027e6:	7442                	ld	s0,48(sp)
    800027e8:	6121                	addi	sp,sp,64
    800027ea:	8082                	ret

00000000800027ec <procinit>:

// initialize the proc table.
void
procinit(void)
{
    800027ec:	1101                	addi	sp,sp,-32
    800027ee:	ec06                	sd	ra,24(sp)
    800027f0:	e822                	sd	s0,16(sp)
    800027f2:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800027f4:	00009597          	auipc	a1,0x9
    800027f8:	9ec58593          	addi	a1,a1,-1556 # 8000b1e0 <etext+0x1e0>
    800027fc:	00017517          	auipc	a0,0x17
    80002800:	1bc50513          	addi	a0,a0,444 # 800199b8 <pid_lock>
    80002804:	fffff097          	auipc	ra,0xfffff
    80002808:	af6080e7          	jalr	-1290(ra) # 800012fa <initlock>
  initlock(&wait_lock, "wait_lock");
    8000280c:	00009597          	auipc	a1,0x9
    80002810:	9dc58593          	addi	a1,a1,-1572 # 8000b1e8 <etext+0x1e8>
    80002814:	00017517          	auipc	a0,0x17
    80002818:	1bc50513          	addi	a0,a0,444 # 800199d0 <wait_lock>
    8000281c:	fffff097          	auipc	ra,0xfffff
    80002820:	ade080e7          	jalr	-1314(ra) # 800012fa <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002824:	00011797          	auipc	a5,0x11
    80002828:	79478793          	addi	a5,a5,1940 # 80013fb8 <proc>
    8000282c:	fef43423          	sd	a5,-24(s0)
    80002830:	a0bd                	j	8000289e <procinit+0xb2>
      initlock(&p->lock, "proc");
    80002832:	fe843783          	ld	a5,-24(s0)
    80002836:	00009597          	auipc	a1,0x9
    8000283a:	9c258593          	addi	a1,a1,-1598 # 8000b1f8 <etext+0x1f8>
    8000283e:	853e                	mv	a0,a5
    80002840:	fffff097          	auipc	ra,0xfffff
    80002844:	aba080e7          	jalr	-1350(ra) # 800012fa <initlock>
      p->state = UNUSED;
    80002848:	fe843783          	ld	a5,-24(s0)
    8000284c:	0007ac23          	sw	zero,24(a5)
      p->kstack = KSTACK((int) (p - proc));
    80002850:	fe843703          	ld	a4,-24(s0)
    80002854:	00011797          	auipc	a5,0x11
    80002858:	76478793          	addi	a5,a5,1892 # 80013fb8 <proc>
    8000285c:	40f707b3          	sub	a5,a4,a5
    80002860:	4037d713          	srai	a4,a5,0x3
    80002864:	00009797          	auipc	a5,0x9
    80002868:	a6c78793          	addi	a5,a5,-1428 # 8000b2d0 <etext+0x2d0>
    8000286c:	639c                	ld	a5,0(a5)
    8000286e:	02f707b3          	mul	a5,a4,a5
    80002872:	2781                	sext.w	a5,a5
    80002874:	2785                	addiw	a5,a5,1
    80002876:	2781                	sext.w	a5,a5
    80002878:	00d7979b          	slliw	a5,a5,0xd
    8000287c:	2781                	sext.w	a5,a5
    8000287e:	873e                	mv	a4,a5
    80002880:	040007b7          	lui	a5,0x4000
    80002884:	17fd                	addi	a5,a5,-1
    80002886:	07b2                	slli	a5,a5,0xc
    80002888:	8f99                	sub	a5,a5,a4
    8000288a:	873e                	mv	a4,a5
    8000288c:	fe843783          	ld	a5,-24(s0)
    80002890:	e3b8                	sd	a4,64(a5)
  for(p = proc; p < &proc[NPROC]; p++) {
    80002892:	fe843783          	ld	a5,-24(s0)
    80002896:	16878793          	addi	a5,a5,360 # 4000168 <_entry-0x7bfffe98>
    8000289a:	fef43423          	sd	a5,-24(s0)
    8000289e:	fe843703          	ld	a4,-24(s0)
    800028a2:	00017797          	auipc	a5,0x17
    800028a6:	11678793          	addi	a5,a5,278 # 800199b8 <pid_lock>
    800028aa:	f8f764e3          	bltu	a4,a5,80002832 <procinit+0x46>
  }
}
    800028ae:	0001                	nop
    800028b0:	0001                	nop
    800028b2:	60e2                	ld	ra,24(sp)
    800028b4:	6442                	ld	s0,16(sp)
    800028b6:	6105                	addi	sp,sp,32
    800028b8:	8082                	ret

00000000800028ba <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800028ba:	1101                	addi	sp,sp,-32
    800028bc:	ec06                	sd	ra,24(sp)
    800028be:	e822                	sd	s0,16(sp)
    800028c0:	1000                	addi	s0,sp,32
  int id = r_tp();
    800028c2:	00000097          	auipc	ra,0x0
    800028c6:	e56080e7          	jalr	-426(ra) # 80002718 <r_tp>
    800028ca:	87aa                	mv	a5,a0
    800028cc:	fef42623          	sw	a5,-20(s0)
  return id;
    800028d0:	fec42783          	lw	a5,-20(s0)
}
    800028d4:	853e                	mv	a0,a5
    800028d6:	60e2                	ld	ra,24(sp)
    800028d8:	6442                	ld	s0,16(sp)
    800028da:	6105                	addi	sp,sp,32
    800028dc:	8082                	ret

00000000800028de <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    800028de:	1101                	addi	sp,sp,-32
    800028e0:	ec06                	sd	ra,24(sp)
    800028e2:	e822                	sd	s0,16(sp)
    800028e4:	1000                	addi	s0,sp,32
  int id = cpuid();
    800028e6:	00000097          	auipc	ra,0x0
    800028ea:	fd4080e7          	jalr	-44(ra) # 800028ba <cpuid>
    800028ee:	87aa                	mv	a5,a0
    800028f0:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    800028f4:	fec42783          	lw	a5,-20(s0)
    800028f8:	00779713          	slli	a4,a5,0x7
    800028fc:	00011797          	auipc	a5,0x11
    80002900:	2bc78793          	addi	a5,a5,700 # 80013bb8 <cpus>
    80002904:	97ba                	add	a5,a5,a4
    80002906:	fef43023          	sd	a5,-32(s0)
  return c;
    8000290a:	fe043783          	ld	a5,-32(s0)
}
    8000290e:	853e                	mv	a0,a5
    80002910:	60e2                	ld	ra,24(sp)
    80002912:	6442                	ld	s0,16(sp)
    80002914:	6105                	addi	sp,sp,32
    80002916:	8082                	ret

0000000080002918 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80002918:	1101                	addi	sp,sp,-32
    8000291a:	ec06                	sd	ra,24(sp)
    8000291c:	e822                	sd	s0,16(sp)
    8000291e:	1000                	addi	s0,sp,32
  push_off();
    80002920:	fffff097          	auipc	ra,0xfffff
    80002924:	b08080e7          	jalr	-1272(ra) # 80001428 <push_off>
  struct cpu *c = mycpu();
    80002928:	00000097          	auipc	ra,0x0
    8000292c:	fb6080e7          	jalr	-74(ra) # 800028de <mycpu>
    80002930:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    80002934:	fe843783          	ld	a5,-24(s0)
    80002938:	639c                	ld	a5,0(a5)
    8000293a:	fef43023          	sd	a5,-32(s0)
  pop_off();
    8000293e:	fffff097          	auipc	ra,0xfffff
    80002942:	b42080e7          	jalr	-1214(ra) # 80001480 <pop_off>
  return p;
    80002946:	fe043783          	ld	a5,-32(s0)
}
    8000294a:	853e                	mv	a0,a5
    8000294c:	60e2                	ld	ra,24(sp)
    8000294e:	6442                	ld	s0,16(sp)
    80002950:	6105                	addi	sp,sp,32
    80002952:	8082                	ret

0000000080002954 <allocpid>:

int
allocpid()
{
    80002954:	1101                	addi	sp,sp,-32
    80002956:	ec06                	sd	ra,24(sp)
    80002958:	e822                	sd	s0,16(sp)
    8000295a:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    8000295c:	00017517          	auipc	a0,0x17
    80002960:	05c50513          	addi	a0,a0,92 # 800199b8 <pid_lock>
    80002964:	fffff097          	auipc	ra,0xfffff
    80002968:	9c6080e7          	jalr	-1594(ra) # 8000132a <acquire>
  pid = nextpid;
    8000296c:	00009797          	auipc	a5,0x9
    80002970:	e5478793          	addi	a5,a5,-428 # 8000b7c0 <nextpid>
    80002974:	439c                	lw	a5,0(a5)
    80002976:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    8000297a:	00009797          	auipc	a5,0x9
    8000297e:	e4678793          	addi	a5,a5,-442 # 8000b7c0 <nextpid>
    80002982:	439c                	lw	a5,0(a5)
    80002984:	2785                	addiw	a5,a5,1
    80002986:	0007871b          	sext.w	a4,a5
    8000298a:	00009797          	auipc	a5,0x9
    8000298e:	e3678793          	addi	a5,a5,-458 # 8000b7c0 <nextpid>
    80002992:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80002994:	00017517          	auipc	a0,0x17
    80002998:	02450513          	addi	a0,a0,36 # 800199b8 <pid_lock>
    8000299c:	fffff097          	auipc	ra,0xfffff
    800029a0:	9f2080e7          	jalr	-1550(ra) # 8000138e <release>

  return pid;
    800029a4:	fec42783          	lw	a5,-20(s0)
}
    800029a8:	853e                	mv	a0,a5
    800029aa:	60e2                	ld	ra,24(sp)
    800029ac:	6442                	ld	s0,16(sp)
    800029ae:	6105                	addi	sp,sp,32
    800029b0:	8082                	ret

00000000800029b2 <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    800029b2:	1101                	addi	sp,sp,-32
    800029b4:	ec06                	sd	ra,24(sp)
    800029b6:	e822                	sd	s0,16(sp)
    800029b8:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800029ba:	00011797          	auipc	a5,0x11
    800029be:	5fe78793          	addi	a5,a5,1534 # 80013fb8 <proc>
    800029c2:	fef43423          	sd	a5,-24(s0)
    800029c6:	a80d                	j	800029f8 <allocproc+0x46>
    acquire(&p->lock);
    800029c8:	fe843783          	ld	a5,-24(s0)
    800029cc:	853e                	mv	a0,a5
    800029ce:	fffff097          	auipc	ra,0xfffff
    800029d2:	95c080e7          	jalr	-1700(ra) # 8000132a <acquire>
    if(p->state == UNUSED) {
    800029d6:	fe843783          	ld	a5,-24(s0)
    800029da:	4f9c                	lw	a5,24(a5)
    800029dc:	cb85                	beqz	a5,80002a0c <allocproc+0x5a>
      goto found;
    } else {
      release(&p->lock);
    800029de:	fe843783          	ld	a5,-24(s0)
    800029e2:	853e                	mv	a0,a5
    800029e4:	fffff097          	auipc	ra,0xfffff
    800029e8:	9aa080e7          	jalr	-1622(ra) # 8000138e <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800029ec:	fe843783          	ld	a5,-24(s0)
    800029f0:	16878793          	addi	a5,a5,360
    800029f4:	fef43423          	sd	a5,-24(s0)
    800029f8:	fe843703          	ld	a4,-24(s0)
    800029fc:	00017797          	auipc	a5,0x17
    80002a00:	fbc78793          	addi	a5,a5,-68 # 800199b8 <pid_lock>
    80002a04:	fcf762e3          	bltu	a4,a5,800029c8 <allocproc+0x16>
    }
  }
  return 0;
    80002a08:	4781                	li	a5,0
    80002a0a:	a0e1                	j	80002ad2 <allocproc+0x120>
      goto found;
    80002a0c:	0001                	nop

found:
  p->pid = allocpid();
    80002a0e:	00000097          	auipc	ra,0x0
    80002a12:	f46080e7          	jalr	-186(ra) # 80002954 <allocpid>
    80002a16:	87aa                	mv	a5,a0
    80002a18:	873e                	mv	a4,a5
    80002a1a:	fe843783          	ld	a5,-24(s0)
    80002a1e:	db98                	sw	a4,48(a5)
  p->state = USED;
    80002a20:	fe843783          	ld	a5,-24(s0)
    80002a24:	4705                	li	a4,1
    80002a26:	cf98                	sw	a4,24(a5)

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80002a28:	ffffe097          	auipc	ra,0xffffe
    80002a2c:	7ae080e7          	jalr	1966(ra) # 800011d6 <kalloc>
    80002a30:	872a                	mv	a4,a0
    80002a32:	fe843783          	ld	a5,-24(s0)
    80002a36:	efb8                	sd	a4,88(a5)
    80002a38:	fe843783          	ld	a5,-24(s0)
    80002a3c:	6fbc                	ld	a5,88(a5)
    80002a3e:	e385                	bnez	a5,80002a5e <allocproc+0xac>
    freeproc(p);
    80002a40:	fe843503          	ld	a0,-24(s0)
    80002a44:	00000097          	auipc	ra,0x0
    80002a48:	098080e7          	jalr	152(ra) # 80002adc <freeproc>
    release(&p->lock);
    80002a4c:	fe843783          	ld	a5,-24(s0)
    80002a50:	853e                	mv	a0,a5
    80002a52:	fffff097          	auipc	ra,0xfffff
    80002a56:	93c080e7          	jalr	-1732(ra) # 8000138e <release>
    return 0;
    80002a5a:	4781                	li	a5,0
    80002a5c:	a89d                	j	80002ad2 <allocproc+0x120>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    80002a5e:	fe843503          	ld	a0,-24(s0)
    80002a62:	00000097          	auipc	ra,0x0
    80002a66:	118080e7          	jalr	280(ra) # 80002b7a <proc_pagetable>
    80002a6a:	872a                	mv	a4,a0
    80002a6c:	fe843783          	ld	a5,-24(s0)
    80002a70:	ebb8                	sd	a4,80(a5)
  if(p->pagetable == 0){
    80002a72:	fe843783          	ld	a5,-24(s0)
    80002a76:	6bbc                	ld	a5,80(a5)
    80002a78:	e385                	bnez	a5,80002a98 <allocproc+0xe6>
    freeproc(p);
    80002a7a:	fe843503          	ld	a0,-24(s0)
    80002a7e:	00000097          	auipc	ra,0x0
    80002a82:	05e080e7          	jalr	94(ra) # 80002adc <freeproc>
    release(&p->lock);
    80002a86:	fe843783          	ld	a5,-24(s0)
    80002a8a:	853e                	mv	a0,a5
    80002a8c:	fffff097          	auipc	ra,0xfffff
    80002a90:	902080e7          	jalr	-1790(ra) # 8000138e <release>
    return 0;
    80002a94:	4781                	li	a5,0
    80002a96:	a835                	j	80002ad2 <allocproc+0x120>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    80002a98:	fe843783          	ld	a5,-24(s0)
    80002a9c:	06078793          	addi	a5,a5,96
    80002aa0:	07000613          	li	a2,112
    80002aa4:	4581                	li	a1,0
    80002aa6:	853e                	mv	a0,a5
    80002aa8:	fffff097          	auipc	ra,0xfffff
    80002aac:	a56080e7          	jalr	-1450(ra) # 800014fe <memset>
  p->context.ra = (uint64)forkret;
    80002ab0:	00001717          	auipc	a4,0x1
    80002ab4:	9da70713          	addi	a4,a4,-1574 # 8000348a <forkret>
    80002ab8:	fe843783          	ld	a5,-24(s0)
    80002abc:	f3b8                	sd	a4,96(a5)
  p->context.sp = p->kstack + PGSIZE;
    80002abe:	fe843783          	ld	a5,-24(s0)
    80002ac2:	63b8                	ld	a4,64(a5)
    80002ac4:	6785                	lui	a5,0x1
    80002ac6:	973e                	add	a4,a4,a5
    80002ac8:	fe843783          	ld	a5,-24(s0)
    80002acc:	f7b8                	sd	a4,104(a5)

  return p;
    80002ace:	fe843783          	ld	a5,-24(s0)
}
    80002ad2:	853e                	mv	a0,a5
    80002ad4:	60e2                	ld	ra,24(sp)
    80002ad6:	6442                	ld	s0,16(sp)
    80002ad8:	6105                	addi	sp,sp,32
    80002ada:	8082                	ret

0000000080002adc <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    80002adc:	1101                	addi	sp,sp,-32
    80002ade:	ec06                	sd	ra,24(sp)
    80002ae0:	e822                	sd	s0,16(sp)
    80002ae2:	1000                	addi	s0,sp,32
    80002ae4:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002ae8:	fe843783          	ld	a5,-24(s0)
    80002aec:	6fbc                	ld	a5,88(a5)
    80002aee:	cb89                	beqz	a5,80002b00 <freeproc+0x24>
    kfree((void*)p->trapframe);
    80002af0:	fe843783          	ld	a5,-24(s0)
    80002af4:	6fbc                	ld	a5,88(a5)
    80002af6:	853e                	mv	a0,a5
    80002af8:	ffffe097          	auipc	ra,0xffffe
    80002afc:	638080e7          	jalr	1592(ra) # 80001130 <kfree>
  p->trapframe = 0;
    80002b00:	fe843783          	ld	a5,-24(s0)
    80002b04:	0407bc23          	sd	zero,88(a5) # 1058 <_entry-0x7fffefa8>
  if(p->pagetable)
    80002b08:	fe843783          	ld	a5,-24(s0)
    80002b0c:	6bbc                	ld	a5,80(a5)
    80002b0e:	cf89                	beqz	a5,80002b28 <freeproc+0x4c>
    proc_freepagetable(p->pagetable, p->sz);
    80002b10:	fe843783          	ld	a5,-24(s0)
    80002b14:	6bb8                	ld	a4,80(a5)
    80002b16:	fe843783          	ld	a5,-24(s0)
    80002b1a:	67bc                	ld	a5,72(a5)
    80002b1c:	85be                	mv	a1,a5
    80002b1e:	853a                	mv	a0,a4
    80002b20:	00000097          	auipc	ra,0x0
    80002b24:	11a080e7          	jalr	282(ra) # 80002c3a <proc_freepagetable>
  p->pagetable = 0;
    80002b28:	fe843783          	ld	a5,-24(s0)
    80002b2c:	0407b823          	sd	zero,80(a5)
  p->sz = 0;
    80002b30:	fe843783          	ld	a5,-24(s0)
    80002b34:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80002b38:	fe843783          	ld	a5,-24(s0)
    80002b3c:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002b40:	fe843783          	ld	a5,-24(s0)
    80002b44:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80002b48:	fe843783          	ld	a5,-24(s0)
    80002b4c:	14078c23          	sb	zero,344(a5)
  p->chan = 0;
    80002b50:	fe843783          	ld	a5,-24(s0)
    80002b54:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002b58:	fe843783          	ld	a5,-24(s0)
    80002b5c:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002b60:	fe843783          	ld	a5,-24(s0)
    80002b64:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002b68:	fe843783          	ld	a5,-24(s0)
    80002b6c:	0007ac23          	sw	zero,24(a5)
}
    80002b70:	0001                	nop
    80002b72:	60e2                	ld	ra,24(sp)
    80002b74:	6442                	ld	s0,16(sp)
    80002b76:	6105                	addi	sp,sp,32
    80002b78:	8082                	ret

0000000080002b7a <proc_pagetable>:

// Create a user page table for a given process, with no user memory,
// but with trampoline and trapframe pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002b7a:	7179                	addi	sp,sp,-48
    80002b7c:	f406                	sd	ra,40(sp)
    80002b7e:	f022                	sd	s0,32(sp)
    80002b80:	1800                	addi	s0,sp,48
    80002b82:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002b86:	fffff097          	auipc	ra,0xfffff
    80002b8a:	3ac080e7          	jalr	940(ra) # 80001f32 <uvmcreate>
    80002b8e:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002b92:	fe843783          	ld	a5,-24(s0)
    80002b96:	e399                	bnez	a5,80002b9c <proc_pagetable+0x22>
    return 0;
    80002b98:	4781                	li	a5,0
    80002b9a:	a859                	j	80002c30 <proc_pagetable+0xb6>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002b9c:	00007797          	auipc	a5,0x7
    80002ba0:	46478793          	addi	a5,a5,1124 # 8000a000 <_trampoline>
    80002ba4:	4729                	li	a4,10
    80002ba6:	86be                	mv	a3,a5
    80002ba8:	6605                	lui	a2,0x1
    80002baa:	040007b7          	lui	a5,0x4000
    80002bae:	17fd                	addi	a5,a5,-1
    80002bb0:	00c79593          	slli	a1,a5,0xc
    80002bb4:	fe843503          	ld	a0,-24(s0)
    80002bb8:	fffff097          	auipc	ra,0xfffff
    80002bbc:	19c080e7          	jalr	412(ra) # 80001d54 <mappages>
    80002bc0:	87aa                	mv	a5,a0
    80002bc2:	0007db63          	bgez	a5,80002bd8 <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002bc6:	4581                	li	a1,0
    80002bc8:	fe843503          	ld	a0,-24(s0)
    80002bcc:	fffff097          	auipc	ra,0xfffff
    80002bd0:	662080e7          	jalr	1634(ra) # 8000222e <uvmfree>
    return 0;
    80002bd4:	4781                	li	a5,0
    80002bd6:	a8a9                	j	80002c30 <proc_pagetable+0xb6>
  }

  // map the trapframe page just below the trampoline page, for
  // trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002bd8:	fd843783          	ld	a5,-40(s0)
    80002bdc:	6fbc                	ld	a5,88(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002bde:	4719                	li	a4,6
    80002be0:	86be                	mv	a3,a5
    80002be2:	6605                	lui	a2,0x1
    80002be4:	020007b7          	lui	a5,0x2000
    80002be8:	17fd                	addi	a5,a5,-1
    80002bea:	00d79593          	slli	a1,a5,0xd
    80002bee:	fe843503          	ld	a0,-24(s0)
    80002bf2:	fffff097          	auipc	ra,0xfffff
    80002bf6:	162080e7          	jalr	354(ra) # 80001d54 <mappages>
    80002bfa:	87aa                	mv	a5,a0
    80002bfc:	0207d863          	bgez	a5,80002c2c <proc_pagetable+0xb2>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002c00:	4681                	li	a3,0
    80002c02:	4605                	li	a2,1
    80002c04:	040007b7          	lui	a5,0x4000
    80002c08:	17fd                	addi	a5,a5,-1
    80002c0a:	00c79593          	slli	a1,a5,0xc
    80002c0e:	fe843503          	ld	a0,-24(s0)
    80002c12:	fffff097          	auipc	ra,0xfffff
    80002c16:	220080e7          	jalr	544(ra) # 80001e32 <uvmunmap>
    uvmfree(pagetable, 0);
    80002c1a:	4581                	li	a1,0
    80002c1c:	fe843503          	ld	a0,-24(s0)
    80002c20:	fffff097          	auipc	ra,0xfffff
    80002c24:	60e080e7          	jalr	1550(ra) # 8000222e <uvmfree>
    return 0;
    80002c28:	4781                	li	a5,0
    80002c2a:	a019                	j	80002c30 <proc_pagetable+0xb6>
  }

  return pagetable;
    80002c2c:	fe843783          	ld	a5,-24(s0)
}
    80002c30:	853e                	mv	a0,a5
    80002c32:	70a2                	ld	ra,40(sp)
    80002c34:	7402                	ld	s0,32(sp)
    80002c36:	6145                	addi	sp,sp,48
    80002c38:	8082                	ret

0000000080002c3a <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002c3a:	1101                	addi	sp,sp,-32
    80002c3c:	ec06                	sd	ra,24(sp)
    80002c3e:	e822                	sd	s0,16(sp)
    80002c40:	1000                	addi	s0,sp,32
    80002c42:	fea43423          	sd	a0,-24(s0)
    80002c46:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002c4a:	4681                	li	a3,0
    80002c4c:	4605                	li	a2,1
    80002c4e:	040007b7          	lui	a5,0x4000
    80002c52:	17fd                	addi	a5,a5,-1
    80002c54:	00c79593          	slli	a1,a5,0xc
    80002c58:	fe843503          	ld	a0,-24(s0)
    80002c5c:	fffff097          	auipc	ra,0xfffff
    80002c60:	1d6080e7          	jalr	470(ra) # 80001e32 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002c64:	4681                	li	a3,0
    80002c66:	4605                	li	a2,1
    80002c68:	020007b7          	lui	a5,0x2000
    80002c6c:	17fd                	addi	a5,a5,-1
    80002c6e:	00d79593          	slli	a1,a5,0xd
    80002c72:	fe843503          	ld	a0,-24(s0)
    80002c76:	fffff097          	auipc	ra,0xfffff
    80002c7a:	1bc080e7          	jalr	444(ra) # 80001e32 <uvmunmap>
  uvmfree(pagetable, sz);
    80002c7e:	fe043583          	ld	a1,-32(s0)
    80002c82:	fe843503          	ld	a0,-24(s0)
    80002c86:	fffff097          	auipc	ra,0xfffff
    80002c8a:	5a8080e7          	jalr	1448(ra) # 8000222e <uvmfree>
}
    80002c8e:	0001                	nop
    80002c90:	60e2                	ld	ra,24(sp)
    80002c92:	6442                	ld	s0,16(sp)
    80002c94:	6105                	addi	sp,sp,32
    80002c96:	8082                	ret

0000000080002c98 <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002c98:	1101                	addi	sp,sp,-32
    80002c9a:	ec06                	sd	ra,24(sp)
    80002c9c:	e822                	sd	s0,16(sp)
    80002c9e:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	d12080e7          	jalr	-750(ra) # 800029b2 <allocproc>
    80002ca8:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002cac:	00009797          	auipc	a5,0x9
    80002cb0:	c9478793          	addi	a5,a5,-876 # 8000b940 <initproc>
    80002cb4:	fe843703          	ld	a4,-24(s0)
    80002cb8:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy initcode's instructions
  // and data into it.
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80002cba:	fe843783          	ld	a5,-24(s0)
    80002cbe:	6bbc                	ld	a5,80(a5)
    80002cc0:	03400613          	li	a2,52
    80002cc4:	00009597          	auipc	a1,0x9
    80002cc8:	b2458593          	addi	a1,a1,-1244 # 8000b7e8 <initcode>
    80002ccc:	853e                	mv	a0,a5
    80002cce:	fffff097          	auipc	ra,0xfffff
    80002cd2:	2a0080e7          	jalr	672(ra) # 80001f6e <uvmfirst>
  p->sz = PGSIZE;
    80002cd6:	fe843783          	ld	a5,-24(s0)
    80002cda:	6705                	lui	a4,0x1
    80002cdc:	e7b8                	sd	a4,72(a5)

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002cde:	fe843783          	ld	a5,-24(s0)
    80002ce2:	6fbc                	ld	a5,88(a5)
    80002ce4:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002ce8:	fe843783          	ld	a5,-24(s0)
    80002cec:	6fbc                	ld	a5,88(a5)
    80002cee:	6705                	lui	a4,0x1
    80002cf0:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002cf2:	fe843783          	ld	a5,-24(s0)
    80002cf6:	15878793          	addi	a5,a5,344
    80002cfa:	4641                	li	a2,16
    80002cfc:	00008597          	auipc	a1,0x8
    80002d00:	50458593          	addi	a1,a1,1284 # 8000b200 <etext+0x200>
    80002d04:	853e                	mv	a0,a5
    80002d06:	fffff097          	auipc	ra,0xfffff
    80002d0a:	afc080e7          	jalr	-1284(ra) # 80001802 <safestrcpy>
  p->cwd = namei("/");
    80002d0e:	00008517          	auipc	a0,0x8
    80002d12:	50250513          	addi	a0,a0,1282 # 8000b210 <etext+0x210>
    80002d16:	00003097          	auipc	ra,0x3
    80002d1a:	16e080e7          	jalr	366(ra) # 80005e84 <namei>
    80002d1e:	872a                	mv	a4,a0
    80002d20:	fe843783          	ld	a5,-24(s0)
    80002d24:	14e7b823          	sd	a4,336(a5)

  p->state = RUNNABLE;
    80002d28:	fe843783          	ld	a5,-24(s0)
    80002d2c:	470d                	li	a4,3
    80002d2e:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002d30:	fe843783          	ld	a5,-24(s0)
    80002d34:	853e                	mv	a0,a5
    80002d36:	ffffe097          	auipc	ra,0xffffe
    80002d3a:	658080e7          	jalr	1624(ra) # 8000138e <release>
}
    80002d3e:	0001                	nop
    80002d40:	60e2                	ld	ra,24(sp)
    80002d42:	6442                	ld	s0,16(sp)
    80002d44:	6105                	addi	sp,sp,32
    80002d46:	8082                	ret

0000000080002d48 <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002d48:	7179                	addi	sp,sp,-48
    80002d4a:	f406                	sd	ra,40(sp)
    80002d4c:	f022                	sd	s0,32(sp)
    80002d4e:	1800                	addi	s0,sp,48
    80002d50:	87aa                	mv	a5,a0
    80002d52:	fcf42e23          	sw	a5,-36(s0)
  uint64 sz;
  struct proc *p = myproc();
    80002d56:	00000097          	auipc	ra,0x0
    80002d5a:	bc2080e7          	jalr	-1086(ra) # 80002918 <myproc>
    80002d5e:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002d62:	fe043783          	ld	a5,-32(s0)
    80002d66:	67bc                	ld	a5,72(a5)
    80002d68:	fef43423          	sd	a5,-24(s0)
  if(n > 0){
    80002d6c:	fdc42783          	lw	a5,-36(s0)
    80002d70:	2781                	sext.w	a5,a5
    80002d72:	02f05963          	blez	a5,80002da4 <growproc+0x5c>
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80002d76:	fe043783          	ld	a5,-32(s0)
    80002d7a:	6ba8                	ld	a0,80(a5)
    80002d7c:	fdc42703          	lw	a4,-36(s0)
    80002d80:	fe843783          	ld	a5,-24(s0)
    80002d84:	97ba                	add	a5,a5,a4
    80002d86:	4691                	li	a3,4
    80002d88:	863e                	mv	a2,a5
    80002d8a:	fe843583          	ld	a1,-24(s0)
    80002d8e:	fffff097          	auipc	ra,0xfffff
    80002d92:	268080e7          	jalr	616(ra) # 80001ff6 <uvmalloc>
    80002d96:	fea43423          	sd	a0,-24(s0)
    80002d9a:	fe843783          	ld	a5,-24(s0)
    80002d9e:	eb95                	bnez	a5,80002dd2 <growproc+0x8a>
      return -1;
    80002da0:	57fd                	li	a5,-1
    80002da2:	a835                	j	80002dde <growproc+0x96>
    }
  } else if(n < 0){
    80002da4:	fdc42783          	lw	a5,-36(s0)
    80002da8:	2781                	sext.w	a5,a5
    80002daa:	0207d463          	bgez	a5,80002dd2 <growproc+0x8a>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002dae:	fe043783          	ld	a5,-32(s0)
    80002db2:	6bb4                	ld	a3,80(a5)
    80002db4:	fdc42703          	lw	a4,-36(s0)
    80002db8:	fe843783          	ld	a5,-24(s0)
    80002dbc:	97ba                	add	a5,a5,a4
    80002dbe:	863e                	mv	a2,a5
    80002dc0:	fe843583          	ld	a1,-24(s0)
    80002dc4:	8536                	mv	a0,a3
    80002dc6:	fffff097          	auipc	ra,0xfffff
    80002dca:	322080e7          	jalr	802(ra) # 800020e8 <uvmdealloc>
    80002dce:	fea43423          	sd	a0,-24(s0)
  }
  p->sz = sz;
    80002dd2:	fe043783          	ld	a5,-32(s0)
    80002dd6:	fe843703          	ld	a4,-24(s0)
    80002dda:	e7b8                	sd	a4,72(a5)
  return 0;
    80002ddc:	4781                	li	a5,0
}
    80002dde:	853e                	mv	a0,a5
    80002de0:	70a2                	ld	ra,40(sp)
    80002de2:	7402                	ld	s0,32(sp)
    80002de4:	6145                	addi	sp,sp,48
    80002de6:	8082                	ret

0000000080002de8 <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    80002de8:	7179                	addi	sp,sp,-48
    80002dea:	f406                	sd	ra,40(sp)
    80002dec:	f022                	sd	s0,32(sp)
    80002dee:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002df0:	00000097          	auipc	ra,0x0
    80002df4:	b28080e7          	jalr	-1240(ra) # 80002918 <myproc>
    80002df8:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80002dfc:	00000097          	auipc	ra,0x0
    80002e00:	bb6080e7          	jalr	-1098(ra) # 800029b2 <allocproc>
    80002e04:	fca43c23          	sd	a0,-40(s0)
    80002e08:	fd843783          	ld	a5,-40(s0)
    80002e0c:	e399                	bnez	a5,80002e12 <fork+0x2a>
    return -1;
    80002e0e:	57fd                	li	a5,-1
    80002e10:	aab5                	j	80002f8c <fork+0x1a4>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80002e12:	fe043783          	ld	a5,-32(s0)
    80002e16:	6bb8                	ld	a4,80(a5)
    80002e18:	fd843783          	ld	a5,-40(s0)
    80002e1c:	6bb4                	ld	a3,80(a5)
    80002e1e:	fe043783          	ld	a5,-32(s0)
    80002e22:	67bc                	ld	a5,72(a5)
    80002e24:	863e                	mv	a2,a5
    80002e26:	85b6                	mv	a1,a3
    80002e28:	853a                	mv	a0,a4
    80002e2a:	fffff097          	auipc	ra,0xfffff
    80002e2e:	44e080e7          	jalr	1102(ra) # 80002278 <uvmcopy>
    80002e32:	87aa                	mv	a5,a0
    80002e34:	0207d163          	bgez	a5,80002e56 <fork+0x6e>
    freeproc(np);
    80002e38:	fd843503          	ld	a0,-40(s0)
    80002e3c:	00000097          	auipc	ra,0x0
    80002e40:	ca0080e7          	jalr	-864(ra) # 80002adc <freeproc>
    release(&np->lock);
    80002e44:	fd843783          	ld	a5,-40(s0)
    80002e48:	853e                	mv	a0,a5
    80002e4a:	ffffe097          	auipc	ra,0xffffe
    80002e4e:	544080e7          	jalr	1348(ra) # 8000138e <release>
    return -1;
    80002e52:	57fd                	li	a5,-1
    80002e54:	aa25                	j	80002f8c <fork+0x1a4>
  }
  np->sz = p->sz;
    80002e56:	fe043783          	ld	a5,-32(s0)
    80002e5a:	67b8                	ld	a4,72(a5)
    80002e5c:	fd843783          	ld	a5,-40(s0)
    80002e60:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80002e62:	fe043783          	ld	a5,-32(s0)
    80002e66:	6fb8                	ld	a4,88(a5)
    80002e68:	fd843783          	ld	a5,-40(s0)
    80002e6c:	6fbc                	ld	a5,88(a5)
    80002e6e:	86be                	mv	a3,a5
    80002e70:	12000793          	li	a5,288
    80002e74:	863e                	mv	a2,a5
    80002e76:	85ba                	mv	a1,a4
    80002e78:	8536                	mv	a0,a3
    80002e7a:	fffff097          	auipc	ra,0xfffff
    80002e7e:	844080e7          	jalr	-1980(ra) # 800016be <memcpy>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80002e82:	fd843783          	ld	a5,-40(s0)
    80002e86:	6fbc                	ld	a5,88(a5)
    80002e88:	0607b823          	sd	zero,112(a5)

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80002e8c:	fe042623          	sw	zero,-20(s0)
    80002e90:	a0a9                	j	80002eda <fork+0xf2>
    if(p->ofile[i])
    80002e92:	fe043703          	ld	a4,-32(s0)
    80002e96:	fec42783          	lw	a5,-20(s0)
    80002e9a:	07e9                	addi	a5,a5,26
    80002e9c:	078e                	slli	a5,a5,0x3
    80002e9e:	97ba                	add	a5,a5,a4
    80002ea0:	639c                	ld	a5,0(a5)
    80002ea2:	c79d                	beqz	a5,80002ed0 <fork+0xe8>
      np->ofile[i] = filedup(p->ofile[i]);
    80002ea4:	fe043703          	ld	a4,-32(s0)
    80002ea8:	fec42783          	lw	a5,-20(s0)
    80002eac:	07e9                	addi	a5,a5,26
    80002eae:	078e                	slli	a5,a5,0x3
    80002eb0:	97ba                	add	a5,a5,a4
    80002eb2:	639c                	ld	a5,0(a5)
    80002eb4:	853e                	mv	a0,a5
    80002eb6:	00004097          	auipc	ra,0x4
    80002eba:	966080e7          	jalr	-1690(ra) # 8000681c <filedup>
    80002ebe:	86aa                	mv	a3,a0
    80002ec0:	fd843703          	ld	a4,-40(s0)
    80002ec4:	fec42783          	lw	a5,-20(s0)
    80002ec8:	07e9                	addi	a5,a5,26
    80002eca:	078e                	slli	a5,a5,0x3
    80002ecc:	97ba                	add	a5,a5,a4
    80002ece:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    80002ed0:	fec42783          	lw	a5,-20(s0)
    80002ed4:	2785                	addiw	a5,a5,1
    80002ed6:	fef42623          	sw	a5,-20(s0)
    80002eda:	fec42783          	lw	a5,-20(s0)
    80002ede:	0007871b          	sext.w	a4,a5
    80002ee2:	47bd                	li	a5,15
    80002ee4:	fae7d7e3          	bge	a5,a4,80002e92 <fork+0xaa>
  np->cwd = idup(p->cwd);
    80002ee8:	fe043783          	ld	a5,-32(s0)
    80002eec:	1507b783          	ld	a5,336(a5)
    80002ef0:	853e                	mv	a0,a5
    80002ef2:	00002097          	auipc	ra,0x2
    80002ef6:	220080e7          	jalr	544(ra) # 80005112 <idup>
    80002efa:	872a                	mv	a4,a0
    80002efc:	fd843783          	ld	a5,-40(s0)
    80002f00:	14e7b823          	sd	a4,336(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80002f04:	fd843783          	ld	a5,-40(s0)
    80002f08:	15878713          	addi	a4,a5,344
    80002f0c:	fe043783          	ld	a5,-32(s0)
    80002f10:	15878793          	addi	a5,a5,344
    80002f14:	4641                	li	a2,16
    80002f16:	85be                	mv	a1,a5
    80002f18:	853a                	mv	a0,a4
    80002f1a:	fffff097          	auipc	ra,0xfffff
    80002f1e:	8e8080e7          	jalr	-1816(ra) # 80001802 <safestrcpy>

  pid = np->pid;
    80002f22:	fd843783          	ld	a5,-40(s0)
    80002f26:	5b9c                	lw	a5,48(a5)
    80002f28:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80002f2c:	fd843783          	ld	a5,-40(s0)
    80002f30:	853e                	mv	a0,a5
    80002f32:	ffffe097          	auipc	ra,0xffffe
    80002f36:	45c080e7          	jalr	1116(ra) # 8000138e <release>

  acquire(&wait_lock);
    80002f3a:	00017517          	auipc	a0,0x17
    80002f3e:	a9650513          	addi	a0,a0,-1386 # 800199d0 <wait_lock>
    80002f42:	ffffe097          	auipc	ra,0xffffe
    80002f46:	3e8080e7          	jalr	1000(ra) # 8000132a <acquire>
  np->parent = p;
    80002f4a:	fd843783          	ld	a5,-40(s0)
    80002f4e:	fe043703          	ld	a4,-32(s0)
    80002f52:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80002f54:	00017517          	auipc	a0,0x17
    80002f58:	a7c50513          	addi	a0,a0,-1412 # 800199d0 <wait_lock>
    80002f5c:	ffffe097          	auipc	ra,0xffffe
    80002f60:	432080e7          	jalr	1074(ra) # 8000138e <release>

  acquire(&np->lock);
    80002f64:	fd843783          	ld	a5,-40(s0)
    80002f68:	853e                	mv	a0,a5
    80002f6a:	ffffe097          	auipc	ra,0xffffe
    80002f6e:	3c0080e7          	jalr	960(ra) # 8000132a <acquire>
  np->state = RUNNABLE;
    80002f72:	fd843783          	ld	a5,-40(s0)
    80002f76:	470d                	li	a4,3
    80002f78:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80002f7a:	fd843783          	ld	a5,-40(s0)
    80002f7e:	853e                	mv	a0,a5
    80002f80:	ffffe097          	auipc	ra,0xffffe
    80002f84:	40e080e7          	jalr	1038(ra) # 8000138e <release>

  return pid;
    80002f88:	fd442783          	lw	a5,-44(s0)
}
    80002f8c:	853e                	mv	a0,a5
    80002f8e:	70a2                	ld	ra,40(sp)
    80002f90:	7402                	ld	s0,32(sp)
    80002f92:	6145                	addi	sp,sp,48
    80002f94:	8082                	ret

0000000080002f96 <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    80002f96:	7179                	addi	sp,sp,-48
    80002f98:	f406                	sd	ra,40(sp)
    80002f9a:	f022                	sd	s0,32(sp)
    80002f9c:	1800                	addi	s0,sp,48
    80002f9e:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002fa2:	00011797          	auipc	a5,0x11
    80002fa6:	01678793          	addi	a5,a5,22 # 80013fb8 <proc>
    80002faa:	fef43423          	sd	a5,-24(s0)
    80002fae:	a081                	j	80002fee <reparent+0x58>
    if(pp->parent == p){
    80002fb0:	fe843783          	ld	a5,-24(s0)
    80002fb4:	7f9c                	ld	a5,56(a5)
    80002fb6:	fd843703          	ld	a4,-40(s0)
    80002fba:	02f71463          	bne	a4,a5,80002fe2 <reparent+0x4c>
      pp->parent = initproc;
    80002fbe:	00009797          	auipc	a5,0x9
    80002fc2:	98278793          	addi	a5,a5,-1662 # 8000b940 <initproc>
    80002fc6:	6398                	ld	a4,0(a5)
    80002fc8:	fe843783          	ld	a5,-24(s0)
    80002fcc:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    80002fce:	00009797          	auipc	a5,0x9
    80002fd2:	97278793          	addi	a5,a5,-1678 # 8000b940 <initproc>
    80002fd6:	639c                	ld	a5,0(a5)
    80002fd8:	853e                	mv	a0,a5
    80002fda:	00000097          	auipc	ra,0x0
    80002fde:	57c080e7          	jalr	1404(ra) # 80003556 <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002fe2:	fe843783          	ld	a5,-24(s0)
    80002fe6:	16878793          	addi	a5,a5,360
    80002fea:	fef43423          	sd	a5,-24(s0)
    80002fee:	fe843703          	ld	a4,-24(s0)
    80002ff2:	00017797          	auipc	a5,0x17
    80002ff6:	9c678793          	addi	a5,a5,-1594 # 800199b8 <pid_lock>
    80002ffa:	faf76be3          	bltu	a4,a5,80002fb0 <reparent+0x1a>
    }
  }
}
    80002ffe:	0001                	nop
    80003000:	0001                	nop
    80003002:	70a2                	ld	ra,40(sp)
    80003004:	7402                	ld	s0,32(sp)
    80003006:	6145                	addi	sp,sp,48
    80003008:	8082                	ret

000000008000300a <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    8000300a:	7139                	addi	sp,sp,-64
    8000300c:	fc06                	sd	ra,56(sp)
    8000300e:	f822                	sd	s0,48(sp)
    80003010:	0080                	addi	s0,sp,64
    80003012:	87aa                	mv	a5,a0
    80003014:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80003018:	00000097          	auipc	ra,0x0
    8000301c:	900080e7          	jalr	-1792(ra) # 80002918 <myproc>
    80003020:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    80003024:	00009797          	auipc	a5,0x9
    80003028:	91c78793          	addi	a5,a5,-1764 # 8000b940 <initproc>
    8000302c:	639c                	ld	a5,0(a5)
    8000302e:	fe043703          	ld	a4,-32(s0)
    80003032:	00f71a63          	bne	a4,a5,80003046 <exit+0x3c>
    panic("init exiting");
    80003036:	00008517          	auipc	a0,0x8
    8000303a:	1e250513          	addi	a0,a0,482 # 8000b218 <etext+0x218>
    8000303e:	ffffe097          	auipc	ra,0xffffe
    80003042:	c4e080e7          	jalr	-946(ra) # 80000c8c <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    80003046:	fe042623          	sw	zero,-20(s0)
    8000304a:	a881                	j	8000309a <exit+0x90>
    if(p->ofile[fd]){
    8000304c:	fe043703          	ld	a4,-32(s0)
    80003050:	fec42783          	lw	a5,-20(s0)
    80003054:	07e9                	addi	a5,a5,26
    80003056:	078e                	slli	a5,a5,0x3
    80003058:	97ba                	add	a5,a5,a4
    8000305a:	639c                	ld	a5,0(a5)
    8000305c:	cb95                	beqz	a5,80003090 <exit+0x86>
      struct file *f = p->ofile[fd];
    8000305e:	fe043703          	ld	a4,-32(s0)
    80003062:	fec42783          	lw	a5,-20(s0)
    80003066:	07e9                	addi	a5,a5,26
    80003068:	078e                	slli	a5,a5,0x3
    8000306a:	97ba                	add	a5,a5,a4
    8000306c:	639c                	ld	a5,0(a5)
    8000306e:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    80003072:	fd843503          	ld	a0,-40(s0)
    80003076:	00004097          	auipc	ra,0x4
    8000307a:	80c080e7          	jalr	-2036(ra) # 80006882 <fileclose>
      p->ofile[fd] = 0;
    8000307e:	fe043703          	ld	a4,-32(s0)
    80003082:	fec42783          	lw	a5,-20(s0)
    80003086:	07e9                	addi	a5,a5,26
    80003088:	078e                	slli	a5,a5,0x3
    8000308a:	97ba                	add	a5,a5,a4
    8000308c:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80003090:	fec42783          	lw	a5,-20(s0)
    80003094:	2785                	addiw	a5,a5,1
    80003096:	fef42623          	sw	a5,-20(s0)
    8000309a:	fec42783          	lw	a5,-20(s0)
    8000309e:	0007871b          	sext.w	a4,a5
    800030a2:	47bd                	li	a5,15
    800030a4:	fae7d4e3          	bge	a5,a4,8000304c <exit+0x42>
    }
  }

  begin_op();
    800030a8:	00003097          	auipc	ra,0x3
    800030ac:	140080e7          	jalr	320(ra) # 800061e8 <begin_op>
  iput(p->cwd);
    800030b0:	fe043783          	ld	a5,-32(s0)
    800030b4:	1507b783          	ld	a5,336(a5)
    800030b8:	853e                	mv	a0,a5
    800030ba:	00002097          	auipc	ra,0x2
    800030be:	232080e7          	jalr	562(ra) # 800052ec <iput>
  end_op();
    800030c2:	00003097          	auipc	ra,0x3
    800030c6:	1e8080e7          	jalr	488(ra) # 800062aa <end_op>
  p->cwd = 0;
    800030ca:	fe043783          	ld	a5,-32(s0)
    800030ce:	1407b823          	sd	zero,336(a5)

  acquire(&wait_lock);
    800030d2:	00017517          	auipc	a0,0x17
    800030d6:	8fe50513          	addi	a0,a0,-1794 # 800199d0 <wait_lock>
    800030da:	ffffe097          	auipc	ra,0xffffe
    800030de:	250080e7          	jalr	592(ra) # 8000132a <acquire>

  // Give any children to init.
  reparent(p);
    800030e2:	fe043503          	ld	a0,-32(s0)
    800030e6:	00000097          	auipc	ra,0x0
    800030ea:	eb0080e7          	jalr	-336(ra) # 80002f96 <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    800030ee:	fe043783          	ld	a5,-32(s0)
    800030f2:	7f9c                	ld	a5,56(a5)
    800030f4:	853e                	mv	a0,a5
    800030f6:	00000097          	auipc	ra,0x0
    800030fa:	460080e7          	jalr	1120(ra) # 80003556 <wakeup>
  
  acquire(&p->lock);
    800030fe:	fe043783          	ld	a5,-32(s0)
    80003102:	853e                	mv	a0,a5
    80003104:	ffffe097          	auipc	ra,0xffffe
    80003108:	226080e7          	jalr	550(ra) # 8000132a <acquire>

  p->xstate = status;
    8000310c:	fe043783          	ld	a5,-32(s0)
    80003110:	fcc42703          	lw	a4,-52(s0)
    80003114:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    80003116:	fe043783          	ld	a5,-32(s0)
    8000311a:	4715                	li	a4,5
    8000311c:	cf98                	sw	a4,24(a5)

  release(&wait_lock);
    8000311e:	00017517          	auipc	a0,0x17
    80003122:	8b250513          	addi	a0,a0,-1870 # 800199d0 <wait_lock>
    80003126:	ffffe097          	auipc	ra,0xffffe
    8000312a:	268080e7          	jalr	616(ra) # 8000138e <release>

  // Jump into the scheduler, never to return.
  sched();
    8000312e:	00000097          	auipc	ra,0x0
    80003132:	230080e7          	jalr	560(ra) # 8000335e <sched>
  panic("zombie exit");
    80003136:	00008517          	auipc	a0,0x8
    8000313a:	0f250513          	addi	a0,a0,242 # 8000b228 <etext+0x228>
    8000313e:	ffffe097          	auipc	ra,0xffffe
    80003142:	b4e080e7          	jalr	-1202(ra) # 80000c8c <panic>

0000000080003146 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    80003146:	7139                	addi	sp,sp,-64
    80003148:	fc06                	sd	ra,56(sp)
    8000314a:	f822                	sd	s0,48(sp)
    8000314c:	0080                	addi	s0,sp,64
    8000314e:	fca43423          	sd	a0,-56(s0)
  struct proc *pp;
  int havekids, pid;
  struct proc *p = myproc();
    80003152:	fffff097          	auipc	ra,0xfffff
    80003156:	7c6080e7          	jalr	1990(ra) # 80002918 <myproc>
    8000315a:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    8000315e:	00017517          	auipc	a0,0x17
    80003162:	87250513          	addi	a0,a0,-1934 # 800199d0 <wait_lock>
    80003166:	ffffe097          	auipc	ra,0xffffe
    8000316a:	1c4080e7          	jalr	452(ra) # 8000132a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    8000316e:	fe042223          	sw	zero,-28(s0)
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80003172:	00011797          	auipc	a5,0x11
    80003176:	e4678793          	addi	a5,a5,-442 # 80013fb8 <proc>
    8000317a:	fef43423          	sd	a5,-24(s0)
    8000317e:	a8d1                	j	80003252 <wait+0x10c>
      if(pp->parent == p){
    80003180:	fe843783          	ld	a5,-24(s0)
    80003184:	7f9c                	ld	a5,56(a5)
    80003186:	fd843703          	ld	a4,-40(s0)
    8000318a:	0af71e63          	bne	a4,a5,80003246 <wait+0x100>
        // make sure the child isn't still in exit() or swtch().
        acquire(&pp->lock);
    8000318e:	fe843783          	ld	a5,-24(s0)
    80003192:	853e                	mv	a0,a5
    80003194:	ffffe097          	auipc	ra,0xffffe
    80003198:	196080e7          	jalr	406(ra) # 8000132a <acquire>

        havekids = 1;
    8000319c:	4785                	li	a5,1
    8000319e:	fef42223          	sw	a5,-28(s0)
        if(pp->state == ZOMBIE){
    800031a2:	fe843783          	ld	a5,-24(s0)
    800031a6:	4f9c                	lw	a5,24(a5)
    800031a8:	873e                	mv	a4,a5
    800031aa:	4795                	li	a5,5
    800031ac:	08f71663          	bne	a4,a5,80003238 <wait+0xf2>
          // Found one.
          pid = pp->pid;
    800031b0:	fe843783          	ld	a5,-24(s0)
    800031b4:	5b9c                	lw	a5,48(a5)
    800031b6:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800031ba:	fc843783          	ld	a5,-56(s0)
    800031be:	c7a9                	beqz	a5,80003208 <wait+0xc2>
    800031c0:	fd843783          	ld	a5,-40(s0)
    800031c4:	6bb8                	ld	a4,80(a5)
    800031c6:	fe843783          	ld	a5,-24(s0)
    800031ca:	02c78793          	addi	a5,a5,44
    800031ce:	4691                	li	a3,4
    800031d0:	863e                	mv	a2,a5
    800031d2:	fc843583          	ld	a1,-56(s0)
    800031d6:	853a                	mv	a0,a4
    800031d8:	fffff097          	auipc	ra,0xfffff
    800031dc:	20a080e7          	jalr	522(ra) # 800023e2 <copyout>
    800031e0:	87aa                	mv	a5,a0
    800031e2:	0207d363          	bgez	a5,80003208 <wait+0xc2>
                                  sizeof(pp->xstate)) < 0) {
            release(&pp->lock);
    800031e6:	fe843783          	ld	a5,-24(s0)
    800031ea:	853e                	mv	a0,a5
    800031ec:	ffffe097          	auipc	ra,0xffffe
    800031f0:	1a2080e7          	jalr	418(ra) # 8000138e <release>
            release(&wait_lock);
    800031f4:	00016517          	auipc	a0,0x16
    800031f8:	7dc50513          	addi	a0,a0,2012 # 800199d0 <wait_lock>
    800031fc:	ffffe097          	auipc	ra,0xffffe
    80003200:	192080e7          	jalr	402(ra) # 8000138e <release>
            return -1;
    80003204:	57fd                	li	a5,-1
    80003206:	a879                	j	800032a4 <wait+0x15e>
          }
          freeproc(pp);
    80003208:	fe843503          	ld	a0,-24(s0)
    8000320c:	00000097          	auipc	ra,0x0
    80003210:	8d0080e7          	jalr	-1840(ra) # 80002adc <freeproc>
          release(&pp->lock);
    80003214:	fe843783          	ld	a5,-24(s0)
    80003218:	853e                	mv	a0,a5
    8000321a:	ffffe097          	auipc	ra,0xffffe
    8000321e:	174080e7          	jalr	372(ra) # 8000138e <release>
          release(&wait_lock);
    80003222:	00016517          	auipc	a0,0x16
    80003226:	7ae50513          	addi	a0,a0,1966 # 800199d0 <wait_lock>
    8000322a:	ffffe097          	auipc	ra,0xffffe
    8000322e:	164080e7          	jalr	356(ra) # 8000138e <release>
          return pid;
    80003232:	fd442783          	lw	a5,-44(s0)
    80003236:	a0bd                	j	800032a4 <wait+0x15e>
        }
        release(&pp->lock);
    80003238:	fe843783          	ld	a5,-24(s0)
    8000323c:	853e                	mv	a0,a5
    8000323e:	ffffe097          	auipc	ra,0xffffe
    80003242:	150080e7          	jalr	336(ra) # 8000138e <release>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80003246:	fe843783          	ld	a5,-24(s0)
    8000324a:	16878793          	addi	a5,a5,360
    8000324e:	fef43423          	sd	a5,-24(s0)
    80003252:	fe843703          	ld	a4,-24(s0)
    80003256:	00016797          	auipc	a5,0x16
    8000325a:	76278793          	addi	a5,a5,1890 # 800199b8 <pid_lock>
    8000325e:	f2f761e3          	bltu	a4,a5,80003180 <wait+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || killed(p)){
    80003262:	fe442783          	lw	a5,-28(s0)
    80003266:	2781                	sext.w	a5,a5
    80003268:	cb89                	beqz	a5,8000327a <wait+0x134>
    8000326a:	fd843503          	ld	a0,-40(s0)
    8000326e:	00000097          	auipc	ra,0x0
    80003272:	47a080e7          	jalr	1146(ra) # 800036e8 <killed>
    80003276:	87aa                	mv	a5,a0
    80003278:	cb99                	beqz	a5,8000328e <wait+0x148>
      release(&wait_lock);
    8000327a:	00016517          	auipc	a0,0x16
    8000327e:	75650513          	addi	a0,a0,1878 # 800199d0 <wait_lock>
    80003282:	ffffe097          	auipc	ra,0xffffe
    80003286:	10c080e7          	jalr	268(ra) # 8000138e <release>
      return -1;
    8000328a:	57fd                	li	a5,-1
    8000328c:	a821                	j	800032a4 <wait+0x15e>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000328e:	00016597          	auipc	a1,0x16
    80003292:	74258593          	addi	a1,a1,1858 # 800199d0 <wait_lock>
    80003296:	fd843503          	ld	a0,-40(s0)
    8000329a:	00000097          	auipc	ra,0x0
    8000329e:	240080e7          	jalr	576(ra) # 800034da <sleep>
    havekids = 0;
    800032a2:	b5f1                	j	8000316e <wait+0x28>
  }
}
    800032a4:	853e                	mv	a0,a5
    800032a6:	70e2                	ld	ra,56(sp)
    800032a8:	7442                	ld	s0,48(sp)
    800032aa:	6121                	addi	sp,sp,64
    800032ac:	8082                	ret

00000000800032ae <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    800032ae:	1101                	addi	sp,sp,-32
    800032b0:	ec06                	sd	ra,24(sp)
    800032b2:	e822                	sd	s0,16(sp)
    800032b4:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    800032b6:	fffff097          	auipc	ra,0xfffff
    800032ba:	628080e7          	jalr	1576(ra) # 800028de <mycpu>
    800032be:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    800032c2:	fe043783          	ld	a5,-32(s0)
    800032c6:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    800032ca:	fffff097          	auipc	ra,0xfffff
    800032ce:	3f6080e7          	jalr	1014(ra) # 800026c0 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    800032d2:	00011797          	auipc	a5,0x11
    800032d6:	ce678793          	addi	a5,a5,-794 # 80013fb8 <proc>
    800032da:	fef43423          	sd	a5,-24(s0)
    800032de:	a0bd                	j	8000334c <scheduler+0x9e>
      acquire(&p->lock);
    800032e0:	fe843783          	ld	a5,-24(s0)
    800032e4:	853e                	mv	a0,a5
    800032e6:	ffffe097          	auipc	ra,0xffffe
    800032ea:	044080e7          	jalr	68(ra) # 8000132a <acquire>
      if(p->state == RUNNABLE) {
    800032ee:	fe843783          	ld	a5,-24(s0)
    800032f2:	4f9c                	lw	a5,24(a5)
    800032f4:	873e                	mv	a4,a5
    800032f6:	478d                	li	a5,3
    800032f8:	02f71d63          	bne	a4,a5,80003332 <scheduler+0x84>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    800032fc:	fe843783          	ld	a5,-24(s0)
    80003300:	4711                	li	a4,4
    80003302:	cf98                	sw	a4,24(a5)
        c->proc = p;
    80003304:	fe043783          	ld	a5,-32(s0)
    80003308:	fe843703          	ld	a4,-24(s0)
    8000330c:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    8000330e:	fe043783          	ld	a5,-32(s0)
    80003312:	00878713          	addi	a4,a5,8
    80003316:	fe843783          	ld	a5,-24(s0)
    8000331a:	06078793          	addi	a5,a5,96
    8000331e:	85be                	mv	a1,a5
    80003320:	853a                	mv	a0,a4
    80003322:	00000097          	auipc	ra,0x0
    80003326:	5d0080e7          	jalr	1488(ra) # 800038f2 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    8000332a:	fe043783          	ld	a5,-32(s0)
    8000332e:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80003332:	fe843783          	ld	a5,-24(s0)
    80003336:	853e                	mv	a0,a5
    80003338:	ffffe097          	auipc	ra,0xffffe
    8000333c:	056080e7          	jalr	86(ra) # 8000138e <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003340:	fe843783          	ld	a5,-24(s0)
    80003344:	16878793          	addi	a5,a5,360
    80003348:	fef43423          	sd	a5,-24(s0)
    8000334c:	fe843703          	ld	a4,-24(s0)
    80003350:	00016797          	auipc	a5,0x16
    80003354:	66878793          	addi	a5,a5,1640 # 800199b8 <pid_lock>
    80003358:	f8f764e3          	bltu	a4,a5,800032e0 <scheduler+0x32>
    intr_on();
    8000335c:	b7bd                	j	800032ca <scheduler+0x1c>

000000008000335e <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    8000335e:	7179                	addi	sp,sp,-48
    80003360:	f406                	sd	ra,40(sp)
    80003362:	f022                	sd	s0,32(sp)
    80003364:	ec26                	sd	s1,24(sp)
    80003366:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    80003368:	fffff097          	auipc	ra,0xfffff
    8000336c:	5b0080e7          	jalr	1456(ra) # 80002918 <myproc>
    80003370:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    80003374:	fd843783          	ld	a5,-40(s0)
    80003378:	853e                	mv	a0,a5
    8000337a:	ffffe097          	auipc	ra,0xffffe
    8000337e:	06a080e7          	jalr	106(ra) # 800013e4 <holding>
    80003382:	87aa                	mv	a5,a0
    80003384:	eb89                	bnez	a5,80003396 <sched+0x38>
    panic("sched p->lock");
    80003386:	00008517          	auipc	a0,0x8
    8000338a:	eb250513          	addi	a0,a0,-334 # 8000b238 <etext+0x238>
    8000338e:	ffffe097          	auipc	ra,0xffffe
    80003392:	8fe080e7          	jalr	-1794(ra) # 80000c8c <panic>
  if(mycpu()->noff != 1)
    80003396:	fffff097          	auipc	ra,0xfffff
    8000339a:	548080e7          	jalr	1352(ra) # 800028de <mycpu>
    8000339e:	87aa                	mv	a5,a0
    800033a0:	5fbc                	lw	a5,120(a5)
    800033a2:	873e                	mv	a4,a5
    800033a4:	4785                	li	a5,1
    800033a6:	00f70a63          	beq	a4,a5,800033ba <sched+0x5c>
    panic("sched locks");
    800033aa:	00008517          	auipc	a0,0x8
    800033ae:	e9e50513          	addi	a0,a0,-354 # 8000b248 <etext+0x248>
    800033b2:	ffffe097          	auipc	ra,0xffffe
    800033b6:	8da080e7          	jalr	-1830(ra) # 80000c8c <panic>
  if(p->state == RUNNING)
    800033ba:	fd843783          	ld	a5,-40(s0)
    800033be:	4f9c                	lw	a5,24(a5)
    800033c0:	873e                	mv	a4,a5
    800033c2:	4791                	li	a5,4
    800033c4:	00f71a63          	bne	a4,a5,800033d8 <sched+0x7a>
    panic("sched running");
    800033c8:	00008517          	auipc	a0,0x8
    800033cc:	e9050513          	addi	a0,a0,-368 # 8000b258 <etext+0x258>
    800033d0:	ffffe097          	auipc	ra,0xffffe
    800033d4:	8bc080e7          	jalr	-1860(ra) # 80000c8c <panic>
  if(intr_get())
    800033d8:	fffff097          	auipc	ra,0xfffff
    800033dc:	312080e7          	jalr	786(ra) # 800026ea <intr_get>
    800033e0:	87aa                	mv	a5,a0
    800033e2:	cb89                	beqz	a5,800033f4 <sched+0x96>
    panic("sched interruptible");
    800033e4:	00008517          	auipc	a0,0x8
    800033e8:	e8450513          	addi	a0,a0,-380 # 8000b268 <etext+0x268>
    800033ec:	ffffe097          	auipc	ra,0xffffe
    800033f0:	8a0080e7          	jalr	-1888(ra) # 80000c8c <panic>

  intena = mycpu()->intena;
    800033f4:	fffff097          	auipc	ra,0xfffff
    800033f8:	4ea080e7          	jalr	1258(ra) # 800028de <mycpu>
    800033fc:	87aa                	mv	a5,a0
    800033fe:	5ffc                	lw	a5,124(a5)
    80003400:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    80003404:	fd843783          	ld	a5,-40(s0)
    80003408:	06078493          	addi	s1,a5,96
    8000340c:	fffff097          	auipc	ra,0xfffff
    80003410:	4d2080e7          	jalr	1234(ra) # 800028de <mycpu>
    80003414:	87aa                	mv	a5,a0
    80003416:	07a1                	addi	a5,a5,8
    80003418:	85be                	mv	a1,a5
    8000341a:	8526                	mv	a0,s1
    8000341c:	00000097          	auipc	ra,0x0
    80003420:	4d6080e7          	jalr	1238(ra) # 800038f2 <swtch>
  mycpu()->intena = intena;
    80003424:	fffff097          	auipc	ra,0xfffff
    80003428:	4ba080e7          	jalr	1210(ra) # 800028de <mycpu>
    8000342c:	872a                	mv	a4,a0
    8000342e:	fd442783          	lw	a5,-44(s0)
    80003432:	df7c                	sw	a5,124(a4)
}
    80003434:	0001                	nop
    80003436:	70a2                	ld	ra,40(sp)
    80003438:	7402                	ld	s0,32(sp)
    8000343a:	64e2                	ld	s1,24(sp)
    8000343c:	6145                	addi	sp,sp,48
    8000343e:	8082                	ret

0000000080003440 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    80003440:	1101                	addi	sp,sp,-32
    80003442:	ec06                	sd	ra,24(sp)
    80003444:	e822                	sd	s0,16(sp)
    80003446:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80003448:	fffff097          	auipc	ra,0xfffff
    8000344c:	4d0080e7          	jalr	1232(ra) # 80002918 <myproc>
    80003450:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    80003454:	fe843783          	ld	a5,-24(s0)
    80003458:	853e                	mv	a0,a5
    8000345a:	ffffe097          	auipc	ra,0xffffe
    8000345e:	ed0080e7          	jalr	-304(ra) # 8000132a <acquire>
  p->state = RUNNABLE;
    80003462:	fe843783          	ld	a5,-24(s0)
    80003466:	470d                	li	a4,3
    80003468:	cf98                	sw	a4,24(a5)
  sched();
    8000346a:	00000097          	auipc	ra,0x0
    8000346e:	ef4080e7          	jalr	-268(ra) # 8000335e <sched>
  release(&p->lock);
    80003472:	fe843783          	ld	a5,-24(s0)
    80003476:	853e                	mv	a0,a5
    80003478:	ffffe097          	auipc	ra,0xffffe
    8000347c:	f16080e7          	jalr	-234(ra) # 8000138e <release>
}
    80003480:	0001                	nop
    80003482:	60e2                	ld	ra,24(sp)
    80003484:	6442                	ld	s0,16(sp)
    80003486:	6105                	addi	sp,sp,32
    80003488:	8082                	ret

000000008000348a <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    8000348a:	1141                	addi	sp,sp,-16
    8000348c:	e406                	sd	ra,8(sp)
    8000348e:	e022                	sd	s0,0(sp)
    80003490:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80003492:	fffff097          	auipc	ra,0xfffff
    80003496:	486080e7          	jalr	1158(ra) # 80002918 <myproc>
    8000349a:	87aa                	mv	a5,a0
    8000349c:	853e                	mv	a0,a5
    8000349e:	ffffe097          	auipc	ra,0xffffe
    800034a2:	ef0080e7          	jalr	-272(ra) # 8000138e <release>

  if (first) {
    800034a6:	00008797          	auipc	a5,0x8
    800034aa:	31e78793          	addi	a5,a5,798 # 8000b7c4 <first.1699>
    800034ae:	439c                	lw	a5,0(a5)
    800034b0:	cf81                	beqz	a5,800034c8 <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    800034b2:	00008797          	auipc	a5,0x8
    800034b6:	31278793          	addi	a5,a5,786 # 8000b7c4 <first.1699>
    800034ba:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    800034be:	4505                	li	a0,1
    800034c0:	00001097          	auipc	ra,0x1
    800034c4:	528080e7          	jalr	1320(ra) # 800049e8 <fsinit>
  }

  usertrapret();
    800034c8:	00000097          	auipc	ra,0x0
    800034cc:	7dc080e7          	jalr	2012(ra) # 80003ca4 <usertrapret>
}
    800034d0:	0001                	nop
    800034d2:	60a2                	ld	ra,8(sp)
    800034d4:	6402                	ld	s0,0(sp)
    800034d6:	0141                	addi	sp,sp,16
    800034d8:	8082                	ret

00000000800034da <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800034da:	7179                	addi	sp,sp,-48
    800034dc:	f406                	sd	ra,40(sp)
    800034de:	f022                	sd	s0,32(sp)
    800034e0:	1800                	addi	s0,sp,48
    800034e2:	fca43c23          	sd	a0,-40(s0)
    800034e6:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    800034ea:	fffff097          	auipc	ra,0xfffff
    800034ee:	42e080e7          	jalr	1070(ra) # 80002918 <myproc>
    800034f2:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800034f6:	fe843783          	ld	a5,-24(s0)
    800034fa:	853e                	mv	a0,a5
    800034fc:	ffffe097          	auipc	ra,0xffffe
    80003500:	e2e080e7          	jalr	-466(ra) # 8000132a <acquire>
  release(lk);
    80003504:	fd043503          	ld	a0,-48(s0)
    80003508:	ffffe097          	auipc	ra,0xffffe
    8000350c:	e86080e7          	jalr	-378(ra) # 8000138e <release>

  // Go to sleep.
  p->chan = chan;
    80003510:	fe843783          	ld	a5,-24(s0)
    80003514:	fd843703          	ld	a4,-40(s0)
    80003518:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    8000351a:	fe843783          	ld	a5,-24(s0)
    8000351e:	4709                	li	a4,2
    80003520:	cf98                	sw	a4,24(a5)

  sched();
    80003522:	00000097          	auipc	ra,0x0
    80003526:	e3c080e7          	jalr	-452(ra) # 8000335e <sched>

  // Tidy up.
  p->chan = 0;
    8000352a:	fe843783          	ld	a5,-24(s0)
    8000352e:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    80003532:	fe843783          	ld	a5,-24(s0)
    80003536:	853e                	mv	a0,a5
    80003538:	ffffe097          	auipc	ra,0xffffe
    8000353c:	e56080e7          	jalr	-426(ra) # 8000138e <release>
  acquire(lk);
    80003540:	fd043503          	ld	a0,-48(s0)
    80003544:	ffffe097          	auipc	ra,0xffffe
    80003548:	de6080e7          	jalr	-538(ra) # 8000132a <acquire>
}
    8000354c:	0001                	nop
    8000354e:	70a2                	ld	ra,40(sp)
    80003550:	7402                	ld	s0,32(sp)
    80003552:	6145                	addi	sp,sp,48
    80003554:	8082                	ret

0000000080003556 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80003556:	7179                	addi	sp,sp,-48
    80003558:	f406                	sd	ra,40(sp)
    8000355a:	f022                	sd	s0,32(sp)
    8000355c:	1800                	addi	s0,sp,48
    8000355e:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80003562:	00011797          	auipc	a5,0x11
    80003566:	a5678793          	addi	a5,a5,-1450 # 80013fb8 <proc>
    8000356a:	fef43423          	sd	a5,-24(s0)
    8000356e:	a051                	j	800035f2 <wakeup+0x9c>
    if(p != myproc()){
    80003570:	fffff097          	auipc	ra,0xfffff
    80003574:	3a8080e7          	jalr	936(ra) # 80002918 <myproc>
    80003578:	872a                	mv	a4,a0
    8000357a:	fe843783          	ld	a5,-24(s0)
    8000357e:	06e78463          	beq	a5,a4,800035e6 <wakeup+0x90>
      if (holding(&p->lock) && p->state == USED ) {
    80003582:	fe843783          	ld	a5,-24(s0)
    80003586:	853e                	mv	a0,a5
    80003588:	ffffe097          	auipc	ra,0xffffe
    8000358c:	e5c080e7          	jalr	-420(ra) # 800013e4 <holding>
    80003590:	87aa                	mv	a5,a0
    80003592:	cb81                	beqz	a5,800035a2 <wakeup+0x4c>
    80003594:	fe843783          	ld	a5,-24(s0)
    80003598:	4f9c                	lw	a5,24(a5)
    8000359a:	873e                	mv	a4,a5
    8000359c:	4785                	li	a5,1
    8000359e:	04f70363          	beq	a4,a5,800035e4 <wakeup+0x8e>
        // Process is being created.
        continue;
      }
      acquire(&p->lock);
    800035a2:	fe843783          	ld	a5,-24(s0)
    800035a6:	853e                	mv	a0,a5
    800035a8:	ffffe097          	auipc	ra,0xffffe
    800035ac:	d82080e7          	jalr	-638(ra) # 8000132a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800035b0:	fe843783          	ld	a5,-24(s0)
    800035b4:	4f9c                	lw	a5,24(a5)
    800035b6:	873e                	mv	a4,a5
    800035b8:	4789                	li	a5,2
    800035ba:	00f71d63          	bne	a4,a5,800035d4 <wakeup+0x7e>
    800035be:	fe843783          	ld	a5,-24(s0)
    800035c2:	739c                	ld	a5,32(a5)
    800035c4:	fd843703          	ld	a4,-40(s0)
    800035c8:	00f71663          	bne	a4,a5,800035d4 <wakeup+0x7e>
        p->state = RUNNABLE;
    800035cc:	fe843783          	ld	a5,-24(s0)
    800035d0:	470d                	li	a4,3
    800035d2:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800035d4:	fe843783          	ld	a5,-24(s0)
    800035d8:	853e                	mv	a0,a5
    800035da:	ffffe097          	auipc	ra,0xffffe
    800035de:	db4080e7          	jalr	-588(ra) # 8000138e <release>
    800035e2:	a011                	j	800035e6 <wakeup+0x90>
        continue;
    800035e4:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++) {
    800035e6:	fe843783          	ld	a5,-24(s0)
    800035ea:	16878793          	addi	a5,a5,360
    800035ee:	fef43423          	sd	a5,-24(s0)
    800035f2:	fe843703          	ld	a4,-24(s0)
    800035f6:	00016797          	auipc	a5,0x16
    800035fa:	3c278793          	addi	a5,a5,962 # 800199b8 <pid_lock>
    800035fe:	f6f769e3          	bltu	a4,a5,80003570 <wakeup+0x1a>
    }
  }
}
    80003602:	0001                	nop
    80003604:	0001                	nop
    80003606:	70a2                	ld	ra,40(sp)
    80003608:	7402                	ld	s0,32(sp)
    8000360a:	6145                	addi	sp,sp,48
    8000360c:	8082                	ret

000000008000360e <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    8000360e:	7179                	addi	sp,sp,-48
    80003610:	f406                	sd	ra,40(sp)
    80003612:	f022                	sd	s0,32(sp)
    80003614:	1800                	addi	s0,sp,48
    80003616:	87aa                	mv	a5,a0
    80003618:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    8000361c:	00011797          	auipc	a5,0x11
    80003620:	99c78793          	addi	a5,a5,-1636 # 80013fb8 <proc>
    80003624:	fef43423          	sd	a5,-24(s0)
    80003628:	a0ad                	j	80003692 <kill+0x84>
    acquire(&p->lock);
    8000362a:	fe843783          	ld	a5,-24(s0)
    8000362e:	853e                	mv	a0,a5
    80003630:	ffffe097          	auipc	ra,0xffffe
    80003634:	cfa080e7          	jalr	-774(ra) # 8000132a <acquire>
    if(p->pid == pid){
    80003638:	fe843783          	ld	a5,-24(s0)
    8000363c:	5b98                	lw	a4,48(a5)
    8000363e:	fdc42783          	lw	a5,-36(s0)
    80003642:	2781                	sext.w	a5,a5
    80003644:	02e79a63          	bne	a5,a4,80003678 <kill+0x6a>
      p->killed = 1;
    80003648:	fe843783          	ld	a5,-24(s0)
    8000364c:	4705                	li	a4,1
    8000364e:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    80003650:	fe843783          	ld	a5,-24(s0)
    80003654:	4f9c                	lw	a5,24(a5)
    80003656:	873e                	mv	a4,a5
    80003658:	4789                	li	a5,2
    8000365a:	00f71663          	bne	a4,a5,80003666 <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    8000365e:	fe843783          	ld	a5,-24(s0)
    80003662:	470d                	li	a4,3
    80003664:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003666:	fe843783          	ld	a5,-24(s0)
    8000366a:	853e                	mv	a0,a5
    8000366c:	ffffe097          	auipc	ra,0xffffe
    80003670:	d22080e7          	jalr	-734(ra) # 8000138e <release>
      return 0;
    80003674:	4781                	li	a5,0
    80003676:	a03d                	j	800036a4 <kill+0x96>
    }
    release(&p->lock);
    80003678:	fe843783          	ld	a5,-24(s0)
    8000367c:	853e                	mv	a0,a5
    8000367e:	ffffe097          	auipc	ra,0xffffe
    80003682:	d10080e7          	jalr	-752(ra) # 8000138e <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80003686:	fe843783          	ld	a5,-24(s0)
    8000368a:	16878793          	addi	a5,a5,360
    8000368e:	fef43423          	sd	a5,-24(s0)
    80003692:	fe843703          	ld	a4,-24(s0)
    80003696:	00016797          	auipc	a5,0x16
    8000369a:	32278793          	addi	a5,a5,802 # 800199b8 <pid_lock>
    8000369e:	f8f766e3          	bltu	a4,a5,8000362a <kill+0x1c>
  }
  return -1;
    800036a2:	57fd                	li	a5,-1
}
    800036a4:	853e                	mv	a0,a5
    800036a6:	70a2                	ld	ra,40(sp)
    800036a8:	7402                	ld	s0,32(sp)
    800036aa:	6145                	addi	sp,sp,48
    800036ac:	8082                	ret

00000000800036ae <setkilled>:

void
setkilled(struct proc *p)
{
    800036ae:	1101                	addi	sp,sp,-32
    800036b0:	ec06                	sd	ra,24(sp)
    800036b2:	e822                	sd	s0,16(sp)
    800036b4:	1000                	addi	s0,sp,32
    800036b6:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    800036ba:	fe843783          	ld	a5,-24(s0)
    800036be:	853e                	mv	a0,a5
    800036c0:	ffffe097          	auipc	ra,0xffffe
    800036c4:	c6a080e7          	jalr	-918(ra) # 8000132a <acquire>
  p->killed = 1;
    800036c8:	fe843783          	ld	a5,-24(s0)
    800036cc:	4705                	li	a4,1
    800036ce:	d798                	sw	a4,40(a5)
  release(&p->lock);
    800036d0:	fe843783          	ld	a5,-24(s0)
    800036d4:	853e                	mv	a0,a5
    800036d6:	ffffe097          	auipc	ra,0xffffe
    800036da:	cb8080e7          	jalr	-840(ra) # 8000138e <release>
}
    800036de:	0001                	nop
    800036e0:	60e2                	ld	ra,24(sp)
    800036e2:	6442                	ld	s0,16(sp)
    800036e4:	6105                	addi	sp,sp,32
    800036e6:	8082                	ret

00000000800036e8 <killed>:

int
killed(struct proc *p)
{
    800036e8:	7179                	addi	sp,sp,-48
    800036ea:	f406                	sd	ra,40(sp)
    800036ec:	f022                	sd	s0,32(sp)
    800036ee:	1800                	addi	s0,sp,48
    800036f0:	fca43c23          	sd	a0,-40(s0)
  int k;
  
  acquire(&p->lock);
    800036f4:	fd843783          	ld	a5,-40(s0)
    800036f8:	853e                	mv	a0,a5
    800036fa:	ffffe097          	auipc	ra,0xffffe
    800036fe:	c30080e7          	jalr	-976(ra) # 8000132a <acquire>
  k = p->killed;
    80003702:	fd843783          	ld	a5,-40(s0)
    80003706:	579c                	lw	a5,40(a5)
    80003708:	fef42623          	sw	a5,-20(s0)
  release(&p->lock);
    8000370c:	fd843783          	ld	a5,-40(s0)
    80003710:	853e                	mv	a0,a5
    80003712:	ffffe097          	auipc	ra,0xffffe
    80003716:	c7c080e7          	jalr	-900(ra) # 8000138e <release>
  return k;
    8000371a:	fec42783          	lw	a5,-20(s0)
}
    8000371e:	853e                	mv	a0,a5
    80003720:	70a2                	ld	ra,40(sp)
    80003722:	7402                	ld	s0,32(sp)
    80003724:	6145                	addi	sp,sp,48
    80003726:	8082                	ret

0000000080003728 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80003728:	7139                	addi	sp,sp,-64
    8000372a:	fc06                	sd	ra,56(sp)
    8000372c:	f822                	sd	s0,48(sp)
    8000372e:	0080                	addi	s0,sp,64
    80003730:	87aa                	mv	a5,a0
    80003732:	fcb43823          	sd	a1,-48(s0)
    80003736:	fcc43423          	sd	a2,-56(s0)
    8000373a:	fcd43023          	sd	a3,-64(s0)
    8000373e:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003742:	fffff097          	auipc	ra,0xfffff
    80003746:	1d6080e7          	jalr	470(ra) # 80002918 <myproc>
    8000374a:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    8000374e:	fdc42783          	lw	a5,-36(s0)
    80003752:	2781                	sext.w	a5,a5
    80003754:	c38d                	beqz	a5,80003776 <either_copyout+0x4e>
    return copyout(p->pagetable, dst, src, len);
    80003756:	fe843783          	ld	a5,-24(s0)
    8000375a:	6bbc                	ld	a5,80(a5)
    8000375c:	fc043683          	ld	a3,-64(s0)
    80003760:	fc843603          	ld	a2,-56(s0)
    80003764:	fd043583          	ld	a1,-48(s0)
    80003768:	853e                	mv	a0,a5
    8000376a:	fffff097          	auipc	ra,0xfffff
    8000376e:	c78080e7          	jalr	-904(ra) # 800023e2 <copyout>
    80003772:	87aa                	mv	a5,a0
    80003774:	a839                	j	80003792 <either_copyout+0x6a>
  } else {
    memmove((char *)dst, src, len);
    80003776:	fd043783          	ld	a5,-48(s0)
    8000377a:	fc043703          	ld	a4,-64(s0)
    8000377e:	2701                	sext.w	a4,a4
    80003780:	863a                	mv	a2,a4
    80003782:	fc843583          	ld	a1,-56(s0)
    80003786:	853e                	mv	a0,a5
    80003788:	ffffe097          	auipc	ra,0xffffe
    8000378c:	e5a080e7          	jalr	-422(ra) # 800015e2 <memmove>
    return 0;
    80003790:	4781                	li	a5,0
  }
}
    80003792:	853e                	mv	a0,a5
    80003794:	70e2                	ld	ra,56(sp)
    80003796:	7442                	ld	s0,48(sp)
    80003798:	6121                	addi	sp,sp,64
    8000379a:	8082                	ret

000000008000379c <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000379c:	7139                	addi	sp,sp,-64
    8000379e:	fc06                	sd	ra,56(sp)
    800037a0:	f822                	sd	s0,48(sp)
    800037a2:	0080                	addi	s0,sp,64
    800037a4:	fca43c23          	sd	a0,-40(s0)
    800037a8:	87ae                	mv	a5,a1
    800037aa:	fcc43423          	sd	a2,-56(s0)
    800037ae:	fcd43023          	sd	a3,-64(s0)
    800037b2:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    800037b6:	fffff097          	auipc	ra,0xfffff
    800037ba:	162080e7          	jalr	354(ra) # 80002918 <myproc>
    800037be:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    800037c2:	fd442783          	lw	a5,-44(s0)
    800037c6:	2781                	sext.w	a5,a5
    800037c8:	c38d                	beqz	a5,800037ea <either_copyin+0x4e>
    return copyin(p->pagetable, dst, src, len);
    800037ca:	fe843783          	ld	a5,-24(s0)
    800037ce:	6bbc                	ld	a5,80(a5)
    800037d0:	fc043683          	ld	a3,-64(s0)
    800037d4:	fc843603          	ld	a2,-56(s0)
    800037d8:	fd843583          	ld	a1,-40(s0)
    800037dc:	853e                	mv	a0,a5
    800037de:	fffff097          	auipc	ra,0xfffff
    800037e2:	cd2080e7          	jalr	-814(ra) # 800024b0 <copyin>
    800037e6:	87aa                	mv	a5,a0
    800037e8:	a839                	j	80003806 <either_copyin+0x6a>
  } else {
    memmove(dst, (char*)src, len);
    800037ea:	fc843783          	ld	a5,-56(s0)
    800037ee:	fc043703          	ld	a4,-64(s0)
    800037f2:	2701                	sext.w	a4,a4
    800037f4:	863a                	mv	a2,a4
    800037f6:	85be                	mv	a1,a5
    800037f8:	fd843503          	ld	a0,-40(s0)
    800037fc:	ffffe097          	auipc	ra,0xffffe
    80003800:	de6080e7          	jalr	-538(ra) # 800015e2 <memmove>
    return 0;
    80003804:	4781                	li	a5,0
  }
}
    80003806:	853e                	mv	a0,a5
    80003808:	70e2                	ld	ra,56(sp)
    8000380a:	7442                	ld	s0,48(sp)
    8000380c:	6121                	addi	sp,sp,64
    8000380e:	8082                	ret

0000000080003810 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80003810:	1101                	addi	sp,sp,-32
    80003812:	ec06                	sd	ra,24(sp)
    80003814:	e822                	sd	s0,16(sp)
    80003816:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80003818:	00008517          	auipc	a0,0x8
    8000381c:	a6850513          	addi	a0,a0,-1432 # 8000b280 <etext+0x280>
    80003820:	ffffd097          	auipc	ra,0xffffd
    80003824:	216080e7          	jalr	534(ra) # 80000a36 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80003828:	00010797          	auipc	a5,0x10
    8000382c:	79078793          	addi	a5,a5,1936 # 80013fb8 <proc>
    80003830:	fef43423          	sd	a5,-24(s0)
    80003834:	a04d                	j	800038d6 <procdump+0xc6>
    if(p->state == UNUSED)
    80003836:	fe843783          	ld	a5,-24(s0)
    8000383a:	4f9c                	lw	a5,24(a5)
    8000383c:	c7d1                	beqz	a5,800038c8 <procdump+0xb8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000383e:	fe843783          	ld	a5,-24(s0)
    80003842:	4f9c                	lw	a5,24(a5)
    80003844:	873e                	mv	a4,a5
    80003846:	4795                	li	a5,5
    80003848:	02e7ee63          	bltu	a5,a4,80003884 <procdump+0x74>
    8000384c:	fe843783          	ld	a5,-24(s0)
    80003850:	4f9c                	lw	a5,24(a5)
    80003852:	00008717          	auipc	a4,0x8
    80003856:	fce70713          	addi	a4,a4,-50 # 8000b820 <states.1744>
    8000385a:	1782                	slli	a5,a5,0x20
    8000385c:	9381                	srli	a5,a5,0x20
    8000385e:	078e                	slli	a5,a5,0x3
    80003860:	97ba                	add	a5,a5,a4
    80003862:	639c                	ld	a5,0(a5)
    80003864:	c385                	beqz	a5,80003884 <procdump+0x74>
      state = states[p->state];
    80003866:	fe843783          	ld	a5,-24(s0)
    8000386a:	4f9c                	lw	a5,24(a5)
    8000386c:	00008717          	auipc	a4,0x8
    80003870:	fb470713          	addi	a4,a4,-76 # 8000b820 <states.1744>
    80003874:	1782                	slli	a5,a5,0x20
    80003876:	9381                	srli	a5,a5,0x20
    80003878:	078e                	slli	a5,a5,0x3
    8000387a:	97ba                	add	a5,a5,a4
    8000387c:	639c                	ld	a5,0(a5)
    8000387e:	fef43023          	sd	a5,-32(s0)
    80003882:	a039                	j	80003890 <procdump+0x80>
    else
      state = "???";
    80003884:	00008797          	auipc	a5,0x8
    80003888:	a0478793          	addi	a5,a5,-1532 # 8000b288 <etext+0x288>
    8000388c:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    80003890:	fe843783          	ld	a5,-24(s0)
    80003894:	5b98                	lw	a4,48(a5)
    80003896:	fe843783          	ld	a5,-24(s0)
    8000389a:	15878793          	addi	a5,a5,344
    8000389e:	86be                	mv	a3,a5
    800038a0:	fe043603          	ld	a2,-32(s0)
    800038a4:	85ba                	mv	a1,a4
    800038a6:	00008517          	auipc	a0,0x8
    800038aa:	9ea50513          	addi	a0,a0,-1558 # 8000b290 <etext+0x290>
    800038ae:	ffffd097          	auipc	ra,0xffffd
    800038b2:	188080e7          	jalr	392(ra) # 80000a36 <printf>
    printf("\n");
    800038b6:	00008517          	auipc	a0,0x8
    800038ba:	9ca50513          	addi	a0,a0,-1590 # 8000b280 <etext+0x280>
    800038be:	ffffd097          	auipc	ra,0xffffd
    800038c2:	178080e7          	jalr	376(ra) # 80000a36 <printf>
    800038c6:	a011                	j	800038ca <procdump+0xba>
      continue;
    800038c8:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    800038ca:	fe843783          	ld	a5,-24(s0)
    800038ce:	16878793          	addi	a5,a5,360
    800038d2:	fef43423          	sd	a5,-24(s0)
    800038d6:	fe843703          	ld	a4,-24(s0)
    800038da:	00016797          	auipc	a5,0x16
    800038de:	0de78793          	addi	a5,a5,222 # 800199b8 <pid_lock>
    800038e2:	f4f76ae3          	bltu	a4,a5,80003836 <procdump+0x26>
  }
}
    800038e6:	0001                	nop
    800038e8:	0001                	nop
    800038ea:	60e2                	ld	ra,24(sp)
    800038ec:	6442                	ld	s0,16(sp)
    800038ee:	6105                	addi	sp,sp,32
    800038f0:	8082                	ret

00000000800038f2 <swtch>:
    800038f2:	00153023          	sd	ra,0(a0)
    800038f6:	00253423          	sd	sp,8(a0)
    800038fa:	e900                	sd	s0,16(a0)
    800038fc:	ed04                	sd	s1,24(a0)
    800038fe:	03253023          	sd	s2,32(a0)
    80003902:	03353423          	sd	s3,40(a0)
    80003906:	03453823          	sd	s4,48(a0)
    8000390a:	03553c23          	sd	s5,56(a0)
    8000390e:	05653023          	sd	s6,64(a0)
    80003912:	05753423          	sd	s7,72(a0)
    80003916:	05853823          	sd	s8,80(a0)
    8000391a:	05953c23          	sd	s9,88(a0)
    8000391e:	07a53023          	sd	s10,96(a0)
    80003922:	07b53423          	sd	s11,104(a0)
    80003926:	0005b083          	ld	ra,0(a1)
    8000392a:	0085b103          	ld	sp,8(a1)
    8000392e:	6980                	ld	s0,16(a1)
    80003930:	6d84                	ld	s1,24(a1)
    80003932:	0205b903          	ld	s2,32(a1)
    80003936:	0285b983          	ld	s3,40(a1)
    8000393a:	0305ba03          	ld	s4,48(a1)
    8000393e:	0385ba83          	ld	s5,56(a1)
    80003942:	0405bb03          	ld	s6,64(a1)
    80003946:	0485bb83          	ld	s7,72(a1)
    8000394a:	0505bc03          	ld	s8,80(a1)
    8000394e:	0585bc83          	ld	s9,88(a1)
    80003952:	0605bd03          	ld	s10,96(a1)
    80003956:	0685bd83          	ld	s11,104(a1)
    8000395a:	8082                	ret

000000008000395c <r_sstatus>:
{
    8000395c:	1101                	addi	sp,sp,-32
    8000395e:	ec22                	sd	s0,24(sp)
    80003960:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80003962:	100027f3          	csrr	a5,sstatus
    80003966:	fef43423          	sd	a5,-24(s0)
  return x;
    8000396a:	fe843783          	ld	a5,-24(s0)
}
    8000396e:	853e                	mv	a0,a5
    80003970:	6462                	ld	s0,24(sp)
    80003972:	6105                	addi	sp,sp,32
    80003974:	8082                	ret

0000000080003976 <w_sstatus>:
{
    80003976:	1101                	addi	sp,sp,-32
    80003978:	ec22                	sd	s0,24(sp)
    8000397a:	1000                	addi	s0,sp,32
    8000397c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80003980:	fe843783          	ld	a5,-24(s0)
    80003984:	10079073          	csrw	sstatus,a5
}
    80003988:	0001                	nop
    8000398a:	6462                	ld	s0,24(sp)
    8000398c:	6105                	addi	sp,sp,32
    8000398e:	8082                	ret

0000000080003990 <r_sip>:
{
    80003990:	1101                	addi	sp,sp,-32
    80003992:	ec22                	sd	s0,24(sp)
    80003994:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    80003996:	144027f3          	csrr	a5,sip
    8000399a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000399e:	fe843783          	ld	a5,-24(s0)
}
    800039a2:	853e                	mv	a0,a5
    800039a4:	6462                	ld	s0,24(sp)
    800039a6:	6105                	addi	sp,sp,32
    800039a8:	8082                	ret

00000000800039aa <w_sip>:
{
    800039aa:	1101                	addi	sp,sp,-32
    800039ac:	ec22                	sd	s0,24(sp)
    800039ae:	1000                	addi	s0,sp,32
    800039b0:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    800039b4:	fe843783          	ld	a5,-24(s0)
    800039b8:	14479073          	csrw	sip,a5
}
    800039bc:	0001                	nop
    800039be:	6462                	ld	s0,24(sp)
    800039c0:	6105                	addi	sp,sp,32
    800039c2:	8082                	ret

00000000800039c4 <w_sepc>:
{
    800039c4:	1101                	addi	sp,sp,-32
    800039c6:	ec22                	sd	s0,24(sp)
    800039c8:	1000                	addi	s0,sp,32
    800039ca:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800039ce:	fe843783          	ld	a5,-24(s0)
    800039d2:	14179073          	csrw	sepc,a5
}
    800039d6:	0001                	nop
    800039d8:	6462                	ld	s0,24(sp)
    800039da:	6105                	addi	sp,sp,32
    800039dc:	8082                	ret

00000000800039de <r_sepc>:
{
    800039de:	1101                	addi	sp,sp,-32
    800039e0:	ec22                	sd	s0,24(sp)
    800039e2:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800039e4:	141027f3          	csrr	a5,sepc
    800039e8:	fef43423          	sd	a5,-24(s0)
  return x;
    800039ec:	fe843783          	ld	a5,-24(s0)
}
    800039f0:	853e                	mv	a0,a5
    800039f2:	6462                	ld	s0,24(sp)
    800039f4:	6105                	addi	sp,sp,32
    800039f6:	8082                	ret

00000000800039f8 <w_stvec>:
{
    800039f8:	1101                	addi	sp,sp,-32
    800039fa:	ec22                	sd	s0,24(sp)
    800039fc:	1000                	addi	s0,sp,32
    800039fe:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    80003a02:	fe843783          	ld	a5,-24(s0)
    80003a06:	10579073          	csrw	stvec,a5
}
    80003a0a:	0001                	nop
    80003a0c:	6462                	ld	s0,24(sp)
    80003a0e:	6105                	addi	sp,sp,32
    80003a10:	8082                	ret

0000000080003a12 <r_satp>:
{
    80003a12:	1101                	addi	sp,sp,-32
    80003a14:	ec22                	sd	s0,24(sp)
    80003a16:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    80003a18:	180027f3          	csrr	a5,satp
    80003a1c:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a20:	fe843783          	ld	a5,-24(s0)
}
    80003a24:	853e                	mv	a0,a5
    80003a26:	6462                	ld	s0,24(sp)
    80003a28:	6105                	addi	sp,sp,32
    80003a2a:	8082                	ret

0000000080003a2c <r_scause>:
{
    80003a2c:	1101                	addi	sp,sp,-32
    80003a2e:	ec22                	sd	s0,24(sp)
    80003a30:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003a32:	142027f3          	csrr	a5,scause
    80003a36:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a3a:	fe843783          	ld	a5,-24(s0)
}
    80003a3e:	853e                	mv	a0,a5
    80003a40:	6462                	ld	s0,24(sp)
    80003a42:	6105                	addi	sp,sp,32
    80003a44:	8082                	ret

0000000080003a46 <r_stval>:
{
    80003a46:	1101                	addi	sp,sp,-32
    80003a48:	ec22                	sd	s0,24(sp)
    80003a4a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003a4c:	143027f3          	csrr	a5,stval
    80003a50:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a54:	fe843783          	ld	a5,-24(s0)
}
    80003a58:	853e                	mv	a0,a5
    80003a5a:	6462                	ld	s0,24(sp)
    80003a5c:	6105                	addi	sp,sp,32
    80003a5e:	8082                	ret

0000000080003a60 <intr_on>:
{
    80003a60:	1141                	addi	sp,sp,-16
    80003a62:	e406                	sd	ra,8(sp)
    80003a64:	e022                	sd	s0,0(sp)
    80003a66:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80003a68:	00000097          	auipc	ra,0x0
    80003a6c:	ef4080e7          	jalr	-268(ra) # 8000395c <r_sstatus>
    80003a70:	87aa                	mv	a5,a0
    80003a72:	0027e793          	ori	a5,a5,2
    80003a76:	853e                	mv	a0,a5
    80003a78:	00000097          	auipc	ra,0x0
    80003a7c:	efe080e7          	jalr	-258(ra) # 80003976 <w_sstatus>
}
    80003a80:	0001                	nop
    80003a82:	60a2                	ld	ra,8(sp)
    80003a84:	6402                	ld	s0,0(sp)
    80003a86:	0141                	addi	sp,sp,16
    80003a88:	8082                	ret

0000000080003a8a <intr_off>:
{
    80003a8a:	1141                	addi	sp,sp,-16
    80003a8c:	e406                	sd	ra,8(sp)
    80003a8e:	e022                	sd	s0,0(sp)
    80003a90:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80003a92:	00000097          	auipc	ra,0x0
    80003a96:	eca080e7          	jalr	-310(ra) # 8000395c <r_sstatus>
    80003a9a:	87aa                	mv	a5,a0
    80003a9c:	9bf5                	andi	a5,a5,-3
    80003a9e:	853e                	mv	a0,a5
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	ed6080e7          	jalr	-298(ra) # 80003976 <w_sstatus>
}
    80003aa8:	0001                	nop
    80003aaa:	60a2                	ld	ra,8(sp)
    80003aac:	6402                	ld	s0,0(sp)
    80003aae:	0141                	addi	sp,sp,16
    80003ab0:	8082                	ret

0000000080003ab2 <intr_get>:
{
    80003ab2:	1101                	addi	sp,sp,-32
    80003ab4:	ec06                	sd	ra,24(sp)
    80003ab6:	e822                	sd	s0,16(sp)
    80003ab8:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80003aba:	00000097          	auipc	ra,0x0
    80003abe:	ea2080e7          	jalr	-350(ra) # 8000395c <r_sstatus>
    80003ac2:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80003ac6:	fe843783          	ld	a5,-24(s0)
    80003aca:	8b89                	andi	a5,a5,2
    80003acc:	00f037b3          	snez	a5,a5
    80003ad0:	0ff7f793          	andi	a5,a5,255
    80003ad4:	2781                	sext.w	a5,a5
}
    80003ad6:	853e                	mv	a0,a5
    80003ad8:	60e2                	ld	ra,24(sp)
    80003ada:	6442                	ld	s0,16(sp)
    80003adc:	6105                	addi	sp,sp,32
    80003ade:	8082                	ret

0000000080003ae0 <r_tp>:
{
    80003ae0:	1101                	addi	sp,sp,-32
    80003ae2:	ec22                	sd	s0,24(sp)
    80003ae4:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80003ae6:	8792                	mv	a5,tp
    80003ae8:	fef43423          	sd	a5,-24(s0)
  return x;
    80003aec:	fe843783          	ld	a5,-24(s0)
}
    80003af0:	853e                	mv	a0,a5
    80003af2:	6462                	ld	s0,24(sp)
    80003af4:	6105                	addi	sp,sp,32
    80003af6:	8082                	ret

0000000080003af8 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80003af8:	1141                	addi	sp,sp,-16
    80003afa:	e406                	sd	ra,8(sp)
    80003afc:	e022                	sd	s0,0(sp)
    80003afe:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80003b00:	00007597          	auipc	a1,0x7
    80003b04:	7d858593          	addi	a1,a1,2008 # 8000b2d8 <etext+0x2d8>
    80003b08:	00016517          	auipc	a0,0x16
    80003b0c:	ee050513          	addi	a0,a0,-288 # 800199e8 <tickslock>
    80003b10:	ffffd097          	auipc	ra,0xffffd
    80003b14:	7ea080e7          	jalr	2026(ra) # 800012fa <initlock>
}
    80003b18:	0001                	nop
    80003b1a:	60a2                	ld	ra,8(sp)
    80003b1c:	6402                	ld	s0,0(sp)
    80003b1e:	0141                	addi	sp,sp,16
    80003b20:	8082                	ret

0000000080003b22 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80003b22:	1141                	addi	sp,sp,-16
    80003b24:	e406                	sd	ra,8(sp)
    80003b26:	e022                	sd	s0,0(sp)
    80003b28:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    80003b2a:	00005797          	auipc	a5,0x5
    80003b2e:	da678793          	addi	a5,a5,-602 # 800088d0 <kernelvec>
    80003b32:	853e                	mv	a0,a5
    80003b34:	00000097          	auipc	ra,0x0
    80003b38:	ec4080e7          	jalr	-316(ra) # 800039f8 <w_stvec>
}
    80003b3c:	0001                	nop
    80003b3e:	60a2                	ld	ra,8(sp)
    80003b40:	6402                	ld	s0,0(sp)
    80003b42:	0141                	addi	sp,sp,16
    80003b44:	8082                	ret

0000000080003b46 <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    80003b46:	7179                	addi	sp,sp,-48
    80003b48:	f406                	sd	ra,40(sp)
    80003b4a:	f022                	sd	s0,32(sp)
    80003b4c:	ec26                	sd	s1,24(sp)
    80003b4e:	1800                	addi	s0,sp,48
  int which_dev = 0;
    80003b50:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    80003b54:	00000097          	auipc	ra,0x0
    80003b58:	e08080e7          	jalr	-504(ra) # 8000395c <r_sstatus>
    80003b5c:	87aa                	mv	a5,a0
    80003b5e:	1007f793          	andi	a5,a5,256
    80003b62:	cb89                	beqz	a5,80003b74 <usertrap+0x2e>
    panic("usertrap: not from user mode");
    80003b64:	00007517          	auipc	a0,0x7
    80003b68:	77c50513          	addi	a0,a0,1916 # 8000b2e0 <etext+0x2e0>
    80003b6c:	ffffd097          	auipc	ra,0xffffd
    80003b70:	120080e7          	jalr	288(ra) # 80000c8c <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    80003b74:	00005797          	auipc	a5,0x5
    80003b78:	d5c78793          	addi	a5,a5,-676 # 800088d0 <kernelvec>
    80003b7c:	853e                	mv	a0,a5
    80003b7e:	00000097          	auipc	ra,0x0
    80003b82:	e7a080e7          	jalr	-390(ra) # 800039f8 <w_stvec>

  struct proc *p = myproc();
    80003b86:	fffff097          	auipc	ra,0xfffff
    80003b8a:	d92080e7          	jalr	-622(ra) # 80002918 <myproc>
    80003b8e:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80003b92:	fd043783          	ld	a5,-48(s0)
    80003b96:	6fa4                	ld	s1,88(a5)
    80003b98:	00000097          	auipc	ra,0x0
    80003b9c:	e46080e7          	jalr	-442(ra) # 800039de <r_sepc>
    80003ba0:	87aa                	mv	a5,a0
    80003ba2:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80003ba4:	00000097          	auipc	ra,0x0
    80003ba8:	e88080e7          	jalr	-376(ra) # 80003a2c <r_scause>
    80003bac:	872a                	mv	a4,a0
    80003bae:	47a1                	li	a5,8
    80003bb0:	04f71163          	bne	a4,a5,80003bf2 <usertrap+0xac>
    // system call

    if(killed(p))
    80003bb4:	fd043503          	ld	a0,-48(s0)
    80003bb8:	00000097          	auipc	ra,0x0
    80003bbc:	b30080e7          	jalr	-1232(ra) # 800036e8 <killed>
    80003bc0:	87aa                	mv	a5,a0
    80003bc2:	c791                	beqz	a5,80003bce <usertrap+0x88>
      exit(-1);
    80003bc4:	557d                	li	a0,-1
    80003bc6:	fffff097          	auipc	ra,0xfffff
    80003bca:	444080e7          	jalr	1092(ra) # 8000300a <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    80003bce:	fd043783          	ld	a5,-48(s0)
    80003bd2:	6fbc                	ld	a5,88(a5)
    80003bd4:	6f98                	ld	a4,24(a5)
    80003bd6:	fd043783          	ld	a5,-48(s0)
    80003bda:	6fbc                	ld	a5,88(a5)
    80003bdc:	0711                	addi	a4,a4,4
    80003bde:	ef98                	sd	a4,24(a5)

    // an interrupt will change sepc, scause, and sstatus,
    // so enable only now that we're done with those registers.
    intr_on();
    80003be0:	00000097          	auipc	ra,0x0
    80003be4:	e80080e7          	jalr	-384(ra) # 80003a60 <intr_on>

    syscall();
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	688080e7          	jalr	1672(ra) # 80004270 <syscall>
    80003bf0:	a885                	j	80003c60 <usertrap+0x11a>
  } else if((which_dev = devintr()) != 0){
    80003bf2:	00000097          	auipc	ra,0x0
    80003bf6:	34e080e7          	jalr	846(ra) # 80003f40 <devintr>
    80003bfa:	87aa                	mv	a5,a0
    80003bfc:	fcf42e23          	sw	a5,-36(s0)
    80003c00:	fdc42783          	lw	a5,-36(s0)
    80003c04:	2781                	sext.w	a5,a5
    80003c06:	efa9                	bnez	a5,80003c60 <usertrap+0x11a>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80003c08:	00000097          	auipc	ra,0x0
    80003c0c:	e24080e7          	jalr	-476(ra) # 80003a2c <r_scause>
    80003c10:	872a                	mv	a4,a0
    80003c12:	fd043783          	ld	a5,-48(s0)
    80003c16:	5b9c                	lw	a5,48(a5)
    80003c18:	863e                	mv	a2,a5
    80003c1a:	85ba                	mv	a1,a4
    80003c1c:	00007517          	auipc	a0,0x7
    80003c20:	6e450513          	addi	a0,a0,1764 # 8000b300 <etext+0x300>
    80003c24:	ffffd097          	auipc	ra,0xffffd
    80003c28:	e12080e7          	jalr	-494(ra) # 80000a36 <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80003c2c:	00000097          	auipc	ra,0x0
    80003c30:	db2080e7          	jalr	-590(ra) # 800039de <r_sepc>
    80003c34:	84aa                	mv	s1,a0
    80003c36:	00000097          	auipc	ra,0x0
    80003c3a:	e10080e7          	jalr	-496(ra) # 80003a46 <r_stval>
    80003c3e:	87aa                	mv	a5,a0
    80003c40:	863e                	mv	a2,a5
    80003c42:	85a6                	mv	a1,s1
    80003c44:	00007517          	auipc	a0,0x7
    80003c48:	6ec50513          	addi	a0,a0,1772 # 8000b330 <etext+0x330>
    80003c4c:	ffffd097          	auipc	ra,0xffffd
    80003c50:	dea080e7          	jalr	-534(ra) # 80000a36 <printf>
    setkilled(p);
    80003c54:	fd043503          	ld	a0,-48(s0)
    80003c58:	00000097          	auipc	ra,0x0
    80003c5c:	a56080e7          	jalr	-1450(ra) # 800036ae <setkilled>
  }

  if(killed(p))
    80003c60:	fd043503          	ld	a0,-48(s0)
    80003c64:	00000097          	auipc	ra,0x0
    80003c68:	a84080e7          	jalr	-1404(ra) # 800036e8 <killed>
    80003c6c:	87aa                	mv	a5,a0
    80003c6e:	c791                	beqz	a5,80003c7a <usertrap+0x134>
    exit(-1);
    80003c70:	557d                	li	a0,-1
    80003c72:	fffff097          	auipc	ra,0xfffff
    80003c76:	398080e7          	jalr	920(ra) # 8000300a <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    80003c7a:	fdc42783          	lw	a5,-36(s0)
    80003c7e:	0007871b          	sext.w	a4,a5
    80003c82:	4789                	li	a5,2
    80003c84:	00f71663          	bne	a4,a5,80003c90 <usertrap+0x14a>
    yield();
    80003c88:	fffff097          	auipc	ra,0xfffff
    80003c8c:	7b8080e7          	jalr	1976(ra) # 80003440 <yield>

  usertrapret();
    80003c90:	00000097          	auipc	ra,0x0
    80003c94:	014080e7          	jalr	20(ra) # 80003ca4 <usertrapret>
}
    80003c98:	0001                	nop
    80003c9a:	70a2                	ld	ra,40(sp)
    80003c9c:	7402                	ld	s0,32(sp)
    80003c9e:	64e2                	ld	s1,24(sp)
    80003ca0:	6145                	addi	sp,sp,48
    80003ca2:	8082                	ret

0000000080003ca4 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80003ca4:	715d                	addi	sp,sp,-80
    80003ca6:	e486                	sd	ra,72(sp)
    80003ca8:	e0a2                	sd	s0,64(sp)
    80003caa:	fc26                	sd	s1,56(sp)
    80003cac:	0880                	addi	s0,sp,80
  struct proc *p = myproc();
    80003cae:	fffff097          	auipc	ra,0xfffff
    80003cb2:	c6a080e7          	jalr	-918(ra) # 80002918 <myproc>
    80003cb6:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    80003cba:	00000097          	auipc	ra,0x0
    80003cbe:	dd0080e7          	jalr	-560(ra) # 80003a8a <intr_off>

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80003cc2:	00006717          	auipc	a4,0x6
    80003cc6:	33e70713          	addi	a4,a4,830 # 8000a000 <_trampoline>
    80003cca:	00006797          	auipc	a5,0x6
    80003cce:	33678793          	addi	a5,a5,822 # 8000a000 <_trampoline>
    80003cd2:	8f1d                	sub	a4,a4,a5
    80003cd4:	040007b7          	lui	a5,0x4000
    80003cd8:	17fd                	addi	a5,a5,-1
    80003cda:	07b2                	slli	a5,a5,0xc
    80003cdc:	97ba                	add	a5,a5,a4
    80003cde:	fcf43823          	sd	a5,-48(s0)
  w_stvec(trampoline_uservec);
    80003ce2:	fd043503          	ld	a0,-48(s0)
    80003ce6:	00000097          	auipc	ra,0x0
    80003cea:	d12080e7          	jalr	-750(ra) # 800039f8 <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80003cee:	fd843783          	ld	a5,-40(s0)
    80003cf2:	6fa4                	ld	s1,88(a5)
    80003cf4:	00000097          	auipc	ra,0x0
    80003cf8:	d1e080e7          	jalr	-738(ra) # 80003a12 <r_satp>
    80003cfc:	87aa                	mv	a5,a0
    80003cfe:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80003d00:	fd843783          	ld	a5,-40(s0)
    80003d04:	63b4                	ld	a3,64(a5)
    80003d06:	fd843783          	ld	a5,-40(s0)
    80003d0a:	6fbc                	ld	a5,88(a5)
    80003d0c:	6705                	lui	a4,0x1
    80003d0e:	9736                	add	a4,a4,a3
    80003d10:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80003d12:	fd843783          	ld	a5,-40(s0)
    80003d16:	6fbc                	ld	a5,88(a5)
    80003d18:	00000717          	auipc	a4,0x0
    80003d1c:	e2e70713          	addi	a4,a4,-466 # 80003b46 <usertrap>
    80003d20:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80003d22:	fd843783          	ld	a5,-40(s0)
    80003d26:	6fa4                	ld	s1,88(a5)
    80003d28:	00000097          	auipc	ra,0x0
    80003d2c:	db8080e7          	jalr	-584(ra) # 80003ae0 <r_tp>
    80003d30:	87aa                	mv	a5,a0
    80003d32:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    80003d34:	00000097          	auipc	ra,0x0
    80003d38:	c28080e7          	jalr	-984(ra) # 8000395c <r_sstatus>
    80003d3c:	fca43423          	sd	a0,-56(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80003d40:	fc843783          	ld	a5,-56(s0)
    80003d44:	eff7f793          	andi	a5,a5,-257
    80003d48:	fcf43423          	sd	a5,-56(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80003d4c:	fc843783          	ld	a5,-56(s0)
    80003d50:	0207e793          	ori	a5,a5,32
    80003d54:	fcf43423          	sd	a5,-56(s0)
  w_sstatus(x);
    80003d58:	fc843503          	ld	a0,-56(s0)
    80003d5c:	00000097          	auipc	ra,0x0
    80003d60:	c1a080e7          	jalr	-998(ra) # 80003976 <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80003d64:	fd843783          	ld	a5,-40(s0)
    80003d68:	6fbc                	ld	a5,88(a5)
    80003d6a:	6f9c                	ld	a5,24(a5)
    80003d6c:	853e                	mv	a0,a5
    80003d6e:	00000097          	auipc	ra,0x0
    80003d72:	c56080e7          	jalr	-938(ra) # 800039c4 <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80003d76:	fd843783          	ld	a5,-40(s0)
    80003d7a:	6bbc                	ld	a5,80(a5)
    80003d7c:	00c7d713          	srli	a4,a5,0xc
    80003d80:	57fd                	li	a5,-1
    80003d82:	17fe                	slli	a5,a5,0x3f
    80003d84:	8fd9                	or	a5,a5,a4
    80003d86:	fcf43023          	sd	a5,-64(s0)

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80003d8a:	00006717          	auipc	a4,0x6
    80003d8e:	31270713          	addi	a4,a4,786 # 8000a09c <userret>
    80003d92:	00006797          	auipc	a5,0x6
    80003d96:	26e78793          	addi	a5,a5,622 # 8000a000 <_trampoline>
    80003d9a:	8f1d                	sub	a4,a4,a5
    80003d9c:	040007b7          	lui	a5,0x4000
    80003da0:	17fd                	addi	a5,a5,-1
    80003da2:	07b2                	slli	a5,a5,0xc
    80003da4:	97ba                	add	a5,a5,a4
    80003da6:	faf43c23          	sd	a5,-72(s0)
  ((void (*)(uint64))trampoline_userret)(satp);
    80003daa:	fb843783          	ld	a5,-72(s0)
    80003dae:	fc043503          	ld	a0,-64(s0)
    80003db2:	9782                	jalr	a5
}
    80003db4:	0001                	nop
    80003db6:	60a6                	ld	ra,72(sp)
    80003db8:	6406                	ld	s0,64(sp)
    80003dba:	74e2                	ld	s1,56(sp)
    80003dbc:	6161                	addi	sp,sp,80
    80003dbe:	8082                	ret

0000000080003dc0 <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80003dc0:	7139                	addi	sp,sp,-64
    80003dc2:	fc06                	sd	ra,56(sp)
    80003dc4:	f822                	sd	s0,48(sp)
    80003dc6:	f426                	sd	s1,40(sp)
    80003dc8:	0080                	addi	s0,sp,64
  int which_dev = 0;
    80003dca:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80003dce:	00000097          	auipc	ra,0x0
    80003dd2:	c10080e7          	jalr	-1008(ra) # 800039de <r_sepc>
    80003dd6:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    80003dda:	00000097          	auipc	ra,0x0
    80003dde:	b82080e7          	jalr	-1150(ra) # 8000395c <r_sstatus>
    80003de2:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    80003de6:	00000097          	auipc	ra,0x0
    80003dea:	c46080e7          	jalr	-954(ra) # 80003a2c <r_scause>
    80003dee:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80003df2:	fc843783          	ld	a5,-56(s0)
    80003df6:	1007f793          	andi	a5,a5,256
    80003dfa:	eb89                	bnez	a5,80003e0c <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    80003dfc:	00007517          	auipc	a0,0x7
    80003e00:	55450513          	addi	a0,a0,1364 # 8000b350 <etext+0x350>
    80003e04:	ffffd097          	auipc	ra,0xffffd
    80003e08:	e88080e7          	jalr	-376(ra) # 80000c8c <panic>
  if(intr_get() != 0)
    80003e0c:	00000097          	auipc	ra,0x0
    80003e10:	ca6080e7          	jalr	-858(ra) # 80003ab2 <intr_get>
    80003e14:	87aa                	mv	a5,a0
    80003e16:	cb89                	beqz	a5,80003e28 <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    80003e18:	00007517          	auipc	a0,0x7
    80003e1c:	56050513          	addi	a0,a0,1376 # 8000b378 <etext+0x378>
    80003e20:	ffffd097          	auipc	ra,0xffffd
    80003e24:	e6c080e7          	jalr	-404(ra) # 80000c8c <panic>

  if((which_dev = devintr()) == 0){
    80003e28:	00000097          	auipc	ra,0x0
    80003e2c:	118080e7          	jalr	280(ra) # 80003f40 <devintr>
    80003e30:	87aa                	mv	a5,a0
    80003e32:	fcf42e23          	sw	a5,-36(s0)
    80003e36:	fdc42783          	lw	a5,-36(s0)
    80003e3a:	2781                	sext.w	a5,a5
    80003e3c:	e7b9                	bnez	a5,80003e8a <kerneltrap+0xca>
    printf("scause %p\n", scause);
    80003e3e:	fc043583          	ld	a1,-64(s0)
    80003e42:	00007517          	auipc	a0,0x7
    80003e46:	55650513          	addi	a0,a0,1366 # 8000b398 <etext+0x398>
    80003e4a:	ffffd097          	auipc	ra,0xffffd
    80003e4e:	bec080e7          	jalr	-1044(ra) # 80000a36 <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80003e52:	00000097          	auipc	ra,0x0
    80003e56:	b8c080e7          	jalr	-1140(ra) # 800039de <r_sepc>
    80003e5a:	84aa                	mv	s1,a0
    80003e5c:	00000097          	auipc	ra,0x0
    80003e60:	bea080e7          	jalr	-1046(ra) # 80003a46 <r_stval>
    80003e64:	87aa                	mv	a5,a0
    80003e66:	863e                	mv	a2,a5
    80003e68:	85a6                	mv	a1,s1
    80003e6a:	00007517          	auipc	a0,0x7
    80003e6e:	53e50513          	addi	a0,a0,1342 # 8000b3a8 <etext+0x3a8>
    80003e72:	ffffd097          	auipc	ra,0xffffd
    80003e76:	bc4080e7          	jalr	-1084(ra) # 80000a36 <printf>
    panic("kerneltrap");
    80003e7a:	00007517          	auipc	a0,0x7
    80003e7e:	54650513          	addi	a0,a0,1350 # 8000b3c0 <etext+0x3c0>
    80003e82:	ffffd097          	auipc	ra,0xffffd
    80003e86:	e0a080e7          	jalr	-502(ra) # 80000c8c <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80003e8a:	fdc42783          	lw	a5,-36(s0)
    80003e8e:	0007871b          	sext.w	a4,a5
    80003e92:	4789                	li	a5,2
    80003e94:	02f71663          	bne	a4,a5,80003ec0 <kerneltrap+0x100>
    80003e98:	fffff097          	auipc	ra,0xfffff
    80003e9c:	a80080e7          	jalr	-1408(ra) # 80002918 <myproc>
    80003ea0:	87aa                	mv	a5,a0
    80003ea2:	cf99                	beqz	a5,80003ec0 <kerneltrap+0x100>
    80003ea4:	fffff097          	auipc	ra,0xfffff
    80003ea8:	a74080e7          	jalr	-1420(ra) # 80002918 <myproc>
    80003eac:	87aa                	mv	a5,a0
    80003eae:	4f9c                	lw	a5,24(a5)
    80003eb0:	873e                	mv	a4,a5
    80003eb2:	4791                	li	a5,4
    80003eb4:	00f71663          	bne	a4,a5,80003ec0 <kerneltrap+0x100>
    yield();
    80003eb8:	fffff097          	auipc	ra,0xfffff
    80003ebc:	588080e7          	jalr	1416(ra) # 80003440 <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80003ec0:	fd043503          	ld	a0,-48(s0)
    80003ec4:	00000097          	auipc	ra,0x0
    80003ec8:	b00080e7          	jalr	-1280(ra) # 800039c4 <w_sepc>
  w_sstatus(sstatus);
    80003ecc:	fc843503          	ld	a0,-56(s0)
    80003ed0:	00000097          	auipc	ra,0x0
    80003ed4:	aa6080e7          	jalr	-1370(ra) # 80003976 <w_sstatus>
}
    80003ed8:	0001                	nop
    80003eda:	70e2                	ld	ra,56(sp)
    80003edc:	7442                	ld	s0,48(sp)
    80003ede:	74a2                	ld	s1,40(sp)
    80003ee0:	6121                	addi	sp,sp,64
    80003ee2:	8082                	ret

0000000080003ee4 <clockintr>:

void
clockintr()
{
    80003ee4:	1141                	addi	sp,sp,-16
    80003ee6:	e406                	sd	ra,8(sp)
    80003ee8:	e022                	sd	s0,0(sp)
    80003eea:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    80003eec:	00016517          	auipc	a0,0x16
    80003ef0:	afc50513          	addi	a0,a0,-1284 # 800199e8 <tickslock>
    80003ef4:	ffffd097          	auipc	ra,0xffffd
    80003ef8:	436080e7          	jalr	1078(ra) # 8000132a <acquire>
  ticks++;
    80003efc:	00008797          	auipc	a5,0x8
    80003f00:	a4c78793          	addi	a5,a5,-1460 # 8000b948 <ticks>
    80003f04:	439c                	lw	a5,0(a5)
    80003f06:	2785                	addiw	a5,a5,1
    80003f08:	0007871b          	sext.w	a4,a5
    80003f0c:	00008797          	auipc	a5,0x8
    80003f10:	a3c78793          	addi	a5,a5,-1476 # 8000b948 <ticks>
    80003f14:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    80003f16:	00008517          	auipc	a0,0x8
    80003f1a:	a3250513          	addi	a0,a0,-1486 # 8000b948 <ticks>
    80003f1e:	fffff097          	auipc	ra,0xfffff
    80003f22:	638080e7          	jalr	1592(ra) # 80003556 <wakeup>
  release(&tickslock);
    80003f26:	00016517          	auipc	a0,0x16
    80003f2a:	ac250513          	addi	a0,a0,-1342 # 800199e8 <tickslock>
    80003f2e:	ffffd097          	auipc	ra,0xffffd
    80003f32:	460080e7          	jalr	1120(ra) # 8000138e <release>
}
    80003f36:	0001                	nop
    80003f38:	60a2                	ld	ra,8(sp)
    80003f3a:	6402                	ld	s0,0(sp)
    80003f3c:	0141                	addi	sp,sp,16
    80003f3e:	8082                	ret

0000000080003f40 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80003f40:	1101                	addi	sp,sp,-32
    80003f42:	ec06                	sd	ra,24(sp)
    80003f44:	e822                	sd	s0,16(sp)
    80003f46:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    80003f48:	00000097          	auipc	ra,0x0
    80003f4c:	ae4080e7          	jalr	-1308(ra) # 80003a2c <r_scause>
    80003f50:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    80003f54:	fe843783          	ld	a5,-24(s0)
    80003f58:	0a07d263          	bgez	a5,80003ffc <devintr+0xbc>
     (scause & 0xff) == 9){
    80003f5c:	fe843783          	ld	a5,-24(s0)
    80003f60:	0ff7f713          	andi	a4,a5,255
  if((scause & 0x8000000000000000L) &&
    80003f64:	47a5                	li	a5,9
    80003f66:	08f71b63          	bne	a4,a5,80003ffc <devintr+0xbc>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    80003f6a:	00005097          	auipc	ra,0x5
    80003f6e:	aa2080e7          	jalr	-1374(ra) # 80008a0c <plic_claim>
    80003f72:	87aa                	mv	a5,a0
    80003f74:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    80003f78:	fe442783          	lw	a5,-28(s0)
    80003f7c:	0007871b          	sext.w	a4,a5
    80003f80:	47a9                	li	a5,10
    80003f82:	00f71763          	bne	a4,a5,80003f90 <devintr+0x50>
      uartintr();
    80003f86:	ffffd097          	auipc	ra,0xffffd
    80003f8a:	0a8080e7          	jalr	168(ra) # 8000102e <uartintr>
    80003f8e:	a891                	j	80003fe2 <devintr+0xa2>
    } else if(irq == VIRTIO0_IRQ){
    80003f90:	fe442783          	lw	a5,-28(s0)
    80003f94:	0007871b          	sext.w	a4,a5
    80003f98:	4785                	li	a5,1
    80003f9a:	00f71863          	bne	a4,a5,80003faa <devintr+0x6a>
      virtio_disk_intr(VIRTIO0_ID);
    80003f9e:	4501                	li	a0,0
    80003fa0:	00006097          	auipc	ra,0x6
    80003fa4:	c2a080e7          	jalr	-982(ra) # 80009bca <virtio_disk_intr>
    80003fa8:	a82d                	j	80003fe2 <devintr+0xa2>
    } else if(irq == VIRTIO1_IRQ){
    80003faa:	fe442783          	lw	a5,-28(s0)
    80003fae:	0007871b          	sext.w	a4,a5
    80003fb2:	4789                	li	a5,2
    80003fb4:	00f71863          	bne	a4,a5,80003fc4 <devintr+0x84>
      virtio_disk_intr(VIRTIO1_ID);
    80003fb8:	4505                	li	a0,1
    80003fba:	00006097          	auipc	ra,0x6
    80003fbe:	c10080e7          	jalr	-1008(ra) # 80009bca <virtio_disk_intr>
    80003fc2:	a005                	j	80003fe2 <devintr+0xa2>
    } else if(irq){
    80003fc4:	fe442783          	lw	a5,-28(s0)
    80003fc8:	2781                	sext.w	a5,a5
    80003fca:	cf81                	beqz	a5,80003fe2 <devintr+0xa2>
      printf("unexpected interrupt irq=%d\n", irq);
    80003fcc:	fe442783          	lw	a5,-28(s0)
    80003fd0:	85be                	mv	a1,a5
    80003fd2:	00007517          	auipc	a0,0x7
    80003fd6:	3fe50513          	addi	a0,a0,1022 # 8000b3d0 <etext+0x3d0>
    80003fda:	ffffd097          	auipc	ra,0xffffd
    80003fde:	a5c080e7          	jalr	-1444(ra) # 80000a36 <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    80003fe2:	fe442783          	lw	a5,-28(s0)
    80003fe6:	2781                	sext.w	a5,a5
    80003fe8:	cb81                	beqz	a5,80003ff8 <devintr+0xb8>
      plic_complete(irq);
    80003fea:	fe442783          	lw	a5,-28(s0)
    80003fee:	853e                	mv	a0,a5
    80003ff0:	00005097          	auipc	ra,0x5
    80003ff4:	a5a080e7          	jalr	-1446(ra) # 80008a4a <plic_complete>

    return 1;
    80003ff8:	4785                	li	a5,1
    80003ffa:	a081                	j	8000403a <devintr+0xfa>
  } else if(scause == 0x8000000000000001L){
    80003ffc:	fe843703          	ld	a4,-24(s0)
    80004000:	57fd                	li	a5,-1
    80004002:	17fe                	slli	a5,a5,0x3f
    80004004:	0785                	addi	a5,a5,1
    80004006:	02f71963          	bne	a4,a5,80004038 <devintr+0xf8>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    8000400a:	fffff097          	auipc	ra,0xfffff
    8000400e:	8b0080e7          	jalr	-1872(ra) # 800028ba <cpuid>
    80004012:	87aa                	mv	a5,a0
    80004014:	e789                	bnez	a5,8000401e <devintr+0xde>
      clockintr();
    80004016:	00000097          	auipc	ra,0x0
    8000401a:	ece080e7          	jalr	-306(ra) # 80003ee4 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    8000401e:	00000097          	auipc	ra,0x0
    80004022:	972080e7          	jalr	-1678(ra) # 80003990 <r_sip>
    80004026:	87aa                	mv	a5,a0
    80004028:	9bf5                	andi	a5,a5,-3
    8000402a:	853e                	mv	a0,a5
    8000402c:	00000097          	auipc	ra,0x0
    80004030:	97e080e7          	jalr	-1666(ra) # 800039aa <w_sip>

    return 2;
    80004034:	4789                	li	a5,2
    80004036:	a011                	j	8000403a <devintr+0xfa>
  } else {
    return 0;
    80004038:	4781                	li	a5,0
  }
}
    8000403a:	853e                	mv	a0,a5
    8000403c:	60e2                	ld	ra,24(sp)
    8000403e:	6442                	ld	s0,16(sp)
    80004040:	6105                	addi	sp,sp,32
    80004042:	8082                	ret

0000000080004044 <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    80004044:	7179                	addi	sp,sp,-48
    80004046:	f406                	sd	ra,40(sp)
    80004048:	f022                	sd	s0,32(sp)
    8000404a:	1800                	addi	s0,sp,48
    8000404c:	fca43c23          	sd	a0,-40(s0)
    80004050:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80004054:	fffff097          	auipc	ra,0xfffff
    80004058:	8c4080e7          	jalr	-1852(ra) # 80002918 <myproc>
    8000405c:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80004060:	fe843783          	ld	a5,-24(s0)
    80004064:	67bc                	ld	a5,72(a5)
    80004066:	fd843703          	ld	a4,-40(s0)
    8000406a:	00f77b63          	bgeu	a4,a5,80004080 <fetchaddr+0x3c>
    8000406e:	fd843783          	ld	a5,-40(s0)
    80004072:	00878713          	addi	a4,a5,8
    80004076:	fe843783          	ld	a5,-24(s0)
    8000407a:	67bc                	ld	a5,72(a5)
    8000407c:	00e7f463          	bgeu	a5,a4,80004084 <fetchaddr+0x40>
    return -1;
    80004080:	57fd                	li	a5,-1
    80004082:	a01d                	j	800040a8 <fetchaddr+0x64>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80004084:	fe843783          	ld	a5,-24(s0)
    80004088:	6bbc                	ld	a5,80(a5)
    8000408a:	46a1                	li	a3,8
    8000408c:	fd843603          	ld	a2,-40(s0)
    80004090:	fd043583          	ld	a1,-48(s0)
    80004094:	853e                	mv	a0,a5
    80004096:	ffffe097          	auipc	ra,0xffffe
    8000409a:	41a080e7          	jalr	1050(ra) # 800024b0 <copyin>
    8000409e:	87aa                	mv	a5,a0
    800040a0:	c399                	beqz	a5,800040a6 <fetchaddr+0x62>
    return -1;
    800040a2:	57fd                	li	a5,-1
    800040a4:	a011                	j	800040a8 <fetchaddr+0x64>
  return 0;
    800040a6:	4781                	li	a5,0
}
    800040a8:	853e                	mv	a0,a5
    800040aa:	70a2                	ld	ra,40(sp)
    800040ac:	7402                	ld	s0,32(sp)
    800040ae:	6145                	addi	sp,sp,48
    800040b0:	8082                	ret

00000000800040b2 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    800040b2:	7139                	addi	sp,sp,-64
    800040b4:	fc06                	sd	ra,56(sp)
    800040b6:	f822                	sd	s0,48(sp)
    800040b8:	0080                	addi	s0,sp,64
    800040ba:	fca43c23          	sd	a0,-40(s0)
    800040be:	fcb43823          	sd	a1,-48(s0)
    800040c2:	87b2                	mv	a5,a2
    800040c4:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    800040c8:	fffff097          	auipc	ra,0xfffff
    800040cc:	850080e7          	jalr	-1968(ra) # 80002918 <myproc>
    800040d0:	fea43423          	sd	a0,-24(s0)
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    800040d4:	fe843783          	ld	a5,-24(s0)
    800040d8:	6bbc                	ld	a5,80(a5)
    800040da:	fcc42703          	lw	a4,-52(s0)
    800040de:	86ba                	mv	a3,a4
    800040e0:	fd843603          	ld	a2,-40(s0)
    800040e4:	fd043583          	ld	a1,-48(s0)
    800040e8:	853e                	mv	a0,a5
    800040ea:	ffffe097          	auipc	ra,0xffffe
    800040ee:	494080e7          	jalr	1172(ra) # 8000257e <copyinstr>
    800040f2:	87aa                	mv	a5,a0
    800040f4:	0007d463          	bgez	a5,800040fc <fetchstr+0x4a>
    return -1;
    800040f8:	57fd                	li	a5,-1
    800040fa:	a801                	j	8000410a <fetchstr+0x58>
  return strlen(buf);
    800040fc:	fd043503          	ld	a0,-48(s0)
    80004100:	ffffd097          	auipc	ra,0xffffd
    80004104:	77c080e7          	jalr	1916(ra) # 8000187c <strlen>
    80004108:	87aa                	mv	a5,a0
}
    8000410a:	853e                	mv	a0,a5
    8000410c:	70e2                	ld	ra,56(sp)
    8000410e:	7442                	ld	s0,48(sp)
    80004110:	6121                	addi	sp,sp,64
    80004112:	8082                	ret

0000000080004114 <argraw>:

static uint64 argraw(int n)
{
    80004114:	7179                	addi	sp,sp,-48
    80004116:	f406                	sd	ra,40(sp)
    80004118:	f022                	sd	s0,32(sp)
    8000411a:	1800                	addi	s0,sp,48
    8000411c:	87aa                	mv	a5,a0
    8000411e:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80004122:	ffffe097          	auipc	ra,0xffffe
    80004126:	7f6080e7          	jalr	2038(ra) # 80002918 <myproc>
    8000412a:	fea43423          	sd	a0,-24(s0)
    8000412e:	fdc42783          	lw	a5,-36(s0)
    80004132:	0007871b          	sext.w	a4,a5
    80004136:	4795                	li	a5,5
    80004138:	06e7e263          	bltu	a5,a4,8000419c <argraw+0x88>
    8000413c:	fdc46783          	lwu	a5,-36(s0)
    80004140:	00279713          	slli	a4,a5,0x2
    80004144:	00007797          	auipc	a5,0x7
    80004148:	2b478793          	addi	a5,a5,692 # 8000b3f8 <etext+0x3f8>
    8000414c:	97ba                	add	a5,a5,a4
    8000414e:	439c                	lw	a5,0(a5)
    80004150:	0007871b          	sext.w	a4,a5
    80004154:	00007797          	auipc	a5,0x7
    80004158:	2a478793          	addi	a5,a5,676 # 8000b3f8 <etext+0x3f8>
    8000415c:	97ba                	add	a5,a5,a4
    8000415e:	8782                	jr	a5
  switch (n) {
  case 0:
    return p->trapframe->a0;
    80004160:	fe843783          	ld	a5,-24(s0)
    80004164:	6fbc                	ld	a5,88(a5)
    80004166:	7bbc                	ld	a5,112(a5)
    80004168:	a091                	j	800041ac <argraw+0x98>
  case 1:
    return p->trapframe->a1;
    8000416a:	fe843783          	ld	a5,-24(s0)
    8000416e:	6fbc                	ld	a5,88(a5)
    80004170:	7fbc                	ld	a5,120(a5)
    80004172:	a82d                	j	800041ac <argraw+0x98>
  case 2:
    return p->trapframe->a2;
    80004174:	fe843783          	ld	a5,-24(s0)
    80004178:	6fbc                	ld	a5,88(a5)
    8000417a:	63dc                	ld	a5,128(a5)
    8000417c:	a805                	j	800041ac <argraw+0x98>
  case 3:
    return p->trapframe->a3;
    8000417e:	fe843783          	ld	a5,-24(s0)
    80004182:	6fbc                	ld	a5,88(a5)
    80004184:	67dc                	ld	a5,136(a5)
    80004186:	a01d                	j	800041ac <argraw+0x98>
  case 4:
    return p->trapframe->a4;
    80004188:	fe843783          	ld	a5,-24(s0)
    8000418c:	6fbc                	ld	a5,88(a5)
    8000418e:	6bdc                	ld	a5,144(a5)
    80004190:	a831                	j	800041ac <argraw+0x98>
  case 5:
    return p->trapframe->a5;
    80004192:	fe843783          	ld	a5,-24(s0)
    80004196:	6fbc                	ld	a5,88(a5)
    80004198:	6fdc                	ld	a5,152(a5)
    8000419a:	a809                	j	800041ac <argraw+0x98>
  }
  panic("argraw");
    8000419c:	00007517          	auipc	a0,0x7
    800041a0:	25450513          	addi	a0,a0,596 # 8000b3f0 <etext+0x3f0>
    800041a4:	ffffd097          	auipc	ra,0xffffd
    800041a8:	ae8080e7          	jalr	-1304(ra) # 80000c8c <panic>
  return -1;
}
    800041ac:	853e                	mv	a0,a5
    800041ae:	70a2                	ld	ra,40(sp)
    800041b0:	7402                	ld	s0,32(sp)
    800041b2:	6145                	addi	sp,sp,48
    800041b4:	8082                	ret

00000000800041b6 <argint>:

// Fetch the nth 32-bit system call argument.
void argint(int n, int *ip)
{
    800041b6:	1101                	addi	sp,sp,-32
    800041b8:	ec06                	sd	ra,24(sp)
    800041ba:	e822                	sd	s0,16(sp)
    800041bc:	1000                	addi	s0,sp,32
    800041be:	87aa                	mv	a5,a0
    800041c0:	feb43023          	sd	a1,-32(s0)
    800041c4:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    800041c8:	fec42783          	lw	a5,-20(s0)
    800041cc:	853e                	mv	a0,a5
    800041ce:	00000097          	auipc	ra,0x0
    800041d2:	f46080e7          	jalr	-186(ra) # 80004114 <argraw>
    800041d6:	87aa                	mv	a5,a0
    800041d8:	0007871b          	sext.w	a4,a5
    800041dc:	fe043783          	ld	a5,-32(s0)
    800041e0:	c398                	sw	a4,0(a5)
}
    800041e2:	0001                	nop
    800041e4:	60e2                	ld	ra,24(sp)
    800041e6:	6442                	ld	s0,16(sp)
    800041e8:	6105                	addi	sp,sp,32
    800041ea:	8082                	ret

00000000800041ec <argaddr>:

// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void argaddr(int n, uint64 *ip)
{
    800041ec:	1101                	addi	sp,sp,-32
    800041ee:	ec06                	sd	ra,24(sp)
    800041f0:	e822                	sd	s0,16(sp)
    800041f2:	1000                	addi	s0,sp,32
    800041f4:	87aa                	mv	a5,a0
    800041f6:	feb43023          	sd	a1,-32(s0)
    800041fa:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    800041fe:	fec42783          	lw	a5,-20(s0)
    80004202:	853e                	mv	a0,a5
    80004204:	00000097          	auipc	ra,0x0
    80004208:	f10080e7          	jalr	-240(ra) # 80004114 <argraw>
    8000420c:	872a                	mv	a4,a0
    8000420e:	fe043783          	ld	a5,-32(s0)
    80004212:	e398                	sd	a4,0(a5)
}
    80004214:	0001                	nop
    80004216:	60e2                	ld	ra,24(sp)
    80004218:	6442                	ld	s0,16(sp)
    8000421a:	6105                	addi	sp,sp,32
    8000421c:	8082                	ret

000000008000421e <argstr>:

// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int argstr(int n, char *buf, int max)
{
    8000421e:	7179                	addi	sp,sp,-48
    80004220:	f406                	sd	ra,40(sp)
    80004222:	f022                	sd	s0,32(sp)
    80004224:	1800                	addi	s0,sp,48
    80004226:	87aa                	mv	a5,a0
    80004228:	fcb43823          	sd	a1,-48(s0)
    8000422c:	8732                	mv	a4,a2
    8000422e:	fcf42e23          	sw	a5,-36(s0)
    80004232:	87ba                	mv	a5,a4
    80004234:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  argaddr(n, &addr);
    80004238:	fe840713          	addi	a4,s0,-24
    8000423c:	fdc42783          	lw	a5,-36(s0)
    80004240:	85ba                	mv	a1,a4
    80004242:	853e                	mv	a0,a5
    80004244:	00000097          	auipc	ra,0x0
    80004248:	fa8080e7          	jalr	-88(ra) # 800041ec <argaddr>
  return fetchstr(addr, buf, max);
    8000424c:	fe843783          	ld	a5,-24(s0)
    80004250:	fd842703          	lw	a4,-40(s0)
    80004254:	863a                	mv	a2,a4
    80004256:	fd043583          	ld	a1,-48(s0)
    8000425a:	853e                	mv	a0,a5
    8000425c:	00000097          	auipc	ra,0x0
    80004260:	e56080e7          	jalr	-426(ra) # 800040b2 <fetchstr>
    80004264:	87aa                	mv	a5,a0
}
    80004266:	853e                	mv	a0,a5
    80004268:	70a2                	ld	ra,40(sp)
    8000426a:	7402                	ld	s0,32(sp)
    8000426c:	6145                	addi	sp,sp,48
    8000426e:	8082                	ret

0000000080004270 <syscall>:
[SYS_mkdir]   sys_mkdir,
[SYS_close]   sys_close,
};

void syscall(void)
{
    80004270:	7179                	addi	sp,sp,-48
    80004272:	f406                	sd	ra,40(sp)
    80004274:	f022                	sd	s0,32(sp)
    80004276:	ec26                	sd	s1,24(sp)
    80004278:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    8000427a:	ffffe097          	auipc	ra,0xffffe
    8000427e:	69e080e7          	jalr	1694(ra) # 80002918 <myproc>
    80004282:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80004286:	fd843783          	ld	a5,-40(s0)
    8000428a:	6fbc                	ld	a5,88(a5)
    8000428c:	77dc                	ld	a5,168(a5)
    8000428e:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80004292:	fd442783          	lw	a5,-44(s0)
    80004296:	2781                	sext.w	a5,a5
    80004298:	04f05263          	blez	a5,800042dc <syscall+0x6c>
    8000429c:	fd442783          	lw	a5,-44(s0)
    800042a0:	873e                	mv	a4,a5
    800042a2:	47d5                	li	a5,21
    800042a4:	02e7ec63          	bltu	a5,a4,800042dc <syscall+0x6c>
    800042a8:	00007717          	auipc	a4,0x7
    800042ac:	5a870713          	addi	a4,a4,1448 # 8000b850 <syscalls>
    800042b0:	fd442783          	lw	a5,-44(s0)
    800042b4:	078e                	slli	a5,a5,0x3
    800042b6:	97ba                	add	a5,a5,a4
    800042b8:	639c                	ld	a5,0(a5)
    800042ba:	c38d                	beqz	a5,800042dc <syscall+0x6c>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    800042bc:	00007717          	auipc	a4,0x7
    800042c0:	59470713          	addi	a4,a4,1428 # 8000b850 <syscalls>
    800042c4:	fd442783          	lw	a5,-44(s0)
    800042c8:	078e                	slli	a5,a5,0x3
    800042ca:	97ba                	add	a5,a5,a4
    800042cc:	6398                	ld	a4,0(a5)
    800042ce:	fd843783          	ld	a5,-40(s0)
    800042d2:	6fa4                	ld	s1,88(a5)
    800042d4:	9702                	jalr	a4
    800042d6:	87aa                	mv	a5,a0
    800042d8:	f8bc                	sd	a5,112(s1)
    800042da:	a815                	j	8000430e <syscall+0x9e>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800042dc:	fd843783          	ld	a5,-40(s0)
    800042e0:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    800042e2:	fd843783          	ld	a5,-40(s0)
    800042e6:	15878793          	addi	a5,a5,344
    printf("%d %s: unknown sys call %d\n",
    800042ea:	fd442683          	lw	a3,-44(s0)
    800042ee:	863e                	mv	a2,a5
    800042f0:	85ba                	mv	a1,a4
    800042f2:	00007517          	auipc	a0,0x7
    800042f6:	11e50513          	addi	a0,a0,286 # 8000b410 <etext+0x410>
    800042fa:	ffffc097          	auipc	ra,0xffffc
    800042fe:	73c080e7          	jalr	1852(ra) # 80000a36 <printf>
    p->trapframe->a0 = -1;
    80004302:	fd843783          	ld	a5,-40(s0)
    80004306:	6fbc                	ld	a5,88(a5)
    80004308:	577d                	li	a4,-1
    8000430a:	fbb8                	sd	a4,112(a5)
  }
}
    8000430c:	0001                	nop
    8000430e:	0001                	nop
    80004310:	70a2                	ld	ra,40(sp)
    80004312:	7402                	ld	s0,32(sp)
    80004314:	64e2                	ld	s1,24(sp)
    80004316:	6145                	addi	sp,sp,48
    80004318:	8082                	ret

000000008000431a <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000431a:	1101                	addi	sp,sp,-32
    8000431c:	ec06                	sd	ra,24(sp)
    8000431e:	e822                	sd	s0,16(sp)
    80004320:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80004322:	fec40793          	addi	a5,s0,-20
    80004326:	85be                	mv	a1,a5
    80004328:	4501                	li	a0,0
    8000432a:	00000097          	auipc	ra,0x0
    8000432e:	e8c080e7          	jalr	-372(ra) # 800041b6 <argint>
  exit(n);
    80004332:	fec42783          	lw	a5,-20(s0)
    80004336:	853e                	mv	a0,a5
    80004338:	fffff097          	auipc	ra,0xfffff
    8000433c:	cd2080e7          	jalr	-814(ra) # 8000300a <exit>
  return 0;  // not reached
    80004340:	4781                	li	a5,0
}
    80004342:	853e                	mv	a0,a5
    80004344:	60e2                	ld	ra,24(sp)
    80004346:	6442                	ld	s0,16(sp)
    80004348:	6105                	addi	sp,sp,32
    8000434a:	8082                	ret

000000008000434c <sys_getpid>:

uint64
sys_getpid(void)
{
    8000434c:	1141                	addi	sp,sp,-16
    8000434e:	e406                	sd	ra,8(sp)
    80004350:	e022                	sd	s0,0(sp)
    80004352:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80004354:	ffffe097          	auipc	ra,0xffffe
    80004358:	5c4080e7          	jalr	1476(ra) # 80002918 <myproc>
    8000435c:	87aa                	mv	a5,a0
    8000435e:	5b9c                	lw	a5,48(a5)
}
    80004360:	853e                	mv	a0,a5
    80004362:	60a2                	ld	ra,8(sp)
    80004364:	6402                	ld	s0,0(sp)
    80004366:	0141                	addi	sp,sp,16
    80004368:	8082                	ret

000000008000436a <sys_fork>:

uint64
sys_fork(void)
{
    8000436a:	1141                	addi	sp,sp,-16
    8000436c:	e406                	sd	ra,8(sp)
    8000436e:	e022                	sd	s0,0(sp)
    80004370:	0800                	addi	s0,sp,16
  return fork();
    80004372:	fffff097          	auipc	ra,0xfffff
    80004376:	a76080e7          	jalr	-1418(ra) # 80002de8 <fork>
    8000437a:	87aa                	mv	a5,a0
}
    8000437c:	853e                	mv	a0,a5
    8000437e:	60a2                	ld	ra,8(sp)
    80004380:	6402                	ld	s0,0(sp)
    80004382:	0141                	addi	sp,sp,16
    80004384:	8082                	ret

0000000080004386 <sys_wait>:

uint64
sys_wait(void)
{
    80004386:	1101                	addi	sp,sp,-32
    80004388:	ec06                	sd	ra,24(sp)
    8000438a:	e822                	sd	s0,16(sp)
    8000438c:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    8000438e:	fe840793          	addi	a5,s0,-24
    80004392:	85be                	mv	a1,a5
    80004394:	4501                	li	a0,0
    80004396:	00000097          	auipc	ra,0x0
    8000439a:	e56080e7          	jalr	-426(ra) # 800041ec <argaddr>
  return wait(p);
    8000439e:	fe843783          	ld	a5,-24(s0)
    800043a2:	853e                	mv	a0,a5
    800043a4:	fffff097          	auipc	ra,0xfffff
    800043a8:	da2080e7          	jalr	-606(ra) # 80003146 <wait>
    800043ac:	87aa                	mv	a5,a0
}
    800043ae:	853e                	mv	a0,a5
    800043b0:	60e2                	ld	ra,24(sp)
    800043b2:	6442                	ld	s0,16(sp)
    800043b4:	6105                	addi	sp,sp,32
    800043b6:	8082                	ret

00000000800043b8 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800043b8:	1101                	addi	sp,sp,-32
    800043ba:	ec06                	sd	ra,24(sp)
    800043bc:	e822                	sd	s0,16(sp)
    800043be:	1000                	addi	s0,sp,32
  uint64 addr;
  int n;

  argint(0, &n);
    800043c0:	fe440793          	addi	a5,s0,-28
    800043c4:	85be                	mv	a1,a5
    800043c6:	4501                	li	a0,0
    800043c8:	00000097          	auipc	ra,0x0
    800043cc:	dee080e7          	jalr	-530(ra) # 800041b6 <argint>
  addr = myproc()->sz;
    800043d0:	ffffe097          	auipc	ra,0xffffe
    800043d4:	548080e7          	jalr	1352(ra) # 80002918 <myproc>
    800043d8:	87aa                	mv	a5,a0
    800043da:	67bc                	ld	a5,72(a5)
    800043dc:	fef43423          	sd	a5,-24(s0)
  if(growproc(n) < 0)
    800043e0:	fe442783          	lw	a5,-28(s0)
    800043e4:	853e                	mv	a0,a5
    800043e6:	fffff097          	auipc	ra,0xfffff
    800043ea:	962080e7          	jalr	-1694(ra) # 80002d48 <growproc>
    800043ee:	87aa                	mv	a5,a0
    800043f0:	0007d463          	bgez	a5,800043f8 <sys_sbrk+0x40>
    return -1;
    800043f4:	57fd                	li	a5,-1
    800043f6:	a019                	j	800043fc <sys_sbrk+0x44>
  return addr;
    800043f8:	fe843783          	ld	a5,-24(s0)
}
    800043fc:	853e                	mv	a0,a5
    800043fe:	60e2                	ld	ra,24(sp)
    80004400:	6442                	ld	s0,16(sp)
    80004402:	6105                	addi	sp,sp,32
    80004404:	8082                	ret

0000000080004406 <sys_sleep>:

uint64
sys_sleep(void)
{
    80004406:	1101                	addi	sp,sp,-32
    80004408:	ec06                	sd	ra,24(sp)
    8000440a:	e822                	sd	s0,16(sp)
    8000440c:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  argint(0, &n);
    8000440e:	fe840793          	addi	a5,s0,-24
    80004412:	85be                	mv	a1,a5
    80004414:	4501                	li	a0,0
    80004416:	00000097          	auipc	ra,0x0
    8000441a:	da0080e7          	jalr	-608(ra) # 800041b6 <argint>
  acquire(&tickslock);
    8000441e:	00015517          	auipc	a0,0x15
    80004422:	5ca50513          	addi	a0,a0,1482 # 800199e8 <tickslock>
    80004426:	ffffd097          	auipc	ra,0xffffd
    8000442a:	f04080e7          	jalr	-252(ra) # 8000132a <acquire>
  ticks0 = ticks;
    8000442e:	00007797          	auipc	a5,0x7
    80004432:	51a78793          	addi	a5,a5,1306 # 8000b948 <ticks>
    80004436:	439c                	lw	a5,0(a5)
    80004438:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    8000443c:	a099                	j	80004482 <sys_sleep+0x7c>
    if(killed(myproc())){
    8000443e:	ffffe097          	auipc	ra,0xffffe
    80004442:	4da080e7          	jalr	1242(ra) # 80002918 <myproc>
    80004446:	87aa                	mv	a5,a0
    80004448:	853e                	mv	a0,a5
    8000444a:	fffff097          	auipc	ra,0xfffff
    8000444e:	29e080e7          	jalr	670(ra) # 800036e8 <killed>
    80004452:	87aa                	mv	a5,a0
    80004454:	cb99                	beqz	a5,8000446a <sys_sleep+0x64>
      release(&tickslock);
    80004456:	00015517          	auipc	a0,0x15
    8000445a:	59250513          	addi	a0,a0,1426 # 800199e8 <tickslock>
    8000445e:	ffffd097          	auipc	ra,0xffffd
    80004462:	f30080e7          	jalr	-208(ra) # 8000138e <release>
      return -1;
    80004466:	57fd                	li	a5,-1
    80004468:	a0b1                	j	800044b4 <sys_sleep+0xae>
    }
    sleep(&ticks, &tickslock);
    8000446a:	00015597          	auipc	a1,0x15
    8000446e:	57e58593          	addi	a1,a1,1406 # 800199e8 <tickslock>
    80004472:	00007517          	auipc	a0,0x7
    80004476:	4d650513          	addi	a0,a0,1238 # 8000b948 <ticks>
    8000447a:	fffff097          	auipc	ra,0xfffff
    8000447e:	060080e7          	jalr	96(ra) # 800034da <sleep>
  while(ticks - ticks0 < n){
    80004482:	00007797          	auipc	a5,0x7
    80004486:	4c678793          	addi	a5,a5,1222 # 8000b948 <ticks>
    8000448a:	4398                	lw	a4,0(a5)
    8000448c:	fec42783          	lw	a5,-20(s0)
    80004490:	40f707bb          	subw	a5,a4,a5
    80004494:	0007871b          	sext.w	a4,a5
    80004498:	fe842783          	lw	a5,-24(s0)
    8000449c:	2781                	sext.w	a5,a5
    8000449e:	faf760e3          	bltu	a4,a5,8000443e <sys_sleep+0x38>
  }
  release(&tickslock);
    800044a2:	00015517          	auipc	a0,0x15
    800044a6:	54650513          	addi	a0,a0,1350 # 800199e8 <tickslock>
    800044aa:	ffffd097          	auipc	ra,0xffffd
    800044ae:	ee4080e7          	jalr	-284(ra) # 8000138e <release>
  return 0;
    800044b2:	4781                	li	a5,0
}
    800044b4:	853e                	mv	a0,a5
    800044b6:	60e2                	ld	ra,24(sp)
    800044b8:	6442                	ld	s0,16(sp)
    800044ba:	6105                	addi	sp,sp,32
    800044bc:	8082                	ret

00000000800044be <sys_kill>:

uint64
sys_kill(void)
{
    800044be:	1101                	addi	sp,sp,-32
    800044c0:	ec06                	sd	ra,24(sp)
    800044c2:	e822                	sd	s0,16(sp)
    800044c4:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    800044c6:	fec40793          	addi	a5,s0,-20
    800044ca:	85be                	mv	a1,a5
    800044cc:	4501                	li	a0,0
    800044ce:	00000097          	auipc	ra,0x0
    800044d2:	ce8080e7          	jalr	-792(ra) # 800041b6 <argint>
  return kill(pid);
    800044d6:	fec42783          	lw	a5,-20(s0)
    800044da:	853e                	mv	a0,a5
    800044dc:	fffff097          	auipc	ra,0xfffff
    800044e0:	132080e7          	jalr	306(ra) # 8000360e <kill>
    800044e4:	87aa                	mv	a5,a0
}
    800044e6:	853e                	mv	a0,a5
    800044e8:	60e2                	ld	ra,24(sp)
    800044ea:	6442                	ld	s0,16(sp)
    800044ec:	6105                	addi	sp,sp,32
    800044ee:	8082                	ret

00000000800044f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800044f0:	1101                	addi	sp,sp,-32
    800044f2:	ec06                	sd	ra,24(sp)
    800044f4:	e822                	sd	s0,16(sp)
    800044f6:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800044f8:	00015517          	auipc	a0,0x15
    800044fc:	4f050513          	addi	a0,a0,1264 # 800199e8 <tickslock>
    80004500:	ffffd097          	auipc	ra,0xffffd
    80004504:	e2a080e7          	jalr	-470(ra) # 8000132a <acquire>
  xticks = ticks;
    80004508:	00007797          	auipc	a5,0x7
    8000450c:	44078793          	addi	a5,a5,1088 # 8000b948 <ticks>
    80004510:	439c                	lw	a5,0(a5)
    80004512:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    80004516:	00015517          	auipc	a0,0x15
    8000451a:	4d250513          	addi	a0,a0,1234 # 800199e8 <tickslock>
    8000451e:	ffffd097          	auipc	ra,0xffffd
    80004522:	e70080e7          	jalr	-400(ra) # 8000138e <release>
  return xticks;
    80004526:	fec46783          	lwu	a5,-20(s0)
}
    8000452a:	853e                	mv	a0,a5
    8000452c:	60e2                	ld	ra,24(sp)
    8000452e:	6442                	ld	s0,16(sp)
    80004530:	6105                	addi	sp,sp,32
    80004532:	8082                	ret

0000000080004534 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004534:	1101                	addi	sp,sp,-32
    80004536:	ec06                	sd	ra,24(sp)
    80004538:	e822                	sd	s0,16(sp)
    8000453a:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000453c:	00007597          	auipc	a1,0x7
    80004540:	ef458593          	addi	a1,a1,-268 # 8000b430 <etext+0x430>
    80004544:	00015517          	auipc	a0,0x15
    80004548:	4bc50513          	addi	a0,a0,1212 # 80019a00 <bcache>
    8000454c:	ffffd097          	auipc	ra,0xffffd
    80004550:	dae080e7          	jalr	-594(ra) # 800012fa <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80004554:	00015717          	auipc	a4,0x15
    80004558:	4ac70713          	addi	a4,a4,1196 # 80019a00 <bcache>
    8000455c:	67a1                	lui	a5,0x8
    8000455e:	97ba                	add	a5,a5,a4
    80004560:	0001d717          	auipc	a4,0x1d
    80004564:	70870713          	addi	a4,a4,1800 # 80021c68 <bcache+0x8268>
    80004568:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    8000456c:	00015717          	auipc	a4,0x15
    80004570:	49470713          	addi	a4,a4,1172 # 80019a00 <bcache>
    80004574:	67a1                	lui	a5,0x8
    80004576:	97ba                	add	a5,a5,a4
    80004578:	0001d717          	auipc	a4,0x1d
    8000457c:	6f070713          	addi	a4,a4,1776 # 80021c68 <bcache+0x8268>
    80004580:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80004584:	00015797          	auipc	a5,0x15
    80004588:	49478793          	addi	a5,a5,1172 # 80019a18 <bcache+0x18>
    8000458c:	fef43423          	sd	a5,-24(s0)
    80004590:	a895                	j	80004604 <binit+0xd0>
    b->next = bcache.head.next;
    80004592:	00015717          	auipc	a4,0x15
    80004596:	46e70713          	addi	a4,a4,1134 # 80019a00 <bcache>
    8000459a:	67a1                	lui	a5,0x8
    8000459c:	97ba                	add	a5,a5,a4
    8000459e:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800045a2:	fe843783          	ld	a5,-24(s0)
    800045a6:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800045a8:	fe843783          	ld	a5,-24(s0)
    800045ac:	0001d717          	auipc	a4,0x1d
    800045b0:	6bc70713          	addi	a4,a4,1724 # 80021c68 <bcache+0x8268>
    800045b4:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    800045b6:	fe843783          	ld	a5,-24(s0)
    800045ba:	07c1                	addi	a5,a5,16
    800045bc:	00007597          	auipc	a1,0x7
    800045c0:	e7c58593          	addi	a1,a1,-388 # 8000b438 <etext+0x438>
    800045c4:	853e                	mv	a0,a5
    800045c6:	00002097          	auipc	ra,0x2
    800045ca:	034080e7          	jalr	52(ra) # 800065fa <initsleeplock>
    bcache.head.next->prev = b;
    800045ce:	00015717          	auipc	a4,0x15
    800045d2:	43270713          	addi	a4,a4,1074 # 80019a00 <bcache>
    800045d6:	67a1                	lui	a5,0x8
    800045d8:	97ba                	add	a5,a5,a4
    800045da:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800045de:	fe843703          	ld	a4,-24(s0)
    800045e2:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800045e4:	00015717          	auipc	a4,0x15
    800045e8:	41c70713          	addi	a4,a4,1052 # 80019a00 <bcache>
    800045ec:	67a1                	lui	a5,0x8
    800045ee:	97ba                	add	a5,a5,a4
    800045f0:	fe843703          	ld	a4,-24(s0)
    800045f4:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800045f8:	fe843783          	ld	a5,-24(s0)
    800045fc:	45878793          	addi	a5,a5,1112
    80004600:	fef43423          	sd	a5,-24(s0)
    80004604:	0001d797          	auipc	a5,0x1d
    80004608:	66478793          	addi	a5,a5,1636 # 80021c68 <bcache+0x8268>
    8000460c:	fe843703          	ld	a4,-24(s0)
    80004610:	f8f761e3          	bltu	a4,a5,80004592 <binit+0x5e>
  }
}
    80004614:	0001                	nop
    80004616:	0001                	nop
    80004618:	60e2                	ld	ra,24(sp)
    8000461a:	6442                	ld	s0,16(sp)
    8000461c:	6105                	addi	sp,sp,32
    8000461e:	8082                	ret

0000000080004620 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80004620:	7179                	addi	sp,sp,-48
    80004622:	f406                	sd	ra,40(sp)
    80004624:	f022                	sd	s0,32(sp)
    80004626:	1800                	addi	s0,sp,48
    80004628:	87aa                	mv	a5,a0
    8000462a:	872e                	mv	a4,a1
    8000462c:	fcf42e23          	sw	a5,-36(s0)
    80004630:	87ba                	mv	a5,a4
    80004632:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    80004636:	00015517          	auipc	a0,0x15
    8000463a:	3ca50513          	addi	a0,a0,970 # 80019a00 <bcache>
    8000463e:	ffffd097          	auipc	ra,0xffffd
    80004642:	cec080e7          	jalr	-788(ra) # 8000132a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004646:	00015717          	auipc	a4,0x15
    8000464a:	3ba70713          	addi	a4,a4,954 # 80019a00 <bcache>
    8000464e:	67a1                	lui	a5,0x8
    80004650:	97ba                	add	a5,a5,a4
    80004652:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004656:	fef43423          	sd	a5,-24(s0)
    8000465a:	a095                	j	800046be <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    8000465c:	fe843783          	ld	a5,-24(s0)
    80004660:	4798                	lw	a4,8(a5)
    80004662:	fdc42783          	lw	a5,-36(s0)
    80004666:	2781                	sext.w	a5,a5
    80004668:	04e79663          	bne	a5,a4,800046b4 <bget+0x94>
    8000466c:	fe843783          	ld	a5,-24(s0)
    80004670:	47d8                	lw	a4,12(a5)
    80004672:	fd842783          	lw	a5,-40(s0)
    80004676:	2781                	sext.w	a5,a5
    80004678:	02e79e63          	bne	a5,a4,800046b4 <bget+0x94>
      b->refcnt++;
    8000467c:	fe843783          	ld	a5,-24(s0)
    80004680:	43bc                	lw	a5,64(a5)
    80004682:	2785                	addiw	a5,a5,1
    80004684:	0007871b          	sext.w	a4,a5
    80004688:	fe843783          	ld	a5,-24(s0)
    8000468c:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    8000468e:	00015517          	auipc	a0,0x15
    80004692:	37250513          	addi	a0,a0,882 # 80019a00 <bcache>
    80004696:	ffffd097          	auipc	ra,0xffffd
    8000469a:	cf8080e7          	jalr	-776(ra) # 8000138e <release>
      acquiresleep(&b->lock);
    8000469e:	fe843783          	ld	a5,-24(s0)
    800046a2:	07c1                	addi	a5,a5,16
    800046a4:	853e                	mv	a0,a5
    800046a6:	00002097          	auipc	ra,0x2
    800046aa:	fa0080e7          	jalr	-96(ra) # 80006646 <acquiresleep>
      return b;
    800046ae:	fe843783          	ld	a5,-24(s0)
    800046b2:	a07d                	j	80004760 <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800046b4:	fe843783          	ld	a5,-24(s0)
    800046b8:	6bbc                	ld	a5,80(a5)
    800046ba:	fef43423          	sd	a5,-24(s0)
    800046be:	fe843703          	ld	a4,-24(s0)
    800046c2:	0001d797          	auipc	a5,0x1d
    800046c6:	5a678793          	addi	a5,a5,1446 # 80021c68 <bcache+0x8268>
    800046ca:	f8f719e3          	bne	a4,a5,8000465c <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800046ce:	00015717          	auipc	a4,0x15
    800046d2:	33270713          	addi	a4,a4,818 # 80019a00 <bcache>
    800046d6:	67a1                	lui	a5,0x8
    800046d8:	97ba                	add	a5,a5,a4
    800046da:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800046de:	fef43423          	sd	a5,-24(s0)
    800046e2:	a8b9                	j	80004740 <bget+0x120>
    if(b->refcnt == 0) {
    800046e4:	fe843783          	ld	a5,-24(s0)
    800046e8:	43bc                	lw	a5,64(a5)
    800046ea:	e7b1                	bnez	a5,80004736 <bget+0x116>
      b->dev = dev;
    800046ec:	fe843783          	ld	a5,-24(s0)
    800046f0:	fdc42703          	lw	a4,-36(s0)
    800046f4:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    800046f6:	fe843783          	ld	a5,-24(s0)
    800046fa:	fd842703          	lw	a4,-40(s0)
    800046fe:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    80004700:	fe843783          	ld	a5,-24(s0)
    80004704:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    80004708:	fe843783          	ld	a5,-24(s0)
    8000470c:	4705                	li	a4,1
    8000470e:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80004710:	00015517          	auipc	a0,0x15
    80004714:	2f050513          	addi	a0,a0,752 # 80019a00 <bcache>
    80004718:	ffffd097          	auipc	ra,0xffffd
    8000471c:	c76080e7          	jalr	-906(ra) # 8000138e <release>
      acquiresleep(&b->lock);
    80004720:	fe843783          	ld	a5,-24(s0)
    80004724:	07c1                	addi	a5,a5,16
    80004726:	853e                	mv	a0,a5
    80004728:	00002097          	auipc	ra,0x2
    8000472c:	f1e080e7          	jalr	-226(ra) # 80006646 <acquiresleep>
      return b;
    80004730:	fe843783          	ld	a5,-24(s0)
    80004734:	a035                	j	80004760 <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004736:	fe843783          	ld	a5,-24(s0)
    8000473a:	67bc                	ld	a5,72(a5)
    8000473c:	fef43423          	sd	a5,-24(s0)
    80004740:	fe843703          	ld	a4,-24(s0)
    80004744:	0001d797          	auipc	a5,0x1d
    80004748:	52478793          	addi	a5,a5,1316 # 80021c68 <bcache+0x8268>
    8000474c:	f8f71ce3          	bne	a4,a5,800046e4 <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80004750:	00007517          	auipc	a0,0x7
    80004754:	cf050513          	addi	a0,a0,-784 # 8000b440 <etext+0x440>
    80004758:	ffffc097          	auipc	ra,0xffffc
    8000475c:	534080e7          	jalr	1332(ra) # 80000c8c <panic>
}
    80004760:	853e                	mv	a0,a5
    80004762:	70a2                	ld	ra,40(sp)
    80004764:	7402                	ld	s0,32(sp)
    80004766:	6145                	addi	sp,sp,48
    80004768:	8082                	ret

000000008000476a <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000476a:	7179                	addi	sp,sp,-48
    8000476c:	f406                	sd	ra,40(sp)
    8000476e:	f022                	sd	s0,32(sp)
    80004770:	1800                	addi	s0,sp,48
    80004772:	87aa                	mv	a5,a0
    80004774:	872e                	mv	a4,a1
    80004776:	fcf42e23          	sw	a5,-36(s0)
    8000477a:	87ba                	mv	a5,a4
    8000477c:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    80004780:	fd842703          	lw	a4,-40(s0)
    80004784:	fdc42783          	lw	a5,-36(s0)
    80004788:	85ba                	mv	a1,a4
    8000478a:	853e                	mv	a0,a5
    8000478c:	00000097          	auipc	ra,0x0
    80004790:	e94080e7          	jalr	-364(ra) # 80004620 <bget>
    80004794:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    80004798:	fe843783          	ld	a5,-24(s0)
    8000479c:	439c                	lw	a5,0(a5)
    8000479e:	ef91                	bnez	a5,800047ba <bread+0x50>
    virtio_disk_rw(VIRTIO0_ID, b, 0, 0);
    800047a0:	4681                	li	a3,0
    800047a2:	4601                	li	a2,0
    800047a4:	fe843583          	ld	a1,-24(s0)
    800047a8:	4501                	li	a0,0
    800047aa:	00005097          	auipc	ra,0x5
    800047ae:	d18080e7          	jalr	-744(ra) # 800094c2 <virtio_disk_rw>
    b->valid = 1;
    800047b2:	fe843783          	ld	a5,-24(s0)
    800047b6:	4705                	li	a4,1
    800047b8:	c398                	sw	a4,0(a5)
  }
  return b;
    800047ba:	fe843783          	ld	a5,-24(s0)
}
    800047be:	853e                	mv	a0,a5
    800047c0:	70a2                	ld	ra,40(sp)
    800047c2:	7402                	ld	s0,32(sp)
    800047c4:	6145                	addi	sp,sp,48
    800047c6:	8082                	ret

00000000800047c8 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800047c8:	1101                	addi	sp,sp,-32
    800047ca:	ec06                	sd	ra,24(sp)
    800047cc:	e822                	sd	s0,16(sp)
    800047ce:	1000                	addi	s0,sp,32
    800047d0:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800047d4:	fe843783          	ld	a5,-24(s0)
    800047d8:	07c1                	addi	a5,a5,16
    800047da:	853e                	mv	a0,a5
    800047dc:	00002097          	auipc	ra,0x2
    800047e0:	f2a080e7          	jalr	-214(ra) # 80006706 <holdingsleep>
    800047e4:	87aa                	mv	a5,a0
    800047e6:	eb89                	bnez	a5,800047f8 <bwrite+0x30>
    panic("bwrite");
    800047e8:	00007517          	auipc	a0,0x7
    800047ec:	c7050513          	addi	a0,a0,-912 # 8000b458 <etext+0x458>
    800047f0:	ffffc097          	auipc	ra,0xffffc
    800047f4:	49c080e7          	jalr	1180(ra) # 80000c8c <panic>
  virtio_disk_rw(VIRTIO0_ID, b, 1, 0);
    800047f8:	4681                	li	a3,0
    800047fa:	4605                	li	a2,1
    800047fc:	fe843583          	ld	a1,-24(s0)
    80004800:	4501                	li	a0,0
    80004802:	00005097          	auipc	ra,0x5
    80004806:	cc0080e7          	jalr	-832(ra) # 800094c2 <virtio_disk_rw>
}
    8000480a:	0001                	nop
    8000480c:	60e2                	ld	ra,24(sp)
    8000480e:	6442                	ld	s0,16(sp)
    80004810:	6105                	addi	sp,sp,32
    80004812:	8082                	ret

0000000080004814 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80004814:	1101                	addi	sp,sp,-32
    80004816:	ec06                	sd	ra,24(sp)
    80004818:	e822                	sd	s0,16(sp)
    8000481a:	1000                	addi	s0,sp,32
    8000481c:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004820:	fe843783          	ld	a5,-24(s0)
    80004824:	07c1                	addi	a5,a5,16
    80004826:	853e                	mv	a0,a5
    80004828:	00002097          	auipc	ra,0x2
    8000482c:	ede080e7          	jalr	-290(ra) # 80006706 <holdingsleep>
    80004830:	87aa                	mv	a5,a0
    80004832:	eb89                	bnez	a5,80004844 <brelse+0x30>
    panic("brelse");
    80004834:	00007517          	auipc	a0,0x7
    80004838:	c2c50513          	addi	a0,a0,-980 # 8000b460 <etext+0x460>
    8000483c:	ffffc097          	auipc	ra,0xffffc
    80004840:	450080e7          	jalr	1104(ra) # 80000c8c <panic>

  releasesleep(&b->lock);
    80004844:	fe843783          	ld	a5,-24(s0)
    80004848:	07c1                	addi	a5,a5,16
    8000484a:	853e                	mv	a0,a5
    8000484c:	00002097          	auipc	ra,0x2
    80004850:	e68080e7          	jalr	-408(ra) # 800066b4 <releasesleep>

  acquire(&bcache.lock);
    80004854:	00015517          	auipc	a0,0x15
    80004858:	1ac50513          	addi	a0,a0,428 # 80019a00 <bcache>
    8000485c:	ffffd097          	auipc	ra,0xffffd
    80004860:	ace080e7          	jalr	-1330(ra) # 8000132a <acquire>
  b->refcnt--;
    80004864:	fe843783          	ld	a5,-24(s0)
    80004868:	43bc                	lw	a5,64(a5)
    8000486a:	37fd                	addiw	a5,a5,-1
    8000486c:	0007871b          	sext.w	a4,a5
    80004870:	fe843783          	ld	a5,-24(s0)
    80004874:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80004876:	fe843783          	ld	a5,-24(s0)
    8000487a:	43bc                	lw	a5,64(a5)
    8000487c:	e7b5                	bnez	a5,800048e8 <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000487e:	fe843783          	ld	a5,-24(s0)
    80004882:	6bbc                	ld	a5,80(a5)
    80004884:	fe843703          	ld	a4,-24(s0)
    80004888:	6738                	ld	a4,72(a4)
    8000488a:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000488c:	fe843783          	ld	a5,-24(s0)
    80004890:	67bc                	ld	a5,72(a5)
    80004892:	fe843703          	ld	a4,-24(s0)
    80004896:	6b38                	ld	a4,80(a4)
    80004898:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000489a:	00015717          	auipc	a4,0x15
    8000489e:	16670713          	addi	a4,a4,358 # 80019a00 <bcache>
    800048a2:	67a1                	lui	a5,0x8
    800048a4:	97ba                	add	a5,a5,a4
    800048a6:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800048aa:	fe843783          	ld	a5,-24(s0)
    800048ae:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800048b0:	fe843783          	ld	a5,-24(s0)
    800048b4:	0001d717          	auipc	a4,0x1d
    800048b8:	3b470713          	addi	a4,a4,948 # 80021c68 <bcache+0x8268>
    800048bc:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    800048be:	00015717          	auipc	a4,0x15
    800048c2:	14270713          	addi	a4,a4,322 # 80019a00 <bcache>
    800048c6:	67a1                	lui	a5,0x8
    800048c8:	97ba                	add	a5,a5,a4
    800048ca:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800048ce:	fe843703          	ld	a4,-24(s0)
    800048d2:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800048d4:	00015717          	auipc	a4,0x15
    800048d8:	12c70713          	addi	a4,a4,300 # 80019a00 <bcache>
    800048dc:	67a1                	lui	a5,0x8
    800048de:	97ba                	add	a5,a5,a4
    800048e0:	fe843703          	ld	a4,-24(s0)
    800048e4:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    800048e8:	00015517          	auipc	a0,0x15
    800048ec:	11850513          	addi	a0,a0,280 # 80019a00 <bcache>
    800048f0:	ffffd097          	auipc	ra,0xffffd
    800048f4:	a9e080e7          	jalr	-1378(ra) # 8000138e <release>
}
    800048f8:	0001                	nop
    800048fa:	60e2                	ld	ra,24(sp)
    800048fc:	6442                	ld	s0,16(sp)
    800048fe:	6105                	addi	sp,sp,32
    80004900:	8082                	ret

0000000080004902 <bpin>:

void
bpin(struct buf *b) {
    80004902:	1101                	addi	sp,sp,-32
    80004904:	ec06                	sd	ra,24(sp)
    80004906:	e822                	sd	s0,16(sp)
    80004908:	1000                	addi	s0,sp,32
    8000490a:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    8000490e:	00015517          	auipc	a0,0x15
    80004912:	0f250513          	addi	a0,a0,242 # 80019a00 <bcache>
    80004916:	ffffd097          	auipc	ra,0xffffd
    8000491a:	a14080e7          	jalr	-1516(ra) # 8000132a <acquire>
  b->refcnt++;
    8000491e:	fe843783          	ld	a5,-24(s0)
    80004922:	43bc                	lw	a5,64(a5)
    80004924:	2785                	addiw	a5,a5,1
    80004926:	0007871b          	sext.w	a4,a5
    8000492a:	fe843783          	ld	a5,-24(s0)
    8000492e:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004930:	00015517          	auipc	a0,0x15
    80004934:	0d050513          	addi	a0,a0,208 # 80019a00 <bcache>
    80004938:	ffffd097          	auipc	ra,0xffffd
    8000493c:	a56080e7          	jalr	-1450(ra) # 8000138e <release>
}
    80004940:	0001                	nop
    80004942:	60e2                	ld	ra,24(sp)
    80004944:	6442                	ld	s0,16(sp)
    80004946:	6105                	addi	sp,sp,32
    80004948:	8082                	ret

000000008000494a <bunpin>:

void
bunpin(struct buf *b) {
    8000494a:	1101                	addi	sp,sp,-32
    8000494c:	ec06                	sd	ra,24(sp)
    8000494e:	e822                	sd	s0,16(sp)
    80004950:	1000                	addi	s0,sp,32
    80004952:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004956:	00015517          	auipc	a0,0x15
    8000495a:	0aa50513          	addi	a0,a0,170 # 80019a00 <bcache>
    8000495e:	ffffd097          	auipc	ra,0xffffd
    80004962:	9cc080e7          	jalr	-1588(ra) # 8000132a <acquire>
  b->refcnt--;
    80004966:	fe843783          	ld	a5,-24(s0)
    8000496a:	43bc                	lw	a5,64(a5)
    8000496c:	37fd                	addiw	a5,a5,-1
    8000496e:	0007871b          	sext.w	a4,a5
    80004972:	fe843783          	ld	a5,-24(s0)
    80004976:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004978:	00015517          	auipc	a0,0x15
    8000497c:	08850513          	addi	a0,a0,136 # 80019a00 <bcache>
    80004980:	ffffd097          	auipc	ra,0xffffd
    80004984:	a0e080e7          	jalr	-1522(ra) # 8000138e <release>
}
    80004988:	0001                	nop
    8000498a:	60e2                	ld	ra,24(sp)
    8000498c:	6442                	ld	s0,16(sp)
    8000498e:	6105                	addi	sp,sp,32
    80004990:	8082                	ret

0000000080004992 <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80004992:	7179                	addi	sp,sp,-48
    80004994:	f406                	sd	ra,40(sp)
    80004996:	f022                	sd	s0,32(sp)
    80004998:	1800                	addi	s0,sp,48
    8000499a:	87aa                	mv	a5,a0
    8000499c:	fcb43823          	sd	a1,-48(s0)
    800049a0:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    800049a4:	fdc42783          	lw	a5,-36(s0)
    800049a8:	4585                	li	a1,1
    800049aa:	853e                	mv	a0,a5
    800049ac:	00000097          	auipc	ra,0x0
    800049b0:	dbe080e7          	jalr	-578(ra) # 8000476a <bread>
    800049b4:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    800049b8:	fe843783          	ld	a5,-24(s0)
    800049bc:	05878793          	addi	a5,a5,88
    800049c0:	02000613          	li	a2,32
    800049c4:	85be                	mv	a1,a5
    800049c6:	fd043503          	ld	a0,-48(s0)
    800049ca:	ffffd097          	auipc	ra,0xffffd
    800049ce:	c18080e7          	jalr	-1000(ra) # 800015e2 <memmove>
  brelse(bp);
    800049d2:	fe843503          	ld	a0,-24(s0)
    800049d6:	00000097          	auipc	ra,0x0
    800049da:	e3e080e7          	jalr	-450(ra) # 80004814 <brelse>
}
    800049de:	0001                	nop
    800049e0:	70a2                	ld	ra,40(sp)
    800049e2:	7402                	ld	s0,32(sp)
    800049e4:	6145                	addi	sp,sp,48
    800049e6:	8082                	ret

00000000800049e8 <fsinit>:

// Init fs
void
fsinit(int dev) {
    800049e8:	1101                	addi	sp,sp,-32
    800049ea:	ec06                	sd	ra,24(sp)
    800049ec:	e822                	sd	s0,16(sp)
    800049ee:	1000                	addi	s0,sp,32
    800049f0:	87aa                	mv	a5,a0
    800049f2:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    800049f6:	fec42783          	lw	a5,-20(s0)
    800049fa:	0001d597          	auipc	a1,0x1d
    800049fe:	6c658593          	addi	a1,a1,1734 # 800220c0 <sb>
    80004a02:	853e                	mv	a0,a5
    80004a04:	00000097          	auipc	ra,0x0
    80004a08:	f8e080e7          	jalr	-114(ra) # 80004992 <readsb>
  if(sb.magic != FSMAGIC)
    80004a0c:	0001d797          	auipc	a5,0x1d
    80004a10:	6b478793          	addi	a5,a5,1716 # 800220c0 <sb>
    80004a14:	439c                	lw	a5,0(a5)
    80004a16:	873e                	mv	a4,a5
    80004a18:	102037b7          	lui	a5,0x10203
    80004a1c:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80004a20:	00f70a63          	beq	a4,a5,80004a34 <fsinit+0x4c>
    panic("invalid file system");
    80004a24:	00007517          	auipc	a0,0x7
    80004a28:	a4450513          	addi	a0,a0,-1468 # 8000b468 <etext+0x468>
    80004a2c:	ffffc097          	auipc	ra,0xffffc
    80004a30:	260080e7          	jalr	608(ra) # 80000c8c <panic>
  initlog(dev, &sb);
    80004a34:	fec42783          	lw	a5,-20(s0)
    80004a38:	0001d597          	auipc	a1,0x1d
    80004a3c:	68858593          	addi	a1,a1,1672 # 800220c0 <sb>
    80004a40:	853e                	mv	a0,a5
    80004a42:	00001097          	auipc	ra,0x1
    80004a46:	49c080e7          	jalr	1180(ra) # 80005ede <initlog>
}
    80004a4a:	0001                	nop
    80004a4c:	60e2                	ld	ra,24(sp)
    80004a4e:	6442                	ld	s0,16(sp)
    80004a50:	6105                	addi	sp,sp,32
    80004a52:	8082                	ret

0000000080004a54 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80004a54:	7179                	addi	sp,sp,-48
    80004a56:	f406                	sd	ra,40(sp)
    80004a58:	f022                	sd	s0,32(sp)
    80004a5a:	1800                	addi	s0,sp,48
    80004a5c:	87aa                	mv	a5,a0
    80004a5e:	872e                	mv	a4,a1
    80004a60:	fcf42e23          	sw	a5,-36(s0)
    80004a64:	87ba                	mv	a5,a4
    80004a66:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80004a6a:	fdc42783          	lw	a5,-36(s0)
    80004a6e:	fd842703          	lw	a4,-40(s0)
    80004a72:	85ba                	mv	a1,a4
    80004a74:	853e                	mv	a0,a5
    80004a76:	00000097          	auipc	ra,0x0
    80004a7a:	cf4080e7          	jalr	-780(ra) # 8000476a <bread>
    80004a7e:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    80004a82:	fe843783          	ld	a5,-24(s0)
    80004a86:	05878793          	addi	a5,a5,88
    80004a8a:	40000613          	li	a2,1024
    80004a8e:	4581                	li	a1,0
    80004a90:	853e                	mv	a0,a5
    80004a92:	ffffd097          	auipc	ra,0xffffd
    80004a96:	a6c080e7          	jalr	-1428(ra) # 800014fe <memset>
  log_write(bp);
    80004a9a:	fe843503          	ld	a0,-24(s0)
    80004a9e:	00002097          	auipc	ra,0x2
    80004aa2:	a28080e7          	jalr	-1496(ra) # 800064c6 <log_write>
  brelse(bp);
    80004aa6:	fe843503          	ld	a0,-24(s0)
    80004aaa:	00000097          	auipc	ra,0x0
    80004aae:	d6a080e7          	jalr	-662(ra) # 80004814 <brelse>
}
    80004ab2:	0001                	nop
    80004ab4:	70a2                	ld	ra,40(sp)
    80004ab6:	7402                	ld	s0,32(sp)
    80004ab8:	6145                	addi	sp,sp,48
    80004aba:	8082                	ret

0000000080004abc <balloc>:

// Allocate a zeroed disk block.
// returns 0 if out of disk space.
static uint
balloc(uint dev)
{
    80004abc:	7139                	addi	sp,sp,-64
    80004abe:	fc06                	sd	ra,56(sp)
    80004ac0:	f822                	sd	s0,48(sp)
    80004ac2:	0080                	addi	s0,sp,64
    80004ac4:	87aa                	mv	a5,a0
    80004ac6:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80004aca:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    80004ace:	fe042623          	sw	zero,-20(s0)
    80004ad2:	a2b5                	j	80004c3e <balloc+0x182>
    bp = bread(dev, BBLOCK(b, sb));
    80004ad4:	fec42783          	lw	a5,-20(s0)
    80004ad8:	41f7d71b          	sraiw	a4,a5,0x1f
    80004adc:	0137571b          	srliw	a4,a4,0x13
    80004ae0:	9fb9                	addw	a5,a5,a4
    80004ae2:	40d7d79b          	sraiw	a5,a5,0xd
    80004ae6:	2781                	sext.w	a5,a5
    80004ae8:	0007871b          	sext.w	a4,a5
    80004aec:	0001d797          	auipc	a5,0x1d
    80004af0:	5d478793          	addi	a5,a5,1492 # 800220c0 <sb>
    80004af4:	4fdc                	lw	a5,28(a5)
    80004af6:	9fb9                	addw	a5,a5,a4
    80004af8:	0007871b          	sext.w	a4,a5
    80004afc:	fcc42783          	lw	a5,-52(s0)
    80004b00:	85ba                	mv	a1,a4
    80004b02:	853e                	mv	a0,a5
    80004b04:	00000097          	auipc	ra,0x0
    80004b08:	c66080e7          	jalr	-922(ra) # 8000476a <bread>
    80004b0c:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004b10:	fe042423          	sw	zero,-24(s0)
    80004b14:	a0dd                	j	80004bfa <balloc+0x13e>
      m = 1 << (bi % 8);
    80004b16:	fe842703          	lw	a4,-24(s0)
    80004b1a:	41f7579b          	sraiw	a5,a4,0x1f
    80004b1e:	01d7d79b          	srliw	a5,a5,0x1d
    80004b22:	9f3d                	addw	a4,a4,a5
    80004b24:	8b1d                	andi	a4,a4,7
    80004b26:	40f707bb          	subw	a5,a4,a5
    80004b2a:	2781                	sext.w	a5,a5
    80004b2c:	4705                	li	a4,1
    80004b2e:	00f717bb          	sllw	a5,a4,a5
    80004b32:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80004b36:	fe842783          	lw	a5,-24(s0)
    80004b3a:	41f7d71b          	sraiw	a4,a5,0x1f
    80004b3e:	01d7571b          	srliw	a4,a4,0x1d
    80004b42:	9fb9                	addw	a5,a5,a4
    80004b44:	4037d79b          	sraiw	a5,a5,0x3
    80004b48:	2781                	sext.w	a5,a5
    80004b4a:	fe043703          	ld	a4,-32(s0)
    80004b4e:	97ba                	add	a5,a5,a4
    80004b50:	0587c783          	lbu	a5,88(a5)
    80004b54:	0007871b          	sext.w	a4,a5
    80004b58:	fdc42783          	lw	a5,-36(s0)
    80004b5c:	8ff9                	and	a5,a5,a4
    80004b5e:	2781                	sext.w	a5,a5
    80004b60:	ebc1                	bnez	a5,80004bf0 <balloc+0x134>
        bp->data[bi/8] |= m;  // Mark block in use.
    80004b62:	fe842783          	lw	a5,-24(s0)
    80004b66:	41f7d71b          	sraiw	a4,a5,0x1f
    80004b6a:	01d7571b          	srliw	a4,a4,0x1d
    80004b6e:	9fb9                	addw	a5,a5,a4
    80004b70:	4037d79b          	sraiw	a5,a5,0x3
    80004b74:	2781                	sext.w	a5,a5
    80004b76:	fe043703          	ld	a4,-32(s0)
    80004b7a:	973e                	add	a4,a4,a5
    80004b7c:	05874703          	lbu	a4,88(a4)
    80004b80:	0187169b          	slliw	a3,a4,0x18
    80004b84:	4186d69b          	sraiw	a3,a3,0x18
    80004b88:	fdc42703          	lw	a4,-36(s0)
    80004b8c:	0187171b          	slliw	a4,a4,0x18
    80004b90:	4187571b          	sraiw	a4,a4,0x18
    80004b94:	8f55                	or	a4,a4,a3
    80004b96:	0187171b          	slliw	a4,a4,0x18
    80004b9a:	4187571b          	sraiw	a4,a4,0x18
    80004b9e:	0ff77713          	andi	a4,a4,255
    80004ba2:	fe043683          	ld	a3,-32(s0)
    80004ba6:	97b6                	add	a5,a5,a3
    80004ba8:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    80004bac:	fe043503          	ld	a0,-32(s0)
    80004bb0:	00002097          	auipc	ra,0x2
    80004bb4:	916080e7          	jalr	-1770(ra) # 800064c6 <log_write>
        brelse(bp);
    80004bb8:	fe043503          	ld	a0,-32(s0)
    80004bbc:	00000097          	auipc	ra,0x0
    80004bc0:	c58080e7          	jalr	-936(ra) # 80004814 <brelse>
        bzero(dev, b + bi);
    80004bc4:	fcc42683          	lw	a3,-52(s0)
    80004bc8:	fec42703          	lw	a4,-20(s0)
    80004bcc:	fe842783          	lw	a5,-24(s0)
    80004bd0:	9fb9                	addw	a5,a5,a4
    80004bd2:	2781                	sext.w	a5,a5
    80004bd4:	85be                	mv	a1,a5
    80004bd6:	8536                	mv	a0,a3
    80004bd8:	00000097          	auipc	ra,0x0
    80004bdc:	e7c080e7          	jalr	-388(ra) # 80004a54 <bzero>
        return b + bi;
    80004be0:	fec42703          	lw	a4,-20(s0)
    80004be4:	fe842783          	lw	a5,-24(s0)
    80004be8:	9fb9                	addw	a5,a5,a4
    80004bea:	2781                	sext.w	a5,a5
    80004bec:	2781                	sext.w	a5,a5
    80004bee:	a895                	j	80004c62 <balloc+0x1a6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004bf0:	fe842783          	lw	a5,-24(s0)
    80004bf4:	2785                	addiw	a5,a5,1
    80004bf6:	fef42423          	sw	a5,-24(s0)
    80004bfa:	fe842783          	lw	a5,-24(s0)
    80004bfe:	0007871b          	sext.w	a4,a5
    80004c02:	6789                	lui	a5,0x2
    80004c04:	02f75163          	bge	a4,a5,80004c26 <balloc+0x16a>
    80004c08:	fec42703          	lw	a4,-20(s0)
    80004c0c:	fe842783          	lw	a5,-24(s0)
    80004c10:	9fb9                	addw	a5,a5,a4
    80004c12:	2781                	sext.w	a5,a5
    80004c14:	0007871b          	sext.w	a4,a5
    80004c18:	0001d797          	auipc	a5,0x1d
    80004c1c:	4a878793          	addi	a5,a5,1192 # 800220c0 <sb>
    80004c20:	43dc                	lw	a5,4(a5)
    80004c22:	eef76ae3          	bltu	a4,a5,80004b16 <balloc+0x5a>
      }
    }
    brelse(bp);
    80004c26:	fe043503          	ld	a0,-32(s0)
    80004c2a:	00000097          	auipc	ra,0x0
    80004c2e:	bea080e7          	jalr	-1046(ra) # 80004814 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80004c32:	fec42703          	lw	a4,-20(s0)
    80004c36:	6789                	lui	a5,0x2
    80004c38:	9fb9                	addw	a5,a5,a4
    80004c3a:	fef42623          	sw	a5,-20(s0)
    80004c3e:	0001d797          	auipc	a5,0x1d
    80004c42:	48278793          	addi	a5,a5,1154 # 800220c0 <sb>
    80004c46:	43d8                	lw	a4,4(a5)
    80004c48:	fec42783          	lw	a5,-20(s0)
    80004c4c:	e8e7e4e3          	bltu	a5,a4,80004ad4 <balloc+0x18>
  }
  printf("balloc: out of blocks\n");
    80004c50:	00007517          	auipc	a0,0x7
    80004c54:	83050513          	addi	a0,a0,-2000 # 8000b480 <etext+0x480>
    80004c58:	ffffc097          	auipc	ra,0xffffc
    80004c5c:	dde080e7          	jalr	-546(ra) # 80000a36 <printf>
  return 0;
    80004c60:	4781                	li	a5,0
}
    80004c62:	853e                	mv	a0,a5
    80004c64:	70e2                	ld	ra,56(sp)
    80004c66:	7442                	ld	s0,48(sp)
    80004c68:	6121                	addi	sp,sp,64
    80004c6a:	8082                	ret

0000000080004c6c <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80004c6c:	7179                	addi	sp,sp,-48
    80004c6e:	f406                	sd	ra,40(sp)
    80004c70:	f022                	sd	s0,32(sp)
    80004c72:	1800                	addi	s0,sp,48
    80004c74:	87aa                	mv	a5,a0
    80004c76:	872e                	mv	a4,a1
    80004c78:	fcf42e23          	sw	a5,-36(s0)
    80004c7c:	87ba                	mv	a5,a4
    80004c7e:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80004c82:	fdc42683          	lw	a3,-36(s0)
    80004c86:	fd842783          	lw	a5,-40(s0)
    80004c8a:	00d7d79b          	srliw	a5,a5,0xd
    80004c8e:	0007871b          	sext.w	a4,a5
    80004c92:	0001d797          	auipc	a5,0x1d
    80004c96:	42e78793          	addi	a5,a5,1070 # 800220c0 <sb>
    80004c9a:	4fdc                	lw	a5,28(a5)
    80004c9c:	9fb9                	addw	a5,a5,a4
    80004c9e:	2781                	sext.w	a5,a5
    80004ca0:	85be                	mv	a1,a5
    80004ca2:	8536                	mv	a0,a3
    80004ca4:	00000097          	auipc	ra,0x0
    80004ca8:	ac6080e7          	jalr	-1338(ra) # 8000476a <bread>
    80004cac:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80004cb0:	fd842703          	lw	a4,-40(s0)
    80004cb4:	6789                	lui	a5,0x2
    80004cb6:	17fd                	addi	a5,a5,-1
    80004cb8:	8ff9                	and	a5,a5,a4
    80004cba:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80004cbe:	fe442703          	lw	a4,-28(s0)
    80004cc2:	41f7579b          	sraiw	a5,a4,0x1f
    80004cc6:	01d7d79b          	srliw	a5,a5,0x1d
    80004cca:	9f3d                	addw	a4,a4,a5
    80004ccc:	8b1d                	andi	a4,a4,7
    80004cce:	40f707bb          	subw	a5,a4,a5
    80004cd2:	2781                	sext.w	a5,a5
    80004cd4:	4705                	li	a4,1
    80004cd6:	00f717bb          	sllw	a5,a4,a5
    80004cda:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80004cde:	fe442783          	lw	a5,-28(s0)
    80004ce2:	41f7d71b          	sraiw	a4,a5,0x1f
    80004ce6:	01d7571b          	srliw	a4,a4,0x1d
    80004cea:	9fb9                	addw	a5,a5,a4
    80004cec:	4037d79b          	sraiw	a5,a5,0x3
    80004cf0:	2781                	sext.w	a5,a5
    80004cf2:	fe843703          	ld	a4,-24(s0)
    80004cf6:	97ba                	add	a5,a5,a4
    80004cf8:	0587c783          	lbu	a5,88(a5) # 2058 <_entry-0x7fffdfa8>
    80004cfc:	0007871b          	sext.w	a4,a5
    80004d00:	fe042783          	lw	a5,-32(s0)
    80004d04:	8ff9                	and	a5,a5,a4
    80004d06:	2781                	sext.w	a5,a5
    80004d08:	eb89                	bnez	a5,80004d1a <bfree+0xae>
    panic("freeing free block");
    80004d0a:	00006517          	auipc	a0,0x6
    80004d0e:	78e50513          	addi	a0,a0,1934 # 8000b498 <etext+0x498>
    80004d12:	ffffc097          	auipc	ra,0xffffc
    80004d16:	f7a080e7          	jalr	-134(ra) # 80000c8c <panic>
  bp->data[bi/8] &= ~m;
    80004d1a:	fe442783          	lw	a5,-28(s0)
    80004d1e:	41f7d71b          	sraiw	a4,a5,0x1f
    80004d22:	01d7571b          	srliw	a4,a4,0x1d
    80004d26:	9fb9                	addw	a5,a5,a4
    80004d28:	4037d79b          	sraiw	a5,a5,0x3
    80004d2c:	2781                	sext.w	a5,a5
    80004d2e:	fe843703          	ld	a4,-24(s0)
    80004d32:	973e                	add	a4,a4,a5
    80004d34:	05874703          	lbu	a4,88(a4)
    80004d38:	0187169b          	slliw	a3,a4,0x18
    80004d3c:	4186d69b          	sraiw	a3,a3,0x18
    80004d40:	fe042703          	lw	a4,-32(s0)
    80004d44:	0187171b          	slliw	a4,a4,0x18
    80004d48:	4187571b          	sraiw	a4,a4,0x18
    80004d4c:	fff74713          	not	a4,a4
    80004d50:	0187171b          	slliw	a4,a4,0x18
    80004d54:	4187571b          	sraiw	a4,a4,0x18
    80004d58:	8f75                	and	a4,a4,a3
    80004d5a:	0187171b          	slliw	a4,a4,0x18
    80004d5e:	4187571b          	sraiw	a4,a4,0x18
    80004d62:	0ff77713          	andi	a4,a4,255
    80004d66:	fe843683          	ld	a3,-24(s0)
    80004d6a:	97b6                	add	a5,a5,a3
    80004d6c:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80004d70:	fe843503          	ld	a0,-24(s0)
    80004d74:	00001097          	auipc	ra,0x1
    80004d78:	752080e7          	jalr	1874(ra) # 800064c6 <log_write>
  brelse(bp);
    80004d7c:	fe843503          	ld	a0,-24(s0)
    80004d80:	00000097          	auipc	ra,0x0
    80004d84:	a94080e7          	jalr	-1388(ra) # 80004814 <brelse>
}
    80004d88:	0001                	nop
    80004d8a:	70a2                	ld	ra,40(sp)
    80004d8c:	7402                	ld	s0,32(sp)
    80004d8e:	6145                	addi	sp,sp,48
    80004d90:	8082                	ret

0000000080004d92 <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80004d92:	1101                	addi	sp,sp,-32
    80004d94:	ec06                	sd	ra,24(sp)
    80004d96:	e822                	sd	s0,16(sp)
    80004d98:	1000                	addi	s0,sp,32
  int i = 0;
    80004d9a:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80004d9e:	00006597          	auipc	a1,0x6
    80004da2:	71258593          	addi	a1,a1,1810 # 8000b4b0 <etext+0x4b0>
    80004da6:	0001d517          	auipc	a0,0x1d
    80004daa:	33a50513          	addi	a0,a0,826 # 800220e0 <itable>
    80004dae:	ffffc097          	auipc	ra,0xffffc
    80004db2:	54c080e7          	jalr	1356(ra) # 800012fa <initlock>
  for(i = 0; i < NINODE; i++) {
    80004db6:	fe042623          	sw	zero,-20(s0)
    80004dba:	a82d                	j	80004df4 <iinit+0x62>
    initsleeplock(&itable.inode[i].lock, "inode");
    80004dbc:	fec42703          	lw	a4,-20(s0)
    80004dc0:	87ba                	mv	a5,a4
    80004dc2:	0792                	slli	a5,a5,0x4
    80004dc4:	97ba                	add	a5,a5,a4
    80004dc6:	078e                	slli	a5,a5,0x3
    80004dc8:	02078713          	addi	a4,a5,32
    80004dcc:	0001d797          	auipc	a5,0x1d
    80004dd0:	31478793          	addi	a5,a5,788 # 800220e0 <itable>
    80004dd4:	97ba                	add	a5,a5,a4
    80004dd6:	07a1                	addi	a5,a5,8
    80004dd8:	00006597          	auipc	a1,0x6
    80004ddc:	6e058593          	addi	a1,a1,1760 # 8000b4b8 <etext+0x4b8>
    80004de0:	853e                	mv	a0,a5
    80004de2:	00002097          	auipc	ra,0x2
    80004de6:	818080e7          	jalr	-2024(ra) # 800065fa <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80004dea:	fec42783          	lw	a5,-20(s0)
    80004dee:	2785                	addiw	a5,a5,1
    80004df0:	fef42623          	sw	a5,-20(s0)
    80004df4:	fec42783          	lw	a5,-20(s0)
    80004df8:	0007871b          	sext.w	a4,a5
    80004dfc:	03100793          	li	a5,49
    80004e00:	fae7dee3          	bge	a5,a4,80004dbc <iinit+0x2a>
  }
}
    80004e04:	0001                	nop
    80004e06:	0001                	nop
    80004e08:	60e2                	ld	ra,24(sp)
    80004e0a:	6442                	ld	s0,16(sp)
    80004e0c:	6105                	addi	sp,sp,32
    80004e0e:	8082                	ret

0000000080004e10 <ialloc>:
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode,
// or NULL if there is no free inode.
struct inode*
ialloc(uint dev, short type)
{
    80004e10:	7139                	addi	sp,sp,-64
    80004e12:	fc06                	sd	ra,56(sp)
    80004e14:	f822                	sd	s0,48(sp)
    80004e16:	0080                	addi	s0,sp,64
    80004e18:	87aa                	mv	a5,a0
    80004e1a:	872e                	mv	a4,a1
    80004e1c:	fcf42623          	sw	a5,-52(s0)
    80004e20:	87ba                	mv	a5,a4
    80004e22:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    80004e26:	4785                	li	a5,1
    80004e28:	fef42623          	sw	a5,-20(s0)
    80004e2c:	a855                	j	80004ee0 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    80004e2e:	fec42783          	lw	a5,-20(s0)
    80004e32:	8391                	srli	a5,a5,0x4
    80004e34:	0007871b          	sext.w	a4,a5
    80004e38:	0001d797          	auipc	a5,0x1d
    80004e3c:	28878793          	addi	a5,a5,648 # 800220c0 <sb>
    80004e40:	4f9c                	lw	a5,24(a5)
    80004e42:	9fb9                	addw	a5,a5,a4
    80004e44:	0007871b          	sext.w	a4,a5
    80004e48:	fcc42783          	lw	a5,-52(s0)
    80004e4c:	85ba                	mv	a1,a4
    80004e4e:	853e                	mv	a0,a5
    80004e50:	00000097          	auipc	ra,0x0
    80004e54:	91a080e7          	jalr	-1766(ra) # 8000476a <bread>
    80004e58:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80004e5c:	fe043783          	ld	a5,-32(s0)
    80004e60:	05878713          	addi	a4,a5,88
    80004e64:	fec42783          	lw	a5,-20(s0)
    80004e68:	8bbd                	andi	a5,a5,15
    80004e6a:	079a                	slli	a5,a5,0x6
    80004e6c:	97ba                	add	a5,a5,a4
    80004e6e:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80004e72:	fd843783          	ld	a5,-40(s0)
    80004e76:	00079783          	lh	a5,0(a5)
    80004e7a:	eba1                	bnez	a5,80004eca <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80004e7c:	04000613          	li	a2,64
    80004e80:	4581                	li	a1,0
    80004e82:	fd843503          	ld	a0,-40(s0)
    80004e86:	ffffc097          	auipc	ra,0xffffc
    80004e8a:	678080e7          	jalr	1656(ra) # 800014fe <memset>
      dip->type = type;
    80004e8e:	fd843783          	ld	a5,-40(s0)
    80004e92:	fca45703          	lhu	a4,-54(s0)
    80004e96:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80004e9a:	fe043503          	ld	a0,-32(s0)
    80004e9e:	00001097          	auipc	ra,0x1
    80004ea2:	628080e7          	jalr	1576(ra) # 800064c6 <log_write>
      brelse(bp);
    80004ea6:	fe043503          	ld	a0,-32(s0)
    80004eaa:	00000097          	auipc	ra,0x0
    80004eae:	96a080e7          	jalr	-1686(ra) # 80004814 <brelse>
      return iget(dev, inum);
    80004eb2:	fec42703          	lw	a4,-20(s0)
    80004eb6:	fcc42783          	lw	a5,-52(s0)
    80004eba:	85ba                	mv	a1,a4
    80004ebc:	853e                	mv	a0,a5
    80004ebe:	00000097          	auipc	ra,0x0
    80004ec2:	138080e7          	jalr	312(ra) # 80004ff6 <iget>
    80004ec6:	87aa                	mv	a5,a0
    80004ec8:	a835                	j	80004f04 <ialloc+0xf4>
    }
    brelse(bp);
    80004eca:	fe043503          	ld	a0,-32(s0)
    80004ece:	00000097          	auipc	ra,0x0
    80004ed2:	946080e7          	jalr	-1722(ra) # 80004814 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80004ed6:	fec42783          	lw	a5,-20(s0)
    80004eda:	2785                	addiw	a5,a5,1
    80004edc:	fef42623          	sw	a5,-20(s0)
    80004ee0:	0001d797          	auipc	a5,0x1d
    80004ee4:	1e078793          	addi	a5,a5,480 # 800220c0 <sb>
    80004ee8:	47d8                	lw	a4,12(a5)
    80004eea:	fec42783          	lw	a5,-20(s0)
    80004eee:	f4e7e0e3          	bltu	a5,a4,80004e2e <ialloc+0x1e>
  }
  printf("ialloc: no inodes\n");
    80004ef2:	00006517          	auipc	a0,0x6
    80004ef6:	5ce50513          	addi	a0,a0,1486 # 8000b4c0 <etext+0x4c0>
    80004efa:	ffffc097          	auipc	ra,0xffffc
    80004efe:	b3c080e7          	jalr	-1220(ra) # 80000a36 <printf>
  return 0;
    80004f02:	4781                	li	a5,0
}
    80004f04:	853e                	mv	a0,a5
    80004f06:	70e2                	ld	ra,56(sp)
    80004f08:	7442                	ld	s0,48(sp)
    80004f0a:	6121                	addi	sp,sp,64
    80004f0c:	8082                	ret

0000000080004f0e <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    80004f0e:	7179                	addi	sp,sp,-48
    80004f10:	f406                	sd	ra,40(sp)
    80004f12:	f022                	sd	s0,32(sp)
    80004f14:	1800                	addi	s0,sp,48
    80004f16:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80004f1a:	fd843783          	ld	a5,-40(s0)
    80004f1e:	4394                	lw	a3,0(a5)
    80004f20:	fd843783          	ld	a5,-40(s0)
    80004f24:	43dc                	lw	a5,4(a5)
    80004f26:	0047d79b          	srliw	a5,a5,0x4
    80004f2a:	0007871b          	sext.w	a4,a5
    80004f2e:	0001d797          	auipc	a5,0x1d
    80004f32:	19278793          	addi	a5,a5,402 # 800220c0 <sb>
    80004f36:	4f9c                	lw	a5,24(a5)
    80004f38:	9fb9                	addw	a5,a5,a4
    80004f3a:	2781                	sext.w	a5,a5
    80004f3c:	85be                	mv	a1,a5
    80004f3e:	8536                	mv	a0,a3
    80004f40:	00000097          	auipc	ra,0x0
    80004f44:	82a080e7          	jalr	-2006(ra) # 8000476a <bread>
    80004f48:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80004f4c:	fe843783          	ld	a5,-24(s0)
    80004f50:	05878713          	addi	a4,a5,88
    80004f54:	fd843783          	ld	a5,-40(s0)
    80004f58:	43dc                	lw	a5,4(a5)
    80004f5a:	1782                	slli	a5,a5,0x20
    80004f5c:	9381                	srli	a5,a5,0x20
    80004f5e:	8bbd                	andi	a5,a5,15
    80004f60:	079a                	slli	a5,a5,0x6
    80004f62:	97ba                	add	a5,a5,a4
    80004f64:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    80004f68:	fd843783          	ld	a5,-40(s0)
    80004f6c:	04479703          	lh	a4,68(a5)
    80004f70:	fe043783          	ld	a5,-32(s0)
    80004f74:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80004f78:	fd843783          	ld	a5,-40(s0)
    80004f7c:	04679703          	lh	a4,70(a5)
    80004f80:	fe043783          	ld	a5,-32(s0)
    80004f84:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80004f88:	fd843783          	ld	a5,-40(s0)
    80004f8c:	04879703          	lh	a4,72(a5)
    80004f90:	fe043783          	ld	a5,-32(s0)
    80004f94:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80004f98:	fd843783          	ld	a5,-40(s0)
    80004f9c:	04a79703          	lh	a4,74(a5)
    80004fa0:	fe043783          	ld	a5,-32(s0)
    80004fa4:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80004fa8:	fd843783          	ld	a5,-40(s0)
    80004fac:	47f8                	lw	a4,76(a5)
    80004fae:	fe043783          	ld	a5,-32(s0)
    80004fb2:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80004fb4:	fe043783          	ld	a5,-32(s0)
    80004fb8:	00c78713          	addi	a4,a5,12
    80004fbc:	fd843783          	ld	a5,-40(s0)
    80004fc0:	05078793          	addi	a5,a5,80
    80004fc4:	03400613          	li	a2,52
    80004fc8:	85be                	mv	a1,a5
    80004fca:	853a                	mv	a0,a4
    80004fcc:	ffffc097          	auipc	ra,0xffffc
    80004fd0:	616080e7          	jalr	1558(ra) # 800015e2 <memmove>
  log_write(bp);
    80004fd4:	fe843503          	ld	a0,-24(s0)
    80004fd8:	00001097          	auipc	ra,0x1
    80004fdc:	4ee080e7          	jalr	1262(ra) # 800064c6 <log_write>
  brelse(bp);
    80004fe0:	fe843503          	ld	a0,-24(s0)
    80004fe4:	00000097          	auipc	ra,0x0
    80004fe8:	830080e7          	jalr	-2000(ra) # 80004814 <brelse>
}
    80004fec:	0001                	nop
    80004fee:	70a2                	ld	ra,40(sp)
    80004ff0:	7402                	ld	s0,32(sp)
    80004ff2:	6145                	addi	sp,sp,48
    80004ff4:	8082                	ret

0000000080004ff6 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    80004ff6:	7179                	addi	sp,sp,-48
    80004ff8:	f406                	sd	ra,40(sp)
    80004ffa:	f022                	sd	s0,32(sp)
    80004ffc:	1800                	addi	s0,sp,48
    80004ffe:	87aa                	mv	a5,a0
    80005000:	872e                	mv	a4,a1
    80005002:	fcf42e23          	sw	a5,-36(s0)
    80005006:	87ba                	mv	a5,a4
    80005008:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    8000500c:	0001d517          	auipc	a0,0x1d
    80005010:	0d450513          	addi	a0,a0,212 # 800220e0 <itable>
    80005014:	ffffc097          	auipc	ra,0xffffc
    80005018:	316080e7          	jalr	790(ra) # 8000132a <acquire>

  // Is the inode already in the table?
  empty = 0;
    8000501c:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005020:	0001d797          	auipc	a5,0x1d
    80005024:	0d878793          	addi	a5,a5,216 # 800220f8 <itable+0x18>
    80005028:	fef43423          	sd	a5,-24(s0)
    8000502c:	a89d                	j	800050a2 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000502e:	fe843783          	ld	a5,-24(s0)
    80005032:	479c                	lw	a5,8(a5)
    80005034:	04f05663          	blez	a5,80005080 <iget+0x8a>
    80005038:	fe843783          	ld	a5,-24(s0)
    8000503c:	4398                	lw	a4,0(a5)
    8000503e:	fdc42783          	lw	a5,-36(s0)
    80005042:	2781                	sext.w	a5,a5
    80005044:	02e79e63          	bne	a5,a4,80005080 <iget+0x8a>
    80005048:	fe843783          	ld	a5,-24(s0)
    8000504c:	43d8                	lw	a4,4(a5)
    8000504e:	fd842783          	lw	a5,-40(s0)
    80005052:	2781                	sext.w	a5,a5
    80005054:	02e79663          	bne	a5,a4,80005080 <iget+0x8a>
      ip->ref++;
    80005058:	fe843783          	ld	a5,-24(s0)
    8000505c:	479c                	lw	a5,8(a5)
    8000505e:	2785                	addiw	a5,a5,1
    80005060:	0007871b          	sext.w	a4,a5
    80005064:	fe843783          	ld	a5,-24(s0)
    80005068:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    8000506a:	0001d517          	auipc	a0,0x1d
    8000506e:	07650513          	addi	a0,a0,118 # 800220e0 <itable>
    80005072:	ffffc097          	auipc	ra,0xffffc
    80005076:	31c080e7          	jalr	796(ra) # 8000138e <release>
      return ip;
    8000507a:	fe843783          	ld	a5,-24(s0)
    8000507e:	a069                	j	80005108 <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80005080:	fe043783          	ld	a5,-32(s0)
    80005084:	eb89                	bnez	a5,80005096 <iget+0xa0>
    80005086:	fe843783          	ld	a5,-24(s0)
    8000508a:	479c                	lw	a5,8(a5)
    8000508c:	e789                	bnez	a5,80005096 <iget+0xa0>
      empty = ip;
    8000508e:	fe843783          	ld	a5,-24(s0)
    80005092:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80005096:	fe843783          	ld	a5,-24(s0)
    8000509a:	08878793          	addi	a5,a5,136
    8000509e:	fef43423          	sd	a5,-24(s0)
    800050a2:	fe843703          	ld	a4,-24(s0)
    800050a6:	0001f797          	auipc	a5,0x1f
    800050aa:	ae278793          	addi	a5,a5,-1310 # 80023b88 <log>
    800050ae:	f8f760e3          	bltu	a4,a5,8000502e <iget+0x38>
  }

  // Recycle an inode entry.
  if(empty == 0)
    800050b2:	fe043783          	ld	a5,-32(s0)
    800050b6:	eb89                	bnez	a5,800050c8 <iget+0xd2>
    panic("iget: no inodes");
    800050b8:	00006517          	auipc	a0,0x6
    800050bc:	42050513          	addi	a0,a0,1056 # 8000b4d8 <etext+0x4d8>
    800050c0:	ffffc097          	auipc	ra,0xffffc
    800050c4:	bcc080e7          	jalr	-1076(ra) # 80000c8c <panic>

  ip = empty;
    800050c8:	fe043783          	ld	a5,-32(s0)
    800050cc:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    800050d0:	fe843783          	ld	a5,-24(s0)
    800050d4:	fdc42703          	lw	a4,-36(s0)
    800050d8:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    800050da:	fe843783          	ld	a5,-24(s0)
    800050de:	fd842703          	lw	a4,-40(s0)
    800050e2:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    800050e4:	fe843783          	ld	a5,-24(s0)
    800050e8:	4705                	li	a4,1
    800050ea:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    800050ec:	fe843783          	ld	a5,-24(s0)
    800050f0:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    800050f4:	0001d517          	auipc	a0,0x1d
    800050f8:	fec50513          	addi	a0,a0,-20 # 800220e0 <itable>
    800050fc:	ffffc097          	auipc	ra,0xffffc
    80005100:	292080e7          	jalr	658(ra) # 8000138e <release>

  return ip;
    80005104:	fe843783          	ld	a5,-24(s0)
}
    80005108:	853e                	mv	a0,a5
    8000510a:	70a2                	ld	ra,40(sp)
    8000510c:	7402                	ld	s0,32(sp)
    8000510e:	6145                	addi	sp,sp,48
    80005110:	8082                	ret

0000000080005112 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80005112:	1101                	addi	sp,sp,-32
    80005114:	ec06                	sd	ra,24(sp)
    80005116:	e822                	sd	s0,16(sp)
    80005118:	1000                	addi	s0,sp,32
    8000511a:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    8000511e:	0001d517          	auipc	a0,0x1d
    80005122:	fc250513          	addi	a0,a0,-62 # 800220e0 <itable>
    80005126:	ffffc097          	auipc	ra,0xffffc
    8000512a:	204080e7          	jalr	516(ra) # 8000132a <acquire>
  ip->ref++;
    8000512e:	fe843783          	ld	a5,-24(s0)
    80005132:	479c                	lw	a5,8(a5)
    80005134:	2785                	addiw	a5,a5,1
    80005136:	0007871b          	sext.w	a4,a5
    8000513a:	fe843783          	ld	a5,-24(s0)
    8000513e:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005140:	0001d517          	auipc	a0,0x1d
    80005144:	fa050513          	addi	a0,a0,-96 # 800220e0 <itable>
    80005148:	ffffc097          	auipc	ra,0xffffc
    8000514c:	246080e7          	jalr	582(ra) # 8000138e <release>
  return ip;
    80005150:	fe843783          	ld	a5,-24(s0)
}
    80005154:	853e                	mv	a0,a5
    80005156:	60e2                	ld	ra,24(sp)
    80005158:	6442                	ld	s0,16(sp)
    8000515a:	6105                	addi	sp,sp,32
    8000515c:	8082                	ret

000000008000515e <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    8000515e:	7179                	addi	sp,sp,-48
    80005160:	f406                	sd	ra,40(sp)
    80005162:	f022                	sd	s0,32(sp)
    80005164:	1800                	addi	s0,sp,48
    80005166:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    8000516a:	fd843783          	ld	a5,-40(s0)
    8000516e:	c791                	beqz	a5,8000517a <ilock+0x1c>
    80005170:	fd843783          	ld	a5,-40(s0)
    80005174:	479c                	lw	a5,8(a5)
    80005176:	00f04a63          	bgtz	a5,8000518a <ilock+0x2c>
    panic("ilock");
    8000517a:	00006517          	auipc	a0,0x6
    8000517e:	36e50513          	addi	a0,a0,878 # 8000b4e8 <etext+0x4e8>
    80005182:	ffffc097          	auipc	ra,0xffffc
    80005186:	b0a080e7          	jalr	-1270(ra) # 80000c8c <panic>

  acquiresleep(&ip->lock);
    8000518a:	fd843783          	ld	a5,-40(s0)
    8000518e:	07c1                	addi	a5,a5,16
    80005190:	853e                	mv	a0,a5
    80005192:	00001097          	auipc	ra,0x1
    80005196:	4b4080e7          	jalr	1204(ra) # 80006646 <acquiresleep>

  if(ip->valid == 0){
    8000519a:	fd843783          	ld	a5,-40(s0)
    8000519e:	43bc                	lw	a5,64(a5)
    800051a0:	e7e5                	bnez	a5,80005288 <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800051a2:	fd843783          	ld	a5,-40(s0)
    800051a6:	4394                	lw	a3,0(a5)
    800051a8:	fd843783          	ld	a5,-40(s0)
    800051ac:	43dc                	lw	a5,4(a5)
    800051ae:	0047d79b          	srliw	a5,a5,0x4
    800051b2:	0007871b          	sext.w	a4,a5
    800051b6:	0001d797          	auipc	a5,0x1d
    800051ba:	f0a78793          	addi	a5,a5,-246 # 800220c0 <sb>
    800051be:	4f9c                	lw	a5,24(a5)
    800051c0:	9fb9                	addw	a5,a5,a4
    800051c2:	2781                	sext.w	a5,a5
    800051c4:	85be                	mv	a1,a5
    800051c6:	8536                	mv	a0,a3
    800051c8:	fffff097          	auipc	ra,0xfffff
    800051cc:	5a2080e7          	jalr	1442(ra) # 8000476a <bread>
    800051d0:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    800051d4:	fe843783          	ld	a5,-24(s0)
    800051d8:	05878713          	addi	a4,a5,88
    800051dc:	fd843783          	ld	a5,-40(s0)
    800051e0:	43dc                	lw	a5,4(a5)
    800051e2:	1782                	slli	a5,a5,0x20
    800051e4:	9381                	srli	a5,a5,0x20
    800051e6:	8bbd                	andi	a5,a5,15
    800051e8:	079a                	slli	a5,a5,0x6
    800051ea:	97ba                	add	a5,a5,a4
    800051ec:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    800051f0:	fe043783          	ld	a5,-32(s0)
    800051f4:	00079703          	lh	a4,0(a5)
    800051f8:	fd843783          	ld	a5,-40(s0)
    800051fc:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80005200:	fe043783          	ld	a5,-32(s0)
    80005204:	00279703          	lh	a4,2(a5)
    80005208:	fd843783          	ld	a5,-40(s0)
    8000520c:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80005210:	fe043783          	ld	a5,-32(s0)
    80005214:	00479703          	lh	a4,4(a5)
    80005218:	fd843783          	ld	a5,-40(s0)
    8000521c:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80005220:	fe043783          	ld	a5,-32(s0)
    80005224:	00679703          	lh	a4,6(a5)
    80005228:	fd843783          	ld	a5,-40(s0)
    8000522c:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80005230:	fe043783          	ld	a5,-32(s0)
    80005234:	4798                	lw	a4,8(a5)
    80005236:	fd843783          	ld	a5,-40(s0)
    8000523a:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    8000523c:	fd843783          	ld	a5,-40(s0)
    80005240:	05078713          	addi	a4,a5,80
    80005244:	fe043783          	ld	a5,-32(s0)
    80005248:	07b1                	addi	a5,a5,12
    8000524a:	03400613          	li	a2,52
    8000524e:	85be                	mv	a1,a5
    80005250:	853a                	mv	a0,a4
    80005252:	ffffc097          	auipc	ra,0xffffc
    80005256:	390080e7          	jalr	912(ra) # 800015e2 <memmove>
    brelse(bp);
    8000525a:	fe843503          	ld	a0,-24(s0)
    8000525e:	fffff097          	auipc	ra,0xfffff
    80005262:	5b6080e7          	jalr	1462(ra) # 80004814 <brelse>
    ip->valid = 1;
    80005266:	fd843783          	ld	a5,-40(s0)
    8000526a:	4705                	li	a4,1
    8000526c:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    8000526e:	fd843783          	ld	a5,-40(s0)
    80005272:	04479783          	lh	a5,68(a5)
    80005276:	eb89                	bnez	a5,80005288 <ilock+0x12a>
      panic("ilock: no type");
    80005278:	00006517          	auipc	a0,0x6
    8000527c:	27850513          	addi	a0,a0,632 # 8000b4f0 <etext+0x4f0>
    80005280:	ffffc097          	auipc	ra,0xffffc
    80005284:	a0c080e7          	jalr	-1524(ra) # 80000c8c <panic>
  }
}
    80005288:	0001                	nop
    8000528a:	70a2                	ld	ra,40(sp)
    8000528c:	7402                	ld	s0,32(sp)
    8000528e:	6145                	addi	sp,sp,48
    80005290:	8082                	ret

0000000080005292 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005292:	1101                	addi	sp,sp,-32
    80005294:	ec06                	sd	ra,24(sp)
    80005296:	e822                	sd	s0,16(sp)
    80005298:	1000                	addi	s0,sp,32
    8000529a:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000529e:	fe843783          	ld	a5,-24(s0)
    800052a2:	c385                	beqz	a5,800052c2 <iunlock+0x30>
    800052a4:	fe843783          	ld	a5,-24(s0)
    800052a8:	07c1                	addi	a5,a5,16
    800052aa:	853e                	mv	a0,a5
    800052ac:	00001097          	auipc	ra,0x1
    800052b0:	45a080e7          	jalr	1114(ra) # 80006706 <holdingsleep>
    800052b4:	87aa                	mv	a5,a0
    800052b6:	c791                	beqz	a5,800052c2 <iunlock+0x30>
    800052b8:	fe843783          	ld	a5,-24(s0)
    800052bc:	479c                	lw	a5,8(a5)
    800052be:	00f04a63          	bgtz	a5,800052d2 <iunlock+0x40>
    panic("iunlock");
    800052c2:	00006517          	auipc	a0,0x6
    800052c6:	23e50513          	addi	a0,a0,574 # 8000b500 <etext+0x500>
    800052ca:	ffffc097          	auipc	ra,0xffffc
    800052ce:	9c2080e7          	jalr	-1598(ra) # 80000c8c <panic>

  releasesleep(&ip->lock);
    800052d2:	fe843783          	ld	a5,-24(s0)
    800052d6:	07c1                	addi	a5,a5,16
    800052d8:	853e                	mv	a0,a5
    800052da:	00001097          	auipc	ra,0x1
    800052de:	3da080e7          	jalr	986(ra) # 800066b4 <releasesleep>
}
    800052e2:	0001                	nop
    800052e4:	60e2                	ld	ra,24(sp)
    800052e6:	6442                	ld	s0,16(sp)
    800052e8:	6105                	addi	sp,sp,32
    800052ea:	8082                	ret

00000000800052ec <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    800052ec:	1101                	addi	sp,sp,-32
    800052ee:	ec06                	sd	ra,24(sp)
    800052f0:	e822                	sd	s0,16(sp)
    800052f2:	1000                	addi	s0,sp,32
    800052f4:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    800052f8:	0001d517          	auipc	a0,0x1d
    800052fc:	de850513          	addi	a0,a0,-536 # 800220e0 <itable>
    80005300:	ffffc097          	auipc	ra,0xffffc
    80005304:	02a080e7          	jalr	42(ra) # 8000132a <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80005308:	fe843783          	ld	a5,-24(s0)
    8000530c:	479c                	lw	a5,8(a5)
    8000530e:	873e                	mv	a4,a5
    80005310:	4785                	li	a5,1
    80005312:	06f71f63          	bne	a4,a5,80005390 <iput+0xa4>
    80005316:	fe843783          	ld	a5,-24(s0)
    8000531a:	43bc                	lw	a5,64(a5)
    8000531c:	cbb5                	beqz	a5,80005390 <iput+0xa4>
    8000531e:	fe843783          	ld	a5,-24(s0)
    80005322:	04a79783          	lh	a5,74(a5)
    80005326:	e7ad                	bnez	a5,80005390 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    80005328:	fe843783          	ld	a5,-24(s0)
    8000532c:	07c1                	addi	a5,a5,16
    8000532e:	853e                	mv	a0,a5
    80005330:	00001097          	auipc	ra,0x1
    80005334:	316080e7          	jalr	790(ra) # 80006646 <acquiresleep>

    release(&itable.lock);
    80005338:	0001d517          	auipc	a0,0x1d
    8000533c:	da850513          	addi	a0,a0,-600 # 800220e0 <itable>
    80005340:	ffffc097          	auipc	ra,0xffffc
    80005344:	04e080e7          	jalr	78(ra) # 8000138e <release>

    itrunc(ip);
    80005348:	fe843503          	ld	a0,-24(s0)
    8000534c:	00000097          	auipc	ra,0x0
    80005350:	21a080e7          	jalr	538(ra) # 80005566 <itrunc>
    ip->type = 0;
    80005354:	fe843783          	ld	a5,-24(s0)
    80005358:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    8000535c:	fe843503          	ld	a0,-24(s0)
    80005360:	00000097          	auipc	ra,0x0
    80005364:	bae080e7          	jalr	-1106(ra) # 80004f0e <iupdate>
    ip->valid = 0;
    80005368:	fe843783          	ld	a5,-24(s0)
    8000536c:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005370:	fe843783          	ld	a5,-24(s0)
    80005374:	07c1                	addi	a5,a5,16
    80005376:	853e                	mv	a0,a5
    80005378:	00001097          	auipc	ra,0x1
    8000537c:	33c080e7          	jalr	828(ra) # 800066b4 <releasesleep>

    acquire(&itable.lock);
    80005380:	0001d517          	auipc	a0,0x1d
    80005384:	d6050513          	addi	a0,a0,-672 # 800220e0 <itable>
    80005388:	ffffc097          	auipc	ra,0xffffc
    8000538c:	fa2080e7          	jalr	-94(ra) # 8000132a <acquire>
  }

  ip->ref--;
    80005390:	fe843783          	ld	a5,-24(s0)
    80005394:	479c                	lw	a5,8(a5)
    80005396:	37fd                	addiw	a5,a5,-1
    80005398:	0007871b          	sext.w	a4,a5
    8000539c:	fe843783          	ld	a5,-24(s0)
    800053a0:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    800053a2:	0001d517          	auipc	a0,0x1d
    800053a6:	d3e50513          	addi	a0,a0,-706 # 800220e0 <itable>
    800053aa:	ffffc097          	auipc	ra,0xffffc
    800053ae:	fe4080e7          	jalr	-28(ra) # 8000138e <release>
}
    800053b2:	0001                	nop
    800053b4:	60e2                	ld	ra,24(sp)
    800053b6:	6442                	ld	s0,16(sp)
    800053b8:	6105                	addi	sp,sp,32
    800053ba:	8082                	ret

00000000800053bc <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    800053bc:	1101                	addi	sp,sp,-32
    800053be:	ec06                	sd	ra,24(sp)
    800053c0:	e822                	sd	s0,16(sp)
    800053c2:	1000                	addi	s0,sp,32
    800053c4:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    800053c8:	fe843503          	ld	a0,-24(s0)
    800053cc:	00000097          	auipc	ra,0x0
    800053d0:	ec6080e7          	jalr	-314(ra) # 80005292 <iunlock>
  iput(ip);
    800053d4:	fe843503          	ld	a0,-24(s0)
    800053d8:	00000097          	auipc	ra,0x0
    800053dc:	f14080e7          	jalr	-236(ra) # 800052ec <iput>
}
    800053e0:	0001                	nop
    800053e2:	60e2                	ld	ra,24(sp)
    800053e4:	6442                	ld	s0,16(sp)
    800053e6:	6105                	addi	sp,sp,32
    800053e8:	8082                	ret

00000000800053ea <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800053ea:	7139                	addi	sp,sp,-64
    800053ec:	fc06                	sd	ra,56(sp)
    800053ee:	f822                	sd	s0,48(sp)
    800053f0:	0080                	addi	s0,sp,64
    800053f2:	fca43423          	sd	a0,-56(s0)
    800053f6:	87ae                	mv	a5,a1
    800053f8:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800053fc:	fc442783          	lw	a5,-60(s0)
    80005400:	0007871b          	sext.w	a4,a5
    80005404:	47ad                	li	a5,11
    80005406:	04e7ee63          	bltu	a5,a4,80005462 <bmap+0x78>
    if((addr = ip->addrs[bn]) == 0){
    8000540a:	fc843703          	ld	a4,-56(s0)
    8000540e:	fc446783          	lwu	a5,-60(s0)
    80005412:	07d1                	addi	a5,a5,20
    80005414:	078a                	slli	a5,a5,0x2
    80005416:	97ba                	add	a5,a5,a4
    80005418:	439c                	lw	a5,0(a5)
    8000541a:	fef42623          	sw	a5,-20(s0)
    8000541e:	fec42783          	lw	a5,-20(s0)
    80005422:	2781                	sext.w	a5,a5
    80005424:	ef85                	bnez	a5,8000545c <bmap+0x72>
      addr = balloc(ip->dev);
    80005426:	fc843783          	ld	a5,-56(s0)
    8000542a:	439c                	lw	a5,0(a5)
    8000542c:	853e                	mv	a0,a5
    8000542e:	fffff097          	auipc	ra,0xfffff
    80005432:	68e080e7          	jalr	1678(ra) # 80004abc <balloc>
    80005436:	87aa                	mv	a5,a0
    80005438:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    8000543c:	fec42783          	lw	a5,-20(s0)
    80005440:	2781                	sext.w	a5,a5
    80005442:	e399                	bnez	a5,80005448 <bmap+0x5e>
        return 0;
    80005444:	4781                	li	a5,0
    80005446:	aa19                	j	8000555c <bmap+0x172>
      ip->addrs[bn] = addr;
    80005448:	fc843703          	ld	a4,-56(s0)
    8000544c:	fc446783          	lwu	a5,-60(s0)
    80005450:	07d1                	addi	a5,a5,20
    80005452:	078a                	slli	a5,a5,0x2
    80005454:	97ba                	add	a5,a5,a4
    80005456:	fec42703          	lw	a4,-20(s0)
    8000545a:	c398                	sw	a4,0(a5)
    }
    return addr;
    8000545c:	fec42783          	lw	a5,-20(s0)
    80005460:	a8f5                	j	8000555c <bmap+0x172>
  }
  bn -= NDIRECT;
    80005462:	fc442783          	lw	a5,-60(s0)
    80005466:	37d1                	addiw	a5,a5,-12
    80005468:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    8000546c:	fc442783          	lw	a5,-60(s0)
    80005470:	0007871b          	sext.w	a4,a5
    80005474:	0ff00793          	li	a5,255
    80005478:	0ce7ea63          	bltu	a5,a4,8000554c <bmap+0x162>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    8000547c:	fc843783          	ld	a5,-56(s0)
    80005480:	0807a783          	lw	a5,128(a5)
    80005484:	fef42623          	sw	a5,-20(s0)
    80005488:	fec42783          	lw	a5,-20(s0)
    8000548c:	2781                	sext.w	a5,a5
    8000548e:	eb85                	bnez	a5,800054be <bmap+0xd4>
      addr = balloc(ip->dev);
    80005490:	fc843783          	ld	a5,-56(s0)
    80005494:	439c                	lw	a5,0(a5)
    80005496:	853e                	mv	a0,a5
    80005498:	fffff097          	auipc	ra,0xfffff
    8000549c:	624080e7          	jalr	1572(ra) # 80004abc <balloc>
    800054a0:	87aa                	mv	a5,a0
    800054a2:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    800054a6:	fec42783          	lw	a5,-20(s0)
    800054aa:	2781                	sext.w	a5,a5
    800054ac:	e399                	bnez	a5,800054b2 <bmap+0xc8>
        return 0;
    800054ae:	4781                	li	a5,0
    800054b0:	a075                	j	8000555c <bmap+0x172>
      ip->addrs[NDIRECT] = addr;
    800054b2:	fc843783          	ld	a5,-56(s0)
    800054b6:	fec42703          	lw	a4,-20(s0)
    800054ba:	08e7a023          	sw	a4,128(a5)
    }
    bp = bread(ip->dev, addr);
    800054be:	fc843783          	ld	a5,-56(s0)
    800054c2:	439c                	lw	a5,0(a5)
    800054c4:	fec42703          	lw	a4,-20(s0)
    800054c8:	85ba                	mv	a1,a4
    800054ca:	853e                	mv	a0,a5
    800054cc:	fffff097          	auipc	ra,0xfffff
    800054d0:	29e080e7          	jalr	670(ra) # 8000476a <bread>
    800054d4:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800054d8:	fe043783          	ld	a5,-32(s0)
    800054dc:	05878793          	addi	a5,a5,88
    800054e0:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    800054e4:	fc446783          	lwu	a5,-60(s0)
    800054e8:	078a                	slli	a5,a5,0x2
    800054ea:	fd843703          	ld	a4,-40(s0)
    800054ee:	97ba                	add	a5,a5,a4
    800054f0:	439c                	lw	a5,0(a5)
    800054f2:	fef42623          	sw	a5,-20(s0)
    800054f6:	fec42783          	lw	a5,-20(s0)
    800054fa:	2781                	sext.w	a5,a5
    800054fc:	ef9d                	bnez	a5,8000553a <bmap+0x150>
      addr = balloc(ip->dev);
    800054fe:	fc843783          	ld	a5,-56(s0)
    80005502:	439c                	lw	a5,0(a5)
    80005504:	853e                	mv	a0,a5
    80005506:	fffff097          	auipc	ra,0xfffff
    8000550a:	5b6080e7          	jalr	1462(ra) # 80004abc <balloc>
    8000550e:	87aa                	mv	a5,a0
    80005510:	fef42623          	sw	a5,-20(s0)
      if(addr){
    80005514:	fec42783          	lw	a5,-20(s0)
    80005518:	2781                	sext.w	a5,a5
    8000551a:	c385                	beqz	a5,8000553a <bmap+0x150>
        a[bn] = addr;
    8000551c:	fc446783          	lwu	a5,-60(s0)
    80005520:	078a                	slli	a5,a5,0x2
    80005522:	fd843703          	ld	a4,-40(s0)
    80005526:	97ba                	add	a5,a5,a4
    80005528:	fec42703          	lw	a4,-20(s0)
    8000552c:	c398                	sw	a4,0(a5)
        log_write(bp);
    8000552e:	fe043503          	ld	a0,-32(s0)
    80005532:	00001097          	auipc	ra,0x1
    80005536:	f94080e7          	jalr	-108(ra) # 800064c6 <log_write>
      }
    }
    brelse(bp);
    8000553a:	fe043503          	ld	a0,-32(s0)
    8000553e:	fffff097          	auipc	ra,0xfffff
    80005542:	2d6080e7          	jalr	726(ra) # 80004814 <brelse>
    return addr;
    80005546:	fec42783          	lw	a5,-20(s0)
    8000554a:	a809                	j	8000555c <bmap+0x172>
  }

  panic("bmap: out of range");
    8000554c:	00006517          	auipc	a0,0x6
    80005550:	fbc50513          	addi	a0,a0,-68 # 8000b508 <etext+0x508>
    80005554:	ffffb097          	auipc	ra,0xffffb
    80005558:	738080e7          	jalr	1848(ra) # 80000c8c <panic>
}
    8000555c:	853e                	mv	a0,a5
    8000555e:	70e2                	ld	ra,56(sp)
    80005560:	7442                	ld	s0,48(sp)
    80005562:	6121                	addi	sp,sp,64
    80005564:	8082                	ret

0000000080005566 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80005566:	7139                	addi	sp,sp,-64
    80005568:	fc06                	sd	ra,56(sp)
    8000556a:	f822                	sd	s0,48(sp)
    8000556c:	0080                	addi	s0,sp,64
    8000556e:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80005572:	fe042623          	sw	zero,-20(s0)
    80005576:	a899                	j	800055cc <itrunc+0x66>
    if(ip->addrs[i]){
    80005578:	fc843703          	ld	a4,-56(s0)
    8000557c:	fec42783          	lw	a5,-20(s0)
    80005580:	07d1                	addi	a5,a5,20
    80005582:	078a                	slli	a5,a5,0x2
    80005584:	97ba                	add	a5,a5,a4
    80005586:	439c                	lw	a5,0(a5)
    80005588:	cf8d                	beqz	a5,800055c2 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    8000558a:	fc843783          	ld	a5,-56(s0)
    8000558e:	439c                	lw	a5,0(a5)
    80005590:	0007869b          	sext.w	a3,a5
    80005594:	fc843703          	ld	a4,-56(s0)
    80005598:	fec42783          	lw	a5,-20(s0)
    8000559c:	07d1                	addi	a5,a5,20
    8000559e:	078a                	slli	a5,a5,0x2
    800055a0:	97ba                	add	a5,a5,a4
    800055a2:	439c                	lw	a5,0(a5)
    800055a4:	85be                	mv	a1,a5
    800055a6:	8536                	mv	a0,a3
    800055a8:	fffff097          	auipc	ra,0xfffff
    800055ac:	6c4080e7          	jalr	1732(ra) # 80004c6c <bfree>
      ip->addrs[i] = 0;
    800055b0:	fc843703          	ld	a4,-56(s0)
    800055b4:	fec42783          	lw	a5,-20(s0)
    800055b8:	07d1                	addi	a5,a5,20
    800055ba:	078a                	slli	a5,a5,0x2
    800055bc:	97ba                	add	a5,a5,a4
    800055be:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    800055c2:	fec42783          	lw	a5,-20(s0)
    800055c6:	2785                	addiw	a5,a5,1
    800055c8:	fef42623          	sw	a5,-20(s0)
    800055cc:	fec42783          	lw	a5,-20(s0)
    800055d0:	0007871b          	sext.w	a4,a5
    800055d4:	47ad                	li	a5,11
    800055d6:	fae7d1e3          	bge	a5,a4,80005578 <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    800055da:	fc843783          	ld	a5,-56(s0)
    800055de:	0807a783          	lw	a5,128(a5)
    800055e2:	cbc5                	beqz	a5,80005692 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800055e4:	fc843783          	ld	a5,-56(s0)
    800055e8:	4398                	lw	a4,0(a5)
    800055ea:	fc843783          	ld	a5,-56(s0)
    800055ee:	0807a783          	lw	a5,128(a5)
    800055f2:	85be                	mv	a1,a5
    800055f4:	853a                	mv	a0,a4
    800055f6:	fffff097          	auipc	ra,0xfffff
    800055fa:	174080e7          	jalr	372(ra) # 8000476a <bread>
    800055fe:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005602:	fe043783          	ld	a5,-32(s0)
    80005606:	05878793          	addi	a5,a5,88
    8000560a:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    8000560e:	fe042423          	sw	zero,-24(s0)
    80005612:	a081                	j	80005652 <itrunc+0xec>
      if(a[j])
    80005614:	fe842783          	lw	a5,-24(s0)
    80005618:	078a                	slli	a5,a5,0x2
    8000561a:	fd843703          	ld	a4,-40(s0)
    8000561e:	97ba                	add	a5,a5,a4
    80005620:	439c                	lw	a5,0(a5)
    80005622:	c39d                	beqz	a5,80005648 <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    80005624:	fc843783          	ld	a5,-56(s0)
    80005628:	439c                	lw	a5,0(a5)
    8000562a:	0007869b          	sext.w	a3,a5
    8000562e:	fe842783          	lw	a5,-24(s0)
    80005632:	078a                	slli	a5,a5,0x2
    80005634:	fd843703          	ld	a4,-40(s0)
    80005638:	97ba                	add	a5,a5,a4
    8000563a:	439c                	lw	a5,0(a5)
    8000563c:	85be                	mv	a1,a5
    8000563e:	8536                	mv	a0,a3
    80005640:	fffff097          	auipc	ra,0xfffff
    80005644:	62c080e7          	jalr	1580(ra) # 80004c6c <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80005648:	fe842783          	lw	a5,-24(s0)
    8000564c:	2785                	addiw	a5,a5,1
    8000564e:	fef42423          	sw	a5,-24(s0)
    80005652:	fe842783          	lw	a5,-24(s0)
    80005656:	873e                	mv	a4,a5
    80005658:	0ff00793          	li	a5,255
    8000565c:	fae7fce3          	bgeu	a5,a4,80005614 <itrunc+0xae>
    }
    brelse(bp);
    80005660:	fe043503          	ld	a0,-32(s0)
    80005664:	fffff097          	auipc	ra,0xfffff
    80005668:	1b0080e7          	jalr	432(ra) # 80004814 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    8000566c:	fc843783          	ld	a5,-56(s0)
    80005670:	439c                	lw	a5,0(a5)
    80005672:	0007871b          	sext.w	a4,a5
    80005676:	fc843783          	ld	a5,-56(s0)
    8000567a:	0807a783          	lw	a5,128(a5)
    8000567e:	85be                	mv	a1,a5
    80005680:	853a                	mv	a0,a4
    80005682:	fffff097          	auipc	ra,0xfffff
    80005686:	5ea080e7          	jalr	1514(ra) # 80004c6c <bfree>
    ip->addrs[NDIRECT] = 0;
    8000568a:	fc843783          	ld	a5,-56(s0)
    8000568e:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80005692:	fc843783          	ld	a5,-56(s0)
    80005696:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    8000569a:	fc843503          	ld	a0,-56(s0)
    8000569e:	00000097          	auipc	ra,0x0
    800056a2:	870080e7          	jalr	-1936(ra) # 80004f0e <iupdate>
}
    800056a6:	0001                	nop
    800056a8:	70e2                	ld	ra,56(sp)
    800056aa:	7442                	ld	s0,48(sp)
    800056ac:	6121                	addi	sp,sp,64
    800056ae:	8082                	ret

00000000800056b0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800056b0:	1101                	addi	sp,sp,-32
    800056b2:	ec22                	sd	s0,24(sp)
    800056b4:	1000                	addi	s0,sp,32
    800056b6:	fea43423          	sd	a0,-24(s0)
    800056ba:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    800056be:	fe843783          	ld	a5,-24(s0)
    800056c2:	439c                	lw	a5,0(a5)
    800056c4:	0007871b          	sext.w	a4,a5
    800056c8:	fe043783          	ld	a5,-32(s0)
    800056cc:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    800056ce:	fe843783          	ld	a5,-24(s0)
    800056d2:	43d8                	lw	a4,4(a5)
    800056d4:	fe043783          	ld	a5,-32(s0)
    800056d8:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    800056da:	fe843783          	ld	a5,-24(s0)
    800056de:	04479703          	lh	a4,68(a5)
    800056e2:	fe043783          	ld	a5,-32(s0)
    800056e6:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    800056ea:	fe843783          	ld	a5,-24(s0)
    800056ee:	04a79703          	lh	a4,74(a5)
    800056f2:	fe043783          	ld	a5,-32(s0)
    800056f6:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    800056fa:	fe843783          	ld	a5,-24(s0)
    800056fe:	47fc                	lw	a5,76(a5)
    80005700:	02079713          	slli	a4,a5,0x20
    80005704:	9301                	srli	a4,a4,0x20
    80005706:	fe043783          	ld	a5,-32(s0)
    8000570a:	eb98                	sd	a4,16(a5)
}
    8000570c:	0001                	nop
    8000570e:	6462                	ld	s0,24(sp)
    80005710:	6105                	addi	sp,sp,32
    80005712:	8082                	ret

0000000080005714 <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    80005714:	715d                	addi	sp,sp,-80
    80005716:	e486                	sd	ra,72(sp)
    80005718:	e0a2                	sd	s0,64(sp)
    8000571a:	0880                	addi	s0,sp,80
    8000571c:	fca43423          	sd	a0,-56(s0)
    80005720:	87ae                	mv	a5,a1
    80005722:	fac43c23          	sd	a2,-72(s0)
    80005726:	fcf42223          	sw	a5,-60(s0)
    8000572a:	87b6                	mv	a5,a3
    8000572c:	fcf42023          	sw	a5,-64(s0)
    80005730:	87ba                	mv	a5,a4
    80005732:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80005736:	fc843783          	ld	a5,-56(s0)
    8000573a:	47f8                	lw	a4,76(a5)
    8000573c:	fc042783          	lw	a5,-64(s0)
    80005740:	2781                	sext.w	a5,a5
    80005742:	00f76e63          	bltu	a4,a5,8000575e <readi+0x4a>
    80005746:	fc042703          	lw	a4,-64(s0)
    8000574a:	fb442783          	lw	a5,-76(s0)
    8000574e:	9fb9                	addw	a5,a5,a4
    80005750:	0007871b          	sext.w	a4,a5
    80005754:	fc042783          	lw	a5,-64(s0)
    80005758:	2781                	sext.w	a5,a5
    8000575a:	00f77463          	bgeu	a4,a5,80005762 <readi+0x4e>
    return 0;
    8000575e:	4781                	li	a5,0
    80005760:	a289                	j	800058a2 <readi+0x18e>
  if(off + n > ip->size)
    80005762:	fc042703          	lw	a4,-64(s0)
    80005766:	fb442783          	lw	a5,-76(s0)
    8000576a:	9fb9                	addw	a5,a5,a4
    8000576c:	0007871b          	sext.w	a4,a5
    80005770:	fc843783          	ld	a5,-56(s0)
    80005774:	47fc                	lw	a5,76(a5)
    80005776:	00e7fb63          	bgeu	a5,a4,8000578c <readi+0x78>
    n = ip->size - off;
    8000577a:	fc843783          	ld	a5,-56(s0)
    8000577e:	47f8                	lw	a4,76(a5)
    80005780:	fc042783          	lw	a5,-64(s0)
    80005784:	40f707bb          	subw	a5,a4,a5
    80005788:	faf42a23          	sw	a5,-76(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000578c:	fe042623          	sw	zero,-20(s0)
    80005790:	a8ed                	j	8000588a <readi+0x176>
    uint addr = bmap(ip, off/BSIZE);
    80005792:	fc042783          	lw	a5,-64(s0)
    80005796:	00a7d79b          	srliw	a5,a5,0xa
    8000579a:	2781                	sext.w	a5,a5
    8000579c:	85be                	mv	a1,a5
    8000579e:	fc843503          	ld	a0,-56(s0)
    800057a2:	00000097          	auipc	ra,0x0
    800057a6:	c48080e7          	jalr	-952(ra) # 800053ea <bmap>
    800057aa:	87aa                	mv	a5,a0
    800057ac:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    800057b0:	fe842783          	lw	a5,-24(s0)
    800057b4:	2781                	sext.w	a5,a5
    800057b6:	c3fd                	beqz	a5,8000589c <readi+0x188>
      break;
    bp = bread(ip->dev, addr);
    800057b8:	fc843783          	ld	a5,-56(s0)
    800057bc:	439c                	lw	a5,0(a5)
    800057be:	fe842703          	lw	a4,-24(s0)
    800057c2:	85ba                	mv	a1,a4
    800057c4:	853e                	mv	a0,a5
    800057c6:	fffff097          	auipc	ra,0xfffff
    800057ca:	fa4080e7          	jalr	-92(ra) # 8000476a <bread>
    800057ce:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    800057d2:	fc042783          	lw	a5,-64(s0)
    800057d6:	3ff7f793          	andi	a5,a5,1023
    800057da:	2781                	sext.w	a5,a5
    800057dc:	40000713          	li	a4,1024
    800057e0:	40f707bb          	subw	a5,a4,a5
    800057e4:	0007869b          	sext.w	a3,a5
    800057e8:	fb442703          	lw	a4,-76(s0)
    800057ec:	fec42783          	lw	a5,-20(s0)
    800057f0:	40f707bb          	subw	a5,a4,a5
    800057f4:	2781                	sext.w	a5,a5
    800057f6:	863e                	mv	a2,a5
    800057f8:	87b6                	mv	a5,a3
    800057fa:	0007869b          	sext.w	a3,a5
    800057fe:	0006071b          	sext.w	a4,a2
    80005802:	00d77363          	bgeu	a4,a3,80005808 <readi+0xf4>
    80005806:	87b2                	mv	a5,a2
    80005808:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000580c:	fe043783          	ld	a5,-32(s0)
    80005810:	05878713          	addi	a4,a5,88
    80005814:	fc046783          	lwu	a5,-64(s0)
    80005818:	3ff7f793          	andi	a5,a5,1023
    8000581c:	973e                	add	a4,a4,a5
    8000581e:	fdc46683          	lwu	a3,-36(s0)
    80005822:	fc442783          	lw	a5,-60(s0)
    80005826:	863a                	mv	a2,a4
    80005828:	fb843583          	ld	a1,-72(s0)
    8000582c:	853e                	mv	a0,a5
    8000582e:	ffffe097          	auipc	ra,0xffffe
    80005832:	efa080e7          	jalr	-262(ra) # 80003728 <either_copyout>
    80005836:	87aa                	mv	a5,a0
    80005838:	873e                	mv	a4,a5
    8000583a:	57fd                	li	a5,-1
    8000583c:	00f71c63          	bne	a4,a5,80005854 <readi+0x140>
      brelse(bp);
    80005840:	fe043503          	ld	a0,-32(s0)
    80005844:	fffff097          	auipc	ra,0xfffff
    80005848:	fd0080e7          	jalr	-48(ra) # 80004814 <brelse>
      tot = -1;
    8000584c:	57fd                	li	a5,-1
    8000584e:	fef42623          	sw	a5,-20(s0)
      break;
    80005852:	a0b1                	j	8000589e <readi+0x18a>
    }
    brelse(bp);
    80005854:	fe043503          	ld	a0,-32(s0)
    80005858:	fffff097          	auipc	ra,0xfffff
    8000585c:	fbc080e7          	jalr	-68(ra) # 80004814 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005860:	fec42703          	lw	a4,-20(s0)
    80005864:	fdc42783          	lw	a5,-36(s0)
    80005868:	9fb9                	addw	a5,a5,a4
    8000586a:	fef42623          	sw	a5,-20(s0)
    8000586e:	fc042703          	lw	a4,-64(s0)
    80005872:	fdc42783          	lw	a5,-36(s0)
    80005876:	9fb9                	addw	a5,a5,a4
    80005878:	fcf42023          	sw	a5,-64(s0)
    8000587c:	fdc46783          	lwu	a5,-36(s0)
    80005880:	fb843703          	ld	a4,-72(s0)
    80005884:	97ba                	add	a5,a5,a4
    80005886:	faf43c23          	sd	a5,-72(s0)
    8000588a:	fec42703          	lw	a4,-20(s0)
    8000588e:	fb442783          	lw	a5,-76(s0)
    80005892:	2701                	sext.w	a4,a4
    80005894:	2781                	sext.w	a5,a5
    80005896:	eef76ee3          	bltu	a4,a5,80005792 <readi+0x7e>
    8000589a:	a011                	j	8000589e <readi+0x18a>
      break;
    8000589c:	0001                	nop
  }
  return tot;
    8000589e:	fec42783          	lw	a5,-20(s0)
}
    800058a2:	853e                	mv	a0,a5
    800058a4:	60a6                	ld	ra,72(sp)
    800058a6:	6406                	ld	s0,64(sp)
    800058a8:	6161                	addi	sp,sp,80
    800058aa:	8082                	ret

00000000800058ac <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    800058ac:	715d                	addi	sp,sp,-80
    800058ae:	e486                	sd	ra,72(sp)
    800058b0:	e0a2                	sd	s0,64(sp)
    800058b2:	0880                	addi	s0,sp,80
    800058b4:	fca43423          	sd	a0,-56(s0)
    800058b8:	87ae                	mv	a5,a1
    800058ba:	fac43c23          	sd	a2,-72(s0)
    800058be:	fcf42223          	sw	a5,-60(s0)
    800058c2:	87b6                	mv	a5,a3
    800058c4:	fcf42023          	sw	a5,-64(s0)
    800058c8:	87ba                	mv	a5,a4
    800058ca:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800058ce:	fc843783          	ld	a5,-56(s0)
    800058d2:	47f8                	lw	a4,76(a5)
    800058d4:	fc042783          	lw	a5,-64(s0)
    800058d8:	2781                	sext.w	a5,a5
    800058da:	00f76e63          	bltu	a4,a5,800058f6 <writei+0x4a>
    800058de:	fc042703          	lw	a4,-64(s0)
    800058e2:	fb442783          	lw	a5,-76(s0)
    800058e6:	9fb9                	addw	a5,a5,a4
    800058e8:	0007871b          	sext.w	a4,a5
    800058ec:	fc042783          	lw	a5,-64(s0)
    800058f0:	2781                	sext.w	a5,a5
    800058f2:	00f77463          	bgeu	a4,a5,800058fa <writei+0x4e>
    return -1;
    800058f6:	57fd                	li	a5,-1
    800058f8:	aab9                	j	80005a56 <writei+0x1aa>
  if(off + n > MAXFILE*BSIZE)
    800058fa:	fc042703          	lw	a4,-64(s0)
    800058fe:	fb442783          	lw	a5,-76(s0)
    80005902:	9fb9                	addw	a5,a5,a4
    80005904:	2781                	sext.w	a5,a5
    80005906:	873e                	mv	a4,a5
    80005908:	000437b7          	lui	a5,0x43
    8000590c:	00e7f463          	bgeu	a5,a4,80005914 <writei+0x68>
    return -1;
    80005910:	57fd                	li	a5,-1
    80005912:	a291                	j	80005a56 <writei+0x1aa>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005914:	fe042623          	sw	zero,-20(s0)
    80005918:	a201                	j	80005a18 <writei+0x16c>
    uint addr = bmap(ip, off/BSIZE);
    8000591a:	fc042783          	lw	a5,-64(s0)
    8000591e:	00a7d79b          	srliw	a5,a5,0xa
    80005922:	2781                	sext.w	a5,a5
    80005924:	85be                	mv	a1,a5
    80005926:	fc843503          	ld	a0,-56(s0)
    8000592a:	00000097          	auipc	ra,0x0
    8000592e:	ac0080e7          	jalr	-1344(ra) # 800053ea <bmap>
    80005932:	87aa                	mv	a5,a0
    80005934:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    80005938:	fe842783          	lw	a5,-24(s0)
    8000593c:	2781                	sext.w	a5,a5
    8000593e:	c7f5                	beqz	a5,80005a2a <writei+0x17e>
      break;
    bp = bread(ip->dev, addr);
    80005940:	fc843783          	ld	a5,-56(s0)
    80005944:	439c                	lw	a5,0(a5)
    80005946:	fe842703          	lw	a4,-24(s0)
    8000594a:	85ba                	mv	a1,a4
    8000594c:	853e                	mv	a0,a5
    8000594e:	fffff097          	auipc	ra,0xfffff
    80005952:	e1c080e7          	jalr	-484(ra) # 8000476a <bread>
    80005956:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    8000595a:	fc042783          	lw	a5,-64(s0)
    8000595e:	3ff7f793          	andi	a5,a5,1023
    80005962:	2781                	sext.w	a5,a5
    80005964:	40000713          	li	a4,1024
    80005968:	40f707bb          	subw	a5,a4,a5
    8000596c:	0007869b          	sext.w	a3,a5
    80005970:	fb442703          	lw	a4,-76(s0)
    80005974:	fec42783          	lw	a5,-20(s0)
    80005978:	40f707bb          	subw	a5,a4,a5
    8000597c:	2781                	sext.w	a5,a5
    8000597e:	863e                	mv	a2,a5
    80005980:	87b6                	mv	a5,a3
    80005982:	0007869b          	sext.w	a3,a5
    80005986:	0006071b          	sext.w	a4,a2
    8000598a:	00d77363          	bgeu	a4,a3,80005990 <writei+0xe4>
    8000598e:	87b2                	mv	a5,a2
    80005990:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80005994:	fe043783          	ld	a5,-32(s0)
    80005998:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    8000599c:	fc046783          	lwu	a5,-64(s0)
    800059a0:	3ff7f793          	andi	a5,a5,1023
    800059a4:	97ba                	add	a5,a5,a4
    800059a6:	fdc46683          	lwu	a3,-36(s0)
    800059aa:	fc442703          	lw	a4,-60(s0)
    800059ae:	fb843603          	ld	a2,-72(s0)
    800059b2:	85ba                	mv	a1,a4
    800059b4:	853e                	mv	a0,a5
    800059b6:	ffffe097          	auipc	ra,0xffffe
    800059ba:	de6080e7          	jalr	-538(ra) # 8000379c <either_copyin>
    800059be:	87aa                	mv	a5,a0
    800059c0:	873e                	mv	a4,a5
    800059c2:	57fd                	li	a5,-1
    800059c4:	00f71963          	bne	a4,a5,800059d6 <writei+0x12a>
      brelse(bp);
    800059c8:	fe043503          	ld	a0,-32(s0)
    800059cc:	fffff097          	auipc	ra,0xfffff
    800059d0:	e48080e7          	jalr	-440(ra) # 80004814 <brelse>
      break;
    800059d4:	a8a1                	j	80005a2c <writei+0x180>
    }
    log_write(bp);
    800059d6:	fe043503          	ld	a0,-32(s0)
    800059da:	00001097          	auipc	ra,0x1
    800059de:	aec080e7          	jalr	-1300(ra) # 800064c6 <log_write>
    brelse(bp);
    800059e2:	fe043503          	ld	a0,-32(s0)
    800059e6:	fffff097          	auipc	ra,0xfffff
    800059ea:	e2e080e7          	jalr	-466(ra) # 80004814 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800059ee:	fec42703          	lw	a4,-20(s0)
    800059f2:	fdc42783          	lw	a5,-36(s0)
    800059f6:	9fb9                	addw	a5,a5,a4
    800059f8:	fef42623          	sw	a5,-20(s0)
    800059fc:	fc042703          	lw	a4,-64(s0)
    80005a00:	fdc42783          	lw	a5,-36(s0)
    80005a04:	9fb9                	addw	a5,a5,a4
    80005a06:	fcf42023          	sw	a5,-64(s0)
    80005a0a:	fdc46783          	lwu	a5,-36(s0)
    80005a0e:	fb843703          	ld	a4,-72(s0)
    80005a12:	97ba                	add	a5,a5,a4
    80005a14:	faf43c23          	sd	a5,-72(s0)
    80005a18:	fec42703          	lw	a4,-20(s0)
    80005a1c:	fb442783          	lw	a5,-76(s0)
    80005a20:	2701                	sext.w	a4,a4
    80005a22:	2781                	sext.w	a5,a5
    80005a24:	eef76be3          	bltu	a4,a5,8000591a <writei+0x6e>
    80005a28:	a011                	j	80005a2c <writei+0x180>
      break;
    80005a2a:	0001                	nop
  }

  if(off > ip->size)
    80005a2c:	fc843783          	ld	a5,-56(s0)
    80005a30:	47f8                	lw	a4,76(a5)
    80005a32:	fc042783          	lw	a5,-64(s0)
    80005a36:	2781                	sext.w	a5,a5
    80005a38:	00f77763          	bgeu	a4,a5,80005a46 <writei+0x19a>
    ip->size = off;
    80005a3c:	fc843783          	ld	a5,-56(s0)
    80005a40:	fc042703          	lw	a4,-64(s0)
    80005a44:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80005a46:	fc843503          	ld	a0,-56(s0)
    80005a4a:	fffff097          	auipc	ra,0xfffff
    80005a4e:	4c4080e7          	jalr	1220(ra) # 80004f0e <iupdate>

  return tot;
    80005a52:	fec42783          	lw	a5,-20(s0)
}
    80005a56:	853e                	mv	a0,a5
    80005a58:	60a6                	ld	ra,72(sp)
    80005a5a:	6406                	ld	s0,64(sp)
    80005a5c:	6161                	addi	sp,sp,80
    80005a5e:	8082                	ret

0000000080005a60 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80005a60:	1101                	addi	sp,sp,-32
    80005a62:	ec06                	sd	ra,24(sp)
    80005a64:	e822                	sd	s0,16(sp)
    80005a66:	1000                	addi	s0,sp,32
    80005a68:	fea43423          	sd	a0,-24(s0)
    80005a6c:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80005a70:	4639                	li	a2,14
    80005a72:	fe043583          	ld	a1,-32(s0)
    80005a76:	fe843503          	ld	a0,-24(s0)
    80005a7a:	ffffc097          	auipc	ra,0xffffc
    80005a7e:	c7c080e7          	jalr	-900(ra) # 800016f6 <strncmp>
    80005a82:	87aa                	mv	a5,a0
}
    80005a84:	853e                	mv	a0,a5
    80005a86:	60e2                	ld	ra,24(sp)
    80005a88:	6442                	ld	s0,16(sp)
    80005a8a:	6105                	addi	sp,sp,32
    80005a8c:	8082                	ret

0000000080005a8e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80005a8e:	715d                	addi	sp,sp,-80
    80005a90:	e486                	sd	ra,72(sp)
    80005a92:	e0a2                	sd	s0,64(sp)
    80005a94:	0880                	addi	s0,sp,80
    80005a96:	fca43423          	sd	a0,-56(s0)
    80005a9a:	fcb43023          	sd	a1,-64(s0)
    80005a9e:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80005aa2:	fc843783          	ld	a5,-56(s0)
    80005aa6:	04479783          	lh	a5,68(a5)
    80005aaa:	0007871b          	sext.w	a4,a5
    80005aae:	4785                	li	a5,1
    80005ab0:	00f70a63          	beq	a4,a5,80005ac4 <dirlookup+0x36>
    panic("dirlookup not DIR");
    80005ab4:	00006517          	auipc	a0,0x6
    80005ab8:	a6c50513          	addi	a0,a0,-1428 # 8000b520 <etext+0x520>
    80005abc:	ffffb097          	auipc	ra,0xffffb
    80005ac0:	1d0080e7          	jalr	464(ra) # 80000c8c <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    80005ac4:	fe042623          	sw	zero,-20(s0)
    80005ac8:	a849                	j	80005b5a <dirlookup+0xcc>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005aca:	fd840793          	addi	a5,s0,-40
    80005ace:	fec42683          	lw	a3,-20(s0)
    80005ad2:	4741                	li	a4,16
    80005ad4:	863e                	mv	a2,a5
    80005ad6:	4581                	li	a1,0
    80005ad8:	fc843503          	ld	a0,-56(s0)
    80005adc:	00000097          	auipc	ra,0x0
    80005ae0:	c38080e7          	jalr	-968(ra) # 80005714 <readi>
    80005ae4:	87aa                	mv	a5,a0
    80005ae6:	873e                	mv	a4,a5
    80005ae8:	47c1                	li	a5,16
    80005aea:	00f70a63          	beq	a4,a5,80005afe <dirlookup+0x70>
      panic("dirlookup read");
    80005aee:	00006517          	auipc	a0,0x6
    80005af2:	a4a50513          	addi	a0,a0,-1462 # 8000b538 <etext+0x538>
    80005af6:	ffffb097          	auipc	ra,0xffffb
    80005afa:	196080e7          	jalr	406(ra) # 80000c8c <panic>
    if(de.inum == 0)
    80005afe:	fd845783          	lhu	a5,-40(s0)
    80005b02:	c7b1                	beqz	a5,80005b4e <dirlookup+0xc0>
      continue;
    if(namecmp(name, de.name) == 0){
    80005b04:	fd840793          	addi	a5,s0,-40
    80005b08:	0789                	addi	a5,a5,2
    80005b0a:	85be                	mv	a1,a5
    80005b0c:	fc043503          	ld	a0,-64(s0)
    80005b10:	00000097          	auipc	ra,0x0
    80005b14:	f50080e7          	jalr	-176(ra) # 80005a60 <namecmp>
    80005b18:	87aa                	mv	a5,a0
    80005b1a:	eb9d                	bnez	a5,80005b50 <dirlookup+0xc2>
      // entry matches path element
      if(poff)
    80005b1c:	fb843783          	ld	a5,-72(s0)
    80005b20:	c791                	beqz	a5,80005b2c <dirlookup+0x9e>
        *poff = off;
    80005b22:	fb843783          	ld	a5,-72(s0)
    80005b26:	fec42703          	lw	a4,-20(s0)
    80005b2a:	c398                	sw	a4,0(a5)
      inum = de.inum;
    80005b2c:	fd845783          	lhu	a5,-40(s0)
    80005b30:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80005b34:	fc843783          	ld	a5,-56(s0)
    80005b38:	439c                	lw	a5,0(a5)
    80005b3a:	fe842703          	lw	a4,-24(s0)
    80005b3e:	85ba                	mv	a1,a4
    80005b40:	853e                	mv	a0,a5
    80005b42:	fffff097          	auipc	ra,0xfffff
    80005b46:	4b4080e7          	jalr	1204(ra) # 80004ff6 <iget>
    80005b4a:	87aa                	mv	a5,a0
    80005b4c:	a005                	j	80005b6c <dirlookup+0xde>
      continue;
    80005b4e:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005b50:	fec42783          	lw	a5,-20(s0)
    80005b54:	27c1                	addiw	a5,a5,16
    80005b56:	fef42623          	sw	a5,-20(s0)
    80005b5a:	fc843783          	ld	a5,-56(s0)
    80005b5e:	47f8                	lw	a4,76(a5)
    80005b60:	fec42783          	lw	a5,-20(s0)
    80005b64:	2781                	sext.w	a5,a5
    80005b66:	f6e7e2e3          	bltu	a5,a4,80005aca <dirlookup+0x3c>
    }
  }

  return 0;
    80005b6a:	4781                	li	a5,0
}
    80005b6c:	853e                	mv	a0,a5
    80005b6e:	60a6                	ld	ra,72(sp)
    80005b70:	6406                	ld	s0,64(sp)
    80005b72:	6161                	addi	sp,sp,80
    80005b74:	8082                	ret

0000000080005b76 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
// Returns 0 on success, -1 on failure (e.g. out of disk blocks).
int
dirlink(struct inode *dp, char *name, uint inum)
{
    80005b76:	715d                	addi	sp,sp,-80
    80005b78:	e486                	sd	ra,72(sp)
    80005b7a:	e0a2                	sd	s0,64(sp)
    80005b7c:	0880                	addi	s0,sp,80
    80005b7e:	fca43423          	sd	a0,-56(s0)
    80005b82:	fcb43023          	sd	a1,-64(s0)
    80005b86:	87b2                	mv	a5,a2
    80005b88:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    80005b8c:	4601                	li	a2,0
    80005b8e:	fc043583          	ld	a1,-64(s0)
    80005b92:	fc843503          	ld	a0,-56(s0)
    80005b96:	00000097          	auipc	ra,0x0
    80005b9a:	ef8080e7          	jalr	-264(ra) # 80005a8e <dirlookup>
    80005b9e:	fea43023          	sd	a0,-32(s0)
    80005ba2:	fe043783          	ld	a5,-32(s0)
    80005ba6:	cb89                	beqz	a5,80005bb8 <dirlink+0x42>
    iput(ip);
    80005ba8:	fe043503          	ld	a0,-32(s0)
    80005bac:	fffff097          	auipc	ra,0xfffff
    80005bb0:	740080e7          	jalr	1856(ra) # 800052ec <iput>
    return -1;
    80005bb4:	57fd                	li	a5,-1
    80005bb6:	a075                	j	80005c62 <dirlink+0xec>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005bb8:	fe042623          	sw	zero,-20(s0)
    80005bbc:	a0a1                	j	80005c04 <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005bbe:	fd040793          	addi	a5,s0,-48
    80005bc2:	fec42683          	lw	a3,-20(s0)
    80005bc6:	4741                	li	a4,16
    80005bc8:	863e                	mv	a2,a5
    80005bca:	4581                	li	a1,0
    80005bcc:	fc843503          	ld	a0,-56(s0)
    80005bd0:	00000097          	auipc	ra,0x0
    80005bd4:	b44080e7          	jalr	-1212(ra) # 80005714 <readi>
    80005bd8:	87aa                	mv	a5,a0
    80005bda:	873e                	mv	a4,a5
    80005bdc:	47c1                	li	a5,16
    80005bde:	00f70a63          	beq	a4,a5,80005bf2 <dirlink+0x7c>
      panic("dirlink read");
    80005be2:	00006517          	auipc	a0,0x6
    80005be6:	96650513          	addi	a0,a0,-1690 # 8000b548 <etext+0x548>
    80005bea:	ffffb097          	auipc	ra,0xffffb
    80005bee:	0a2080e7          	jalr	162(ra) # 80000c8c <panic>
    if(de.inum == 0)
    80005bf2:	fd045783          	lhu	a5,-48(s0)
    80005bf6:	cf99                	beqz	a5,80005c14 <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005bf8:	fec42783          	lw	a5,-20(s0)
    80005bfc:	27c1                	addiw	a5,a5,16
    80005bfe:	2781                	sext.w	a5,a5
    80005c00:	fef42623          	sw	a5,-20(s0)
    80005c04:	fc843783          	ld	a5,-56(s0)
    80005c08:	47f8                	lw	a4,76(a5)
    80005c0a:	fec42783          	lw	a5,-20(s0)
    80005c0e:	fae7e8e3          	bltu	a5,a4,80005bbe <dirlink+0x48>
    80005c12:	a011                	j	80005c16 <dirlink+0xa0>
      break;
    80005c14:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    80005c16:	fd040793          	addi	a5,s0,-48
    80005c1a:	0789                	addi	a5,a5,2
    80005c1c:	4639                	li	a2,14
    80005c1e:	fc043583          	ld	a1,-64(s0)
    80005c22:	853e                	mv	a0,a5
    80005c24:	ffffc097          	auipc	ra,0xffffc
    80005c28:	b5c080e7          	jalr	-1188(ra) # 80001780 <strncpy>
  de.inum = inum;
    80005c2c:	fbc42783          	lw	a5,-68(s0)
    80005c30:	17c2                	slli	a5,a5,0x30
    80005c32:	93c1                	srli	a5,a5,0x30
    80005c34:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005c38:	fd040793          	addi	a5,s0,-48
    80005c3c:	fec42683          	lw	a3,-20(s0)
    80005c40:	4741                	li	a4,16
    80005c42:	863e                	mv	a2,a5
    80005c44:	4581                	li	a1,0
    80005c46:	fc843503          	ld	a0,-56(s0)
    80005c4a:	00000097          	auipc	ra,0x0
    80005c4e:	c62080e7          	jalr	-926(ra) # 800058ac <writei>
    80005c52:	87aa                	mv	a5,a0
    80005c54:	873e                	mv	a4,a5
    80005c56:	47c1                	li	a5,16
    80005c58:	00f70463          	beq	a4,a5,80005c60 <dirlink+0xea>
    return -1;
    80005c5c:	57fd                	li	a5,-1
    80005c5e:	a011                	j	80005c62 <dirlink+0xec>

  return 0;
    80005c60:	4781                	li	a5,0
}
    80005c62:	853e                	mv	a0,a5
    80005c64:	60a6                	ld	ra,72(sp)
    80005c66:	6406                	ld	s0,64(sp)
    80005c68:	6161                	addi	sp,sp,80
    80005c6a:	8082                	ret

0000000080005c6c <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    80005c6c:	7179                	addi	sp,sp,-48
    80005c6e:	f406                	sd	ra,40(sp)
    80005c70:	f022                	sd	s0,32(sp)
    80005c72:	1800                	addi	s0,sp,48
    80005c74:	fca43c23          	sd	a0,-40(s0)
    80005c78:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    80005c7c:	a031                	j	80005c88 <skipelem+0x1c>
    path++;
    80005c7e:	fd843783          	ld	a5,-40(s0)
    80005c82:	0785                	addi	a5,a5,1
    80005c84:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005c88:	fd843783          	ld	a5,-40(s0)
    80005c8c:	0007c783          	lbu	a5,0(a5)
    80005c90:	873e                	mv	a4,a5
    80005c92:	02f00793          	li	a5,47
    80005c96:	fef704e3          	beq	a4,a5,80005c7e <skipelem+0x12>
  if(*path == 0)
    80005c9a:	fd843783          	ld	a5,-40(s0)
    80005c9e:	0007c783          	lbu	a5,0(a5)
    80005ca2:	e399                	bnez	a5,80005ca8 <skipelem+0x3c>
    return 0;
    80005ca4:	4781                	li	a5,0
    80005ca6:	a06d                	j	80005d50 <skipelem+0xe4>
  s = path;
    80005ca8:	fd843783          	ld	a5,-40(s0)
    80005cac:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80005cb0:	a031                	j	80005cbc <skipelem+0x50>
    path++;
    80005cb2:	fd843783          	ld	a5,-40(s0)
    80005cb6:	0785                	addi	a5,a5,1
    80005cb8:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    80005cbc:	fd843783          	ld	a5,-40(s0)
    80005cc0:	0007c783          	lbu	a5,0(a5)
    80005cc4:	873e                	mv	a4,a5
    80005cc6:	02f00793          	li	a5,47
    80005cca:	00f70763          	beq	a4,a5,80005cd8 <skipelem+0x6c>
    80005cce:	fd843783          	ld	a5,-40(s0)
    80005cd2:	0007c783          	lbu	a5,0(a5)
    80005cd6:	fff1                	bnez	a5,80005cb2 <skipelem+0x46>
  len = path - s;
    80005cd8:	fd843703          	ld	a4,-40(s0)
    80005cdc:	fe843783          	ld	a5,-24(s0)
    80005ce0:	40f707b3          	sub	a5,a4,a5
    80005ce4:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80005ce8:	fe442783          	lw	a5,-28(s0)
    80005cec:	0007871b          	sext.w	a4,a5
    80005cf0:	47b5                	li	a5,13
    80005cf2:	00e7dc63          	bge	a5,a4,80005d0a <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80005cf6:	4639                	li	a2,14
    80005cf8:	fe843583          	ld	a1,-24(s0)
    80005cfc:	fd043503          	ld	a0,-48(s0)
    80005d00:	ffffc097          	auipc	ra,0xffffc
    80005d04:	8e2080e7          	jalr	-1822(ra) # 800015e2 <memmove>
    80005d08:	a80d                	j	80005d3a <skipelem+0xce>
  else {
    memmove(name, s, len);
    80005d0a:	fe442783          	lw	a5,-28(s0)
    80005d0e:	863e                	mv	a2,a5
    80005d10:	fe843583          	ld	a1,-24(s0)
    80005d14:	fd043503          	ld	a0,-48(s0)
    80005d18:	ffffc097          	auipc	ra,0xffffc
    80005d1c:	8ca080e7          	jalr	-1846(ra) # 800015e2 <memmove>
    name[len] = 0;
    80005d20:	fe442783          	lw	a5,-28(s0)
    80005d24:	fd043703          	ld	a4,-48(s0)
    80005d28:	97ba                	add	a5,a5,a4
    80005d2a:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    80005d2e:	a031                	j	80005d3a <skipelem+0xce>
    path++;
    80005d30:	fd843783          	ld	a5,-40(s0)
    80005d34:	0785                	addi	a5,a5,1
    80005d36:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005d3a:	fd843783          	ld	a5,-40(s0)
    80005d3e:	0007c783          	lbu	a5,0(a5)
    80005d42:	873e                	mv	a4,a5
    80005d44:	02f00793          	li	a5,47
    80005d48:	fef704e3          	beq	a4,a5,80005d30 <skipelem+0xc4>
  return path;
    80005d4c:	fd843783          	ld	a5,-40(s0)
}
    80005d50:	853e                	mv	a0,a5
    80005d52:	70a2                	ld	ra,40(sp)
    80005d54:	7402                	ld	s0,32(sp)
    80005d56:	6145                	addi	sp,sp,48
    80005d58:	8082                	ret

0000000080005d5a <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80005d5a:	7139                	addi	sp,sp,-64
    80005d5c:	fc06                	sd	ra,56(sp)
    80005d5e:	f822                	sd	s0,48(sp)
    80005d60:	0080                	addi	s0,sp,64
    80005d62:	fca43c23          	sd	a0,-40(s0)
    80005d66:	87ae                	mv	a5,a1
    80005d68:	fcc43423          	sd	a2,-56(s0)
    80005d6c:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80005d70:	fd843783          	ld	a5,-40(s0)
    80005d74:	0007c783          	lbu	a5,0(a5)
    80005d78:	873e                	mv	a4,a5
    80005d7a:	02f00793          	li	a5,47
    80005d7e:	00f71b63          	bne	a4,a5,80005d94 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80005d82:	4585                	li	a1,1
    80005d84:	4505                	li	a0,1
    80005d86:	fffff097          	auipc	ra,0xfffff
    80005d8a:	270080e7          	jalr	624(ra) # 80004ff6 <iget>
    80005d8e:	fea43423          	sd	a0,-24(s0)
    80005d92:	a84d                	j	80005e44 <namex+0xea>
  else
    ip = idup(myproc()->cwd);
    80005d94:	ffffd097          	auipc	ra,0xffffd
    80005d98:	b84080e7          	jalr	-1148(ra) # 80002918 <myproc>
    80005d9c:	87aa                	mv	a5,a0
    80005d9e:	1507b783          	ld	a5,336(a5)
    80005da2:	853e                	mv	a0,a5
    80005da4:	fffff097          	auipc	ra,0xfffff
    80005da8:	36e080e7          	jalr	878(ra) # 80005112 <idup>
    80005dac:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80005db0:	a851                	j	80005e44 <namex+0xea>
    ilock(ip);
    80005db2:	fe843503          	ld	a0,-24(s0)
    80005db6:	fffff097          	auipc	ra,0xfffff
    80005dba:	3a8080e7          	jalr	936(ra) # 8000515e <ilock>
    if(ip->type != T_DIR){
    80005dbe:	fe843783          	ld	a5,-24(s0)
    80005dc2:	04479783          	lh	a5,68(a5)
    80005dc6:	0007871b          	sext.w	a4,a5
    80005dca:	4785                	li	a5,1
    80005dcc:	00f70a63          	beq	a4,a5,80005de0 <namex+0x86>
      iunlockput(ip);
    80005dd0:	fe843503          	ld	a0,-24(s0)
    80005dd4:	fffff097          	auipc	ra,0xfffff
    80005dd8:	5e8080e7          	jalr	1512(ra) # 800053bc <iunlockput>
      return 0;
    80005ddc:	4781                	li	a5,0
    80005dde:	a871                	j	80005e7a <namex+0x120>
    }
    if(nameiparent && *path == '\0'){
    80005de0:	fd442783          	lw	a5,-44(s0)
    80005de4:	2781                	sext.w	a5,a5
    80005de6:	cf99                	beqz	a5,80005e04 <namex+0xaa>
    80005de8:	fd843783          	ld	a5,-40(s0)
    80005dec:	0007c783          	lbu	a5,0(a5)
    80005df0:	eb91                	bnez	a5,80005e04 <namex+0xaa>
      // Stop one level early.
      iunlock(ip);
    80005df2:	fe843503          	ld	a0,-24(s0)
    80005df6:	fffff097          	auipc	ra,0xfffff
    80005dfa:	49c080e7          	jalr	1180(ra) # 80005292 <iunlock>
      return ip;
    80005dfe:	fe843783          	ld	a5,-24(s0)
    80005e02:	a8a5                	j	80005e7a <namex+0x120>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80005e04:	4601                	li	a2,0
    80005e06:	fc843583          	ld	a1,-56(s0)
    80005e0a:	fe843503          	ld	a0,-24(s0)
    80005e0e:	00000097          	auipc	ra,0x0
    80005e12:	c80080e7          	jalr	-896(ra) # 80005a8e <dirlookup>
    80005e16:	fea43023          	sd	a0,-32(s0)
    80005e1a:	fe043783          	ld	a5,-32(s0)
    80005e1e:	eb89                	bnez	a5,80005e30 <namex+0xd6>
      iunlockput(ip);
    80005e20:	fe843503          	ld	a0,-24(s0)
    80005e24:	fffff097          	auipc	ra,0xfffff
    80005e28:	598080e7          	jalr	1432(ra) # 800053bc <iunlockput>
      return 0;
    80005e2c:	4781                	li	a5,0
    80005e2e:	a0b1                	j	80005e7a <namex+0x120>
    }
    iunlockput(ip);
    80005e30:	fe843503          	ld	a0,-24(s0)
    80005e34:	fffff097          	auipc	ra,0xfffff
    80005e38:	588080e7          	jalr	1416(ra) # 800053bc <iunlockput>
    ip = next;
    80005e3c:	fe043783          	ld	a5,-32(s0)
    80005e40:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    80005e44:	fc843583          	ld	a1,-56(s0)
    80005e48:	fd843503          	ld	a0,-40(s0)
    80005e4c:	00000097          	auipc	ra,0x0
    80005e50:	e20080e7          	jalr	-480(ra) # 80005c6c <skipelem>
    80005e54:	fca43c23          	sd	a0,-40(s0)
    80005e58:	fd843783          	ld	a5,-40(s0)
    80005e5c:	fbb9                	bnez	a5,80005db2 <namex+0x58>
  }
  if(nameiparent){
    80005e5e:	fd442783          	lw	a5,-44(s0)
    80005e62:	2781                	sext.w	a5,a5
    80005e64:	cb89                	beqz	a5,80005e76 <namex+0x11c>
    iput(ip);
    80005e66:	fe843503          	ld	a0,-24(s0)
    80005e6a:	fffff097          	auipc	ra,0xfffff
    80005e6e:	482080e7          	jalr	1154(ra) # 800052ec <iput>
    return 0;
    80005e72:	4781                	li	a5,0
    80005e74:	a019                	j	80005e7a <namex+0x120>
  }
  return ip;
    80005e76:	fe843783          	ld	a5,-24(s0)
}
    80005e7a:	853e                	mv	a0,a5
    80005e7c:	70e2                	ld	ra,56(sp)
    80005e7e:	7442                	ld	s0,48(sp)
    80005e80:	6121                	addi	sp,sp,64
    80005e82:	8082                	ret

0000000080005e84 <namei>:

struct inode*
namei(char *path)
{
    80005e84:	7179                	addi	sp,sp,-48
    80005e86:	f406                	sd	ra,40(sp)
    80005e88:	f022                	sd	s0,32(sp)
    80005e8a:	1800                	addi	s0,sp,48
    80005e8c:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80005e90:	fe040793          	addi	a5,s0,-32
    80005e94:	863e                	mv	a2,a5
    80005e96:	4581                	li	a1,0
    80005e98:	fd843503          	ld	a0,-40(s0)
    80005e9c:	00000097          	auipc	ra,0x0
    80005ea0:	ebe080e7          	jalr	-322(ra) # 80005d5a <namex>
    80005ea4:	87aa                	mv	a5,a0
}
    80005ea6:	853e                	mv	a0,a5
    80005ea8:	70a2                	ld	ra,40(sp)
    80005eaa:	7402                	ld	s0,32(sp)
    80005eac:	6145                	addi	sp,sp,48
    80005eae:	8082                	ret

0000000080005eb0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80005eb0:	1101                	addi	sp,sp,-32
    80005eb2:	ec06                	sd	ra,24(sp)
    80005eb4:	e822                	sd	s0,16(sp)
    80005eb6:	1000                	addi	s0,sp,32
    80005eb8:	fea43423          	sd	a0,-24(s0)
    80005ebc:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80005ec0:	fe043603          	ld	a2,-32(s0)
    80005ec4:	4585                	li	a1,1
    80005ec6:	fe843503          	ld	a0,-24(s0)
    80005eca:	00000097          	auipc	ra,0x0
    80005ece:	e90080e7          	jalr	-368(ra) # 80005d5a <namex>
    80005ed2:	87aa                	mv	a5,a0
}
    80005ed4:	853e                	mv	a0,a5
    80005ed6:	60e2                	ld	ra,24(sp)
    80005ed8:	6442                	ld	s0,16(sp)
    80005eda:	6105                	addi	sp,sp,32
    80005edc:	8082                	ret

0000000080005ede <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80005ede:	1101                	addi	sp,sp,-32
    80005ee0:	ec06                	sd	ra,24(sp)
    80005ee2:	e822                	sd	s0,16(sp)
    80005ee4:	1000                	addi	s0,sp,32
    80005ee6:	87aa                	mv	a5,a0
    80005ee8:	feb43023          	sd	a1,-32(s0)
    80005eec:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80005ef0:	00005597          	auipc	a1,0x5
    80005ef4:	66858593          	addi	a1,a1,1640 # 8000b558 <etext+0x558>
    80005ef8:	0001e517          	auipc	a0,0x1e
    80005efc:	c9050513          	addi	a0,a0,-880 # 80023b88 <log>
    80005f00:	ffffb097          	auipc	ra,0xffffb
    80005f04:	3fa080e7          	jalr	1018(ra) # 800012fa <initlock>
  log.start = sb->logstart;
    80005f08:	fe043783          	ld	a5,-32(s0)
    80005f0c:	4bdc                	lw	a5,20(a5)
    80005f0e:	0007871b          	sext.w	a4,a5
    80005f12:	0001e797          	auipc	a5,0x1e
    80005f16:	c7678793          	addi	a5,a5,-906 # 80023b88 <log>
    80005f1a:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    80005f1c:	fe043783          	ld	a5,-32(s0)
    80005f20:	4b9c                	lw	a5,16(a5)
    80005f22:	0007871b          	sext.w	a4,a5
    80005f26:	0001e797          	auipc	a5,0x1e
    80005f2a:	c6278793          	addi	a5,a5,-926 # 80023b88 <log>
    80005f2e:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    80005f30:	0001e797          	auipc	a5,0x1e
    80005f34:	c5878793          	addi	a5,a5,-936 # 80023b88 <log>
    80005f38:	fec42703          	lw	a4,-20(s0)
    80005f3c:	d798                	sw	a4,40(a5)
  recover_from_log();
    80005f3e:	00000097          	auipc	ra,0x0
    80005f42:	272080e7          	jalr	626(ra) # 800061b0 <recover_from_log>
}
    80005f46:	0001                	nop
    80005f48:	60e2                	ld	ra,24(sp)
    80005f4a:	6442                	ld	s0,16(sp)
    80005f4c:	6105                	addi	sp,sp,32
    80005f4e:	8082                	ret

0000000080005f50 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80005f50:	7139                	addi	sp,sp,-64
    80005f52:	fc06                	sd	ra,56(sp)
    80005f54:	f822                	sd	s0,48(sp)
    80005f56:	0080                	addi	s0,sp,64
    80005f58:	87aa                	mv	a5,a0
    80005f5a:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80005f5e:	fe042623          	sw	zero,-20(s0)
    80005f62:	a0f9                	j	80006030 <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80005f64:	0001e797          	auipc	a5,0x1e
    80005f68:	c2478793          	addi	a5,a5,-988 # 80023b88 <log>
    80005f6c:	579c                	lw	a5,40(a5)
    80005f6e:	0007869b          	sext.w	a3,a5
    80005f72:	0001e797          	auipc	a5,0x1e
    80005f76:	c1678793          	addi	a5,a5,-1002 # 80023b88 <log>
    80005f7a:	4f9c                	lw	a5,24(a5)
    80005f7c:	fec42703          	lw	a4,-20(s0)
    80005f80:	9fb9                	addw	a5,a5,a4
    80005f82:	2781                	sext.w	a5,a5
    80005f84:	2785                	addiw	a5,a5,1
    80005f86:	2781                	sext.w	a5,a5
    80005f88:	2781                	sext.w	a5,a5
    80005f8a:	85be                	mv	a1,a5
    80005f8c:	8536                	mv	a0,a3
    80005f8e:	ffffe097          	auipc	ra,0xffffe
    80005f92:	7dc080e7          	jalr	2012(ra) # 8000476a <bread>
    80005f96:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80005f9a:	0001e797          	auipc	a5,0x1e
    80005f9e:	bee78793          	addi	a5,a5,-1042 # 80023b88 <log>
    80005fa2:	579c                	lw	a5,40(a5)
    80005fa4:	0007869b          	sext.w	a3,a5
    80005fa8:	0001e717          	auipc	a4,0x1e
    80005fac:	be070713          	addi	a4,a4,-1056 # 80023b88 <log>
    80005fb0:	fec42783          	lw	a5,-20(s0)
    80005fb4:	07a1                	addi	a5,a5,8
    80005fb6:	078a                	slli	a5,a5,0x2
    80005fb8:	97ba                	add	a5,a5,a4
    80005fba:	4b9c                	lw	a5,16(a5)
    80005fbc:	2781                	sext.w	a5,a5
    80005fbe:	85be                	mv	a1,a5
    80005fc0:	8536                	mv	a0,a3
    80005fc2:	ffffe097          	auipc	ra,0xffffe
    80005fc6:	7a8080e7          	jalr	1960(ra) # 8000476a <bread>
    80005fca:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80005fce:	fd843783          	ld	a5,-40(s0)
    80005fd2:	05878713          	addi	a4,a5,88
    80005fd6:	fe043783          	ld	a5,-32(s0)
    80005fda:	05878793          	addi	a5,a5,88
    80005fde:	40000613          	li	a2,1024
    80005fe2:	85be                	mv	a1,a5
    80005fe4:	853a                	mv	a0,a4
    80005fe6:	ffffb097          	auipc	ra,0xffffb
    80005fea:	5fc080e7          	jalr	1532(ra) # 800015e2 <memmove>
    bwrite(dbuf);  // write dst to disk
    80005fee:	fd843503          	ld	a0,-40(s0)
    80005ff2:	ffffe097          	auipc	ra,0xffffe
    80005ff6:	7d6080e7          	jalr	2006(ra) # 800047c8 <bwrite>
    if(recovering == 0)
    80005ffa:	fcc42783          	lw	a5,-52(s0)
    80005ffe:	2781                	sext.w	a5,a5
    80006000:	e799                	bnez	a5,8000600e <install_trans+0xbe>
      bunpin(dbuf);
    80006002:	fd843503          	ld	a0,-40(s0)
    80006006:	fffff097          	auipc	ra,0xfffff
    8000600a:	944080e7          	jalr	-1724(ra) # 8000494a <bunpin>
    brelse(lbuf);
    8000600e:	fe043503          	ld	a0,-32(s0)
    80006012:	fffff097          	auipc	ra,0xfffff
    80006016:	802080e7          	jalr	-2046(ra) # 80004814 <brelse>
    brelse(dbuf);
    8000601a:	fd843503          	ld	a0,-40(s0)
    8000601e:	ffffe097          	auipc	ra,0xffffe
    80006022:	7f6080e7          	jalr	2038(ra) # 80004814 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006026:	fec42783          	lw	a5,-20(s0)
    8000602a:	2785                	addiw	a5,a5,1
    8000602c:	fef42623          	sw	a5,-20(s0)
    80006030:	0001e797          	auipc	a5,0x1e
    80006034:	b5878793          	addi	a5,a5,-1192 # 80023b88 <log>
    80006038:	57d8                	lw	a4,44(a5)
    8000603a:	fec42783          	lw	a5,-20(s0)
    8000603e:	2781                	sext.w	a5,a5
    80006040:	f2e7c2e3          	blt	a5,a4,80005f64 <install_trans+0x14>
  }
}
    80006044:	0001                	nop
    80006046:	0001                	nop
    80006048:	70e2                	ld	ra,56(sp)
    8000604a:	7442                	ld	s0,48(sp)
    8000604c:	6121                	addi	sp,sp,64
    8000604e:	8082                	ret

0000000080006050 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80006050:	7179                	addi	sp,sp,-48
    80006052:	f406                	sd	ra,40(sp)
    80006054:	f022                	sd	s0,32(sp)
    80006056:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006058:	0001e797          	auipc	a5,0x1e
    8000605c:	b3078793          	addi	a5,a5,-1232 # 80023b88 <log>
    80006060:	579c                	lw	a5,40(a5)
    80006062:	0007871b          	sext.w	a4,a5
    80006066:	0001e797          	auipc	a5,0x1e
    8000606a:	b2278793          	addi	a5,a5,-1246 # 80023b88 <log>
    8000606e:	4f9c                	lw	a5,24(a5)
    80006070:	2781                	sext.w	a5,a5
    80006072:	85be                	mv	a1,a5
    80006074:	853a                	mv	a0,a4
    80006076:	ffffe097          	auipc	ra,0xffffe
    8000607a:	6f4080e7          	jalr	1780(ra) # 8000476a <bread>
    8000607e:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80006082:	fe043783          	ld	a5,-32(s0)
    80006086:	05878793          	addi	a5,a5,88
    8000608a:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    8000608e:	fd843783          	ld	a5,-40(s0)
    80006092:	4398                	lw	a4,0(a5)
    80006094:	0001e797          	auipc	a5,0x1e
    80006098:	af478793          	addi	a5,a5,-1292 # 80023b88 <log>
    8000609c:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    8000609e:	fe042623          	sw	zero,-20(s0)
    800060a2:	a03d                	j	800060d0 <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    800060a4:	fd843703          	ld	a4,-40(s0)
    800060a8:	fec42783          	lw	a5,-20(s0)
    800060ac:	078a                	slli	a5,a5,0x2
    800060ae:	97ba                	add	a5,a5,a4
    800060b0:	43d8                	lw	a4,4(a5)
    800060b2:	0001e697          	auipc	a3,0x1e
    800060b6:	ad668693          	addi	a3,a3,-1322 # 80023b88 <log>
    800060ba:	fec42783          	lw	a5,-20(s0)
    800060be:	07a1                	addi	a5,a5,8
    800060c0:	078a                	slli	a5,a5,0x2
    800060c2:	97b6                	add	a5,a5,a3
    800060c4:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    800060c6:	fec42783          	lw	a5,-20(s0)
    800060ca:	2785                	addiw	a5,a5,1
    800060cc:	fef42623          	sw	a5,-20(s0)
    800060d0:	0001e797          	auipc	a5,0x1e
    800060d4:	ab878793          	addi	a5,a5,-1352 # 80023b88 <log>
    800060d8:	57d8                	lw	a4,44(a5)
    800060da:	fec42783          	lw	a5,-20(s0)
    800060de:	2781                	sext.w	a5,a5
    800060e0:	fce7c2e3          	blt	a5,a4,800060a4 <read_head+0x54>
  }
  brelse(buf);
    800060e4:	fe043503          	ld	a0,-32(s0)
    800060e8:	ffffe097          	auipc	ra,0xffffe
    800060ec:	72c080e7          	jalr	1836(ra) # 80004814 <brelse>
}
    800060f0:	0001                	nop
    800060f2:	70a2                	ld	ra,40(sp)
    800060f4:	7402                	ld	s0,32(sp)
    800060f6:	6145                	addi	sp,sp,48
    800060f8:	8082                	ret

00000000800060fa <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800060fa:	7179                	addi	sp,sp,-48
    800060fc:	f406                	sd	ra,40(sp)
    800060fe:	f022                	sd	s0,32(sp)
    80006100:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006102:	0001e797          	auipc	a5,0x1e
    80006106:	a8678793          	addi	a5,a5,-1402 # 80023b88 <log>
    8000610a:	579c                	lw	a5,40(a5)
    8000610c:	0007871b          	sext.w	a4,a5
    80006110:	0001e797          	auipc	a5,0x1e
    80006114:	a7878793          	addi	a5,a5,-1416 # 80023b88 <log>
    80006118:	4f9c                	lw	a5,24(a5)
    8000611a:	2781                	sext.w	a5,a5
    8000611c:	85be                	mv	a1,a5
    8000611e:	853a                	mv	a0,a4
    80006120:	ffffe097          	auipc	ra,0xffffe
    80006124:	64a080e7          	jalr	1610(ra) # 8000476a <bread>
    80006128:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    8000612c:	fe043783          	ld	a5,-32(s0)
    80006130:	05878793          	addi	a5,a5,88
    80006134:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80006138:	0001e797          	auipc	a5,0x1e
    8000613c:	a5078793          	addi	a5,a5,-1456 # 80023b88 <log>
    80006140:	57d8                	lw	a4,44(a5)
    80006142:	fd843783          	ld	a5,-40(s0)
    80006146:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006148:	fe042623          	sw	zero,-20(s0)
    8000614c:	a03d                	j	8000617a <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    8000614e:	0001e717          	auipc	a4,0x1e
    80006152:	a3a70713          	addi	a4,a4,-1478 # 80023b88 <log>
    80006156:	fec42783          	lw	a5,-20(s0)
    8000615a:	07a1                	addi	a5,a5,8
    8000615c:	078a                	slli	a5,a5,0x2
    8000615e:	97ba                	add	a5,a5,a4
    80006160:	4b98                	lw	a4,16(a5)
    80006162:	fd843683          	ld	a3,-40(s0)
    80006166:	fec42783          	lw	a5,-20(s0)
    8000616a:	078a                	slli	a5,a5,0x2
    8000616c:	97b6                	add	a5,a5,a3
    8000616e:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006170:	fec42783          	lw	a5,-20(s0)
    80006174:	2785                	addiw	a5,a5,1
    80006176:	fef42623          	sw	a5,-20(s0)
    8000617a:	0001e797          	auipc	a5,0x1e
    8000617e:	a0e78793          	addi	a5,a5,-1522 # 80023b88 <log>
    80006182:	57d8                	lw	a4,44(a5)
    80006184:	fec42783          	lw	a5,-20(s0)
    80006188:	2781                	sext.w	a5,a5
    8000618a:	fce7c2e3          	blt	a5,a4,8000614e <write_head+0x54>
  }
  bwrite(buf);
    8000618e:	fe043503          	ld	a0,-32(s0)
    80006192:	ffffe097          	auipc	ra,0xffffe
    80006196:	636080e7          	jalr	1590(ra) # 800047c8 <bwrite>
  brelse(buf);
    8000619a:	fe043503          	ld	a0,-32(s0)
    8000619e:	ffffe097          	auipc	ra,0xffffe
    800061a2:	676080e7          	jalr	1654(ra) # 80004814 <brelse>
}
    800061a6:	0001                	nop
    800061a8:	70a2                	ld	ra,40(sp)
    800061aa:	7402                	ld	s0,32(sp)
    800061ac:	6145                	addi	sp,sp,48
    800061ae:	8082                	ret

00000000800061b0 <recover_from_log>:

static void
recover_from_log(void)
{
    800061b0:	1141                	addi	sp,sp,-16
    800061b2:	e406                	sd	ra,8(sp)
    800061b4:	e022                	sd	s0,0(sp)
    800061b6:	0800                	addi	s0,sp,16
  read_head();
    800061b8:	00000097          	auipc	ra,0x0
    800061bc:	e98080e7          	jalr	-360(ra) # 80006050 <read_head>
  install_trans(1); // if committed, copy from log to disk
    800061c0:	4505                	li	a0,1
    800061c2:	00000097          	auipc	ra,0x0
    800061c6:	d8e080e7          	jalr	-626(ra) # 80005f50 <install_trans>
  log.lh.n = 0;
    800061ca:	0001e797          	auipc	a5,0x1e
    800061ce:	9be78793          	addi	a5,a5,-1602 # 80023b88 <log>
    800061d2:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    800061d6:	00000097          	auipc	ra,0x0
    800061da:	f24080e7          	jalr	-220(ra) # 800060fa <write_head>
}
    800061de:	0001                	nop
    800061e0:	60a2                	ld	ra,8(sp)
    800061e2:	6402                	ld	s0,0(sp)
    800061e4:	0141                	addi	sp,sp,16
    800061e6:	8082                	ret

00000000800061e8 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    800061e8:	1141                	addi	sp,sp,-16
    800061ea:	e406                	sd	ra,8(sp)
    800061ec:	e022                	sd	s0,0(sp)
    800061ee:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    800061f0:	0001e517          	auipc	a0,0x1e
    800061f4:	99850513          	addi	a0,a0,-1640 # 80023b88 <log>
    800061f8:	ffffb097          	auipc	ra,0xffffb
    800061fc:	132080e7          	jalr	306(ra) # 8000132a <acquire>
  while(1){
    if(log.committing){
    80006200:	0001e797          	auipc	a5,0x1e
    80006204:	98878793          	addi	a5,a5,-1656 # 80023b88 <log>
    80006208:	53dc                	lw	a5,36(a5)
    8000620a:	cf91                	beqz	a5,80006226 <begin_op+0x3e>
      sleep(&log, &log.lock);
    8000620c:	0001e597          	auipc	a1,0x1e
    80006210:	97c58593          	addi	a1,a1,-1668 # 80023b88 <log>
    80006214:	0001e517          	auipc	a0,0x1e
    80006218:	97450513          	addi	a0,a0,-1676 # 80023b88 <log>
    8000621c:	ffffd097          	auipc	ra,0xffffd
    80006220:	2be080e7          	jalr	702(ra) # 800034da <sleep>
    80006224:	bff1                	j	80006200 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80006226:	0001e797          	auipc	a5,0x1e
    8000622a:	96278793          	addi	a5,a5,-1694 # 80023b88 <log>
    8000622e:	57d8                	lw	a4,44(a5)
    80006230:	0001e797          	auipc	a5,0x1e
    80006234:	95878793          	addi	a5,a5,-1704 # 80023b88 <log>
    80006238:	539c                	lw	a5,32(a5)
    8000623a:	2785                	addiw	a5,a5,1
    8000623c:	2781                	sext.w	a5,a5
    8000623e:	86be                	mv	a3,a5
    80006240:	87b6                	mv	a5,a3
    80006242:	0027979b          	slliw	a5,a5,0x2
    80006246:	9fb5                	addw	a5,a5,a3
    80006248:	0017979b          	slliw	a5,a5,0x1
    8000624c:	2781                	sext.w	a5,a5
    8000624e:	9fb9                	addw	a5,a5,a4
    80006250:	2781                	sext.w	a5,a5
    80006252:	873e                	mv	a4,a5
    80006254:	47f9                	li	a5,30
    80006256:	00e7df63          	bge	a5,a4,80006274 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000625a:	0001e597          	auipc	a1,0x1e
    8000625e:	92e58593          	addi	a1,a1,-1746 # 80023b88 <log>
    80006262:	0001e517          	auipc	a0,0x1e
    80006266:	92650513          	addi	a0,a0,-1754 # 80023b88 <log>
    8000626a:	ffffd097          	auipc	ra,0xffffd
    8000626e:	270080e7          	jalr	624(ra) # 800034da <sleep>
    80006272:	b779                	j	80006200 <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80006274:	0001e797          	auipc	a5,0x1e
    80006278:	91478793          	addi	a5,a5,-1772 # 80023b88 <log>
    8000627c:	539c                	lw	a5,32(a5)
    8000627e:	2785                	addiw	a5,a5,1
    80006280:	0007871b          	sext.w	a4,a5
    80006284:	0001e797          	auipc	a5,0x1e
    80006288:	90478793          	addi	a5,a5,-1788 # 80023b88 <log>
    8000628c:	d398                	sw	a4,32(a5)
      release(&log.lock);
    8000628e:	0001e517          	auipc	a0,0x1e
    80006292:	8fa50513          	addi	a0,a0,-1798 # 80023b88 <log>
    80006296:	ffffb097          	auipc	ra,0xffffb
    8000629a:	0f8080e7          	jalr	248(ra) # 8000138e <release>
      break;
    8000629e:	0001                	nop
    }
  }
}
    800062a0:	0001                	nop
    800062a2:	60a2                	ld	ra,8(sp)
    800062a4:	6402                	ld	s0,0(sp)
    800062a6:	0141                	addi	sp,sp,16
    800062a8:	8082                	ret

00000000800062aa <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800062aa:	1101                	addi	sp,sp,-32
    800062ac:	ec06                	sd	ra,24(sp)
    800062ae:	e822                	sd	s0,16(sp)
    800062b0:	1000                	addi	s0,sp,32
  int do_commit = 0;
    800062b2:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    800062b6:	0001e517          	auipc	a0,0x1e
    800062ba:	8d250513          	addi	a0,a0,-1838 # 80023b88 <log>
    800062be:	ffffb097          	auipc	ra,0xffffb
    800062c2:	06c080e7          	jalr	108(ra) # 8000132a <acquire>
  log.outstanding -= 1;
    800062c6:	0001e797          	auipc	a5,0x1e
    800062ca:	8c278793          	addi	a5,a5,-1854 # 80023b88 <log>
    800062ce:	539c                	lw	a5,32(a5)
    800062d0:	37fd                	addiw	a5,a5,-1
    800062d2:	0007871b          	sext.w	a4,a5
    800062d6:	0001e797          	auipc	a5,0x1e
    800062da:	8b278793          	addi	a5,a5,-1870 # 80023b88 <log>
    800062de:	d398                	sw	a4,32(a5)
  if(log.committing)
    800062e0:	0001e797          	auipc	a5,0x1e
    800062e4:	8a878793          	addi	a5,a5,-1880 # 80023b88 <log>
    800062e8:	53dc                	lw	a5,36(a5)
    800062ea:	cb89                	beqz	a5,800062fc <end_op+0x52>
    panic("log.committing");
    800062ec:	00005517          	auipc	a0,0x5
    800062f0:	27450513          	addi	a0,a0,628 # 8000b560 <etext+0x560>
    800062f4:	ffffb097          	auipc	ra,0xffffb
    800062f8:	998080e7          	jalr	-1640(ra) # 80000c8c <panic>
  if(log.outstanding == 0){
    800062fc:	0001e797          	auipc	a5,0x1e
    80006300:	88c78793          	addi	a5,a5,-1908 # 80023b88 <log>
    80006304:	539c                	lw	a5,32(a5)
    80006306:	eb99                	bnez	a5,8000631c <end_op+0x72>
    do_commit = 1;
    80006308:	4785                	li	a5,1
    8000630a:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    8000630e:	0001e797          	auipc	a5,0x1e
    80006312:	87a78793          	addi	a5,a5,-1926 # 80023b88 <log>
    80006316:	4705                	li	a4,1
    80006318:	d3d8                	sw	a4,36(a5)
    8000631a:	a809                	j	8000632c <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    8000631c:	0001e517          	auipc	a0,0x1e
    80006320:	86c50513          	addi	a0,a0,-1940 # 80023b88 <log>
    80006324:	ffffd097          	auipc	ra,0xffffd
    80006328:	232080e7          	jalr	562(ra) # 80003556 <wakeup>
  }
  release(&log.lock);
    8000632c:	0001e517          	auipc	a0,0x1e
    80006330:	85c50513          	addi	a0,a0,-1956 # 80023b88 <log>
    80006334:	ffffb097          	auipc	ra,0xffffb
    80006338:	05a080e7          	jalr	90(ra) # 8000138e <release>

  if(do_commit){
    8000633c:	fec42783          	lw	a5,-20(s0)
    80006340:	2781                	sext.w	a5,a5
    80006342:	c3b9                	beqz	a5,80006388 <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80006344:	00000097          	auipc	ra,0x0
    80006348:	134080e7          	jalr	308(ra) # 80006478 <commit>
    acquire(&log.lock);
    8000634c:	0001e517          	auipc	a0,0x1e
    80006350:	83c50513          	addi	a0,a0,-1988 # 80023b88 <log>
    80006354:	ffffb097          	auipc	ra,0xffffb
    80006358:	fd6080e7          	jalr	-42(ra) # 8000132a <acquire>
    log.committing = 0;
    8000635c:	0001e797          	auipc	a5,0x1e
    80006360:	82c78793          	addi	a5,a5,-2004 # 80023b88 <log>
    80006364:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    80006368:	0001e517          	auipc	a0,0x1e
    8000636c:	82050513          	addi	a0,a0,-2016 # 80023b88 <log>
    80006370:	ffffd097          	auipc	ra,0xffffd
    80006374:	1e6080e7          	jalr	486(ra) # 80003556 <wakeup>
    release(&log.lock);
    80006378:	0001e517          	auipc	a0,0x1e
    8000637c:	81050513          	addi	a0,a0,-2032 # 80023b88 <log>
    80006380:	ffffb097          	auipc	ra,0xffffb
    80006384:	00e080e7          	jalr	14(ra) # 8000138e <release>
  }
}
    80006388:	0001                	nop
    8000638a:	60e2                	ld	ra,24(sp)
    8000638c:	6442                	ld	s0,16(sp)
    8000638e:	6105                	addi	sp,sp,32
    80006390:	8082                	ret

0000000080006392 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    80006392:	7179                	addi	sp,sp,-48
    80006394:	f406                	sd	ra,40(sp)
    80006396:	f022                	sd	s0,32(sp)
    80006398:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    8000639a:	fe042623          	sw	zero,-20(s0)
    8000639e:	a86d                	j	80006458 <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800063a0:	0001d797          	auipc	a5,0x1d
    800063a4:	7e878793          	addi	a5,a5,2024 # 80023b88 <log>
    800063a8:	579c                	lw	a5,40(a5)
    800063aa:	0007869b          	sext.w	a3,a5
    800063ae:	0001d797          	auipc	a5,0x1d
    800063b2:	7da78793          	addi	a5,a5,2010 # 80023b88 <log>
    800063b6:	4f9c                	lw	a5,24(a5)
    800063b8:	fec42703          	lw	a4,-20(s0)
    800063bc:	9fb9                	addw	a5,a5,a4
    800063be:	2781                	sext.w	a5,a5
    800063c0:	2785                	addiw	a5,a5,1
    800063c2:	2781                	sext.w	a5,a5
    800063c4:	2781                	sext.w	a5,a5
    800063c6:	85be                	mv	a1,a5
    800063c8:	8536                	mv	a0,a3
    800063ca:	ffffe097          	auipc	ra,0xffffe
    800063ce:	3a0080e7          	jalr	928(ra) # 8000476a <bread>
    800063d2:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800063d6:	0001d797          	auipc	a5,0x1d
    800063da:	7b278793          	addi	a5,a5,1970 # 80023b88 <log>
    800063de:	579c                	lw	a5,40(a5)
    800063e0:	0007869b          	sext.w	a3,a5
    800063e4:	0001d717          	auipc	a4,0x1d
    800063e8:	7a470713          	addi	a4,a4,1956 # 80023b88 <log>
    800063ec:	fec42783          	lw	a5,-20(s0)
    800063f0:	07a1                	addi	a5,a5,8
    800063f2:	078a                	slli	a5,a5,0x2
    800063f4:	97ba                	add	a5,a5,a4
    800063f6:	4b9c                	lw	a5,16(a5)
    800063f8:	2781                	sext.w	a5,a5
    800063fa:	85be                	mv	a1,a5
    800063fc:	8536                	mv	a0,a3
    800063fe:	ffffe097          	auipc	ra,0xffffe
    80006402:	36c080e7          	jalr	876(ra) # 8000476a <bread>
    80006406:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    8000640a:	fe043783          	ld	a5,-32(s0)
    8000640e:	05878713          	addi	a4,a5,88
    80006412:	fd843783          	ld	a5,-40(s0)
    80006416:	05878793          	addi	a5,a5,88
    8000641a:	40000613          	li	a2,1024
    8000641e:	85be                	mv	a1,a5
    80006420:	853a                	mv	a0,a4
    80006422:	ffffb097          	auipc	ra,0xffffb
    80006426:	1c0080e7          	jalr	448(ra) # 800015e2 <memmove>
    bwrite(to);  // write the log
    8000642a:	fe043503          	ld	a0,-32(s0)
    8000642e:	ffffe097          	auipc	ra,0xffffe
    80006432:	39a080e7          	jalr	922(ra) # 800047c8 <bwrite>
    brelse(from);
    80006436:	fd843503          	ld	a0,-40(s0)
    8000643a:	ffffe097          	auipc	ra,0xffffe
    8000643e:	3da080e7          	jalr	986(ra) # 80004814 <brelse>
    brelse(to);
    80006442:	fe043503          	ld	a0,-32(s0)
    80006446:	ffffe097          	auipc	ra,0xffffe
    8000644a:	3ce080e7          	jalr	974(ra) # 80004814 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000644e:	fec42783          	lw	a5,-20(s0)
    80006452:	2785                	addiw	a5,a5,1
    80006454:	fef42623          	sw	a5,-20(s0)
    80006458:	0001d797          	auipc	a5,0x1d
    8000645c:	73078793          	addi	a5,a5,1840 # 80023b88 <log>
    80006460:	57d8                	lw	a4,44(a5)
    80006462:	fec42783          	lw	a5,-20(s0)
    80006466:	2781                	sext.w	a5,a5
    80006468:	f2e7cce3          	blt	a5,a4,800063a0 <write_log+0xe>
  }
}
    8000646c:	0001                	nop
    8000646e:	0001                	nop
    80006470:	70a2                	ld	ra,40(sp)
    80006472:	7402                	ld	s0,32(sp)
    80006474:	6145                	addi	sp,sp,48
    80006476:	8082                	ret

0000000080006478 <commit>:

static void
commit()
{
    80006478:	1141                	addi	sp,sp,-16
    8000647a:	e406                	sd	ra,8(sp)
    8000647c:	e022                	sd	s0,0(sp)
    8000647e:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006480:	0001d797          	auipc	a5,0x1d
    80006484:	70878793          	addi	a5,a5,1800 # 80023b88 <log>
    80006488:	57dc                	lw	a5,44(a5)
    8000648a:	02f05963          	blez	a5,800064bc <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    8000648e:	00000097          	auipc	ra,0x0
    80006492:	f04080e7          	jalr	-252(ra) # 80006392 <write_log>
    write_head();    // Write header to disk -- the real commit
    80006496:	00000097          	auipc	ra,0x0
    8000649a:	c64080e7          	jalr	-924(ra) # 800060fa <write_head>
    install_trans(0); // Now install writes to home locations
    8000649e:	4501                	li	a0,0
    800064a0:	00000097          	auipc	ra,0x0
    800064a4:	ab0080e7          	jalr	-1360(ra) # 80005f50 <install_trans>
    log.lh.n = 0;
    800064a8:	0001d797          	auipc	a5,0x1d
    800064ac:	6e078793          	addi	a5,a5,1760 # 80023b88 <log>
    800064b0:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    800064b4:	00000097          	auipc	ra,0x0
    800064b8:	c46080e7          	jalr	-954(ra) # 800060fa <write_head>
  }
}
    800064bc:	0001                	nop
    800064be:	60a2                	ld	ra,8(sp)
    800064c0:	6402                	ld	s0,0(sp)
    800064c2:	0141                	addi	sp,sp,16
    800064c4:	8082                	ret

00000000800064c6 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800064c6:	7179                	addi	sp,sp,-48
    800064c8:	f406                	sd	ra,40(sp)
    800064ca:	f022                	sd	s0,32(sp)
    800064cc:	1800                	addi	s0,sp,48
    800064ce:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    800064d2:	0001d517          	auipc	a0,0x1d
    800064d6:	6b650513          	addi	a0,a0,1718 # 80023b88 <log>
    800064da:	ffffb097          	auipc	ra,0xffffb
    800064de:	e50080e7          	jalr	-432(ra) # 8000132a <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800064e2:	0001d797          	auipc	a5,0x1d
    800064e6:	6a678793          	addi	a5,a5,1702 # 80023b88 <log>
    800064ea:	57dc                	lw	a5,44(a5)
    800064ec:	873e                	mv	a4,a5
    800064ee:	47f5                	li	a5,29
    800064f0:	02e7c063          	blt	a5,a4,80006510 <log_write+0x4a>
    800064f4:	0001d797          	auipc	a5,0x1d
    800064f8:	69478793          	addi	a5,a5,1684 # 80023b88 <log>
    800064fc:	57d8                	lw	a4,44(a5)
    800064fe:	0001d797          	auipc	a5,0x1d
    80006502:	68a78793          	addi	a5,a5,1674 # 80023b88 <log>
    80006506:	4fdc                	lw	a5,28(a5)
    80006508:	37fd                	addiw	a5,a5,-1
    8000650a:	2781                	sext.w	a5,a5
    8000650c:	00f74a63          	blt	a4,a5,80006520 <log_write+0x5a>
    panic("too big a transaction");
    80006510:	00005517          	auipc	a0,0x5
    80006514:	06050513          	addi	a0,a0,96 # 8000b570 <etext+0x570>
    80006518:	ffffa097          	auipc	ra,0xffffa
    8000651c:	774080e7          	jalr	1908(ra) # 80000c8c <panic>
  if (log.outstanding < 1)
    80006520:	0001d797          	auipc	a5,0x1d
    80006524:	66878793          	addi	a5,a5,1640 # 80023b88 <log>
    80006528:	539c                	lw	a5,32(a5)
    8000652a:	00f04a63          	bgtz	a5,8000653e <log_write+0x78>
    panic("log_write outside of trans");
    8000652e:	00005517          	auipc	a0,0x5
    80006532:	05a50513          	addi	a0,a0,90 # 8000b588 <etext+0x588>
    80006536:	ffffa097          	auipc	ra,0xffffa
    8000653a:	756080e7          	jalr	1878(ra) # 80000c8c <panic>

  for (i = 0; i < log.lh.n; i++) {
    8000653e:	fe042623          	sw	zero,-20(s0)
    80006542:	a03d                	j	80006570 <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80006544:	0001d717          	auipc	a4,0x1d
    80006548:	64470713          	addi	a4,a4,1604 # 80023b88 <log>
    8000654c:	fec42783          	lw	a5,-20(s0)
    80006550:	07a1                	addi	a5,a5,8
    80006552:	078a                	slli	a5,a5,0x2
    80006554:	97ba                	add	a5,a5,a4
    80006556:	4b9c                	lw	a5,16(a5)
    80006558:	0007871b          	sext.w	a4,a5
    8000655c:	fd843783          	ld	a5,-40(s0)
    80006560:	47dc                	lw	a5,12(a5)
    80006562:	02f70263          	beq	a4,a5,80006586 <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    80006566:	fec42783          	lw	a5,-20(s0)
    8000656a:	2785                	addiw	a5,a5,1
    8000656c:	fef42623          	sw	a5,-20(s0)
    80006570:	0001d797          	auipc	a5,0x1d
    80006574:	61878793          	addi	a5,a5,1560 # 80023b88 <log>
    80006578:	57d8                	lw	a4,44(a5)
    8000657a:	fec42783          	lw	a5,-20(s0)
    8000657e:	2781                	sext.w	a5,a5
    80006580:	fce7c2e3          	blt	a5,a4,80006544 <log_write+0x7e>
    80006584:	a011                	j	80006588 <log_write+0xc2>
      break;
    80006586:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80006588:	fd843783          	ld	a5,-40(s0)
    8000658c:	47dc                	lw	a5,12(a5)
    8000658e:	0007871b          	sext.w	a4,a5
    80006592:	0001d697          	auipc	a3,0x1d
    80006596:	5f668693          	addi	a3,a3,1526 # 80023b88 <log>
    8000659a:	fec42783          	lw	a5,-20(s0)
    8000659e:	07a1                	addi	a5,a5,8
    800065a0:	078a                	slli	a5,a5,0x2
    800065a2:	97b6                	add	a5,a5,a3
    800065a4:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    800065a6:	0001d797          	auipc	a5,0x1d
    800065aa:	5e278793          	addi	a5,a5,1506 # 80023b88 <log>
    800065ae:	57d8                	lw	a4,44(a5)
    800065b0:	fec42783          	lw	a5,-20(s0)
    800065b4:	2781                	sext.w	a5,a5
    800065b6:	02e79563          	bne	a5,a4,800065e0 <log_write+0x11a>
    bpin(b);
    800065ba:	fd843503          	ld	a0,-40(s0)
    800065be:	ffffe097          	auipc	ra,0xffffe
    800065c2:	344080e7          	jalr	836(ra) # 80004902 <bpin>
    log.lh.n++;
    800065c6:	0001d797          	auipc	a5,0x1d
    800065ca:	5c278793          	addi	a5,a5,1474 # 80023b88 <log>
    800065ce:	57dc                	lw	a5,44(a5)
    800065d0:	2785                	addiw	a5,a5,1
    800065d2:	0007871b          	sext.w	a4,a5
    800065d6:	0001d797          	auipc	a5,0x1d
    800065da:	5b278793          	addi	a5,a5,1458 # 80023b88 <log>
    800065de:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    800065e0:	0001d517          	auipc	a0,0x1d
    800065e4:	5a850513          	addi	a0,a0,1448 # 80023b88 <log>
    800065e8:	ffffb097          	auipc	ra,0xffffb
    800065ec:	da6080e7          	jalr	-602(ra) # 8000138e <release>
}
    800065f0:	0001                	nop
    800065f2:	70a2                	ld	ra,40(sp)
    800065f4:	7402                	ld	s0,32(sp)
    800065f6:	6145                	addi	sp,sp,48
    800065f8:	8082                	ret

00000000800065fa <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800065fa:	1101                	addi	sp,sp,-32
    800065fc:	ec06                	sd	ra,24(sp)
    800065fe:	e822                	sd	s0,16(sp)
    80006600:	1000                	addi	s0,sp,32
    80006602:	fea43423          	sd	a0,-24(s0)
    80006606:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    8000660a:	fe843783          	ld	a5,-24(s0)
    8000660e:	07a1                	addi	a5,a5,8
    80006610:	00005597          	auipc	a1,0x5
    80006614:	f9858593          	addi	a1,a1,-104 # 8000b5a8 <etext+0x5a8>
    80006618:	853e                	mv	a0,a5
    8000661a:	ffffb097          	auipc	ra,0xffffb
    8000661e:	ce0080e7          	jalr	-800(ra) # 800012fa <initlock>
  lk->name = name;
    80006622:	fe843783          	ld	a5,-24(s0)
    80006626:	fe043703          	ld	a4,-32(s0)
    8000662a:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    8000662c:	fe843783          	ld	a5,-24(s0)
    80006630:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006634:	fe843783          	ld	a5,-24(s0)
    80006638:	0207a423          	sw	zero,40(a5)
}
    8000663c:	0001                	nop
    8000663e:	60e2                	ld	ra,24(sp)
    80006640:	6442                	ld	s0,16(sp)
    80006642:	6105                	addi	sp,sp,32
    80006644:	8082                	ret

0000000080006646 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80006646:	1101                	addi	sp,sp,-32
    80006648:	ec06                	sd	ra,24(sp)
    8000664a:	e822                	sd	s0,16(sp)
    8000664c:	1000                	addi	s0,sp,32
    8000664e:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80006652:	fe843783          	ld	a5,-24(s0)
    80006656:	07a1                	addi	a5,a5,8
    80006658:	853e                	mv	a0,a5
    8000665a:	ffffb097          	auipc	ra,0xffffb
    8000665e:	cd0080e7          	jalr	-816(ra) # 8000132a <acquire>
  while (lk->locked) {
    80006662:	a819                	j	80006678 <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    80006664:	fe843783          	ld	a5,-24(s0)
    80006668:	07a1                	addi	a5,a5,8
    8000666a:	85be                	mv	a1,a5
    8000666c:	fe843503          	ld	a0,-24(s0)
    80006670:	ffffd097          	auipc	ra,0xffffd
    80006674:	e6a080e7          	jalr	-406(ra) # 800034da <sleep>
  while (lk->locked) {
    80006678:	fe843783          	ld	a5,-24(s0)
    8000667c:	439c                	lw	a5,0(a5)
    8000667e:	f3fd                	bnez	a5,80006664 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    80006680:	fe843783          	ld	a5,-24(s0)
    80006684:	4705                	li	a4,1
    80006686:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    80006688:	ffffc097          	auipc	ra,0xffffc
    8000668c:	290080e7          	jalr	656(ra) # 80002918 <myproc>
    80006690:	87aa                	mv	a5,a0
    80006692:	5b98                	lw	a4,48(a5)
    80006694:	fe843783          	ld	a5,-24(s0)
    80006698:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    8000669a:	fe843783          	ld	a5,-24(s0)
    8000669e:	07a1                	addi	a5,a5,8
    800066a0:	853e                	mv	a0,a5
    800066a2:	ffffb097          	auipc	ra,0xffffb
    800066a6:	cec080e7          	jalr	-788(ra) # 8000138e <release>
}
    800066aa:	0001                	nop
    800066ac:	60e2                	ld	ra,24(sp)
    800066ae:	6442                	ld	s0,16(sp)
    800066b0:	6105                	addi	sp,sp,32
    800066b2:	8082                	ret

00000000800066b4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800066b4:	1101                	addi	sp,sp,-32
    800066b6:	ec06                	sd	ra,24(sp)
    800066b8:	e822                	sd	s0,16(sp)
    800066ba:	1000                	addi	s0,sp,32
    800066bc:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800066c0:	fe843783          	ld	a5,-24(s0)
    800066c4:	07a1                	addi	a5,a5,8
    800066c6:	853e                	mv	a0,a5
    800066c8:	ffffb097          	auipc	ra,0xffffb
    800066cc:	c62080e7          	jalr	-926(ra) # 8000132a <acquire>
  lk->locked = 0;
    800066d0:	fe843783          	ld	a5,-24(s0)
    800066d4:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800066d8:	fe843783          	ld	a5,-24(s0)
    800066dc:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    800066e0:	fe843503          	ld	a0,-24(s0)
    800066e4:	ffffd097          	auipc	ra,0xffffd
    800066e8:	e72080e7          	jalr	-398(ra) # 80003556 <wakeup>
  release(&lk->lk);
    800066ec:	fe843783          	ld	a5,-24(s0)
    800066f0:	07a1                	addi	a5,a5,8
    800066f2:	853e                	mv	a0,a5
    800066f4:	ffffb097          	auipc	ra,0xffffb
    800066f8:	c9a080e7          	jalr	-870(ra) # 8000138e <release>
}
    800066fc:	0001                	nop
    800066fe:	60e2                	ld	ra,24(sp)
    80006700:	6442                	ld	s0,16(sp)
    80006702:	6105                	addi	sp,sp,32
    80006704:	8082                	ret

0000000080006706 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80006706:	7139                	addi	sp,sp,-64
    80006708:	fc06                	sd	ra,56(sp)
    8000670a:	f822                	sd	s0,48(sp)
    8000670c:	f426                	sd	s1,40(sp)
    8000670e:	0080                	addi	s0,sp,64
    80006710:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    80006714:	fc843783          	ld	a5,-56(s0)
    80006718:	07a1                	addi	a5,a5,8
    8000671a:	853e                	mv	a0,a5
    8000671c:	ffffb097          	auipc	ra,0xffffb
    80006720:	c0e080e7          	jalr	-1010(ra) # 8000132a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80006724:	fc843783          	ld	a5,-56(s0)
    80006728:	439c                	lw	a5,0(a5)
    8000672a:	cf99                	beqz	a5,80006748 <holdingsleep+0x42>
    8000672c:	fc843783          	ld	a5,-56(s0)
    80006730:	5784                	lw	s1,40(a5)
    80006732:	ffffc097          	auipc	ra,0xffffc
    80006736:	1e6080e7          	jalr	486(ra) # 80002918 <myproc>
    8000673a:	87aa                	mv	a5,a0
    8000673c:	5b9c                	lw	a5,48(a5)
    8000673e:	8726                	mv	a4,s1
    80006740:	00f71463          	bne	a4,a5,80006748 <holdingsleep+0x42>
    80006744:	4785                	li	a5,1
    80006746:	a011                	j	8000674a <holdingsleep+0x44>
    80006748:	4781                	li	a5,0
    8000674a:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    8000674e:	fc843783          	ld	a5,-56(s0)
    80006752:	07a1                	addi	a5,a5,8
    80006754:	853e                	mv	a0,a5
    80006756:	ffffb097          	auipc	ra,0xffffb
    8000675a:	c38080e7          	jalr	-968(ra) # 8000138e <release>
  return r;
    8000675e:	fdc42783          	lw	a5,-36(s0)
}
    80006762:	853e                	mv	a0,a5
    80006764:	70e2                	ld	ra,56(sp)
    80006766:	7442                	ld	s0,48(sp)
    80006768:	74a2                	ld	s1,40(sp)
    8000676a:	6121                	addi	sp,sp,64
    8000676c:	8082                	ret

000000008000676e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000676e:	1141                	addi	sp,sp,-16
    80006770:	e406                	sd	ra,8(sp)
    80006772:	e022                	sd	s0,0(sp)
    80006774:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80006776:	00005597          	auipc	a1,0x5
    8000677a:	e4258593          	addi	a1,a1,-446 # 8000b5b8 <etext+0x5b8>
    8000677e:	0001d517          	auipc	a0,0x1d
    80006782:	55250513          	addi	a0,a0,1362 # 80023cd0 <ftable>
    80006786:	ffffb097          	auipc	ra,0xffffb
    8000678a:	b74080e7          	jalr	-1164(ra) # 800012fa <initlock>
}
    8000678e:	0001                	nop
    80006790:	60a2                	ld	ra,8(sp)
    80006792:	6402                	ld	s0,0(sp)
    80006794:	0141                	addi	sp,sp,16
    80006796:	8082                	ret

0000000080006798 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80006798:	1101                	addi	sp,sp,-32
    8000679a:	ec06                	sd	ra,24(sp)
    8000679c:	e822                	sd	s0,16(sp)
    8000679e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800067a0:	0001d517          	auipc	a0,0x1d
    800067a4:	53050513          	addi	a0,a0,1328 # 80023cd0 <ftable>
    800067a8:	ffffb097          	auipc	ra,0xffffb
    800067ac:	b82080e7          	jalr	-1150(ra) # 8000132a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800067b0:	0001d797          	auipc	a5,0x1d
    800067b4:	53878793          	addi	a5,a5,1336 # 80023ce8 <ftable+0x18>
    800067b8:	fef43423          	sd	a5,-24(s0)
    800067bc:	a815                	j	800067f0 <filealloc+0x58>
    if(f->ref == 0){
    800067be:	fe843783          	ld	a5,-24(s0)
    800067c2:	43dc                	lw	a5,4(a5)
    800067c4:	e385                	bnez	a5,800067e4 <filealloc+0x4c>
      f->ref = 1;
    800067c6:	fe843783          	ld	a5,-24(s0)
    800067ca:	4705                	li	a4,1
    800067cc:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    800067ce:	0001d517          	auipc	a0,0x1d
    800067d2:	50250513          	addi	a0,a0,1282 # 80023cd0 <ftable>
    800067d6:	ffffb097          	auipc	ra,0xffffb
    800067da:	bb8080e7          	jalr	-1096(ra) # 8000138e <release>
      return f;
    800067de:	fe843783          	ld	a5,-24(s0)
    800067e2:	a805                	j	80006812 <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800067e4:	fe843783          	ld	a5,-24(s0)
    800067e8:	02878793          	addi	a5,a5,40
    800067ec:	fef43423          	sd	a5,-24(s0)
    800067f0:	0001e797          	auipc	a5,0x1e
    800067f4:	49878793          	addi	a5,a5,1176 # 80024c88 <disk>
    800067f8:	fe843703          	ld	a4,-24(s0)
    800067fc:	fcf761e3          	bltu	a4,a5,800067be <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    80006800:	0001d517          	auipc	a0,0x1d
    80006804:	4d050513          	addi	a0,a0,1232 # 80023cd0 <ftable>
    80006808:	ffffb097          	auipc	ra,0xffffb
    8000680c:	b86080e7          	jalr	-1146(ra) # 8000138e <release>
  return 0;
    80006810:	4781                	li	a5,0
}
    80006812:	853e                	mv	a0,a5
    80006814:	60e2                	ld	ra,24(sp)
    80006816:	6442                	ld	s0,16(sp)
    80006818:	6105                	addi	sp,sp,32
    8000681a:	8082                	ret

000000008000681c <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000681c:	1101                	addi	sp,sp,-32
    8000681e:	ec06                	sd	ra,24(sp)
    80006820:	e822                	sd	s0,16(sp)
    80006822:	1000                	addi	s0,sp,32
    80006824:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    80006828:	0001d517          	auipc	a0,0x1d
    8000682c:	4a850513          	addi	a0,a0,1192 # 80023cd0 <ftable>
    80006830:	ffffb097          	auipc	ra,0xffffb
    80006834:	afa080e7          	jalr	-1286(ra) # 8000132a <acquire>
  if(f->ref < 1)
    80006838:	fe843783          	ld	a5,-24(s0)
    8000683c:	43dc                	lw	a5,4(a5)
    8000683e:	00f04a63          	bgtz	a5,80006852 <filedup+0x36>
    panic("filedup");
    80006842:	00005517          	auipc	a0,0x5
    80006846:	d7e50513          	addi	a0,a0,-642 # 8000b5c0 <etext+0x5c0>
    8000684a:	ffffa097          	auipc	ra,0xffffa
    8000684e:	442080e7          	jalr	1090(ra) # 80000c8c <panic>
  f->ref++;
    80006852:	fe843783          	ld	a5,-24(s0)
    80006856:	43dc                	lw	a5,4(a5)
    80006858:	2785                	addiw	a5,a5,1
    8000685a:	0007871b          	sext.w	a4,a5
    8000685e:	fe843783          	ld	a5,-24(s0)
    80006862:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80006864:	0001d517          	auipc	a0,0x1d
    80006868:	46c50513          	addi	a0,a0,1132 # 80023cd0 <ftable>
    8000686c:	ffffb097          	auipc	ra,0xffffb
    80006870:	b22080e7          	jalr	-1246(ra) # 8000138e <release>
  return f;
    80006874:	fe843783          	ld	a5,-24(s0)
}
    80006878:	853e                	mv	a0,a5
    8000687a:	60e2                	ld	ra,24(sp)
    8000687c:	6442                	ld	s0,16(sp)
    8000687e:	6105                	addi	sp,sp,32
    80006880:	8082                	ret

0000000080006882 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80006882:	715d                	addi	sp,sp,-80
    80006884:	e486                	sd	ra,72(sp)
    80006886:	e0a2                	sd	s0,64(sp)
    80006888:	0880                	addi	s0,sp,80
    8000688a:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    8000688e:	0001d517          	auipc	a0,0x1d
    80006892:	44250513          	addi	a0,a0,1090 # 80023cd0 <ftable>
    80006896:	ffffb097          	auipc	ra,0xffffb
    8000689a:	a94080e7          	jalr	-1388(ra) # 8000132a <acquire>
  if(f->ref < 1)
    8000689e:	fb843783          	ld	a5,-72(s0)
    800068a2:	43dc                	lw	a5,4(a5)
    800068a4:	00f04a63          	bgtz	a5,800068b8 <fileclose+0x36>
    panic("fileclose");
    800068a8:	00005517          	auipc	a0,0x5
    800068ac:	d2050513          	addi	a0,a0,-736 # 8000b5c8 <etext+0x5c8>
    800068b0:	ffffa097          	auipc	ra,0xffffa
    800068b4:	3dc080e7          	jalr	988(ra) # 80000c8c <panic>
  if(--f->ref > 0){
    800068b8:	fb843783          	ld	a5,-72(s0)
    800068bc:	43dc                	lw	a5,4(a5)
    800068be:	37fd                	addiw	a5,a5,-1
    800068c0:	0007871b          	sext.w	a4,a5
    800068c4:	fb843783          	ld	a5,-72(s0)
    800068c8:	c3d8                	sw	a4,4(a5)
    800068ca:	fb843783          	ld	a5,-72(s0)
    800068ce:	43dc                	lw	a5,4(a5)
    800068d0:	00f05b63          	blez	a5,800068e6 <fileclose+0x64>
    release(&ftable.lock);
    800068d4:	0001d517          	auipc	a0,0x1d
    800068d8:	3fc50513          	addi	a0,a0,1020 # 80023cd0 <ftable>
    800068dc:	ffffb097          	auipc	ra,0xffffb
    800068e0:	ab2080e7          	jalr	-1358(ra) # 8000138e <release>
    800068e4:	a879                	j	80006982 <fileclose+0x100>
    return;
  }
  ff = *f;
    800068e6:	fb843783          	ld	a5,-72(s0)
    800068ea:	638c                	ld	a1,0(a5)
    800068ec:	6790                	ld	a2,8(a5)
    800068ee:	6b94                	ld	a3,16(a5)
    800068f0:	6f98                	ld	a4,24(a5)
    800068f2:	739c                	ld	a5,32(a5)
    800068f4:	fcb43423          	sd	a1,-56(s0)
    800068f8:	fcc43823          	sd	a2,-48(s0)
    800068fc:	fcd43c23          	sd	a3,-40(s0)
    80006900:	fee43023          	sd	a4,-32(s0)
    80006904:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80006908:	fb843783          	ld	a5,-72(s0)
    8000690c:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    80006910:	fb843783          	ld	a5,-72(s0)
    80006914:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80006918:	0001d517          	auipc	a0,0x1d
    8000691c:	3b850513          	addi	a0,a0,952 # 80023cd0 <ftable>
    80006920:	ffffb097          	auipc	ra,0xffffb
    80006924:	a6e080e7          	jalr	-1426(ra) # 8000138e <release>

  if(ff.type == FD_PIPE){
    80006928:	fc842783          	lw	a5,-56(s0)
    8000692c:	873e                	mv	a4,a5
    8000692e:	4785                	li	a5,1
    80006930:	00f71e63          	bne	a4,a5,8000694c <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    80006934:	fd843783          	ld	a5,-40(s0)
    80006938:	fd144703          	lbu	a4,-47(s0)
    8000693c:	2701                	sext.w	a4,a4
    8000693e:	85ba                	mv	a1,a4
    80006940:	853e                	mv	a0,a5
    80006942:	00000097          	auipc	ra,0x0
    80006946:	5aa080e7          	jalr	1450(ra) # 80006eec <pipeclose>
    8000694a:	a825                	j	80006982 <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    8000694c:	fc842783          	lw	a5,-56(s0)
    80006950:	873e                	mv	a4,a5
    80006952:	4789                	li	a5,2
    80006954:	00f70863          	beq	a4,a5,80006964 <fileclose+0xe2>
    80006958:	fc842783          	lw	a5,-56(s0)
    8000695c:	873e                	mv	a4,a5
    8000695e:	478d                	li	a5,3
    80006960:	02f71163          	bne	a4,a5,80006982 <fileclose+0x100>
    begin_op();
    80006964:	00000097          	auipc	ra,0x0
    80006968:	884080e7          	jalr	-1916(ra) # 800061e8 <begin_op>
    iput(ff.ip);
    8000696c:	fe043783          	ld	a5,-32(s0)
    80006970:	853e                	mv	a0,a5
    80006972:	fffff097          	auipc	ra,0xfffff
    80006976:	97a080e7          	jalr	-1670(ra) # 800052ec <iput>
    end_op();
    8000697a:	00000097          	auipc	ra,0x0
    8000697e:	930080e7          	jalr	-1744(ra) # 800062aa <end_op>
  }
}
    80006982:	60a6                	ld	ra,72(sp)
    80006984:	6406                	ld	s0,64(sp)
    80006986:	6161                	addi	sp,sp,80
    80006988:	8082                	ret

000000008000698a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000698a:	7139                	addi	sp,sp,-64
    8000698c:	fc06                	sd	ra,56(sp)
    8000698e:	f822                	sd	s0,48(sp)
    80006990:	0080                	addi	s0,sp,64
    80006992:	fca43423          	sd	a0,-56(s0)
    80006996:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    8000699a:	ffffc097          	auipc	ra,0xffffc
    8000699e:	f7e080e7          	jalr	-130(ra) # 80002918 <myproc>
    800069a2:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800069a6:	fc843783          	ld	a5,-56(s0)
    800069aa:	439c                	lw	a5,0(a5)
    800069ac:	873e                	mv	a4,a5
    800069ae:	4789                	li	a5,2
    800069b0:	00f70963          	beq	a4,a5,800069c2 <filestat+0x38>
    800069b4:	fc843783          	ld	a5,-56(s0)
    800069b8:	439c                	lw	a5,0(a5)
    800069ba:	873e                	mv	a4,a5
    800069bc:	478d                	li	a5,3
    800069be:	06f71263          	bne	a4,a5,80006a22 <filestat+0x98>
    ilock(f->ip);
    800069c2:	fc843783          	ld	a5,-56(s0)
    800069c6:	6f9c                	ld	a5,24(a5)
    800069c8:	853e                	mv	a0,a5
    800069ca:	ffffe097          	auipc	ra,0xffffe
    800069ce:	794080e7          	jalr	1940(ra) # 8000515e <ilock>
    stati(f->ip, &st);
    800069d2:	fc843783          	ld	a5,-56(s0)
    800069d6:	6f9c                	ld	a5,24(a5)
    800069d8:	fd040713          	addi	a4,s0,-48
    800069dc:	85ba                	mv	a1,a4
    800069de:	853e                	mv	a0,a5
    800069e0:	fffff097          	auipc	ra,0xfffff
    800069e4:	cd0080e7          	jalr	-816(ra) # 800056b0 <stati>
    iunlock(f->ip);
    800069e8:	fc843783          	ld	a5,-56(s0)
    800069ec:	6f9c                	ld	a5,24(a5)
    800069ee:	853e                	mv	a0,a5
    800069f0:	fffff097          	auipc	ra,0xfffff
    800069f4:	8a2080e7          	jalr	-1886(ra) # 80005292 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800069f8:	fe843783          	ld	a5,-24(s0)
    800069fc:	6bbc                	ld	a5,80(a5)
    800069fe:	fd040713          	addi	a4,s0,-48
    80006a02:	46e1                	li	a3,24
    80006a04:	863a                	mv	a2,a4
    80006a06:	fc043583          	ld	a1,-64(s0)
    80006a0a:	853e                	mv	a0,a5
    80006a0c:	ffffc097          	auipc	ra,0xffffc
    80006a10:	9d6080e7          	jalr	-1578(ra) # 800023e2 <copyout>
    80006a14:	87aa                	mv	a5,a0
    80006a16:	0007d463          	bgez	a5,80006a1e <filestat+0x94>
      return -1;
    80006a1a:	57fd                	li	a5,-1
    80006a1c:	a021                	j	80006a24 <filestat+0x9a>
    return 0;
    80006a1e:	4781                	li	a5,0
    80006a20:	a011                	j	80006a24 <filestat+0x9a>
  }
  return -1;
    80006a22:	57fd                	li	a5,-1
}
    80006a24:	853e                	mv	a0,a5
    80006a26:	70e2                	ld	ra,56(sp)
    80006a28:	7442                	ld	s0,48(sp)
    80006a2a:	6121                	addi	sp,sp,64
    80006a2c:	8082                	ret

0000000080006a2e <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80006a2e:	7139                	addi	sp,sp,-64
    80006a30:	fc06                	sd	ra,56(sp)
    80006a32:	f822                	sd	s0,48(sp)
    80006a34:	0080                	addi	s0,sp,64
    80006a36:	fca43c23          	sd	a0,-40(s0)
    80006a3a:	fcb43823          	sd	a1,-48(s0)
    80006a3e:	87b2                	mv	a5,a2
    80006a40:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    80006a44:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    80006a48:	fd843783          	ld	a5,-40(s0)
    80006a4c:	0087c783          	lbu	a5,8(a5)
    80006a50:	e399                	bnez	a5,80006a56 <fileread+0x28>
    return -1;
    80006a52:	57fd                	li	a5,-1
    80006a54:	aa1d                	j	80006b8a <fileread+0x15c>

  if(f->type == FD_PIPE){
    80006a56:	fd843783          	ld	a5,-40(s0)
    80006a5a:	439c                	lw	a5,0(a5)
    80006a5c:	873e                	mv	a4,a5
    80006a5e:	4785                	li	a5,1
    80006a60:	02f71363          	bne	a4,a5,80006a86 <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    80006a64:	fd843783          	ld	a5,-40(s0)
    80006a68:	6b9c                	ld	a5,16(a5)
    80006a6a:	fcc42703          	lw	a4,-52(s0)
    80006a6e:	863a                	mv	a2,a4
    80006a70:	fd043583          	ld	a1,-48(s0)
    80006a74:	853e                	mv	a0,a5
    80006a76:	00000097          	auipc	ra,0x0
    80006a7a:	670080e7          	jalr	1648(ra) # 800070e6 <piperead>
    80006a7e:	87aa                	mv	a5,a0
    80006a80:	fef42623          	sw	a5,-20(s0)
    80006a84:	a209                	j	80006b86 <fileread+0x158>
  } else if(f->type == FD_DEVICE){
    80006a86:	fd843783          	ld	a5,-40(s0)
    80006a8a:	439c                	lw	a5,0(a5)
    80006a8c:	873e                	mv	a4,a5
    80006a8e:	478d                	li	a5,3
    80006a90:	06f71863          	bne	a4,a5,80006b00 <fileread+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80006a94:	fd843783          	ld	a5,-40(s0)
    80006a98:	02479783          	lh	a5,36(a5)
    80006a9c:	2781                	sext.w	a5,a5
    80006a9e:	0207c863          	bltz	a5,80006ace <fileread+0xa0>
    80006aa2:	fd843783          	ld	a5,-40(s0)
    80006aa6:	02479783          	lh	a5,36(a5)
    80006aaa:	0007871b          	sext.w	a4,a5
    80006aae:	47a5                	li	a5,9
    80006ab0:	00e7cf63          	blt	a5,a4,80006ace <fileread+0xa0>
    80006ab4:	fd843783          	ld	a5,-40(s0)
    80006ab8:	02479783          	lh	a5,36(a5)
    80006abc:	2781                	sext.w	a5,a5
    80006abe:	0001d717          	auipc	a4,0x1d
    80006ac2:	17270713          	addi	a4,a4,370 # 80023c30 <devsw>
    80006ac6:	0792                	slli	a5,a5,0x4
    80006ac8:	97ba                	add	a5,a5,a4
    80006aca:	639c                	ld	a5,0(a5)
    80006acc:	e399                	bnez	a5,80006ad2 <fileread+0xa4>
      return -1;
    80006ace:	57fd                	li	a5,-1
    80006ad0:	a86d                	j	80006b8a <fileread+0x15c>
    r = devsw[f->major].read(1, addr, n);
    80006ad2:	fd843783          	ld	a5,-40(s0)
    80006ad6:	02479783          	lh	a5,36(a5)
    80006ada:	2781                	sext.w	a5,a5
    80006adc:	0001d717          	auipc	a4,0x1d
    80006ae0:	15470713          	addi	a4,a4,340 # 80023c30 <devsw>
    80006ae4:	0792                	slli	a5,a5,0x4
    80006ae6:	97ba                	add	a5,a5,a4
    80006ae8:	6398                	ld	a4,0(a5)
    80006aea:	fcc42783          	lw	a5,-52(s0)
    80006aee:	863e                	mv	a2,a5
    80006af0:	fd043583          	ld	a1,-48(s0)
    80006af4:	4505                	li	a0,1
    80006af6:	9702                	jalr	a4
    80006af8:	87aa                	mv	a5,a0
    80006afa:	fef42623          	sw	a5,-20(s0)
    80006afe:	a061                	j	80006b86 <fileread+0x158>
  } else if(f->type == FD_INODE){
    80006b00:	fd843783          	ld	a5,-40(s0)
    80006b04:	439c                	lw	a5,0(a5)
    80006b06:	873e                	mv	a4,a5
    80006b08:	4789                	li	a5,2
    80006b0a:	06f71663          	bne	a4,a5,80006b76 <fileread+0x148>
    ilock(f->ip);
    80006b0e:	fd843783          	ld	a5,-40(s0)
    80006b12:	6f9c                	ld	a5,24(a5)
    80006b14:	853e                	mv	a0,a5
    80006b16:	ffffe097          	auipc	ra,0xffffe
    80006b1a:	648080e7          	jalr	1608(ra) # 8000515e <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80006b1e:	fd843783          	ld	a5,-40(s0)
    80006b22:	6f88                	ld	a0,24(a5)
    80006b24:	fd843783          	ld	a5,-40(s0)
    80006b28:	539c                	lw	a5,32(a5)
    80006b2a:	fcc42703          	lw	a4,-52(s0)
    80006b2e:	86be                	mv	a3,a5
    80006b30:	fd043603          	ld	a2,-48(s0)
    80006b34:	4585                	li	a1,1
    80006b36:	fffff097          	auipc	ra,0xfffff
    80006b3a:	bde080e7          	jalr	-1058(ra) # 80005714 <readi>
    80006b3e:	87aa                	mv	a5,a0
    80006b40:	fef42623          	sw	a5,-20(s0)
    80006b44:	fec42783          	lw	a5,-20(s0)
    80006b48:	2781                	sext.w	a5,a5
    80006b4a:	00f05d63          	blez	a5,80006b64 <fileread+0x136>
      f->off += r;
    80006b4e:	fd843783          	ld	a5,-40(s0)
    80006b52:	5398                	lw	a4,32(a5)
    80006b54:	fec42783          	lw	a5,-20(s0)
    80006b58:	9fb9                	addw	a5,a5,a4
    80006b5a:	0007871b          	sext.w	a4,a5
    80006b5e:	fd843783          	ld	a5,-40(s0)
    80006b62:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    80006b64:	fd843783          	ld	a5,-40(s0)
    80006b68:	6f9c                	ld	a5,24(a5)
    80006b6a:	853e                	mv	a0,a5
    80006b6c:	ffffe097          	auipc	ra,0xffffe
    80006b70:	726080e7          	jalr	1830(ra) # 80005292 <iunlock>
    80006b74:	a809                	j	80006b86 <fileread+0x158>
  } else {
    panic("fileread");
    80006b76:	00005517          	auipc	a0,0x5
    80006b7a:	a6250513          	addi	a0,a0,-1438 # 8000b5d8 <etext+0x5d8>
    80006b7e:	ffffa097          	auipc	ra,0xffffa
    80006b82:	10e080e7          	jalr	270(ra) # 80000c8c <panic>
  }

  return r;
    80006b86:	fec42783          	lw	a5,-20(s0)
}
    80006b8a:	853e                	mv	a0,a5
    80006b8c:	70e2                	ld	ra,56(sp)
    80006b8e:	7442                	ld	s0,48(sp)
    80006b90:	6121                	addi	sp,sp,64
    80006b92:	8082                	ret

0000000080006b94 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80006b94:	715d                	addi	sp,sp,-80
    80006b96:	e486                	sd	ra,72(sp)
    80006b98:	e0a2                	sd	s0,64(sp)
    80006b9a:	0880                	addi	s0,sp,80
    80006b9c:	fca43423          	sd	a0,-56(s0)
    80006ba0:	fcb43023          	sd	a1,-64(s0)
    80006ba4:	87b2                	mv	a5,a2
    80006ba6:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    80006baa:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    80006bae:	fc843783          	ld	a5,-56(s0)
    80006bb2:	0097c783          	lbu	a5,9(a5)
    80006bb6:	e399                	bnez	a5,80006bbc <filewrite+0x28>
    return -1;
    80006bb8:	57fd                	li	a5,-1
    80006bba:	aad1                	j	80006d8e <filewrite+0x1fa>

  if(f->type == FD_PIPE){
    80006bbc:	fc843783          	ld	a5,-56(s0)
    80006bc0:	439c                	lw	a5,0(a5)
    80006bc2:	873e                	mv	a4,a5
    80006bc4:	4785                	li	a5,1
    80006bc6:	02f71363          	bne	a4,a5,80006bec <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    80006bca:	fc843783          	ld	a5,-56(s0)
    80006bce:	6b9c                	ld	a5,16(a5)
    80006bd0:	fbc42703          	lw	a4,-68(s0)
    80006bd4:	863a                	mv	a2,a4
    80006bd6:	fc043583          	ld	a1,-64(s0)
    80006bda:	853e                	mv	a0,a5
    80006bdc:	00000097          	auipc	ra,0x0
    80006be0:	3b8080e7          	jalr	952(ra) # 80006f94 <pipewrite>
    80006be4:	87aa                	mv	a5,a0
    80006be6:	fef42623          	sw	a5,-20(s0)
    80006bea:	a245                	j	80006d8a <filewrite+0x1f6>
  } else if(f->type == FD_DEVICE){
    80006bec:	fc843783          	ld	a5,-56(s0)
    80006bf0:	439c                	lw	a5,0(a5)
    80006bf2:	873e                	mv	a4,a5
    80006bf4:	478d                	li	a5,3
    80006bf6:	06f71863          	bne	a4,a5,80006c66 <filewrite+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80006bfa:	fc843783          	ld	a5,-56(s0)
    80006bfe:	02479783          	lh	a5,36(a5)
    80006c02:	2781                	sext.w	a5,a5
    80006c04:	0207c863          	bltz	a5,80006c34 <filewrite+0xa0>
    80006c08:	fc843783          	ld	a5,-56(s0)
    80006c0c:	02479783          	lh	a5,36(a5)
    80006c10:	0007871b          	sext.w	a4,a5
    80006c14:	47a5                	li	a5,9
    80006c16:	00e7cf63          	blt	a5,a4,80006c34 <filewrite+0xa0>
    80006c1a:	fc843783          	ld	a5,-56(s0)
    80006c1e:	02479783          	lh	a5,36(a5)
    80006c22:	2781                	sext.w	a5,a5
    80006c24:	0001d717          	auipc	a4,0x1d
    80006c28:	00c70713          	addi	a4,a4,12 # 80023c30 <devsw>
    80006c2c:	0792                	slli	a5,a5,0x4
    80006c2e:	97ba                	add	a5,a5,a4
    80006c30:	679c                	ld	a5,8(a5)
    80006c32:	e399                	bnez	a5,80006c38 <filewrite+0xa4>
      return -1;
    80006c34:	57fd                	li	a5,-1
    80006c36:	aaa1                	j	80006d8e <filewrite+0x1fa>
    ret = devsw[f->major].write(1, addr, n);
    80006c38:	fc843783          	ld	a5,-56(s0)
    80006c3c:	02479783          	lh	a5,36(a5)
    80006c40:	2781                	sext.w	a5,a5
    80006c42:	0001d717          	auipc	a4,0x1d
    80006c46:	fee70713          	addi	a4,a4,-18 # 80023c30 <devsw>
    80006c4a:	0792                	slli	a5,a5,0x4
    80006c4c:	97ba                	add	a5,a5,a4
    80006c4e:	6798                	ld	a4,8(a5)
    80006c50:	fbc42783          	lw	a5,-68(s0)
    80006c54:	863e                	mv	a2,a5
    80006c56:	fc043583          	ld	a1,-64(s0)
    80006c5a:	4505                	li	a0,1
    80006c5c:	9702                	jalr	a4
    80006c5e:	87aa                	mv	a5,a0
    80006c60:	fef42623          	sw	a5,-20(s0)
    80006c64:	a21d                	j	80006d8a <filewrite+0x1f6>
  } else if(f->type == FD_INODE){
    80006c66:	fc843783          	ld	a5,-56(s0)
    80006c6a:	439c                	lw	a5,0(a5)
    80006c6c:	873e                	mv	a4,a5
    80006c6e:	4789                	li	a5,2
    80006c70:	10f71563          	bne	a4,a5,80006d7a <filewrite+0x1e6>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80006c74:	6785                	lui	a5,0x1
    80006c76:	c007879b          	addiw	a5,a5,-1024
    80006c7a:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    80006c7e:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80006c82:	a0d9                	j	80006d48 <filewrite+0x1b4>
      int n1 = n - i;
    80006c84:	fbc42703          	lw	a4,-68(s0)
    80006c88:	fe842783          	lw	a5,-24(s0)
    80006c8c:	40f707bb          	subw	a5,a4,a5
    80006c90:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80006c94:	fe442703          	lw	a4,-28(s0)
    80006c98:	fe042783          	lw	a5,-32(s0)
    80006c9c:	2701                	sext.w	a4,a4
    80006c9e:	2781                	sext.w	a5,a5
    80006ca0:	00e7d663          	bge	a5,a4,80006cac <filewrite+0x118>
        n1 = max;
    80006ca4:	fe042783          	lw	a5,-32(s0)
    80006ca8:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80006cac:	fffff097          	auipc	ra,0xfffff
    80006cb0:	53c080e7          	jalr	1340(ra) # 800061e8 <begin_op>
      ilock(f->ip);
    80006cb4:	fc843783          	ld	a5,-56(s0)
    80006cb8:	6f9c                	ld	a5,24(a5)
    80006cba:	853e                	mv	a0,a5
    80006cbc:	ffffe097          	auipc	ra,0xffffe
    80006cc0:	4a2080e7          	jalr	1186(ra) # 8000515e <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80006cc4:	fc843783          	ld	a5,-56(s0)
    80006cc8:	6f88                	ld	a0,24(a5)
    80006cca:	fe842703          	lw	a4,-24(s0)
    80006cce:	fc043783          	ld	a5,-64(s0)
    80006cd2:	00f70633          	add	a2,a4,a5
    80006cd6:	fc843783          	ld	a5,-56(s0)
    80006cda:	539c                	lw	a5,32(a5)
    80006cdc:	fe442703          	lw	a4,-28(s0)
    80006ce0:	86be                	mv	a3,a5
    80006ce2:	4585                	li	a1,1
    80006ce4:	fffff097          	auipc	ra,0xfffff
    80006ce8:	bc8080e7          	jalr	-1080(ra) # 800058ac <writei>
    80006cec:	87aa                	mv	a5,a0
    80006cee:	fcf42e23          	sw	a5,-36(s0)
    80006cf2:	fdc42783          	lw	a5,-36(s0)
    80006cf6:	2781                	sext.w	a5,a5
    80006cf8:	00f05d63          	blez	a5,80006d12 <filewrite+0x17e>
        f->off += r;
    80006cfc:	fc843783          	ld	a5,-56(s0)
    80006d00:	5398                	lw	a4,32(a5)
    80006d02:	fdc42783          	lw	a5,-36(s0)
    80006d06:	9fb9                	addw	a5,a5,a4
    80006d08:	0007871b          	sext.w	a4,a5
    80006d0c:	fc843783          	ld	a5,-56(s0)
    80006d10:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    80006d12:	fc843783          	ld	a5,-56(s0)
    80006d16:	6f9c                	ld	a5,24(a5)
    80006d18:	853e                	mv	a0,a5
    80006d1a:	ffffe097          	auipc	ra,0xffffe
    80006d1e:	578080e7          	jalr	1400(ra) # 80005292 <iunlock>
      end_op();
    80006d22:	fffff097          	auipc	ra,0xfffff
    80006d26:	588080e7          	jalr	1416(ra) # 800062aa <end_op>

      if(r != n1){
    80006d2a:	fdc42703          	lw	a4,-36(s0)
    80006d2e:	fe442783          	lw	a5,-28(s0)
    80006d32:	2701                	sext.w	a4,a4
    80006d34:	2781                	sext.w	a5,a5
    80006d36:	02f71263          	bne	a4,a5,80006d5a <filewrite+0x1c6>
        // error from writei
        break;
      }
      i += r;
    80006d3a:	fe842703          	lw	a4,-24(s0)
    80006d3e:	fdc42783          	lw	a5,-36(s0)
    80006d42:	9fb9                	addw	a5,a5,a4
    80006d44:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    80006d48:	fe842703          	lw	a4,-24(s0)
    80006d4c:	fbc42783          	lw	a5,-68(s0)
    80006d50:	2701                	sext.w	a4,a4
    80006d52:	2781                	sext.w	a5,a5
    80006d54:	f2f748e3          	blt	a4,a5,80006c84 <filewrite+0xf0>
    80006d58:	a011                	j	80006d5c <filewrite+0x1c8>
        break;
    80006d5a:	0001                	nop
    }
    ret = (i == n ? n : -1);
    80006d5c:	fe842703          	lw	a4,-24(s0)
    80006d60:	fbc42783          	lw	a5,-68(s0)
    80006d64:	2701                	sext.w	a4,a4
    80006d66:	2781                	sext.w	a5,a5
    80006d68:	00f71563          	bne	a4,a5,80006d72 <filewrite+0x1de>
    80006d6c:	fbc42783          	lw	a5,-68(s0)
    80006d70:	a011                	j	80006d74 <filewrite+0x1e0>
    80006d72:	57fd                	li	a5,-1
    80006d74:	fef42623          	sw	a5,-20(s0)
    80006d78:	a809                	j	80006d8a <filewrite+0x1f6>
  } else {
    panic("filewrite");
    80006d7a:	00005517          	auipc	a0,0x5
    80006d7e:	86e50513          	addi	a0,a0,-1938 # 8000b5e8 <etext+0x5e8>
    80006d82:	ffffa097          	auipc	ra,0xffffa
    80006d86:	f0a080e7          	jalr	-246(ra) # 80000c8c <panic>
  }

  return ret;
    80006d8a:	fec42783          	lw	a5,-20(s0)
}
    80006d8e:	853e                	mv	a0,a5
    80006d90:	60a6                	ld	ra,72(sp)
    80006d92:	6406                	ld	s0,64(sp)
    80006d94:	6161                	addi	sp,sp,80
    80006d96:	8082                	ret

0000000080006d98 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80006d98:	7179                	addi	sp,sp,-48
    80006d9a:	f406                	sd	ra,40(sp)
    80006d9c:	f022                	sd	s0,32(sp)
    80006d9e:	1800                	addi	s0,sp,48
    80006da0:	fca43c23          	sd	a0,-40(s0)
    80006da4:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    80006da8:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80006dac:	fd043783          	ld	a5,-48(s0)
    80006db0:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80006db4:	fd043783          	ld	a5,-48(s0)
    80006db8:	6398                	ld	a4,0(a5)
    80006dba:	fd843783          	ld	a5,-40(s0)
    80006dbe:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80006dc0:	00000097          	auipc	ra,0x0
    80006dc4:	9d8080e7          	jalr	-1576(ra) # 80006798 <filealloc>
    80006dc8:	872a                	mv	a4,a0
    80006dca:	fd843783          	ld	a5,-40(s0)
    80006dce:	e398                	sd	a4,0(a5)
    80006dd0:	fd843783          	ld	a5,-40(s0)
    80006dd4:	639c                	ld	a5,0(a5)
    80006dd6:	c3e9                	beqz	a5,80006e98 <pipealloc+0x100>
    80006dd8:	00000097          	auipc	ra,0x0
    80006ddc:	9c0080e7          	jalr	-1600(ra) # 80006798 <filealloc>
    80006de0:	872a                	mv	a4,a0
    80006de2:	fd043783          	ld	a5,-48(s0)
    80006de6:	e398                	sd	a4,0(a5)
    80006de8:	fd043783          	ld	a5,-48(s0)
    80006dec:	639c                	ld	a5,0(a5)
    80006dee:	c7cd                	beqz	a5,80006e98 <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80006df0:	ffffa097          	auipc	ra,0xffffa
    80006df4:	3e6080e7          	jalr	998(ra) # 800011d6 <kalloc>
    80006df8:	fea43423          	sd	a0,-24(s0)
    80006dfc:	fe843783          	ld	a5,-24(s0)
    80006e00:	cfd1                	beqz	a5,80006e9c <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    80006e02:	fe843783          	ld	a5,-24(s0)
    80006e06:	4705                	li	a4,1
    80006e08:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    80006e0c:	fe843783          	ld	a5,-24(s0)
    80006e10:	4705                	li	a4,1
    80006e12:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    80006e16:	fe843783          	ld	a5,-24(s0)
    80006e1a:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    80006e1e:	fe843783          	ld	a5,-24(s0)
    80006e22:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    80006e26:	fe843783          	ld	a5,-24(s0)
    80006e2a:	00004597          	auipc	a1,0x4
    80006e2e:	7ce58593          	addi	a1,a1,1998 # 8000b5f8 <etext+0x5f8>
    80006e32:	853e                	mv	a0,a5
    80006e34:	ffffa097          	auipc	ra,0xffffa
    80006e38:	4c6080e7          	jalr	1222(ra) # 800012fa <initlock>
  (*f0)->type = FD_PIPE;
    80006e3c:	fd843783          	ld	a5,-40(s0)
    80006e40:	639c                	ld	a5,0(a5)
    80006e42:	4705                	li	a4,1
    80006e44:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    80006e46:	fd843783          	ld	a5,-40(s0)
    80006e4a:	639c                	ld	a5,0(a5)
    80006e4c:	4705                	li	a4,1
    80006e4e:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    80006e52:	fd843783          	ld	a5,-40(s0)
    80006e56:	639c                	ld	a5,0(a5)
    80006e58:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80006e5c:	fd843783          	ld	a5,-40(s0)
    80006e60:	639c                	ld	a5,0(a5)
    80006e62:	fe843703          	ld	a4,-24(s0)
    80006e66:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    80006e68:	fd043783          	ld	a5,-48(s0)
    80006e6c:	639c                	ld	a5,0(a5)
    80006e6e:	4705                	li	a4,1
    80006e70:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    80006e72:	fd043783          	ld	a5,-48(s0)
    80006e76:	639c                	ld	a5,0(a5)
    80006e78:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80006e7c:	fd043783          	ld	a5,-48(s0)
    80006e80:	639c                	ld	a5,0(a5)
    80006e82:	4705                	li	a4,1
    80006e84:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80006e88:	fd043783          	ld	a5,-48(s0)
    80006e8c:	639c                	ld	a5,0(a5)
    80006e8e:	fe843703          	ld	a4,-24(s0)
    80006e92:	eb98                	sd	a4,16(a5)
  return 0;
    80006e94:	4781                	li	a5,0
    80006e96:	a0b1                	j	80006ee2 <pipealloc+0x14a>
    goto bad;
    80006e98:	0001                	nop
    80006e9a:	a011                	j	80006e9e <pipealloc+0x106>
    goto bad;
    80006e9c:	0001                	nop

 bad:
  if(pi)
    80006e9e:	fe843783          	ld	a5,-24(s0)
    80006ea2:	c799                	beqz	a5,80006eb0 <pipealloc+0x118>
    kfree((char*)pi);
    80006ea4:	fe843503          	ld	a0,-24(s0)
    80006ea8:	ffffa097          	auipc	ra,0xffffa
    80006eac:	288080e7          	jalr	648(ra) # 80001130 <kfree>
  if(*f0)
    80006eb0:	fd843783          	ld	a5,-40(s0)
    80006eb4:	639c                	ld	a5,0(a5)
    80006eb6:	cb89                	beqz	a5,80006ec8 <pipealloc+0x130>
    fileclose(*f0);
    80006eb8:	fd843783          	ld	a5,-40(s0)
    80006ebc:	639c                	ld	a5,0(a5)
    80006ebe:	853e                	mv	a0,a5
    80006ec0:	00000097          	auipc	ra,0x0
    80006ec4:	9c2080e7          	jalr	-1598(ra) # 80006882 <fileclose>
  if(*f1)
    80006ec8:	fd043783          	ld	a5,-48(s0)
    80006ecc:	639c                	ld	a5,0(a5)
    80006ece:	cb89                	beqz	a5,80006ee0 <pipealloc+0x148>
    fileclose(*f1);
    80006ed0:	fd043783          	ld	a5,-48(s0)
    80006ed4:	639c                	ld	a5,0(a5)
    80006ed6:	853e                	mv	a0,a5
    80006ed8:	00000097          	auipc	ra,0x0
    80006edc:	9aa080e7          	jalr	-1622(ra) # 80006882 <fileclose>
  return -1;
    80006ee0:	57fd                	li	a5,-1
}
    80006ee2:	853e                	mv	a0,a5
    80006ee4:	70a2                	ld	ra,40(sp)
    80006ee6:	7402                	ld	s0,32(sp)
    80006ee8:	6145                	addi	sp,sp,48
    80006eea:	8082                	ret

0000000080006eec <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80006eec:	1101                	addi	sp,sp,-32
    80006eee:	ec06                	sd	ra,24(sp)
    80006ef0:	e822                	sd	s0,16(sp)
    80006ef2:	1000                	addi	s0,sp,32
    80006ef4:	fea43423          	sd	a0,-24(s0)
    80006ef8:	87ae                	mv	a5,a1
    80006efa:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80006efe:	fe843783          	ld	a5,-24(s0)
    80006f02:	853e                	mv	a0,a5
    80006f04:	ffffa097          	auipc	ra,0xffffa
    80006f08:	426080e7          	jalr	1062(ra) # 8000132a <acquire>
  if(writable){
    80006f0c:	fe442783          	lw	a5,-28(s0)
    80006f10:	2781                	sext.w	a5,a5
    80006f12:	cf99                	beqz	a5,80006f30 <pipeclose+0x44>
    pi->writeopen = 0;
    80006f14:	fe843783          	ld	a5,-24(s0)
    80006f18:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80006f1c:	fe843783          	ld	a5,-24(s0)
    80006f20:	21878793          	addi	a5,a5,536
    80006f24:	853e                	mv	a0,a5
    80006f26:	ffffc097          	auipc	ra,0xffffc
    80006f2a:	630080e7          	jalr	1584(ra) # 80003556 <wakeup>
    80006f2e:	a831                	j	80006f4a <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    80006f30:	fe843783          	ld	a5,-24(s0)
    80006f34:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80006f38:	fe843783          	ld	a5,-24(s0)
    80006f3c:	21c78793          	addi	a5,a5,540
    80006f40:	853e                	mv	a0,a5
    80006f42:	ffffc097          	auipc	ra,0xffffc
    80006f46:	614080e7          	jalr	1556(ra) # 80003556 <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80006f4a:	fe843783          	ld	a5,-24(s0)
    80006f4e:	2207a783          	lw	a5,544(a5)
    80006f52:	e785                	bnez	a5,80006f7a <pipeclose+0x8e>
    80006f54:	fe843783          	ld	a5,-24(s0)
    80006f58:	2247a783          	lw	a5,548(a5)
    80006f5c:	ef99                	bnez	a5,80006f7a <pipeclose+0x8e>
    release(&pi->lock);
    80006f5e:	fe843783          	ld	a5,-24(s0)
    80006f62:	853e                	mv	a0,a5
    80006f64:	ffffa097          	auipc	ra,0xffffa
    80006f68:	42a080e7          	jalr	1066(ra) # 8000138e <release>
    kfree((char*)pi);
    80006f6c:	fe843503          	ld	a0,-24(s0)
    80006f70:	ffffa097          	auipc	ra,0xffffa
    80006f74:	1c0080e7          	jalr	448(ra) # 80001130 <kfree>
    80006f78:	a809                	j	80006f8a <pipeclose+0x9e>
  } else
    release(&pi->lock);
    80006f7a:	fe843783          	ld	a5,-24(s0)
    80006f7e:	853e                	mv	a0,a5
    80006f80:	ffffa097          	auipc	ra,0xffffa
    80006f84:	40e080e7          	jalr	1038(ra) # 8000138e <release>
}
    80006f88:	0001                	nop
    80006f8a:	0001                	nop
    80006f8c:	60e2                	ld	ra,24(sp)
    80006f8e:	6442                	ld	s0,16(sp)
    80006f90:	6105                	addi	sp,sp,32
    80006f92:	8082                	ret

0000000080006f94 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80006f94:	715d                	addi	sp,sp,-80
    80006f96:	e486                	sd	ra,72(sp)
    80006f98:	e0a2                	sd	s0,64(sp)
    80006f9a:	0880                	addi	s0,sp,80
    80006f9c:	fca43423          	sd	a0,-56(s0)
    80006fa0:	fcb43023          	sd	a1,-64(s0)
    80006fa4:	87b2                	mv	a5,a2
    80006fa6:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    80006faa:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    80006fae:	ffffc097          	auipc	ra,0xffffc
    80006fb2:	96a080e7          	jalr	-1686(ra) # 80002918 <myproc>
    80006fb6:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    80006fba:	fc843783          	ld	a5,-56(s0)
    80006fbe:	853e                	mv	a0,a5
    80006fc0:	ffffa097          	auipc	ra,0xffffa
    80006fc4:	36a080e7          	jalr	874(ra) # 8000132a <acquire>
  while(i < n){
    80006fc8:	a8f1                	j	800070a4 <pipewrite+0x110>
    if(pi->readopen == 0 || killed(pr)){
    80006fca:	fc843783          	ld	a5,-56(s0)
    80006fce:	2207a783          	lw	a5,544(a5)
    80006fd2:	cb89                	beqz	a5,80006fe4 <pipewrite+0x50>
    80006fd4:	fe043503          	ld	a0,-32(s0)
    80006fd8:	ffffc097          	auipc	ra,0xffffc
    80006fdc:	710080e7          	jalr	1808(ra) # 800036e8 <killed>
    80006fe0:	87aa                	mv	a5,a0
    80006fe2:	cb91                	beqz	a5,80006ff6 <pipewrite+0x62>
      release(&pi->lock);
    80006fe4:	fc843783          	ld	a5,-56(s0)
    80006fe8:	853e                	mv	a0,a5
    80006fea:	ffffa097          	auipc	ra,0xffffa
    80006fee:	3a4080e7          	jalr	932(ra) # 8000138e <release>
      return -1;
    80006ff2:	57fd                	li	a5,-1
    80006ff4:	a0e5                	j	800070dc <pipewrite+0x148>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80006ff6:	fc843783          	ld	a5,-56(s0)
    80006ffa:	21c7a703          	lw	a4,540(a5)
    80006ffe:	fc843783          	ld	a5,-56(s0)
    80007002:	2187a783          	lw	a5,536(a5)
    80007006:	2007879b          	addiw	a5,a5,512
    8000700a:	2781                	sext.w	a5,a5
    8000700c:	02f71863          	bne	a4,a5,8000703c <pipewrite+0xa8>
      wakeup(&pi->nread);
    80007010:	fc843783          	ld	a5,-56(s0)
    80007014:	21878793          	addi	a5,a5,536
    80007018:	853e                	mv	a0,a5
    8000701a:	ffffc097          	auipc	ra,0xffffc
    8000701e:	53c080e7          	jalr	1340(ra) # 80003556 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80007022:	fc843783          	ld	a5,-56(s0)
    80007026:	21c78793          	addi	a5,a5,540
    8000702a:	fc843703          	ld	a4,-56(s0)
    8000702e:	85ba                	mv	a1,a4
    80007030:	853e                	mv	a0,a5
    80007032:	ffffc097          	auipc	ra,0xffffc
    80007036:	4a8080e7          	jalr	1192(ra) # 800034da <sleep>
    8000703a:	a0ad                	j	800070a4 <pipewrite+0x110>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000703c:	fe043783          	ld	a5,-32(s0)
    80007040:	6ba8                	ld	a0,80(a5)
    80007042:	fec42703          	lw	a4,-20(s0)
    80007046:	fc043783          	ld	a5,-64(s0)
    8000704a:	973e                	add	a4,a4,a5
    8000704c:	fdf40793          	addi	a5,s0,-33
    80007050:	4685                	li	a3,1
    80007052:	863a                	mv	a2,a4
    80007054:	85be                	mv	a1,a5
    80007056:	ffffb097          	auipc	ra,0xffffb
    8000705a:	45a080e7          	jalr	1114(ra) # 800024b0 <copyin>
    8000705e:	87aa                	mv	a5,a0
    80007060:	873e                	mv	a4,a5
    80007062:	57fd                	li	a5,-1
    80007064:	04f70963          	beq	a4,a5,800070b6 <pipewrite+0x122>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80007068:	fc843783          	ld	a5,-56(s0)
    8000706c:	21c7a783          	lw	a5,540(a5)
    80007070:	2781                	sext.w	a5,a5
    80007072:	0017871b          	addiw	a4,a5,1
    80007076:	0007069b          	sext.w	a3,a4
    8000707a:	fc843703          	ld	a4,-56(s0)
    8000707e:	20d72e23          	sw	a3,540(a4)
    80007082:	1ff7f793          	andi	a5,a5,511
    80007086:	2781                	sext.w	a5,a5
    80007088:	fdf44703          	lbu	a4,-33(s0)
    8000708c:	fc843683          	ld	a3,-56(s0)
    80007090:	1782                	slli	a5,a5,0x20
    80007092:	9381                	srli	a5,a5,0x20
    80007094:	97b6                	add	a5,a5,a3
    80007096:	00e78c23          	sb	a4,24(a5)
      i++;
    8000709a:	fec42783          	lw	a5,-20(s0)
    8000709e:	2785                	addiw	a5,a5,1
    800070a0:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    800070a4:	fec42703          	lw	a4,-20(s0)
    800070a8:	fbc42783          	lw	a5,-68(s0)
    800070ac:	2701                	sext.w	a4,a4
    800070ae:	2781                	sext.w	a5,a5
    800070b0:	f0f74de3          	blt	a4,a5,80006fca <pipewrite+0x36>
    800070b4:	a011                	j	800070b8 <pipewrite+0x124>
        break;
    800070b6:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    800070b8:	fc843783          	ld	a5,-56(s0)
    800070bc:	21878793          	addi	a5,a5,536
    800070c0:	853e                	mv	a0,a5
    800070c2:	ffffc097          	auipc	ra,0xffffc
    800070c6:	494080e7          	jalr	1172(ra) # 80003556 <wakeup>
  release(&pi->lock);
    800070ca:	fc843783          	ld	a5,-56(s0)
    800070ce:	853e                	mv	a0,a5
    800070d0:	ffffa097          	auipc	ra,0xffffa
    800070d4:	2be080e7          	jalr	702(ra) # 8000138e <release>

  return i;
    800070d8:	fec42783          	lw	a5,-20(s0)
}
    800070dc:	853e                	mv	a0,a5
    800070de:	60a6                	ld	ra,72(sp)
    800070e0:	6406                	ld	s0,64(sp)
    800070e2:	6161                	addi	sp,sp,80
    800070e4:	8082                	ret

00000000800070e6 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800070e6:	715d                	addi	sp,sp,-80
    800070e8:	e486                	sd	ra,72(sp)
    800070ea:	e0a2                	sd	s0,64(sp)
    800070ec:	0880                	addi	s0,sp,80
    800070ee:	fca43423          	sd	a0,-56(s0)
    800070f2:	fcb43023          	sd	a1,-64(s0)
    800070f6:	87b2                	mv	a5,a2
    800070f8:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    800070fc:	ffffc097          	auipc	ra,0xffffc
    80007100:	81c080e7          	jalr	-2020(ra) # 80002918 <myproc>
    80007104:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80007108:	fc843783          	ld	a5,-56(s0)
    8000710c:	853e                	mv	a0,a5
    8000710e:	ffffa097          	auipc	ra,0xffffa
    80007112:	21c080e7          	jalr	540(ra) # 8000132a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007116:	a835                	j	80007152 <piperead+0x6c>
    if(killed(pr)){
    80007118:	fe043503          	ld	a0,-32(s0)
    8000711c:	ffffc097          	auipc	ra,0xffffc
    80007120:	5cc080e7          	jalr	1484(ra) # 800036e8 <killed>
    80007124:	87aa                	mv	a5,a0
    80007126:	cb91                	beqz	a5,8000713a <piperead+0x54>
      release(&pi->lock);
    80007128:	fc843783          	ld	a5,-56(s0)
    8000712c:	853e                	mv	a0,a5
    8000712e:	ffffa097          	auipc	ra,0xffffa
    80007132:	260080e7          	jalr	608(ra) # 8000138e <release>
      return -1;
    80007136:	57fd                	li	a5,-1
    80007138:	a8dd                	j	8000722e <piperead+0x148>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000713a:	fc843783          	ld	a5,-56(s0)
    8000713e:	21878793          	addi	a5,a5,536
    80007142:	fc843703          	ld	a4,-56(s0)
    80007146:	85ba                	mv	a1,a4
    80007148:	853e                	mv	a0,a5
    8000714a:	ffffc097          	auipc	ra,0xffffc
    8000714e:	390080e7          	jalr	912(ra) # 800034da <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007152:	fc843783          	ld	a5,-56(s0)
    80007156:	2187a703          	lw	a4,536(a5)
    8000715a:	fc843783          	ld	a5,-56(s0)
    8000715e:	21c7a783          	lw	a5,540(a5)
    80007162:	00f71763          	bne	a4,a5,80007170 <piperead+0x8a>
    80007166:	fc843783          	ld	a5,-56(s0)
    8000716a:	2247a783          	lw	a5,548(a5)
    8000716e:	f7cd                	bnez	a5,80007118 <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007170:	fe042623          	sw	zero,-20(s0)
    80007174:	a8bd                	j	800071f2 <piperead+0x10c>
    if(pi->nread == pi->nwrite)
    80007176:	fc843783          	ld	a5,-56(s0)
    8000717a:	2187a703          	lw	a4,536(a5)
    8000717e:	fc843783          	ld	a5,-56(s0)
    80007182:	21c7a783          	lw	a5,540(a5)
    80007186:	06f70f63          	beq	a4,a5,80007204 <piperead+0x11e>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000718a:	fc843783          	ld	a5,-56(s0)
    8000718e:	2187a783          	lw	a5,536(a5)
    80007192:	2781                	sext.w	a5,a5
    80007194:	0017871b          	addiw	a4,a5,1
    80007198:	0007069b          	sext.w	a3,a4
    8000719c:	fc843703          	ld	a4,-56(s0)
    800071a0:	20d72c23          	sw	a3,536(a4)
    800071a4:	1ff7f793          	andi	a5,a5,511
    800071a8:	2781                	sext.w	a5,a5
    800071aa:	fc843703          	ld	a4,-56(s0)
    800071ae:	1782                	slli	a5,a5,0x20
    800071b0:	9381                	srli	a5,a5,0x20
    800071b2:	97ba                	add	a5,a5,a4
    800071b4:	0187c783          	lbu	a5,24(a5)
    800071b8:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800071bc:	fe043783          	ld	a5,-32(s0)
    800071c0:	6ba8                	ld	a0,80(a5)
    800071c2:	fec42703          	lw	a4,-20(s0)
    800071c6:	fc043783          	ld	a5,-64(s0)
    800071ca:	97ba                	add	a5,a5,a4
    800071cc:	fdf40713          	addi	a4,s0,-33
    800071d0:	4685                	li	a3,1
    800071d2:	863a                	mv	a2,a4
    800071d4:	85be                	mv	a1,a5
    800071d6:	ffffb097          	auipc	ra,0xffffb
    800071da:	20c080e7          	jalr	524(ra) # 800023e2 <copyout>
    800071de:	87aa                	mv	a5,a0
    800071e0:	873e                	mv	a4,a5
    800071e2:	57fd                	li	a5,-1
    800071e4:	02f70263          	beq	a4,a5,80007208 <piperead+0x122>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800071e8:	fec42783          	lw	a5,-20(s0)
    800071ec:	2785                	addiw	a5,a5,1
    800071ee:	fef42623          	sw	a5,-20(s0)
    800071f2:	fec42703          	lw	a4,-20(s0)
    800071f6:	fbc42783          	lw	a5,-68(s0)
    800071fa:	2701                	sext.w	a4,a4
    800071fc:	2781                	sext.w	a5,a5
    800071fe:	f6f74ce3          	blt	a4,a5,80007176 <piperead+0x90>
    80007202:	a021                	j	8000720a <piperead+0x124>
      break;
    80007204:	0001                	nop
    80007206:	a011                	j	8000720a <piperead+0x124>
      break;
    80007208:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000720a:	fc843783          	ld	a5,-56(s0)
    8000720e:	21c78793          	addi	a5,a5,540
    80007212:	853e                	mv	a0,a5
    80007214:	ffffc097          	auipc	ra,0xffffc
    80007218:	342080e7          	jalr	834(ra) # 80003556 <wakeup>
  release(&pi->lock);
    8000721c:	fc843783          	ld	a5,-56(s0)
    80007220:	853e                	mv	a0,a5
    80007222:	ffffa097          	auipc	ra,0xffffa
    80007226:	16c080e7          	jalr	364(ra) # 8000138e <release>
  return i;
    8000722a:	fec42783          	lw	a5,-20(s0)
}
    8000722e:	853e                	mv	a0,a5
    80007230:	60a6                	ld	ra,72(sp)
    80007232:	6406                	ld	s0,64(sp)
    80007234:	6161                	addi	sp,sp,80
    80007236:	8082                	ret

0000000080007238 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80007238:	7179                	addi	sp,sp,-48
    8000723a:	f422                	sd	s0,40(sp)
    8000723c:	1800                	addi	s0,sp,48
    8000723e:	87aa                	mv	a5,a0
    80007240:	fcf42e23          	sw	a5,-36(s0)
    int perm = 0;
    80007244:	fe042623          	sw	zero,-20(s0)
    if(flags & 0x1)
    80007248:	fdc42783          	lw	a5,-36(s0)
    8000724c:	8b85                	andi	a5,a5,1
    8000724e:	2781                	sext.w	a5,a5
    80007250:	c781                	beqz	a5,80007258 <flags2perm+0x20>
      perm = PTE_X;
    80007252:	47a1                	li	a5,8
    80007254:	fef42623          	sw	a5,-20(s0)
    if(flags & 0x2)
    80007258:	fdc42783          	lw	a5,-36(s0)
    8000725c:	8b89                	andi	a5,a5,2
    8000725e:	2781                	sext.w	a5,a5
    80007260:	c799                	beqz	a5,8000726e <flags2perm+0x36>
      perm |= PTE_W;
    80007262:	fec42783          	lw	a5,-20(s0)
    80007266:	0047e793          	ori	a5,a5,4
    8000726a:	fef42623          	sw	a5,-20(s0)
    return perm;
    8000726e:	fec42783          	lw	a5,-20(s0)
}
    80007272:	853e                	mv	a0,a5
    80007274:	7422                	ld	s0,40(sp)
    80007276:	6145                	addi	sp,sp,48
    80007278:	8082                	ret

000000008000727a <exec>:

int
exec(char *path, char **argv)
{
    8000727a:	de010113          	addi	sp,sp,-544
    8000727e:	20113c23          	sd	ra,536(sp)
    80007282:	20813823          	sd	s0,528(sp)
    80007286:	20913423          	sd	s1,520(sp)
    8000728a:	1400                	addi	s0,sp,544
    8000728c:	dea43423          	sd	a0,-536(s0)
    80007290:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80007294:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80007298:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    8000729c:	ffffb097          	auipc	ra,0xffffb
    800072a0:	67c080e7          	jalr	1660(ra) # 80002918 <myproc>
    800072a4:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    800072a8:	fffff097          	auipc	ra,0xfffff
    800072ac:	f40080e7          	jalr	-192(ra) # 800061e8 <begin_op>

  if((ip = namei(path)) == 0){
    800072b0:	de843503          	ld	a0,-536(s0)
    800072b4:	fffff097          	auipc	ra,0xfffff
    800072b8:	bd0080e7          	jalr	-1072(ra) # 80005e84 <namei>
    800072bc:	faa43423          	sd	a0,-88(s0)
    800072c0:	fa843783          	ld	a5,-88(s0)
    800072c4:	e799                	bnez	a5,800072d2 <exec+0x58>
    end_op();
    800072c6:	fffff097          	auipc	ra,0xfffff
    800072ca:	fe4080e7          	jalr	-28(ra) # 800062aa <end_op>
    return -1;
    800072ce:	57fd                	li	a5,-1
    800072d0:	a1a9                	j	8000771a <exec+0x4a0>
  }
  ilock(ip);
    800072d2:	fa843503          	ld	a0,-88(s0)
    800072d6:	ffffe097          	auipc	ra,0xffffe
    800072da:	e88080e7          	jalr	-376(ra) # 8000515e <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800072de:	e3040793          	addi	a5,s0,-464
    800072e2:	04000713          	li	a4,64
    800072e6:	4681                	li	a3,0
    800072e8:	863e                	mv	a2,a5
    800072ea:	4581                	li	a1,0
    800072ec:	fa843503          	ld	a0,-88(s0)
    800072f0:	ffffe097          	auipc	ra,0xffffe
    800072f4:	424080e7          	jalr	1060(ra) # 80005714 <readi>
    800072f8:	87aa                	mv	a5,a0
    800072fa:	873e                	mv	a4,a5
    800072fc:	04000793          	li	a5,64
    80007300:	3af71763          	bne	a4,a5,800076ae <exec+0x434>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80007304:	e3042783          	lw	a5,-464(s0)
    80007308:	873e                	mv	a4,a5
    8000730a:	464c47b7          	lui	a5,0x464c4
    8000730e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80007312:	3af71063          	bne	a4,a5,800076b2 <exec+0x438>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007316:	f9843503          	ld	a0,-104(s0)
    8000731a:	ffffc097          	auipc	ra,0xffffc
    8000731e:	860080e7          	jalr	-1952(ra) # 80002b7a <proc_pagetable>
    80007322:	faa43023          	sd	a0,-96(s0)
    80007326:	fa043783          	ld	a5,-96(s0)
    8000732a:	38078663          	beqz	a5,800076b6 <exec+0x43c>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000732e:	fc042623          	sw	zero,-52(s0)
    80007332:	e5043783          	ld	a5,-432(s0)
    80007336:	fcf42423          	sw	a5,-56(s0)
    8000733a:	a0fd                	j	80007428 <exec+0x1ae>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000733c:	df840793          	addi	a5,s0,-520
    80007340:	fc842683          	lw	a3,-56(s0)
    80007344:	03800713          	li	a4,56
    80007348:	863e                	mv	a2,a5
    8000734a:	4581                	li	a1,0
    8000734c:	fa843503          	ld	a0,-88(s0)
    80007350:	ffffe097          	auipc	ra,0xffffe
    80007354:	3c4080e7          	jalr	964(ra) # 80005714 <readi>
    80007358:	87aa                	mv	a5,a0
    8000735a:	873e                	mv	a4,a5
    8000735c:	03800793          	li	a5,56
    80007360:	34f71d63          	bne	a4,a5,800076ba <exec+0x440>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80007364:	df842783          	lw	a5,-520(s0)
    80007368:	873e                	mv	a4,a5
    8000736a:	4785                	li	a5,1
    8000736c:	0af71163          	bne	a4,a5,8000740e <exec+0x194>
      continue;
    if(ph.memsz < ph.filesz)
    80007370:	e2043703          	ld	a4,-480(s0)
    80007374:	e1843783          	ld	a5,-488(s0)
    80007378:	34f76363          	bltu	a4,a5,800076be <exec+0x444>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    8000737c:	e0843703          	ld	a4,-504(s0)
    80007380:	e2043783          	ld	a5,-480(s0)
    80007384:	973e                	add	a4,a4,a5
    80007386:	e0843783          	ld	a5,-504(s0)
    8000738a:	32f76c63          	bltu	a4,a5,800076c2 <exec+0x448>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
    8000738e:	e0843703          	ld	a4,-504(s0)
    80007392:	6785                	lui	a5,0x1
    80007394:	17fd                	addi	a5,a5,-1
    80007396:	8ff9                	and	a5,a5,a4
    80007398:	32079763          	bnez	a5,800076c6 <exec+0x44c>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000739c:	e0843703          	ld	a4,-504(s0)
    800073a0:	e2043783          	ld	a5,-480(s0)
    800073a4:	00f704b3          	add	s1,a4,a5
    800073a8:	dfc42783          	lw	a5,-516(s0)
    800073ac:	2781                	sext.w	a5,a5
    800073ae:	853e                	mv	a0,a5
    800073b0:	00000097          	auipc	ra,0x0
    800073b4:	e88080e7          	jalr	-376(ra) # 80007238 <flags2perm>
    800073b8:	87aa                	mv	a5,a0
    800073ba:	86be                	mv	a3,a5
    800073bc:	8626                	mv	a2,s1
    800073be:	fb843583          	ld	a1,-72(s0)
    800073c2:	fa043503          	ld	a0,-96(s0)
    800073c6:	ffffb097          	auipc	ra,0xffffb
    800073ca:	c30080e7          	jalr	-976(ra) # 80001ff6 <uvmalloc>
    800073ce:	f6a43823          	sd	a0,-144(s0)
    800073d2:	f7043783          	ld	a5,-144(s0)
    800073d6:	2e078a63          	beqz	a5,800076ca <exec+0x450>
      goto bad;
    sz = sz1;
    800073da:	f7043783          	ld	a5,-144(s0)
    800073de:	faf43c23          	sd	a5,-72(s0)
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800073e2:	e0843783          	ld	a5,-504(s0)
    800073e6:	e0043703          	ld	a4,-512(s0)
    800073ea:	0007069b          	sext.w	a3,a4
    800073ee:	e1843703          	ld	a4,-488(s0)
    800073f2:	2701                	sext.w	a4,a4
    800073f4:	fa843603          	ld	a2,-88(s0)
    800073f8:	85be                	mv	a1,a5
    800073fa:	fa043503          	ld	a0,-96(s0)
    800073fe:	00000097          	auipc	ra,0x0
    80007402:	330080e7          	jalr	816(ra) # 8000772e <loadseg>
    80007406:	87aa                	mv	a5,a0
    80007408:	2c07c363          	bltz	a5,800076ce <exec+0x454>
    8000740c:	a011                	j	80007410 <exec+0x196>
      continue;
    8000740e:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007410:	fcc42783          	lw	a5,-52(s0)
    80007414:	2785                	addiw	a5,a5,1
    80007416:	fcf42623          	sw	a5,-52(s0)
    8000741a:	fc842783          	lw	a5,-56(s0)
    8000741e:	0387879b          	addiw	a5,a5,56
    80007422:	2781                	sext.w	a5,a5
    80007424:	fcf42423          	sw	a5,-56(s0)
    80007428:	e6845783          	lhu	a5,-408(s0)
    8000742c:	0007871b          	sext.w	a4,a5
    80007430:	fcc42783          	lw	a5,-52(s0)
    80007434:	2781                	sext.w	a5,a5
    80007436:	f0e7c3e3          	blt	a5,a4,8000733c <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    8000743a:	fa843503          	ld	a0,-88(s0)
    8000743e:	ffffe097          	auipc	ra,0xffffe
    80007442:	f7e080e7          	jalr	-130(ra) # 800053bc <iunlockput>
  end_op();
    80007446:	fffff097          	auipc	ra,0xfffff
    8000744a:	e64080e7          	jalr	-412(ra) # 800062aa <end_op>
  ip = 0;
    8000744e:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80007452:	ffffb097          	auipc	ra,0xffffb
    80007456:	4c6080e7          	jalr	1222(ra) # 80002918 <myproc>
    8000745a:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    8000745e:	f9843783          	ld	a5,-104(s0)
    80007462:	67bc                	ld	a5,72(a5)
    80007464:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible as a stack guard.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80007468:	fb843703          	ld	a4,-72(s0)
    8000746c:	6785                	lui	a5,0x1
    8000746e:	17fd                	addi	a5,a5,-1
    80007470:	973e                	add	a4,a4,a5
    80007472:	77fd                	lui	a5,0xfffff
    80007474:	8ff9                	and	a5,a5,a4
    80007476:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    8000747a:	fb843703          	ld	a4,-72(s0)
    8000747e:	6789                	lui	a5,0x2
    80007480:	97ba                	add	a5,a5,a4
    80007482:	4691                	li	a3,4
    80007484:	863e                	mv	a2,a5
    80007486:	fb843583          	ld	a1,-72(s0)
    8000748a:	fa043503          	ld	a0,-96(s0)
    8000748e:	ffffb097          	auipc	ra,0xffffb
    80007492:	b68080e7          	jalr	-1176(ra) # 80001ff6 <uvmalloc>
    80007496:	f8a43423          	sd	a0,-120(s0)
    8000749a:	f8843783          	ld	a5,-120(s0)
    8000749e:	22078a63          	beqz	a5,800076d2 <exec+0x458>
    goto bad;
  sz = sz1;
    800074a2:	f8843783          	ld	a5,-120(s0)
    800074a6:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    800074aa:	fb843703          	ld	a4,-72(s0)
    800074ae:	77f9                	lui	a5,0xffffe
    800074b0:	97ba                	add	a5,a5,a4
    800074b2:	85be                	mv	a1,a5
    800074b4:	fa043503          	ld	a0,-96(s0)
    800074b8:	ffffb097          	auipc	ra,0xffffb
    800074bc:	ed4080e7          	jalr	-300(ra) # 8000238c <uvmclear>
  sp = sz;
    800074c0:	fb843783          	ld	a5,-72(s0)
    800074c4:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    800074c8:	fb043703          	ld	a4,-80(s0)
    800074cc:	77fd                	lui	a5,0xfffff
    800074ce:	97ba                	add	a5,a5,a4
    800074d0:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    800074d4:	fc043023          	sd	zero,-64(s0)
    800074d8:	a845                	j	80007588 <exec+0x30e>
    if(argc >= MAXARG)
    800074da:	fc043703          	ld	a4,-64(s0)
    800074de:	47fd                	li	a5,31
    800074e0:	1ee7eb63          	bltu	a5,a4,800076d6 <exec+0x45c>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    800074e4:	fc043783          	ld	a5,-64(s0)
    800074e8:	078e                	slli	a5,a5,0x3
    800074ea:	de043703          	ld	a4,-544(s0)
    800074ee:	97ba                	add	a5,a5,a4
    800074f0:	639c                	ld	a5,0(a5)
    800074f2:	853e                	mv	a0,a5
    800074f4:	ffffa097          	auipc	ra,0xffffa
    800074f8:	388080e7          	jalr	904(ra) # 8000187c <strlen>
    800074fc:	87aa                	mv	a5,a0
    800074fe:	2785                	addiw	a5,a5,1
    80007500:	2781                	sext.w	a5,a5
    80007502:	873e                	mv	a4,a5
    80007504:	fb043783          	ld	a5,-80(s0)
    80007508:	8f99                	sub	a5,a5,a4
    8000750a:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000750e:	fb043783          	ld	a5,-80(s0)
    80007512:	9bc1                	andi	a5,a5,-16
    80007514:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80007518:	fb043703          	ld	a4,-80(s0)
    8000751c:	f8043783          	ld	a5,-128(s0)
    80007520:	1af76d63          	bltu	a4,a5,800076da <exec+0x460>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80007524:	fc043783          	ld	a5,-64(s0)
    80007528:	078e                	slli	a5,a5,0x3
    8000752a:	de043703          	ld	a4,-544(s0)
    8000752e:	97ba                	add	a5,a5,a4
    80007530:	6384                	ld	s1,0(a5)
    80007532:	fc043783          	ld	a5,-64(s0)
    80007536:	078e                	slli	a5,a5,0x3
    80007538:	de043703          	ld	a4,-544(s0)
    8000753c:	97ba                	add	a5,a5,a4
    8000753e:	639c                	ld	a5,0(a5)
    80007540:	853e                	mv	a0,a5
    80007542:	ffffa097          	auipc	ra,0xffffa
    80007546:	33a080e7          	jalr	826(ra) # 8000187c <strlen>
    8000754a:	87aa                	mv	a5,a0
    8000754c:	2785                	addiw	a5,a5,1
    8000754e:	2781                	sext.w	a5,a5
    80007550:	86be                	mv	a3,a5
    80007552:	8626                	mv	a2,s1
    80007554:	fb043583          	ld	a1,-80(s0)
    80007558:	fa043503          	ld	a0,-96(s0)
    8000755c:	ffffb097          	auipc	ra,0xffffb
    80007560:	e86080e7          	jalr	-378(ra) # 800023e2 <copyout>
    80007564:	87aa                	mv	a5,a0
    80007566:	1607cc63          	bltz	a5,800076de <exec+0x464>
      goto bad;
    ustack[argc] = sp;
    8000756a:	fc043783          	ld	a5,-64(s0)
    8000756e:	078e                	slli	a5,a5,0x3
    80007570:	fe040713          	addi	a4,s0,-32
    80007574:	97ba                	add	a5,a5,a4
    80007576:	fb043703          	ld	a4,-80(s0)
    8000757a:	e8e7b823          	sd	a4,-368(a5) # ffffffffffffee90 <end+0xffffffff7ffd9f60>
  for(argc = 0; argv[argc]; argc++) {
    8000757e:	fc043783          	ld	a5,-64(s0)
    80007582:	0785                	addi	a5,a5,1
    80007584:	fcf43023          	sd	a5,-64(s0)
    80007588:	fc043783          	ld	a5,-64(s0)
    8000758c:	078e                	slli	a5,a5,0x3
    8000758e:	de043703          	ld	a4,-544(s0)
    80007592:	97ba                	add	a5,a5,a4
    80007594:	639c                	ld	a5,0(a5)
    80007596:	f3b1                	bnez	a5,800074da <exec+0x260>
  }
  ustack[argc] = 0;
    80007598:	fc043783          	ld	a5,-64(s0)
    8000759c:	078e                	slli	a5,a5,0x3
    8000759e:	fe040713          	addi	a4,s0,-32
    800075a2:	97ba                	add	a5,a5,a4
    800075a4:	e807b823          	sd	zero,-368(a5)

  // push the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    800075a8:	fc043783          	ld	a5,-64(s0)
    800075ac:	0785                	addi	a5,a5,1
    800075ae:	078e                	slli	a5,a5,0x3
    800075b0:	fb043703          	ld	a4,-80(s0)
    800075b4:	40f707b3          	sub	a5,a4,a5
    800075b8:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    800075bc:	fb043783          	ld	a5,-80(s0)
    800075c0:	9bc1                	andi	a5,a5,-16
    800075c2:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    800075c6:	fb043703          	ld	a4,-80(s0)
    800075ca:	f8043783          	ld	a5,-128(s0)
    800075ce:	10f76a63          	bltu	a4,a5,800076e2 <exec+0x468>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800075d2:	fc043783          	ld	a5,-64(s0)
    800075d6:	0785                	addi	a5,a5,1
    800075d8:	00379713          	slli	a4,a5,0x3
    800075dc:	e7040793          	addi	a5,s0,-400
    800075e0:	86ba                	mv	a3,a4
    800075e2:	863e                	mv	a2,a5
    800075e4:	fb043583          	ld	a1,-80(s0)
    800075e8:	fa043503          	ld	a0,-96(s0)
    800075ec:	ffffb097          	auipc	ra,0xffffb
    800075f0:	df6080e7          	jalr	-522(ra) # 800023e2 <copyout>
    800075f4:	87aa                	mv	a5,a0
    800075f6:	0e07c863          	bltz	a5,800076e6 <exec+0x46c>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    800075fa:	f9843783          	ld	a5,-104(s0)
    800075fe:	6fbc                	ld	a5,88(a5)
    80007600:	fb043703          	ld	a4,-80(s0)
    80007604:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80007606:	de843783          	ld	a5,-536(s0)
    8000760a:	fcf43c23          	sd	a5,-40(s0)
    8000760e:	fd843783          	ld	a5,-40(s0)
    80007612:	fcf43823          	sd	a5,-48(s0)
    80007616:	a025                	j	8000763e <exec+0x3c4>
    if(*s == '/')
    80007618:	fd843783          	ld	a5,-40(s0)
    8000761c:	0007c783          	lbu	a5,0(a5)
    80007620:	873e                	mv	a4,a5
    80007622:	02f00793          	li	a5,47
    80007626:	00f71763          	bne	a4,a5,80007634 <exec+0x3ba>
      last = s+1;
    8000762a:	fd843783          	ld	a5,-40(s0)
    8000762e:	0785                	addi	a5,a5,1
    80007630:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80007634:	fd843783          	ld	a5,-40(s0)
    80007638:	0785                	addi	a5,a5,1
    8000763a:	fcf43c23          	sd	a5,-40(s0)
    8000763e:	fd843783          	ld	a5,-40(s0)
    80007642:	0007c783          	lbu	a5,0(a5)
    80007646:	fbe9                	bnez	a5,80007618 <exec+0x39e>
  safestrcpy(p->name, last, sizeof(p->name));
    80007648:	f9843783          	ld	a5,-104(s0)
    8000764c:	15878793          	addi	a5,a5,344
    80007650:	4641                	li	a2,16
    80007652:	fd043583          	ld	a1,-48(s0)
    80007656:	853e                	mv	a0,a5
    80007658:	ffffa097          	auipc	ra,0xffffa
    8000765c:	1aa080e7          	jalr	426(ra) # 80001802 <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    80007660:	f9843783          	ld	a5,-104(s0)
    80007664:	6bbc                	ld	a5,80(a5)
    80007666:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    8000766a:	f9843783          	ld	a5,-104(s0)
    8000766e:	fa043703          	ld	a4,-96(s0)
    80007672:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    80007674:	f9843783          	ld	a5,-104(s0)
    80007678:	fb843703          	ld	a4,-72(s0)
    8000767c:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000767e:	f9843783          	ld	a5,-104(s0)
    80007682:	6fbc                	ld	a5,88(a5)
    80007684:	e4843703          	ld	a4,-440(s0)
    80007688:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    8000768a:	f9843783          	ld	a5,-104(s0)
    8000768e:	6fbc                	ld	a5,88(a5)
    80007690:	fb043703          	ld	a4,-80(s0)
    80007694:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80007696:	f9043583          	ld	a1,-112(s0)
    8000769a:	f7843503          	ld	a0,-136(s0)
    8000769e:	ffffb097          	auipc	ra,0xffffb
    800076a2:	59c080e7          	jalr	1436(ra) # 80002c3a <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800076a6:	fc043783          	ld	a5,-64(s0)
    800076aa:	2781                	sext.w	a5,a5
    800076ac:	a0bd                	j	8000771a <exec+0x4a0>
    goto bad;
    800076ae:	0001                	nop
    800076b0:	a825                	j	800076e8 <exec+0x46e>
    goto bad;
    800076b2:	0001                	nop
    800076b4:	a815                	j	800076e8 <exec+0x46e>
    goto bad;
    800076b6:	0001                	nop
    800076b8:	a805                	j	800076e8 <exec+0x46e>
      goto bad;
    800076ba:	0001                	nop
    800076bc:	a035                	j	800076e8 <exec+0x46e>
      goto bad;
    800076be:	0001                	nop
    800076c0:	a025                	j	800076e8 <exec+0x46e>
      goto bad;
    800076c2:	0001                	nop
    800076c4:	a015                	j	800076e8 <exec+0x46e>
      goto bad;
    800076c6:	0001                	nop
    800076c8:	a005                	j	800076e8 <exec+0x46e>
      goto bad;
    800076ca:	0001                	nop
    800076cc:	a831                	j	800076e8 <exec+0x46e>
      goto bad;
    800076ce:	0001                	nop
    800076d0:	a821                	j	800076e8 <exec+0x46e>
    goto bad;
    800076d2:	0001                	nop
    800076d4:	a811                	j	800076e8 <exec+0x46e>
      goto bad;
    800076d6:	0001                	nop
    800076d8:	a801                	j	800076e8 <exec+0x46e>
      goto bad;
    800076da:	0001                	nop
    800076dc:	a031                	j	800076e8 <exec+0x46e>
      goto bad;
    800076de:	0001                	nop
    800076e0:	a021                	j	800076e8 <exec+0x46e>
    goto bad;
    800076e2:	0001                	nop
    800076e4:	a011                	j	800076e8 <exec+0x46e>
    goto bad;
    800076e6:	0001                	nop

 bad:
  if(pagetable)
    800076e8:	fa043783          	ld	a5,-96(s0)
    800076ec:	cb89                	beqz	a5,800076fe <exec+0x484>
    proc_freepagetable(pagetable, sz);
    800076ee:	fb843583          	ld	a1,-72(s0)
    800076f2:	fa043503          	ld	a0,-96(s0)
    800076f6:	ffffb097          	auipc	ra,0xffffb
    800076fa:	544080e7          	jalr	1348(ra) # 80002c3a <proc_freepagetable>
  if(ip){
    800076fe:	fa843783          	ld	a5,-88(s0)
    80007702:	cb99                	beqz	a5,80007718 <exec+0x49e>
    iunlockput(ip);
    80007704:	fa843503          	ld	a0,-88(s0)
    80007708:	ffffe097          	auipc	ra,0xffffe
    8000770c:	cb4080e7          	jalr	-844(ra) # 800053bc <iunlockput>
    end_op();
    80007710:	fffff097          	auipc	ra,0xfffff
    80007714:	b9a080e7          	jalr	-1126(ra) # 800062aa <end_op>
  }
  return -1;
    80007718:	57fd                	li	a5,-1
}
    8000771a:	853e                	mv	a0,a5
    8000771c:	21813083          	ld	ra,536(sp)
    80007720:	21013403          	ld	s0,528(sp)
    80007724:	20813483          	ld	s1,520(sp)
    80007728:	22010113          	addi	sp,sp,544
    8000772c:	8082                	ret

000000008000772e <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    8000772e:	7139                	addi	sp,sp,-64
    80007730:	fc06                	sd	ra,56(sp)
    80007732:	f822                	sd	s0,48(sp)
    80007734:	0080                	addi	s0,sp,64
    80007736:	fca43c23          	sd	a0,-40(s0)
    8000773a:	fcb43823          	sd	a1,-48(s0)
    8000773e:	fcc43423          	sd	a2,-56(s0)
    80007742:	87b6                	mv	a5,a3
    80007744:	fcf42223          	sw	a5,-60(s0)
    80007748:	87ba                	mv	a5,a4
    8000774a:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    8000774e:	fe042623          	sw	zero,-20(s0)
    80007752:	a05d                	j	800077f8 <loadseg+0xca>
    pa = walkaddr(pagetable, va + i);
    80007754:	fec46703          	lwu	a4,-20(s0)
    80007758:	fd043783          	ld	a5,-48(s0)
    8000775c:	97ba                	add	a5,a5,a4
    8000775e:	85be                	mv	a1,a5
    80007760:	fd843503          	ld	a0,-40(s0)
    80007764:	ffffa097          	auipc	ra,0xffffa
    80007768:	51e080e7          	jalr	1310(ra) # 80001c82 <walkaddr>
    8000776c:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80007770:	fe043783          	ld	a5,-32(s0)
    80007774:	eb89                	bnez	a5,80007786 <loadseg+0x58>
      panic("loadseg: address should exist");
    80007776:	00004517          	auipc	a0,0x4
    8000777a:	e8a50513          	addi	a0,a0,-374 # 8000b600 <etext+0x600>
    8000777e:	ffff9097          	auipc	ra,0xffff9
    80007782:	50e080e7          	jalr	1294(ra) # 80000c8c <panic>
    if(sz - i < PGSIZE)
    80007786:	fc042703          	lw	a4,-64(s0)
    8000778a:	fec42783          	lw	a5,-20(s0)
    8000778e:	40f707bb          	subw	a5,a4,a5
    80007792:	2781                	sext.w	a5,a5
    80007794:	873e                	mv	a4,a5
    80007796:	6785                	lui	a5,0x1
    80007798:	00f77b63          	bgeu	a4,a5,800077ae <loadseg+0x80>
      n = sz - i;
    8000779c:	fc042703          	lw	a4,-64(s0)
    800077a0:	fec42783          	lw	a5,-20(s0)
    800077a4:	40f707bb          	subw	a5,a4,a5
    800077a8:	fef42423          	sw	a5,-24(s0)
    800077ac:	a021                	j	800077b4 <loadseg+0x86>
    else
      n = PGSIZE;
    800077ae:	6785                	lui	a5,0x1
    800077b0:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800077b4:	fc442703          	lw	a4,-60(s0)
    800077b8:	fec42783          	lw	a5,-20(s0)
    800077bc:	9fb9                	addw	a5,a5,a4
    800077be:	2781                	sext.w	a5,a5
    800077c0:	fe842703          	lw	a4,-24(s0)
    800077c4:	86be                	mv	a3,a5
    800077c6:	fe043603          	ld	a2,-32(s0)
    800077ca:	4581                	li	a1,0
    800077cc:	fc843503          	ld	a0,-56(s0)
    800077d0:	ffffe097          	auipc	ra,0xffffe
    800077d4:	f44080e7          	jalr	-188(ra) # 80005714 <readi>
    800077d8:	87aa                	mv	a5,a0
    800077da:	0007871b          	sext.w	a4,a5
    800077de:	fe842783          	lw	a5,-24(s0)
    800077e2:	2781                	sext.w	a5,a5
    800077e4:	00e78463          	beq	a5,a4,800077ec <loadseg+0xbe>
      return -1;
    800077e8:	57fd                	li	a5,-1
    800077ea:	a005                	j	8000780a <loadseg+0xdc>
  for(i = 0; i < sz; i += PGSIZE){
    800077ec:	fec42703          	lw	a4,-20(s0)
    800077f0:	6785                	lui	a5,0x1
    800077f2:	9fb9                	addw	a5,a5,a4
    800077f4:	fef42623          	sw	a5,-20(s0)
    800077f8:	fec42703          	lw	a4,-20(s0)
    800077fc:	fc042783          	lw	a5,-64(s0)
    80007800:	2701                	sext.w	a4,a4
    80007802:	2781                	sext.w	a5,a5
    80007804:	f4f768e3          	bltu	a4,a5,80007754 <loadseg+0x26>
  }
  
  return 0;
    80007808:	4781                	li	a5,0
}
    8000780a:	853e                	mv	a0,a5
    8000780c:	70e2                	ld	ra,56(sp)
    8000780e:	7442                	ld	s0,48(sp)
    80007810:	6121                	addi	sp,sp,64
    80007812:	8082                	ret

0000000080007814 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80007814:	7139                	addi	sp,sp,-64
    80007816:	fc06                	sd	ra,56(sp)
    80007818:	f822                	sd	s0,48(sp)
    8000781a:	0080                	addi	s0,sp,64
    8000781c:	87aa                	mv	a5,a0
    8000781e:	fcb43823          	sd	a1,-48(s0)
    80007822:	fcc43423          	sd	a2,-56(s0)
    80007826:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  argint(n, &fd);
    8000782a:	fe440713          	addi	a4,s0,-28
    8000782e:	fdc42783          	lw	a5,-36(s0)
    80007832:	85ba                	mv	a1,a4
    80007834:	853e                	mv	a0,a5
    80007836:	ffffd097          	auipc	ra,0xffffd
    8000783a:	980080e7          	jalr	-1664(ra) # 800041b6 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000783e:	fe442783          	lw	a5,-28(s0)
    80007842:	0207c863          	bltz	a5,80007872 <argfd+0x5e>
    80007846:	fe442783          	lw	a5,-28(s0)
    8000784a:	873e                	mv	a4,a5
    8000784c:	47bd                	li	a5,15
    8000784e:	02e7c263          	blt	a5,a4,80007872 <argfd+0x5e>
    80007852:	ffffb097          	auipc	ra,0xffffb
    80007856:	0c6080e7          	jalr	198(ra) # 80002918 <myproc>
    8000785a:	872a                	mv	a4,a0
    8000785c:	fe442783          	lw	a5,-28(s0)
    80007860:	07e9                	addi	a5,a5,26
    80007862:	078e                	slli	a5,a5,0x3
    80007864:	97ba                	add	a5,a5,a4
    80007866:	639c                	ld	a5,0(a5)
    80007868:	fef43423          	sd	a5,-24(s0)
    8000786c:	fe843783          	ld	a5,-24(s0)
    80007870:	e399                	bnez	a5,80007876 <argfd+0x62>
    return -1;
    80007872:	57fd                	li	a5,-1
    80007874:	a015                	j	80007898 <argfd+0x84>
  if(pfd)
    80007876:	fd043783          	ld	a5,-48(s0)
    8000787a:	c791                	beqz	a5,80007886 <argfd+0x72>
    *pfd = fd;
    8000787c:	fe442703          	lw	a4,-28(s0)
    80007880:	fd043783          	ld	a5,-48(s0)
    80007884:	c398                	sw	a4,0(a5)
  if(pf)
    80007886:	fc843783          	ld	a5,-56(s0)
    8000788a:	c791                	beqz	a5,80007896 <argfd+0x82>
    *pf = f;
    8000788c:	fc843783          	ld	a5,-56(s0)
    80007890:	fe843703          	ld	a4,-24(s0)
    80007894:	e398                	sd	a4,0(a5)
  return 0;
    80007896:	4781                	li	a5,0
}
    80007898:	853e                	mv	a0,a5
    8000789a:	70e2                	ld	ra,56(sp)
    8000789c:	7442                	ld	s0,48(sp)
    8000789e:	6121                	addi	sp,sp,64
    800078a0:	8082                	ret

00000000800078a2 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800078a2:	7179                	addi	sp,sp,-48
    800078a4:	f406                	sd	ra,40(sp)
    800078a6:	f022                	sd	s0,32(sp)
    800078a8:	1800                	addi	s0,sp,48
    800078aa:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    800078ae:	ffffb097          	auipc	ra,0xffffb
    800078b2:	06a080e7          	jalr	106(ra) # 80002918 <myproc>
    800078b6:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    800078ba:	fe042623          	sw	zero,-20(s0)
    800078be:	a825                	j	800078f6 <fdalloc+0x54>
    if(p->ofile[fd] == 0){
    800078c0:	fe043703          	ld	a4,-32(s0)
    800078c4:	fec42783          	lw	a5,-20(s0)
    800078c8:	07e9                	addi	a5,a5,26
    800078ca:	078e                	slli	a5,a5,0x3
    800078cc:	97ba                	add	a5,a5,a4
    800078ce:	639c                	ld	a5,0(a5)
    800078d0:	ef91                	bnez	a5,800078ec <fdalloc+0x4a>
      p->ofile[fd] = f;
    800078d2:	fe043703          	ld	a4,-32(s0)
    800078d6:	fec42783          	lw	a5,-20(s0)
    800078da:	07e9                	addi	a5,a5,26
    800078dc:	078e                	slli	a5,a5,0x3
    800078de:	97ba                	add	a5,a5,a4
    800078e0:	fd843703          	ld	a4,-40(s0)
    800078e4:	e398                	sd	a4,0(a5)
      return fd;
    800078e6:	fec42783          	lw	a5,-20(s0)
    800078ea:	a831                	j	80007906 <fdalloc+0x64>
  for(fd = 0; fd < NOFILE; fd++){
    800078ec:	fec42783          	lw	a5,-20(s0)
    800078f0:	2785                	addiw	a5,a5,1
    800078f2:	fef42623          	sw	a5,-20(s0)
    800078f6:	fec42783          	lw	a5,-20(s0)
    800078fa:	0007871b          	sext.w	a4,a5
    800078fe:	47bd                	li	a5,15
    80007900:	fce7d0e3          	bge	a5,a4,800078c0 <fdalloc+0x1e>
    }
  }
  return -1;
    80007904:	57fd                	li	a5,-1
}
    80007906:	853e                	mv	a0,a5
    80007908:	70a2                	ld	ra,40(sp)
    8000790a:	7402                	ld	s0,32(sp)
    8000790c:	6145                	addi	sp,sp,48
    8000790e:	8082                	ret

0000000080007910 <sys_dup>:

uint64
sys_dup(void)
{
    80007910:	1101                	addi	sp,sp,-32
    80007912:	ec06                	sd	ra,24(sp)
    80007914:	e822                	sd	s0,16(sp)
    80007916:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    80007918:	fe040793          	addi	a5,s0,-32
    8000791c:	863e                	mv	a2,a5
    8000791e:	4581                	li	a1,0
    80007920:	4501                	li	a0,0
    80007922:	00000097          	auipc	ra,0x0
    80007926:	ef2080e7          	jalr	-270(ra) # 80007814 <argfd>
    8000792a:	87aa                	mv	a5,a0
    8000792c:	0007d463          	bgez	a5,80007934 <sys_dup+0x24>
    return -1;
    80007930:	57fd                	li	a5,-1
    80007932:	a81d                	j	80007968 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80007934:	fe043783          	ld	a5,-32(s0)
    80007938:	853e                	mv	a0,a5
    8000793a:	00000097          	auipc	ra,0x0
    8000793e:	f68080e7          	jalr	-152(ra) # 800078a2 <fdalloc>
    80007942:	87aa                	mv	a5,a0
    80007944:	fef42623          	sw	a5,-20(s0)
    80007948:	fec42783          	lw	a5,-20(s0)
    8000794c:	2781                	sext.w	a5,a5
    8000794e:	0007d463          	bgez	a5,80007956 <sys_dup+0x46>
    return -1;
    80007952:	57fd                	li	a5,-1
    80007954:	a811                	j	80007968 <sys_dup+0x58>
  filedup(f);
    80007956:	fe043783          	ld	a5,-32(s0)
    8000795a:	853e                	mv	a0,a5
    8000795c:	fffff097          	auipc	ra,0xfffff
    80007960:	ec0080e7          	jalr	-320(ra) # 8000681c <filedup>
  return fd;
    80007964:	fec42783          	lw	a5,-20(s0)
}
    80007968:	853e                	mv	a0,a5
    8000796a:	60e2                	ld	ra,24(sp)
    8000796c:	6442                	ld	s0,16(sp)
    8000796e:	6105                	addi	sp,sp,32
    80007970:	8082                	ret

0000000080007972 <sys_read>:

uint64
sys_read(void)
{
    80007972:	7179                	addi	sp,sp,-48
    80007974:	f406                	sd	ra,40(sp)
    80007976:	f022                	sd	s0,32(sp)
    80007978:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  argaddr(1, &p);
    8000797a:	fd840793          	addi	a5,s0,-40
    8000797e:	85be                	mv	a1,a5
    80007980:	4505                	li	a0,1
    80007982:	ffffd097          	auipc	ra,0xffffd
    80007986:	86a080e7          	jalr	-1942(ra) # 800041ec <argaddr>
  argint(2, &n);
    8000798a:	fe440793          	addi	a5,s0,-28
    8000798e:	85be                	mv	a1,a5
    80007990:	4509                	li	a0,2
    80007992:	ffffd097          	auipc	ra,0xffffd
    80007996:	824080e7          	jalr	-2012(ra) # 800041b6 <argint>
  if(argfd(0, 0, &f) < 0)
    8000799a:	fe840793          	addi	a5,s0,-24
    8000799e:	863e                	mv	a2,a5
    800079a0:	4581                	li	a1,0
    800079a2:	4501                	li	a0,0
    800079a4:	00000097          	auipc	ra,0x0
    800079a8:	e70080e7          	jalr	-400(ra) # 80007814 <argfd>
    800079ac:	87aa                	mv	a5,a0
    800079ae:	0007d463          	bgez	a5,800079b6 <sys_read+0x44>
    return -1;
    800079b2:	57fd                	li	a5,-1
    800079b4:	a839                	j	800079d2 <sys_read+0x60>
  return fileread(f, p, n);
    800079b6:	fe843783          	ld	a5,-24(s0)
    800079ba:	fd843703          	ld	a4,-40(s0)
    800079be:	fe442683          	lw	a3,-28(s0)
    800079c2:	8636                	mv	a2,a3
    800079c4:	85ba                	mv	a1,a4
    800079c6:	853e                	mv	a0,a5
    800079c8:	fffff097          	auipc	ra,0xfffff
    800079cc:	066080e7          	jalr	102(ra) # 80006a2e <fileread>
    800079d0:	87aa                	mv	a5,a0
}
    800079d2:	853e                	mv	a0,a5
    800079d4:	70a2                	ld	ra,40(sp)
    800079d6:	7402                	ld	s0,32(sp)
    800079d8:	6145                	addi	sp,sp,48
    800079da:	8082                	ret

00000000800079dc <sys_write>:

uint64
sys_write(void)
{
    800079dc:	7179                	addi	sp,sp,-48
    800079de:	f406                	sd	ra,40(sp)
    800079e0:	f022                	sd	s0,32(sp)
    800079e2:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;
  
  argaddr(1, &p);
    800079e4:	fd840793          	addi	a5,s0,-40
    800079e8:	85be                	mv	a1,a5
    800079ea:	4505                	li	a0,1
    800079ec:	ffffd097          	auipc	ra,0xffffd
    800079f0:	800080e7          	jalr	-2048(ra) # 800041ec <argaddr>
  argint(2, &n);
    800079f4:	fe440793          	addi	a5,s0,-28
    800079f8:	85be                	mv	a1,a5
    800079fa:	4509                	li	a0,2
    800079fc:	ffffc097          	auipc	ra,0xffffc
    80007a00:	7ba080e7          	jalr	1978(ra) # 800041b6 <argint>
  if(argfd(0, 0, &f) < 0)
    80007a04:	fe840793          	addi	a5,s0,-24
    80007a08:	863e                	mv	a2,a5
    80007a0a:	4581                	li	a1,0
    80007a0c:	4501                	li	a0,0
    80007a0e:	00000097          	auipc	ra,0x0
    80007a12:	e06080e7          	jalr	-506(ra) # 80007814 <argfd>
    80007a16:	87aa                	mv	a5,a0
    80007a18:	0007d463          	bgez	a5,80007a20 <sys_write+0x44>
    return -1;
    80007a1c:	57fd                	li	a5,-1
    80007a1e:	a839                	j	80007a3c <sys_write+0x60>

  return filewrite(f, p, n);
    80007a20:	fe843783          	ld	a5,-24(s0)
    80007a24:	fd843703          	ld	a4,-40(s0)
    80007a28:	fe442683          	lw	a3,-28(s0)
    80007a2c:	8636                	mv	a2,a3
    80007a2e:	85ba                	mv	a1,a4
    80007a30:	853e                	mv	a0,a5
    80007a32:	fffff097          	auipc	ra,0xfffff
    80007a36:	162080e7          	jalr	354(ra) # 80006b94 <filewrite>
    80007a3a:	87aa                	mv	a5,a0
}
    80007a3c:	853e                	mv	a0,a5
    80007a3e:	70a2                	ld	ra,40(sp)
    80007a40:	7402                	ld	s0,32(sp)
    80007a42:	6145                	addi	sp,sp,48
    80007a44:	8082                	ret

0000000080007a46 <sys_close>:

uint64
sys_close(void)
{
    80007a46:	1101                	addi	sp,sp,-32
    80007a48:	ec06                	sd	ra,24(sp)
    80007a4a:	e822                	sd	s0,16(sp)
    80007a4c:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80007a4e:	fe040713          	addi	a4,s0,-32
    80007a52:	fec40793          	addi	a5,s0,-20
    80007a56:	863a                	mv	a2,a4
    80007a58:	85be                	mv	a1,a5
    80007a5a:	4501                	li	a0,0
    80007a5c:	00000097          	auipc	ra,0x0
    80007a60:	db8080e7          	jalr	-584(ra) # 80007814 <argfd>
    80007a64:	87aa                	mv	a5,a0
    80007a66:	0007d463          	bgez	a5,80007a6e <sys_close+0x28>
    return -1;
    80007a6a:	57fd                	li	a5,-1
    80007a6c:	a02d                	j	80007a96 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
    80007a6e:	ffffb097          	auipc	ra,0xffffb
    80007a72:	eaa080e7          	jalr	-342(ra) # 80002918 <myproc>
    80007a76:	872a                	mv	a4,a0
    80007a78:	fec42783          	lw	a5,-20(s0)
    80007a7c:	07e9                	addi	a5,a5,26
    80007a7e:	078e                	slli	a5,a5,0x3
    80007a80:	97ba                	add	a5,a5,a4
    80007a82:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  fileclose(f);
    80007a86:	fe043783          	ld	a5,-32(s0)
    80007a8a:	853e                	mv	a0,a5
    80007a8c:	fffff097          	auipc	ra,0xfffff
    80007a90:	df6080e7          	jalr	-522(ra) # 80006882 <fileclose>
  return 0;
    80007a94:	4781                	li	a5,0
}
    80007a96:	853e                	mv	a0,a5
    80007a98:	60e2                	ld	ra,24(sp)
    80007a9a:	6442                	ld	s0,16(sp)
    80007a9c:	6105                	addi	sp,sp,32
    80007a9e:	8082                	ret

0000000080007aa0 <sys_fstat>:

uint64
sys_fstat(void)
{
    80007aa0:	1101                	addi	sp,sp,-32
    80007aa2:	ec06                	sd	ra,24(sp)
    80007aa4:	e822                	sd	s0,16(sp)
    80007aa6:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  argaddr(1, &st);
    80007aa8:	fe040793          	addi	a5,s0,-32
    80007aac:	85be                	mv	a1,a5
    80007aae:	4505                	li	a0,1
    80007ab0:	ffffc097          	auipc	ra,0xffffc
    80007ab4:	73c080e7          	jalr	1852(ra) # 800041ec <argaddr>
  if(argfd(0, 0, &f) < 0)
    80007ab8:	fe840793          	addi	a5,s0,-24
    80007abc:	863e                	mv	a2,a5
    80007abe:	4581                	li	a1,0
    80007ac0:	4501                	li	a0,0
    80007ac2:	00000097          	auipc	ra,0x0
    80007ac6:	d52080e7          	jalr	-686(ra) # 80007814 <argfd>
    80007aca:	87aa                	mv	a5,a0
    80007acc:	0007d463          	bgez	a5,80007ad4 <sys_fstat+0x34>
    return -1;
    80007ad0:	57fd                	li	a5,-1
    80007ad2:	a821                	j	80007aea <sys_fstat+0x4a>
  return filestat(f, st);
    80007ad4:	fe843783          	ld	a5,-24(s0)
    80007ad8:	fe043703          	ld	a4,-32(s0)
    80007adc:	85ba                	mv	a1,a4
    80007ade:	853e                	mv	a0,a5
    80007ae0:	fffff097          	auipc	ra,0xfffff
    80007ae4:	eaa080e7          	jalr	-342(ra) # 8000698a <filestat>
    80007ae8:	87aa                	mv	a5,a0
}
    80007aea:	853e                	mv	a0,a5
    80007aec:	60e2                	ld	ra,24(sp)
    80007aee:	6442                	ld	s0,16(sp)
    80007af0:	6105                	addi	sp,sp,32
    80007af2:	8082                	ret

0000000080007af4 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80007af4:	7169                	addi	sp,sp,-304
    80007af6:	f606                	sd	ra,296(sp)
    80007af8:	f222                	sd	s0,288(sp)
    80007afa:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80007afc:	ed040793          	addi	a5,s0,-304
    80007b00:	08000613          	li	a2,128
    80007b04:	85be                	mv	a1,a5
    80007b06:	4501                	li	a0,0
    80007b08:	ffffc097          	auipc	ra,0xffffc
    80007b0c:	716080e7          	jalr	1814(ra) # 8000421e <argstr>
    80007b10:	87aa                	mv	a5,a0
    80007b12:	0007cf63          	bltz	a5,80007b30 <sys_link+0x3c>
    80007b16:	f5040793          	addi	a5,s0,-176
    80007b1a:	08000613          	li	a2,128
    80007b1e:	85be                	mv	a1,a5
    80007b20:	4505                	li	a0,1
    80007b22:	ffffc097          	auipc	ra,0xffffc
    80007b26:	6fc080e7          	jalr	1788(ra) # 8000421e <argstr>
    80007b2a:	87aa                	mv	a5,a0
    80007b2c:	0007d463          	bgez	a5,80007b34 <sys_link+0x40>
    return -1;
    80007b30:	57fd                	li	a5,-1
    80007b32:	aab5                	j	80007cae <sys_link+0x1ba>

  begin_op();
    80007b34:	ffffe097          	auipc	ra,0xffffe
    80007b38:	6b4080e7          	jalr	1716(ra) # 800061e8 <begin_op>
  if((ip = namei(old)) == 0){
    80007b3c:	ed040793          	addi	a5,s0,-304
    80007b40:	853e                	mv	a0,a5
    80007b42:	ffffe097          	auipc	ra,0xffffe
    80007b46:	342080e7          	jalr	834(ra) # 80005e84 <namei>
    80007b4a:	fea43423          	sd	a0,-24(s0)
    80007b4e:	fe843783          	ld	a5,-24(s0)
    80007b52:	e799                	bnez	a5,80007b60 <sys_link+0x6c>
    end_op();
    80007b54:	ffffe097          	auipc	ra,0xffffe
    80007b58:	756080e7          	jalr	1878(ra) # 800062aa <end_op>
    return -1;
    80007b5c:	57fd                	li	a5,-1
    80007b5e:	aa81                	j	80007cae <sys_link+0x1ba>
  }

  ilock(ip);
    80007b60:	fe843503          	ld	a0,-24(s0)
    80007b64:	ffffd097          	auipc	ra,0xffffd
    80007b68:	5fa080e7          	jalr	1530(ra) # 8000515e <ilock>
  if(ip->type == T_DIR){
    80007b6c:	fe843783          	ld	a5,-24(s0)
    80007b70:	04479783          	lh	a5,68(a5)
    80007b74:	0007871b          	sext.w	a4,a5
    80007b78:	4785                	li	a5,1
    80007b7a:	00f71e63          	bne	a4,a5,80007b96 <sys_link+0xa2>
    iunlockput(ip);
    80007b7e:	fe843503          	ld	a0,-24(s0)
    80007b82:	ffffe097          	auipc	ra,0xffffe
    80007b86:	83a080e7          	jalr	-1990(ra) # 800053bc <iunlockput>
    end_op();
    80007b8a:	ffffe097          	auipc	ra,0xffffe
    80007b8e:	720080e7          	jalr	1824(ra) # 800062aa <end_op>
    return -1;
    80007b92:	57fd                	li	a5,-1
    80007b94:	aa29                	j	80007cae <sys_link+0x1ba>
  }

  ip->nlink++;
    80007b96:	fe843783          	ld	a5,-24(s0)
    80007b9a:	04a79783          	lh	a5,74(a5)
    80007b9e:	17c2                	slli	a5,a5,0x30
    80007ba0:	93c1                	srli	a5,a5,0x30
    80007ba2:	2785                	addiw	a5,a5,1
    80007ba4:	17c2                	slli	a5,a5,0x30
    80007ba6:	93c1                	srli	a5,a5,0x30
    80007ba8:	0107971b          	slliw	a4,a5,0x10
    80007bac:	4107571b          	sraiw	a4,a4,0x10
    80007bb0:	fe843783          	ld	a5,-24(s0)
    80007bb4:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007bb8:	fe843503          	ld	a0,-24(s0)
    80007bbc:	ffffd097          	auipc	ra,0xffffd
    80007bc0:	352080e7          	jalr	850(ra) # 80004f0e <iupdate>
  iunlock(ip);
    80007bc4:	fe843503          	ld	a0,-24(s0)
    80007bc8:	ffffd097          	auipc	ra,0xffffd
    80007bcc:	6ca080e7          	jalr	1738(ra) # 80005292 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    80007bd0:	fd040713          	addi	a4,s0,-48
    80007bd4:	f5040793          	addi	a5,s0,-176
    80007bd8:	85ba                	mv	a1,a4
    80007bda:	853e                	mv	a0,a5
    80007bdc:	ffffe097          	auipc	ra,0xffffe
    80007be0:	2d4080e7          	jalr	724(ra) # 80005eb0 <nameiparent>
    80007be4:	fea43023          	sd	a0,-32(s0)
    80007be8:	fe043783          	ld	a5,-32(s0)
    80007bec:	cba5                	beqz	a5,80007c5c <sys_link+0x168>
    goto bad;
  ilock(dp);
    80007bee:	fe043503          	ld	a0,-32(s0)
    80007bf2:	ffffd097          	auipc	ra,0xffffd
    80007bf6:	56c080e7          	jalr	1388(ra) # 8000515e <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80007bfa:	fe043783          	ld	a5,-32(s0)
    80007bfe:	4398                	lw	a4,0(a5)
    80007c00:	fe843783          	ld	a5,-24(s0)
    80007c04:	439c                	lw	a5,0(a5)
    80007c06:	02f71263          	bne	a4,a5,80007c2a <sys_link+0x136>
    80007c0a:	fe843783          	ld	a5,-24(s0)
    80007c0e:	43d8                	lw	a4,4(a5)
    80007c10:	fd040793          	addi	a5,s0,-48
    80007c14:	863a                	mv	a2,a4
    80007c16:	85be                	mv	a1,a5
    80007c18:	fe043503          	ld	a0,-32(s0)
    80007c1c:	ffffe097          	auipc	ra,0xffffe
    80007c20:	f5a080e7          	jalr	-166(ra) # 80005b76 <dirlink>
    80007c24:	87aa                	mv	a5,a0
    80007c26:	0007d963          	bgez	a5,80007c38 <sys_link+0x144>
    iunlockput(dp);
    80007c2a:	fe043503          	ld	a0,-32(s0)
    80007c2e:	ffffd097          	auipc	ra,0xffffd
    80007c32:	78e080e7          	jalr	1934(ra) # 800053bc <iunlockput>
    goto bad;
    80007c36:	a025                	j	80007c5e <sys_link+0x16a>
  }
  iunlockput(dp);
    80007c38:	fe043503          	ld	a0,-32(s0)
    80007c3c:	ffffd097          	auipc	ra,0xffffd
    80007c40:	780080e7          	jalr	1920(ra) # 800053bc <iunlockput>
  iput(ip);
    80007c44:	fe843503          	ld	a0,-24(s0)
    80007c48:	ffffd097          	auipc	ra,0xffffd
    80007c4c:	6a4080e7          	jalr	1700(ra) # 800052ec <iput>

  end_op();
    80007c50:	ffffe097          	auipc	ra,0xffffe
    80007c54:	65a080e7          	jalr	1626(ra) # 800062aa <end_op>

  return 0;
    80007c58:	4781                	li	a5,0
    80007c5a:	a891                	j	80007cae <sys_link+0x1ba>
    goto bad;
    80007c5c:	0001                	nop

bad:
  ilock(ip);
    80007c5e:	fe843503          	ld	a0,-24(s0)
    80007c62:	ffffd097          	auipc	ra,0xffffd
    80007c66:	4fc080e7          	jalr	1276(ra) # 8000515e <ilock>
  ip->nlink--;
    80007c6a:	fe843783          	ld	a5,-24(s0)
    80007c6e:	04a79783          	lh	a5,74(a5)
    80007c72:	17c2                	slli	a5,a5,0x30
    80007c74:	93c1                	srli	a5,a5,0x30
    80007c76:	37fd                	addiw	a5,a5,-1
    80007c78:	17c2                	slli	a5,a5,0x30
    80007c7a:	93c1                	srli	a5,a5,0x30
    80007c7c:	0107971b          	slliw	a4,a5,0x10
    80007c80:	4107571b          	sraiw	a4,a4,0x10
    80007c84:	fe843783          	ld	a5,-24(s0)
    80007c88:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007c8c:	fe843503          	ld	a0,-24(s0)
    80007c90:	ffffd097          	auipc	ra,0xffffd
    80007c94:	27e080e7          	jalr	638(ra) # 80004f0e <iupdate>
  iunlockput(ip);
    80007c98:	fe843503          	ld	a0,-24(s0)
    80007c9c:	ffffd097          	auipc	ra,0xffffd
    80007ca0:	720080e7          	jalr	1824(ra) # 800053bc <iunlockput>
  end_op();
    80007ca4:	ffffe097          	auipc	ra,0xffffe
    80007ca8:	606080e7          	jalr	1542(ra) # 800062aa <end_op>
  return -1;
    80007cac:	57fd                	li	a5,-1
}
    80007cae:	853e                	mv	a0,a5
    80007cb0:	70b2                	ld	ra,296(sp)
    80007cb2:	7412                	ld	s0,288(sp)
    80007cb4:	6155                	addi	sp,sp,304
    80007cb6:	8082                	ret

0000000080007cb8 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80007cb8:	7139                	addi	sp,sp,-64
    80007cba:	fc06                	sd	ra,56(sp)
    80007cbc:	f822                	sd	s0,48(sp)
    80007cbe:	0080                	addi	s0,sp,64
    80007cc0:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007cc4:	02000793          	li	a5,32
    80007cc8:	fef42623          	sw	a5,-20(s0)
    80007ccc:	a0b1                	j	80007d18 <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80007cce:	fd840793          	addi	a5,s0,-40
    80007cd2:	fec42683          	lw	a3,-20(s0)
    80007cd6:	4741                	li	a4,16
    80007cd8:	863e                	mv	a2,a5
    80007cda:	4581                	li	a1,0
    80007cdc:	fc843503          	ld	a0,-56(s0)
    80007ce0:	ffffe097          	auipc	ra,0xffffe
    80007ce4:	a34080e7          	jalr	-1484(ra) # 80005714 <readi>
    80007ce8:	87aa                	mv	a5,a0
    80007cea:	873e                	mv	a4,a5
    80007cec:	47c1                	li	a5,16
    80007cee:	00f70a63          	beq	a4,a5,80007d02 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80007cf2:	00004517          	auipc	a0,0x4
    80007cf6:	92e50513          	addi	a0,a0,-1746 # 8000b620 <etext+0x620>
    80007cfa:	ffff9097          	auipc	ra,0xffff9
    80007cfe:	f92080e7          	jalr	-110(ra) # 80000c8c <panic>
    if(de.inum != 0)
    80007d02:	fd845783          	lhu	a5,-40(s0)
    80007d06:	c399                	beqz	a5,80007d0c <isdirempty+0x54>
      return 0;
    80007d08:	4781                	li	a5,0
    80007d0a:	a839                	j	80007d28 <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007d0c:	fec42783          	lw	a5,-20(s0)
    80007d10:	27c1                	addiw	a5,a5,16
    80007d12:	2781                	sext.w	a5,a5
    80007d14:	fef42623          	sw	a5,-20(s0)
    80007d18:	fc843783          	ld	a5,-56(s0)
    80007d1c:	47f8                	lw	a4,76(a5)
    80007d1e:	fec42783          	lw	a5,-20(s0)
    80007d22:	fae7e6e3          	bltu	a5,a4,80007cce <isdirempty+0x16>
  }
  return 1;
    80007d26:	4785                	li	a5,1
}
    80007d28:	853e                	mv	a0,a5
    80007d2a:	70e2                	ld	ra,56(sp)
    80007d2c:	7442                	ld	s0,48(sp)
    80007d2e:	6121                	addi	sp,sp,64
    80007d30:	8082                	ret

0000000080007d32 <sys_unlink>:

uint64
sys_unlink(void)
{
    80007d32:	7155                	addi	sp,sp,-208
    80007d34:	e586                	sd	ra,200(sp)
    80007d36:	e1a2                	sd	s0,192(sp)
    80007d38:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    80007d3a:	f4040793          	addi	a5,s0,-192
    80007d3e:	08000613          	li	a2,128
    80007d42:	85be                	mv	a1,a5
    80007d44:	4501                	li	a0,0
    80007d46:	ffffc097          	auipc	ra,0xffffc
    80007d4a:	4d8080e7          	jalr	1240(ra) # 8000421e <argstr>
    80007d4e:	87aa                	mv	a5,a0
    80007d50:	0007d463          	bgez	a5,80007d58 <sys_unlink+0x26>
    return -1;
    80007d54:	57fd                	li	a5,-1
    80007d56:	a2ed                	j	80007f40 <sys_unlink+0x20e>

  begin_op();
    80007d58:	ffffe097          	auipc	ra,0xffffe
    80007d5c:	490080e7          	jalr	1168(ra) # 800061e8 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80007d60:	fc040713          	addi	a4,s0,-64
    80007d64:	f4040793          	addi	a5,s0,-192
    80007d68:	85ba                	mv	a1,a4
    80007d6a:	853e                	mv	a0,a5
    80007d6c:	ffffe097          	auipc	ra,0xffffe
    80007d70:	144080e7          	jalr	324(ra) # 80005eb0 <nameiparent>
    80007d74:	fea43423          	sd	a0,-24(s0)
    80007d78:	fe843783          	ld	a5,-24(s0)
    80007d7c:	e799                	bnez	a5,80007d8a <sys_unlink+0x58>
    end_op();
    80007d7e:	ffffe097          	auipc	ra,0xffffe
    80007d82:	52c080e7          	jalr	1324(ra) # 800062aa <end_op>
    return -1;
    80007d86:	57fd                	li	a5,-1
    80007d88:	aa65                	j	80007f40 <sys_unlink+0x20e>
  }

  ilock(dp);
    80007d8a:	fe843503          	ld	a0,-24(s0)
    80007d8e:	ffffd097          	auipc	ra,0xffffd
    80007d92:	3d0080e7          	jalr	976(ra) # 8000515e <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80007d96:	fc040793          	addi	a5,s0,-64
    80007d9a:	00004597          	auipc	a1,0x4
    80007d9e:	89e58593          	addi	a1,a1,-1890 # 8000b638 <etext+0x638>
    80007da2:	853e                	mv	a0,a5
    80007da4:	ffffe097          	auipc	ra,0xffffe
    80007da8:	cbc080e7          	jalr	-836(ra) # 80005a60 <namecmp>
    80007dac:	87aa                	mv	a5,a0
    80007dae:	16078b63          	beqz	a5,80007f24 <sys_unlink+0x1f2>
    80007db2:	fc040793          	addi	a5,s0,-64
    80007db6:	00004597          	auipc	a1,0x4
    80007dba:	88a58593          	addi	a1,a1,-1910 # 8000b640 <etext+0x640>
    80007dbe:	853e                	mv	a0,a5
    80007dc0:	ffffe097          	auipc	ra,0xffffe
    80007dc4:	ca0080e7          	jalr	-864(ra) # 80005a60 <namecmp>
    80007dc8:	87aa                	mv	a5,a0
    80007dca:	14078d63          	beqz	a5,80007f24 <sys_unlink+0x1f2>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    80007dce:	f3c40713          	addi	a4,s0,-196
    80007dd2:	fc040793          	addi	a5,s0,-64
    80007dd6:	863a                	mv	a2,a4
    80007dd8:	85be                	mv	a1,a5
    80007dda:	fe843503          	ld	a0,-24(s0)
    80007dde:	ffffe097          	auipc	ra,0xffffe
    80007de2:	cb0080e7          	jalr	-848(ra) # 80005a8e <dirlookup>
    80007de6:	fea43023          	sd	a0,-32(s0)
    80007dea:	fe043783          	ld	a5,-32(s0)
    80007dee:	12078d63          	beqz	a5,80007f28 <sys_unlink+0x1f6>
    goto bad;
  ilock(ip);
    80007df2:	fe043503          	ld	a0,-32(s0)
    80007df6:	ffffd097          	auipc	ra,0xffffd
    80007dfa:	368080e7          	jalr	872(ra) # 8000515e <ilock>

  if(ip->nlink < 1)
    80007dfe:	fe043783          	ld	a5,-32(s0)
    80007e02:	04a79783          	lh	a5,74(a5)
    80007e06:	2781                	sext.w	a5,a5
    80007e08:	00f04a63          	bgtz	a5,80007e1c <sys_unlink+0xea>
    panic("unlink: nlink < 1");
    80007e0c:	00004517          	auipc	a0,0x4
    80007e10:	83c50513          	addi	a0,a0,-1988 # 8000b648 <etext+0x648>
    80007e14:	ffff9097          	auipc	ra,0xffff9
    80007e18:	e78080e7          	jalr	-392(ra) # 80000c8c <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80007e1c:	fe043783          	ld	a5,-32(s0)
    80007e20:	04479783          	lh	a5,68(a5)
    80007e24:	0007871b          	sext.w	a4,a5
    80007e28:	4785                	li	a5,1
    80007e2a:	02f71163          	bne	a4,a5,80007e4c <sys_unlink+0x11a>
    80007e2e:	fe043503          	ld	a0,-32(s0)
    80007e32:	00000097          	auipc	ra,0x0
    80007e36:	e86080e7          	jalr	-378(ra) # 80007cb8 <isdirempty>
    80007e3a:	87aa                	mv	a5,a0
    80007e3c:	eb81                	bnez	a5,80007e4c <sys_unlink+0x11a>
    iunlockput(ip);
    80007e3e:	fe043503          	ld	a0,-32(s0)
    80007e42:	ffffd097          	auipc	ra,0xffffd
    80007e46:	57a080e7          	jalr	1402(ra) # 800053bc <iunlockput>
    goto bad;
    80007e4a:	a0c5                	j	80007f2a <sys_unlink+0x1f8>
  }

  memset(&de, 0, sizeof(de));
    80007e4c:	fd040793          	addi	a5,s0,-48
    80007e50:	4641                	li	a2,16
    80007e52:	4581                	li	a1,0
    80007e54:	853e                	mv	a0,a5
    80007e56:	ffff9097          	auipc	ra,0xffff9
    80007e5a:	6a8080e7          	jalr	1704(ra) # 800014fe <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80007e5e:	fd040793          	addi	a5,s0,-48
    80007e62:	f3c42683          	lw	a3,-196(s0)
    80007e66:	4741                	li	a4,16
    80007e68:	863e                	mv	a2,a5
    80007e6a:	4581                	li	a1,0
    80007e6c:	fe843503          	ld	a0,-24(s0)
    80007e70:	ffffe097          	auipc	ra,0xffffe
    80007e74:	a3c080e7          	jalr	-1476(ra) # 800058ac <writei>
    80007e78:	87aa                	mv	a5,a0
    80007e7a:	873e                	mv	a4,a5
    80007e7c:	47c1                	li	a5,16
    80007e7e:	00f70a63          	beq	a4,a5,80007e92 <sys_unlink+0x160>
    panic("unlink: writei");
    80007e82:	00003517          	auipc	a0,0x3
    80007e86:	7de50513          	addi	a0,a0,2014 # 8000b660 <etext+0x660>
    80007e8a:	ffff9097          	auipc	ra,0xffff9
    80007e8e:	e02080e7          	jalr	-510(ra) # 80000c8c <panic>
  if(ip->type == T_DIR){
    80007e92:	fe043783          	ld	a5,-32(s0)
    80007e96:	04479783          	lh	a5,68(a5)
    80007e9a:	0007871b          	sext.w	a4,a5
    80007e9e:	4785                	li	a5,1
    80007ea0:	02f71963          	bne	a4,a5,80007ed2 <sys_unlink+0x1a0>
    dp->nlink--;
    80007ea4:	fe843783          	ld	a5,-24(s0)
    80007ea8:	04a79783          	lh	a5,74(a5)
    80007eac:	17c2                	slli	a5,a5,0x30
    80007eae:	93c1                	srli	a5,a5,0x30
    80007eb0:	37fd                	addiw	a5,a5,-1
    80007eb2:	17c2                	slli	a5,a5,0x30
    80007eb4:	93c1                	srli	a5,a5,0x30
    80007eb6:	0107971b          	slliw	a4,a5,0x10
    80007eba:	4107571b          	sraiw	a4,a4,0x10
    80007ebe:	fe843783          	ld	a5,-24(s0)
    80007ec2:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80007ec6:	fe843503          	ld	a0,-24(s0)
    80007eca:	ffffd097          	auipc	ra,0xffffd
    80007ece:	044080e7          	jalr	68(ra) # 80004f0e <iupdate>
  }
  iunlockput(dp);
    80007ed2:	fe843503          	ld	a0,-24(s0)
    80007ed6:	ffffd097          	auipc	ra,0xffffd
    80007eda:	4e6080e7          	jalr	1254(ra) # 800053bc <iunlockput>

  ip->nlink--;
    80007ede:	fe043783          	ld	a5,-32(s0)
    80007ee2:	04a79783          	lh	a5,74(a5)
    80007ee6:	17c2                	slli	a5,a5,0x30
    80007ee8:	93c1                	srli	a5,a5,0x30
    80007eea:	37fd                	addiw	a5,a5,-1
    80007eec:	17c2                	slli	a5,a5,0x30
    80007eee:	93c1                	srli	a5,a5,0x30
    80007ef0:	0107971b          	slliw	a4,a5,0x10
    80007ef4:	4107571b          	sraiw	a4,a4,0x10
    80007ef8:	fe043783          	ld	a5,-32(s0)
    80007efc:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007f00:	fe043503          	ld	a0,-32(s0)
    80007f04:	ffffd097          	auipc	ra,0xffffd
    80007f08:	00a080e7          	jalr	10(ra) # 80004f0e <iupdate>
  iunlockput(ip);
    80007f0c:	fe043503          	ld	a0,-32(s0)
    80007f10:	ffffd097          	auipc	ra,0xffffd
    80007f14:	4ac080e7          	jalr	1196(ra) # 800053bc <iunlockput>

  end_op();
    80007f18:	ffffe097          	auipc	ra,0xffffe
    80007f1c:	392080e7          	jalr	914(ra) # 800062aa <end_op>

  return 0;
    80007f20:	4781                	li	a5,0
    80007f22:	a839                	j	80007f40 <sys_unlink+0x20e>
    goto bad;
    80007f24:	0001                	nop
    80007f26:	a011                	j	80007f2a <sys_unlink+0x1f8>
    goto bad;
    80007f28:	0001                	nop

bad:
  iunlockput(dp);
    80007f2a:	fe843503          	ld	a0,-24(s0)
    80007f2e:	ffffd097          	auipc	ra,0xffffd
    80007f32:	48e080e7          	jalr	1166(ra) # 800053bc <iunlockput>
  end_op();
    80007f36:	ffffe097          	auipc	ra,0xffffe
    80007f3a:	374080e7          	jalr	884(ra) # 800062aa <end_op>
  return -1;
    80007f3e:	57fd                	li	a5,-1
}
    80007f40:	853e                	mv	a0,a5
    80007f42:	60ae                	ld	ra,200(sp)
    80007f44:	640e                	ld	s0,192(sp)
    80007f46:	6169                	addi	sp,sp,208
    80007f48:	8082                	ret

0000000080007f4a <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    80007f4a:	7139                	addi	sp,sp,-64
    80007f4c:	fc06                	sd	ra,56(sp)
    80007f4e:	f822                	sd	s0,48(sp)
    80007f50:	0080                	addi	s0,sp,64
    80007f52:	fca43423          	sd	a0,-56(s0)
    80007f56:	87ae                	mv	a5,a1
    80007f58:	8736                	mv	a4,a3
    80007f5a:	fcf41323          	sh	a5,-58(s0)
    80007f5e:	87b2                	mv	a5,a2
    80007f60:	fcf41223          	sh	a5,-60(s0)
    80007f64:	87ba                	mv	a5,a4
    80007f66:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80007f6a:	fd040793          	addi	a5,s0,-48
    80007f6e:	85be                	mv	a1,a5
    80007f70:	fc843503          	ld	a0,-56(s0)
    80007f74:	ffffe097          	auipc	ra,0xffffe
    80007f78:	f3c080e7          	jalr	-196(ra) # 80005eb0 <nameiparent>
    80007f7c:	fea43423          	sd	a0,-24(s0)
    80007f80:	fe843783          	ld	a5,-24(s0)
    80007f84:	e399                	bnez	a5,80007f8a <create+0x40>
    return 0;
    80007f86:	4781                	li	a5,0
    80007f88:	a2ed                	j	80008172 <create+0x228>

  ilock(dp);
    80007f8a:	fe843503          	ld	a0,-24(s0)
    80007f8e:	ffffd097          	auipc	ra,0xffffd
    80007f92:	1d0080e7          	jalr	464(ra) # 8000515e <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80007f96:	fd040793          	addi	a5,s0,-48
    80007f9a:	4601                	li	a2,0
    80007f9c:	85be                	mv	a1,a5
    80007f9e:	fe843503          	ld	a0,-24(s0)
    80007fa2:	ffffe097          	auipc	ra,0xffffe
    80007fa6:	aec080e7          	jalr	-1300(ra) # 80005a8e <dirlookup>
    80007faa:	fea43023          	sd	a0,-32(s0)
    80007fae:	fe043783          	ld	a5,-32(s0)
    80007fb2:	c3ad                	beqz	a5,80008014 <create+0xca>
    iunlockput(dp);
    80007fb4:	fe843503          	ld	a0,-24(s0)
    80007fb8:	ffffd097          	auipc	ra,0xffffd
    80007fbc:	404080e7          	jalr	1028(ra) # 800053bc <iunlockput>
    ilock(ip);
    80007fc0:	fe043503          	ld	a0,-32(s0)
    80007fc4:	ffffd097          	auipc	ra,0xffffd
    80007fc8:	19a080e7          	jalr	410(ra) # 8000515e <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80007fcc:	fc641783          	lh	a5,-58(s0)
    80007fd0:	0007871b          	sext.w	a4,a5
    80007fd4:	4789                	li	a5,2
    80007fd6:	02f71763          	bne	a4,a5,80008004 <create+0xba>
    80007fda:	fe043783          	ld	a5,-32(s0)
    80007fde:	04479783          	lh	a5,68(a5)
    80007fe2:	0007871b          	sext.w	a4,a5
    80007fe6:	4789                	li	a5,2
    80007fe8:	00f70b63          	beq	a4,a5,80007ffe <create+0xb4>
    80007fec:	fe043783          	ld	a5,-32(s0)
    80007ff0:	04479783          	lh	a5,68(a5)
    80007ff4:	0007871b          	sext.w	a4,a5
    80007ff8:	478d                	li	a5,3
    80007ffa:	00f71563          	bne	a4,a5,80008004 <create+0xba>
      return ip;
    80007ffe:	fe043783          	ld	a5,-32(s0)
    80008002:	aa85                	j	80008172 <create+0x228>
    iunlockput(ip);
    80008004:	fe043503          	ld	a0,-32(s0)
    80008008:	ffffd097          	auipc	ra,0xffffd
    8000800c:	3b4080e7          	jalr	948(ra) # 800053bc <iunlockput>
    return 0;
    80008010:	4781                	li	a5,0
    80008012:	a285                	j	80008172 <create+0x228>
  }

  if((ip = ialloc(dp->dev, type)) == 0){
    80008014:	fe843783          	ld	a5,-24(s0)
    80008018:	439c                	lw	a5,0(a5)
    8000801a:	fc641703          	lh	a4,-58(s0)
    8000801e:	85ba                	mv	a1,a4
    80008020:	853e                	mv	a0,a5
    80008022:	ffffd097          	auipc	ra,0xffffd
    80008026:	dee080e7          	jalr	-530(ra) # 80004e10 <ialloc>
    8000802a:	fea43023          	sd	a0,-32(s0)
    8000802e:	fe043783          	ld	a5,-32(s0)
    80008032:	eb89                	bnez	a5,80008044 <create+0xfa>
    iunlockput(dp);
    80008034:	fe843503          	ld	a0,-24(s0)
    80008038:	ffffd097          	auipc	ra,0xffffd
    8000803c:	384080e7          	jalr	900(ra) # 800053bc <iunlockput>
    return 0;
    80008040:	4781                	li	a5,0
    80008042:	aa05                	j	80008172 <create+0x228>
  }

  ilock(ip);
    80008044:	fe043503          	ld	a0,-32(s0)
    80008048:	ffffd097          	auipc	ra,0xffffd
    8000804c:	116080e7          	jalr	278(ra) # 8000515e <ilock>
  ip->major = major;
    80008050:	fe043783          	ld	a5,-32(s0)
    80008054:	fc445703          	lhu	a4,-60(s0)
    80008058:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    8000805c:	fe043783          	ld	a5,-32(s0)
    80008060:	fc245703          	lhu	a4,-62(s0)
    80008064:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    80008068:	fe043783          	ld	a5,-32(s0)
    8000806c:	4705                	li	a4,1
    8000806e:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008072:	fe043503          	ld	a0,-32(s0)
    80008076:	ffffd097          	auipc	ra,0xffffd
    8000807a:	e98080e7          	jalr	-360(ra) # 80004f0e <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    8000807e:	fc641783          	lh	a5,-58(s0)
    80008082:	0007871b          	sext.w	a4,a5
    80008086:	4785                	li	a5,1
    80008088:	04f71463          	bne	a4,a5,800080d0 <create+0x186>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000808c:	fe043783          	ld	a5,-32(s0)
    80008090:	43dc                	lw	a5,4(a5)
    80008092:	863e                	mv	a2,a5
    80008094:	00003597          	auipc	a1,0x3
    80008098:	5a458593          	addi	a1,a1,1444 # 8000b638 <etext+0x638>
    8000809c:	fe043503          	ld	a0,-32(s0)
    800080a0:	ffffe097          	auipc	ra,0xffffe
    800080a4:	ad6080e7          	jalr	-1322(ra) # 80005b76 <dirlink>
    800080a8:	87aa                	mv	a5,a0
    800080aa:	0807ca63          	bltz	a5,8000813e <create+0x1f4>
    800080ae:	fe843783          	ld	a5,-24(s0)
    800080b2:	43dc                	lw	a5,4(a5)
    800080b4:	863e                	mv	a2,a5
    800080b6:	00003597          	auipc	a1,0x3
    800080ba:	58a58593          	addi	a1,a1,1418 # 8000b640 <etext+0x640>
    800080be:	fe043503          	ld	a0,-32(s0)
    800080c2:	ffffe097          	auipc	ra,0xffffe
    800080c6:	ab4080e7          	jalr	-1356(ra) # 80005b76 <dirlink>
    800080ca:	87aa                	mv	a5,a0
    800080cc:	0607c963          	bltz	a5,8000813e <create+0x1f4>
      goto fail;
  }

  if(dirlink(dp, name, ip->inum) < 0)
    800080d0:	fe043783          	ld	a5,-32(s0)
    800080d4:	43d8                	lw	a4,4(a5)
    800080d6:	fd040793          	addi	a5,s0,-48
    800080da:	863a                	mv	a2,a4
    800080dc:	85be                	mv	a1,a5
    800080de:	fe843503          	ld	a0,-24(s0)
    800080e2:	ffffe097          	auipc	ra,0xffffe
    800080e6:	a94080e7          	jalr	-1388(ra) # 80005b76 <dirlink>
    800080ea:	87aa                	mv	a5,a0
    800080ec:	0407cb63          	bltz	a5,80008142 <create+0x1f8>
    goto fail;

  if(type == T_DIR){
    800080f0:	fc641783          	lh	a5,-58(s0)
    800080f4:	0007871b          	sext.w	a4,a5
    800080f8:	4785                	li	a5,1
    800080fa:	02f71963          	bne	a4,a5,8000812c <create+0x1e2>
    // now that success is guaranteed:
    dp->nlink++;  // for ".."
    800080fe:	fe843783          	ld	a5,-24(s0)
    80008102:	04a79783          	lh	a5,74(a5)
    80008106:	17c2                	slli	a5,a5,0x30
    80008108:	93c1                	srli	a5,a5,0x30
    8000810a:	2785                	addiw	a5,a5,1
    8000810c:	17c2                	slli	a5,a5,0x30
    8000810e:	93c1                	srli	a5,a5,0x30
    80008110:	0107971b          	slliw	a4,a5,0x10
    80008114:	4107571b          	sraiw	a4,a4,0x10
    80008118:	fe843783          	ld	a5,-24(s0)
    8000811c:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008120:	fe843503          	ld	a0,-24(s0)
    80008124:	ffffd097          	auipc	ra,0xffffd
    80008128:	dea080e7          	jalr	-534(ra) # 80004f0e <iupdate>
  }

  iunlockput(dp);
    8000812c:	fe843503          	ld	a0,-24(s0)
    80008130:	ffffd097          	auipc	ra,0xffffd
    80008134:	28c080e7          	jalr	652(ra) # 800053bc <iunlockput>

  return ip;
    80008138:	fe043783          	ld	a5,-32(s0)
    8000813c:	a81d                	j	80008172 <create+0x228>
      goto fail;
    8000813e:	0001                	nop
    80008140:	a011                	j	80008144 <create+0x1fa>
    goto fail;
    80008142:	0001                	nop

 fail:
  // something went wrong. de-allocate ip.
  ip->nlink = 0;
    80008144:	fe043783          	ld	a5,-32(s0)
    80008148:	04079523          	sh	zero,74(a5)
  iupdate(ip);
    8000814c:	fe043503          	ld	a0,-32(s0)
    80008150:	ffffd097          	auipc	ra,0xffffd
    80008154:	dbe080e7          	jalr	-578(ra) # 80004f0e <iupdate>
  iunlockput(ip);
    80008158:	fe043503          	ld	a0,-32(s0)
    8000815c:	ffffd097          	auipc	ra,0xffffd
    80008160:	260080e7          	jalr	608(ra) # 800053bc <iunlockput>
  iunlockput(dp);
    80008164:	fe843503          	ld	a0,-24(s0)
    80008168:	ffffd097          	auipc	ra,0xffffd
    8000816c:	254080e7          	jalr	596(ra) # 800053bc <iunlockput>
  return 0;
    80008170:	4781                	li	a5,0
}
    80008172:	853e                	mv	a0,a5
    80008174:	70e2                	ld	ra,56(sp)
    80008176:	7442                	ld	s0,48(sp)
    80008178:	6121                	addi	sp,sp,64
    8000817a:	8082                	ret

000000008000817c <sys_open>:

uint64
sys_open(void)
{
    8000817c:	7131                	addi	sp,sp,-192
    8000817e:	fd06                	sd	ra,184(sp)
    80008180:	f922                	sd	s0,176(sp)
    80008182:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80008184:	f4c40793          	addi	a5,s0,-180
    80008188:	85be                	mv	a1,a5
    8000818a:	4505                	li	a0,1
    8000818c:	ffffc097          	auipc	ra,0xffffc
    80008190:	02a080e7          	jalr	42(ra) # 800041b6 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80008194:	f5040793          	addi	a5,s0,-176
    80008198:	08000613          	li	a2,128
    8000819c:	85be                	mv	a1,a5
    8000819e:	4501                	li	a0,0
    800081a0:	ffffc097          	auipc	ra,0xffffc
    800081a4:	07e080e7          	jalr	126(ra) # 8000421e <argstr>
    800081a8:	87aa                	mv	a5,a0
    800081aa:	fef42223          	sw	a5,-28(s0)
    800081ae:	fe442783          	lw	a5,-28(s0)
    800081b2:	2781                	sext.w	a5,a5
    800081b4:	0007d463          	bgez	a5,800081bc <sys_open+0x40>
    return -1;
    800081b8:	57fd                	li	a5,-1
    800081ba:	a429                	j	800083c4 <sys_open+0x248>

  begin_op();
    800081bc:	ffffe097          	auipc	ra,0xffffe
    800081c0:	02c080e7          	jalr	44(ra) # 800061e8 <begin_op>

  if(omode & O_CREATE){
    800081c4:	f4c42783          	lw	a5,-180(s0)
    800081c8:	2007f793          	andi	a5,a5,512
    800081cc:	2781                	sext.w	a5,a5
    800081ce:	c795                	beqz	a5,800081fa <sys_open+0x7e>
    ip = create(path, T_FILE, 0, 0);
    800081d0:	f5040793          	addi	a5,s0,-176
    800081d4:	4681                	li	a3,0
    800081d6:	4601                	li	a2,0
    800081d8:	4589                	li	a1,2
    800081da:	853e                	mv	a0,a5
    800081dc:	00000097          	auipc	ra,0x0
    800081e0:	d6e080e7          	jalr	-658(ra) # 80007f4a <create>
    800081e4:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    800081e8:	fe843783          	ld	a5,-24(s0)
    800081ec:	e7bd                	bnez	a5,8000825a <sys_open+0xde>
      end_op();
    800081ee:	ffffe097          	auipc	ra,0xffffe
    800081f2:	0bc080e7          	jalr	188(ra) # 800062aa <end_op>
      return -1;
    800081f6:	57fd                	li	a5,-1
    800081f8:	a2f1                	j	800083c4 <sys_open+0x248>
    }
  } else {
    if((ip = namei(path)) == 0){
    800081fa:	f5040793          	addi	a5,s0,-176
    800081fe:	853e                	mv	a0,a5
    80008200:	ffffe097          	auipc	ra,0xffffe
    80008204:	c84080e7          	jalr	-892(ra) # 80005e84 <namei>
    80008208:	fea43423          	sd	a0,-24(s0)
    8000820c:	fe843783          	ld	a5,-24(s0)
    80008210:	e799                	bnez	a5,8000821e <sys_open+0xa2>
      end_op();
    80008212:	ffffe097          	auipc	ra,0xffffe
    80008216:	098080e7          	jalr	152(ra) # 800062aa <end_op>
      return -1;
    8000821a:	57fd                	li	a5,-1
    8000821c:	a265                	j	800083c4 <sys_open+0x248>
    }
    ilock(ip);
    8000821e:	fe843503          	ld	a0,-24(s0)
    80008222:	ffffd097          	auipc	ra,0xffffd
    80008226:	f3c080e7          	jalr	-196(ra) # 8000515e <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000822a:	fe843783          	ld	a5,-24(s0)
    8000822e:	04479783          	lh	a5,68(a5)
    80008232:	0007871b          	sext.w	a4,a5
    80008236:	4785                	li	a5,1
    80008238:	02f71163          	bne	a4,a5,8000825a <sys_open+0xde>
    8000823c:	f4c42783          	lw	a5,-180(s0)
    80008240:	cf89                	beqz	a5,8000825a <sys_open+0xde>
      iunlockput(ip);
    80008242:	fe843503          	ld	a0,-24(s0)
    80008246:	ffffd097          	auipc	ra,0xffffd
    8000824a:	176080e7          	jalr	374(ra) # 800053bc <iunlockput>
      end_op();
    8000824e:	ffffe097          	auipc	ra,0xffffe
    80008252:	05c080e7          	jalr	92(ra) # 800062aa <end_op>
      return -1;
    80008256:	57fd                	li	a5,-1
    80008258:	a2b5                	j	800083c4 <sys_open+0x248>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000825a:	fe843783          	ld	a5,-24(s0)
    8000825e:	04479783          	lh	a5,68(a5)
    80008262:	0007871b          	sext.w	a4,a5
    80008266:	478d                	li	a5,3
    80008268:	02f71e63          	bne	a4,a5,800082a4 <sys_open+0x128>
    8000826c:	fe843783          	ld	a5,-24(s0)
    80008270:	04679783          	lh	a5,70(a5)
    80008274:	2781                	sext.w	a5,a5
    80008276:	0007cb63          	bltz	a5,8000828c <sys_open+0x110>
    8000827a:	fe843783          	ld	a5,-24(s0)
    8000827e:	04679783          	lh	a5,70(a5)
    80008282:	0007871b          	sext.w	a4,a5
    80008286:	47a5                	li	a5,9
    80008288:	00e7de63          	bge	a5,a4,800082a4 <sys_open+0x128>
    iunlockput(ip);
    8000828c:	fe843503          	ld	a0,-24(s0)
    80008290:	ffffd097          	auipc	ra,0xffffd
    80008294:	12c080e7          	jalr	300(ra) # 800053bc <iunlockput>
    end_op();
    80008298:	ffffe097          	auipc	ra,0xffffe
    8000829c:	012080e7          	jalr	18(ra) # 800062aa <end_op>
    return -1;
    800082a0:	57fd                	li	a5,-1
    800082a2:	a20d                	j	800083c4 <sys_open+0x248>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800082a4:	ffffe097          	auipc	ra,0xffffe
    800082a8:	4f4080e7          	jalr	1268(ra) # 80006798 <filealloc>
    800082ac:	fca43c23          	sd	a0,-40(s0)
    800082b0:	fd843783          	ld	a5,-40(s0)
    800082b4:	cf99                	beqz	a5,800082d2 <sys_open+0x156>
    800082b6:	fd843503          	ld	a0,-40(s0)
    800082ba:	fffff097          	auipc	ra,0xfffff
    800082be:	5e8080e7          	jalr	1512(ra) # 800078a2 <fdalloc>
    800082c2:	87aa                	mv	a5,a0
    800082c4:	fcf42a23          	sw	a5,-44(s0)
    800082c8:	fd442783          	lw	a5,-44(s0)
    800082cc:	2781                	sext.w	a5,a5
    800082ce:	0207d763          	bgez	a5,800082fc <sys_open+0x180>
    if(f)
    800082d2:	fd843783          	ld	a5,-40(s0)
    800082d6:	c799                	beqz	a5,800082e4 <sys_open+0x168>
      fileclose(f);
    800082d8:	fd843503          	ld	a0,-40(s0)
    800082dc:	ffffe097          	auipc	ra,0xffffe
    800082e0:	5a6080e7          	jalr	1446(ra) # 80006882 <fileclose>
    iunlockput(ip);
    800082e4:	fe843503          	ld	a0,-24(s0)
    800082e8:	ffffd097          	auipc	ra,0xffffd
    800082ec:	0d4080e7          	jalr	212(ra) # 800053bc <iunlockput>
    end_op();
    800082f0:	ffffe097          	auipc	ra,0xffffe
    800082f4:	fba080e7          	jalr	-70(ra) # 800062aa <end_op>
    return -1;
    800082f8:	57fd                	li	a5,-1
    800082fa:	a0e9                	j	800083c4 <sys_open+0x248>
  }

  if(ip->type == T_DEVICE){
    800082fc:	fe843783          	ld	a5,-24(s0)
    80008300:	04479783          	lh	a5,68(a5)
    80008304:	0007871b          	sext.w	a4,a5
    80008308:	478d                	li	a5,3
    8000830a:	00f71f63          	bne	a4,a5,80008328 <sys_open+0x1ac>
    f->type = FD_DEVICE;
    8000830e:	fd843783          	ld	a5,-40(s0)
    80008312:	470d                	li	a4,3
    80008314:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80008316:	fe843783          	ld	a5,-24(s0)
    8000831a:	04679703          	lh	a4,70(a5)
    8000831e:	fd843783          	ld	a5,-40(s0)
    80008322:	02e79223          	sh	a4,36(a5)
    80008326:	a809                	j	80008338 <sys_open+0x1bc>
  } else {
    f->type = FD_INODE;
    80008328:	fd843783          	ld	a5,-40(s0)
    8000832c:	4709                	li	a4,2
    8000832e:	c398                	sw	a4,0(a5)
    f->off = 0;
    80008330:	fd843783          	ld	a5,-40(s0)
    80008334:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80008338:	fd843783          	ld	a5,-40(s0)
    8000833c:	fe843703          	ld	a4,-24(s0)
    80008340:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008342:	f4c42783          	lw	a5,-180(s0)
    80008346:	8b85                	andi	a5,a5,1
    80008348:	2781                	sext.w	a5,a5
    8000834a:	0017b793          	seqz	a5,a5
    8000834e:	0ff7f793          	andi	a5,a5,255
    80008352:	873e                	mv	a4,a5
    80008354:	fd843783          	ld	a5,-40(s0)
    80008358:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000835c:	f4c42783          	lw	a5,-180(s0)
    80008360:	8b85                	andi	a5,a5,1
    80008362:	2781                	sext.w	a5,a5
    80008364:	e791                	bnez	a5,80008370 <sys_open+0x1f4>
    80008366:	f4c42783          	lw	a5,-180(s0)
    8000836a:	8b89                	andi	a5,a5,2
    8000836c:	2781                	sext.w	a5,a5
    8000836e:	c399                	beqz	a5,80008374 <sys_open+0x1f8>
    80008370:	4785                	li	a5,1
    80008372:	a011                	j	80008376 <sys_open+0x1fa>
    80008374:	4781                	li	a5,0
    80008376:	0ff7f713          	andi	a4,a5,255
    8000837a:	fd843783          	ld	a5,-40(s0)
    8000837e:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80008382:	f4c42783          	lw	a5,-180(s0)
    80008386:	4007f793          	andi	a5,a5,1024
    8000838a:	2781                	sext.w	a5,a5
    8000838c:	c385                	beqz	a5,800083ac <sys_open+0x230>
    8000838e:	fe843783          	ld	a5,-24(s0)
    80008392:	04479783          	lh	a5,68(a5)
    80008396:	0007871b          	sext.w	a4,a5
    8000839a:	4789                	li	a5,2
    8000839c:	00f71863          	bne	a4,a5,800083ac <sys_open+0x230>
    itrunc(ip);
    800083a0:	fe843503          	ld	a0,-24(s0)
    800083a4:	ffffd097          	auipc	ra,0xffffd
    800083a8:	1c2080e7          	jalr	450(ra) # 80005566 <itrunc>
  }

  iunlock(ip);
    800083ac:	fe843503          	ld	a0,-24(s0)
    800083b0:	ffffd097          	auipc	ra,0xffffd
    800083b4:	ee2080e7          	jalr	-286(ra) # 80005292 <iunlock>
  end_op();
    800083b8:	ffffe097          	auipc	ra,0xffffe
    800083bc:	ef2080e7          	jalr	-270(ra) # 800062aa <end_op>

  return fd;
    800083c0:	fd442783          	lw	a5,-44(s0)
}
    800083c4:	853e                	mv	a0,a5
    800083c6:	70ea                	ld	ra,184(sp)
    800083c8:	744a                	ld	s0,176(sp)
    800083ca:	6129                	addi	sp,sp,192
    800083cc:	8082                	ret

00000000800083ce <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800083ce:	7135                	addi	sp,sp,-160
    800083d0:	ed06                	sd	ra,152(sp)
    800083d2:	e922                	sd	s0,144(sp)
    800083d4:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800083d6:	ffffe097          	auipc	ra,0xffffe
    800083da:	e12080e7          	jalr	-494(ra) # 800061e8 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800083de:	f6840793          	addi	a5,s0,-152
    800083e2:	08000613          	li	a2,128
    800083e6:	85be                	mv	a1,a5
    800083e8:	4501                	li	a0,0
    800083ea:	ffffc097          	auipc	ra,0xffffc
    800083ee:	e34080e7          	jalr	-460(ra) # 8000421e <argstr>
    800083f2:	87aa                	mv	a5,a0
    800083f4:	0207c163          	bltz	a5,80008416 <sys_mkdir+0x48>
    800083f8:	f6840793          	addi	a5,s0,-152
    800083fc:	4681                	li	a3,0
    800083fe:	4601                	li	a2,0
    80008400:	4585                	li	a1,1
    80008402:	853e                	mv	a0,a5
    80008404:	00000097          	auipc	ra,0x0
    80008408:	b46080e7          	jalr	-1210(ra) # 80007f4a <create>
    8000840c:	fea43423          	sd	a0,-24(s0)
    80008410:	fe843783          	ld	a5,-24(s0)
    80008414:	e799                	bnez	a5,80008422 <sys_mkdir+0x54>
    end_op();
    80008416:	ffffe097          	auipc	ra,0xffffe
    8000841a:	e94080e7          	jalr	-364(ra) # 800062aa <end_op>
    return -1;
    8000841e:	57fd                	li	a5,-1
    80008420:	a821                	j	80008438 <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    80008422:	fe843503          	ld	a0,-24(s0)
    80008426:	ffffd097          	auipc	ra,0xffffd
    8000842a:	f96080e7          	jalr	-106(ra) # 800053bc <iunlockput>
  end_op();
    8000842e:	ffffe097          	auipc	ra,0xffffe
    80008432:	e7c080e7          	jalr	-388(ra) # 800062aa <end_op>
  return 0;
    80008436:	4781                	li	a5,0
}
    80008438:	853e                	mv	a0,a5
    8000843a:	60ea                	ld	ra,152(sp)
    8000843c:	644a                	ld	s0,144(sp)
    8000843e:	610d                	addi	sp,sp,160
    80008440:	8082                	ret

0000000080008442 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008442:	7135                	addi	sp,sp,-160
    80008444:	ed06                	sd	ra,152(sp)
    80008446:	e922                	sd	s0,144(sp)
    80008448:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000844a:	ffffe097          	auipc	ra,0xffffe
    8000844e:	d9e080e7          	jalr	-610(ra) # 800061e8 <begin_op>
  argint(1, &major);
    80008452:	f6440793          	addi	a5,s0,-156
    80008456:	85be                	mv	a1,a5
    80008458:	4505                	li	a0,1
    8000845a:	ffffc097          	auipc	ra,0xffffc
    8000845e:	d5c080e7          	jalr	-676(ra) # 800041b6 <argint>
  argint(2, &minor);
    80008462:	f6040793          	addi	a5,s0,-160
    80008466:	85be                	mv	a1,a5
    80008468:	4509                	li	a0,2
    8000846a:	ffffc097          	auipc	ra,0xffffc
    8000846e:	d4c080e7          	jalr	-692(ra) # 800041b6 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008472:	f6840793          	addi	a5,s0,-152
    80008476:	08000613          	li	a2,128
    8000847a:	85be                	mv	a1,a5
    8000847c:	4501                	li	a0,0
    8000847e:	ffffc097          	auipc	ra,0xffffc
    80008482:	da0080e7          	jalr	-608(ra) # 8000421e <argstr>
    80008486:	87aa                	mv	a5,a0
    80008488:	0207cc63          	bltz	a5,800084c0 <sys_mknod+0x7e>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    8000848c:	f6442783          	lw	a5,-156(s0)
    80008490:	0107971b          	slliw	a4,a5,0x10
    80008494:	4107571b          	sraiw	a4,a4,0x10
    80008498:	f6042783          	lw	a5,-160(s0)
    8000849c:	0107969b          	slliw	a3,a5,0x10
    800084a0:	4106d69b          	sraiw	a3,a3,0x10
    800084a4:	f6840793          	addi	a5,s0,-152
    800084a8:	863a                	mv	a2,a4
    800084aa:	458d                	li	a1,3
    800084ac:	853e                	mv	a0,a5
    800084ae:	00000097          	auipc	ra,0x0
    800084b2:	a9c080e7          	jalr	-1380(ra) # 80007f4a <create>
    800084b6:	fea43423          	sd	a0,-24(s0)
  if((argstr(0, path, MAXPATH)) < 0 ||
    800084ba:	fe843783          	ld	a5,-24(s0)
    800084be:	e799                	bnez	a5,800084cc <sys_mknod+0x8a>
    end_op();
    800084c0:	ffffe097          	auipc	ra,0xffffe
    800084c4:	dea080e7          	jalr	-534(ra) # 800062aa <end_op>
    return -1;
    800084c8:	57fd                	li	a5,-1
    800084ca:	a821                	j	800084e2 <sys_mknod+0xa0>
  }
  iunlockput(ip);
    800084cc:	fe843503          	ld	a0,-24(s0)
    800084d0:	ffffd097          	auipc	ra,0xffffd
    800084d4:	eec080e7          	jalr	-276(ra) # 800053bc <iunlockput>
  end_op();
    800084d8:	ffffe097          	auipc	ra,0xffffe
    800084dc:	dd2080e7          	jalr	-558(ra) # 800062aa <end_op>
  return 0;
    800084e0:	4781                	li	a5,0
}
    800084e2:	853e                	mv	a0,a5
    800084e4:	60ea                	ld	ra,152(sp)
    800084e6:	644a                	ld	s0,144(sp)
    800084e8:	610d                	addi	sp,sp,160
    800084ea:	8082                	ret

00000000800084ec <sys_chdir>:

uint64
sys_chdir(void)
{
    800084ec:	7135                	addi	sp,sp,-160
    800084ee:	ed06                	sd	ra,152(sp)
    800084f0:	e922                	sd	s0,144(sp)
    800084f2:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800084f4:	ffffa097          	auipc	ra,0xffffa
    800084f8:	424080e7          	jalr	1060(ra) # 80002918 <myproc>
    800084fc:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    80008500:	ffffe097          	auipc	ra,0xffffe
    80008504:	ce8080e7          	jalr	-792(ra) # 800061e8 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80008508:	f6040793          	addi	a5,s0,-160
    8000850c:	08000613          	li	a2,128
    80008510:	85be                	mv	a1,a5
    80008512:	4501                	li	a0,0
    80008514:	ffffc097          	auipc	ra,0xffffc
    80008518:	d0a080e7          	jalr	-758(ra) # 8000421e <argstr>
    8000851c:	87aa                	mv	a5,a0
    8000851e:	0007ce63          	bltz	a5,8000853a <sys_chdir+0x4e>
    80008522:	f6040793          	addi	a5,s0,-160
    80008526:	853e                	mv	a0,a5
    80008528:	ffffe097          	auipc	ra,0xffffe
    8000852c:	95c080e7          	jalr	-1700(ra) # 80005e84 <namei>
    80008530:	fea43023          	sd	a0,-32(s0)
    80008534:	fe043783          	ld	a5,-32(s0)
    80008538:	e799                	bnez	a5,80008546 <sys_chdir+0x5a>
    end_op();
    8000853a:	ffffe097          	auipc	ra,0xffffe
    8000853e:	d70080e7          	jalr	-656(ra) # 800062aa <end_op>
    return -1;
    80008542:	57fd                	li	a5,-1
    80008544:	a0b5                	j	800085b0 <sys_chdir+0xc4>
  }
  ilock(ip);
    80008546:	fe043503          	ld	a0,-32(s0)
    8000854a:	ffffd097          	auipc	ra,0xffffd
    8000854e:	c14080e7          	jalr	-1004(ra) # 8000515e <ilock>
  if(ip->type != T_DIR){
    80008552:	fe043783          	ld	a5,-32(s0)
    80008556:	04479783          	lh	a5,68(a5)
    8000855a:	0007871b          	sext.w	a4,a5
    8000855e:	4785                	li	a5,1
    80008560:	00f70e63          	beq	a4,a5,8000857c <sys_chdir+0x90>
    iunlockput(ip);
    80008564:	fe043503          	ld	a0,-32(s0)
    80008568:	ffffd097          	auipc	ra,0xffffd
    8000856c:	e54080e7          	jalr	-428(ra) # 800053bc <iunlockput>
    end_op();
    80008570:	ffffe097          	auipc	ra,0xffffe
    80008574:	d3a080e7          	jalr	-710(ra) # 800062aa <end_op>
    return -1;
    80008578:	57fd                	li	a5,-1
    8000857a:	a81d                	j	800085b0 <sys_chdir+0xc4>
  }
  iunlock(ip);
    8000857c:	fe043503          	ld	a0,-32(s0)
    80008580:	ffffd097          	auipc	ra,0xffffd
    80008584:	d12080e7          	jalr	-750(ra) # 80005292 <iunlock>
  iput(p->cwd);
    80008588:	fe843783          	ld	a5,-24(s0)
    8000858c:	1507b783          	ld	a5,336(a5)
    80008590:	853e                	mv	a0,a5
    80008592:	ffffd097          	auipc	ra,0xffffd
    80008596:	d5a080e7          	jalr	-678(ra) # 800052ec <iput>
  end_op();
    8000859a:	ffffe097          	auipc	ra,0xffffe
    8000859e:	d10080e7          	jalr	-752(ra) # 800062aa <end_op>
  p->cwd = ip;
    800085a2:	fe843783          	ld	a5,-24(s0)
    800085a6:	fe043703          	ld	a4,-32(s0)
    800085aa:	14e7b823          	sd	a4,336(a5)
  return 0;
    800085ae:	4781                	li	a5,0
}
    800085b0:	853e                	mv	a0,a5
    800085b2:	60ea                	ld	ra,152(sp)
    800085b4:	644a                	ld	s0,144(sp)
    800085b6:	610d                	addi	sp,sp,160
    800085b8:	8082                	ret

00000000800085ba <sys_exec>:

uint64
sys_exec(void)
{
    800085ba:	7161                	addi	sp,sp,-432
    800085bc:	f706                	sd	ra,424(sp)
    800085be:	f322                	sd	s0,416(sp)
    800085c0:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    800085c2:	e6040793          	addi	a5,s0,-416
    800085c6:	85be                	mv	a1,a5
    800085c8:	4505                	li	a0,1
    800085ca:	ffffc097          	auipc	ra,0xffffc
    800085ce:	c22080e7          	jalr	-990(ra) # 800041ec <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    800085d2:	f6840793          	addi	a5,s0,-152
    800085d6:	08000613          	li	a2,128
    800085da:	85be                	mv	a1,a5
    800085dc:	4501                	li	a0,0
    800085de:	ffffc097          	auipc	ra,0xffffc
    800085e2:	c40080e7          	jalr	-960(ra) # 8000421e <argstr>
    800085e6:	87aa                	mv	a5,a0
    800085e8:	0007d463          	bgez	a5,800085f0 <sys_exec+0x36>
    return -1;
    800085ec:	57fd                	li	a5,-1
    800085ee:	a249                	j	80008770 <sys_exec+0x1b6>
  }
  memset(argv, 0, sizeof(argv));
    800085f0:	e6840793          	addi	a5,s0,-408
    800085f4:	10000613          	li	a2,256
    800085f8:	4581                	li	a1,0
    800085fa:	853e                	mv	a0,a5
    800085fc:	ffff9097          	auipc	ra,0xffff9
    80008600:	f02080e7          	jalr	-254(ra) # 800014fe <memset>
  for(i=0;; i++){
    80008604:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    80008608:	fec42783          	lw	a5,-20(s0)
    8000860c:	873e                	mv	a4,a5
    8000860e:	47fd                	li	a5,31
    80008610:	10e7e463          	bltu	a5,a4,80008718 <sys_exec+0x15e>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80008614:	fec42783          	lw	a5,-20(s0)
    80008618:	00379713          	slli	a4,a5,0x3
    8000861c:	e6043783          	ld	a5,-416(s0)
    80008620:	97ba                	add	a5,a5,a4
    80008622:	e5840713          	addi	a4,s0,-424
    80008626:	85ba                	mv	a1,a4
    80008628:	853e                	mv	a0,a5
    8000862a:	ffffc097          	auipc	ra,0xffffc
    8000862e:	a1a080e7          	jalr	-1510(ra) # 80004044 <fetchaddr>
    80008632:	87aa                	mv	a5,a0
    80008634:	0e07c463          	bltz	a5,8000871c <sys_exec+0x162>
      goto bad;
    }
    if(uarg == 0){
    80008638:	e5843783          	ld	a5,-424(s0)
    8000863c:	eb95                	bnez	a5,80008670 <sys_exec+0xb6>
      argv[i] = 0;
    8000863e:	fec42783          	lw	a5,-20(s0)
    80008642:	078e                	slli	a5,a5,0x3
    80008644:	ff040713          	addi	a4,s0,-16
    80008648:	97ba                	add	a5,a5,a4
    8000864a:	e607bc23          	sd	zero,-392(a5)
      break;
    8000864e:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    80008650:	e6840713          	addi	a4,s0,-408
    80008654:	f6840793          	addi	a5,s0,-152
    80008658:	85ba                	mv	a1,a4
    8000865a:	853e                	mv	a0,a5
    8000865c:	fffff097          	auipc	ra,0xfffff
    80008660:	c1e080e7          	jalr	-994(ra) # 8000727a <exec>
    80008664:	87aa                	mv	a5,a0
    80008666:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000866a:	fe042623          	sw	zero,-20(s0)
    8000866e:	a059                	j	800086f4 <sys_exec+0x13a>
    argv[i] = kalloc();
    80008670:	ffff9097          	auipc	ra,0xffff9
    80008674:	b66080e7          	jalr	-1178(ra) # 800011d6 <kalloc>
    80008678:	872a                	mv	a4,a0
    8000867a:	fec42783          	lw	a5,-20(s0)
    8000867e:	078e                	slli	a5,a5,0x3
    80008680:	ff040693          	addi	a3,s0,-16
    80008684:	97b6                	add	a5,a5,a3
    80008686:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    8000868a:	fec42783          	lw	a5,-20(s0)
    8000868e:	078e                	slli	a5,a5,0x3
    80008690:	ff040713          	addi	a4,s0,-16
    80008694:	97ba                	add	a5,a5,a4
    80008696:	e787b783          	ld	a5,-392(a5)
    8000869a:	c3d9                	beqz	a5,80008720 <sys_exec+0x166>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000869c:	e5843703          	ld	a4,-424(s0)
    800086a0:	fec42783          	lw	a5,-20(s0)
    800086a4:	078e                	slli	a5,a5,0x3
    800086a6:	ff040693          	addi	a3,s0,-16
    800086aa:	97b6                	add	a5,a5,a3
    800086ac:	e787b783          	ld	a5,-392(a5)
    800086b0:	6605                	lui	a2,0x1
    800086b2:	85be                	mv	a1,a5
    800086b4:	853a                	mv	a0,a4
    800086b6:	ffffc097          	auipc	ra,0xffffc
    800086ba:	9fc080e7          	jalr	-1540(ra) # 800040b2 <fetchstr>
    800086be:	87aa                	mv	a5,a0
    800086c0:	0607c263          	bltz	a5,80008724 <sys_exec+0x16a>
  for(i=0;; i++){
    800086c4:	fec42783          	lw	a5,-20(s0)
    800086c8:	2785                	addiw	a5,a5,1
    800086ca:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    800086ce:	bf2d                	j	80008608 <sys_exec+0x4e>
    kfree(argv[i]);
    800086d0:	fec42783          	lw	a5,-20(s0)
    800086d4:	078e                	slli	a5,a5,0x3
    800086d6:	ff040713          	addi	a4,s0,-16
    800086da:	97ba                	add	a5,a5,a4
    800086dc:	e787b783          	ld	a5,-392(a5)
    800086e0:	853e                	mv	a0,a5
    800086e2:	ffff9097          	auipc	ra,0xffff9
    800086e6:	a4e080e7          	jalr	-1458(ra) # 80001130 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800086ea:	fec42783          	lw	a5,-20(s0)
    800086ee:	2785                	addiw	a5,a5,1
    800086f0:	fef42623          	sw	a5,-20(s0)
    800086f4:	fec42783          	lw	a5,-20(s0)
    800086f8:	873e                	mv	a4,a5
    800086fa:	47fd                	li	a5,31
    800086fc:	00e7eb63          	bltu	a5,a4,80008712 <sys_exec+0x158>
    80008700:	fec42783          	lw	a5,-20(s0)
    80008704:	078e                	slli	a5,a5,0x3
    80008706:	ff040713          	addi	a4,s0,-16
    8000870a:	97ba                	add	a5,a5,a4
    8000870c:	e787b783          	ld	a5,-392(a5)
    80008710:	f3e1                	bnez	a5,800086d0 <sys_exec+0x116>

  return ret;
    80008712:	fe842783          	lw	a5,-24(s0)
    80008716:	a8a9                	j	80008770 <sys_exec+0x1b6>
      goto bad;
    80008718:	0001                	nop
    8000871a:	a031                	j	80008726 <sys_exec+0x16c>
      goto bad;
    8000871c:	0001                	nop
    8000871e:	a021                	j	80008726 <sys_exec+0x16c>
      goto bad;
    80008720:	0001                	nop
    80008722:	a011                	j	80008726 <sys_exec+0x16c>
      goto bad;
    80008724:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008726:	fe042623          	sw	zero,-20(s0)
    8000872a:	a01d                	j	80008750 <sys_exec+0x196>
    kfree(argv[i]);
    8000872c:	fec42783          	lw	a5,-20(s0)
    80008730:	078e                	slli	a5,a5,0x3
    80008732:	ff040713          	addi	a4,s0,-16
    80008736:	97ba                	add	a5,a5,a4
    80008738:	e787b783          	ld	a5,-392(a5)
    8000873c:	853e                	mv	a0,a5
    8000873e:	ffff9097          	auipc	ra,0xffff9
    80008742:	9f2080e7          	jalr	-1550(ra) # 80001130 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008746:	fec42783          	lw	a5,-20(s0)
    8000874a:	2785                	addiw	a5,a5,1
    8000874c:	fef42623          	sw	a5,-20(s0)
    80008750:	fec42783          	lw	a5,-20(s0)
    80008754:	873e                	mv	a4,a5
    80008756:	47fd                	li	a5,31
    80008758:	00e7eb63          	bltu	a5,a4,8000876e <sys_exec+0x1b4>
    8000875c:	fec42783          	lw	a5,-20(s0)
    80008760:	078e                	slli	a5,a5,0x3
    80008762:	ff040713          	addi	a4,s0,-16
    80008766:	97ba                	add	a5,a5,a4
    80008768:	e787b783          	ld	a5,-392(a5)
    8000876c:	f3e1                	bnez	a5,8000872c <sys_exec+0x172>
  return -1;
    8000876e:	57fd                	li	a5,-1
}
    80008770:	853e                	mv	a0,a5
    80008772:	70ba                	ld	ra,424(sp)
    80008774:	741a                	ld	s0,416(sp)
    80008776:	615d                	addi	sp,sp,432
    80008778:	8082                	ret

000000008000877a <sys_pipe>:

uint64
sys_pipe(void)
{
    8000877a:	7139                	addi	sp,sp,-64
    8000877c:	fc06                	sd	ra,56(sp)
    8000877e:	f822                	sd	s0,48(sp)
    80008780:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80008782:	ffffa097          	auipc	ra,0xffffa
    80008786:	196080e7          	jalr	406(ra) # 80002918 <myproc>
    8000878a:	fea43423          	sd	a0,-24(s0)

  argaddr(0, &fdarray);
    8000878e:	fe040793          	addi	a5,s0,-32
    80008792:	85be                	mv	a1,a5
    80008794:	4501                	li	a0,0
    80008796:	ffffc097          	auipc	ra,0xffffc
    8000879a:	a56080e7          	jalr	-1450(ra) # 800041ec <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    8000879e:	fd040713          	addi	a4,s0,-48
    800087a2:	fd840793          	addi	a5,s0,-40
    800087a6:	85ba                	mv	a1,a4
    800087a8:	853e                	mv	a0,a5
    800087aa:	ffffe097          	auipc	ra,0xffffe
    800087ae:	5ee080e7          	jalr	1518(ra) # 80006d98 <pipealloc>
    800087b2:	87aa                	mv	a5,a0
    800087b4:	0007d463          	bgez	a5,800087bc <sys_pipe+0x42>
    return -1;
    800087b8:	57fd                	li	a5,-1
    800087ba:	a219                	j	800088c0 <sys_pipe+0x146>
  fd0 = -1;
    800087bc:	57fd                	li	a5,-1
    800087be:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800087c2:	fd843783          	ld	a5,-40(s0)
    800087c6:	853e                	mv	a0,a5
    800087c8:	fffff097          	auipc	ra,0xfffff
    800087cc:	0da080e7          	jalr	218(ra) # 800078a2 <fdalloc>
    800087d0:	87aa                	mv	a5,a0
    800087d2:	fcf42623          	sw	a5,-52(s0)
    800087d6:	fcc42783          	lw	a5,-52(s0)
    800087da:	0207c063          	bltz	a5,800087fa <sys_pipe+0x80>
    800087de:	fd043783          	ld	a5,-48(s0)
    800087e2:	853e                	mv	a0,a5
    800087e4:	fffff097          	auipc	ra,0xfffff
    800087e8:	0be080e7          	jalr	190(ra) # 800078a2 <fdalloc>
    800087ec:	87aa                	mv	a5,a0
    800087ee:	fcf42423          	sw	a5,-56(s0)
    800087f2:	fc842783          	lw	a5,-56(s0)
    800087f6:	0207df63          	bgez	a5,80008834 <sys_pipe+0xba>
    if(fd0 >= 0)
    800087fa:	fcc42783          	lw	a5,-52(s0)
    800087fe:	0007cb63          	bltz	a5,80008814 <sys_pipe+0x9a>
      p->ofile[fd0] = 0;
    80008802:	fcc42783          	lw	a5,-52(s0)
    80008806:	fe843703          	ld	a4,-24(s0)
    8000880a:	07e9                	addi	a5,a5,26
    8000880c:	078e                	slli	a5,a5,0x3
    8000880e:	97ba                	add	a5,a5,a4
    80008810:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80008814:	fd843783          	ld	a5,-40(s0)
    80008818:	853e                	mv	a0,a5
    8000881a:	ffffe097          	auipc	ra,0xffffe
    8000881e:	068080e7          	jalr	104(ra) # 80006882 <fileclose>
    fileclose(wf);
    80008822:	fd043783          	ld	a5,-48(s0)
    80008826:	853e                	mv	a0,a5
    80008828:	ffffe097          	auipc	ra,0xffffe
    8000882c:	05a080e7          	jalr	90(ra) # 80006882 <fileclose>
    return -1;
    80008830:	57fd                	li	a5,-1
    80008832:	a079                	j	800088c0 <sys_pipe+0x146>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008834:	fe843783          	ld	a5,-24(s0)
    80008838:	6bbc                	ld	a5,80(a5)
    8000883a:	fe043703          	ld	a4,-32(s0)
    8000883e:	fcc40613          	addi	a2,s0,-52
    80008842:	4691                	li	a3,4
    80008844:	85ba                	mv	a1,a4
    80008846:	853e                	mv	a0,a5
    80008848:	ffffa097          	auipc	ra,0xffffa
    8000884c:	b9a080e7          	jalr	-1126(ra) # 800023e2 <copyout>
    80008850:	87aa                	mv	a5,a0
    80008852:	0207c463          	bltz	a5,8000887a <sys_pipe+0x100>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80008856:	fe843783          	ld	a5,-24(s0)
    8000885a:	6bb8                	ld	a4,80(a5)
    8000885c:	fe043783          	ld	a5,-32(s0)
    80008860:	0791                	addi	a5,a5,4
    80008862:	fc840613          	addi	a2,s0,-56
    80008866:	4691                	li	a3,4
    80008868:	85be                	mv	a1,a5
    8000886a:	853a                	mv	a0,a4
    8000886c:	ffffa097          	auipc	ra,0xffffa
    80008870:	b76080e7          	jalr	-1162(ra) # 800023e2 <copyout>
    80008874:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008876:	0407d463          	bgez	a5,800088be <sys_pipe+0x144>
    p->ofile[fd0] = 0;
    8000887a:	fcc42783          	lw	a5,-52(s0)
    8000887e:	fe843703          	ld	a4,-24(s0)
    80008882:	07e9                	addi	a5,a5,26
    80008884:	078e                	slli	a5,a5,0x3
    80008886:	97ba                	add	a5,a5,a4
    80008888:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8000888c:	fc842783          	lw	a5,-56(s0)
    80008890:	fe843703          	ld	a4,-24(s0)
    80008894:	07e9                	addi	a5,a5,26
    80008896:	078e                	slli	a5,a5,0x3
    80008898:	97ba                	add	a5,a5,a4
    8000889a:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    8000889e:	fd843783          	ld	a5,-40(s0)
    800088a2:	853e                	mv	a0,a5
    800088a4:	ffffe097          	auipc	ra,0xffffe
    800088a8:	fde080e7          	jalr	-34(ra) # 80006882 <fileclose>
    fileclose(wf);
    800088ac:	fd043783          	ld	a5,-48(s0)
    800088b0:	853e                	mv	a0,a5
    800088b2:	ffffe097          	auipc	ra,0xffffe
    800088b6:	fd0080e7          	jalr	-48(ra) # 80006882 <fileclose>
    return -1;
    800088ba:	57fd                	li	a5,-1
    800088bc:	a011                	j	800088c0 <sys_pipe+0x146>
  }
  return 0;
    800088be:	4781                	li	a5,0
}
    800088c0:	853e                	mv	a0,a5
    800088c2:	70e2                	ld	ra,56(sp)
    800088c4:	7442                	ld	s0,48(sp)
    800088c6:	6121                	addi	sp,sp,64
    800088c8:	8082                	ret
    800088ca:	0000                	unimp
    800088cc:	0000                	unimp
	...

00000000800088d0 <kernelvec>:
    800088d0:	7111                	addi	sp,sp,-256
    800088d2:	e006                	sd	ra,0(sp)
    800088d4:	e40a                	sd	sp,8(sp)
    800088d6:	e80e                	sd	gp,16(sp)
    800088d8:	ec12                	sd	tp,24(sp)
    800088da:	f016                	sd	t0,32(sp)
    800088dc:	f41a                	sd	t1,40(sp)
    800088de:	f81e                	sd	t2,48(sp)
    800088e0:	fc22                	sd	s0,56(sp)
    800088e2:	e0a6                	sd	s1,64(sp)
    800088e4:	e4aa                	sd	a0,72(sp)
    800088e6:	e8ae                	sd	a1,80(sp)
    800088e8:	ecb2                	sd	a2,88(sp)
    800088ea:	f0b6                	sd	a3,96(sp)
    800088ec:	f4ba                	sd	a4,104(sp)
    800088ee:	f8be                	sd	a5,112(sp)
    800088f0:	fcc2                	sd	a6,120(sp)
    800088f2:	e146                	sd	a7,128(sp)
    800088f4:	e54a                	sd	s2,136(sp)
    800088f6:	e94e                	sd	s3,144(sp)
    800088f8:	ed52                	sd	s4,152(sp)
    800088fa:	f156                	sd	s5,160(sp)
    800088fc:	f55a                	sd	s6,168(sp)
    800088fe:	f95e                	sd	s7,176(sp)
    80008900:	fd62                	sd	s8,184(sp)
    80008902:	e1e6                	sd	s9,192(sp)
    80008904:	e5ea                	sd	s10,200(sp)
    80008906:	e9ee                	sd	s11,208(sp)
    80008908:	edf2                	sd	t3,216(sp)
    8000890a:	f1f6                	sd	t4,224(sp)
    8000890c:	f5fa                	sd	t5,232(sp)
    8000890e:	f9fe                	sd	t6,240(sp)
    80008910:	cb0fb0ef          	jal	ra,80003dc0 <kerneltrap>
    80008914:	6082                	ld	ra,0(sp)
    80008916:	6122                	ld	sp,8(sp)
    80008918:	61c2                	ld	gp,16(sp)
    8000891a:	7282                	ld	t0,32(sp)
    8000891c:	7322                	ld	t1,40(sp)
    8000891e:	73c2                	ld	t2,48(sp)
    80008920:	7462                	ld	s0,56(sp)
    80008922:	6486                	ld	s1,64(sp)
    80008924:	6526                	ld	a0,72(sp)
    80008926:	65c6                	ld	a1,80(sp)
    80008928:	6666                	ld	a2,88(sp)
    8000892a:	7686                	ld	a3,96(sp)
    8000892c:	7726                	ld	a4,104(sp)
    8000892e:	77c6                	ld	a5,112(sp)
    80008930:	7866                	ld	a6,120(sp)
    80008932:	688a                	ld	a7,128(sp)
    80008934:	692a                	ld	s2,136(sp)
    80008936:	69ca                	ld	s3,144(sp)
    80008938:	6a6a                	ld	s4,152(sp)
    8000893a:	7a8a                	ld	s5,160(sp)
    8000893c:	7b2a                	ld	s6,168(sp)
    8000893e:	7bca                	ld	s7,176(sp)
    80008940:	7c6a                	ld	s8,184(sp)
    80008942:	6c8e                	ld	s9,192(sp)
    80008944:	6d2e                	ld	s10,200(sp)
    80008946:	6dce                	ld	s11,208(sp)
    80008948:	6e6e                	ld	t3,216(sp)
    8000894a:	7e8e                	ld	t4,224(sp)
    8000894c:	7f2e                	ld	t5,232(sp)
    8000894e:	7fce                	ld	t6,240(sp)
    80008950:	6111                	addi	sp,sp,256
    80008952:	10200073          	sret
    80008956:	00000013          	nop
    8000895a:	00000013          	nop
    8000895e:	0001                	nop

0000000080008960 <timervec>:
    80008960:	34051573          	csrrw	a0,mscratch,a0
    80008964:	e10c                	sd	a1,0(a0)
    80008966:	e510                	sd	a2,8(a0)
    80008968:	e914                	sd	a3,16(a0)
    8000896a:	6d0c                	ld	a1,24(a0)
    8000896c:	7110                	ld	a2,32(a0)
    8000896e:	6194                	ld	a3,0(a1)
    80008970:	96b2                	add	a3,a3,a2
    80008972:	e194                	sd	a3,0(a1)
    80008974:	4589                	li	a1,2
    80008976:	14459073          	csrw	sip,a1
    8000897a:	6914                	ld	a3,16(a0)
    8000897c:	6510                	ld	a2,8(a0)
    8000897e:	610c                	ld	a1,0(a0)
    80008980:	34051573          	csrrw	a0,mscratch,a0
    80008984:	30200073          	mret
	...

000000008000898a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000898a:	1141                	addi	sp,sp,-16
    8000898c:	e422                	sd	s0,8(sp)
    8000898e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80008990:	0c0007b7          	lui	a5,0xc000
    80008994:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    80008998:	4705                	li	a4,1
    8000899a:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000899c:	0c0007b7          	lui	a5,0xc000
    800089a0:	0791                	addi	a5,a5,4
    800089a2:	4705                	li	a4,1
    800089a4:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO1_IRQ*4) = 1;
    800089a6:	0c0007b7          	lui	a5,0xc000
    800089aa:	07a1                	addi	a5,a5,8
    800089ac:	4705                	li	a4,1
    800089ae:	c398                	sw	a4,0(a5)
}
    800089b0:	0001                	nop
    800089b2:	6422                	ld	s0,8(sp)
    800089b4:	0141                	addi	sp,sp,16
    800089b6:	8082                	ret

00000000800089b8 <plicinithart>:

void
plicinithart(void)
{
    800089b8:	1101                	addi	sp,sp,-32
    800089ba:	ec06                	sd	ra,24(sp)
    800089bc:	e822                	sd	s0,16(sp)
    800089be:	1000                	addi	s0,sp,32
  int hart = cpuid();
    800089c0:	ffffa097          	auipc	ra,0xffffa
    800089c4:	efa080e7          	jalr	-262(ra) # 800028ba <cpuid>
    800089c8:	87aa                	mv	a5,a0
    800089ca:	fef42623          	sw	a5,-20(s0)
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ) | (1 << VIRTIO1_IRQ);
    800089ce:	fec42783          	lw	a5,-20(s0)
    800089d2:	0087979b          	slliw	a5,a5,0x8
    800089d6:	2781                	sext.w	a5,a5
    800089d8:	873e                	mv	a4,a5
    800089da:	0c0027b7          	lui	a5,0xc002
    800089de:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    800089e2:	97ba                	add	a5,a5,a4
    800089e4:	873e                	mv	a4,a5
    800089e6:	40600793          	li	a5,1030
    800089ea:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800089ec:	fec42783          	lw	a5,-20(s0)
    800089f0:	00d7979b          	slliw	a5,a5,0xd
    800089f4:	2781                	sext.w	a5,a5
    800089f6:	873e                	mv	a4,a5
    800089f8:	0c2017b7          	lui	a5,0xc201
    800089fc:	97ba                	add	a5,a5,a4
    800089fe:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80008a02:	0001                	nop
    80008a04:	60e2                	ld	ra,24(sp)
    80008a06:	6442                	ld	s0,16(sp)
    80008a08:	6105                	addi	sp,sp,32
    80008a0a:	8082                	ret

0000000080008a0c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80008a0c:	1101                	addi	sp,sp,-32
    80008a0e:	ec06                	sd	ra,24(sp)
    80008a10:	e822                	sd	s0,16(sp)
    80008a12:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80008a14:	ffffa097          	auipc	ra,0xffffa
    80008a18:	ea6080e7          	jalr	-346(ra) # 800028ba <cpuid>
    80008a1c:	87aa                	mv	a5,a0
    80008a1e:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80008a22:	fec42783          	lw	a5,-20(s0)
    80008a26:	00d7979b          	slliw	a5,a5,0xd
    80008a2a:	2781                	sext.w	a5,a5
    80008a2c:	873e                	mv	a4,a5
    80008a2e:	0c2017b7          	lui	a5,0xc201
    80008a32:	0791                	addi	a5,a5,4
    80008a34:	97ba                	add	a5,a5,a4
    80008a36:	439c                	lw	a5,0(a5)
    80008a38:	fef42423          	sw	a5,-24(s0)
  return irq;
    80008a3c:	fe842783          	lw	a5,-24(s0)
}
    80008a40:	853e                	mv	a0,a5
    80008a42:	60e2                	ld	ra,24(sp)
    80008a44:	6442                	ld	s0,16(sp)
    80008a46:	6105                	addi	sp,sp,32
    80008a48:	8082                	ret

0000000080008a4a <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80008a4a:	7179                	addi	sp,sp,-48
    80008a4c:	f406                	sd	ra,40(sp)
    80008a4e:	f022                	sd	s0,32(sp)
    80008a50:	1800                	addi	s0,sp,48
    80008a52:	87aa                	mv	a5,a0
    80008a54:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    80008a58:	ffffa097          	auipc	ra,0xffffa
    80008a5c:	e62080e7          	jalr	-414(ra) # 800028ba <cpuid>
    80008a60:	87aa                	mv	a5,a0
    80008a62:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80008a66:	fec42783          	lw	a5,-20(s0)
    80008a6a:	00d7979b          	slliw	a5,a5,0xd
    80008a6e:	2781                	sext.w	a5,a5
    80008a70:	873e                	mv	a4,a5
    80008a72:	0c2017b7          	lui	a5,0xc201
    80008a76:	0791                	addi	a5,a5,4
    80008a78:	97ba                	add	a5,a5,a4
    80008a7a:	873e                	mv	a4,a5
    80008a7c:	fdc42783          	lw	a5,-36(s0)
    80008a80:	c31c                	sw	a5,0(a4)
}
    80008a82:	0001                	nop
    80008a84:	70a2                	ld	ra,40(sp)
    80008a86:	7402                	ld	s0,32(sp)
    80008a88:	6145                	addi	sp,sp,48
    80008a8a:	8082                	ret

0000000080008a8c <r_sstatus>:
{
    80008a8c:	1101                	addi	sp,sp,-32
    80008a8e:	ec22                	sd	s0,24(sp)
    80008a90:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80008a92:	100027f3          	csrr	a5,sstatus
    80008a96:	fef43423          	sd	a5,-24(s0)
  return x;
    80008a9a:	fe843783          	ld	a5,-24(s0)
}
    80008a9e:	853e                	mv	a0,a5
    80008aa0:	6462                	ld	s0,24(sp)
    80008aa2:	6105                	addi	sp,sp,32
    80008aa4:	8082                	ret

0000000080008aa6 <w_sstatus>:
{
    80008aa6:	1101                	addi	sp,sp,-32
    80008aa8:	ec22                	sd	s0,24(sp)
    80008aaa:	1000                	addi	s0,sp,32
    80008aac:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80008ab0:	fe843783          	ld	a5,-24(s0)
    80008ab4:	10079073          	csrw	sstatus,a5
}
    80008ab8:	0001                	nop
    80008aba:	6462                	ld	s0,24(sp)
    80008abc:	6105                	addi	sp,sp,32
    80008abe:	8082                	ret

0000000080008ac0 <intr_on>:
{
    80008ac0:	1141                	addi	sp,sp,-16
    80008ac2:	e406                	sd	ra,8(sp)
    80008ac4:	e022                	sd	s0,0(sp)
    80008ac6:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80008ac8:	00000097          	auipc	ra,0x0
    80008acc:	fc4080e7          	jalr	-60(ra) # 80008a8c <r_sstatus>
    80008ad0:	87aa                	mv	a5,a0
    80008ad2:	0027e793          	ori	a5,a5,2
    80008ad6:	853e                	mv	a0,a5
    80008ad8:	00000097          	auipc	ra,0x0
    80008adc:	fce080e7          	jalr	-50(ra) # 80008aa6 <w_sstatus>
}
    80008ae0:	0001                	nop
    80008ae2:	60a2                	ld	ra,8(sp)
    80008ae4:	6402                	ld	s0,0(sp)
    80008ae6:	0141                	addi	sp,sp,16
    80008ae8:	8082                	ret

0000000080008aea <intr_off>:
{
    80008aea:	1141                	addi	sp,sp,-16
    80008aec:	e406                	sd	ra,8(sp)
    80008aee:	e022                	sd	s0,0(sp)
    80008af0:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80008af2:	00000097          	auipc	ra,0x0
    80008af6:	f9a080e7          	jalr	-102(ra) # 80008a8c <r_sstatus>
    80008afa:	87aa                	mv	a5,a0
    80008afc:	9bf5                	andi	a5,a5,-3
    80008afe:	853e                	mv	a0,a5
    80008b00:	00000097          	auipc	ra,0x0
    80008b04:	fa6080e7          	jalr	-90(ra) # 80008aa6 <w_sstatus>
}
    80008b08:	0001                	nop
    80008b0a:	60a2                	ld	ra,8(sp)
    80008b0c:	6402                	ld	s0,0(sp)
    80008b0e:	0141                	addi	sp,sp,16
    80008b10:	8082                	ret

0000000080008b12 <virtio_disk_init>:

static struct buf* swap_buffer;

void
virtio_disk_init(int id, char * name)
{
    80008b12:	7139                	addi	sp,sp,-64
    80008b14:	fc06                	sd	ra,56(sp)
    80008b16:	f822                	sd	s0,48(sp)
    80008b18:	0080                	addi	s0,sp,64
    80008b1a:	87aa                	mv	a5,a0
    80008b1c:	fcb43023          	sd	a1,-64(s0)
    80008b20:	fcf42623          	sw	a5,-52(s0)
  uint32 status = 0;
    80008b24:	fe042423          	sw	zero,-24(s0)

  initlock(&disk[id].vdisk_lock, name);
    80008b28:	fcc42703          	lw	a4,-52(s0)
    80008b2c:	15000793          	li	a5,336
    80008b30:	02f707b3          	mul	a5,a4,a5
    80008b34:	13078713          	addi	a4,a5,304 # c201130 <_entry-0x73dfeed0>
    80008b38:	0001c797          	auipc	a5,0x1c
    80008b3c:	15078793          	addi	a5,a5,336 # 80024c88 <disk>
    80008b40:	97ba                	add	a5,a5,a4
    80008b42:	fc043583          	ld	a1,-64(s0)
    80008b46:	853e                	mv	a0,a5
    80008b48:	ffff8097          	auipc	ra,0xffff8
    80008b4c:	7b2080e7          	jalr	1970(ra) # 800012fa <initlock>
  disk[id].name = name;
    80008b50:	0001c717          	auipc	a4,0x1c
    80008b54:	13870713          	addi	a4,a4,312 # 80024c88 <disk>
    80008b58:	fcc42683          	lw	a3,-52(s0)
    80008b5c:	15000793          	li	a5,336
    80008b60:	02f687b3          	mul	a5,a3,a5
    80008b64:	97ba                	add	a5,a5,a4
    80008b66:	fc043703          	ld	a4,-64(s0)
    80008b6a:	e398                	sd	a4,0(a5)

  if(*R(id, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008b6c:	fcc42703          	lw	a4,-52(s0)
    80008b70:	67c1                	lui	a5,0x10
    80008b72:	0785                	addi	a5,a5,1
    80008b74:	97ba                	add	a5,a5,a4
    80008b76:	07b2                	slli	a5,a5,0xc
    80008b78:	439c                	lw	a5,0(a5)
    80008b7a:	2781                	sext.w	a5,a5
    80008b7c:	873e                	mv	a4,a5
    80008b7e:	747277b7          	lui	a5,0x74727
    80008b82:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80008b86:	04f71c63          	bne	a4,a5,80008bde <virtio_disk_init+0xcc>
     *R(id, VIRTIO_MMIO_VERSION) != 2 ||
    80008b8a:	fcc42703          	lw	a4,-52(s0)
    80008b8e:	67c1                	lui	a5,0x10
    80008b90:	0785                	addi	a5,a5,1
    80008b92:	97ba                	add	a5,a5,a4
    80008b94:	07b2                	slli	a5,a5,0xc
    80008b96:	0791                	addi	a5,a5,4
    80008b98:	439c                	lw	a5,0(a5)
    80008b9a:	2781                	sext.w	a5,a5
  if(*R(id, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008b9c:	873e                	mv	a4,a5
    80008b9e:	4789                	li	a5,2
    80008ba0:	02f71f63          	bne	a4,a5,80008bde <virtio_disk_init+0xcc>
     *R(id, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008ba4:	fcc42703          	lw	a4,-52(s0)
    80008ba8:	67c1                	lui	a5,0x10
    80008baa:	0785                	addi	a5,a5,1
    80008bac:	97ba                	add	a5,a5,a4
    80008bae:	07b2                	slli	a5,a5,0xc
    80008bb0:	07a1                	addi	a5,a5,8
    80008bb2:	439c                	lw	a5,0(a5)
    80008bb4:	2781                	sext.w	a5,a5
     *R(id, VIRTIO_MMIO_VERSION) != 2 ||
    80008bb6:	873e                	mv	a4,a5
    80008bb8:	4789                	li	a5,2
    80008bba:	02f71263          	bne	a4,a5,80008bde <virtio_disk_init+0xcc>
     *R(id, VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80008bbe:	fcc42703          	lw	a4,-52(s0)
    80008bc2:	67c1                	lui	a5,0x10
    80008bc4:	0785                	addi	a5,a5,1
    80008bc6:	97ba                	add	a5,a5,a4
    80008bc8:	07b2                	slli	a5,a5,0xc
    80008bca:	07b1                	addi	a5,a5,12
    80008bcc:	439c                	lw	a5,0(a5)
    80008bce:	2781                	sext.w	a5,a5
     *R(id, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008bd0:	873e                	mv	a4,a5
    80008bd2:	554d47b7          	lui	a5,0x554d4
    80008bd6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80008bda:	00f70d63          	beq	a4,a5,80008bf4 <virtio_disk_init+0xe2>
    panic_concat(2, "could not find virtio disk: ", name);
    80008bde:	fc043603          	ld	a2,-64(s0)
    80008be2:	00003597          	auipc	a1,0x3
    80008be6:	a8e58593          	addi	a1,a1,-1394 # 8000b670 <etext+0x670>
    80008bea:	4509                	li	a0,2
    80008bec:	ffff8097          	auipc	ra,0xffff8
    80008bf0:	0f2080e7          	jalr	242(ra) # 80000cde <panic_concat>
  }
  
  // reset device
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008bf4:	fcc42703          	lw	a4,-52(s0)
    80008bf8:	67c1                	lui	a5,0x10
    80008bfa:	0785                	addi	a5,a5,1
    80008bfc:	97ba                	add	a5,a5,a4
    80008bfe:	07b2                	slli	a5,a5,0xc
    80008c00:	07078793          	addi	a5,a5,112 # 10070 <_entry-0x7ffeff90>
    80008c04:	873e                	mv	a4,a5
    80008c06:	fe842783          	lw	a5,-24(s0)
    80008c0a:	c31c                	sw	a5,0(a4)

  // set ACKNOWLEDGE status bit
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80008c0c:	fe842783          	lw	a5,-24(s0)
    80008c10:	0017e793          	ori	a5,a5,1
    80008c14:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008c18:	fcc42703          	lw	a4,-52(s0)
    80008c1c:	67c1                	lui	a5,0x10
    80008c1e:	0785                	addi	a5,a5,1
    80008c20:	97ba                	add	a5,a5,a4
    80008c22:	07b2                	slli	a5,a5,0xc
    80008c24:	07078793          	addi	a5,a5,112 # 10070 <_entry-0x7ffeff90>
    80008c28:	873e                	mv	a4,a5
    80008c2a:	fe842783          	lw	a5,-24(s0)
    80008c2e:	c31c                	sw	a5,0(a4)

  // set DRIVER status bit
  status |= VIRTIO_CONFIG_S_DRIVER;
    80008c30:	fe842783          	lw	a5,-24(s0)
    80008c34:	0027e793          	ori	a5,a5,2
    80008c38:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008c3c:	fcc42703          	lw	a4,-52(s0)
    80008c40:	67c1                	lui	a5,0x10
    80008c42:	0785                	addi	a5,a5,1
    80008c44:	97ba                	add	a5,a5,a4
    80008c46:	07b2                	slli	a5,a5,0xc
    80008c48:	07078793          	addi	a5,a5,112 # 10070 <_entry-0x7ffeff90>
    80008c4c:	873e                	mv	a4,a5
    80008c4e:	fe842783          	lw	a5,-24(s0)
    80008c52:	c31c                	sw	a5,0(a4)

  // negotiate features
  uint64 features = *R(id, VIRTIO_MMIO_DEVICE_FEATURES);
    80008c54:	fcc42703          	lw	a4,-52(s0)
    80008c58:	67c1                	lui	a5,0x10
    80008c5a:	0785                	addi	a5,a5,1
    80008c5c:	97ba                	add	a5,a5,a4
    80008c5e:	07b2                	slli	a5,a5,0xc
    80008c60:	07c1                	addi	a5,a5,16
    80008c62:	439c                	lw	a5,0(a5)
    80008c64:	2781                	sext.w	a5,a5
    80008c66:	1782                	slli	a5,a5,0x20
    80008c68:	9381                	srli	a5,a5,0x20
    80008c6a:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    80008c6e:	fe043783          	ld	a5,-32(s0)
    80008c72:	fdf7f793          	andi	a5,a5,-33
    80008c76:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    80008c7a:	fe043783          	ld	a5,-32(s0)
    80008c7e:	f7f7f793          	andi	a5,a5,-129
    80008c82:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80008c86:	fe043703          	ld	a4,-32(s0)
    80008c8a:	77fd                	lui	a5,0xfffff
    80008c8c:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ffda8cf>
    80008c90:	8ff9                	and	a5,a5,a4
    80008c92:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    80008c96:	fe043703          	ld	a4,-32(s0)
    80008c9a:	77fd                	lui	a5,0xfffff
    80008c9c:	17fd                	addi	a5,a5,-1
    80008c9e:	8ff9                	and	a5,a5,a4
    80008ca0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    80008ca4:	fe043703          	ld	a4,-32(s0)
    80008ca8:	f80007b7          	lui	a5,0xf8000
    80008cac:	17fd                	addi	a5,a5,-1
    80008cae:	8ff9                	and	a5,a5,a4
    80008cb0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80008cb4:	fe043703          	ld	a4,-32(s0)
    80008cb8:	e00007b7          	lui	a5,0xe0000
    80008cbc:	17fd                	addi	a5,a5,-1
    80008cbe:	8ff9                	and	a5,a5,a4
    80008cc0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80008cc4:	fe043703          	ld	a4,-32(s0)
    80008cc8:	f00007b7          	lui	a5,0xf0000
    80008ccc:	17fd                	addi	a5,a5,-1
    80008cce:	8ff9                	and	a5,a5,a4
    80008cd0:	fef43023          	sd	a5,-32(s0)
  *R(id, VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80008cd4:	fcc42703          	lw	a4,-52(s0)
    80008cd8:	67c1                	lui	a5,0x10
    80008cda:	0785                	addi	a5,a5,1
    80008cdc:	97ba                	add	a5,a5,a4
    80008cde:	07b2                	slli	a5,a5,0xc
    80008ce0:	02078793          	addi	a5,a5,32 # 10020 <_entry-0x7ffeffe0>
    80008ce4:	873e                	mv	a4,a5
    80008ce6:	fe043783          	ld	a5,-32(s0)
    80008cea:	2781                	sext.w	a5,a5
    80008cec:	c31c                	sw	a5,0(a4)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80008cee:	fe842783          	lw	a5,-24(s0)
    80008cf2:	0087e793          	ori	a5,a5,8
    80008cf6:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    80008cfa:	fcc42703          	lw	a4,-52(s0)
    80008cfe:	67c1                	lui	a5,0x10
    80008d00:	0785                	addi	a5,a5,1
    80008d02:	97ba                	add	a5,a5,a4
    80008d04:	07b2                	slli	a5,a5,0xc
    80008d06:	07078793          	addi	a5,a5,112 # 10070 <_entry-0x7ffeff90>
    80008d0a:	873e                	mv	a4,a5
    80008d0c:	fe842783          	lw	a5,-24(s0)
    80008d10:	c31c                	sw	a5,0(a4)

  // re-read status to ensure FEATURES_OK is set.
  status = *R(id, VIRTIO_MMIO_STATUS);
    80008d12:	fcc42703          	lw	a4,-52(s0)
    80008d16:	67c1                	lui	a5,0x10
    80008d18:	0785                	addi	a5,a5,1
    80008d1a:	97ba                	add	a5,a5,a4
    80008d1c:	07b2                	slli	a5,a5,0xc
    80008d1e:	07078793          	addi	a5,a5,112 # 10070 <_entry-0x7ffeff90>
    80008d22:	439c                	lw	a5,0(a5)
    80008d24:	fef42423          	sw	a5,-24(s0)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80008d28:	fe842783          	lw	a5,-24(s0)
    80008d2c:	8ba1                	andi	a5,a5,8
    80008d2e:	2781                	sext.w	a5,a5
    80008d30:	ef81                	bnez	a5,80008d48 <virtio_disk_init+0x236>
      panic_concat(2, name, ": virtio disk FEATURES_OK unset");
    80008d32:	00003617          	auipc	a2,0x3
    80008d36:	95e60613          	addi	a2,a2,-1698 # 8000b690 <etext+0x690>
    80008d3a:	fc043583          	ld	a1,-64(s0)
    80008d3e:	4509                	li	a0,2
    80008d40:	ffff8097          	auipc	ra,0xffff8
    80008d44:	f9e080e7          	jalr	-98(ra) # 80000cde <panic_concat>

  // initialize queue 0.
  *R(id, VIRTIO_MMIO_QUEUE_SEL) = 0;
    80008d48:	fcc42703          	lw	a4,-52(s0)
    80008d4c:	67c1                	lui	a5,0x10
    80008d4e:	0785                	addi	a5,a5,1
    80008d50:	97ba                	add	a5,a5,a4
    80008d52:	07b2                	slli	a5,a5,0xc
    80008d54:	03078793          	addi	a5,a5,48 # 10030 <_entry-0x7ffeffd0>
    80008d58:	0007a023          	sw	zero,0(a5)

  // ensure queue 0 is not in use.
  if(*R(id, VIRTIO_MMIO_QUEUE_READY))
    80008d5c:	fcc42703          	lw	a4,-52(s0)
    80008d60:	67c1                	lui	a5,0x10
    80008d62:	0785                	addi	a5,a5,1
    80008d64:	97ba                	add	a5,a5,a4
    80008d66:	07b2                	slli	a5,a5,0xc
    80008d68:	04478793          	addi	a5,a5,68 # 10044 <_entry-0x7ffeffbc>
    80008d6c:	439c                	lw	a5,0(a5)
    80008d6e:	2781                	sext.w	a5,a5
    80008d70:	cf81                	beqz	a5,80008d88 <virtio_disk_init+0x276>
      panic_concat(2, name, ": virtio disk should not be ready");
    80008d72:	00003617          	auipc	a2,0x3
    80008d76:	93e60613          	addi	a2,a2,-1730 # 8000b6b0 <etext+0x6b0>
    80008d7a:	fc043583          	ld	a1,-64(s0)
    80008d7e:	4509                	li	a0,2
    80008d80:	ffff8097          	auipc	ra,0xffff8
    80008d84:	f5e080e7          	jalr	-162(ra) # 80000cde <panic_concat>

  // check maximum queue size.
  uint32 max = *R(id, VIRTIO_MMIO_QUEUE_NUM_MAX);
    80008d88:	fcc42703          	lw	a4,-52(s0)
    80008d8c:	67c1                	lui	a5,0x10
    80008d8e:	0785                	addi	a5,a5,1
    80008d90:	97ba                	add	a5,a5,a4
    80008d92:	07b2                	slli	a5,a5,0xc
    80008d94:	03478793          	addi	a5,a5,52 # 10034 <_entry-0x7ffeffcc>
    80008d98:	439c                	lw	a5,0(a5)
    80008d9a:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    80008d9e:	fdc42783          	lw	a5,-36(s0)
    80008da2:	2781                	sext.w	a5,a5
    80008da4:	ef81                	bnez	a5,80008dbc <virtio_disk_init+0x2aa>
      panic_concat(2, name, ": virtio disk has no queue 0");
    80008da6:	00003617          	auipc	a2,0x3
    80008daa:	93260613          	addi	a2,a2,-1742 # 8000b6d8 <etext+0x6d8>
    80008dae:	fc043583          	ld	a1,-64(s0)
    80008db2:	4509                	li	a0,2
    80008db4:	ffff8097          	auipc	ra,0xffff8
    80008db8:	f2a080e7          	jalr	-214(ra) # 80000cde <panic_concat>
  if(max < NUM)
    80008dbc:	fdc42783          	lw	a5,-36(s0)
    80008dc0:	0007871b          	sext.w	a4,a5
    80008dc4:	479d                	li	a5,7
    80008dc6:	00e7ed63          	bltu	a5,a4,80008de0 <virtio_disk_init+0x2ce>
      panic_concat(2, name, ": virtio disk max queue too short");
    80008dca:	00003617          	auipc	a2,0x3
    80008dce:	92e60613          	addi	a2,a2,-1746 # 8000b6f8 <etext+0x6f8>
    80008dd2:	fc043583          	ld	a1,-64(s0)
    80008dd6:	4509                	li	a0,2
    80008dd8:	ffff8097          	auipc	ra,0xffff8
    80008ddc:	f06080e7          	jalr	-250(ra) # 80000cde <panic_concat>

  // allocate and zero queue memory.
  disk[id].desc = kalloc();
    80008de0:	ffff8097          	auipc	ra,0xffff8
    80008de4:	3f6080e7          	jalr	1014(ra) # 800011d6 <kalloc>
    80008de8:	862a                	mv	a2,a0
    80008dea:	0001c717          	auipc	a4,0x1c
    80008dee:	e9e70713          	addi	a4,a4,-354 # 80024c88 <disk>
    80008df2:	fcc42683          	lw	a3,-52(s0)
    80008df6:	15000793          	li	a5,336
    80008dfa:	02f687b3          	mul	a5,a3,a5
    80008dfe:	97ba                	add	a5,a5,a4
    80008e00:	e790                	sd	a2,8(a5)
  disk[id].avail = kalloc();
    80008e02:	ffff8097          	auipc	ra,0xffff8
    80008e06:	3d4080e7          	jalr	980(ra) # 800011d6 <kalloc>
    80008e0a:	862a                	mv	a2,a0
    80008e0c:	0001c717          	auipc	a4,0x1c
    80008e10:	e7c70713          	addi	a4,a4,-388 # 80024c88 <disk>
    80008e14:	fcc42683          	lw	a3,-52(s0)
    80008e18:	15000793          	li	a5,336
    80008e1c:	02f687b3          	mul	a5,a3,a5
    80008e20:	97ba                	add	a5,a5,a4
    80008e22:	eb90                	sd	a2,16(a5)
  disk[id].used = kalloc();
    80008e24:	ffff8097          	auipc	ra,0xffff8
    80008e28:	3b2080e7          	jalr	946(ra) # 800011d6 <kalloc>
    80008e2c:	862a                	mv	a2,a0
    80008e2e:	0001c717          	auipc	a4,0x1c
    80008e32:	e5a70713          	addi	a4,a4,-422 # 80024c88 <disk>
    80008e36:	fcc42683          	lw	a3,-52(s0)
    80008e3a:	15000793          	li	a5,336
    80008e3e:	02f687b3          	mul	a5,a3,a5
    80008e42:	97ba                	add	a5,a5,a4
    80008e44:	ef90                	sd	a2,24(a5)
  if(!disk[id].desc || !disk[id].avail || !disk[id].used)
    80008e46:	0001c717          	auipc	a4,0x1c
    80008e4a:	e4270713          	addi	a4,a4,-446 # 80024c88 <disk>
    80008e4e:	fcc42683          	lw	a3,-52(s0)
    80008e52:	15000793          	li	a5,336
    80008e56:	02f687b3          	mul	a5,a3,a5
    80008e5a:	97ba                	add	a5,a5,a4
    80008e5c:	679c                	ld	a5,8(a5)
    80008e5e:	cb9d                	beqz	a5,80008e94 <virtio_disk_init+0x382>
    80008e60:	0001c717          	auipc	a4,0x1c
    80008e64:	e2870713          	addi	a4,a4,-472 # 80024c88 <disk>
    80008e68:	fcc42683          	lw	a3,-52(s0)
    80008e6c:	15000793          	li	a5,336
    80008e70:	02f687b3          	mul	a5,a3,a5
    80008e74:	97ba                	add	a5,a5,a4
    80008e76:	6b9c                	ld	a5,16(a5)
    80008e78:	cf91                	beqz	a5,80008e94 <virtio_disk_init+0x382>
    80008e7a:	0001c717          	auipc	a4,0x1c
    80008e7e:	e0e70713          	addi	a4,a4,-498 # 80024c88 <disk>
    80008e82:	fcc42683          	lw	a3,-52(s0)
    80008e86:	15000793          	li	a5,336
    80008e8a:	02f687b3          	mul	a5,a3,a5
    80008e8e:	97ba                	add	a5,a5,a4
    80008e90:	6f9c                	ld	a5,24(a5)
    80008e92:	ef81                	bnez	a5,80008eaa <virtio_disk_init+0x398>
      panic_concat(2, name, ": virtio disk kalloc");
    80008e94:	00003617          	auipc	a2,0x3
    80008e98:	88c60613          	addi	a2,a2,-1908 # 8000b720 <etext+0x720>
    80008e9c:	fc043583          	ld	a1,-64(s0)
    80008ea0:	4509                	li	a0,2
    80008ea2:	ffff8097          	auipc	ra,0xffff8
    80008ea6:	e3c080e7          	jalr	-452(ra) # 80000cde <panic_concat>
  memset(disk[id].desc, 0, PGSIZE);
    80008eaa:	0001c717          	auipc	a4,0x1c
    80008eae:	dde70713          	addi	a4,a4,-546 # 80024c88 <disk>
    80008eb2:	fcc42683          	lw	a3,-52(s0)
    80008eb6:	15000793          	li	a5,336
    80008eba:	02f687b3          	mul	a5,a3,a5
    80008ebe:	97ba                	add	a5,a5,a4
    80008ec0:	679c                	ld	a5,8(a5)
    80008ec2:	6605                	lui	a2,0x1
    80008ec4:	4581                	li	a1,0
    80008ec6:	853e                	mv	a0,a5
    80008ec8:	ffff8097          	auipc	ra,0xffff8
    80008ecc:	636080e7          	jalr	1590(ra) # 800014fe <memset>
  memset(disk[id].avail, 0, PGSIZE);
    80008ed0:	0001c717          	auipc	a4,0x1c
    80008ed4:	db870713          	addi	a4,a4,-584 # 80024c88 <disk>
    80008ed8:	fcc42683          	lw	a3,-52(s0)
    80008edc:	15000793          	li	a5,336
    80008ee0:	02f687b3          	mul	a5,a3,a5
    80008ee4:	97ba                	add	a5,a5,a4
    80008ee6:	6b9c                	ld	a5,16(a5)
    80008ee8:	6605                	lui	a2,0x1
    80008eea:	4581                	li	a1,0
    80008eec:	853e                	mv	a0,a5
    80008eee:	ffff8097          	auipc	ra,0xffff8
    80008ef2:	610080e7          	jalr	1552(ra) # 800014fe <memset>
  memset(disk[id].used, 0, PGSIZE);
    80008ef6:	0001c717          	auipc	a4,0x1c
    80008efa:	d9270713          	addi	a4,a4,-622 # 80024c88 <disk>
    80008efe:	fcc42683          	lw	a3,-52(s0)
    80008f02:	15000793          	li	a5,336
    80008f06:	02f687b3          	mul	a5,a3,a5
    80008f0a:	97ba                	add	a5,a5,a4
    80008f0c:	6f9c                	ld	a5,24(a5)
    80008f0e:	6605                	lui	a2,0x1
    80008f10:	4581                	li	a1,0
    80008f12:	853e                	mv	a0,a5
    80008f14:	ffff8097          	auipc	ra,0xffff8
    80008f18:	5ea080e7          	jalr	1514(ra) # 800014fe <memset>

  // set queue size.
  *R(id, VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80008f1c:	fcc42703          	lw	a4,-52(s0)
    80008f20:	67c1                	lui	a5,0x10
    80008f22:	0785                	addi	a5,a5,1
    80008f24:	97ba                	add	a5,a5,a4
    80008f26:	07b2                	slli	a5,a5,0xc
    80008f28:	03878793          	addi	a5,a5,56 # 10038 <_entry-0x7ffeffc8>
    80008f2c:	873e                	mv	a4,a5
    80008f2e:	47a1                	li	a5,8
    80008f30:	c31c                	sw	a5,0(a4)

  // write physical addresses.
  *R(id, VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk[id].desc;
    80008f32:	0001c717          	auipc	a4,0x1c
    80008f36:	d5670713          	addi	a4,a4,-682 # 80024c88 <disk>
    80008f3a:	fcc42683          	lw	a3,-52(s0)
    80008f3e:	15000793          	li	a5,336
    80008f42:	02f687b3          	mul	a5,a3,a5
    80008f46:	97ba                	add	a5,a5,a4
    80008f48:	679c                	ld	a5,8(a5)
    80008f4a:	86be                	mv	a3,a5
    80008f4c:	fcc42703          	lw	a4,-52(s0)
    80008f50:	67c1                	lui	a5,0x10
    80008f52:	0785                	addi	a5,a5,1
    80008f54:	97ba                	add	a5,a5,a4
    80008f56:	07b2                	slli	a5,a5,0xc
    80008f58:	08078793          	addi	a5,a5,128 # 10080 <_entry-0x7ffeff80>
    80008f5c:	873e                	mv	a4,a5
    80008f5e:	0006879b          	sext.w	a5,a3
    80008f62:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk[id].desc >> 32;
    80008f64:	0001c717          	auipc	a4,0x1c
    80008f68:	d2470713          	addi	a4,a4,-732 # 80024c88 <disk>
    80008f6c:	fcc42683          	lw	a3,-52(s0)
    80008f70:	15000793          	li	a5,336
    80008f74:	02f687b3          	mul	a5,a3,a5
    80008f78:	97ba                	add	a5,a5,a4
    80008f7a:	679c                	ld	a5,8(a5)
    80008f7c:	0207d693          	srli	a3,a5,0x20
    80008f80:	fcc42703          	lw	a4,-52(s0)
    80008f84:	67c1                	lui	a5,0x10
    80008f86:	0785                	addi	a5,a5,1
    80008f88:	97ba                	add	a5,a5,a4
    80008f8a:	07b2                	slli	a5,a5,0xc
    80008f8c:	08478793          	addi	a5,a5,132 # 10084 <_entry-0x7ffeff7c>
    80008f90:	873e                	mv	a4,a5
    80008f92:	0006879b          	sext.w	a5,a3
    80008f96:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk[id].avail;
    80008f98:	0001c717          	auipc	a4,0x1c
    80008f9c:	cf070713          	addi	a4,a4,-784 # 80024c88 <disk>
    80008fa0:	fcc42683          	lw	a3,-52(s0)
    80008fa4:	15000793          	li	a5,336
    80008fa8:	02f687b3          	mul	a5,a3,a5
    80008fac:	97ba                	add	a5,a5,a4
    80008fae:	6b9c                	ld	a5,16(a5)
    80008fb0:	86be                	mv	a3,a5
    80008fb2:	fcc42703          	lw	a4,-52(s0)
    80008fb6:	67c1                	lui	a5,0x10
    80008fb8:	0785                	addi	a5,a5,1
    80008fba:	97ba                	add	a5,a5,a4
    80008fbc:	07b2                	slli	a5,a5,0xc
    80008fbe:	09078793          	addi	a5,a5,144 # 10090 <_entry-0x7ffeff70>
    80008fc2:	873e                	mv	a4,a5
    80008fc4:	0006879b          	sext.w	a5,a3
    80008fc8:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk[id].avail >> 32;
    80008fca:	0001c717          	auipc	a4,0x1c
    80008fce:	cbe70713          	addi	a4,a4,-834 # 80024c88 <disk>
    80008fd2:	fcc42683          	lw	a3,-52(s0)
    80008fd6:	15000793          	li	a5,336
    80008fda:	02f687b3          	mul	a5,a3,a5
    80008fde:	97ba                	add	a5,a5,a4
    80008fe0:	6b9c                	ld	a5,16(a5)
    80008fe2:	0207d693          	srli	a3,a5,0x20
    80008fe6:	fcc42703          	lw	a4,-52(s0)
    80008fea:	67c1                	lui	a5,0x10
    80008fec:	0785                	addi	a5,a5,1
    80008fee:	97ba                	add	a5,a5,a4
    80008ff0:	07b2                	slli	a5,a5,0xc
    80008ff2:	09478793          	addi	a5,a5,148 # 10094 <_entry-0x7ffeff6c>
    80008ff6:	873e                	mv	a4,a5
    80008ff8:	0006879b          	sext.w	a5,a3
    80008ffc:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk[id].used;
    80008ffe:	0001c717          	auipc	a4,0x1c
    80009002:	c8a70713          	addi	a4,a4,-886 # 80024c88 <disk>
    80009006:	fcc42683          	lw	a3,-52(s0)
    8000900a:	15000793          	li	a5,336
    8000900e:	02f687b3          	mul	a5,a3,a5
    80009012:	97ba                	add	a5,a5,a4
    80009014:	6f9c                	ld	a5,24(a5)
    80009016:	86be                	mv	a3,a5
    80009018:	fcc42703          	lw	a4,-52(s0)
    8000901c:	67c1                	lui	a5,0x10
    8000901e:	0785                	addi	a5,a5,1
    80009020:	97ba                	add	a5,a5,a4
    80009022:	07b2                	slli	a5,a5,0xc
    80009024:	0a078793          	addi	a5,a5,160 # 100a0 <_entry-0x7ffeff60>
    80009028:	873e                	mv	a4,a5
    8000902a:	0006879b          	sext.w	a5,a3
    8000902e:	c31c                	sw	a5,0(a4)
  *R(id, VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk[id].used >> 32;
    80009030:	0001c717          	auipc	a4,0x1c
    80009034:	c5870713          	addi	a4,a4,-936 # 80024c88 <disk>
    80009038:	fcc42683          	lw	a3,-52(s0)
    8000903c:	15000793          	li	a5,336
    80009040:	02f687b3          	mul	a5,a3,a5
    80009044:	97ba                	add	a5,a5,a4
    80009046:	6f9c                	ld	a5,24(a5)
    80009048:	0207d693          	srli	a3,a5,0x20
    8000904c:	fcc42703          	lw	a4,-52(s0)
    80009050:	67c1                	lui	a5,0x10
    80009052:	0785                	addi	a5,a5,1
    80009054:	97ba                	add	a5,a5,a4
    80009056:	07b2                	slli	a5,a5,0xc
    80009058:	0a478793          	addi	a5,a5,164 # 100a4 <_entry-0x7ffeff5c>
    8000905c:	873e                	mv	a4,a5
    8000905e:	0006879b          	sext.w	a5,a3
    80009062:	c31c                	sw	a5,0(a4)

  // queue is ready.
  *R(id, VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80009064:	fcc42703          	lw	a4,-52(s0)
    80009068:	67c1                	lui	a5,0x10
    8000906a:	0785                	addi	a5,a5,1
    8000906c:	97ba                	add	a5,a5,a4
    8000906e:	07b2                	slli	a5,a5,0xc
    80009070:	04478793          	addi	a5,a5,68 # 10044 <_entry-0x7ffeffbc>
    80009074:	873e                	mv	a4,a5
    80009076:	4785                	li	a5,1
    80009078:	c31c                	sw	a5,0(a4)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    8000907a:	fe042623          	sw	zero,-20(s0)
    8000907e:	a03d                	j	800090ac <virtio_disk_init+0x59a>
    disk[id].free[i] = 1;
    80009080:	0001c697          	auipc	a3,0x1c
    80009084:	c0868693          	addi	a3,a3,-1016 # 80024c88 <disk>
    80009088:	fec42703          	lw	a4,-20(s0)
    8000908c:	fcc42603          	lw	a2,-52(s0)
    80009090:	15000793          	li	a5,336
    80009094:	02f607b3          	mul	a5,a2,a5
    80009098:	97b6                	add	a5,a5,a3
    8000909a:	97ba                	add	a5,a5,a4
    8000909c:	4705                	li	a4,1
    8000909e:	02e78023          	sb	a4,32(a5)
  for(int i = 0; i < NUM; i++)
    800090a2:	fec42783          	lw	a5,-20(s0)
    800090a6:	2785                	addiw	a5,a5,1
    800090a8:	fef42623          	sw	a5,-20(s0)
    800090ac:	fec42783          	lw	a5,-20(s0)
    800090b0:	0007871b          	sext.w	a4,a5
    800090b4:	479d                	li	a5,7
    800090b6:	fce7d5e3          	bge	a5,a4,80009080 <virtio_disk_init+0x56e>

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    800090ba:	fe842783          	lw	a5,-24(s0)
    800090be:	0047e793          	ori	a5,a5,4
    800090c2:	fef42423          	sw	a5,-24(s0)
  *R(id, VIRTIO_MMIO_STATUS) = status;
    800090c6:	fcc42703          	lw	a4,-52(s0)
    800090ca:	67c1                	lui	a5,0x10
    800090cc:	0785                	addi	a5,a5,1
    800090ce:	97ba                	add	a5,a5,a4
    800090d0:	07b2                	slli	a5,a5,0xc
    800090d2:	07078793          	addi	a5,a5,112 # 10070 <_entry-0x7ffeff90>
    800090d6:	873e                	mv	a4,a5
    800090d8:	fe842783          	lw	a5,-24(s0)
    800090dc:	c31c                	sw	a5,0(a4)

  if (id == VIRTIO1_ID) {
    800090de:	fcc42783          	lw	a5,-52(s0)
    800090e2:	0007871b          	sext.w	a4,a5
    800090e6:	4785                	li	a5,1
    800090e8:	06f71663          	bne	a4,a5,80009154 <virtio_disk_init+0x642>
    swap_buffer = kalloc();
    800090ec:	ffff8097          	auipc	ra,0xffff8
    800090f0:	0ea080e7          	jalr	234(ra) # 800011d6 <kalloc>
    800090f4:	872a                	mv	a4,a0
    800090f6:	0001c797          	auipc	a5,0x1c
    800090fa:	e3278793          	addi	a5,a5,-462 # 80024f28 <swap_buffer>
    800090fe:	e398                	sd	a4,0(a5)
    if (!swap_buffer) {
    80009100:	0001c797          	auipc	a5,0x1c
    80009104:	e2878793          	addi	a5,a5,-472 # 80024f28 <swap_buffer>
    80009108:	639c                	ld	a5,0(a5)
    8000910a:	eb89                	bnez	a5,8000911c <virtio_disk_init+0x60a>
      panic("virtio_disk_init: kalloc of swap_buffer failed");
    8000910c:	00002517          	auipc	a0,0x2
    80009110:	62c50513          	addi	a0,a0,1580 # 8000b738 <etext+0x738>
    80009114:	ffff8097          	auipc	ra,0xffff8
    80009118:	b78080e7          	jalr	-1160(ra) # 80000c8c <panic>
    }
    memset(swap_buffer, 0, BSIZE);
    8000911c:	0001c797          	auipc	a5,0x1c
    80009120:	e0c78793          	addi	a5,a5,-500 # 80024f28 <swap_buffer>
    80009124:	639c                	ld	a5,0(a5)
    80009126:	40000613          	li	a2,1024
    8000912a:	4581                	li	a1,0
    8000912c:	853e                	mv	a0,a5
    8000912e:	ffff8097          	auipc	ra,0xffff8
    80009132:	3d0080e7          	jalr	976(ra) # 800014fe <memset>
    initsleeplock(&swap_buffer->lock, "swap_buffer");
    80009136:	0001c797          	auipc	a5,0x1c
    8000913a:	df278793          	addi	a5,a5,-526 # 80024f28 <swap_buffer>
    8000913e:	639c                	ld	a5,0(a5)
    80009140:	07c1                	addi	a5,a5,16
    80009142:	00002597          	auipc	a1,0x2
    80009146:	62658593          	addi	a1,a1,1574 # 8000b768 <etext+0x768>
    8000914a:	853e                	mv	a0,a5
    8000914c:	ffffd097          	auipc	ra,0xffffd
    80009150:	4ae080e7          	jalr	1198(ra) # 800065fa <initsleeplock>
  }

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ and VIRTIO1_IRQ.
}
    80009154:	0001                	nop
    80009156:	70e2                	ld	ra,56(sp)
    80009158:	7442                	ld	s0,48(sp)
    8000915a:	6121                	addi	sp,sp,64
    8000915c:	8082                	ret

000000008000915e <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc(int id)
{
    8000915e:	7179                	addi	sp,sp,-48
    80009160:	f422                	sd	s0,40(sp)
    80009162:	1800                	addi	s0,sp,48
    80009164:	87aa                	mv	a5,a0
    80009166:	fcf42e23          	sw	a5,-36(s0)
  for(int i = 0; i < NUM; i++){
    8000916a:	fe042623          	sw	zero,-20(s0)
    8000916e:	a891                	j	800091c2 <alloc_desc+0x64>
    if(disk[id].free[i]){
    80009170:	0001c697          	auipc	a3,0x1c
    80009174:	b1868693          	addi	a3,a3,-1256 # 80024c88 <disk>
    80009178:	fec42703          	lw	a4,-20(s0)
    8000917c:	fdc42603          	lw	a2,-36(s0)
    80009180:	15000793          	li	a5,336
    80009184:	02f607b3          	mul	a5,a2,a5
    80009188:	97b6                	add	a5,a5,a3
    8000918a:	97ba                	add	a5,a5,a4
    8000918c:	0207c783          	lbu	a5,32(a5)
    80009190:	c785                	beqz	a5,800091b8 <alloc_desc+0x5a>
      disk[id].free[i] = 0;
    80009192:	0001c697          	auipc	a3,0x1c
    80009196:	af668693          	addi	a3,a3,-1290 # 80024c88 <disk>
    8000919a:	fec42703          	lw	a4,-20(s0)
    8000919e:	fdc42603          	lw	a2,-36(s0)
    800091a2:	15000793          	li	a5,336
    800091a6:	02f607b3          	mul	a5,a2,a5
    800091aa:	97b6                	add	a5,a5,a3
    800091ac:	97ba                	add	a5,a5,a4
    800091ae:	02078023          	sb	zero,32(a5)
      return i;
    800091b2:	fec42783          	lw	a5,-20(s0)
    800091b6:	a831                	j	800091d2 <alloc_desc+0x74>
  for(int i = 0; i < NUM; i++){
    800091b8:	fec42783          	lw	a5,-20(s0)
    800091bc:	2785                	addiw	a5,a5,1
    800091be:	fef42623          	sw	a5,-20(s0)
    800091c2:	fec42783          	lw	a5,-20(s0)
    800091c6:	0007871b          	sext.w	a4,a5
    800091ca:	479d                	li	a5,7
    800091cc:	fae7d2e3          	bge	a5,a4,80009170 <alloc_desc+0x12>
    }
  }
  return -1;
    800091d0:	57fd                	li	a5,-1
}
    800091d2:	853e                	mv	a0,a5
    800091d4:	7422                	ld	s0,40(sp)
    800091d6:	6145                	addi	sp,sp,48
    800091d8:	8082                	ret

00000000800091da <free_desc>:

// mark a descriptor as free.
static void
free_desc(int id, int i)
{
    800091da:	1101                	addi	sp,sp,-32
    800091dc:	ec06                	sd	ra,24(sp)
    800091de:	e822                	sd	s0,16(sp)
    800091e0:	1000                	addi	s0,sp,32
    800091e2:	87aa                	mv	a5,a0
    800091e4:	872e                	mv	a4,a1
    800091e6:	fef42623          	sw	a5,-20(s0)
    800091ea:	87ba                	mv	a5,a4
    800091ec:	fef42423          	sw	a5,-24(s0)
  if(i >= NUM)
    800091f0:	fe842783          	lw	a5,-24(s0)
    800091f4:	0007871b          	sext.w	a4,a5
    800091f8:	479d                	li	a5,7
    800091fa:	02e7d863          	bge	a5,a4,8000922a <free_desc+0x50>
    panic_concat(2, disk[id].name, ": free_desc 1");
    800091fe:	0001c717          	auipc	a4,0x1c
    80009202:	a8a70713          	addi	a4,a4,-1398 # 80024c88 <disk>
    80009206:	fec42683          	lw	a3,-20(s0)
    8000920a:	15000793          	li	a5,336
    8000920e:	02f687b3          	mul	a5,a3,a5
    80009212:	97ba                	add	a5,a5,a4
    80009214:	639c                	ld	a5,0(a5)
    80009216:	00002617          	auipc	a2,0x2
    8000921a:	56260613          	addi	a2,a2,1378 # 8000b778 <etext+0x778>
    8000921e:	85be                	mv	a1,a5
    80009220:	4509                	li	a0,2
    80009222:	ffff8097          	auipc	ra,0xffff8
    80009226:	abc080e7          	jalr	-1348(ra) # 80000cde <panic_concat>
  if(disk[id].free[i])
    8000922a:	0001c697          	auipc	a3,0x1c
    8000922e:	a5e68693          	addi	a3,a3,-1442 # 80024c88 <disk>
    80009232:	fe842703          	lw	a4,-24(s0)
    80009236:	fec42603          	lw	a2,-20(s0)
    8000923a:	15000793          	li	a5,336
    8000923e:	02f607b3          	mul	a5,a2,a5
    80009242:	97b6                	add	a5,a5,a3
    80009244:	97ba                	add	a5,a5,a4
    80009246:	0207c783          	lbu	a5,32(a5)
    8000924a:	c79d                	beqz	a5,80009278 <free_desc+0x9e>
      panic_concat(2, disk[id].name, ": free_desc 2");
    8000924c:	0001c717          	auipc	a4,0x1c
    80009250:	a3c70713          	addi	a4,a4,-1476 # 80024c88 <disk>
    80009254:	fec42683          	lw	a3,-20(s0)
    80009258:	15000793          	li	a5,336
    8000925c:	02f687b3          	mul	a5,a3,a5
    80009260:	97ba                	add	a5,a5,a4
    80009262:	639c                	ld	a5,0(a5)
    80009264:	00002617          	auipc	a2,0x2
    80009268:	52460613          	addi	a2,a2,1316 # 8000b788 <etext+0x788>
    8000926c:	85be                	mv	a1,a5
    8000926e:	4509                	li	a0,2
    80009270:	ffff8097          	auipc	ra,0xffff8
    80009274:	a6e080e7          	jalr	-1426(ra) # 80000cde <panic_concat>
  disk[id].desc[i].addr = 0;
    80009278:	0001c717          	auipc	a4,0x1c
    8000927c:	a1070713          	addi	a4,a4,-1520 # 80024c88 <disk>
    80009280:	fec42683          	lw	a3,-20(s0)
    80009284:	15000793          	li	a5,336
    80009288:	02f687b3          	mul	a5,a3,a5
    8000928c:	97ba                	add	a5,a5,a4
    8000928e:	6798                	ld	a4,8(a5)
    80009290:	fe842783          	lw	a5,-24(s0)
    80009294:	0792                	slli	a5,a5,0x4
    80009296:	97ba                	add	a5,a5,a4
    80009298:	0007b023          	sd	zero,0(a5)
  disk[id].desc[i].len = 0;
    8000929c:	0001c717          	auipc	a4,0x1c
    800092a0:	9ec70713          	addi	a4,a4,-1556 # 80024c88 <disk>
    800092a4:	fec42683          	lw	a3,-20(s0)
    800092a8:	15000793          	li	a5,336
    800092ac:	02f687b3          	mul	a5,a3,a5
    800092b0:	97ba                	add	a5,a5,a4
    800092b2:	6798                	ld	a4,8(a5)
    800092b4:	fe842783          	lw	a5,-24(s0)
    800092b8:	0792                	slli	a5,a5,0x4
    800092ba:	97ba                	add	a5,a5,a4
    800092bc:	0007a423          	sw	zero,8(a5)
  disk[id].desc[i].flags = 0;
    800092c0:	0001c717          	auipc	a4,0x1c
    800092c4:	9c870713          	addi	a4,a4,-1592 # 80024c88 <disk>
    800092c8:	fec42683          	lw	a3,-20(s0)
    800092cc:	15000793          	li	a5,336
    800092d0:	02f687b3          	mul	a5,a3,a5
    800092d4:	97ba                	add	a5,a5,a4
    800092d6:	6798                	ld	a4,8(a5)
    800092d8:	fe842783          	lw	a5,-24(s0)
    800092dc:	0792                	slli	a5,a5,0x4
    800092de:	97ba                	add	a5,a5,a4
    800092e0:	00079623          	sh	zero,12(a5)
  disk[id].desc[i].next = 0;
    800092e4:	0001c717          	auipc	a4,0x1c
    800092e8:	9a470713          	addi	a4,a4,-1628 # 80024c88 <disk>
    800092ec:	fec42683          	lw	a3,-20(s0)
    800092f0:	15000793          	li	a5,336
    800092f4:	02f687b3          	mul	a5,a3,a5
    800092f8:	97ba                	add	a5,a5,a4
    800092fa:	6798                	ld	a4,8(a5)
    800092fc:	fe842783          	lw	a5,-24(s0)
    80009300:	0792                	slli	a5,a5,0x4
    80009302:	97ba                	add	a5,a5,a4
    80009304:	00079723          	sh	zero,14(a5)
  disk[id].free[i] = 1;
    80009308:	0001c697          	auipc	a3,0x1c
    8000930c:	98068693          	addi	a3,a3,-1664 # 80024c88 <disk>
    80009310:	fe842703          	lw	a4,-24(s0)
    80009314:	fec42603          	lw	a2,-20(s0)
    80009318:	15000793          	li	a5,336
    8000931c:	02f607b3          	mul	a5,a2,a5
    80009320:	97b6                	add	a5,a5,a3
    80009322:	97ba                	add	a5,a5,a4
    80009324:	4705                	li	a4,1
    80009326:	02e78023          	sb	a4,32(a5)
  if (!disk[id].bw_transfer) {
    8000932a:	0001c717          	auipc	a4,0x1c
    8000932e:	95e70713          	addi	a4,a4,-1698 # 80024c88 <disk>
    80009332:	fec42683          	lw	a3,-20(s0)
    80009336:	15000793          	li	a5,336
    8000933a:	02f687b3          	mul	a5,a3,a5
    8000933e:	97ba                	add	a5,a5,a4
    80009340:	1487a783          	lw	a5,328(a5)
    80009344:	e39d                	bnez	a5,8000936a <free_desc+0x190>
      wakeup(&disk[id].free[0]);
    80009346:	fec42703          	lw	a4,-20(s0)
    8000934a:	15000793          	li	a5,336
    8000934e:	02f707b3          	mul	a5,a4,a5
    80009352:	02078713          	addi	a4,a5,32
    80009356:	0001c797          	auipc	a5,0x1c
    8000935a:	93278793          	addi	a5,a5,-1742 # 80024c88 <disk>
    8000935e:	97ba                	add	a5,a5,a4
    80009360:	853e                	mv	a0,a5
    80009362:	ffffa097          	auipc	ra,0xffffa
    80009366:	1f4080e7          	jalr	500(ra) # 80003556 <wakeup>
  }
}
    8000936a:	0001                	nop
    8000936c:	60e2                	ld	ra,24(sp)
    8000936e:	6442                	ld	s0,16(sp)
    80009370:	6105                	addi	sp,sp,32
    80009372:	8082                	ret

0000000080009374 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int id, int i)
{
    80009374:	7179                	addi	sp,sp,-48
    80009376:	f406                	sd	ra,40(sp)
    80009378:	f022                	sd	s0,32(sp)
    8000937a:	1800                	addi	s0,sp,48
    8000937c:	87aa                	mv	a5,a0
    8000937e:	872e                	mv	a4,a1
    80009380:	fcf42e23          	sw	a5,-36(s0)
    80009384:	87ba                	mv	a5,a4
    80009386:	fcf42c23          	sw	a5,-40(s0)
  while(1){
    int flag = disk[id].desc[i].flags;
    8000938a:	0001c717          	auipc	a4,0x1c
    8000938e:	8fe70713          	addi	a4,a4,-1794 # 80024c88 <disk>
    80009392:	fdc42683          	lw	a3,-36(s0)
    80009396:	15000793          	li	a5,336
    8000939a:	02f687b3          	mul	a5,a3,a5
    8000939e:	97ba                	add	a5,a5,a4
    800093a0:	6798                	ld	a4,8(a5)
    800093a2:	fd842783          	lw	a5,-40(s0)
    800093a6:	0792                	slli	a5,a5,0x4
    800093a8:	97ba                	add	a5,a5,a4
    800093aa:	00c7d783          	lhu	a5,12(a5)
    800093ae:	fef42623          	sw	a5,-20(s0)
    int nxt = disk[id].desc[i].next;
    800093b2:	0001c717          	auipc	a4,0x1c
    800093b6:	8d670713          	addi	a4,a4,-1834 # 80024c88 <disk>
    800093ba:	fdc42683          	lw	a3,-36(s0)
    800093be:	15000793          	li	a5,336
    800093c2:	02f687b3          	mul	a5,a3,a5
    800093c6:	97ba                	add	a5,a5,a4
    800093c8:	6798                	ld	a4,8(a5)
    800093ca:	fd842783          	lw	a5,-40(s0)
    800093ce:	0792                	slli	a5,a5,0x4
    800093d0:	97ba                	add	a5,a5,a4
    800093d2:	00e7d783          	lhu	a5,14(a5)
    800093d6:	fef42423          	sw	a5,-24(s0)
    free_desc(id, i);
    800093da:	fd842703          	lw	a4,-40(s0)
    800093de:	fdc42783          	lw	a5,-36(s0)
    800093e2:	85ba                	mv	a1,a4
    800093e4:	853e                	mv	a0,a5
    800093e6:	00000097          	auipc	ra,0x0
    800093ea:	df4080e7          	jalr	-524(ra) # 800091da <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800093ee:	fec42783          	lw	a5,-20(s0)
    800093f2:	8b85                	andi	a5,a5,1
    800093f4:	2781                	sext.w	a5,a5
    800093f6:	c791                	beqz	a5,80009402 <free_chain+0x8e>
      i = nxt;
    800093f8:	fe842783          	lw	a5,-24(s0)
    800093fc:	fcf42c23          	sw	a5,-40(s0)
  while(1){
    80009400:	b769                	j	8000938a <free_chain+0x16>
    else
      break;
    80009402:	0001                	nop
  }
}
    80009404:	0001                	nop
    80009406:	70a2                	ld	ra,40(sp)
    80009408:	7402                	ld	s0,32(sp)
    8000940a:	6145                	addi	sp,sp,48
    8000940c:	8082                	ret

000000008000940e <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int id, int *idx)
{
    8000940e:	7139                	addi	sp,sp,-64
    80009410:	fc06                	sd	ra,56(sp)
    80009412:	f822                	sd	s0,48(sp)
    80009414:	f426                	sd	s1,40(sp)
    80009416:	0080                	addi	s0,sp,64
    80009418:	87aa                	mv	a5,a0
    8000941a:	fcb43023          	sd	a1,-64(s0)
    8000941e:	fcf42623          	sw	a5,-52(s0)
  for(int i = 0; i < 3; i++){
    80009422:	fc042e23          	sw	zero,-36(s0)
    80009426:	a041                	j	800094a6 <alloc3_desc+0x98>
    idx[i] = alloc_desc(id);
    80009428:	fdc42783          	lw	a5,-36(s0)
    8000942c:	078a                	slli	a5,a5,0x2
    8000942e:	fc043703          	ld	a4,-64(s0)
    80009432:	00f704b3          	add	s1,a4,a5
    80009436:	fcc42783          	lw	a5,-52(s0)
    8000943a:	853e                	mv	a0,a5
    8000943c:	00000097          	auipc	ra,0x0
    80009440:	d22080e7          	jalr	-734(ra) # 8000915e <alloc_desc>
    80009444:	87aa                	mv	a5,a0
    80009446:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80009448:	fdc42783          	lw	a5,-36(s0)
    8000944c:	078a                	slli	a5,a5,0x2
    8000944e:	fc043703          	ld	a4,-64(s0)
    80009452:	97ba                	add	a5,a5,a4
    80009454:	439c                	lw	a5,0(a5)
    80009456:	0407d363          	bgez	a5,8000949c <alloc3_desc+0x8e>
      for(int j = 0; j < i; j++)
    8000945a:	fc042c23          	sw	zero,-40(s0)
    8000945e:	a02d                	j	80009488 <alloc3_desc+0x7a>
        free_desc(id, idx[j]);
    80009460:	fd842783          	lw	a5,-40(s0)
    80009464:	078a                	slli	a5,a5,0x2
    80009466:	fc043703          	ld	a4,-64(s0)
    8000946a:	97ba                	add	a5,a5,a4
    8000946c:	4398                	lw	a4,0(a5)
    8000946e:	fcc42783          	lw	a5,-52(s0)
    80009472:	85ba                	mv	a1,a4
    80009474:	853e                	mv	a0,a5
    80009476:	00000097          	auipc	ra,0x0
    8000947a:	d64080e7          	jalr	-668(ra) # 800091da <free_desc>
      for(int j = 0; j < i; j++)
    8000947e:	fd842783          	lw	a5,-40(s0)
    80009482:	2785                	addiw	a5,a5,1
    80009484:	fcf42c23          	sw	a5,-40(s0)
    80009488:	fd842703          	lw	a4,-40(s0)
    8000948c:	fdc42783          	lw	a5,-36(s0)
    80009490:	2701                	sext.w	a4,a4
    80009492:	2781                	sext.w	a5,a5
    80009494:	fcf746e3          	blt	a4,a5,80009460 <alloc3_desc+0x52>
      return -1;
    80009498:	57fd                	li	a5,-1
    8000949a:	a831                	j	800094b6 <alloc3_desc+0xa8>
  for(int i = 0; i < 3; i++){
    8000949c:	fdc42783          	lw	a5,-36(s0)
    800094a0:	2785                	addiw	a5,a5,1
    800094a2:	fcf42e23          	sw	a5,-36(s0)
    800094a6:	fdc42783          	lw	a5,-36(s0)
    800094aa:	0007871b          	sext.w	a4,a5
    800094ae:	4789                	li	a5,2
    800094b0:	f6e7dce3          	bge	a5,a4,80009428 <alloc3_desc+0x1a>
    }
  }
  return 0;
    800094b4:	4781                	li	a5,0
}
    800094b6:	853e                	mv	a0,a5
    800094b8:	70e2                	ld	ra,56(sp)
    800094ba:	7442                	ld	s0,48(sp)
    800094bc:	74a2                	ld	s1,40(sp)
    800094be:	6121                	addi	sp,sp,64
    800094c0:	8082                	ret

00000000800094c2 <virtio_disk_rw>:

void
virtio_disk_rw(int id, struct buf *b, int write, int busy_wait)
{
    800094c2:	715d                	addi	sp,sp,-80
    800094c4:	e486                	sd	ra,72(sp)
    800094c6:	e0a2                	sd	s0,64(sp)
    800094c8:	0880                	addi	s0,sp,80
    800094ca:	87aa                	mv	a5,a0
    800094cc:	fcb43023          	sd	a1,-64(s0)
    800094d0:	8736                	mv	a4,a3
    800094d2:	fcf42623          	sw	a5,-52(s0)
    800094d6:	87b2                	mv	a5,a2
    800094d8:	fcf42423          	sw	a5,-56(s0)
    800094dc:	87ba                	mv	a5,a4
    800094de:	faf42e23          	sw	a5,-68(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    800094e2:	fc043783          	ld	a5,-64(s0)
    800094e6:	47dc                	lw	a5,12(a5)
    800094e8:	0017979b          	slliw	a5,a5,0x1
    800094ec:	2781                	sext.w	a5,a5
    800094ee:	1782                	slli	a5,a5,0x20
    800094f0:	9381                	srli	a5,a5,0x20
    800094f2:	fef43423          	sd	a5,-24(s0)

  acquire(&disk[id].vdisk_lock);
    800094f6:	fcc42703          	lw	a4,-52(s0)
    800094fa:	15000793          	li	a5,336
    800094fe:	02f707b3          	mul	a5,a4,a5
    80009502:	13078713          	addi	a4,a5,304
    80009506:	0001b797          	auipc	a5,0x1b
    8000950a:	78278793          	addi	a5,a5,1922 # 80024c88 <disk>
    8000950e:	97ba                	add	a5,a5,a4
    80009510:	853e                	mv	a0,a5
    80009512:	ffff8097          	auipc	ra,0xffff8
    80009516:	e18080e7          	jalr	-488(ra) # 8000132a <acquire>
  disk[id].bw_transfer = busy_wait;
    8000951a:	0001b717          	auipc	a4,0x1b
    8000951e:	76e70713          	addi	a4,a4,1902 # 80024c88 <disk>
    80009522:	fcc42683          	lw	a3,-52(s0)
    80009526:	15000793          	li	a5,336
    8000952a:	02f687b3          	mul	a5,a3,a5
    8000952e:	97ba                	add	a5,a5,a4
    80009530:	fbc42703          	lw	a4,-68(s0)
    80009534:	14e7a423          	sw	a4,328(a5)
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(id, idx) == 0) {
    80009538:	fd040713          	addi	a4,s0,-48
    8000953c:	fcc42783          	lw	a5,-52(s0)
    80009540:	85ba                	mv	a1,a4
    80009542:	853e                	mv	a0,a5
    80009544:	00000097          	auipc	ra,0x0
    80009548:	eca080e7          	jalr	-310(ra) # 8000940e <alloc3_desc>
    8000954c:	87aa                	mv	a5,a0
    8000954e:	c3e9                	beqz	a5,80009610 <virtio_disk_rw+0x14e>
      break;
    }
    if (!busy_wait) {
    80009550:	fbc42783          	lw	a5,-68(s0)
    80009554:	2781                	sext.w	a5,a5
    80009556:	e3b9                	bnez	a5,8000959c <virtio_disk_rw+0xda>
        sleep(&disk[id].free[0], &disk[id].vdisk_lock);
    80009558:	fcc42703          	lw	a4,-52(s0)
    8000955c:	15000793          	li	a5,336
    80009560:	02f707b3          	mul	a5,a4,a5
    80009564:	02078713          	addi	a4,a5,32
    80009568:	0001b797          	auipc	a5,0x1b
    8000956c:	72078793          	addi	a5,a5,1824 # 80024c88 <disk>
    80009570:	00f706b3          	add	a3,a4,a5
    80009574:	fcc42703          	lw	a4,-52(s0)
    80009578:	15000793          	li	a5,336
    8000957c:	02f707b3          	mul	a5,a4,a5
    80009580:	13078713          	addi	a4,a5,304
    80009584:	0001b797          	auipc	a5,0x1b
    80009588:	70478793          	addi	a5,a5,1796 # 80024c88 <disk>
    8000958c:	97ba                	add	a5,a5,a4
    8000958e:	85be                	mv	a1,a5
    80009590:	8536                	mv	a0,a3
    80009592:	ffffa097          	auipc	ra,0xffffa
    80009596:	f48080e7          	jalr	-184(ra) # 800034da <sleep>
    8000959a:	bf79                	j	80009538 <virtio_disk_rw+0x76>
    } else {
        release(&disk[id].vdisk_lock);
    8000959c:	fcc42703          	lw	a4,-52(s0)
    800095a0:	15000793          	li	a5,336
    800095a4:	02f707b3          	mul	a5,a4,a5
    800095a8:	13078713          	addi	a4,a5,304
    800095ac:	0001b797          	auipc	a5,0x1b
    800095b0:	6dc78793          	addi	a5,a5,1756 # 80024c88 <disk>
    800095b4:	97ba                	add	a5,a5,a4
    800095b6:	853e                	mv	a0,a5
    800095b8:	ffff8097          	auipc	ra,0xffff8
    800095bc:	dd6080e7          	jalr	-554(ra) # 8000138e <release>
        intr_on();
    800095c0:	fffff097          	auipc	ra,0xfffff
    800095c4:	500080e7          	jalr	1280(ra) # 80008ac0 <intr_on>
        while(alloc3_desc(id, idx) != 0);
    800095c8:	0001                	nop
    800095ca:	fd040713          	addi	a4,s0,-48
    800095ce:	fcc42783          	lw	a5,-52(s0)
    800095d2:	85ba                	mv	a1,a4
    800095d4:	853e                	mv	a0,a5
    800095d6:	00000097          	auipc	ra,0x0
    800095da:	e38080e7          	jalr	-456(ra) # 8000940e <alloc3_desc>
    800095de:	87aa                	mv	a5,a0
    800095e0:	f7ed                	bnez	a5,800095ca <virtio_disk_rw+0x108>
        intr_off();
    800095e2:	fffff097          	auipc	ra,0xfffff
    800095e6:	508080e7          	jalr	1288(ra) # 80008aea <intr_off>
        acquire(&disk[id].vdisk_lock);
    800095ea:	fcc42703          	lw	a4,-52(s0)
    800095ee:	15000793          	li	a5,336
    800095f2:	02f707b3          	mul	a5,a4,a5
    800095f6:	13078713          	addi	a4,a5,304
    800095fa:	0001b797          	auipc	a5,0x1b
    800095fe:	68e78793          	addi	a5,a5,1678 # 80024c88 <disk>
    80009602:	97ba                	add	a5,a5,a4
    80009604:	853e                	mv	a0,a5
    80009606:	ffff8097          	auipc	ra,0xffff8
    8000960a:	d24080e7          	jalr	-732(ra) # 8000132a <acquire>
    if(alloc3_desc(id, idx) == 0) {
    8000960e:	b72d                	j	80009538 <virtio_disk_rw+0x76>
      break;
    80009610:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk[id].ops[idx[0]];
    80009612:	fd042683          	lw	a3,-48(s0)
    80009616:	fcc42703          	lw	a4,-52(s0)
    8000961a:	87ba                	mv	a5,a4
    8000961c:	078a                	slli	a5,a5,0x2
    8000961e:	97ba                	add	a5,a5,a4
    80009620:	078a                	slli	a5,a5,0x2
    80009622:	97ba                	add	a5,a5,a4
    80009624:	97b6                	add	a5,a5,a3
    80009626:	07ad                	addi	a5,a5,11
    80009628:	00479713          	slli	a4,a5,0x4
    8000962c:	0001b797          	auipc	a5,0x1b
    80009630:	65c78793          	addi	a5,a5,1628 # 80024c88 <disk>
    80009634:	97ba                	add	a5,a5,a4
    80009636:	fef43023          	sd	a5,-32(s0)

  if(write)
    8000963a:	fc842783          	lw	a5,-56(s0)
    8000963e:	2781                	sext.w	a5,a5
    80009640:	c791                	beqz	a5,8000964c <virtio_disk_rw+0x18a>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80009642:	fe043783          	ld	a5,-32(s0)
    80009646:	4705                	li	a4,1
    80009648:	c398                	sw	a4,0(a5)
    8000964a:	a029                	j	80009654 <virtio_disk_rw+0x192>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    8000964c:	fe043783          	ld	a5,-32(s0)
    80009650:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009654:	fe043783          	ld	a5,-32(s0)
    80009658:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    8000965c:	fe043783          	ld	a5,-32(s0)
    80009660:	fe843703          	ld	a4,-24(s0)
    80009664:	e798                	sd	a4,8(a5)

  disk[id].desc[idx[0]].addr = (uint64) buf0;
    80009666:	0001b717          	auipc	a4,0x1b
    8000966a:	62270713          	addi	a4,a4,1570 # 80024c88 <disk>
    8000966e:	fcc42683          	lw	a3,-52(s0)
    80009672:	15000793          	li	a5,336
    80009676:	02f687b3          	mul	a5,a3,a5
    8000967a:	97ba                	add	a5,a5,a4
    8000967c:	6798                	ld	a4,8(a5)
    8000967e:	fd042783          	lw	a5,-48(s0)
    80009682:	0792                	slli	a5,a5,0x4
    80009684:	97ba                	add	a5,a5,a4
    80009686:	fe043703          	ld	a4,-32(s0)
    8000968a:	e398                	sd	a4,0(a5)
  disk[id].desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000968c:	0001b717          	auipc	a4,0x1b
    80009690:	5fc70713          	addi	a4,a4,1532 # 80024c88 <disk>
    80009694:	fcc42683          	lw	a3,-52(s0)
    80009698:	15000793          	li	a5,336
    8000969c:	02f687b3          	mul	a5,a3,a5
    800096a0:	97ba                	add	a5,a5,a4
    800096a2:	6798                	ld	a4,8(a5)
    800096a4:	fd042783          	lw	a5,-48(s0)
    800096a8:	0792                	slli	a5,a5,0x4
    800096aa:	97ba                	add	a5,a5,a4
    800096ac:	4741                	li	a4,16
    800096ae:	c798                	sw	a4,8(a5)
  disk[id].desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800096b0:	0001b717          	auipc	a4,0x1b
    800096b4:	5d870713          	addi	a4,a4,1496 # 80024c88 <disk>
    800096b8:	fcc42683          	lw	a3,-52(s0)
    800096bc:	15000793          	li	a5,336
    800096c0:	02f687b3          	mul	a5,a3,a5
    800096c4:	97ba                	add	a5,a5,a4
    800096c6:	6798                	ld	a4,8(a5)
    800096c8:	fd042783          	lw	a5,-48(s0)
    800096cc:	0792                	slli	a5,a5,0x4
    800096ce:	97ba                	add	a5,a5,a4
    800096d0:	4705                	li	a4,1
    800096d2:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[0]].next = idx[1];
    800096d6:	fd442603          	lw	a2,-44(s0)
    800096da:	0001b717          	auipc	a4,0x1b
    800096de:	5ae70713          	addi	a4,a4,1454 # 80024c88 <disk>
    800096e2:	fcc42683          	lw	a3,-52(s0)
    800096e6:	15000793          	li	a5,336
    800096ea:	02f687b3          	mul	a5,a3,a5
    800096ee:	97ba                	add	a5,a5,a4
    800096f0:	6798                	ld	a4,8(a5)
    800096f2:	fd042783          	lw	a5,-48(s0)
    800096f6:	0792                	slli	a5,a5,0x4
    800096f8:	97ba                	add	a5,a5,a4
    800096fa:	03061713          	slli	a4,a2,0x30
    800096fe:	9341                	srli	a4,a4,0x30
    80009700:	00e79723          	sh	a4,14(a5)

  disk[id].desc[idx[1]].addr = (uint64) b->data;
    80009704:	fc043783          	ld	a5,-64(s0)
    80009708:	05878613          	addi	a2,a5,88
    8000970c:	0001b717          	auipc	a4,0x1b
    80009710:	57c70713          	addi	a4,a4,1404 # 80024c88 <disk>
    80009714:	fcc42683          	lw	a3,-52(s0)
    80009718:	15000793          	li	a5,336
    8000971c:	02f687b3          	mul	a5,a3,a5
    80009720:	97ba                	add	a5,a5,a4
    80009722:	6798                	ld	a4,8(a5)
    80009724:	fd442783          	lw	a5,-44(s0)
    80009728:	0792                	slli	a5,a5,0x4
    8000972a:	97ba                	add	a5,a5,a4
    8000972c:	8732                	mv	a4,a2
    8000972e:	e398                	sd	a4,0(a5)
  disk[id].desc[idx[1]].len = BSIZE;
    80009730:	0001b717          	auipc	a4,0x1b
    80009734:	55870713          	addi	a4,a4,1368 # 80024c88 <disk>
    80009738:	fcc42683          	lw	a3,-52(s0)
    8000973c:	15000793          	li	a5,336
    80009740:	02f687b3          	mul	a5,a3,a5
    80009744:	97ba                	add	a5,a5,a4
    80009746:	6798                	ld	a4,8(a5)
    80009748:	fd442783          	lw	a5,-44(s0)
    8000974c:	0792                	slli	a5,a5,0x4
    8000974e:	97ba                	add	a5,a5,a4
    80009750:	40000713          	li	a4,1024
    80009754:	c798                	sw	a4,8(a5)
  if(write)
    80009756:	fc842783          	lw	a5,-56(s0)
    8000975a:	2781                	sext.w	a5,a5
    8000975c:	c785                	beqz	a5,80009784 <virtio_disk_rw+0x2c2>
    disk[id].desc[idx[1]].flags = 0; // device reads b->data
    8000975e:	0001b717          	auipc	a4,0x1b
    80009762:	52a70713          	addi	a4,a4,1322 # 80024c88 <disk>
    80009766:	fcc42683          	lw	a3,-52(s0)
    8000976a:	15000793          	li	a5,336
    8000976e:	02f687b3          	mul	a5,a3,a5
    80009772:	97ba                	add	a5,a5,a4
    80009774:	6798                	ld	a4,8(a5)
    80009776:	fd442783          	lw	a5,-44(s0)
    8000977a:	0792                	slli	a5,a5,0x4
    8000977c:	97ba                	add	a5,a5,a4
    8000977e:	00079623          	sh	zero,12(a5)
    80009782:	a025                	j	800097aa <virtio_disk_rw+0x2e8>
  else
    disk[id].desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80009784:	0001b717          	auipc	a4,0x1b
    80009788:	50470713          	addi	a4,a4,1284 # 80024c88 <disk>
    8000978c:	fcc42683          	lw	a3,-52(s0)
    80009790:	15000793          	li	a5,336
    80009794:	02f687b3          	mul	a5,a3,a5
    80009798:	97ba                	add	a5,a5,a4
    8000979a:	6798                	ld	a4,8(a5)
    8000979c:	fd442783          	lw	a5,-44(s0)
    800097a0:	0792                	slli	a5,a5,0x4
    800097a2:	97ba                	add	a5,a5,a4
    800097a4:	4709                	li	a4,2
    800097a6:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800097aa:	0001b717          	auipc	a4,0x1b
    800097ae:	4de70713          	addi	a4,a4,1246 # 80024c88 <disk>
    800097b2:	fcc42683          	lw	a3,-52(s0)
    800097b6:	15000793          	li	a5,336
    800097ba:	02f687b3          	mul	a5,a3,a5
    800097be:	97ba                	add	a5,a5,a4
    800097c0:	6798                	ld	a4,8(a5)
    800097c2:	fd442783          	lw	a5,-44(s0)
    800097c6:	0792                	slli	a5,a5,0x4
    800097c8:	97ba                	add	a5,a5,a4
    800097ca:	00c7d703          	lhu	a4,12(a5)
    800097ce:	0001b697          	auipc	a3,0x1b
    800097d2:	4ba68693          	addi	a3,a3,1210 # 80024c88 <disk>
    800097d6:	fcc42603          	lw	a2,-52(s0)
    800097da:	15000793          	li	a5,336
    800097de:	02f607b3          	mul	a5,a2,a5
    800097e2:	97b6                	add	a5,a5,a3
    800097e4:	6794                	ld	a3,8(a5)
    800097e6:	fd442783          	lw	a5,-44(s0)
    800097ea:	0792                	slli	a5,a5,0x4
    800097ec:	97b6                	add	a5,a5,a3
    800097ee:	00176713          	ori	a4,a4,1
    800097f2:	1742                	slli	a4,a4,0x30
    800097f4:	9341                	srli	a4,a4,0x30
    800097f6:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[1]].next = idx[2];
    800097fa:	fd842603          	lw	a2,-40(s0)
    800097fe:	0001b717          	auipc	a4,0x1b
    80009802:	48a70713          	addi	a4,a4,1162 # 80024c88 <disk>
    80009806:	fcc42683          	lw	a3,-52(s0)
    8000980a:	15000793          	li	a5,336
    8000980e:	02f687b3          	mul	a5,a3,a5
    80009812:	97ba                	add	a5,a5,a4
    80009814:	6798                	ld	a4,8(a5)
    80009816:	fd442783          	lw	a5,-44(s0)
    8000981a:	0792                	slli	a5,a5,0x4
    8000981c:	97ba                	add	a5,a5,a4
    8000981e:	03061713          	slli	a4,a2,0x30
    80009822:	9341                	srli	a4,a4,0x30
    80009824:	00e79723          	sh	a4,14(a5)

  disk[id].info[idx[0]].status = 0xff; // device writes 0 on success
    80009828:	fd042603          	lw	a2,-48(s0)
    8000982c:	0001b697          	auipc	a3,0x1b
    80009830:	45c68693          	addi	a3,a3,1116 # 80024c88 <disk>
    80009834:	fcc42703          	lw	a4,-52(s0)
    80009838:	87ba                	mv	a5,a4
    8000983a:	078a                	slli	a5,a5,0x2
    8000983c:	97ba                	add	a5,a5,a4
    8000983e:	078a                	slli	a5,a5,0x2
    80009840:	97ba                	add	a5,a5,a4
    80009842:	97b2                	add	a5,a5,a2
    80009844:	078d                	addi	a5,a5,3
    80009846:	0792                	slli	a5,a5,0x4
    80009848:	97b6                	add	a5,a5,a3
    8000984a:	577d                	li	a4,-1
    8000984c:	00e78423          	sb	a4,8(a5)
  disk[id].desc[idx[2]].addr = (uint64) &disk[id].info[idx[0]].status;
    80009850:	fd042683          	lw	a3,-48(s0)
    80009854:	fcc42703          	lw	a4,-52(s0)
    80009858:	87ba                	mv	a5,a4
    8000985a:	078a                	slli	a5,a5,0x2
    8000985c:	97ba                	add	a5,a5,a4
    8000985e:	078a                	slli	a5,a5,0x2
    80009860:	97ba                	add	a5,a5,a4
    80009862:	97b6                	add	a5,a5,a3
    80009864:	078d                	addi	a5,a5,3
    80009866:	00479713          	slli	a4,a5,0x4
    8000986a:	0001b797          	auipc	a5,0x1b
    8000986e:	41e78793          	addi	a5,a5,1054 # 80024c88 <disk>
    80009872:	97ba                	add	a5,a5,a4
    80009874:	00878613          	addi	a2,a5,8
    80009878:	0001b717          	auipc	a4,0x1b
    8000987c:	41070713          	addi	a4,a4,1040 # 80024c88 <disk>
    80009880:	fcc42683          	lw	a3,-52(s0)
    80009884:	15000793          	li	a5,336
    80009888:	02f687b3          	mul	a5,a3,a5
    8000988c:	97ba                	add	a5,a5,a4
    8000988e:	6798                	ld	a4,8(a5)
    80009890:	fd842783          	lw	a5,-40(s0)
    80009894:	0792                	slli	a5,a5,0x4
    80009896:	97ba                	add	a5,a5,a4
    80009898:	8732                	mv	a4,a2
    8000989a:	e398                	sd	a4,0(a5)
  disk[id].desc[idx[2]].len = 1;
    8000989c:	0001b717          	auipc	a4,0x1b
    800098a0:	3ec70713          	addi	a4,a4,1004 # 80024c88 <disk>
    800098a4:	fcc42683          	lw	a3,-52(s0)
    800098a8:	15000793          	li	a5,336
    800098ac:	02f687b3          	mul	a5,a3,a5
    800098b0:	97ba                	add	a5,a5,a4
    800098b2:	6798                	ld	a4,8(a5)
    800098b4:	fd842783          	lw	a5,-40(s0)
    800098b8:	0792                	slli	a5,a5,0x4
    800098ba:	97ba                	add	a5,a5,a4
    800098bc:	4705                	li	a4,1
    800098be:	c798                	sw	a4,8(a5)
  disk[id].desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800098c0:	0001b717          	auipc	a4,0x1b
    800098c4:	3c870713          	addi	a4,a4,968 # 80024c88 <disk>
    800098c8:	fcc42683          	lw	a3,-52(s0)
    800098cc:	15000793          	li	a5,336
    800098d0:	02f687b3          	mul	a5,a3,a5
    800098d4:	97ba                	add	a5,a5,a4
    800098d6:	6798                	ld	a4,8(a5)
    800098d8:	fd842783          	lw	a5,-40(s0)
    800098dc:	0792                	slli	a5,a5,0x4
    800098de:	97ba                	add	a5,a5,a4
    800098e0:	4709                	li	a4,2
    800098e2:	00e79623          	sh	a4,12(a5)
  disk[id].desc[idx[2]].next = 0;
    800098e6:	0001b717          	auipc	a4,0x1b
    800098ea:	3a270713          	addi	a4,a4,930 # 80024c88 <disk>
    800098ee:	fcc42683          	lw	a3,-52(s0)
    800098f2:	15000793          	li	a5,336
    800098f6:	02f687b3          	mul	a5,a3,a5
    800098fa:	97ba                	add	a5,a5,a4
    800098fc:	6798                	ld	a4,8(a5)
    800098fe:	fd842783          	lw	a5,-40(s0)
    80009902:	0792                	slli	a5,a5,0x4
    80009904:	97ba                	add	a5,a5,a4
    80009906:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000990a:	fc043783          	ld	a5,-64(s0)
    8000990e:	4705                	li	a4,1
    80009910:	c3d8                	sw	a4,4(a5)
  disk[id].info[idx[0]].b = b;
    80009912:	fd042603          	lw	a2,-48(s0)
    80009916:	0001b697          	auipc	a3,0x1b
    8000991a:	37268693          	addi	a3,a3,882 # 80024c88 <disk>
    8000991e:	fcc42703          	lw	a4,-52(s0)
    80009922:	87ba                	mv	a5,a4
    80009924:	078a                	slli	a5,a5,0x2
    80009926:	97ba                	add	a5,a5,a4
    80009928:	078a                	slli	a5,a5,0x2
    8000992a:	97ba                	add	a5,a5,a4
    8000992c:	97b2                	add	a5,a5,a2
    8000992e:	078d                	addi	a5,a5,3
    80009930:	0792                	slli	a5,a5,0x4
    80009932:	97b6                	add	a5,a5,a3
    80009934:	fc043703          	ld	a4,-64(s0)
    80009938:	e398                	sd	a4,0(a5)

  // tell the device the first index in our chain of descriptors.
  disk[id].avail->ring[disk[id].avail->idx % NUM] = idx[0];
    8000993a:	fd042583          	lw	a1,-48(s0)
    8000993e:	0001b717          	auipc	a4,0x1b
    80009942:	34a70713          	addi	a4,a4,842 # 80024c88 <disk>
    80009946:	fcc42683          	lw	a3,-52(s0)
    8000994a:	15000793          	li	a5,336
    8000994e:	02f687b3          	mul	a5,a3,a5
    80009952:	97ba                	add	a5,a5,a4
    80009954:	6b94                	ld	a3,16(a5)
    80009956:	0001b717          	auipc	a4,0x1b
    8000995a:	33270713          	addi	a4,a4,818 # 80024c88 <disk>
    8000995e:	fcc42603          	lw	a2,-52(s0)
    80009962:	15000793          	li	a5,336
    80009966:	02f607b3          	mul	a5,a2,a5
    8000996a:	97ba                	add	a5,a5,a4
    8000996c:	6b9c                	ld	a5,16(a5)
    8000996e:	0027d783          	lhu	a5,2(a5)
    80009972:	2781                	sext.w	a5,a5
    80009974:	8b9d                	andi	a5,a5,7
    80009976:	2781                	sext.w	a5,a5
    80009978:	03059713          	slli	a4,a1,0x30
    8000997c:	9341                	srli	a4,a4,0x30
    8000997e:	0786                	slli	a5,a5,0x1
    80009980:	97b6                	add	a5,a5,a3
    80009982:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80009986:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk[id].avail->idx += 1; // not % NUM ...
    8000998a:	0001b717          	auipc	a4,0x1b
    8000998e:	2fe70713          	addi	a4,a4,766 # 80024c88 <disk>
    80009992:	fcc42683          	lw	a3,-52(s0)
    80009996:	15000793          	li	a5,336
    8000999a:	02f687b3          	mul	a5,a3,a5
    8000999e:	97ba                	add	a5,a5,a4
    800099a0:	6b9c                	ld	a5,16(a5)
    800099a2:	0027d703          	lhu	a4,2(a5)
    800099a6:	0001b697          	auipc	a3,0x1b
    800099aa:	2e268693          	addi	a3,a3,738 # 80024c88 <disk>
    800099ae:	fcc42603          	lw	a2,-52(s0)
    800099b2:	15000793          	li	a5,336
    800099b6:	02f607b3          	mul	a5,a2,a5
    800099ba:	97b6                	add	a5,a5,a3
    800099bc:	6b9c                	ld	a5,16(a5)
    800099be:	2705                	addiw	a4,a4,1
    800099c0:	1742                	slli	a4,a4,0x30
    800099c2:	9341                	srli	a4,a4,0x30
    800099c4:	00e79123          	sh	a4,2(a5)

  __sync_synchronize();
    800099c8:	0ff0000f          	fence

  *R(id, VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800099cc:	fcc42703          	lw	a4,-52(s0)
    800099d0:	67c1                	lui	a5,0x10
    800099d2:	0785                	addi	a5,a5,1
    800099d4:	97ba                	add	a5,a5,a4
    800099d6:	07b2                	slli	a5,a5,0xc
    800099d8:	05078793          	addi	a5,a5,80 # 10050 <_entry-0x7ffeffb0>
    800099dc:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800099e0:	a871                	j	80009a7c <virtio_disk_rw+0x5ba>
    if (!busy_wait) {
    800099e2:	fbc42783          	lw	a5,-68(s0)
    800099e6:	2781                	sext.w	a5,a5
    800099e8:	e795                	bnez	a5,80009a14 <virtio_disk_rw+0x552>
        sleep(b, &disk[id].vdisk_lock);
    800099ea:	fcc42703          	lw	a4,-52(s0)
    800099ee:	15000793          	li	a5,336
    800099f2:	02f707b3          	mul	a5,a4,a5
    800099f6:	13078713          	addi	a4,a5,304
    800099fa:	0001b797          	auipc	a5,0x1b
    800099fe:	28e78793          	addi	a5,a5,654 # 80024c88 <disk>
    80009a02:	97ba                	add	a5,a5,a4
    80009a04:	85be                	mv	a1,a5
    80009a06:	fc043503          	ld	a0,-64(s0)
    80009a0a:	ffffa097          	auipc	ra,0xffffa
    80009a0e:	ad0080e7          	jalr	-1328(ra) # 800034da <sleep>
    80009a12:	a0ad                	j	80009a7c <virtio_disk_rw+0x5ba>
    } else {
        release(&disk[id].vdisk_lock);
    80009a14:	fcc42703          	lw	a4,-52(s0)
    80009a18:	15000793          	li	a5,336
    80009a1c:	02f707b3          	mul	a5,a4,a5
    80009a20:	13078713          	addi	a4,a5,304
    80009a24:	0001b797          	auipc	a5,0x1b
    80009a28:	26478793          	addi	a5,a5,612 # 80024c88 <disk>
    80009a2c:	97ba                	add	a5,a5,a4
    80009a2e:	853e                	mv	a0,a5
    80009a30:	ffff8097          	auipc	ra,0xffff8
    80009a34:	95e080e7          	jalr	-1698(ra) # 8000138e <release>
        intr_on();
    80009a38:	fffff097          	auipc	ra,0xfffff
    80009a3c:	088080e7          	jalr	136(ra) # 80008ac0 <intr_on>
        while(b->disk == 1);
    80009a40:	0001                	nop
    80009a42:	fc043783          	ld	a5,-64(s0)
    80009a46:	43dc                	lw	a5,4(a5)
    80009a48:	873e                	mv	a4,a5
    80009a4a:	4785                	li	a5,1
    80009a4c:	fef70be3          	beq	a4,a5,80009a42 <virtio_disk_rw+0x580>
        intr_off();
    80009a50:	fffff097          	auipc	ra,0xfffff
    80009a54:	09a080e7          	jalr	154(ra) # 80008aea <intr_off>
        acquire(&disk[id].vdisk_lock);
    80009a58:	fcc42703          	lw	a4,-52(s0)
    80009a5c:	15000793          	li	a5,336
    80009a60:	02f707b3          	mul	a5,a4,a5
    80009a64:	13078713          	addi	a4,a5,304
    80009a68:	0001b797          	auipc	a5,0x1b
    80009a6c:	22078793          	addi	a5,a5,544 # 80024c88 <disk>
    80009a70:	97ba                	add	a5,a5,a4
    80009a72:	853e                	mv	a0,a5
    80009a74:	ffff8097          	auipc	ra,0xffff8
    80009a78:	8b6080e7          	jalr	-1866(ra) # 8000132a <acquire>
  while(b->disk == 1) {
    80009a7c:	fc043783          	ld	a5,-64(s0)
    80009a80:	43dc                	lw	a5,4(a5)
    80009a82:	873e                	mv	a4,a5
    80009a84:	4785                	li	a5,1
    80009a86:	f4f70ee3          	beq	a4,a5,800099e2 <virtio_disk_rw+0x520>
    }
  }

  disk[id].info[idx[0]].b = 0;
    80009a8a:	fd042603          	lw	a2,-48(s0)
    80009a8e:	0001b697          	auipc	a3,0x1b
    80009a92:	1fa68693          	addi	a3,a3,506 # 80024c88 <disk>
    80009a96:	fcc42703          	lw	a4,-52(s0)
    80009a9a:	87ba                	mv	a5,a4
    80009a9c:	078a                	slli	a5,a5,0x2
    80009a9e:	97ba                	add	a5,a5,a4
    80009aa0:	078a                	slli	a5,a5,0x2
    80009aa2:	97ba                	add	a5,a5,a4
    80009aa4:	97b2                	add	a5,a5,a2
    80009aa6:	078d                	addi	a5,a5,3
    80009aa8:	0792                	slli	a5,a5,0x4
    80009aaa:	97b6                	add	a5,a5,a3
    80009aac:	0007b023          	sd	zero,0(a5)
  free_chain(id, idx[0]);
    80009ab0:	fd042703          	lw	a4,-48(s0)
    80009ab4:	fcc42783          	lw	a5,-52(s0)
    80009ab8:	85ba                	mv	a1,a4
    80009aba:	853e                	mv	a0,a5
    80009abc:	00000097          	auipc	ra,0x0
    80009ac0:	8b8080e7          	jalr	-1864(ra) # 80009374 <free_chain>

  release(&disk[id].vdisk_lock);
    80009ac4:	fcc42703          	lw	a4,-52(s0)
    80009ac8:	15000793          	li	a5,336
    80009acc:	02f707b3          	mul	a5,a4,a5
    80009ad0:	13078713          	addi	a4,a5,304
    80009ad4:	0001b797          	auipc	a5,0x1b
    80009ad8:	1b478793          	addi	a5,a5,436 # 80024c88 <disk>
    80009adc:	97ba                	add	a5,a5,a4
    80009ade:	853e                	mv	a0,a5
    80009ae0:	ffff8097          	auipc	ra,0xffff8
    80009ae4:	8ae080e7          	jalr	-1874(ra) # 8000138e <release>
}
    80009ae8:	0001                	nop
    80009aea:	60a6                	ld	ra,72(sp)
    80009aec:	6406                	ld	s0,64(sp)
    80009aee:	6161                	addi	sp,sp,80
    80009af0:	8082                	ret

0000000080009af2 <write_block>:

void write_block(int blockno, uchar data[BSIZE], int busy_wait) {
    80009af2:	7179                	addi	sp,sp,-48
    80009af4:	f406                	sd	ra,40(sp)
    80009af6:	f022                	sd	s0,32(sp)
    80009af8:	1800                	addi	s0,sp,48
    80009afa:	87aa                	mv	a5,a0
    80009afc:	fcb43823          	sd	a1,-48(s0)
    80009b00:	8732                	mv	a4,a2
    80009b02:	fcf42e23          	sw	a5,-36(s0)
    80009b06:	87ba                	mv	a5,a4
    80009b08:	fcf42c23          	sw	a5,-40(s0)
    struct buf *b = swap_buffer;
    80009b0c:	0001b797          	auipc	a5,0x1b
    80009b10:	41c78793          	addi	a5,a5,1052 # 80024f28 <swap_buffer>
    80009b14:	639c                	ld	a5,0(a5)
    80009b16:	fef43423          	sd	a5,-24(s0)
    b->blockno = blockno;
    80009b1a:	fdc42703          	lw	a4,-36(s0)
    80009b1e:	fe843783          	ld	a5,-24(s0)
    80009b22:	c7d8                	sw	a4,12(a5)
    memmove(b->data, data, BSIZE);
    80009b24:	fe843783          	ld	a5,-24(s0)
    80009b28:	05878793          	addi	a5,a5,88
    80009b2c:	40000613          	li	a2,1024
    80009b30:	fd043583          	ld	a1,-48(s0)
    80009b34:	853e                	mv	a0,a5
    80009b36:	ffff8097          	auipc	ra,0xffff8
    80009b3a:	aac080e7          	jalr	-1364(ra) # 800015e2 <memmove>

    virtio_disk_rw(VIRTIO1_ID, b, 1, busy_wait);
    80009b3e:	fd842783          	lw	a5,-40(s0)
    80009b42:	86be                	mv	a3,a5
    80009b44:	4605                	li	a2,1
    80009b46:	fe843583          	ld	a1,-24(s0)
    80009b4a:	4505                	li	a0,1
    80009b4c:	00000097          	auipc	ra,0x0
    80009b50:	976080e7          	jalr	-1674(ra) # 800094c2 <virtio_disk_rw>
}
    80009b54:	0001                	nop
    80009b56:	70a2                	ld	ra,40(sp)
    80009b58:	7402                	ld	s0,32(sp)
    80009b5a:	6145                	addi	sp,sp,48
    80009b5c:	8082                	ret

0000000080009b5e <read_block>:

void read_block(int blockno, uchar data[BSIZE], int busy_wait) {
    80009b5e:	7179                	addi	sp,sp,-48
    80009b60:	f406                	sd	ra,40(sp)
    80009b62:	f022                	sd	s0,32(sp)
    80009b64:	1800                	addi	s0,sp,48
    80009b66:	87aa                	mv	a5,a0
    80009b68:	fcb43823          	sd	a1,-48(s0)
    80009b6c:	8732                	mv	a4,a2
    80009b6e:	fcf42e23          	sw	a5,-36(s0)
    80009b72:	87ba                	mv	a5,a4
    80009b74:	fcf42c23          	sw	a5,-40(s0)
    struct buf *b = swap_buffer;
    80009b78:	0001b797          	auipc	a5,0x1b
    80009b7c:	3b078793          	addi	a5,a5,944 # 80024f28 <swap_buffer>
    80009b80:	639c                	ld	a5,0(a5)
    80009b82:	fef43423          	sd	a5,-24(s0)
    b->blockno = blockno;
    80009b86:	fdc42703          	lw	a4,-36(s0)
    80009b8a:	fe843783          	ld	a5,-24(s0)
    80009b8e:	c7d8                	sw	a4,12(a5)

    virtio_disk_rw(VIRTIO1_ID, b, 0, busy_wait);
    80009b90:	fd842783          	lw	a5,-40(s0)
    80009b94:	86be                	mv	a3,a5
    80009b96:	4601                	li	a2,0
    80009b98:	fe843583          	ld	a1,-24(s0)
    80009b9c:	4505                	li	a0,1
    80009b9e:	00000097          	auipc	ra,0x0
    80009ba2:	924080e7          	jalr	-1756(ra) # 800094c2 <virtio_disk_rw>
    memmove(data, b->data, BSIZE);
    80009ba6:	fe843783          	ld	a5,-24(s0)
    80009baa:	05878793          	addi	a5,a5,88
    80009bae:	40000613          	li	a2,1024
    80009bb2:	85be                	mv	a1,a5
    80009bb4:	fd043503          	ld	a0,-48(s0)
    80009bb8:	ffff8097          	auipc	ra,0xffff8
    80009bbc:	a2a080e7          	jalr	-1494(ra) # 800015e2 <memmove>
}
    80009bc0:	0001                	nop
    80009bc2:	70a2                	ld	ra,40(sp)
    80009bc4:	7402                	ld	s0,32(sp)
    80009bc6:	6145                	addi	sp,sp,48
    80009bc8:	8082                	ret

0000000080009bca <virtio_disk_intr>:

void
virtio_disk_intr(int id)
{
    80009bca:	7179                	addi	sp,sp,-48
    80009bcc:	f406                	sd	ra,40(sp)
    80009bce:	f022                	sd	s0,32(sp)
    80009bd0:	1800                	addi	s0,sp,48
    80009bd2:	87aa                	mv	a5,a0
    80009bd4:	fcf42e23          	sw	a5,-36(s0)
  acquire(&disk[id].vdisk_lock);
    80009bd8:	fdc42703          	lw	a4,-36(s0)
    80009bdc:	15000793          	li	a5,336
    80009be0:	02f707b3          	mul	a5,a4,a5
    80009be4:	13078713          	addi	a4,a5,304
    80009be8:	0001b797          	auipc	a5,0x1b
    80009bec:	0a078793          	addi	a5,a5,160 # 80024c88 <disk>
    80009bf0:	97ba                	add	a5,a5,a4
    80009bf2:	853e                	mv	a0,a5
    80009bf4:	ffff7097          	auipc	ra,0xffff7
    80009bf8:	736080e7          	jalr	1846(ra) # 8000132a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(id, VIRTIO_MMIO_INTERRUPT_ACK) = *R(id, VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80009bfc:	fdc42703          	lw	a4,-36(s0)
    80009c00:	67c1                	lui	a5,0x10
    80009c02:	0785                	addi	a5,a5,1
    80009c04:	97ba                	add	a5,a5,a4
    80009c06:	07b2                	slli	a5,a5,0xc
    80009c08:	06078793          	addi	a5,a5,96 # 10060 <_entry-0x7ffeffa0>
    80009c0c:	439c                	lw	a5,0(a5)
    80009c0e:	0007869b          	sext.w	a3,a5
    80009c12:	fdc42703          	lw	a4,-36(s0)
    80009c16:	67c1                	lui	a5,0x10
    80009c18:	0785                	addi	a5,a5,1
    80009c1a:	97ba                	add	a5,a5,a4
    80009c1c:	07b2                	slli	a5,a5,0xc
    80009c1e:	06478793          	addi	a5,a5,100 # 10064 <_entry-0x7ffeff9c>
    80009c22:	873e                	mv	a4,a5
    80009c24:	87b6                	mv	a5,a3
    80009c26:	8b8d                	andi	a5,a5,3
    80009c28:	2781                	sext.w	a5,a5
    80009c2a:	c31c                	sw	a5,0(a4)

  __sync_synchronize();
    80009c2c:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk[id].used_idx != disk[id].used->idx){
    80009c30:	aa05                	j	80009d60 <virtio_disk_intr+0x196>
    __sync_synchronize();
    80009c32:	0ff0000f          	fence
    int idx = disk[id].used->ring[disk[id].used_idx % NUM].id;
    80009c36:	0001b717          	auipc	a4,0x1b
    80009c3a:	05270713          	addi	a4,a4,82 # 80024c88 <disk>
    80009c3e:	fdc42683          	lw	a3,-36(s0)
    80009c42:	15000793          	li	a5,336
    80009c46:	02f687b3          	mul	a5,a3,a5
    80009c4a:	97ba                	add	a5,a5,a4
    80009c4c:	6f98                	ld	a4,24(a5)
    80009c4e:	0001b697          	auipc	a3,0x1b
    80009c52:	03a68693          	addi	a3,a3,58 # 80024c88 <disk>
    80009c56:	fdc42603          	lw	a2,-36(s0)
    80009c5a:	15000793          	li	a5,336
    80009c5e:	02f607b3          	mul	a5,a2,a5
    80009c62:	97b6                	add	a5,a5,a3
    80009c64:	0287d783          	lhu	a5,40(a5)
    80009c68:	2781                	sext.w	a5,a5
    80009c6a:	8b9d                	andi	a5,a5,7
    80009c6c:	2781                	sext.w	a5,a5
    80009c6e:	078e                	slli	a5,a5,0x3
    80009c70:	97ba                	add	a5,a5,a4
    80009c72:	43dc                	lw	a5,4(a5)
    80009c74:	fef42623          	sw	a5,-20(s0)

    if(disk[id].info[idx].status != 0)
    80009c78:	0001b697          	auipc	a3,0x1b
    80009c7c:	01068693          	addi	a3,a3,16 # 80024c88 <disk>
    80009c80:	fec42603          	lw	a2,-20(s0)
    80009c84:	fdc42703          	lw	a4,-36(s0)
    80009c88:	87ba                	mv	a5,a4
    80009c8a:	078a                	slli	a5,a5,0x2
    80009c8c:	97ba                	add	a5,a5,a4
    80009c8e:	078a                	slli	a5,a5,0x2
    80009c90:	97ba                	add	a5,a5,a4
    80009c92:	97b2                	add	a5,a5,a2
    80009c94:	078d                	addi	a5,a5,3
    80009c96:	0792                	slli	a5,a5,0x4
    80009c98:	97b6                	add	a5,a5,a3
    80009c9a:	0087c783          	lbu	a5,8(a5)
    80009c9e:	c79d                	beqz	a5,80009ccc <virtio_disk_intr+0x102>
      panic_concat(2, disk[id].name, ": virtio_disk_intr status");
    80009ca0:	0001b717          	auipc	a4,0x1b
    80009ca4:	fe870713          	addi	a4,a4,-24 # 80024c88 <disk>
    80009ca8:	fdc42683          	lw	a3,-36(s0)
    80009cac:	15000793          	li	a5,336
    80009cb0:	02f687b3          	mul	a5,a3,a5
    80009cb4:	97ba                	add	a5,a5,a4
    80009cb6:	639c                	ld	a5,0(a5)
    80009cb8:	00002617          	auipc	a2,0x2
    80009cbc:	ae060613          	addi	a2,a2,-1312 # 8000b798 <etext+0x798>
    80009cc0:	85be                	mv	a1,a5
    80009cc2:	4509                	li	a0,2
    80009cc4:	ffff7097          	auipc	ra,0xffff7
    80009cc8:	01a080e7          	jalr	26(ra) # 80000cde <panic_concat>

    struct buf *b = disk[id].info[idx].b;
    80009ccc:	0001b697          	auipc	a3,0x1b
    80009cd0:	fbc68693          	addi	a3,a3,-68 # 80024c88 <disk>
    80009cd4:	fec42603          	lw	a2,-20(s0)
    80009cd8:	fdc42703          	lw	a4,-36(s0)
    80009cdc:	87ba                	mv	a5,a4
    80009cde:	078a                	slli	a5,a5,0x2
    80009ce0:	97ba                	add	a5,a5,a4
    80009ce2:	078a                	slli	a5,a5,0x2
    80009ce4:	97ba                	add	a5,a5,a4
    80009ce6:	97b2                	add	a5,a5,a2
    80009ce8:	078d                	addi	a5,a5,3
    80009cea:	0792                	slli	a5,a5,0x4
    80009cec:	97b6                	add	a5,a5,a3
    80009cee:	639c                	ld	a5,0(a5)
    80009cf0:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80009cf4:	fe043783          	ld	a5,-32(s0)
    80009cf8:	0007a223          	sw	zero,4(a5)
    if (!disk[id].bw_transfer) {
    80009cfc:	0001b717          	auipc	a4,0x1b
    80009d00:	f8c70713          	addi	a4,a4,-116 # 80024c88 <disk>
    80009d04:	fdc42683          	lw	a3,-36(s0)
    80009d08:	15000793          	li	a5,336
    80009d0c:	02f687b3          	mul	a5,a3,a5
    80009d10:	97ba                	add	a5,a5,a4
    80009d12:	1487a783          	lw	a5,328(a5)
    80009d16:	e799                	bnez	a5,80009d24 <virtio_disk_intr+0x15a>
        wakeup(b);
    80009d18:	fe043503          	ld	a0,-32(s0)
    80009d1c:	ffffa097          	auipc	ra,0xffffa
    80009d20:	83a080e7          	jalr	-1990(ra) # 80003556 <wakeup>
    }

    disk[id].used_idx += 1;
    80009d24:	0001b717          	auipc	a4,0x1b
    80009d28:	f6470713          	addi	a4,a4,-156 # 80024c88 <disk>
    80009d2c:	fdc42683          	lw	a3,-36(s0)
    80009d30:	15000793          	li	a5,336
    80009d34:	02f687b3          	mul	a5,a3,a5
    80009d38:	97ba                	add	a5,a5,a4
    80009d3a:	0287d783          	lhu	a5,40(a5)
    80009d3e:	2785                	addiw	a5,a5,1
    80009d40:	03079713          	slli	a4,a5,0x30
    80009d44:	9341                	srli	a4,a4,0x30
    80009d46:	0001b697          	auipc	a3,0x1b
    80009d4a:	f4268693          	addi	a3,a3,-190 # 80024c88 <disk>
    80009d4e:	fdc42603          	lw	a2,-36(s0)
    80009d52:	15000793          	li	a5,336
    80009d56:	02f607b3          	mul	a5,a2,a5
    80009d5a:	97b6                	add	a5,a5,a3
    80009d5c:	02e79423          	sh	a4,40(a5)
  while(disk[id].used_idx != disk[id].used->idx){
    80009d60:	0001b717          	auipc	a4,0x1b
    80009d64:	f2870713          	addi	a4,a4,-216 # 80024c88 <disk>
    80009d68:	fdc42683          	lw	a3,-36(s0)
    80009d6c:	15000793          	li	a5,336
    80009d70:	02f687b3          	mul	a5,a3,a5
    80009d74:	97ba                	add	a5,a5,a4
    80009d76:	0287d603          	lhu	a2,40(a5)
    80009d7a:	0001b717          	auipc	a4,0x1b
    80009d7e:	f0e70713          	addi	a4,a4,-242 # 80024c88 <disk>
    80009d82:	fdc42683          	lw	a3,-36(s0)
    80009d86:	15000793          	li	a5,336
    80009d8a:	02f687b3          	mul	a5,a3,a5
    80009d8e:	97ba                	add	a5,a5,a4
    80009d90:	6f9c                	ld	a5,24(a5)
    80009d92:	0027d783          	lhu	a5,2(a5)
    80009d96:	0006071b          	sext.w	a4,a2
    80009d9a:	2781                	sext.w	a5,a5
    80009d9c:	e8f71be3          	bne	a4,a5,80009c32 <virtio_disk_intr+0x68>
  }

  release(&disk[id].vdisk_lock);
    80009da0:	fdc42703          	lw	a4,-36(s0)
    80009da4:	15000793          	li	a5,336
    80009da8:	02f707b3          	mul	a5,a4,a5
    80009dac:	13078713          	addi	a4,a5,304
    80009db0:	0001b797          	auipc	a5,0x1b
    80009db4:	ed878793          	addi	a5,a5,-296 # 80024c88 <disk>
    80009db8:	97ba                	add	a5,a5,a4
    80009dba:	853e                	mv	a0,a5
    80009dbc:	ffff7097          	auipc	ra,0xffff7
    80009dc0:	5d2080e7          	jalr	1490(ra) # 8000138e <release>
}
    80009dc4:	0001                	nop
    80009dc6:	70a2                	ld	ra,40(sp)
    80009dc8:	7402                	ld	s0,32(sp)
    80009dca:	6145                	addi	sp,sp,48
    80009dcc:	8082                	ret
	...

000000008000a000 <_trampoline>:
    8000a000:	14051073          	csrw	sscratch,a0
    8000a004:	02000537          	lui	a0,0x2000
    8000a008:	357d                	addiw	a0,a0,-1
    8000a00a:	0536                	slli	a0,a0,0xd
    8000a00c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    8000a010:	02253823          	sd	sp,48(a0)
    8000a014:	02353c23          	sd	gp,56(a0)
    8000a018:	04453023          	sd	tp,64(a0)
    8000a01c:	04553423          	sd	t0,72(a0)
    8000a020:	04653823          	sd	t1,80(a0)
    8000a024:	04753c23          	sd	t2,88(a0)
    8000a028:	f120                	sd	s0,96(a0)
    8000a02a:	f524                	sd	s1,104(a0)
    8000a02c:	fd2c                	sd	a1,120(a0)
    8000a02e:	e150                	sd	a2,128(a0)
    8000a030:	e554                	sd	a3,136(a0)
    8000a032:	e958                	sd	a4,144(a0)
    8000a034:	ed5c                	sd	a5,152(a0)
    8000a036:	0b053023          	sd	a6,160(a0)
    8000a03a:	0b153423          	sd	a7,168(a0)
    8000a03e:	0b253823          	sd	s2,176(a0)
    8000a042:	0b353c23          	sd	s3,184(a0)
    8000a046:	0d453023          	sd	s4,192(a0)
    8000a04a:	0d553423          	sd	s5,200(a0)
    8000a04e:	0d653823          	sd	s6,208(a0)
    8000a052:	0d753c23          	sd	s7,216(a0)
    8000a056:	0f853023          	sd	s8,224(a0)
    8000a05a:	0f953423          	sd	s9,232(a0)
    8000a05e:	0fa53823          	sd	s10,240(a0)
    8000a062:	0fb53c23          	sd	s11,248(a0)
    8000a066:	11c53023          	sd	t3,256(a0)
    8000a06a:	11d53423          	sd	t4,264(a0)
    8000a06e:	11e53823          	sd	t5,272(a0)
    8000a072:	11f53c23          	sd	t6,280(a0)
    8000a076:	140022f3          	csrr	t0,sscratch
    8000a07a:	06553823          	sd	t0,112(a0)
    8000a07e:	00853103          	ld	sp,8(a0)
    8000a082:	02053203          	ld	tp,32(a0)
    8000a086:	01053283          	ld	t0,16(a0)
    8000a08a:	00053303          	ld	t1,0(a0)
    8000a08e:	12000073          	sfence.vma
    8000a092:	18031073          	csrw	satp,t1
    8000a096:	12000073          	sfence.vma
    8000a09a:	8282                	jr	t0

000000008000a09c <userret>:
    8000a09c:	12000073          	sfence.vma
    8000a0a0:	18051073          	csrw	satp,a0
    8000a0a4:	12000073          	sfence.vma
    8000a0a8:	02000537          	lui	a0,0x2000
    8000a0ac:	357d                	addiw	a0,a0,-1
    8000a0ae:	0536                	slli	a0,a0,0xd
    8000a0b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    8000a0b4:	03053103          	ld	sp,48(a0)
    8000a0b8:	03853183          	ld	gp,56(a0)
    8000a0bc:	04053203          	ld	tp,64(a0)
    8000a0c0:	04853283          	ld	t0,72(a0)
    8000a0c4:	05053303          	ld	t1,80(a0)
    8000a0c8:	05853383          	ld	t2,88(a0)
    8000a0cc:	7120                	ld	s0,96(a0)
    8000a0ce:	7524                	ld	s1,104(a0)
    8000a0d0:	7d2c                	ld	a1,120(a0)
    8000a0d2:	6150                	ld	a2,128(a0)
    8000a0d4:	6554                	ld	a3,136(a0)
    8000a0d6:	6958                	ld	a4,144(a0)
    8000a0d8:	6d5c                	ld	a5,152(a0)
    8000a0da:	0a053803          	ld	a6,160(a0)
    8000a0de:	0a853883          	ld	a7,168(a0)
    8000a0e2:	0b053903          	ld	s2,176(a0)
    8000a0e6:	0b853983          	ld	s3,184(a0)
    8000a0ea:	0c053a03          	ld	s4,192(a0)
    8000a0ee:	0c853a83          	ld	s5,200(a0)
    8000a0f2:	0d053b03          	ld	s6,208(a0)
    8000a0f6:	0d853b83          	ld	s7,216(a0)
    8000a0fa:	0e053c03          	ld	s8,224(a0)
    8000a0fe:	0e853c83          	ld	s9,232(a0)
    8000a102:	0f053d03          	ld	s10,240(a0)
    8000a106:	0f853d83          	ld	s11,248(a0)
    8000a10a:	10053e03          	ld	t3,256(a0)
    8000a10e:	10853e83          	ld	t4,264(a0)
    8000a112:	11053f03          	ld	t5,272(a0)
    8000a116:	11853f83          	ld	t6,280(a0)
    8000a11a:	7928                	ld	a0,112(a0)
    8000a11c:	10200073          	sret
	...
