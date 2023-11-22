
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <r_sp>:
  return (x & SSTATUS_SIE) != 0;
}

static inline uint64
r_sp()
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
       6:	878a                	mv	a5,sp
       8:	fef43423          	sd	a5,-24(s0)
  return x;
       c:	fe843783          	ld	a5,-24(s0)
}
      10:	853e                	mv	a0,a5
      12:	6462                	ld	s0,24(sp)
      14:	6105                	addi	sp,sp,32
      16:	8082                	ret

0000000000000018 <copyin>:

// what if you pass ridiculous pointers to system calls
// that read user memory with copyin?
void
copyin(char *s)
{
      18:	715d                	addi	sp,sp,-80
      1a:	e486                	sd	ra,72(sp)
      1c:	e0a2                	sd	s0,64(sp)
      1e:	0880                	addi	s0,sp,80
      20:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
      24:	4785                	li	a5,1
      26:	07fe                	slli	a5,a5,0x1f
      28:	fcf43423          	sd	a5,-56(s0)
      2c:	57fd                	li	a5,-1
      2e:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
      32:	fe042623          	sw	zero,-20(s0)
      36:	a245                	j	1d6 <copyin+0x1be>
    uint64 addr = addrs[ai];
      38:	fec42783          	lw	a5,-20(s0)
      3c:	078e                	slli	a5,a5,0x3
      3e:	ff040713          	addi	a4,s0,-16
      42:	97ba                	add	a5,a5,a4
      44:	fd87b783          	ld	a5,-40(a5)
      48:	fef43023          	sd	a5,-32(s0)

    int fd = open("copyin1", O_CREATE|O_WRONLY);
      4c:	20100593          	li	a1,513
      50:	00008517          	auipc	a0,0x8
      54:	05050513          	addi	a0,a0,80 # 80a0 <malloc+0x168>
      58:	00008097          	auipc	ra,0x8
      5c:	800080e7          	jalr	-2048(ra) # 7858 <open>
      60:	87aa                	mv	a5,a0
      62:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
      66:	fdc42783          	lw	a5,-36(s0)
      6a:	2781                	sext.w	a5,a5
      6c:	0007df63          	bgez	a5,8a <copyin+0x72>
      printf("open(copyin1) failed\n");
      70:	00008517          	auipc	a0,0x8
      74:	03850513          	addi	a0,a0,56 # 80a8 <malloc+0x170>
      78:	00008097          	auipc	ra,0x8
      7c:	cce080e7          	jalr	-818(ra) # 7d46 <printf>
      exit(1);
      80:	4505                	li	a0,1
      82:	00007097          	auipc	ra,0x7
      86:	796080e7          	jalr	1942(ra) # 7818 <exit>
    }
    int n = write(fd, (void*)addr, 8192);
      8a:	fe043703          	ld	a4,-32(s0)
      8e:	fdc42783          	lw	a5,-36(s0)
      92:	6609                	lui	a2,0x2
      94:	85ba                	mv	a1,a4
      96:	853e                	mv	a0,a5
      98:	00007097          	auipc	ra,0x7
      9c:	7a0080e7          	jalr	1952(ra) # 7838 <write>
      a0:	87aa                	mv	a5,a0
      a2:	fcf42c23          	sw	a5,-40(s0)
    if(n >= 0){
      a6:	fd842783          	lw	a5,-40(s0)
      aa:	2781                	sext.w	a5,a5
      ac:	0207c463          	bltz	a5,d4 <copyin+0xbc>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
      b0:	fd842783          	lw	a5,-40(s0)
      b4:	863e                	mv	a2,a5
      b6:	fe043583          	ld	a1,-32(s0)
      ba:	00008517          	auipc	a0,0x8
      be:	00650513          	addi	a0,a0,6 # 80c0 <malloc+0x188>
      c2:	00008097          	auipc	ra,0x8
      c6:	c84080e7          	jalr	-892(ra) # 7d46 <printf>
      exit(1);
      ca:	4505                	li	a0,1
      cc:	00007097          	auipc	ra,0x7
      d0:	74c080e7          	jalr	1868(ra) # 7818 <exit>
    }
    close(fd);
      d4:	fdc42783          	lw	a5,-36(s0)
      d8:	853e                	mv	a0,a5
      da:	00007097          	auipc	ra,0x7
      de:	766080e7          	jalr	1894(ra) # 7840 <close>
    unlink("copyin1");
      e2:	00008517          	auipc	a0,0x8
      e6:	fbe50513          	addi	a0,a0,-66 # 80a0 <malloc+0x168>
      ea:	00007097          	auipc	ra,0x7
      ee:	77e080e7          	jalr	1918(ra) # 7868 <unlink>

    n = write(1, (char*)addr, 8192);
      f2:	fe043783          	ld	a5,-32(s0)
      f6:	6609                	lui	a2,0x2
      f8:	85be                	mv	a1,a5
      fa:	4505                	li	a0,1
      fc:	00007097          	auipc	ra,0x7
     100:	73c080e7          	jalr	1852(ra) # 7838 <write>
     104:	87aa                	mv	a5,a0
     106:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     10a:	fd842783          	lw	a5,-40(s0)
     10e:	2781                	sext.w	a5,a5
     110:	02f05463          	blez	a5,138 <copyin+0x120>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     114:	fd842783          	lw	a5,-40(s0)
     118:	863e                	mv	a2,a5
     11a:	fe043583          	ld	a1,-32(s0)
     11e:	00008517          	auipc	a0,0x8
     122:	fd250513          	addi	a0,a0,-46 # 80f0 <malloc+0x1b8>
     126:	00008097          	auipc	ra,0x8
     12a:	c20080e7          	jalr	-992(ra) # 7d46 <printf>
      exit(1);
     12e:	4505                	li	a0,1
     130:	00007097          	auipc	ra,0x7
     134:	6e8080e7          	jalr	1768(ra) # 7818 <exit>
    }

    int fds[2];
    if(pipe(fds) < 0){
     138:	fc040793          	addi	a5,s0,-64
     13c:	853e                	mv	a0,a5
     13e:	00007097          	auipc	ra,0x7
     142:	6ea080e7          	jalr	1770(ra) # 7828 <pipe>
     146:	87aa                	mv	a5,a0
     148:	0007df63          	bgez	a5,166 <copyin+0x14e>
      printf("pipe() failed\n");
     14c:	00008517          	auipc	a0,0x8
     150:	fd450513          	addi	a0,a0,-44 # 8120 <malloc+0x1e8>
     154:	00008097          	auipc	ra,0x8
     158:	bf2080e7          	jalr	-1038(ra) # 7d46 <printf>
      exit(1);
     15c:	4505                	li	a0,1
     15e:	00007097          	auipc	ra,0x7
     162:	6ba080e7          	jalr	1722(ra) # 7818 <exit>
    }
    n = write(fds[1], (char*)addr, 8192);
     166:	fc442783          	lw	a5,-60(s0)
     16a:	fe043703          	ld	a4,-32(s0)
     16e:	6609                	lui	a2,0x2
     170:	85ba                	mv	a1,a4
     172:	853e                	mv	a0,a5
     174:	00007097          	auipc	ra,0x7
     178:	6c4080e7          	jalr	1732(ra) # 7838 <write>
     17c:	87aa                	mv	a5,a0
     17e:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     182:	fd842783          	lw	a5,-40(s0)
     186:	2781                	sext.w	a5,a5
     188:	02f05463          	blez	a5,1b0 <copyin+0x198>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     18c:	fd842783          	lw	a5,-40(s0)
     190:	863e                	mv	a2,a5
     192:	fe043583          	ld	a1,-32(s0)
     196:	00008517          	auipc	a0,0x8
     19a:	f9a50513          	addi	a0,a0,-102 # 8130 <malloc+0x1f8>
     19e:	00008097          	auipc	ra,0x8
     1a2:	ba8080e7          	jalr	-1112(ra) # 7d46 <printf>
      exit(1);
     1a6:	4505                	li	a0,1
     1a8:	00007097          	auipc	ra,0x7
     1ac:	670080e7          	jalr	1648(ra) # 7818 <exit>
    }
    close(fds[0]);
     1b0:	fc042783          	lw	a5,-64(s0)
     1b4:	853e                	mv	a0,a5
     1b6:	00007097          	auipc	ra,0x7
     1ba:	68a080e7          	jalr	1674(ra) # 7840 <close>
    close(fds[1]);
     1be:	fc442783          	lw	a5,-60(s0)
     1c2:	853e                	mv	a0,a5
     1c4:	00007097          	auipc	ra,0x7
     1c8:	67c080e7          	jalr	1660(ra) # 7840 <close>
  for(int ai = 0; ai < 2; ai++){
     1cc:	fec42783          	lw	a5,-20(s0)
     1d0:	2785                	addiw	a5,a5,1
     1d2:	fef42623          	sw	a5,-20(s0)
     1d6:	fec42783          	lw	a5,-20(s0)
     1da:	0007871b          	sext.w	a4,a5
     1de:	4785                	li	a5,1
     1e0:	e4e7dce3          	bge	a5,a4,38 <copyin+0x20>
  }
}
     1e4:	0001                	nop
     1e6:	0001                	nop
     1e8:	60a6                	ld	ra,72(sp)
     1ea:	6406                	ld	s0,64(sp)
     1ec:	6161                	addi	sp,sp,80
     1ee:	8082                	ret

00000000000001f0 <copyout>:

// what if you pass ridiculous pointers to system calls
// that write user memory with copyout?
void
copyout(char *s)
{
     1f0:	715d                	addi	sp,sp,-80
     1f2:	e486                	sd	ra,72(sp)
     1f4:	e0a2                	sd	s0,64(sp)
     1f6:	0880                	addi	s0,sp,80
     1f8:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     1fc:	4785                	li	a5,1
     1fe:	07fe                	slli	a5,a5,0x1f
     200:	fcf43423          	sd	a5,-56(s0)
     204:	57fd                	li	a5,-1
     206:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     20a:	fe042623          	sw	zero,-20(s0)
     20e:	a279                	j	39c <copyout+0x1ac>
    uint64 addr = addrs[ai];
     210:	fec42783          	lw	a5,-20(s0)
     214:	078e                	slli	a5,a5,0x3
     216:	ff040713          	addi	a4,s0,-16
     21a:	97ba                	add	a5,a5,a4
     21c:	fd87b783          	ld	a5,-40(a5)
     220:	fef43023          	sd	a5,-32(s0)

    int fd = open("README", 0);
     224:	4581                	li	a1,0
     226:	00008517          	auipc	a0,0x8
     22a:	f3a50513          	addi	a0,a0,-198 # 8160 <malloc+0x228>
     22e:	00007097          	auipc	ra,0x7
     232:	62a080e7          	jalr	1578(ra) # 7858 <open>
     236:	87aa                	mv	a5,a0
     238:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
     23c:	fdc42783          	lw	a5,-36(s0)
     240:	2781                	sext.w	a5,a5
     242:	0007df63          	bgez	a5,260 <copyout+0x70>
      printf("open(README) failed\n");
     246:	00008517          	auipc	a0,0x8
     24a:	f2250513          	addi	a0,a0,-222 # 8168 <malloc+0x230>
     24e:	00008097          	auipc	ra,0x8
     252:	af8080e7          	jalr	-1288(ra) # 7d46 <printf>
      exit(1);
     256:	4505                	li	a0,1
     258:	00007097          	auipc	ra,0x7
     25c:	5c0080e7          	jalr	1472(ra) # 7818 <exit>
    }
    int n = read(fd, (void*)addr, 8192);
     260:	fe043703          	ld	a4,-32(s0)
     264:	fdc42783          	lw	a5,-36(s0)
     268:	6609                	lui	a2,0x2
     26a:	85ba                	mv	a1,a4
     26c:	853e                	mv	a0,a5
     26e:	00007097          	auipc	ra,0x7
     272:	5c2080e7          	jalr	1474(ra) # 7830 <read>
     276:	87aa                	mv	a5,a0
     278:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     27c:	fd842783          	lw	a5,-40(s0)
     280:	2781                	sext.w	a5,a5
     282:	02f05463          	blez	a5,2aa <copyout+0xba>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     286:	fd842783          	lw	a5,-40(s0)
     28a:	863e                	mv	a2,a5
     28c:	fe043583          	ld	a1,-32(s0)
     290:	00008517          	auipc	a0,0x8
     294:	ef050513          	addi	a0,a0,-272 # 8180 <malloc+0x248>
     298:	00008097          	auipc	ra,0x8
     29c:	aae080e7          	jalr	-1362(ra) # 7d46 <printf>
      exit(1);
     2a0:	4505                	li	a0,1
     2a2:	00007097          	auipc	ra,0x7
     2a6:	576080e7          	jalr	1398(ra) # 7818 <exit>
    }
    close(fd);
     2aa:	fdc42783          	lw	a5,-36(s0)
     2ae:	853e                	mv	a0,a5
     2b0:	00007097          	auipc	ra,0x7
     2b4:	590080e7          	jalr	1424(ra) # 7840 <close>

    int fds[2];
    if(pipe(fds) < 0){
     2b8:	fc040793          	addi	a5,s0,-64
     2bc:	853e                	mv	a0,a5
     2be:	00007097          	auipc	ra,0x7
     2c2:	56a080e7          	jalr	1386(ra) # 7828 <pipe>
     2c6:	87aa                	mv	a5,a0
     2c8:	0007df63          	bgez	a5,2e6 <copyout+0xf6>
      printf("pipe() failed\n");
     2cc:	00008517          	auipc	a0,0x8
     2d0:	e5450513          	addi	a0,a0,-428 # 8120 <malloc+0x1e8>
     2d4:	00008097          	auipc	ra,0x8
     2d8:	a72080e7          	jalr	-1422(ra) # 7d46 <printf>
      exit(1);
     2dc:	4505                	li	a0,1
     2de:	00007097          	auipc	ra,0x7
     2e2:	53a080e7          	jalr	1338(ra) # 7818 <exit>
    }
    n = write(fds[1], "x", 1);
     2e6:	fc442783          	lw	a5,-60(s0)
     2ea:	4605                	li	a2,1
     2ec:	00008597          	auipc	a1,0x8
     2f0:	ec458593          	addi	a1,a1,-316 # 81b0 <malloc+0x278>
     2f4:	853e                	mv	a0,a5
     2f6:	00007097          	auipc	ra,0x7
     2fa:	542080e7          	jalr	1346(ra) # 7838 <write>
     2fe:	87aa                	mv	a5,a0
     300:	fcf42c23          	sw	a5,-40(s0)
    if(n != 1){
     304:	fd842783          	lw	a5,-40(s0)
     308:	0007871b          	sext.w	a4,a5
     30c:	4785                	li	a5,1
     30e:	00f70f63          	beq	a4,a5,32c <copyout+0x13c>
      printf("pipe write failed\n");
     312:	00008517          	auipc	a0,0x8
     316:	ea650513          	addi	a0,a0,-346 # 81b8 <malloc+0x280>
     31a:	00008097          	auipc	ra,0x8
     31e:	a2c080e7          	jalr	-1492(ra) # 7d46 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00007097          	auipc	ra,0x7
     328:	4f4080e7          	jalr	1268(ra) # 7818 <exit>
    }
    n = read(fds[0], (void*)addr, 8192);
     32c:	fc042783          	lw	a5,-64(s0)
     330:	fe043703          	ld	a4,-32(s0)
     334:	6609                	lui	a2,0x2
     336:	85ba                	mv	a1,a4
     338:	853e                	mv	a0,a5
     33a:	00007097          	auipc	ra,0x7
     33e:	4f6080e7          	jalr	1270(ra) # 7830 <read>
     342:	87aa                	mv	a5,a0
     344:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     348:	fd842783          	lw	a5,-40(s0)
     34c:	2781                	sext.w	a5,a5
     34e:	02f05463          	blez	a5,376 <copyout+0x186>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     352:	fd842783          	lw	a5,-40(s0)
     356:	863e                	mv	a2,a5
     358:	fe043583          	ld	a1,-32(s0)
     35c:	00008517          	auipc	a0,0x8
     360:	e7450513          	addi	a0,a0,-396 # 81d0 <malloc+0x298>
     364:	00008097          	auipc	ra,0x8
     368:	9e2080e7          	jalr	-1566(ra) # 7d46 <printf>
      exit(1);
     36c:	4505                	li	a0,1
     36e:	00007097          	auipc	ra,0x7
     372:	4aa080e7          	jalr	1194(ra) # 7818 <exit>
    }
    close(fds[0]);
     376:	fc042783          	lw	a5,-64(s0)
     37a:	853e                	mv	a0,a5
     37c:	00007097          	auipc	ra,0x7
     380:	4c4080e7          	jalr	1220(ra) # 7840 <close>
    close(fds[1]);
     384:	fc442783          	lw	a5,-60(s0)
     388:	853e                	mv	a0,a5
     38a:	00007097          	auipc	ra,0x7
     38e:	4b6080e7          	jalr	1206(ra) # 7840 <close>
  for(int ai = 0; ai < 2; ai++){
     392:	fec42783          	lw	a5,-20(s0)
     396:	2785                	addiw	a5,a5,1
     398:	fef42623          	sw	a5,-20(s0)
     39c:	fec42783          	lw	a5,-20(s0)
     3a0:	0007871b          	sext.w	a4,a5
     3a4:	4785                	li	a5,1
     3a6:	e6e7d5e3          	bge	a5,a4,210 <copyout+0x20>
  }
}
     3aa:	0001                	nop
     3ac:	0001                	nop
     3ae:	60a6                	ld	ra,72(sp)
     3b0:	6406                	ld	s0,64(sp)
     3b2:	6161                	addi	sp,sp,80
     3b4:	8082                	ret

00000000000003b6 <copyinstr1>:

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
     3b6:	715d                	addi	sp,sp,-80
     3b8:	e486                	sd	ra,72(sp)
     3ba:	e0a2                	sd	s0,64(sp)
     3bc:	0880                	addi	s0,sp,80
     3be:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     3c2:	4785                	li	a5,1
     3c4:	07fe                	slli	a5,a5,0x1f
     3c6:	fcf43423          	sd	a5,-56(s0)
     3ca:	57fd                	li	a5,-1
     3cc:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     3d0:	fe042623          	sw	zero,-20(s0)
     3d4:	a09d                	j	43a <copyinstr1+0x84>
    uint64 addr = addrs[ai];
     3d6:	fec42783          	lw	a5,-20(s0)
     3da:	078e                	slli	a5,a5,0x3
     3dc:	ff040713          	addi	a4,s0,-16
     3e0:	97ba                	add	a5,a5,a4
     3e2:	fd87b783          	ld	a5,-40(a5)
     3e6:	fef43023          	sd	a5,-32(s0)

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
     3ea:	fe043783          	ld	a5,-32(s0)
     3ee:	20100593          	li	a1,513
     3f2:	853e                	mv	a0,a5
     3f4:	00007097          	auipc	ra,0x7
     3f8:	464080e7          	jalr	1124(ra) # 7858 <open>
     3fc:	87aa                	mv	a5,a0
     3fe:	fcf42e23          	sw	a5,-36(s0)
    if(fd >= 0){
     402:	fdc42783          	lw	a5,-36(s0)
     406:	2781                	sext.w	a5,a5
     408:	0207c463          	bltz	a5,430 <copyinstr1+0x7a>
      printf("open(%p) returned %d, not -1\n", addr, fd);
     40c:	fdc42783          	lw	a5,-36(s0)
     410:	863e                	mv	a2,a5
     412:	fe043583          	ld	a1,-32(s0)
     416:	00008517          	auipc	a0,0x8
     41a:	dea50513          	addi	a0,a0,-534 # 8200 <malloc+0x2c8>
     41e:	00008097          	auipc	ra,0x8
     422:	928080e7          	jalr	-1752(ra) # 7d46 <printf>
      exit(1);
     426:	4505                	li	a0,1
     428:	00007097          	auipc	ra,0x7
     42c:	3f0080e7          	jalr	1008(ra) # 7818 <exit>
  for(int ai = 0; ai < 2; ai++){
     430:	fec42783          	lw	a5,-20(s0)
     434:	2785                	addiw	a5,a5,1
     436:	fef42623          	sw	a5,-20(s0)
     43a:	fec42783          	lw	a5,-20(s0)
     43e:	0007871b          	sext.w	a4,a5
     442:	4785                	li	a5,1
     444:	f8e7d9e3          	bge	a5,a4,3d6 <copyinstr1+0x20>
    }
  }
}
     448:	0001                	nop
     44a:	0001                	nop
     44c:	60a6                	ld	ra,72(sp)
     44e:	6406                	ld	s0,64(sp)
     450:	6161                	addi	sp,sp,80
     452:	8082                	ret

0000000000000454 <copyinstr2>:
// what if a string system call argument is exactly the size
// of the kernel buffer it is copied into, so that the null
// would fall just beyond the end of the kernel buffer?
void
copyinstr2(char *s)
{
     454:	7151                	addi	sp,sp,-240
     456:	f586                	sd	ra,232(sp)
     458:	f1a2                	sd	s0,224(sp)
     45a:	1980                	addi	s0,sp,240
     45c:	f0a43c23          	sd	a0,-232(s0)
  char b[MAXPATH+1];

  for(int i = 0; i < MAXPATH; i++)
     460:	fe042623          	sw	zero,-20(s0)
     464:	a839                	j	482 <copyinstr2+0x2e>
    b[i] = 'x';
     466:	fec42783          	lw	a5,-20(s0)
     46a:	ff040713          	addi	a4,s0,-16
     46e:	97ba                	add	a5,a5,a4
     470:	07800713          	li	a4,120
     474:	f6e78423          	sb	a4,-152(a5)
  for(int i = 0; i < MAXPATH; i++)
     478:	fec42783          	lw	a5,-20(s0)
     47c:	2785                	addiw	a5,a5,1
     47e:	fef42623          	sw	a5,-20(s0)
     482:	fec42783          	lw	a5,-20(s0)
     486:	0007871b          	sext.w	a4,a5
     48a:	07f00793          	li	a5,127
     48e:	fce7dce3          	bge	a5,a4,466 <copyinstr2+0x12>
  b[MAXPATH] = '\0';
     492:	fc040c23          	sb	zero,-40(s0)

  int ret = unlink(b);
     496:	f5840793          	addi	a5,s0,-168
     49a:	853e                	mv	a0,a5
     49c:	00007097          	auipc	ra,0x7
     4a0:	3cc080e7          	jalr	972(ra) # 7868 <unlink>
     4a4:	87aa                	mv	a5,a0
     4a6:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     4aa:	fe442783          	lw	a5,-28(s0)
     4ae:	0007871b          	sext.w	a4,a5
     4b2:	57fd                	li	a5,-1
     4b4:	02f70563          	beq	a4,a5,4de <copyinstr2+0x8a>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     4b8:	fe442703          	lw	a4,-28(s0)
     4bc:	f5840793          	addi	a5,s0,-168
     4c0:	863a                	mv	a2,a4
     4c2:	85be                	mv	a1,a5
     4c4:	00008517          	auipc	a0,0x8
     4c8:	d5c50513          	addi	a0,a0,-676 # 8220 <malloc+0x2e8>
     4cc:	00008097          	auipc	ra,0x8
     4d0:	87a080e7          	jalr	-1926(ra) # 7d46 <printf>
    exit(1);
     4d4:	4505                	li	a0,1
     4d6:	00007097          	auipc	ra,0x7
     4da:	342080e7          	jalr	834(ra) # 7818 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     4de:	f5840793          	addi	a5,s0,-168
     4e2:	20100593          	li	a1,513
     4e6:	853e                	mv	a0,a5
     4e8:	00007097          	auipc	ra,0x7
     4ec:	370080e7          	jalr	880(ra) # 7858 <open>
     4f0:	87aa                	mv	a5,a0
     4f2:	fef42023          	sw	a5,-32(s0)
  if(fd != -1){
     4f6:	fe042783          	lw	a5,-32(s0)
     4fa:	0007871b          	sext.w	a4,a5
     4fe:	57fd                	li	a5,-1
     500:	02f70563          	beq	a4,a5,52a <copyinstr2+0xd6>
    printf("open(%s) returned %d, not -1\n", b, fd);
     504:	fe042703          	lw	a4,-32(s0)
     508:	f5840793          	addi	a5,s0,-168
     50c:	863a                	mv	a2,a4
     50e:	85be                	mv	a1,a5
     510:	00008517          	auipc	a0,0x8
     514:	d3050513          	addi	a0,a0,-720 # 8240 <malloc+0x308>
     518:	00008097          	auipc	ra,0x8
     51c:	82e080e7          	jalr	-2002(ra) # 7d46 <printf>
    exit(1);
     520:	4505                	li	a0,1
     522:	00007097          	auipc	ra,0x7
     526:	2f6080e7          	jalr	758(ra) # 7818 <exit>
  }

  ret = link(b, b);
     52a:	f5840713          	addi	a4,s0,-168
     52e:	f5840793          	addi	a5,s0,-168
     532:	85ba                	mv	a1,a4
     534:	853e                	mv	a0,a5
     536:	00007097          	auipc	ra,0x7
     53a:	342080e7          	jalr	834(ra) # 7878 <link>
     53e:	87aa                	mv	a5,a0
     540:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     544:	fe442783          	lw	a5,-28(s0)
     548:	0007871b          	sext.w	a4,a5
     54c:	57fd                	li	a5,-1
     54e:	02f70763          	beq	a4,a5,57c <copyinstr2+0x128>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     552:	fe442683          	lw	a3,-28(s0)
     556:	f5840713          	addi	a4,s0,-168
     55a:	f5840793          	addi	a5,s0,-168
     55e:	863a                	mv	a2,a4
     560:	85be                	mv	a1,a5
     562:	00008517          	auipc	a0,0x8
     566:	cfe50513          	addi	a0,a0,-770 # 8260 <malloc+0x328>
     56a:	00007097          	auipc	ra,0x7
     56e:	7dc080e7          	jalr	2012(ra) # 7d46 <printf>
    exit(1);
     572:	4505                	li	a0,1
     574:	00007097          	auipc	ra,0x7
     578:	2a4080e7          	jalr	676(ra) # 7818 <exit>
  }

  char *args[] = { "xx", 0 };
     57c:	00008797          	auipc	a5,0x8
     580:	d0c78793          	addi	a5,a5,-756 # 8288 <malloc+0x350>
     584:	f4f43423          	sd	a5,-184(s0)
     588:	f4043823          	sd	zero,-176(s0)
  ret = exec(b, args);
     58c:	f4840713          	addi	a4,s0,-184
     590:	f5840793          	addi	a5,s0,-168
     594:	85ba                	mv	a1,a4
     596:	853e                	mv	a0,a5
     598:	00007097          	auipc	ra,0x7
     59c:	2b8080e7          	jalr	696(ra) # 7850 <exec>
     5a0:	87aa                	mv	a5,a0
     5a2:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     5a6:	fe442783          	lw	a5,-28(s0)
     5aa:	0007871b          	sext.w	a4,a5
     5ae:	57fd                	li	a5,-1
     5b0:	02f70563          	beq	a4,a5,5da <copyinstr2+0x186>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     5b4:	fe042703          	lw	a4,-32(s0)
     5b8:	f5840793          	addi	a5,s0,-168
     5bc:	863a                	mv	a2,a4
     5be:	85be                	mv	a1,a5
     5c0:	00008517          	auipc	a0,0x8
     5c4:	cd050513          	addi	a0,a0,-816 # 8290 <malloc+0x358>
     5c8:	00007097          	auipc	ra,0x7
     5cc:	77e080e7          	jalr	1918(ra) # 7d46 <printf>
    exit(1);
     5d0:	4505                	li	a0,1
     5d2:	00007097          	auipc	ra,0x7
     5d6:	246080e7          	jalr	582(ra) # 7818 <exit>
  }

  int pid = fork();
     5da:	00007097          	auipc	ra,0x7
     5de:	236080e7          	jalr	566(ra) # 7810 <fork>
     5e2:	87aa                	mv	a5,a0
     5e4:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
     5e8:	fdc42783          	lw	a5,-36(s0)
     5ec:	2781                	sext.w	a5,a5
     5ee:	0007df63          	bgez	a5,60c <copyinstr2+0x1b8>
    printf("fork failed\n");
     5f2:	00008517          	auipc	a0,0x8
     5f6:	cbe50513          	addi	a0,a0,-834 # 82b0 <malloc+0x378>
     5fa:	00007097          	auipc	ra,0x7
     5fe:	74c080e7          	jalr	1868(ra) # 7d46 <printf>
    exit(1);
     602:	4505                	li	a0,1
     604:	00007097          	auipc	ra,0x7
     608:	214080e7          	jalr	532(ra) # 7818 <exit>
  }
  if(pid == 0){
     60c:	fdc42783          	lw	a5,-36(s0)
     610:	2781                	sext.w	a5,a5
     612:	efd5                	bnez	a5,6ce <copyinstr2+0x27a>
    static char big[PGSIZE+1];
    for(int i = 0; i < PGSIZE; i++)
     614:	fe042423          	sw	zero,-24(s0)
     618:	a00d                	j	63a <copyinstr2+0x1e6>
      big[i] = 'x';
     61a:	00010717          	auipc	a4,0x10
     61e:	54670713          	addi	a4,a4,1350 # 10b60 <big.1266>
     622:	fe842783          	lw	a5,-24(s0)
     626:	97ba                	add	a5,a5,a4
     628:	07800713          	li	a4,120
     62c:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
     630:	fe842783          	lw	a5,-24(s0)
     634:	2785                	addiw	a5,a5,1
     636:	fef42423          	sw	a5,-24(s0)
     63a:	fe842783          	lw	a5,-24(s0)
     63e:	0007871b          	sext.w	a4,a5
     642:	6785                	lui	a5,0x1
     644:	fcf74be3          	blt	a4,a5,61a <copyinstr2+0x1c6>
    big[PGSIZE] = '\0';
     648:	00010717          	auipc	a4,0x10
     64c:	51870713          	addi	a4,a4,1304 # 10b60 <big.1266>
     650:	6785                	lui	a5,0x1
     652:	97ba                	add	a5,a5,a4
     654:	00078023          	sb	zero,0(a5) # 1000 <truncate3+0x1aa>
    char *args2[] = { big, big, big, 0 };
     658:	00008797          	auipc	a5,0x8
     65c:	cc878793          	addi	a5,a5,-824 # 8320 <malloc+0x3e8>
     660:	6390                	ld	a2,0(a5)
     662:	6794                	ld	a3,8(a5)
     664:	6b98                	ld	a4,16(a5)
     666:	6f9c                	ld	a5,24(a5)
     668:	f2c43023          	sd	a2,-224(s0)
     66c:	f2d43423          	sd	a3,-216(s0)
     670:	f2e43823          	sd	a4,-208(s0)
     674:	f2f43c23          	sd	a5,-200(s0)
    ret = exec("echo", args2);
     678:	f2040793          	addi	a5,s0,-224
     67c:	85be                	mv	a1,a5
     67e:	00008517          	auipc	a0,0x8
     682:	c4250513          	addi	a0,a0,-958 # 82c0 <malloc+0x388>
     686:	00007097          	auipc	ra,0x7
     68a:	1ca080e7          	jalr	458(ra) # 7850 <exec>
     68e:	87aa                	mv	a5,a0
     690:	fef42223          	sw	a5,-28(s0)
    if(ret != -1){
     694:	fe442783          	lw	a5,-28(s0)
     698:	0007871b          	sext.w	a4,a5
     69c:	57fd                	li	a5,-1
     69e:	02f70263          	beq	a4,a5,6c2 <copyinstr2+0x26e>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
     6a2:	fe042783          	lw	a5,-32(s0)
     6a6:	85be                	mv	a1,a5
     6a8:	00008517          	auipc	a0,0x8
     6ac:	c2050513          	addi	a0,a0,-992 # 82c8 <malloc+0x390>
     6b0:	00007097          	auipc	ra,0x7
     6b4:	696080e7          	jalr	1686(ra) # 7d46 <printf>
      exit(1);
     6b8:	4505                	li	a0,1
     6ba:	00007097          	auipc	ra,0x7
     6be:	15e080e7          	jalr	350(ra) # 7818 <exit>
    }
    exit(747); // OK
     6c2:	2eb00513          	li	a0,747
     6c6:	00007097          	auipc	ra,0x7
     6ca:	152080e7          	jalr	338(ra) # 7818 <exit>
  }

  int st = 0;
     6ce:	f4042223          	sw	zero,-188(s0)
  wait(&st);
     6d2:	f4440793          	addi	a5,s0,-188
     6d6:	853e                	mv	a0,a5
     6d8:	00007097          	auipc	ra,0x7
     6dc:	148080e7          	jalr	328(ra) # 7820 <wait>
  if(st != 747){
     6e0:	f4442783          	lw	a5,-188(s0)
     6e4:	873e                	mv	a4,a5
     6e6:	2eb00793          	li	a5,747
     6ea:	00f70f63          	beq	a4,a5,708 <copyinstr2+0x2b4>
    printf("exec(echo, BIG) succeeded, should have failed\n");
     6ee:	00008517          	auipc	a0,0x8
     6f2:	c0250513          	addi	a0,a0,-1022 # 82f0 <malloc+0x3b8>
     6f6:	00007097          	auipc	ra,0x7
     6fa:	650080e7          	jalr	1616(ra) # 7d46 <printf>
    exit(1);
     6fe:	4505                	li	a0,1
     700:	00007097          	auipc	ra,0x7
     704:	118080e7          	jalr	280(ra) # 7818 <exit>
  }
}
     708:	0001                	nop
     70a:	70ae                	ld	ra,232(sp)
     70c:	740e                	ld	s0,224(sp)
     70e:	616d                	addi	sp,sp,240
     710:	8082                	ret

0000000000000712 <copyinstr3>:

// what if a string argument crosses over the end of last user page?
void
copyinstr3(char *s)
{
     712:	715d                	addi	sp,sp,-80
     714:	e486                	sd	ra,72(sp)
     716:	e0a2                	sd	s0,64(sp)
     718:	0880                	addi	s0,sp,80
     71a:	faa43c23          	sd	a0,-72(s0)
  sbrk(8192);
     71e:	6509                	lui	a0,0x2
     720:	00007097          	auipc	ra,0x7
     724:	180080e7          	jalr	384(ra) # 78a0 <sbrk>
  uint64 top = (uint64) sbrk(0);
     728:	4501                	li	a0,0
     72a:	00007097          	auipc	ra,0x7
     72e:	176080e7          	jalr	374(ra) # 78a0 <sbrk>
     732:	87aa                	mv	a5,a0
     734:	fef43423          	sd	a5,-24(s0)
  if((top % PGSIZE) != 0){
     738:	fe843703          	ld	a4,-24(s0)
     73c:	6785                	lui	a5,0x1
     73e:	17fd                	addi	a5,a5,-1
     740:	8ff9                	and	a5,a5,a4
     742:	c39d                	beqz	a5,768 <copyinstr3+0x56>
    sbrk(PGSIZE - (top % PGSIZE));
     744:	fe843783          	ld	a5,-24(s0)
     748:	2781                	sext.w	a5,a5
     74a:	873e                	mv	a4,a5
     74c:	6785                	lui	a5,0x1
     74e:	17fd                	addi	a5,a5,-1
     750:	8ff9                	and	a5,a5,a4
     752:	2781                	sext.w	a5,a5
     754:	6705                	lui	a4,0x1
     756:	40f707bb          	subw	a5,a4,a5
     75a:	2781                	sext.w	a5,a5
     75c:	2781                	sext.w	a5,a5
     75e:	853e                	mv	a0,a5
     760:	00007097          	auipc	ra,0x7
     764:	140080e7          	jalr	320(ra) # 78a0 <sbrk>
  }
  top = (uint64) sbrk(0);
     768:	4501                	li	a0,0
     76a:	00007097          	auipc	ra,0x7
     76e:	136080e7          	jalr	310(ra) # 78a0 <sbrk>
     772:	87aa                	mv	a5,a0
     774:	fef43423          	sd	a5,-24(s0)
  if(top % PGSIZE){
     778:	fe843703          	ld	a4,-24(s0)
     77c:	6785                	lui	a5,0x1
     77e:	17fd                	addi	a5,a5,-1
     780:	8ff9                	and	a5,a5,a4
     782:	cf91                	beqz	a5,79e <copyinstr3+0x8c>
    printf("oops\n");
     784:	00008517          	auipc	a0,0x8
     788:	bbc50513          	addi	a0,a0,-1092 # 8340 <malloc+0x408>
     78c:	00007097          	auipc	ra,0x7
     790:	5ba080e7          	jalr	1466(ra) # 7d46 <printf>
    exit(1);
     794:	4505                	li	a0,1
     796:	00007097          	auipc	ra,0x7
     79a:	082080e7          	jalr	130(ra) # 7818 <exit>
  }

  char *b = (char *) (top - 1);
     79e:	fe843783          	ld	a5,-24(s0)
     7a2:	17fd                	addi	a5,a5,-1
     7a4:	fef43023          	sd	a5,-32(s0)
  *b = 'x';
     7a8:	fe043783          	ld	a5,-32(s0)
     7ac:	07800713          	li	a4,120
     7b0:	00e78023          	sb	a4,0(a5) # 1000 <truncate3+0x1aa>

  int ret = unlink(b);
     7b4:	fe043503          	ld	a0,-32(s0)
     7b8:	00007097          	auipc	ra,0x7
     7bc:	0b0080e7          	jalr	176(ra) # 7868 <unlink>
     7c0:	87aa                	mv	a5,a0
     7c2:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     7c6:	fdc42783          	lw	a5,-36(s0)
     7ca:	0007871b          	sext.w	a4,a5
     7ce:	57fd                	li	a5,-1
     7d0:	02f70463          	beq	a4,a5,7f8 <copyinstr3+0xe6>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     7d4:	fdc42783          	lw	a5,-36(s0)
     7d8:	863e                	mv	a2,a5
     7da:	fe043583          	ld	a1,-32(s0)
     7de:	00008517          	auipc	a0,0x8
     7e2:	a4250513          	addi	a0,a0,-1470 # 8220 <malloc+0x2e8>
     7e6:	00007097          	auipc	ra,0x7
     7ea:	560080e7          	jalr	1376(ra) # 7d46 <printf>
    exit(1);
     7ee:	4505                	li	a0,1
     7f0:	00007097          	auipc	ra,0x7
     7f4:	028080e7          	jalr	40(ra) # 7818 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     7f8:	20100593          	li	a1,513
     7fc:	fe043503          	ld	a0,-32(s0)
     800:	00007097          	auipc	ra,0x7
     804:	058080e7          	jalr	88(ra) # 7858 <open>
     808:	87aa                	mv	a5,a0
     80a:	fcf42c23          	sw	a5,-40(s0)
  if(fd != -1){
     80e:	fd842783          	lw	a5,-40(s0)
     812:	0007871b          	sext.w	a4,a5
     816:	57fd                	li	a5,-1
     818:	02f70463          	beq	a4,a5,840 <copyinstr3+0x12e>
    printf("open(%s) returned %d, not -1\n", b, fd);
     81c:	fd842783          	lw	a5,-40(s0)
     820:	863e                	mv	a2,a5
     822:	fe043583          	ld	a1,-32(s0)
     826:	00008517          	auipc	a0,0x8
     82a:	a1a50513          	addi	a0,a0,-1510 # 8240 <malloc+0x308>
     82e:	00007097          	auipc	ra,0x7
     832:	518080e7          	jalr	1304(ra) # 7d46 <printf>
    exit(1);
     836:	4505                	li	a0,1
     838:	00007097          	auipc	ra,0x7
     83c:	fe0080e7          	jalr	-32(ra) # 7818 <exit>
  }

  ret = link(b, b);
     840:	fe043583          	ld	a1,-32(s0)
     844:	fe043503          	ld	a0,-32(s0)
     848:	00007097          	auipc	ra,0x7
     84c:	030080e7          	jalr	48(ra) # 7878 <link>
     850:	87aa                	mv	a5,a0
     852:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     856:	fdc42783          	lw	a5,-36(s0)
     85a:	0007871b          	sext.w	a4,a5
     85e:	57fd                	li	a5,-1
     860:	02f70663          	beq	a4,a5,88c <copyinstr3+0x17a>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     864:	fdc42783          	lw	a5,-36(s0)
     868:	86be                	mv	a3,a5
     86a:	fe043603          	ld	a2,-32(s0)
     86e:	fe043583          	ld	a1,-32(s0)
     872:	00008517          	auipc	a0,0x8
     876:	9ee50513          	addi	a0,a0,-1554 # 8260 <malloc+0x328>
     87a:	00007097          	auipc	ra,0x7
     87e:	4cc080e7          	jalr	1228(ra) # 7d46 <printf>
    exit(1);
     882:	4505                	li	a0,1
     884:	00007097          	auipc	ra,0x7
     888:	f94080e7          	jalr	-108(ra) # 7818 <exit>
  }

  char *args[] = { "xx", 0 };
     88c:	00008797          	auipc	a5,0x8
     890:	9fc78793          	addi	a5,a5,-1540 # 8288 <malloc+0x350>
     894:	fcf43423          	sd	a5,-56(s0)
     898:	fc043823          	sd	zero,-48(s0)
  ret = exec(b, args);
     89c:	fc840793          	addi	a5,s0,-56
     8a0:	85be                	mv	a1,a5
     8a2:	fe043503          	ld	a0,-32(s0)
     8a6:	00007097          	auipc	ra,0x7
     8aa:	faa080e7          	jalr	-86(ra) # 7850 <exec>
     8ae:	87aa                	mv	a5,a0
     8b0:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     8b4:	fdc42783          	lw	a5,-36(s0)
     8b8:	0007871b          	sext.w	a4,a5
     8bc:	57fd                	li	a5,-1
     8be:	02f70463          	beq	a4,a5,8e6 <copyinstr3+0x1d4>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     8c2:	fd842783          	lw	a5,-40(s0)
     8c6:	863e                	mv	a2,a5
     8c8:	fe043583          	ld	a1,-32(s0)
     8cc:	00008517          	auipc	a0,0x8
     8d0:	9c450513          	addi	a0,a0,-1596 # 8290 <malloc+0x358>
     8d4:	00007097          	auipc	ra,0x7
     8d8:	472080e7          	jalr	1138(ra) # 7d46 <printf>
    exit(1);
     8dc:	4505                	li	a0,1
     8de:	00007097          	auipc	ra,0x7
     8e2:	f3a080e7          	jalr	-198(ra) # 7818 <exit>
  }
}
     8e6:	0001                	nop
     8e8:	60a6                	ld	ra,72(sp)
     8ea:	6406                	ld	s0,64(sp)
     8ec:	6161                	addi	sp,sp,80
     8ee:	8082                	ret

00000000000008f0 <rwsbrk>:

// See if the kernel refuses to read/write user memory that the
// application doesn't have anymore, because it returned it.
void
rwsbrk()
{
     8f0:	1101                	addi	sp,sp,-32
     8f2:	ec06                	sd	ra,24(sp)
     8f4:	e822                	sd	s0,16(sp)
     8f6:	1000                	addi	s0,sp,32
  int fd, n;

  uint64 a = (uint64) sbrk(8192);
     8f8:	6509                	lui	a0,0x2
     8fa:	00007097          	auipc	ra,0x7
     8fe:	fa6080e7          	jalr	-90(ra) # 78a0 <sbrk>
     902:	87aa                	mv	a5,a0
     904:	fef43423          	sd	a5,-24(s0)

  if(a == 0xffffffffffffffffLL) {
     908:	fe843703          	ld	a4,-24(s0)
     90c:	57fd                	li	a5,-1
     90e:	00f71f63          	bne	a4,a5,92c <rwsbrk+0x3c>
    printf("sbrk(rwsbrk) failed\n");
     912:	00008517          	auipc	a0,0x8
     916:	a3650513          	addi	a0,a0,-1482 # 8348 <malloc+0x410>
     91a:	00007097          	auipc	ra,0x7
     91e:	42c080e7          	jalr	1068(ra) # 7d46 <printf>
    exit(1);
     922:	4505                	li	a0,1
     924:	00007097          	auipc	ra,0x7
     928:	ef4080e7          	jalr	-268(ra) # 7818 <exit>
  }

  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
     92c:	7579                	lui	a0,0xffffe
     92e:	00007097          	auipc	ra,0x7
     932:	f72080e7          	jalr	-142(ra) # 78a0 <sbrk>
     936:	872a                	mv	a4,a0
     938:	57fd                	li	a5,-1
     93a:	00f71f63          	bne	a4,a5,958 <rwsbrk+0x68>
    printf("sbrk(rwsbrk) shrink failed\n");
     93e:	00008517          	auipc	a0,0x8
     942:	a2250513          	addi	a0,a0,-1502 # 8360 <malloc+0x428>
     946:	00007097          	auipc	ra,0x7
     94a:	400080e7          	jalr	1024(ra) # 7d46 <printf>
    exit(1);
     94e:	4505                	li	a0,1
     950:	00007097          	auipc	ra,0x7
     954:	ec8080e7          	jalr	-312(ra) # 7818 <exit>
  }

  fd = open("rwsbrk", O_CREATE|O_WRONLY);
     958:	20100593          	li	a1,513
     95c:	00008517          	auipc	a0,0x8
     960:	a2450513          	addi	a0,a0,-1500 # 8380 <malloc+0x448>
     964:	00007097          	auipc	ra,0x7
     968:	ef4080e7          	jalr	-268(ra) # 7858 <open>
     96c:	87aa                	mv	a5,a0
     96e:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     972:	fe442783          	lw	a5,-28(s0)
     976:	2781                	sext.w	a5,a5
     978:	0007df63          	bgez	a5,996 <rwsbrk+0xa6>
    printf("open(rwsbrk) failed\n");
     97c:	00008517          	auipc	a0,0x8
     980:	a0c50513          	addi	a0,a0,-1524 # 8388 <malloc+0x450>
     984:	00007097          	auipc	ra,0x7
     988:	3c2080e7          	jalr	962(ra) # 7d46 <printf>
    exit(1);
     98c:	4505                	li	a0,1
     98e:	00007097          	auipc	ra,0x7
     992:	e8a080e7          	jalr	-374(ra) # 7818 <exit>
  }
  n = write(fd, (void*)(a+4096), 1024);
     996:	fe843703          	ld	a4,-24(s0)
     99a:	6785                	lui	a5,0x1
     99c:	97ba                	add	a5,a5,a4
     99e:	873e                	mv	a4,a5
     9a0:	fe442783          	lw	a5,-28(s0)
     9a4:	40000613          	li	a2,1024
     9a8:	85ba                	mv	a1,a4
     9aa:	853e                	mv	a0,a5
     9ac:	00007097          	auipc	ra,0x7
     9b0:	e8c080e7          	jalr	-372(ra) # 7838 <write>
     9b4:	87aa                	mv	a5,a0
     9b6:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     9ba:	fe042783          	lw	a5,-32(s0)
     9be:	2781                	sext.w	a5,a5
     9c0:	0207c763          	bltz	a5,9ee <rwsbrk+0xfe>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
     9c4:	fe843703          	ld	a4,-24(s0)
     9c8:	6785                	lui	a5,0x1
     9ca:	97ba                	add	a5,a5,a4
     9cc:	fe042703          	lw	a4,-32(s0)
     9d0:	863a                	mv	a2,a4
     9d2:	85be                	mv	a1,a5
     9d4:	00008517          	auipc	a0,0x8
     9d8:	9cc50513          	addi	a0,a0,-1588 # 83a0 <malloc+0x468>
     9dc:	00007097          	auipc	ra,0x7
     9e0:	36a080e7          	jalr	874(ra) # 7d46 <printf>
    exit(1);
     9e4:	4505                	li	a0,1
     9e6:	00007097          	auipc	ra,0x7
     9ea:	e32080e7          	jalr	-462(ra) # 7818 <exit>
  }
  close(fd);
     9ee:	fe442783          	lw	a5,-28(s0)
     9f2:	853e                	mv	a0,a5
     9f4:	00007097          	auipc	ra,0x7
     9f8:	e4c080e7          	jalr	-436(ra) # 7840 <close>
  unlink("rwsbrk");
     9fc:	00008517          	auipc	a0,0x8
     a00:	98450513          	addi	a0,a0,-1660 # 8380 <malloc+0x448>
     a04:	00007097          	auipc	ra,0x7
     a08:	e64080e7          	jalr	-412(ra) # 7868 <unlink>

  fd = open("README", O_RDONLY);
     a0c:	4581                	li	a1,0
     a0e:	00007517          	auipc	a0,0x7
     a12:	75250513          	addi	a0,a0,1874 # 8160 <malloc+0x228>
     a16:	00007097          	auipc	ra,0x7
     a1a:	e42080e7          	jalr	-446(ra) # 7858 <open>
     a1e:	87aa                	mv	a5,a0
     a20:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     a24:	fe442783          	lw	a5,-28(s0)
     a28:	2781                	sext.w	a5,a5
     a2a:	0007df63          	bgez	a5,a48 <rwsbrk+0x158>
    printf("open(rwsbrk) failed\n");
     a2e:	00008517          	auipc	a0,0x8
     a32:	95a50513          	addi	a0,a0,-1702 # 8388 <malloc+0x450>
     a36:	00007097          	auipc	ra,0x7
     a3a:	310080e7          	jalr	784(ra) # 7d46 <printf>
    exit(1);
     a3e:	4505                	li	a0,1
     a40:	00007097          	auipc	ra,0x7
     a44:	dd8080e7          	jalr	-552(ra) # 7818 <exit>
  }
  n = read(fd, (void*)(a+4096), 10);
     a48:	fe843703          	ld	a4,-24(s0)
     a4c:	6785                	lui	a5,0x1
     a4e:	97ba                	add	a5,a5,a4
     a50:	873e                	mv	a4,a5
     a52:	fe442783          	lw	a5,-28(s0)
     a56:	4629                	li	a2,10
     a58:	85ba                	mv	a1,a4
     a5a:	853e                	mv	a0,a5
     a5c:	00007097          	auipc	ra,0x7
     a60:	dd4080e7          	jalr	-556(ra) # 7830 <read>
     a64:	87aa                	mv	a5,a0
     a66:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     a6a:	fe042783          	lw	a5,-32(s0)
     a6e:	2781                	sext.w	a5,a5
     a70:	0207c763          	bltz	a5,a9e <rwsbrk+0x1ae>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
     a74:	fe843703          	ld	a4,-24(s0)
     a78:	6785                	lui	a5,0x1
     a7a:	97ba                	add	a5,a5,a4
     a7c:	fe042703          	lw	a4,-32(s0)
     a80:	863a                	mv	a2,a4
     a82:	85be                	mv	a1,a5
     a84:	00008517          	auipc	a0,0x8
     a88:	94c50513          	addi	a0,a0,-1716 # 83d0 <malloc+0x498>
     a8c:	00007097          	auipc	ra,0x7
     a90:	2ba080e7          	jalr	698(ra) # 7d46 <printf>
    exit(1);
     a94:	4505                	li	a0,1
     a96:	00007097          	auipc	ra,0x7
     a9a:	d82080e7          	jalr	-638(ra) # 7818 <exit>
  }
  close(fd);
     a9e:	fe442783          	lw	a5,-28(s0)
     aa2:	853e                	mv	a0,a5
     aa4:	00007097          	auipc	ra,0x7
     aa8:	d9c080e7          	jalr	-612(ra) # 7840 <close>

  exit(0);
     aac:	4501                	li	a0,0
     aae:	00007097          	auipc	ra,0x7
     ab2:	d6a080e7          	jalr	-662(ra) # 7818 <exit>

0000000000000ab6 <truncate1>:
}

// test O_TRUNC.
void
truncate1(char *s)
{
     ab6:	715d                	addi	sp,sp,-80
     ab8:	e486                	sd	ra,72(sp)
     aba:	e0a2                	sd	s0,64(sp)
     abc:	0880                	addi	s0,sp,80
     abe:	faa43c23          	sd	a0,-72(s0)
  char buf[32];

  unlink("truncfile");
     ac2:	00008517          	auipc	a0,0x8
     ac6:	93650513          	addi	a0,a0,-1738 # 83f8 <malloc+0x4c0>
     aca:	00007097          	auipc	ra,0x7
     ace:	d9e080e7          	jalr	-610(ra) # 7868 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     ad2:	60100593          	li	a1,1537
     ad6:	00008517          	auipc	a0,0x8
     ada:	92250513          	addi	a0,a0,-1758 # 83f8 <malloc+0x4c0>
     ade:	00007097          	auipc	ra,0x7
     ae2:	d7a080e7          	jalr	-646(ra) # 7858 <open>
     ae6:	87aa                	mv	a5,a0
     ae8:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     aec:	fec42783          	lw	a5,-20(s0)
     af0:	4611                	li	a2,4
     af2:	00008597          	auipc	a1,0x8
     af6:	91658593          	addi	a1,a1,-1770 # 8408 <malloc+0x4d0>
     afa:	853e                	mv	a0,a5
     afc:	00007097          	auipc	ra,0x7
     b00:	d3c080e7          	jalr	-708(ra) # 7838 <write>
  close(fd1);
     b04:	fec42783          	lw	a5,-20(s0)
     b08:	853e                	mv	a0,a5
     b0a:	00007097          	auipc	ra,0x7
     b0e:	d36080e7          	jalr	-714(ra) # 7840 <close>

  int fd2 = open("truncfile", O_RDONLY);
     b12:	4581                	li	a1,0
     b14:	00008517          	auipc	a0,0x8
     b18:	8e450513          	addi	a0,a0,-1820 # 83f8 <malloc+0x4c0>
     b1c:	00007097          	auipc	ra,0x7
     b20:	d3c080e7          	jalr	-708(ra) # 7858 <open>
     b24:	87aa                	mv	a5,a0
     b26:	fef42423          	sw	a5,-24(s0)
  int n = read(fd2, buf, sizeof(buf));
     b2a:	fc040713          	addi	a4,s0,-64
     b2e:	fe842783          	lw	a5,-24(s0)
     b32:	02000613          	li	a2,32
     b36:	85ba                	mv	a1,a4
     b38:	853e                	mv	a0,a5
     b3a:	00007097          	auipc	ra,0x7
     b3e:	cf6080e7          	jalr	-778(ra) # 7830 <read>
     b42:	87aa                	mv	a5,a0
     b44:	fef42223          	sw	a5,-28(s0)
  if(n != 4){
     b48:	fe442783          	lw	a5,-28(s0)
     b4c:	0007871b          	sext.w	a4,a5
     b50:	4791                	li	a5,4
     b52:	02f70463          	beq	a4,a5,b7a <truncate1+0xc4>
    printf("%s: read %d bytes, wanted 4\n", s, n);
     b56:	fe442783          	lw	a5,-28(s0)
     b5a:	863e                	mv	a2,a5
     b5c:	fb843583          	ld	a1,-72(s0)
     b60:	00008517          	auipc	a0,0x8
     b64:	8b050513          	addi	a0,a0,-1872 # 8410 <malloc+0x4d8>
     b68:	00007097          	auipc	ra,0x7
     b6c:	1de080e7          	jalr	478(ra) # 7d46 <printf>
    exit(1);
     b70:	4505                	li	a0,1
     b72:	00007097          	auipc	ra,0x7
     b76:	ca6080e7          	jalr	-858(ra) # 7818 <exit>
  }

  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     b7a:	40100593          	li	a1,1025
     b7e:	00008517          	auipc	a0,0x8
     b82:	87a50513          	addi	a0,a0,-1926 # 83f8 <malloc+0x4c0>
     b86:	00007097          	auipc	ra,0x7
     b8a:	cd2080e7          	jalr	-814(ra) # 7858 <open>
     b8e:	87aa                	mv	a5,a0
     b90:	fef42623          	sw	a5,-20(s0)

  int fd3 = open("truncfile", O_RDONLY);
     b94:	4581                	li	a1,0
     b96:	00008517          	auipc	a0,0x8
     b9a:	86250513          	addi	a0,a0,-1950 # 83f8 <malloc+0x4c0>
     b9e:	00007097          	auipc	ra,0x7
     ba2:	cba080e7          	jalr	-838(ra) # 7858 <open>
     ba6:	87aa                	mv	a5,a0
     ba8:	fef42023          	sw	a5,-32(s0)
  n = read(fd3, buf, sizeof(buf));
     bac:	fc040713          	addi	a4,s0,-64
     bb0:	fe042783          	lw	a5,-32(s0)
     bb4:	02000613          	li	a2,32
     bb8:	85ba                	mv	a1,a4
     bba:	853e                	mv	a0,a5
     bbc:	00007097          	auipc	ra,0x7
     bc0:	c74080e7          	jalr	-908(ra) # 7830 <read>
     bc4:	87aa                	mv	a5,a0
     bc6:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     bca:	fe442783          	lw	a5,-28(s0)
     bce:	2781                	sext.w	a5,a5
     bd0:	cf95                	beqz	a5,c0c <truncate1+0x156>
    printf("aaa fd3=%d\n", fd3);
     bd2:	fe042783          	lw	a5,-32(s0)
     bd6:	85be                	mv	a1,a5
     bd8:	00008517          	auipc	a0,0x8
     bdc:	85850513          	addi	a0,a0,-1960 # 8430 <malloc+0x4f8>
     be0:	00007097          	auipc	ra,0x7
     be4:	166080e7          	jalr	358(ra) # 7d46 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     be8:	fe442783          	lw	a5,-28(s0)
     bec:	863e                	mv	a2,a5
     bee:	fb843583          	ld	a1,-72(s0)
     bf2:	00008517          	auipc	a0,0x8
     bf6:	84e50513          	addi	a0,a0,-1970 # 8440 <malloc+0x508>
     bfa:	00007097          	auipc	ra,0x7
     bfe:	14c080e7          	jalr	332(ra) # 7d46 <printf>
    exit(1);
     c02:	4505                	li	a0,1
     c04:	00007097          	auipc	ra,0x7
     c08:	c14080e7          	jalr	-1004(ra) # 7818 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     c0c:	fc040713          	addi	a4,s0,-64
     c10:	fe842783          	lw	a5,-24(s0)
     c14:	02000613          	li	a2,32
     c18:	85ba                	mv	a1,a4
     c1a:	853e                	mv	a0,a5
     c1c:	00007097          	auipc	ra,0x7
     c20:	c14080e7          	jalr	-1004(ra) # 7830 <read>
     c24:	87aa                	mv	a5,a0
     c26:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     c2a:	fe442783          	lw	a5,-28(s0)
     c2e:	2781                	sext.w	a5,a5
     c30:	cf95                	beqz	a5,c6c <truncate1+0x1b6>
    printf("bbb fd2=%d\n", fd2);
     c32:	fe842783          	lw	a5,-24(s0)
     c36:	85be                	mv	a1,a5
     c38:	00008517          	auipc	a0,0x8
     c3c:	82850513          	addi	a0,a0,-2008 # 8460 <malloc+0x528>
     c40:	00007097          	auipc	ra,0x7
     c44:	106080e7          	jalr	262(ra) # 7d46 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     c48:	fe442783          	lw	a5,-28(s0)
     c4c:	863e                	mv	a2,a5
     c4e:	fb843583          	ld	a1,-72(s0)
     c52:	00007517          	auipc	a0,0x7
     c56:	7ee50513          	addi	a0,a0,2030 # 8440 <malloc+0x508>
     c5a:	00007097          	auipc	ra,0x7
     c5e:	0ec080e7          	jalr	236(ra) # 7d46 <printf>
    exit(1);
     c62:	4505                	li	a0,1
     c64:	00007097          	auipc	ra,0x7
     c68:	bb4080e7          	jalr	-1100(ra) # 7818 <exit>
  }

  write(fd1, "abcdef", 6);
     c6c:	fec42783          	lw	a5,-20(s0)
     c70:	4619                	li	a2,6
     c72:	00007597          	auipc	a1,0x7
     c76:	7fe58593          	addi	a1,a1,2046 # 8470 <malloc+0x538>
     c7a:	853e                	mv	a0,a5
     c7c:	00007097          	auipc	ra,0x7
     c80:	bbc080e7          	jalr	-1092(ra) # 7838 <write>

  n = read(fd3, buf, sizeof(buf));
     c84:	fc040713          	addi	a4,s0,-64
     c88:	fe042783          	lw	a5,-32(s0)
     c8c:	02000613          	li	a2,32
     c90:	85ba                	mv	a1,a4
     c92:	853e                	mv	a0,a5
     c94:	00007097          	auipc	ra,0x7
     c98:	b9c080e7          	jalr	-1124(ra) # 7830 <read>
     c9c:	87aa                	mv	a5,a0
     c9e:	fef42223          	sw	a5,-28(s0)
  if(n != 6){
     ca2:	fe442783          	lw	a5,-28(s0)
     ca6:	0007871b          	sext.w	a4,a5
     caa:	4799                	li	a5,6
     cac:	02f70463          	beq	a4,a5,cd4 <truncate1+0x21e>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     cb0:	fe442783          	lw	a5,-28(s0)
     cb4:	863e                	mv	a2,a5
     cb6:	fb843583          	ld	a1,-72(s0)
     cba:	00007517          	auipc	a0,0x7
     cbe:	7be50513          	addi	a0,a0,1982 # 8478 <malloc+0x540>
     cc2:	00007097          	auipc	ra,0x7
     cc6:	084080e7          	jalr	132(ra) # 7d46 <printf>
    exit(1);
     cca:	4505                	li	a0,1
     ccc:	00007097          	auipc	ra,0x7
     cd0:	b4c080e7          	jalr	-1204(ra) # 7818 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     cd4:	fc040713          	addi	a4,s0,-64
     cd8:	fe842783          	lw	a5,-24(s0)
     cdc:	02000613          	li	a2,32
     ce0:	85ba                	mv	a1,a4
     ce2:	853e                	mv	a0,a5
     ce4:	00007097          	auipc	ra,0x7
     ce8:	b4c080e7          	jalr	-1204(ra) # 7830 <read>
     cec:	87aa                	mv	a5,a0
     cee:	fef42223          	sw	a5,-28(s0)
  if(n != 2){
     cf2:	fe442783          	lw	a5,-28(s0)
     cf6:	0007871b          	sext.w	a4,a5
     cfa:	4789                	li	a5,2
     cfc:	02f70463          	beq	a4,a5,d24 <truncate1+0x26e>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     d00:	fe442783          	lw	a5,-28(s0)
     d04:	863e                	mv	a2,a5
     d06:	fb843583          	ld	a1,-72(s0)
     d0a:	00007517          	auipc	a0,0x7
     d0e:	78e50513          	addi	a0,a0,1934 # 8498 <malloc+0x560>
     d12:	00007097          	auipc	ra,0x7
     d16:	034080e7          	jalr	52(ra) # 7d46 <printf>
    exit(1);
     d1a:	4505                	li	a0,1
     d1c:	00007097          	auipc	ra,0x7
     d20:	afc080e7          	jalr	-1284(ra) # 7818 <exit>
  }

  unlink("truncfile");
     d24:	00007517          	auipc	a0,0x7
     d28:	6d450513          	addi	a0,a0,1748 # 83f8 <malloc+0x4c0>
     d2c:	00007097          	auipc	ra,0x7
     d30:	b3c080e7          	jalr	-1220(ra) # 7868 <unlink>

  close(fd1);
     d34:	fec42783          	lw	a5,-20(s0)
     d38:	853e                	mv	a0,a5
     d3a:	00007097          	auipc	ra,0x7
     d3e:	b06080e7          	jalr	-1274(ra) # 7840 <close>
  close(fd2);
     d42:	fe842783          	lw	a5,-24(s0)
     d46:	853e                	mv	a0,a5
     d48:	00007097          	auipc	ra,0x7
     d4c:	af8080e7          	jalr	-1288(ra) # 7840 <close>
  close(fd3);
     d50:	fe042783          	lw	a5,-32(s0)
     d54:	853e                	mv	a0,a5
     d56:	00007097          	auipc	ra,0x7
     d5a:	aea080e7          	jalr	-1302(ra) # 7840 <close>
}
     d5e:	0001                	nop
     d60:	60a6                	ld	ra,72(sp)
     d62:	6406                	ld	s0,64(sp)
     d64:	6161                	addi	sp,sp,80
     d66:	8082                	ret

0000000000000d68 <truncate2>:
// this causes a write at an offset beyond the end of the file.
// such writes fail on xv6 (unlike POSIX) but at least
// they don't crash.
void
truncate2(char *s)
{
     d68:	7179                	addi	sp,sp,-48
     d6a:	f406                	sd	ra,40(sp)
     d6c:	f022                	sd	s0,32(sp)
     d6e:	1800                	addi	s0,sp,48
     d70:	fca43c23          	sd	a0,-40(s0)
  unlink("truncfile");
     d74:	00007517          	auipc	a0,0x7
     d78:	68450513          	addi	a0,a0,1668 # 83f8 <malloc+0x4c0>
     d7c:	00007097          	auipc	ra,0x7
     d80:	aec080e7          	jalr	-1300(ra) # 7868 <unlink>

  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     d84:	60100593          	li	a1,1537
     d88:	00007517          	auipc	a0,0x7
     d8c:	67050513          	addi	a0,a0,1648 # 83f8 <malloc+0x4c0>
     d90:	00007097          	auipc	ra,0x7
     d94:	ac8080e7          	jalr	-1336(ra) # 7858 <open>
     d98:	87aa                	mv	a5,a0
     d9a:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     d9e:	fec42783          	lw	a5,-20(s0)
     da2:	4611                	li	a2,4
     da4:	00007597          	auipc	a1,0x7
     da8:	66458593          	addi	a1,a1,1636 # 8408 <malloc+0x4d0>
     dac:	853e                	mv	a0,a5
     dae:	00007097          	auipc	ra,0x7
     db2:	a8a080e7          	jalr	-1398(ra) # 7838 <write>

  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     db6:	40100593          	li	a1,1025
     dba:	00007517          	auipc	a0,0x7
     dbe:	63e50513          	addi	a0,a0,1598 # 83f8 <malloc+0x4c0>
     dc2:	00007097          	auipc	ra,0x7
     dc6:	a96080e7          	jalr	-1386(ra) # 7858 <open>
     dca:	87aa                	mv	a5,a0
     dcc:	fef42423          	sw	a5,-24(s0)

  int n = write(fd1, "x", 1);
     dd0:	fec42783          	lw	a5,-20(s0)
     dd4:	4605                	li	a2,1
     dd6:	00007597          	auipc	a1,0x7
     dda:	3da58593          	addi	a1,a1,986 # 81b0 <malloc+0x278>
     dde:	853e                	mv	a0,a5
     de0:	00007097          	auipc	ra,0x7
     de4:	a58080e7          	jalr	-1448(ra) # 7838 <write>
     de8:	87aa                	mv	a5,a0
     dea:	fef42223          	sw	a5,-28(s0)
  if(n != -1){
     dee:	fe442783          	lw	a5,-28(s0)
     df2:	0007871b          	sext.w	a4,a5
     df6:	57fd                	li	a5,-1
     df8:	02f70463          	beq	a4,a5,e20 <truncate2+0xb8>
    printf("%s: write returned %d, expected -1\n", s, n);
     dfc:	fe442783          	lw	a5,-28(s0)
     e00:	863e                	mv	a2,a5
     e02:	fd843583          	ld	a1,-40(s0)
     e06:	00007517          	auipc	a0,0x7
     e0a:	6b250513          	addi	a0,a0,1714 # 84b8 <malloc+0x580>
     e0e:	00007097          	auipc	ra,0x7
     e12:	f38080e7          	jalr	-200(ra) # 7d46 <printf>
    exit(1);
     e16:	4505                	li	a0,1
     e18:	00007097          	auipc	ra,0x7
     e1c:	a00080e7          	jalr	-1536(ra) # 7818 <exit>
  }

  unlink("truncfile");
     e20:	00007517          	auipc	a0,0x7
     e24:	5d850513          	addi	a0,a0,1496 # 83f8 <malloc+0x4c0>
     e28:	00007097          	auipc	ra,0x7
     e2c:	a40080e7          	jalr	-1472(ra) # 7868 <unlink>
  close(fd1);
     e30:	fec42783          	lw	a5,-20(s0)
     e34:	853e                	mv	a0,a5
     e36:	00007097          	auipc	ra,0x7
     e3a:	a0a080e7          	jalr	-1526(ra) # 7840 <close>
  close(fd2);
     e3e:	fe842783          	lw	a5,-24(s0)
     e42:	853e                	mv	a0,a5
     e44:	00007097          	auipc	ra,0x7
     e48:	9fc080e7          	jalr	-1540(ra) # 7840 <close>
}
     e4c:	0001                	nop
     e4e:	70a2                	ld	ra,40(sp)
     e50:	7402                	ld	s0,32(sp)
     e52:	6145                	addi	sp,sp,48
     e54:	8082                	ret

0000000000000e56 <truncate3>:

void
truncate3(char *s)
{
     e56:	711d                	addi	sp,sp,-96
     e58:	ec86                	sd	ra,88(sp)
     e5a:	e8a2                	sd	s0,80(sp)
     e5c:	1080                	addi	s0,sp,96
     e5e:	faa43423          	sd	a0,-88(s0)
  int pid, xstatus;

  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
     e62:	60100593          	li	a1,1537
     e66:	00007517          	auipc	a0,0x7
     e6a:	59250513          	addi	a0,a0,1426 # 83f8 <malloc+0x4c0>
     e6e:	00007097          	auipc	ra,0x7
     e72:	9ea080e7          	jalr	-1558(ra) # 7858 <open>
     e76:	87aa                	mv	a5,a0
     e78:	853e                	mv	a0,a5
     e7a:	00007097          	auipc	ra,0x7
     e7e:	9c6080e7          	jalr	-1594(ra) # 7840 <close>

  pid = fork();
     e82:	00007097          	auipc	ra,0x7
     e86:	98e080e7          	jalr	-1650(ra) # 7810 <fork>
     e8a:	87aa                	mv	a5,a0
     e8c:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
     e90:	fe442783          	lw	a5,-28(s0)
     e94:	2781                	sext.w	a5,a5
     e96:	0207d163          	bgez	a5,eb8 <truncate3+0x62>
    printf("%s: fork failed\n", s);
     e9a:	fa843583          	ld	a1,-88(s0)
     e9e:	00007517          	auipc	a0,0x7
     ea2:	64250513          	addi	a0,a0,1602 # 84e0 <malloc+0x5a8>
     ea6:	00007097          	auipc	ra,0x7
     eaa:	ea0080e7          	jalr	-352(ra) # 7d46 <printf>
    exit(1);
     eae:	4505                	li	a0,1
     eb0:	00007097          	auipc	ra,0x7
     eb4:	968080e7          	jalr	-1688(ra) # 7818 <exit>
  }

  if(pid == 0){
     eb8:	fe442783          	lw	a5,-28(s0)
     ebc:	2781                	sext.w	a5,a5
     ebe:	10079563          	bnez	a5,fc8 <truncate3+0x172>
    for(int i = 0; i < 100; i++){
     ec2:	fe042623          	sw	zero,-20(s0)
     ec6:	a0e5                	j	fae <truncate3+0x158>
      char buf[32];
      int fd = open("truncfile", O_WRONLY);
     ec8:	4585                	li	a1,1
     eca:	00007517          	auipc	a0,0x7
     ece:	52e50513          	addi	a0,a0,1326 # 83f8 <malloc+0x4c0>
     ed2:	00007097          	auipc	ra,0x7
     ed6:	986080e7          	jalr	-1658(ra) # 7858 <open>
     eda:	87aa                	mv	a5,a0
     edc:	fcf42c23          	sw	a5,-40(s0)
      if(fd < 0){
     ee0:	fd842783          	lw	a5,-40(s0)
     ee4:	2781                	sext.w	a5,a5
     ee6:	0207d163          	bgez	a5,f08 <truncate3+0xb2>
        printf("%s: open failed\n", s);
     eea:	fa843583          	ld	a1,-88(s0)
     eee:	00007517          	auipc	a0,0x7
     ef2:	60a50513          	addi	a0,a0,1546 # 84f8 <malloc+0x5c0>
     ef6:	00007097          	auipc	ra,0x7
     efa:	e50080e7          	jalr	-432(ra) # 7d46 <printf>
        exit(1);
     efe:	4505                	li	a0,1
     f00:	00007097          	auipc	ra,0x7
     f04:	918080e7          	jalr	-1768(ra) # 7818 <exit>
      }
      int n = write(fd, "1234567890", 10);
     f08:	fd842783          	lw	a5,-40(s0)
     f0c:	4629                	li	a2,10
     f0e:	00007597          	auipc	a1,0x7
     f12:	60258593          	addi	a1,a1,1538 # 8510 <malloc+0x5d8>
     f16:	853e                	mv	a0,a5
     f18:	00007097          	auipc	ra,0x7
     f1c:	920080e7          	jalr	-1760(ra) # 7838 <write>
     f20:	87aa                	mv	a5,a0
     f22:	fcf42a23          	sw	a5,-44(s0)
      if(n != 10){
     f26:	fd442783          	lw	a5,-44(s0)
     f2a:	0007871b          	sext.w	a4,a5
     f2e:	47a9                	li	a5,10
     f30:	02f70463          	beq	a4,a5,f58 <truncate3+0x102>
        printf("%s: write got %d, expected 10\n", s, n);
     f34:	fd442783          	lw	a5,-44(s0)
     f38:	863e                	mv	a2,a5
     f3a:	fa843583          	ld	a1,-88(s0)
     f3e:	00007517          	auipc	a0,0x7
     f42:	5e250513          	addi	a0,a0,1506 # 8520 <malloc+0x5e8>
     f46:	00007097          	auipc	ra,0x7
     f4a:	e00080e7          	jalr	-512(ra) # 7d46 <printf>
        exit(1);
     f4e:	4505                	li	a0,1
     f50:	00007097          	auipc	ra,0x7
     f54:	8c8080e7          	jalr	-1848(ra) # 7818 <exit>
      }
      close(fd);
     f58:	fd842783          	lw	a5,-40(s0)
     f5c:	853e                	mv	a0,a5
     f5e:	00007097          	auipc	ra,0x7
     f62:	8e2080e7          	jalr	-1822(ra) # 7840 <close>
      fd = open("truncfile", O_RDONLY);
     f66:	4581                	li	a1,0
     f68:	00007517          	auipc	a0,0x7
     f6c:	49050513          	addi	a0,a0,1168 # 83f8 <malloc+0x4c0>
     f70:	00007097          	auipc	ra,0x7
     f74:	8e8080e7          	jalr	-1816(ra) # 7858 <open>
     f78:	87aa                	mv	a5,a0
     f7a:	fcf42c23          	sw	a5,-40(s0)
      read(fd, buf, sizeof(buf));
     f7e:	fb040713          	addi	a4,s0,-80
     f82:	fd842783          	lw	a5,-40(s0)
     f86:	02000613          	li	a2,32
     f8a:	85ba                	mv	a1,a4
     f8c:	853e                	mv	a0,a5
     f8e:	00007097          	auipc	ra,0x7
     f92:	8a2080e7          	jalr	-1886(ra) # 7830 <read>
      close(fd);
     f96:	fd842783          	lw	a5,-40(s0)
     f9a:	853e                	mv	a0,a5
     f9c:	00007097          	auipc	ra,0x7
     fa0:	8a4080e7          	jalr	-1884(ra) # 7840 <close>
    for(int i = 0; i < 100; i++){
     fa4:	fec42783          	lw	a5,-20(s0)
     fa8:	2785                	addiw	a5,a5,1
     faa:	fef42623          	sw	a5,-20(s0)
     fae:	fec42783          	lw	a5,-20(s0)
     fb2:	0007871b          	sext.w	a4,a5
     fb6:	06300793          	li	a5,99
     fba:	f0e7d7e3          	bge	a5,a4,ec8 <truncate3+0x72>
    }
    exit(0);
     fbe:	4501                	li	a0,0
     fc0:	00007097          	auipc	ra,0x7
     fc4:	858080e7          	jalr	-1960(ra) # 7818 <exit>
  }

  for(int i = 0; i < 150; i++){
     fc8:	fe042423          	sw	zero,-24(s0)
     fcc:	a075                	j	1078 <truncate3+0x222>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     fce:	60100593          	li	a1,1537
     fd2:	00007517          	auipc	a0,0x7
     fd6:	42650513          	addi	a0,a0,1062 # 83f8 <malloc+0x4c0>
     fda:	00007097          	auipc	ra,0x7
     fde:	87e080e7          	jalr	-1922(ra) # 7858 <open>
     fe2:	87aa                	mv	a5,a0
     fe4:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
     fe8:	fe042783          	lw	a5,-32(s0)
     fec:	2781                	sext.w	a5,a5
     fee:	0207d163          	bgez	a5,1010 <truncate3+0x1ba>
      printf("%s: open failed\n", s);
     ff2:	fa843583          	ld	a1,-88(s0)
     ff6:	00007517          	auipc	a0,0x7
     ffa:	50250513          	addi	a0,a0,1282 # 84f8 <malloc+0x5c0>
     ffe:	00007097          	auipc	ra,0x7
    1002:	d48080e7          	jalr	-696(ra) # 7d46 <printf>
      exit(1);
    1006:	4505                	li	a0,1
    1008:	00007097          	auipc	ra,0x7
    100c:	810080e7          	jalr	-2032(ra) # 7818 <exit>
    }
    int n = write(fd, "xxx", 3);
    1010:	fe042783          	lw	a5,-32(s0)
    1014:	460d                	li	a2,3
    1016:	00007597          	auipc	a1,0x7
    101a:	52a58593          	addi	a1,a1,1322 # 8540 <malloc+0x608>
    101e:	853e                	mv	a0,a5
    1020:	00007097          	auipc	ra,0x7
    1024:	818080e7          	jalr	-2024(ra) # 7838 <write>
    1028:	87aa                	mv	a5,a0
    102a:	fcf42e23          	sw	a5,-36(s0)
    if(n != 3){
    102e:	fdc42783          	lw	a5,-36(s0)
    1032:	0007871b          	sext.w	a4,a5
    1036:	478d                	li	a5,3
    1038:	02f70463          	beq	a4,a5,1060 <truncate3+0x20a>
      printf("%s: write got %d, expected 3\n", s, n);
    103c:	fdc42783          	lw	a5,-36(s0)
    1040:	863e                	mv	a2,a5
    1042:	fa843583          	ld	a1,-88(s0)
    1046:	00007517          	auipc	a0,0x7
    104a:	50250513          	addi	a0,a0,1282 # 8548 <malloc+0x610>
    104e:	00007097          	auipc	ra,0x7
    1052:	cf8080e7          	jalr	-776(ra) # 7d46 <printf>
      exit(1);
    1056:	4505                	li	a0,1
    1058:	00006097          	auipc	ra,0x6
    105c:	7c0080e7          	jalr	1984(ra) # 7818 <exit>
    }
    close(fd);
    1060:	fe042783          	lw	a5,-32(s0)
    1064:	853e                	mv	a0,a5
    1066:	00006097          	auipc	ra,0x6
    106a:	7da080e7          	jalr	2010(ra) # 7840 <close>
  for(int i = 0; i < 150; i++){
    106e:	fe842783          	lw	a5,-24(s0)
    1072:	2785                	addiw	a5,a5,1
    1074:	fef42423          	sw	a5,-24(s0)
    1078:	fe842783          	lw	a5,-24(s0)
    107c:	0007871b          	sext.w	a4,a5
    1080:	09500793          	li	a5,149
    1084:	f4e7d5e3          	bge	a5,a4,fce <truncate3+0x178>
  }

  wait(&xstatus);
    1088:	fd040793          	addi	a5,s0,-48
    108c:	853e                	mv	a0,a5
    108e:	00006097          	auipc	ra,0x6
    1092:	792080e7          	jalr	1938(ra) # 7820 <wait>
  unlink("truncfile");
    1096:	00007517          	auipc	a0,0x7
    109a:	36250513          	addi	a0,a0,866 # 83f8 <malloc+0x4c0>
    109e:	00006097          	auipc	ra,0x6
    10a2:	7ca080e7          	jalr	1994(ra) # 7868 <unlink>
  exit(xstatus);
    10a6:	fd042783          	lw	a5,-48(s0)
    10aa:	853e                	mv	a0,a5
    10ac:	00006097          	auipc	ra,0x6
    10b0:	76c080e7          	jalr	1900(ra) # 7818 <exit>

00000000000010b4 <iputtest>:


// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(char *s)
{
    10b4:	1101                	addi	sp,sp,-32
    10b6:	ec06                	sd	ra,24(sp)
    10b8:	e822                	sd	s0,16(sp)
    10ba:	1000                	addi	s0,sp,32
    10bc:	fea43423          	sd	a0,-24(s0)
  if(mkdir("iputdir") < 0){
    10c0:	00007517          	auipc	a0,0x7
    10c4:	4a850513          	addi	a0,a0,1192 # 8568 <malloc+0x630>
    10c8:	00006097          	auipc	ra,0x6
    10cc:	7b8080e7          	jalr	1976(ra) # 7880 <mkdir>
    10d0:	87aa                	mv	a5,a0
    10d2:	0207d163          	bgez	a5,10f4 <iputtest+0x40>
    printf("%s: mkdir failed\n", s);
    10d6:	fe843583          	ld	a1,-24(s0)
    10da:	00007517          	auipc	a0,0x7
    10de:	49650513          	addi	a0,a0,1174 # 8570 <malloc+0x638>
    10e2:	00007097          	auipc	ra,0x7
    10e6:	c64080e7          	jalr	-924(ra) # 7d46 <printf>
    exit(1);
    10ea:	4505                	li	a0,1
    10ec:	00006097          	auipc	ra,0x6
    10f0:	72c080e7          	jalr	1836(ra) # 7818 <exit>
  }
  if(chdir("iputdir") < 0){
    10f4:	00007517          	auipc	a0,0x7
    10f8:	47450513          	addi	a0,a0,1140 # 8568 <malloc+0x630>
    10fc:	00006097          	auipc	ra,0x6
    1100:	78c080e7          	jalr	1932(ra) # 7888 <chdir>
    1104:	87aa                	mv	a5,a0
    1106:	0207d163          	bgez	a5,1128 <iputtest+0x74>
    printf("%s: chdir iputdir failed\n", s);
    110a:	fe843583          	ld	a1,-24(s0)
    110e:	00007517          	auipc	a0,0x7
    1112:	47a50513          	addi	a0,a0,1146 # 8588 <malloc+0x650>
    1116:	00007097          	auipc	ra,0x7
    111a:	c30080e7          	jalr	-976(ra) # 7d46 <printf>
    exit(1);
    111e:	4505                	li	a0,1
    1120:	00006097          	auipc	ra,0x6
    1124:	6f8080e7          	jalr	1784(ra) # 7818 <exit>
  }
  if(unlink("../iputdir") < 0){
    1128:	00007517          	auipc	a0,0x7
    112c:	48050513          	addi	a0,a0,1152 # 85a8 <malloc+0x670>
    1130:	00006097          	auipc	ra,0x6
    1134:	738080e7          	jalr	1848(ra) # 7868 <unlink>
    1138:	87aa                	mv	a5,a0
    113a:	0207d163          	bgez	a5,115c <iputtest+0xa8>
    printf("%s: unlink ../iputdir failed\n", s);
    113e:	fe843583          	ld	a1,-24(s0)
    1142:	00007517          	auipc	a0,0x7
    1146:	47650513          	addi	a0,a0,1142 # 85b8 <malloc+0x680>
    114a:	00007097          	auipc	ra,0x7
    114e:	bfc080e7          	jalr	-1028(ra) # 7d46 <printf>
    exit(1);
    1152:	4505                	li	a0,1
    1154:	00006097          	auipc	ra,0x6
    1158:	6c4080e7          	jalr	1732(ra) # 7818 <exit>
  }
  if(chdir("/") < 0){
    115c:	00007517          	auipc	a0,0x7
    1160:	47c50513          	addi	a0,a0,1148 # 85d8 <malloc+0x6a0>
    1164:	00006097          	auipc	ra,0x6
    1168:	724080e7          	jalr	1828(ra) # 7888 <chdir>
    116c:	87aa                	mv	a5,a0
    116e:	0207d163          	bgez	a5,1190 <iputtest+0xdc>
    printf("%s: chdir / failed\n", s);
    1172:	fe843583          	ld	a1,-24(s0)
    1176:	00007517          	auipc	a0,0x7
    117a:	46a50513          	addi	a0,a0,1130 # 85e0 <malloc+0x6a8>
    117e:	00007097          	auipc	ra,0x7
    1182:	bc8080e7          	jalr	-1080(ra) # 7d46 <printf>
    exit(1);
    1186:	4505                	li	a0,1
    1188:	00006097          	auipc	ra,0x6
    118c:	690080e7          	jalr	1680(ra) # 7818 <exit>
  }
}
    1190:	0001                	nop
    1192:	60e2                	ld	ra,24(sp)
    1194:	6442                	ld	s0,16(sp)
    1196:	6105                	addi	sp,sp,32
    1198:	8082                	ret

000000000000119a <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(char *s)
{
    119a:	7179                	addi	sp,sp,-48
    119c:	f406                	sd	ra,40(sp)
    119e:	f022                	sd	s0,32(sp)
    11a0:	1800                	addi	s0,sp,48
    11a2:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  pid = fork();
    11a6:	00006097          	auipc	ra,0x6
    11aa:	66a080e7          	jalr	1642(ra) # 7810 <fork>
    11ae:	87aa                	mv	a5,a0
    11b0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    11b4:	fec42783          	lw	a5,-20(s0)
    11b8:	2781                	sext.w	a5,a5
    11ba:	0207d163          	bgez	a5,11dc <exitiputtest+0x42>
    printf("%s: fork failed\n", s);
    11be:	fd843583          	ld	a1,-40(s0)
    11c2:	00007517          	auipc	a0,0x7
    11c6:	31e50513          	addi	a0,a0,798 # 84e0 <malloc+0x5a8>
    11ca:	00007097          	auipc	ra,0x7
    11ce:	b7c080e7          	jalr	-1156(ra) # 7d46 <printf>
    exit(1);
    11d2:	4505                	li	a0,1
    11d4:	00006097          	auipc	ra,0x6
    11d8:	644080e7          	jalr	1604(ra) # 7818 <exit>
  }
  if(pid == 0){
    11dc:	fec42783          	lw	a5,-20(s0)
    11e0:	2781                	sext.w	a5,a5
    11e2:	e7c5                	bnez	a5,128a <exitiputtest+0xf0>
    if(mkdir("iputdir") < 0){
    11e4:	00007517          	auipc	a0,0x7
    11e8:	38450513          	addi	a0,a0,900 # 8568 <malloc+0x630>
    11ec:	00006097          	auipc	ra,0x6
    11f0:	694080e7          	jalr	1684(ra) # 7880 <mkdir>
    11f4:	87aa                	mv	a5,a0
    11f6:	0207d163          	bgez	a5,1218 <exitiputtest+0x7e>
      printf("%s: mkdir failed\n", s);
    11fa:	fd843583          	ld	a1,-40(s0)
    11fe:	00007517          	auipc	a0,0x7
    1202:	37250513          	addi	a0,a0,882 # 8570 <malloc+0x638>
    1206:	00007097          	auipc	ra,0x7
    120a:	b40080e7          	jalr	-1216(ra) # 7d46 <printf>
      exit(1);
    120e:	4505                	li	a0,1
    1210:	00006097          	auipc	ra,0x6
    1214:	608080e7          	jalr	1544(ra) # 7818 <exit>
    }
    if(chdir("iputdir") < 0){
    1218:	00007517          	auipc	a0,0x7
    121c:	35050513          	addi	a0,a0,848 # 8568 <malloc+0x630>
    1220:	00006097          	auipc	ra,0x6
    1224:	668080e7          	jalr	1640(ra) # 7888 <chdir>
    1228:	87aa                	mv	a5,a0
    122a:	0207d163          	bgez	a5,124c <exitiputtest+0xb2>
      printf("%s: child chdir failed\n", s);
    122e:	fd843583          	ld	a1,-40(s0)
    1232:	00007517          	auipc	a0,0x7
    1236:	3c650513          	addi	a0,a0,966 # 85f8 <malloc+0x6c0>
    123a:	00007097          	auipc	ra,0x7
    123e:	b0c080e7          	jalr	-1268(ra) # 7d46 <printf>
      exit(1);
    1242:	4505                	li	a0,1
    1244:	00006097          	auipc	ra,0x6
    1248:	5d4080e7          	jalr	1492(ra) # 7818 <exit>
    }
    if(unlink("../iputdir") < 0){
    124c:	00007517          	auipc	a0,0x7
    1250:	35c50513          	addi	a0,a0,860 # 85a8 <malloc+0x670>
    1254:	00006097          	auipc	ra,0x6
    1258:	614080e7          	jalr	1556(ra) # 7868 <unlink>
    125c:	87aa                	mv	a5,a0
    125e:	0207d163          	bgez	a5,1280 <exitiputtest+0xe6>
      printf("%s: unlink ../iputdir failed\n", s);
    1262:	fd843583          	ld	a1,-40(s0)
    1266:	00007517          	auipc	a0,0x7
    126a:	35250513          	addi	a0,a0,850 # 85b8 <malloc+0x680>
    126e:	00007097          	auipc	ra,0x7
    1272:	ad8080e7          	jalr	-1320(ra) # 7d46 <printf>
      exit(1);
    1276:	4505                	li	a0,1
    1278:	00006097          	auipc	ra,0x6
    127c:	5a0080e7          	jalr	1440(ra) # 7818 <exit>
    }
    exit(0);
    1280:	4501                	li	a0,0
    1282:	00006097          	auipc	ra,0x6
    1286:	596080e7          	jalr	1430(ra) # 7818 <exit>
  }
  wait(&xstatus);
    128a:	fe840793          	addi	a5,s0,-24
    128e:	853e                	mv	a0,a5
    1290:	00006097          	auipc	ra,0x6
    1294:	590080e7          	jalr	1424(ra) # 7820 <wait>
  exit(xstatus);
    1298:	fe842783          	lw	a5,-24(s0)
    129c:	853e                	mv	a0,a5
    129e:	00006097          	auipc	ra,0x6
    12a2:	57a080e7          	jalr	1402(ra) # 7818 <exit>

00000000000012a6 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(char *s)
{
    12a6:	7179                	addi	sp,sp,-48
    12a8:	f406                	sd	ra,40(sp)
    12aa:	f022                	sd	s0,32(sp)
    12ac:	1800                	addi	s0,sp,48
    12ae:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  if(mkdir("oidir") < 0){
    12b2:	00007517          	auipc	a0,0x7
    12b6:	35e50513          	addi	a0,a0,862 # 8610 <malloc+0x6d8>
    12ba:	00006097          	auipc	ra,0x6
    12be:	5c6080e7          	jalr	1478(ra) # 7880 <mkdir>
    12c2:	87aa                	mv	a5,a0
    12c4:	0207d163          	bgez	a5,12e6 <openiputtest+0x40>
    printf("%s: mkdir oidir failed\n", s);
    12c8:	fd843583          	ld	a1,-40(s0)
    12cc:	00007517          	auipc	a0,0x7
    12d0:	34c50513          	addi	a0,a0,844 # 8618 <malloc+0x6e0>
    12d4:	00007097          	auipc	ra,0x7
    12d8:	a72080e7          	jalr	-1422(ra) # 7d46 <printf>
    exit(1);
    12dc:	4505                	li	a0,1
    12de:	00006097          	auipc	ra,0x6
    12e2:	53a080e7          	jalr	1338(ra) # 7818 <exit>
  }
  pid = fork();
    12e6:	00006097          	auipc	ra,0x6
    12ea:	52a080e7          	jalr	1322(ra) # 7810 <fork>
    12ee:	87aa                	mv	a5,a0
    12f0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    12f4:	fec42783          	lw	a5,-20(s0)
    12f8:	2781                	sext.w	a5,a5
    12fa:	0207d163          	bgez	a5,131c <openiputtest+0x76>
    printf("%s: fork failed\n", s);
    12fe:	fd843583          	ld	a1,-40(s0)
    1302:	00007517          	auipc	a0,0x7
    1306:	1de50513          	addi	a0,a0,478 # 84e0 <malloc+0x5a8>
    130a:	00007097          	auipc	ra,0x7
    130e:	a3c080e7          	jalr	-1476(ra) # 7d46 <printf>
    exit(1);
    1312:	4505                	li	a0,1
    1314:	00006097          	auipc	ra,0x6
    1318:	504080e7          	jalr	1284(ra) # 7818 <exit>
  }
  if(pid == 0){
    131c:	fec42783          	lw	a5,-20(s0)
    1320:	2781                	sext.w	a5,a5
    1322:	e7b1                	bnez	a5,136e <openiputtest+0xc8>
    int fd = open("oidir", O_RDWR);
    1324:	4589                	li	a1,2
    1326:	00007517          	auipc	a0,0x7
    132a:	2ea50513          	addi	a0,a0,746 # 8610 <malloc+0x6d8>
    132e:	00006097          	auipc	ra,0x6
    1332:	52a080e7          	jalr	1322(ra) # 7858 <open>
    1336:	87aa                	mv	a5,a0
    1338:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0){
    133c:	fe842783          	lw	a5,-24(s0)
    1340:	2781                	sext.w	a5,a5
    1342:	0207c163          	bltz	a5,1364 <openiputtest+0xbe>
      printf("%s: open directory for write succeeded\n", s);
    1346:	fd843583          	ld	a1,-40(s0)
    134a:	00007517          	auipc	a0,0x7
    134e:	2e650513          	addi	a0,a0,742 # 8630 <malloc+0x6f8>
    1352:	00007097          	auipc	ra,0x7
    1356:	9f4080e7          	jalr	-1548(ra) # 7d46 <printf>
      exit(1);
    135a:	4505                	li	a0,1
    135c:	00006097          	auipc	ra,0x6
    1360:	4bc080e7          	jalr	1212(ra) # 7818 <exit>
    }
    exit(0);
    1364:	4501                	li	a0,0
    1366:	00006097          	auipc	ra,0x6
    136a:	4b2080e7          	jalr	1202(ra) # 7818 <exit>
  }
  sleep(1);
    136e:	4505                	li	a0,1
    1370:	00006097          	auipc	ra,0x6
    1374:	538080e7          	jalr	1336(ra) # 78a8 <sleep>
  if(unlink("oidir") != 0){
    1378:	00007517          	auipc	a0,0x7
    137c:	29850513          	addi	a0,a0,664 # 8610 <malloc+0x6d8>
    1380:	00006097          	auipc	ra,0x6
    1384:	4e8080e7          	jalr	1256(ra) # 7868 <unlink>
    1388:	87aa                	mv	a5,a0
    138a:	c385                	beqz	a5,13aa <openiputtest+0x104>
    printf("%s: unlink failed\n", s);
    138c:	fd843583          	ld	a1,-40(s0)
    1390:	00007517          	auipc	a0,0x7
    1394:	2c850513          	addi	a0,a0,712 # 8658 <malloc+0x720>
    1398:	00007097          	auipc	ra,0x7
    139c:	9ae080e7          	jalr	-1618(ra) # 7d46 <printf>
    exit(1);
    13a0:	4505                	li	a0,1
    13a2:	00006097          	auipc	ra,0x6
    13a6:	476080e7          	jalr	1142(ra) # 7818 <exit>
  }
  wait(&xstatus);
    13aa:	fe440793          	addi	a5,s0,-28
    13ae:	853e                	mv	a0,a5
    13b0:	00006097          	auipc	ra,0x6
    13b4:	470080e7          	jalr	1136(ra) # 7820 <wait>
  exit(xstatus);
    13b8:	fe442783          	lw	a5,-28(s0)
    13bc:	853e                	mv	a0,a5
    13be:	00006097          	auipc	ra,0x6
    13c2:	45a080e7          	jalr	1114(ra) # 7818 <exit>

00000000000013c6 <opentest>:

// simple file system tests

void
opentest(char *s)
{
    13c6:	7179                	addi	sp,sp,-48
    13c8:	f406                	sd	ra,40(sp)
    13ca:	f022                	sd	s0,32(sp)
    13cc:	1800                	addi	s0,sp,48
    13ce:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("echo", 0);
    13d2:	4581                	li	a1,0
    13d4:	00007517          	auipc	a0,0x7
    13d8:	eec50513          	addi	a0,a0,-276 # 82c0 <malloc+0x388>
    13dc:	00006097          	auipc	ra,0x6
    13e0:	47c080e7          	jalr	1148(ra) # 7858 <open>
    13e4:	87aa                	mv	a5,a0
    13e6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    13ea:	fec42783          	lw	a5,-20(s0)
    13ee:	2781                	sext.w	a5,a5
    13f0:	0207d163          	bgez	a5,1412 <opentest+0x4c>
    printf("%s: open echo failed!\n", s);
    13f4:	fd843583          	ld	a1,-40(s0)
    13f8:	00007517          	auipc	a0,0x7
    13fc:	27850513          	addi	a0,a0,632 # 8670 <malloc+0x738>
    1400:	00007097          	auipc	ra,0x7
    1404:	946080e7          	jalr	-1722(ra) # 7d46 <printf>
    exit(1);
    1408:	4505                	li	a0,1
    140a:	00006097          	auipc	ra,0x6
    140e:	40e080e7          	jalr	1038(ra) # 7818 <exit>
  }
  close(fd);
    1412:	fec42783          	lw	a5,-20(s0)
    1416:	853e                	mv	a0,a5
    1418:	00006097          	auipc	ra,0x6
    141c:	428080e7          	jalr	1064(ra) # 7840 <close>
  fd = open("doesnotexist", 0);
    1420:	4581                	li	a1,0
    1422:	00007517          	auipc	a0,0x7
    1426:	26650513          	addi	a0,a0,614 # 8688 <malloc+0x750>
    142a:	00006097          	auipc	ra,0x6
    142e:	42e080e7          	jalr	1070(ra) # 7858 <open>
    1432:	87aa                	mv	a5,a0
    1434:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    1438:	fec42783          	lw	a5,-20(s0)
    143c:	2781                	sext.w	a5,a5
    143e:	0207c163          	bltz	a5,1460 <opentest+0x9a>
    printf("%s: open doesnotexist succeeded!\n", s);
    1442:	fd843583          	ld	a1,-40(s0)
    1446:	00007517          	auipc	a0,0x7
    144a:	25250513          	addi	a0,a0,594 # 8698 <malloc+0x760>
    144e:	00007097          	auipc	ra,0x7
    1452:	8f8080e7          	jalr	-1800(ra) # 7d46 <printf>
    exit(1);
    1456:	4505                	li	a0,1
    1458:	00006097          	auipc	ra,0x6
    145c:	3c0080e7          	jalr	960(ra) # 7818 <exit>
  }
}
    1460:	0001                	nop
    1462:	70a2                	ld	ra,40(sp)
    1464:	7402                	ld	s0,32(sp)
    1466:	6145                	addi	sp,sp,48
    1468:	8082                	ret

000000000000146a <writetest>:

void
writetest(char *s)
{
    146a:	7179                	addi	sp,sp,-48
    146c:	f406                	sd	ra,40(sp)
    146e:	f022                	sd	s0,32(sp)
    1470:	1800                	addi	s0,sp,48
    1472:	fca43c23          	sd	a0,-40(s0)
  int fd;
  int i;
  enum { N=100, SZ=10 };

  fd = open("small", O_CREATE|O_RDWR);
    1476:	20200593          	li	a1,514
    147a:	00007517          	auipc	a0,0x7
    147e:	24650513          	addi	a0,a0,582 # 86c0 <malloc+0x788>
    1482:	00006097          	auipc	ra,0x6
    1486:	3d6080e7          	jalr	982(ra) # 7858 <open>
    148a:	87aa                	mv	a5,a0
    148c:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1490:	fe842783          	lw	a5,-24(s0)
    1494:	2781                	sext.w	a5,a5
    1496:	0207d163          	bgez	a5,14b8 <writetest+0x4e>
    printf("%s: error: creat small failed!\n", s);
    149a:	fd843583          	ld	a1,-40(s0)
    149e:	00007517          	auipc	a0,0x7
    14a2:	22a50513          	addi	a0,a0,554 # 86c8 <malloc+0x790>
    14a6:	00007097          	auipc	ra,0x7
    14aa:	8a0080e7          	jalr	-1888(ra) # 7d46 <printf>
    exit(1);
    14ae:	4505                	li	a0,1
    14b0:	00006097          	auipc	ra,0x6
    14b4:	368080e7          	jalr	872(ra) # 7818 <exit>
  }
  for(i = 0; i < N; i++){
    14b8:	fe042623          	sw	zero,-20(s0)
    14bc:	a861                	j	1554 <writetest+0xea>
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    14be:	fe842783          	lw	a5,-24(s0)
    14c2:	4629                	li	a2,10
    14c4:	00007597          	auipc	a1,0x7
    14c8:	22458593          	addi	a1,a1,548 # 86e8 <malloc+0x7b0>
    14cc:	853e                	mv	a0,a5
    14ce:	00006097          	auipc	ra,0x6
    14d2:	36a080e7          	jalr	874(ra) # 7838 <write>
    14d6:	87aa                	mv	a5,a0
    14d8:	873e                	mv	a4,a5
    14da:	47a9                	li	a5,10
    14dc:	02f70463          	beq	a4,a5,1504 <writetest+0x9a>
      printf("%s: error: write aa %d new file failed\n", s, i);
    14e0:	fec42783          	lw	a5,-20(s0)
    14e4:	863e                	mv	a2,a5
    14e6:	fd843583          	ld	a1,-40(s0)
    14ea:	00007517          	auipc	a0,0x7
    14ee:	20e50513          	addi	a0,a0,526 # 86f8 <malloc+0x7c0>
    14f2:	00007097          	auipc	ra,0x7
    14f6:	854080e7          	jalr	-1964(ra) # 7d46 <printf>
      exit(1);
    14fa:	4505                	li	a0,1
    14fc:	00006097          	auipc	ra,0x6
    1500:	31c080e7          	jalr	796(ra) # 7818 <exit>
    }
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    1504:	fe842783          	lw	a5,-24(s0)
    1508:	4629                	li	a2,10
    150a:	00007597          	auipc	a1,0x7
    150e:	21658593          	addi	a1,a1,534 # 8720 <malloc+0x7e8>
    1512:	853e                	mv	a0,a5
    1514:	00006097          	auipc	ra,0x6
    1518:	324080e7          	jalr	804(ra) # 7838 <write>
    151c:	87aa                	mv	a5,a0
    151e:	873e                	mv	a4,a5
    1520:	47a9                	li	a5,10
    1522:	02f70463          	beq	a4,a5,154a <writetest+0xe0>
      printf("%s: error: write bb %d new file failed\n", s, i);
    1526:	fec42783          	lw	a5,-20(s0)
    152a:	863e                	mv	a2,a5
    152c:	fd843583          	ld	a1,-40(s0)
    1530:	00007517          	auipc	a0,0x7
    1534:	20050513          	addi	a0,a0,512 # 8730 <malloc+0x7f8>
    1538:	00007097          	auipc	ra,0x7
    153c:	80e080e7          	jalr	-2034(ra) # 7d46 <printf>
      exit(1);
    1540:	4505                	li	a0,1
    1542:	00006097          	auipc	ra,0x6
    1546:	2d6080e7          	jalr	726(ra) # 7818 <exit>
  for(i = 0; i < N; i++){
    154a:	fec42783          	lw	a5,-20(s0)
    154e:	2785                	addiw	a5,a5,1
    1550:	fef42623          	sw	a5,-20(s0)
    1554:	fec42783          	lw	a5,-20(s0)
    1558:	0007871b          	sext.w	a4,a5
    155c:	06300793          	li	a5,99
    1560:	f4e7dfe3          	bge	a5,a4,14be <writetest+0x54>
    }
  }
  close(fd);
    1564:	fe842783          	lw	a5,-24(s0)
    1568:	853e                	mv	a0,a5
    156a:	00006097          	auipc	ra,0x6
    156e:	2d6080e7          	jalr	726(ra) # 7840 <close>
  fd = open("small", O_RDONLY);
    1572:	4581                	li	a1,0
    1574:	00007517          	auipc	a0,0x7
    1578:	14c50513          	addi	a0,a0,332 # 86c0 <malloc+0x788>
    157c:	00006097          	auipc	ra,0x6
    1580:	2dc080e7          	jalr	732(ra) # 7858 <open>
    1584:	87aa                	mv	a5,a0
    1586:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    158a:	fe842783          	lw	a5,-24(s0)
    158e:	2781                	sext.w	a5,a5
    1590:	0207d163          	bgez	a5,15b2 <writetest+0x148>
    printf("%s: error: open small failed!\n", s);
    1594:	fd843583          	ld	a1,-40(s0)
    1598:	00007517          	auipc	a0,0x7
    159c:	1c050513          	addi	a0,a0,448 # 8758 <malloc+0x820>
    15a0:	00006097          	auipc	ra,0x6
    15a4:	7a6080e7          	jalr	1958(ra) # 7d46 <printf>
    exit(1);
    15a8:	4505                	li	a0,1
    15aa:	00006097          	auipc	ra,0x6
    15ae:	26e080e7          	jalr	622(ra) # 7818 <exit>
  }
  i = read(fd, buf, N*SZ*2);
    15b2:	fe842783          	lw	a5,-24(s0)
    15b6:	7d000613          	li	a2,2000
    15ba:	0000a597          	auipc	a1,0xa
    15be:	e9658593          	addi	a1,a1,-362 # b450 <buf>
    15c2:	853e                	mv	a0,a5
    15c4:	00006097          	auipc	ra,0x6
    15c8:	26c080e7          	jalr	620(ra) # 7830 <read>
    15cc:	87aa                	mv	a5,a0
    15ce:	fef42623          	sw	a5,-20(s0)
  if(i != N*SZ*2){
    15d2:	fec42783          	lw	a5,-20(s0)
    15d6:	0007871b          	sext.w	a4,a5
    15da:	7d000793          	li	a5,2000
    15de:	02f70163          	beq	a4,a5,1600 <writetest+0x196>
    printf("%s: read failed\n", s);
    15e2:	fd843583          	ld	a1,-40(s0)
    15e6:	00007517          	auipc	a0,0x7
    15ea:	19250513          	addi	a0,a0,402 # 8778 <malloc+0x840>
    15ee:	00006097          	auipc	ra,0x6
    15f2:	758080e7          	jalr	1880(ra) # 7d46 <printf>
    exit(1);
    15f6:	4505                	li	a0,1
    15f8:	00006097          	auipc	ra,0x6
    15fc:	220080e7          	jalr	544(ra) # 7818 <exit>
  }
  close(fd);
    1600:	fe842783          	lw	a5,-24(s0)
    1604:	853e                	mv	a0,a5
    1606:	00006097          	auipc	ra,0x6
    160a:	23a080e7          	jalr	570(ra) # 7840 <close>

  if(unlink("small") < 0){
    160e:	00007517          	auipc	a0,0x7
    1612:	0b250513          	addi	a0,a0,178 # 86c0 <malloc+0x788>
    1616:	00006097          	auipc	ra,0x6
    161a:	252080e7          	jalr	594(ra) # 7868 <unlink>
    161e:	87aa                	mv	a5,a0
    1620:	0207d163          	bgez	a5,1642 <writetest+0x1d8>
    printf("%s: unlink small failed\n", s);
    1624:	fd843583          	ld	a1,-40(s0)
    1628:	00007517          	auipc	a0,0x7
    162c:	16850513          	addi	a0,a0,360 # 8790 <malloc+0x858>
    1630:	00006097          	auipc	ra,0x6
    1634:	716080e7          	jalr	1814(ra) # 7d46 <printf>
    exit(1);
    1638:	4505                	li	a0,1
    163a:	00006097          	auipc	ra,0x6
    163e:	1de080e7          	jalr	478(ra) # 7818 <exit>
  }
}
    1642:	0001                	nop
    1644:	70a2                	ld	ra,40(sp)
    1646:	7402                	ld	s0,32(sp)
    1648:	6145                	addi	sp,sp,48
    164a:	8082                	ret

000000000000164c <writebig>:

void
writebig(char *s)
{
    164c:	7179                	addi	sp,sp,-48
    164e:	f406                	sd	ra,40(sp)
    1650:	f022                	sd	s0,32(sp)
    1652:	1800                	addi	s0,sp,48
    1654:	fca43c23          	sd	a0,-40(s0)
  int i, fd, n;

  fd = open("big", O_CREATE|O_RDWR);
    1658:	20200593          	li	a1,514
    165c:	00007517          	auipc	a0,0x7
    1660:	15450513          	addi	a0,a0,340 # 87b0 <malloc+0x878>
    1664:	00006097          	auipc	ra,0x6
    1668:	1f4080e7          	jalr	500(ra) # 7858 <open>
    166c:	87aa                	mv	a5,a0
    166e:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    1672:	fe442783          	lw	a5,-28(s0)
    1676:	2781                	sext.w	a5,a5
    1678:	0207d163          	bgez	a5,169a <writebig+0x4e>
    printf("%s: error: creat big failed!\n", s);
    167c:	fd843583          	ld	a1,-40(s0)
    1680:	00007517          	auipc	a0,0x7
    1684:	13850513          	addi	a0,a0,312 # 87b8 <malloc+0x880>
    1688:	00006097          	auipc	ra,0x6
    168c:	6be080e7          	jalr	1726(ra) # 7d46 <printf>
    exit(1);
    1690:	4505                	li	a0,1
    1692:	00006097          	auipc	ra,0x6
    1696:	186080e7          	jalr	390(ra) # 7818 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
    169a:	fe042623          	sw	zero,-20(s0)
    169e:	a095                	j	1702 <writebig+0xb6>
    ((int*)buf)[0] = i;
    16a0:	0000a797          	auipc	a5,0xa
    16a4:	db078793          	addi	a5,a5,-592 # b450 <buf>
    16a8:	fec42703          	lw	a4,-20(s0)
    16ac:	c398                	sw	a4,0(a5)
    if(write(fd, buf, BSIZE) != BSIZE){
    16ae:	fe442783          	lw	a5,-28(s0)
    16b2:	40000613          	li	a2,1024
    16b6:	0000a597          	auipc	a1,0xa
    16ba:	d9a58593          	addi	a1,a1,-614 # b450 <buf>
    16be:	853e                	mv	a0,a5
    16c0:	00006097          	auipc	ra,0x6
    16c4:	178080e7          	jalr	376(ra) # 7838 <write>
    16c8:	87aa                	mv	a5,a0
    16ca:	873e                	mv	a4,a5
    16cc:	40000793          	li	a5,1024
    16d0:	02f70463          	beq	a4,a5,16f8 <writebig+0xac>
      printf("%s: error: write big file failed\n", s, i);
    16d4:	fec42783          	lw	a5,-20(s0)
    16d8:	863e                	mv	a2,a5
    16da:	fd843583          	ld	a1,-40(s0)
    16de:	00007517          	auipc	a0,0x7
    16e2:	0fa50513          	addi	a0,a0,250 # 87d8 <malloc+0x8a0>
    16e6:	00006097          	auipc	ra,0x6
    16ea:	660080e7          	jalr	1632(ra) # 7d46 <printf>
      exit(1);
    16ee:	4505                	li	a0,1
    16f0:	00006097          	auipc	ra,0x6
    16f4:	128080e7          	jalr	296(ra) # 7818 <exit>
  for(i = 0; i < MAXFILE; i++){
    16f8:	fec42783          	lw	a5,-20(s0)
    16fc:	2785                	addiw	a5,a5,1
    16fe:	fef42623          	sw	a5,-20(s0)
    1702:	fec42783          	lw	a5,-20(s0)
    1706:	873e                	mv	a4,a5
    1708:	10b00793          	li	a5,267
    170c:	f8e7fae3          	bgeu	a5,a4,16a0 <writebig+0x54>
    }
  }

  close(fd);
    1710:	fe442783          	lw	a5,-28(s0)
    1714:	853e                	mv	a0,a5
    1716:	00006097          	auipc	ra,0x6
    171a:	12a080e7          	jalr	298(ra) # 7840 <close>

  fd = open("big", O_RDONLY);
    171e:	4581                	li	a1,0
    1720:	00007517          	auipc	a0,0x7
    1724:	09050513          	addi	a0,a0,144 # 87b0 <malloc+0x878>
    1728:	00006097          	auipc	ra,0x6
    172c:	130080e7          	jalr	304(ra) # 7858 <open>
    1730:	87aa                	mv	a5,a0
    1732:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    1736:	fe442783          	lw	a5,-28(s0)
    173a:	2781                	sext.w	a5,a5
    173c:	0207d163          	bgez	a5,175e <writebig+0x112>
    printf("%s: error: open big failed!\n", s);
    1740:	fd843583          	ld	a1,-40(s0)
    1744:	00007517          	auipc	a0,0x7
    1748:	0bc50513          	addi	a0,a0,188 # 8800 <malloc+0x8c8>
    174c:	00006097          	auipc	ra,0x6
    1750:	5fa080e7          	jalr	1530(ra) # 7d46 <printf>
    exit(1);
    1754:	4505                	li	a0,1
    1756:	00006097          	auipc	ra,0x6
    175a:	0c2080e7          	jalr	194(ra) # 7818 <exit>
  }

  n = 0;
    175e:	fe042423          	sw	zero,-24(s0)
  for(;;){
    i = read(fd, buf, BSIZE);
    1762:	fe442783          	lw	a5,-28(s0)
    1766:	40000613          	li	a2,1024
    176a:	0000a597          	auipc	a1,0xa
    176e:	ce658593          	addi	a1,a1,-794 # b450 <buf>
    1772:	853e                	mv	a0,a5
    1774:	00006097          	auipc	ra,0x6
    1778:	0bc080e7          	jalr	188(ra) # 7830 <read>
    177c:	87aa                	mv	a5,a0
    177e:	fef42623          	sw	a5,-20(s0)
    if(i == 0){
    1782:	fec42783          	lw	a5,-20(s0)
    1786:	2781                	sext.w	a5,a5
    1788:	eb9d                	bnez	a5,17be <writebig+0x172>
      if(n == MAXFILE - 1){
    178a:	fe842783          	lw	a5,-24(s0)
    178e:	0007871b          	sext.w	a4,a5
    1792:	10b00793          	li	a5,267
    1796:	0af71663          	bne	a4,a5,1842 <writebig+0x1f6>
        printf("%s: read only %d blocks from big", s, n);
    179a:	fe842783          	lw	a5,-24(s0)
    179e:	863e                	mv	a2,a5
    17a0:	fd843583          	ld	a1,-40(s0)
    17a4:	00007517          	auipc	a0,0x7
    17a8:	07c50513          	addi	a0,a0,124 # 8820 <malloc+0x8e8>
    17ac:	00006097          	auipc	ra,0x6
    17b0:	59a080e7          	jalr	1434(ra) # 7d46 <printf>
        exit(1);
    17b4:	4505                	li	a0,1
    17b6:	00006097          	auipc	ra,0x6
    17ba:	062080e7          	jalr	98(ra) # 7818 <exit>
      }
      break;
    } else if(i != BSIZE){
    17be:	fec42783          	lw	a5,-20(s0)
    17c2:	0007871b          	sext.w	a4,a5
    17c6:	40000793          	li	a5,1024
    17ca:	02f70463          	beq	a4,a5,17f2 <writebig+0x1a6>
      printf("%s: read failed %d\n", s, i);
    17ce:	fec42783          	lw	a5,-20(s0)
    17d2:	863e                	mv	a2,a5
    17d4:	fd843583          	ld	a1,-40(s0)
    17d8:	00007517          	auipc	a0,0x7
    17dc:	07050513          	addi	a0,a0,112 # 8848 <malloc+0x910>
    17e0:	00006097          	auipc	ra,0x6
    17e4:	566080e7          	jalr	1382(ra) # 7d46 <printf>
      exit(1);
    17e8:	4505                	li	a0,1
    17ea:	00006097          	auipc	ra,0x6
    17ee:	02e080e7          	jalr	46(ra) # 7818 <exit>
    }
    if(((int*)buf)[0] != n){
    17f2:	0000a797          	auipc	a5,0xa
    17f6:	c5e78793          	addi	a5,a5,-930 # b450 <buf>
    17fa:	4398                	lw	a4,0(a5)
    17fc:	fe842783          	lw	a5,-24(s0)
    1800:	2781                	sext.w	a5,a5
    1802:	02e78a63          	beq	a5,a4,1836 <writebig+0x1ea>
      printf("%s: read content of block %d is %d\n", s,
             n, ((int*)buf)[0]);
    1806:	0000a797          	auipc	a5,0xa
    180a:	c4a78793          	addi	a5,a5,-950 # b450 <buf>
      printf("%s: read content of block %d is %d\n", s,
    180e:	4398                	lw	a4,0(a5)
    1810:	fe842783          	lw	a5,-24(s0)
    1814:	86ba                	mv	a3,a4
    1816:	863e                	mv	a2,a5
    1818:	fd843583          	ld	a1,-40(s0)
    181c:	00007517          	auipc	a0,0x7
    1820:	04450513          	addi	a0,a0,68 # 8860 <malloc+0x928>
    1824:	00006097          	auipc	ra,0x6
    1828:	522080e7          	jalr	1314(ra) # 7d46 <printf>
      exit(1);
    182c:	4505                	li	a0,1
    182e:	00006097          	auipc	ra,0x6
    1832:	fea080e7          	jalr	-22(ra) # 7818 <exit>
    }
    n++;
    1836:	fe842783          	lw	a5,-24(s0)
    183a:	2785                	addiw	a5,a5,1
    183c:	fef42423          	sw	a5,-24(s0)
    i = read(fd, buf, BSIZE);
    1840:	b70d                	j	1762 <writebig+0x116>
      break;
    1842:	0001                	nop
  }
  close(fd);
    1844:	fe442783          	lw	a5,-28(s0)
    1848:	853e                	mv	a0,a5
    184a:	00006097          	auipc	ra,0x6
    184e:	ff6080e7          	jalr	-10(ra) # 7840 <close>
  if(unlink("big") < 0){
    1852:	00007517          	auipc	a0,0x7
    1856:	f5e50513          	addi	a0,a0,-162 # 87b0 <malloc+0x878>
    185a:	00006097          	auipc	ra,0x6
    185e:	00e080e7          	jalr	14(ra) # 7868 <unlink>
    1862:	87aa                	mv	a5,a0
    1864:	0207d163          	bgez	a5,1886 <writebig+0x23a>
    printf("%s: unlink big failed\n", s);
    1868:	fd843583          	ld	a1,-40(s0)
    186c:	00007517          	auipc	a0,0x7
    1870:	01c50513          	addi	a0,a0,28 # 8888 <malloc+0x950>
    1874:	00006097          	auipc	ra,0x6
    1878:	4d2080e7          	jalr	1234(ra) # 7d46 <printf>
    exit(1);
    187c:	4505                	li	a0,1
    187e:	00006097          	auipc	ra,0x6
    1882:	f9a080e7          	jalr	-102(ra) # 7818 <exit>
  }
}
    1886:	0001                	nop
    1888:	70a2                	ld	ra,40(sp)
    188a:	7402                	ld	s0,32(sp)
    188c:	6145                	addi	sp,sp,48
    188e:	8082                	ret

0000000000001890 <createtest>:

// many creates, followed by unlink test
void
createtest(char *s)
{
    1890:	7179                	addi	sp,sp,-48
    1892:	f406                	sd	ra,40(sp)
    1894:	f022                	sd	s0,32(sp)
    1896:	1800                	addi	s0,sp,48
    1898:	fca43c23          	sd	a0,-40(s0)
  int i, fd;
  enum { N=52 };

  char name[3];
  name[0] = 'a';
    189c:	06100793          	li	a5,97
    18a0:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    18a4:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    18a8:	fe042623          	sw	zero,-20(s0)
    18ac:	a099                	j	18f2 <createtest+0x62>
    name[1] = '0' + i;
    18ae:	fec42783          	lw	a5,-20(s0)
    18b2:	0ff7f793          	andi	a5,a5,255
    18b6:	0307879b          	addiw	a5,a5,48
    18ba:	0ff7f793          	andi	a5,a5,255
    18be:	fef400a3          	sb	a5,-31(s0)
    fd = open(name, O_CREATE|O_RDWR);
    18c2:	fe040793          	addi	a5,s0,-32
    18c6:	20200593          	li	a1,514
    18ca:	853e                	mv	a0,a5
    18cc:	00006097          	auipc	ra,0x6
    18d0:	f8c080e7          	jalr	-116(ra) # 7858 <open>
    18d4:	87aa                	mv	a5,a0
    18d6:	fef42423          	sw	a5,-24(s0)
    close(fd);
    18da:	fe842783          	lw	a5,-24(s0)
    18de:	853e                	mv	a0,a5
    18e0:	00006097          	auipc	ra,0x6
    18e4:	f60080e7          	jalr	-160(ra) # 7840 <close>
  for(i = 0; i < N; i++){
    18e8:	fec42783          	lw	a5,-20(s0)
    18ec:	2785                	addiw	a5,a5,1
    18ee:	fef42623          	sw	a5,-20(s0)
    18f2:	fec42783          	lw	a5,-20(s0)
    18f6:	0007871b          	sext.w	a4,a5
    18fa:	03300793          	li	a5,51
    18fe:	fae7d8e3          	bge	a5,a4,18ae <createtest+0x1e>
  }
  name[0] = 'a';
    1902:	06100793          	li	a5,97
    1906:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    190a:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    190e:	fe042623          	sw	zero,-20(s0)
    1912:	a03d                	j	1940 <createtest+0xb0>
    name[1] = '0' + i;
    1914:	fec42783          	lw	a5,-20(s0)
    1918:	0ff7f793          	andi	a5,a5,255
    191c:	0307879b          	addiw	a5,a5,48
    1920:	0ff7f793          	andi	a5,a5,255
    1924:	fef400a3          	sb	a5,-31(s0)
    unlink(name);
    1928:	fe040793          	addi	a5,s0,-32
    192c:	853e                	mv	a0,a5
    192e:	00006097          	auipc	ra,0x6
    1932:	f3a080e7          	jalr	-198(ra) # 7868 <unlink>
  for(i = 0; i < N; i++){
    1936:	fec42783          	lw	a5,-20(s0)
    193a:	2785                	addiw	a5,a5,1
    193c:	fef42623          	sw	a5,-20(s0)
    1940:	fec42783          	lw	a5,-20(s0)
    1944:	0007871b          	sext.w	a4,a5
    1948:	03300793          	li	a5,51
    194c:	fce7d4e3          	bge	a5,a4,1914 <createtest+0x84>
  }
}
    1950:	0001                	nop
    1952:	0001                	nop
    1954:	70a2                	ld	ra,40(sp)
    1956:	7402                	ld	s0,32(sp)
    1958:	6145                	addi	sp,sp,48
    195a:	8082                	ret

000000000000195c <dirtest>:

void dirtest(char *s)
{
    195c:	1101                	addi	sp,sp,-32
    195e:	ec06                	sd	ra,24(sp)
    1960:	e822                	sd	s0,16(sp)
    1962:	1000                	addi	s0,sp,32
    1964:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dir0") < 0){
    1968:	00007517          	auipc	a0,0x7
    196c:	f3850513          	addi	a0,a0,-200 # 88a0 <malloc+0x968>
    1970:	00006097          	auipc	ra,0x6
    1974:	f10080e7          	jalr	-240(ra) # 7880 <mkdir>
    1978:	87aa                	mv	a5,a0
    197a:	0207d163          	bgez	a5,199c <dirtest+0x40>
    printf("%s: mkdir failed\n", s);
    197e:	fe843583          	ld	a1,-24(s0)
    1982:	00007517          	auipc	a0,0x7
    1986:	bee50513          	addi	a0,a0,-1042 # 8570 <malloc+0x638>
    198a:	00006097          	auipc	ra,0x6
    198e:	3bc080e7          	jalr	956(ra) # 7d46 <printf>
    exit(1);
    1992:	4505                	li	a0,1
    1994:	00006097          	auipc	ra,0x6
    1998:	e84080e7          	jalr	-380(ra) # 7818 <exit>
  }

  if(chdir("dir0") < 0){
    199c:	00007517          	auipc	a0,0x7
    19a0:	f0450513          	addi	a0,a0,-252 # 88a0 <malloc+0x968>
    19a4:	00006097          	auipc	ra,0x6
    19a8:	ee4080e7          	jalr	-284(ra) # 7888 <chdir>
    19ac:	87aa                	mv	a5,a0
    19ae:	0207d163          	bgez	a5,19d0 <dirtest+0x74>
    printf("%s: chdir dir0 failed\n", s);
    19b2:	fe843583          	ld	a1,-24(s0)
    19b6:	00007517          	auipc	a0,0x7
    19ba:	ef250513          	addi	a0,a0,-270 # 88a8 <malloc+0x970>
    19be:	00006097          	auipc	ra,0x6
    19c2:	388080e7          	jalr	904(ra) # 7d46 <printf>
    exit(1);
    19c6:	4505                	li	a0,1
    19c8:	00006097          	auipc	ra,0x6
    19cc:	e50080e7          	jalr	-432(ra) # 7818 <exit>
  }

  if(chdir("..") < 0){
    19d0:	00007517          	auipc	a0,0x7
    19d4:	ef050513          	addi	a0,a0,-272 # 88c0 <malloc+0x988>
    19d8:	00006097          	auipc	ra,0x6
    19dc:	eb0080e7          	jalr	-336(ra) # 7888 <chdir>
    19e0:	87aa                	mv	a5,a0
    19e2:	0207d163          	bgez	a5,1a04 <dirtest+0xa8>
    printf("%s: chdir .. failed\n", s);
    19e6:	fe843583          	ld	a1,-24(s0)
    19ea:	00007517          	auipc	a0,0x7
    19ee:	ede50513          	addi	a0,a0,-290 # 88c8 <malloc+0x990>
    19f2:	00006097          	auipc	ra,0x6
    19f6:	354080e7          	jalr	852(ra) # 7d46 <printf>
    exit(1);
    19fa:	4505                	li	a0,1
    19fc:	00006097          	auipc	ra,0x6
    1a00:	e1c080e7          	jalr	-484(ra) # 7818 <exit>
  }

  if(unlink("dir0") < 0){
    1a04:	00007517          	auipc	a0,0x7
    1a08:	e9c50513          	addi	a0,a0,-356 # 88a0 <malloc+0x968>
    1a0c:	00006097          	auipc	ra,0x6
    1a10:	e5c080e7          	jalr	-420(ra) # 7868 <unlink>
    1a14:	87aa                	mv	a5,a0
    1a16:	0207d163          	bgez	a5,1a38 <dirtest+0xdc>
    printf("%s: unlink dir0 failed\n", s);
    1a1a:	fe843583          	ld	a1,-24(s0)
    1a1e:	00007517          	auipc	a0,0x7
    1a22:	ec250513          	addi	a0,a0,-318 # 88e0 <malloc+0x9a8>
    1a26:	00006097          	auipc	ra,0x6
    1a2a:	320080e7          	jalr	800(ra) # 7d46 <printf>
    exit(1);
    1a2e:	4505                	li	a0,1
    1a30:	00006097          	auipc	ra,0x6
    1a34:	de8080e7          	jalr	-536(ra) # 7818 <exit>
  }
}
    1a38:	0001                	nop
    1a3a:	60e2                	ld	ra,24(sp)
    1a3c:	6442                	ld	s0,16(sp)
    1a3e:	6105                	addi	sp,sp,32
    1a40:	8082                	ret

0000000000001a42 <exectest>:

void
exectest(char *s)
{
    1a42:	715d                	addi	sp,sp,-80
    1a44:	e486                	sd	ra,72(sp)
    1a46:	e0a2                	sd	s0,64(sp)
    1a48:	0880                	addi	s0,sp,80
    1a4a:	faa43c23          	sd	a0,-72(s0)
  int fd, xstatus, pid;
  char *echoargv[] = { "echo", "OK", 0 };
    1a4e:	00007797          	auipc	a5,0x7
    1a52:	87278793          	addi	a5,a5,-1934 # 82c0 <malloc+0x388>
    1a56:	fcf43423          	sd	a5,-56(s0)
    1a5a:	00007797          	auipc	a5,0x7
    1a5e:	e9e78793          	addi	a5,a5,-354 # 88f8 <malloc+0x9c0>
    1a62:	fcf43823          	sd	a5,-48(s0)
    1a66:	fc043c23          	sd	zero,-40(s0)
  char buf[3];

  unlink("echo-ok");
    1a6a:	00007517          	auipc	a0,0x7
    1a6e:	e9650513          	addi	a0,a0,-362 # 8900 <malloc+0x9c8>
    1a72:	00006097          	auipc	ra,0x6
    1a76:	df6080e7          	jalr	-522(ra) # 7868 <unlink>
  pid = fork();
    1a7a:	00006097          	auipc	ra,0x6
    1a7e:	d96080e7          	jalr	-618(ra) # 7810 <fork>
    1a82:	87aa                	mv	a5,a0
    1a84:	fef42623          	sw	a5,-20(s0)
  if(pid < 0) {
    1a88:	fec42783          	lw	a5,-20(s0)
    1a8c:	2781                	sext.w	a5,a5
    1a8e:	0207d163          	bgez	a5,1ab0 <exectest+0x6e>
     printf("%s: fork failed\n", s);
    1a92:	fb843583          	ld	a1,-72(s0)
    1a96:	00007517          	auipc	a0,0x7
    1a9a:	a4a50513          	addi	a0,a0,-1462 # 84e0 <malloc+0x5a8>
    1a9e:	00006097          	auipc	ra,0x6
    1aa2:	2a8080e7          	jalr	680(ra) # 7d46 <printf>
     exit(1);
    1aa6:	4505                	li	a0,1
    1aa8:	00006097          	auipc	ra,0x6
    1aac:	d70080e7          	jalr	-656(ra) # 7818 <exit>
  }
  if(pid == 0) {
    1ab0:	fec42783          	lw	a5,-20(s0)
    1ab4:	2781                	sext.w	a5,a5
    1ab6:	ebd5                	bnez	a5,1b6a <exectest+0x128>
    close(1);
    1ab8:	4505                	li	a0,1
    1aba:	00006097          	auipc	ra,0x6
    1abe:	d86080e7          	jalr	-634(ra) # 7840 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1ac2:	20100593          	li	a1,513
    1ac6:	00007517          	auipc	a0,0x7
    1aca:	e3a50513          	addi	a0,a0,-454 # 8900 <malloc+0x9c8>
    1ace:	00006097          	auipc	ra,0x6
    1ad2:	d8a080e7          	jalr	-630(ra) # 7858 <open>
    1ad6:	87aa                	mv	a5,a0
    1ad8:	fef42423          	sw	a5,-24(s0)
    if(fd < 0) {
    1adc:	fe842783          	lw	a5,-24(s0)
    1ae0:	2781                	sext.w	a5,a5
    1ae2:	0207d163          	bgez	a5,1b04 <exectest+0xc2>
      printf("%s: create failed\n", s);
    1ae6:	fb843583          	ld	a1,-72(s0)
    1aea:	00007517          	auipc	a0,0x7
    1aee:	e1e50513          	addi	a0,a0,-482 # 8908 <malloc+0x9d0>
    1af2:	00006097          	auipc	ra,0x6
    1af6:	254080e7          	jalr	596(ra) # 7d46 <printf>
      exit(1);
    1afa:	4505                	li	a0,1
    1afc:	00006097          	auipc	ra,0x6
    1b00:	d1c080e7          	jalr	-740(ra) # 7818 <exit>
    }
    if(fd != 1) {
    1b04:	fe842783          	lw	a5,-24(s0)
    1b08:	0007871b          	sext.w	a4,a5
    1b0c:	4785                	li	a5,1
    1b0e:	02f70163          	beq	a4,a5,1b30 <exectest+0xee>
      printf("%s: wrong fd\n", s);
    1b12:	fb843583          	ld	a1,-72(s0)
    1b16:	00007517          	auipc	a0,0x7
    1b1a:	e0a50513          	addi	a0,a0,-502 # 8920 <malloc+0x9e8>
    1b1e:	00006097          	auipc	ra,0x6
    1b22:	228080e7          	jalr	552(ra) # 7d46 <printf>
      exit(1);
    1b26:	4505                	li	a0,1
    1b28:	00006097          	auipc	ra,0x6
    1b2c:	cf0080e7          	jalr	-784(ra) # 7818 <exit>
    }
    if(exec("echo", echoargv) < 0){
    1b30:	fc840793          	addi	a5,s0,-56
    1b34:	85be                	mv	a1,a5
    1b36:	00006517          	auipc	a0,0x6
    1b3a:	78a50513          	addi	a0,a0,1930 # 82c0 <malloc+0x388>
    1b3e:	00006097          	auipc	ra,0x6
    1b42:	d12080e7          	jalr	-750(ra) # 7850 <exec>
    1b46:	87aa                	mv	a5,a0
    1b48:	0207d163          	bgez	a5,1b6a <exectest+0x128>
      printf("%s: exec echo failed\n", s);
    1b4c:	fb843583          	ld	a1,-72(s0)
    1b50:	00007517          	auipc	a0,0x7
    1b54:	de050513          	addi	a0,a0,-544 # 8930 <malloc+0x9f8>
    1b58:	00006097          	auipc	ra,0x6
    1b5c:	1ee080e7          	jalr	494(ra) # 7d46 <printf>
      exit(1);
    1b60:	4505                	li	a0,1
    1b62:	00006097          	auipc	ra,0x6
    1b66:	cb6080e7          	jalr	-842(ra) # 7818 <exit>
    }
    // won't get to here
  }
  if (wait(&xstatus) != pid) {
    1b6a:	fe440793          	addi	a5,s0,-28
    1b6e:	853e                	mv	a0,a5
    1b70:	00006097          	auipc	ra,0x6
    1b74:	cb0080e7          	jalr	-848(ra) # 7820 <wait>
    1b78:	87aa                	mv	a5,a0
    1b7a:	873e                	mv	a4,a5
    1b7c:	fec42783          	lw	a5,-20(s0)
    1b80:	2781                	sext.w	a5,a5
    1b82:	00e78c63          	beq	a5,a4,1b9a <exectest+0x158>
    printf("%s: wait failed!\n", s);
    1b86:	fb843583          	ld	a1,-72(s0)
    1b8a:	00007517          	auipc	a0,0x7
    1b8e:	dbe50513          	addi	a0,a0,-578 # 8948 <malloc+0xa10>
    1b92:	00006097          	auipc	ra,0x6
    1b96:	1b4080e7          	jalr	436(ra) # 7d46 <printf>
  }
  if(xstatus != 0)
    1b9a:	fe442783          	lw	a5,-28(s0)
    1b9e:	cb81                	beqz	a5,1bae <exectest+0x16c>
    exit(xstatus);
    1ba0:	fe442783          	lw	a5,-28(s0)
    1ba4:	853e                	mv	a0,a5
    1ba6:	00006097          	auipc	ra,0x6
    1baa:	c72080e7          	jalr	-910(ra) # 7818 <exit>

  fd = open("echo-ok", O_RDONLY);
    1bae:	4581                	li	a1,0
    1bb0:	00007517          	auipc	a0,0x7
    1bb4:	d5050513          	addi	a0,a0,-688 # 8900 <malloc+0x9c8>
    1bb8:	00006097          	auipc	ra,0x6
    1bbc:	ca0080e7          	jalr	-864(ra) # 7858 <open>
    1bc0:	87aa                	mv	a5,a0
    1bc2:	fef42423          	sw	a5,-24(s0)
  if(fd < 0) {
    1bc6:	fe842783          	lw	a5,-24(s0)
    1bca:	2781                	sext.w	a5,a5
    1bcc:	0207d163          	bgez	a5,1bee <exectest+0x1ac>
    printf("%s: open failed\n", s);
    1bd0:	fb843583          	ld	a1,-72(s0)
    1bd4:	00007517          	auipc	a0,0x7
    1bd8:	92450513          	addi	a0,a0,-1756 # 84f8 <malloc+0x5c0>
    1bdc:	00006097          	auipc	ra,0x6
    1be0:	16a080e7          	jalr	362(ra) # 7d46 <printf>
    exit(1);
    1be4:	4505                	li	a0,1
    1be6:	00006097          	auipc	ra,0x6
    1bea:	c32080e7          	jalr	-974(ra) # 7818 <exit>
  }
  if (read(fd, buf, 2) != 2) {
    1bee:	fc040713          	addi	a4,s0,-64
    1bf2:	fe842783          	lw	a5,-24(s0)
    1bf6:	4609                	li	a2,2
    1bf8:	85ba                	mv	a1,a4
    1bfa:	853e                	mv	a0,a5
    1bfc:	00006097          	auipc	ra,0x6
    1c00:	c34080e7          	jalr	-972(ra) # 7830 <read>
    1c04:	87aa                	mv	a5,a0
    1c06:	873e                	mv	a4,a5
    1c08:	4789                	li	a5,2
    1c0a:	02f70163          	beq	a4,a5,1c2c <exectest+0x1ea>
    printf("%s: read failed\n", s);
    1c0e:	fb843583          	ld	a1,-72(s0)
    1c12:	00007517          	auipc	a0,0x7
    1c16:	b6650513          	addi	a0,a0,-1178 # 8778 <malloc+0x840>
    1c1a:	00006097          	auipc	ra,0x6
    1c1e:	12c080e7          	jalr	300(ra) # 7d46 <printf>
    exit(1);
    1c22:	4505                	li	a0,1
    1c24:	00006097          	auipc	ra,0x6
    1c28:	bf4080e7          	jalr	-1036(ra) # 7818 <exit>
  }
  unlink("echo-ok");
    1c2c:	00007517          	auipc	a0,0x7
    1c30:	cd450513          	addi	a0,a0,-812 # 8900 <malloc+0x9c8>
    1c34:	00006097          	auipc	ra,0x6
    1c38:	c34080e7          	jalr	-972(ra) # 7868 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1c3c:	fc044783          	lbu	a5,-64(s0)
    1c40:	873e                	mv	a4,a5
    1c42:	04f00793          	li	a5,79
    1c46:	00f71e63          	bne	a4,a5,1c62 <exectest+0x220>
    1c4a:	fc144783          	lbu	a5,-63(s0)
    1c4e:	873e                	mv	a4,a5
    1c50:	04b00793          	li	a5,75
    1c54:	00f71763          	bne	a4,a5,1c62 <exectest+0x220>
    exit(0);
    1c58:	4501                	li	a0,0
    1c5a:	00006097          	auipc	ra,0x6
    1c5e:	bbe080e7          	jalr	-1090(ra) # 7818 <exit>
  else {
    printf("%s: wrong output\n", s);
    1c62:	fb843583          	ld	a1,-72(s0)
    1c66:	00007517          	auipc	a0,0x7
    1c6a:	cfa50513          	addi	a0,a0,-774 # 8960 <malloc+0xa28>
    1c6e:	00006097          	auipc	ra,0x6
    1c72:	0d8080e7          	jalr	216(ra) # 7d46 <printf>
    exit(1);
    1c76:	4505                	li	a0,1
    1c78:	00006097          	auipc	ra,0x6
    1c7c:	ba0080e7          	jalr	-1120(ra) # 7818 <exit>

0000000000001c80 <pipe1>:

// simple fork and pipe read/write

void
pipe1(char *s)
{
    1c80:	715d                	addi	sp,sp,-80
    1c82:	e486                	sd	ra,72(sp)
    1c84:	e0a2                	sd	s0,64(sp)
    1c86:	0880                	addi	s0,sp,80
    1c88:	faa43c23          	sd	a0,-72(s0)
  int fds[2], pid, xstatus;
  int seq, i, n, cc, total;
  enum { N=5, SZ=1033 };

  if(pipe(fds) != 0){
    1c8c:	fd040793          	addi	a5,s0,-48
    1c90:	853e                	mv	a0,a5
    1c92:	00006097          	auipc	ra,0x6
    1c96:	b96080e7          	jalr	-1130(ra) # 7828 <pipe>
    1c9a:	87aa                	mv	a5,a0
    1c9c:	c385                	beqz	a5,1cbc <pipe1+0x3c>
    printf("%s: pipe() failed\n", s);
    1c9e:	fb843583          	ld	a1,-72(s0)
    1ca2:	00007517          	auipc	a0,0x7
    1ca6:	cd650513          	addi	a0,a0,-810 # 8978 <malloc+0xa40>
    1caa:	00006097          	auipc	ra,0x6
    1cae:	09c080e7          	jalr	156(ra) # 7d46 <printf>
    exit(1);
    1cb2:	4505                	li	a0,1
    1cb4:	00006097          	auipc	ra,0x6
    1cb8:	b64080e7          	jalr	-1180(ra) # 7818 <exit>
  }
  pid = fork();
    1cbc:	00006097          	auipc	ra,0x6
    1cc0:	b54080e7          	jalr	-1196(ra) # 7810 <fork>
    1cc4:	87aa                	mv	a5,a0
    1cc6:	fcf42c23          	sw	a5,-40(s0)
  seq = 0;
    1cca:	fe042623          	sw	zero,-20(s0)
  if(pid == 0){
    1cce:	fd842783          	lw	a5,-40(s0)
    1cd2:	2781                	sext.w	a5,a5
    1cd4:	efdd                	bnez	a5,1d92 <pipe1+0x112>
    close(fds[0]);
    1cd6:	fd042783          	lw	a5,-48(s0)
    1cda:	853e                	mv	a0,a5
    1cdc:	00006097          	auipc	ra,0x6
    1ce0:	b64080e7          	jalr	-1180(ra) # 7840 <close>
    for(n = 0; n < N; n++){
    1ce4:	fe042223          	sw	zero,-28(s0)
    1ce8:	a849                	j	1d7a <pipe1+0xfa>
      for(i = 0; i < SZ; i++)
    1cea:	fe042423          	sw	zero,-24(s0)
    1cee:	a03d                	j	1d1c <pipe1+0x9c>
        buf[i] = seq++;
    1cf0:	fec42783          	lw	a5,-20(s0)
    1cf4:	0017871b          	addiw	a4,a5,1
    1cf8:	fee42623          	sw	a4,-20(s0)
    1cfc:	0ff7f713          	andi	a4,a5,255
    1d00:	00009697          	auipc	a3,0x9
    1d04:	75068693          	addi	a3,a3,1872 # b450 <buf>
    1d08:	fe842783          	lw	a5,-24(s0)
    1d0c:	97b6                	add	a5,a5,a3
    1d0e:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1d12:	fe842783          	lw	a5,-24(s0)
    1d16:	2785                	addiw	a5,a5,1
    1d18:	fef42423          	sw	a5,-24(s0)
    1d1c:	fe842783          	lw	a5,-24(s0)
    1d20:	0007871b          	sext.w	a4,a5
    1d24:	40800793          	li	a5,1032
    1d28:	fce7d4e3          	bge	a5,a4,1cf0 <pipe1+0x70>
      if(write(fds[1], buf, SZ) != SZ){
    1d2c:	fd442783          	lw	a5,-44(s0)
    1d30:	40900613          	li	a2,1033
    1d34:	00009597          	auipc	a1,0x9
    1d38:	71c58593          	addi	a1,a1,1820 # b450 <buf>
    1d3c:	853e                	mv	a0,a5
    1d3e:	00006097          	auipc	ra,0x6
    1d42:	afa080e7          	jalr	-1286(ra) # 7838 <write>
    1d46:	87aa                	mv	a5,a0
    1d48:	873e                	mv	a4,a5
    1d4a:	40900793          	li	a5,1033
    1d4e:	02f70163          	beq	a4,a5,1d70 <pipe1+0xf0>
        printf("%s: pipe1 oops 1\n", s);
    1d52:	fb843583          	ld	a1,-72(s0)
    1d56:	00007517          	auipc	a0,0x7
    1d5a:	c3a50513          	addi	a0,a0,-966 # 8990 <malloc+0xa58>
    1d5e:	00006097          	auipc	ra,0x6
    1d62:	fe8080e7          	jalr	-24(ra) # 7d46 <printf>
        exit(1);
    1d66:	4505                	li	a0,1
    1d68:	00006097          	auipc	ra,0x6
    1d6c:	ab0080e7          	jalr	-1360(ra) # 7818 <exit>
    for(n = 0; n < N; n++){
    1d70:	fe442783          	lw	a5,-28(s0)
    1d74:	2785                	addiw	a5,a5,1
    1d76:	fef42223          	sw	a5,-28(s0)
    1d7a:	fe442783          	lw	a5,-28(s0)
    1d7e:	0007871b          	sext.w	a4,a5
    1d82:	4791                	li	a5,4
    1d84:	f6e7d3e3          	bge	a5,a4,1cea <pipe1+0x6a>
      }
    }
    exit(0);
    1d88:	4501                	li	a0,0
    1d8a:	00006097          	auipc	ra,0x6
    1d8e:	a8e080e7          	jalr	-1394(ra) # 7818 <exit>
  } else if(pid > 0){
    1d92:	fd842783          	lw	a5,-40(s0)
    1d96:	2781                	sext.w	a5,a5
    1d98:	12f05b63          	blez	a5,1ece <pipe1+0x24e>
    close(fds[1]);
    1d9c:	fd442783          	lw	a5,-44(s0)
    1da0:	853e                	mv	a0,a5
    1da2:	00006097          	auipc	ra,0x6
    1da6:	a9e080e7          	jalr	-1378(ra) # 7840 <close>
    total = 0;
    1daa:	fc042e23          	sw	zero,-36(s0)
    cc = 1;
    1dae:	4785                	li	a5,1
    1db0:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1db4:	a849                	j	1e46 <pipe1+0x1c6>
      for(i = 0; i < n; i++){
    1db6:	fe042423          	sw	zero,-24(s0)
    1dba:	a881                	j	1e0a <pipe1+0x18a>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1dbc:	00009717          	auipc	a4,0x9
    1dc0:	69470713          	addi	a4,a4,1684 # b450 <buf>
    1dc4:	fe842783          	lw	a5,-24(s0)
    1dc8:	97ba                	add	a5,a5,a4
    1dca:	0007c783          	lbu	a5,0(a5)
    1dce:	0007869b          	sext.w	a3,a5
    1dd2:	fec42783          	lw	a5,-20(s0)
    1dd6:	0017871b          	addiw	a4,a5,1
    1dda:	fee42623          	sw	a4,-20(s0)
    1dde:	0ff7f793          	andi	a5,a5,255
    1de2:	2781                	sext.w	a5,a5
    1de4:	8736                	mv	a4,a3
    1de6:	00f70d63          	beq	a4,a5,1e00 <pipe1+0x180>
          printf("%s: pipe1 oops 2\n", s);
    1dea:	fb843583          	ld	a1,-72(s0)
    1dee:	00007517          	auipc	a0,0x7
    1df2:	bba50513          	addi	a0,a0,-1094 # 89a8 <malloc+0xa70>
    1df6:	00006097          	auipc	ra,0x6
    1dfa:	f50080e7          	jalr	-176(ra) # 7d46 <printf>
          return;
    1dfe:	a0fd                	j	1eec <pipe1+0x26c>
      for(i = 0; i < n; i++){
    1e00:	fe842783          	lw	a5,-24(s0)
    1e04:	2785                	addiw	a5,a5,1
    1e06:	fef42423          	sw	a5,-24(s0)
    1e0a:	fe842703          	lw	a4,-24(s0)
    1e0e:	fe442783          	lw	a5,-28(s0)
    1e12:	2701                	sext.w	a4,a4
    1e14:	2781                	sext.w	a5,a5
    1e16:	faf743e3          	blt	a4,a5,1dbc <pipe1+0x13c>
        }
      }
      total += n;
    1e1a:	fdc42703          	lw	a4,-36(s0)
    1e1e:	fe442783          	lw	a5,-28(s0)
    1e22:	9fb9                	addw	a5,a5,a4
    1e24:	fcf42e23          	sw	a5,-36(s0)
      cc = cc * 2;
    1e28:	fe042783          	lw	a5,-32(s0)
    1e2c:	0017979b          	slliw	a5,a5,0x1
    1e30:	fef42023          	sw	a5,-32(s0)
      if(cc > sizeof(buf))
    1e34:	fe042783          	lw	a5,-32(s0)
    1e38:	873e                	mv	a4,a5
    1e3a:	678d                	lui	a5,0x3
    1e3c:	00e7f563          	bgeu	a5,a4,1e46 <pipe1+0x1c6>
        cc = sizeof(buf);
    1e40:	678d                	lui	a5,0x3
    1e42:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1e46:	fd042783          	lw	a5,-48(s0)
    1e4a:	fe042703          	lw	a4,-32(s0)
    1e4e:	863a                	mv	a2,a4
    1e50:	00009597          	auipc	a1,0x9
    1e54:	60058593          	addi	a1,a1,1536 # b450 <buf>
    1e58:	853e                	mv	a0,a5
    1e5a:	00006097          	auipc	ra,0x6
    1e5e:	9d6080e7          	jalr	-1578(ra) # 7830 <read>
    1e62:	87aa                	mv	a5,a0
    1e64:	fef42223          	sw	a5,-28(s0)
    1e68:	fe442783          	lw	a5,-28(s0)
    1e6c:	2781                	sext.w	a5,a5
    1e6e:	f4f044e3          	bgtz	a5,1db6 <pipe1+0x136>
    }
    if(total != N * SZ){
    1e72:	fdc42783          	lw	a5,-36(s0)
    1e76:	0007871b          	sext.w	a4,a5
    1e7a:	6785                	lui	a5,0x1
    1e7c:	42d78793          	addi	a5,a5,1069 # 142d <opentest+0x67>
    1e80:	02f70263          	beq	a4,a5,1ea4 <pipe1+0x224>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1e84:	fdc42783          	lw	a5,-36(s0)
    1e88:	85be                	mv	a1,a5
    1e8a:	00007517          	auipc	a0,0x7
    1e8e:	b3650513          	addi	a0,a0,-1226 # 89c0 <malloc+0xa88>
    1e92:	00006097          	auipc	ra,0x6
    1e96:	eb4080e7          	jalr	-332(ra) # 7d46 <printf>
      exit(1);
    1e9a:	4505                	li	a0,1
    1e9c:	00006097          	auipc	ra,0x6
    1ea0:	97c080e7          	jalr	-1668(ra) # 7818 <exit>
    }
    close(fds[0]);
    1ea4:	fd042783          	lw	a5,-48(s0)
    1ea8:	853e                	mv	a0,a5
    1eaa:	00006097          	auipc	ra,0x6
    1eae:	996080e7          	jalr	-1642(ra) # 7840 <close>
    wait(&xstatus);
    1eb2:	fcc40793          	addi	a5,s0,-52
    1eb6:	853e                	mv	a0,a5
    1eb8:	00006097          	auipc	ra,0x6
    1ebc:	968080e7          	jalr	-1688(ra) # 7820 <wait>
    exit(xstatus);
    1ec0:	fcc42783          	lw	a5,-52(s0)
    1ec4:	853e                	mv	a0,a5
    1ec6:	00006097          	auipc	ra,0x6
    1eca:	952080e7          	jalr	-1710(ra) # 7818 <exit>
  } else {
    printf("%s: fork() failed\n", s);
    1ece:	fb843583          	ld	a1,-72(s0)
    1ed2:	00007517          	auipc	a0,0x7
    1ed6:	b0e50513          	addi	a0,a0,-1266 # 89e0 <malloc+0xaa8>
    1eda:	00006097          	auipc	ra,0x6
    1ede:	e6c080e7          	jalr	-404(ra) # 7d46 <printf>
    exit(1);
    1ee2:	4505                	li	a0,1
    1ee4:	00006097          	auipc	ra,0x6
    1ee8:	934080e7          	jalr	-1740(ra) # 7818 <exit>
  }
}
    1eec:	60a6                	ld	ra,72(sp)
    1eee:	6406                	ld	s0,64(sp)
    1ef0:	6161                	addi	sp,sp,80
    1ef2:	8082                	ret

0000000000001ef4 <killstatus>:


// test if child is killed (status = -1)
void
killstatus(char *s)
{
    1ef4:	7179                	addi	sp,sp,-48
    1ef6:	f406                	sd	ra,40(sp)
    1ef8:	f022                	sd	s0,32(sp)
    1efa:	1800                	addi	s0,sp,48
    1efc:	fca43c23          	sd	a0,-40(s0)
  int xst;

  for(int i = 0; i < 100; i++){
    1f00:	fe042623          	sw	zero,-20(s0)
    1f04:	a055                	j	1fa8 <killstatus+0xb4>
    int pid1 = fork();
    1f06:	00006097          	auipc	ra,0x6
    1f0a:	90a080e7          	jalr	-1782(ra) # 7810 <fork>
    1f0e:	87aa                	mv	a5,a0
    1f10:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    1f14:	fe842783          	lw	a5,-24(s0)
    1f18:	2781                	sext.w	a5,a5
    1f1a:	0207d163          	bgez	a5,1f3c <killstatus+0x48>
      printf("%s: fork failed\n", s);
    1f1e:	fd843583          	ld	a1,-40(s0)
    1f22:	00006517          	auipc	a0,0x6
    1f26:	5be50513          	addi	a0,a0,1470 # 84e0 <malloc+0x5a8>
    1f2a:	00006097          	auipc	ra,0x6
    1f2e:	e1c080e7          	jalr	-484(ra) # 7d46 <printf>
      exit(1);
    1f32:	4505                	li	a0,1
    1f34:	00006097          	auipc	ra,0x6
    1f38:	8e4080e7          	jalr	-1820(ra) # 7818 <exit>
    }
    if(pid1 == 0){
    1f3c:	fe842783          	lw	a5,-24(s0)
    1f40:	2781                	sext.w	a5,a5
    1f42:	e791                	bnez	a5,1f4e <killstatus+0x5a>
      while(1) {
        getpid();
    1f44:	00006097          	auipc	ra,0x6
    1f48:	954080e7          	jalr	-1708(ra) # 7898 <getpid>
    1f4c:	bfe5                	j	1f44 <killstatus+0x50>
      }
      exit(0);
    }
    sleep(1);
    1f4e:	4505                	li	a0,1
    1f50:	00006097          	auipc	ra,0x6
    1f54:	958080e7          	jalr	-1704(ra) # 78a8 <sleep>
    kill(pid1);
    1f58:	fe842783          	lw	a5,-24(s0)
    1f5c:	853e                	mv	a0,a5
    1f5e:	00006097          	auipc	ra,0x6
    1f62:	8ea080e7          	jalr	-1814(ra) # 7848 <kill>
    wait(&xst);
    1f66:	fe440793          	addi	a5,s0,-28
    1f6a:	853e                	mv	a0,a5
    1f6c:	00006097          	auipc	ra,0x6
    1f70:	8b4080e7          	jalr	-1868(ra) # 7820 <wait>
    if(xst != -1) {
    1f74:	fe442783          	lw	a5,-28(s0)
    1f78:	873e                	mv	a4,a5
    1f7a:	57fd                	li	a5,-1
    1f7c:	02f70163          	beq	a4,a5,1f9e <killstatus+0xaa>
       printf("%s: status should be -1\n", s);
    1f80:	fd843583          	ld	a1,-40(s0)
    1f84:	00007517          	auipc	a0,0x7
    1f88:	a7450513          	addi	a0,a0,-1420 # 89f8 <malloc+0xac0>
    1f8c:	00006097          	auipc	ra,0x6
    1f90:	dba080e7          	jalr	-582(ra) # 7d46 <printf>
       exit(1);
    1f94:	4505                	li	a0,1
    1f96:	00006097          	auipc	ra,0x6
    1f9a:	882080e7          	jalr	-1918(ra) # 7818 <exit>
  for(int i = 0; i < 100; i++){
    1f9e:	fec42783          	lw	a5,-20(s0)
    1fa2:	2785                	addiw	a5,a5,1
    1fa4:	fef42623          	sw	a5,-20(s0)
    1fa8:	fec42783          	lw	a5,-20(s0)
    1fac:	0007871b          	sext.w	a4,a5
    1fb0:	06300793          	li	a5,99
    1fb4:	f4e7d9e3          	bge	a5,a4,1f06 <killstatus+0x12>
    }
  }
  exit(0);
    1fb8:	4501                	li	a0,0
    1fba:	00006097          	auipc	ra,0x6
    1fbe:	85e080e7          	jalr	-1954(ra) # 7818 <exit>

0000000000001fc2 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(char *s)
{
    1fc2:	7139                	addi	sp,sp,-64
    1fc4:	fc06                	sd	ra,56(sp)
    1fc6:	f822                	sd	s0,48(sp)
    1fc8:	0080                	addi	s0,sp,64
    1fca:	fca43423          	sd	a0,-56(s0)
  int pid1, pid2, pid3;
  int pfds[2];

  pid1 = fork();
    1fce:	00006097          	auipc	ra,0x6
    1fd2:	842080e7          	jalr	-1982(ra) # 7810 <fork>
    1fd6:	87aa                	mv	a5,a0
    1fd8:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0) {
    1fdc:	fec42783          	lw	a5,-20(s0)
    1fe0:	2781                	sext.w	a5,a5
    1fe2:	0207d163          	bgez	a5,2004 <preempt+0x42>
    printf("%s: fork failed", s);
    1fe6:	fc843583          	ld	a1,-56(s0)
    1fea:	00007517          	auipc	a0,0x7
    1fee:	a2e50513          	addi	a0,a0,-1490 # 8a18 <malloc+0xae0>
    1ff2:	00006097          	auipc	ra,0x6
    1ff6:	d54080e7          	jalr	-684(ra) # 7d46 <printf>
    exit(1);
    1ffa:	4505                	li	a0,1
    1ffc:	00006097          	auipc	ra,0x6
    2000:	81c080e7          	jalr	-2020(ra) # 7818 <exit>
  }
  if(pid1 == 0)
    2004:	fec42783          	lw	a5,-20(s0)
    2008:	2781                	sext.w	a5,a5
    200a:	e391                	bnez	a5,200e <preempt+0x4c>
    for(;;)
    200c:	a001                	j	200c <preempt+0x4a>
      ;

  pid2 = fork();
    200e:	00006097          	auipc	ra,0x6
    2012:	802080e7          	jalr	-2046(ra) # 7810 <fork>
    2016:	87aa                	mv	a5,a0
    2018:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0) {
    201c:	fe842783          	lw	a5,-24(s0)
    2020:	2781                	sext.w	a5,a5
    2022:	0207d163          	bgez	a5,2044 <preempt+0x82>
    printf("%s: fork failed\n", s);
    2026:	fc843583          	ld	a1,-56(s0)
    202a:	00006517          	auipc	a0,0x6
    202e:	4b650513          	addi	a0,a0,1206 # 84e0 <malloc+0x5a8>
    2032:	00006097          	auipc	ra,0x6
    2036:	d14080e7          	jalr	-748(ra) # 7d46 <printf>
    exit(1);
    203a:	4505                	li	a0,1
    203c:	00005097          	auipc	ra,0x5
    2040:	7dc080e7          	jalr	2012(ra) # 7818 <exit>
  }
  if(pid2 == 0)
    2044:	fe842783          	lw	a5,-24(s0)
    2048:	2781                	sext.w	a5,a5
    204a:	e391                	bnez	a5,204e <preempt+0x8c>
    for(;;)
    204c:	a001                	j	204c <preempt+0x8a>
      ;

  pipe(pfds);
    204e:	fd840793          	addi	a5,s0,-40
    2052:	853e                	mv	a0,a5
    2054:	00005097          	auipc	ra,0x5
    2058:	7d4080e7          	jalr	2004(ra) # 7828 <pipe>
  pid3 = fork();
    205c:	00005097          	auipc	ra,0x5
    2060:	7b4080e7          	jalr	1972(ra) # 7810 <fork>
    2064:	87aa                	mv	a5,a0
    2066:	fef42223          	sw	a5,-28(s0)
  if(pid3 < 0) {
    206a:	fe442783          	lw	a5,-28(s0)
    206e:	2781                	sext.w	a5,a5
    2070:	0207d163          	bgez	a5,2092 <preempt+0xd0>
     printf("%s: fork failed\n", s);
    2074:	fc843583          	ld	a1,-56(s0)
    2078:	00006517          	auipc	a0,0x6
    207c:	46850513          	addi	a0,a0,1128 # 84e0 <malloc+0x5a8>
    2080:	00006097          	auipc	ra,0x6
    2084:	cc6080e7          	jalr	-826(ra) # 7d46 <printf>
     exit(1);
    2088:	4505                	li	a0,1
    208a:	00005097          	auipc	ra,0x5
    208e:	78e080e7          	jalr	1934(ra) # 7818 <exit>
  }
  if(pid3 == 0){
    2092:	fe442783          	lw	a5,-28(s0)
    2096:	2781                	sext.w	a5,a5
    2098:	ebb9                	bnez	a5,20ee <preempt+0x12c>
    close(pfds[0]);
    209a:	fd842783          	lw	a5,-40(s0)
    209e:	853e                	mv	a0,a5
    20a0:	00005097          	auipc	ra,0x5
    20a4:	7a0080e7          	jalr	1952(ra) # 7840 <close>
    if(write(pfds[1], "x", 1) != 1)
    20a8:	fdc42783          	lw	a5,-36(s0)
    20ac:	4605                	li	a2,1
    20ae:	00006597          	auipc	a1,0x6
    20b2:	10258593          	addi	a1,a1,258 # 81b0 <malloc+0x278>
    20b6:	853e                	mv	a0,a5
    20b8:	00005097          	auipc	ra,0x5
    20bc:	780080e7          	jalr	1920(ra) # 7838 <write>
    20c0:	87aa                	mv	a5,a0
    20c2:	873e                	mv	a4,a5
    20c4:	4785                	li	a5,1
    20c6:	00f70c63          	beq	a4,a5,20de <preempt+0x11c>
      printf("%s: preempt write error", s);
    20ca:	fc843583          	ld	a1,-56(s0)
    20ce:	00007517          	auipc	a0,0x7
    20d2:	95a50513          	addi	a0,a0,-1702 # 8a28 <malloc+0xaf0>
    20d6:	00006097          	auipc	ra,0x6
    20da:	c70080e7          	jalr	-912(ra) # 7d46 <printf>
    close(pfds[1]);
    20de:	fdc42783          	lw	a5,-36(s0)
    20e2:	853e                	mv	a0,a5
    20e4:	00005097          	auipc	ra,0x5
    20e8:	75c080e7          	jalr	1884(ra) # 7840 <close>
    for(;;)
    20ec:	a001                	j	20ec <preempt+0x12a>
      ;
  }

  close(pfds[1]);
    20ee:	fdc42783          	lw	a5,-36(s0)
    20f2:	853e                	mv	a0,a5
    20f4:	00005097          	auipc	ra,0x5
    20f8:	74c080e7          	jalr	1868(ra) # 7840 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    20fc:	fd842783          	lw	a5,-40(s0)
    2100:	660d                	lui	a2,0x3
    2102:	00009597          	auipc	a1,0x9
    2106:	34e58593          	addi	a1,a1,846 # b450 <buf>
    210a:	853e                	mv	a0,a5
    210c:	00005097          	auipc	ra,0x5
    2110:	724080e7          	jalr	1828(ra) # 7830 <read>
    2114:	87aa                	mv	a5,a0
    2116:	873e                	mv	a4,a5
    2118:	4785                	li	a5,1
    211a:	00f70d63          	beq	a4,a5,2134 <preempt+0x172>
    printf("%s: preempt read error", s);
    211e:	fc843583          	ld	a1,-56(s0)
    2122:	00007517          	auipc	a0,0x7
    2126:	91e50513          	addi	a0,a0,-1762 # 8a40 <malloc+0xb08>
    212a:	00006097          	auipc	ra,0x6
    212e:	c1c080e7          	jalr	-996(ra) # 7d46 <printf>
    2132:	a8a5                	j	21aa <preempt+0x1e8>
    return;
  }
  close(pfds[0]);
    2134:	fd842783          	lw	a5,-40(s0)
    2138:	853e                	mv	a0,a5
    213a:	00005097          	auipc	ra,0x5
    213e:	706080e7          	jalr	1798(ra) # 7840 <close>
  printf("kill... ");
    2142:	00007517          	auipc	a0,0x7
    2146:	91650513          	addi	a0,a0,-1770 # 8a58 <malloc+0xb20>
    214a:	00006097          	auipc	ra,0x6
    214e:	bfc080e7          	jalr	-1028(ra) # 7d46 <printf>
  kill(pid1);
    2152:	fec42783          	lw	a5,-20(s0)
    2156:	853e                	mv	a0,a5
    2158:	00005097          	auipc	ra,0x5
    215c:	6f0080e7          	jalr	1776(ra) # 7848 <kill>
  kill(pid2);
    2160:	fe842783          	lw	a5,-24(s0)
    2164:	853e                	mv	a0,a5
    2166:	00005097          	auipc	ra,0x5
    216a:	6e2080e7          	jalr	1762(ra) # 7848 <kill>
  kill(pid3);
    216e:	fe442783          	lw	a5,-28(s0)
    2172:	853e                	mv	a0,a5
    2174:	00005097          	auipc	ra,0x5
    2178:	6d4080e7          	jalr	1748(ra) # 7848 <kill>
  printf("wait... ");
    217c:	00007517          	auipc	a0,0x7
    2180:	8ec50513          	addi	a0,a0,-1812 # 8a68 <malloc+0xb30>
    2184:	00006097          	auipc	ra,0x6
    2188:	bc2080e7          	jalr	-1086(ra) # 7d46 <printf>
  wait(0);
    218c:	4501                	li	a0,0
    218e:	00005097          	auipc	ra,0x5
    2192:	692080e7          	jalr	1682(ra) # 7820 <wait>
  wait(0);
    2196:	4501                	li	a0,0
    2198:	00005097          	auipc	ra,0x5
    219c:	688080e7          	jalr	1672(ra) # 7820 <wait>
  wait(0);
    21a0:	4501                	li	a0,0
    21a2:	00005097          	auipc	ra,0x5
    21a6:	67e080e7          	jalr	1662(ra) # 7820 <wait>
}
    21aa:	70e2                	ld	ra,56(sp)
    21ac:	7442                	ld	s0,48(sp)
    21ae:	6121                	addi	sp,sp,64
    21b0:	8082                	ret

00000000000021b2 <exitwait>:

// try to find any races between exit and wait
void
exitwait(char *s)
{
    21b2:	7179                	addi	sp,sp,-48
    21b4:	f406                	sd	ra,40(sp)
    21b6:	f022                	sd	s0,32(sp)
    21b8:	1800                	addi	s0,sp,48
    21ba:	fca43c23          	sd	a0,-40(s0)
  int i, pid;

  for(i = 0; i < 100; i++){
    21be:	fe042623          	sw	zero,-20(s0)
    21c2:	a87d                	j	2280 <exitwait+0xce>
    pid = fork();
    21c4:	00005097          	auipc	ra,0x5
    21c8:	64c080e7          	jalr	1612(ra) # 7810 <fork>
    21cc:	87aa                	mv	a5,a0
    21ce:	fef42423          	sw	a5,-24(s0)
    if(pid < 0){
    21d2:	fe842783          	lw	a5,-24(s0)
    21d6:	2781                	sext.w	a5,a5
    21d8:	0207d163          	bgez	a5,21fa <exitwait+0x48>
      printf("%s: fork failed\n", s);
    21dc:	fd843583          	ld	a1,-40(s0)
    21e0:	00006517          	auipc	a0,0x6
    21e4:	30050513          	addi	a0,a0,768 # 84e0 <malloc+0x5a8>
    21e8:	00006097          	auipc	ra,0x6
    21ec:	b5e080e7          	jalr	-1186(ra) # 7d46 <printf>
      exit(1);
    21f0:	4505                	li	a0,1
    21f2:	00005097          	auipc	ra,0x5
    21f6:	626080e7          	jalr	1574(ra) # 7818 <exit>
    }
    if(pid){
    21fa:	fe842783          	lw	a5,-24(s0)
    21fe:	2781                	sext.w	a5,a5
    2200:	c7a5                	beqz	a5,2268 <exitwait+0xb6>
      int xstate;
      if(wait(&xstate) != pid){
    2202:	fe440793          	addi	a5,s0,-28
    2206:	853e                	mv	a0,a5
    2208:	00005097          	auipc	ra,0x5
    220c:	618080e7          	jalr	1560(ra) # 7820 <wait>
    2210:	87aa                	mv	a5,a0
    2212:	873e                	mv	a4,a5
    2214:	fe842783          	lw	a5,-24(s0)
    2218:	2781                	sext.w	a5,a5
    221a:	02e78163          	beq	a5,a4,223c <exitwait+0x8a>
        printf("%s: wait wrong pid\n", s);
    221e:	fd843583          	ld	a1,-40(s0)
    2222:	00007517          	auipc	a0,0x7
    2226:	85650513          	addi	a0,a0,-1962 # 8a78 <malloc+0xb40>
    222a:	00006097          	auipc	ra,0x6
    222e:	b1c080e7          	jalr	-1252(ra) # 7d46 <printf>
        exit(1);
    2232:	4505                	li	a0,1
    2234:	00005097          	auipc	ra,0x5
    2238:	5e4080e7          	jalr	1508(ra) # 7818 <exit>
      }
      if(i != xstate) {
    223c:	fe442703          	lw	a4,-28(s0)
    2240:	fec42783          	lw	a5,-20(s0)
    2244:	2781                	sext.w	a5,a5
    2246:	02e78863          	beq	a5,a4,2276 <exitwait+0xc4>
        printf("%s: wait wrong exit status\n", s);
    224a:	fd843583          	ld	a1,-40(s0)
    224e:	00007517          	auipc	a0,0x7
    2252:	84250513          	addi	a0,a0,-1982 # 8a90 <malloc+0xb58>
    2256:	00006097          	auipc	ra,0x6
    225a:	af0080e7          	jalr	-1296(ra) # 7d46 <printf>
        exit(1);
    225e:	4505                	li	a0,1
    2260:	00005097          	auipc	ra,0x5
    2264:	5b8080e7          	jalr	1464(ra) # 7818 <exit>
      }
    } else {
      exit(i);
    2268:	fec42783          	lw	a5,-20(s0)
    226c:	853e                	mv	a0,a5
    226e:	00005097          	auipc	ra,0x5
    2272:	5aa080e7          	jalr	1450(ra) # 7818 <exit>
  for(i = 0; i < 100; i++){
    2276:	fec42783          	lw	a5,-20(s0)
    227a:	2785                	addiw	a5,a5,1
    227c:	fef42623          	sw	a5,-20(s0)
    2280:	fec42783          	lw	a5,-20(s0)
    2284:	0007871b          	sext.w	a4,a5
    2288:	06300793          	li	a5,99
    228c:	f2e7dce3          	bge	a5,a4,21c4 <exitwait+0x12>
    }
  }
}
    2290:	0001                	nop
    2292:	0001                	nop
    2294:	70a2                	ld	ra,40(sp)
    2296:	7402                	ld	s0,32(sp)
    2298:	6145                	addi	sp,sp,48
    229a:	8082                	ret

000000000000229c <reparent>:
// try to find races in the reparenting
// code that handles a parent exiting
// when it still has live children.
void
reparent(char *s)
{
    229c:	7179                	addi	sp,sp,-48
    229e:	f406                	sd	ra,40(sp)
    22a0:	f022                	sd	s0,32(sp)
    22a2:	1800                	addi	s0,sp,48
    22a4:	fca43c23          	sd	a0,-40(s0)
  int master_pid = getpid();
    22a8:	00005097          	auipc	ra,0x5
    22ac:	5f0080e7          	jalr	1520(ra) # 7898 <getpid>
    22b0:	87aa                	mv	a5,a0
    22b2:	fef42423          	sw	a5,-24(s0)
  for(int i = 0; i < 200; i++){
    22b6:	fe042623          	sw	zero,-20(s0)
    22ba:	a86d                	j	2374 <reparent+0xd8>
    int pid = fork();
    22bc:	00005097          	auipc	ra,0x5
    22c0:	554080e7          	jalr	1364(ra) # 7810 <fork>
    22c4:	87aa                	mv	a5,a0
    22c6:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    22ca:	fe442783          	lw	a5,-28(s0)
    22ce:	2781                	sext.w	a5,a5
    22d0:	0207d163          	bgez	a5,22f2 <reparent+0x56>
      printf("%s: fork failed\n", s);
    22d4:	fd843583          	ld	a1,-40(s0)
    22d8:	00006517          	auipc	a0,0x6
    22dc:	20850513          	addi	a0,a0,520 # 84e0 <malloc+0x5a8>
    22e0:	00006097          	auipc	ra,0x6
    22e4:	a66080e7          	jalr	-1434(ra) # 7d46 <printf>
      exit(1);
    22e8:	4505                	li	a0,1
    22ea:	00005097          	auipc	ra,0x5
    22ee:	52e080e7          	jalr	1326(ra) # 7818 <exit>
    }
    if(pid){
    22f2:	fe442783          	lw	a5,-28(s0)
    22f6:	2781                	sext.w	a5,a5
    22f8:	cf85                	beqz	a5,2330 <reparent+0x94>
      if(wait(0) != pid){
    22fa:	4501                	li	a0,0
    22fc:	00005097          	auipc	ra,0x5
    2300:	524080e7          	jalr	1316(ra) # 7820 <wait>
    2304:	87aa                	mv	a5,a0
    2306:	873e                	mv	a4,a5
    2308:	fe442783          	lw	a5,-28(s0)
    230c:	2781                	sext.w	a5,a5
    230e:	04e78e63          	beq	a5,a4,236a <reparent+0xce>
        printf("%s: wait wrong pid\n", s);
    2312:	fd843583          	ld	a1,-40(s0)
    2316:	00006517          	auipc	a0,0x6
    231a:	76250513          	addi	a0,a0,1890 # 8a78 <malloc+0xb40>
    231e:	00006097          	auipc	ra,0x6
    2322:	a28080e7          	jalr	-1496(ra) # 7d46 <printf>
        exit(1);
    2326:	4505                	li	a0,1
    2328:	00005097          	auipc	ra,0x5
    232c:	4f0080e7          	jalr	1264(ra) # 7818 <exit>
      }
    } else {
      int pid2 = fork();
    2330:	00005097          	auipc	ra,0x5
    2334:	4e0080e7          	jalr	1248(ra) # 7810 <fork>
    2338:	87aa                	mv	a5,a0
    233a:	fef42023          	sw	a5,-32(s0)
      if(pid2 < 0){
    233e:	fe042783          	lw	a5,-32(s0)
    2342:	2781                	sext.w	a5,a5
    2344:	0007de63          	bgez	a5,2360 <reparent+0xc4>
        kill(master_pid);
    2348:	fe842783          	lw	a5,-24(s0)
    234c:	853e                	mv	a0,a5
    234e:	00005097          	auipc	ra,0x5
    2352:	4fa080e7          	jalr	1274(ra) # 7848 <kill>
        exit(1);
    2356:	4505                	li	a0,1
    2358:	00005097          	auipc	ra,0x5
    235c:	4c0080e7          	jalr	1216(ra) # 7818 <exit>
      }
      exit(0);
    2360:	4501                	li	a0,0
    2362:	00005097          	auipc	ra,0x5
    2366:	4b6080e7          	jalr	1206(ra) # 7818 <exit>
  for(int i = 0; i < 200; i++){
    236a:	fec42783          	lw	a5,-20(s0)
    236e:	2785                	addiw	a5,a5,1
    2370:	fef42623          	sw	a5,-20(s0)
    2374:	fec42783          	lw	a5,-20(s0)
    2378:	0007871b          	sext.w	a4,a5
    237c:	0c700793          	li	a5,199
    2380:	f2e7dee3          	bge	a5,a4,22bc <reparent+0x20>
    }
  }
  exit(0);
    2384:	4501                	li	a0,0
    2386:	00005097          	auipc	ra,0x5
    238a:	492080e7          	jalr	1170(ra) # 7818 <exit>

000000000000238e <twochildren>:
}

// what if two children exit() at the same time?
void
twochildren(char *s)
{
    238e:	7179                	addi	sp,sp,-48
    2390:	f406                	sd	ra,40(sp)
    2392:	f022                	sd	s0,32(sp)
    2394:	1800                	addi	s0,sp,48
    2396:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 1000; i++){
    239a:	fe042623          	sw	zero,-20(s0)
    239e:	a845                	j	244e <twochildren+0xc0>
    int pid1 = fork();
    23a0:	00005097          	auipc	ra,0x5
    23a4:	470080e7          	jalr	1136(ra) # 7810 <fork>
    23a8:	87aa                	mv	a5,a0
    23aa:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    23ae:	fe842783          	lw	a5,-24(s0)
    23b2:	2781                	sext.w	a5,a5
    23b4:	0207d163          	bgez	a5,23d6 <twochildren+0x48>
      printf("%s: fork failed\n", s);
    23b8:	fd843583          	ld	a1,-40(s0)
    23bc:	00006517          	auipc	a0,0x6
    23c0:	12450513          	addi	a0,a0,292 # 84e0 <malloc+0x5a8>
    23c4:	00006097          	auipc	ra,0x6
    23c8:	982080e7          	jalr	-1662(ra) # 7d46 <printf>
      exit(1);
    23cc:	4505                	li	a0,1
    23ce:	00005097          	auipc	ra,0x5
    23d2:	44a080e7          	jalr	1098(ra) # 7818 <exit>
    }
    if(pid1 == 0){
    23d6:	fe842783          	lw	a5,-24(s0)
    23da:	2781                	sext.w	a5,a5
    23dc:	e791                	bnez	a5,23e8 <twochildren+0x5a>
      exit(0);
    23de:	4501                	li	a0,0
    23e0:	00005097          	auipc	ra,0x5
    23e4:	438080e7          	jalr	1080(ra) # 7818 <exit>
    } else {
      int pid2 = fork();
    23e8:	00005097          	auipc	ra,0x5
    23ec:	428080e7          	jalr	1064(ra) # 7810 <fork>
    23f0:	87aa                	mv	a5,a0
    23f2:	fef42223          	sw	a5,-28(s0)
      if(pid2 < 0){
    23f6:	fe442783          	lw	a5,-28(s0)
    23fa:	2781                	sext.w	a5,a5
    23fc:	0207d163          	bgez	a5,241e <twochildren+0x90>
        printf("%s: fork failed\n", s);
    2400:	fd843583          	ld	a1,-40(s0)
    2404:	00006517          	auipc	a0,0x6
    2408:	0dc50513          	addi	a0,a0,220 # 84e0 <malloc+0x5a8>
    240c:	00006097          	auipc	ra,0x6
    2410:	93a080e7          	jalr	-1734(ra) # 7d46 <printf>
        exit(1);
    2414:	4505                	li	a0,1
    2416:	00005097          	auipc	ra,0x5
    241a:	402080e7          	jalr	1026(ra) # 7818 <exit>
      }
      if(pid2 == 0){
    241e:	fe442783          	lw	a5,-28(s0)
    2422:	2781                	sext.w	a5,a5
    2424:	e791                	bnez	a5,2430 <twochildren+0xa2>
        exit(0);
    2426:	4501                	li	a0,0
    2428:	00005097          	auipc	ra,0x5
    242c:	3f0080e7          	jalr	1008(ra) # 7818 <exit>
      } else {
        wait(0);
    2430:	4501                	li	a0,0
    2432:	00005097          	auipc	ra,0x5
    2436:	3ee080e7          	jalr	1006(ra) # 7820 <wait>
        wait(0);
    243a:	4501                	li	a0,0
    243c:	00005097          	auipc	ra,0x5
    2440:	3e4080e7          	jalr	996(ra) # 7820 <wait>
  for(int i = 0; i < 1000; i++){
    2444:	fec42783          	lw	a5,-20(s0)
    2448:	2785                	addiw	a5,a5,1
    244a:	fef42623          	sw	a5,-20(s0)
    244e:	fec42783          	lw	a5,-20(s0)
    2452:	0007871b          	sext.w	a4,a5
    2456:	3e700793          	li	a5,999
    245a:	f4e7d3e3          	bge	a5,a4,23a0 <twochildren+0x12>
      }
    }
  }
}
    245e:	0001                	nop
    2460:	0001                	nop
    2462:	70a2                	ld	ra,40(sp)
    2464:	7402                	ld	s0,32(sp)
    2466:	6145                	addi	sp,sp,48
    2468:	8082                	ret

000000000000246a <forkfork>:

// concurrent forks to try to expose locking bugs.
void
forkfork(char *s)
{
    246a:	7139                	addi	sp,sp,-64
    246c:	fc06                	sd	ra,56(sp)
    246e:	f822                	sd	s0,48(sp)
    2470:	0080                	addi	s0,sp,64
    2472:	fca43423          	sd	a0,-56(s0)
  enum { N=2 };

  for(int i = 0; i < N; i++){
    2476:	fe042623          	sw	zero,-20(s0)
    247a:	a84d                	j	252c <forkfork+0xc2>
    int pid = fork();
    247c:	00005097          	auipc	ra,0x5
    2480:	394080e7          	jalr	916(ra) # 7810 <fork>
    2484:	87aa                	mv	a5,a0
    2486:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    248a:	fe042783          	lw	a5,-32(s0)
    248e:	2781                	sext.w	a5,a5
    2490:	0207d163          	bgez	a5,24b2 <forkfork+0x48>
      printf("%s: fork failed", s);
    2494:	fc843583          	ld	a1,-56(s0)
    2498:	00006517          	auipc	a0,0x6
    249c:	58050513          	addi	a0,a0,1408 # 8a18 <malloc+0xae0>
    24a0:	00006097          	auipc	ra,0x6
    24a4:	8a6080e7          	jalr	-1882(ra) # 7d46 <printf>
      exit(1);
    24a8:	4505                	li	a0,1
    24aa:	00005097          	auipc	ra,0x5
    24ae:	36e080e7          	jalr	878(ra) # 7818 <exit>
    }
    if(pid == 0){
    24b2:	fe042783          	lw	a5,-32(s0)
    24b6:	2781                	sext.w	a5,a5
    24b8:	e7ad                	bnez	a5,2522 <forkfork+0xb8>
      for(int j = 0; j < 200; j++){
    24ba:	fe042423          	sw	zero,-24(s0)
    24be:	a0a9                	j	2508 <forkfork+0x9e>
        int pid1 = fork();
    24c0:	00005097          	auipc	ra,0x5
    24c4:	350080e7          	jalr	848(ra) # 7810 <fork>
    24c8:	87aa                	mv	a5,a0
    24ca:	fcf42e23          	sw	a5,-36(s0)
        if(pid1 < 0){
    24ce:	fdc42783          	lw	a5,-36(s0)
    24d2:	2781                	sext.w	a5,a5
    24d4:	0007d763          	bgez	a5,24e2 <forkfork+0x78>
          exit(1);
    24d8:	4505                	li	a0,1
    24da:	00005097          	auipc	ra,0x5
    24de:	33e080e7          	jalr	830(ra) # 7818 <exit>
        }
        if(pid1 == 0){
    24e2:	fdc42783          	lw	a5,-36(s0)
    24e6:	2781                	sext.w	a5,a5
    24e8:	e791                	bnez	a5,24f4 <forkfork+0x8a>
          exit(0);
    24ea:	4501                	li	a0,0
    24ec:	00005097          	auipc	ra,0x5
    24f0:	32c080e7          	jalr	812(ra) # 7818 <exit>
        }
        wait(0);
    24f4:	4501                	li	a0,0
    24f6:	00005097          	auipc	ra,0x5
    24fa:	32a080e7          	jalr	810(ra) # 7820 <wait>
      for(int j = 0; j < 200; j++){
    24fe:	fe842783          	lw	a5,-24(s0)
    2502:	2785                	addiw	a5,a5,1
    2504:	fef42423          	sw	a5,-24(s0)
    2508:	fe842783          	lw	a5,-24(s0)
    250c:	0007871b          	sext.w	a4,a5
    2510:	0c700793          	li	a5,199
    2514:	fae7d6e3          	bge	a5,a4,24c0 <forkfork+0x56>
      }
      exit(0);
    2518:	4501                	li	a0,0
    251a:	00005097          	auipc	ra,0x5
    251e:	2fe080e7          	jalr	766(ra) # 7818 <exit>
  for(int i = 0; i < N; i++){
    2522:	fec42783          	lw	a5,-20(s0)
    2526:	2785                	addiw	a5,a5,1
    2528:	fef42623          	sw	a5,-20(s0)
    252c:	fec42783          	lw	a5,-20(s0)
    2530:	0007871b          	sext.w	a4,a5
    2534:	4785                	li	a5,1
    2536:	f4e7d3e3          	bge	a5,a4,247c <forkfork+0x12>
    }
  }

  int xstatus;
  for(int i = 0; i < N; i++){
    253a:	fe042223          	sw	zero,-28(s0)
    253e:	a83d                	j	257c <forkfork+0x112>
    wait(&xstatus);
    2540:	fd840793          	addi	a5,s0,-40
    2544:	853e                	mv	a0,a5
    2546:	00005097          	auipc	ra,0x5
    254a:	2da080e7          	jalr	730(ra) # 7820 <wait>
    if(xstatus != 0) {
    254e:	fd842783          	lw	a5,-40(s0)
    2552:	c385                	beqz	a5,2572 <forkfork+0x108>
      printf("%s: fork in child failed", s);
    2554:	fc843583          	ld	a1,-56(s0)
    2558:	00006517          	auipc	a0,0x6
    255c:	55850513          	addi	a0,a0,1368 # 8ab0 <malloc+0xb78>
    2560:	00005097          	auipc	ra,0x5
    2564:	7e6080e7          	jalr	2022(ra) # 7d46 <printf>
      exit(1);
    2568:	4505                	li	a0,1
    256a:	00005097          	auipc	ra,0x5
    256e:	2ae080e7          	jalr	686(ra) # 7818 <exit>
  for(int i = 0; i < N; i++){
    2572:	fe442783          	lw	a5,-28(s0)
    2576:	2785                	addiw	a5,a5,1
    2578:	fef42223          	sw	a5,-28(s0)
    257c:	fe442783          	lw	a5,-28(s0)
    2580:	0007871b          	sext.w	a4,a5
    2584:	4785                	li	a5,1
    2586:	fae7dde3          	bge	a5,a4,2540 <forkfork+0xd6>
    }
  }
}
    258a:	0001                	nop
    258c:	0001                	nop
    258e:	70e2                	ld	ra,56(sp)
    2590:	7442                	ld	s0,48(sp)
    2592:	6121                	addi	sp,sp,64
    2594:	8082                	ret

0000000000002596 <forkforkfork>:

void
forkforkfork(char *s)
{
    2596:	7179                	addi	sp,sp,-48
    2598:	f406                	sd	ra,40(sp)
    259a:	f022                	sd	s0,32(sp)
    259c:	1800                	addi	s0,sp,48
    259e:	fca43c23          	sd	a0,-40(s0)
  unlink("stopforking");
    25a2:	00006517          	auipc	a0,0x6
    25a6:	52e50513          	addi	a0,a0,1326 # 8ad0 <malloc+0xb98>
    25aa:	00005097          	auipc	ra,0x5
    25ae:	2be080e7          	jalr	702(ra) # 7868 <unlink>

  int pid = fork();
    25b2:	00005097          	auipc	ra,0x5
    25b6:	25e080e7          	jalr	606(ra) # 7810 <fork>
    25ba:	87aa                	mv	a5,a0
    25bc:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    25c0:	fec42783          	lw	a5,-20(s0)
    25c4:	2781                	sext.w	a5,a5
    25c6:	0207d163          	bgez	a5,25e8 <forkforkfork+0x52>
    printf("%s: fork failed", s);
    25ca:	fd843583          	ld	a1,-40(s0)
    25ce:	00006517          	auipc	a0,0x6
    25d2:	44a50513          	addi	a0,a0,1098 # 8a18 <malloc+0xae0>
    25d6:	00005097          	auipc	ra,0x5
    25da:	770080e7          	jalr	1904(ra) # 7d46 <printf>
    exit(1);
    25de:	4505                	li	a0,1
    25e0:	00005097          	auipc	ra,0x5
    25e4:	238080e7          	jalr	568(ra) # 7818 <exit>
  }
  if(pid == 0){
    25e8:	fec42783          	lw	a5,-20(s0)
    25ec:	2781                	sext.w	a5,a5
    25ee:	efb9                	bnez	a5,264c <forkforkfork+0xb6>
    while(1){
      int fd = open("stopforking", 0);
    25f0:	4581                	li	a1,0
    25f2:	00006517          	auipc	a0,0x6
    25f6:	4de50513          	addi	a0,a0,1246 # 8ad0 <malloc+0xb98>
    25fa:	00005097          	auipc	ra,0x5
    25fe:	25e080e7          	jalr	606(ra) # 7858 <open>
    2602:	87aa                	mv	a5,a0
    2604:	fef42423          	sw	a5,-24(s0)
      if(fd >= 0){
    2608:	fe842783          	lw	a5,-24(s0)
    260c:	2781                	sext.w	a5,a5
    260e:	0007c763          	bltz	a5,261c <forkforkfork+0x86>
        exit(0);
    2612:	4501                	li	a0,0
    2614:	00005097          	auipc	ra,0x5
    2618:	204080e7          	jalr	516(ra) # 7818 <exit>
      }
      if(fork() < 0){
    261c:	00005097          	auipc	ra,0x5
    2620:	1f4080e7          	jalr	500(ra) # 7810 <fork>
    2624:	87aa                	mv	a5,a0
    2626:	fc07d5e3          	bgez	a5,25f0 <forkforkfork+0x5a>
        close(open("stopforking", O_CREATE|O_RDWR));
    262a:	20200593          	li	a1,514
    262e:	00006517          	auipc	a0,0x6
    2632:	4a250513          	addi	a0,a0,1186 # 8ad0 <malloc+0xb98>
    2636:	00005097          	auipc	ra,0x5
    263a:	222080e7          	jalr	546(ra) # 7858 <open>
    263e:	87aa                	mv	a5,a0
    2640:	853e                	mv	a0,a5
    2642:	00005097          	auipc	ra,0x5
    2646:	1fe080e7          	jalr	510(ra) # 7840 <close>
    while(1){
    264a:	b75d                	j	25f0 <forkforkfork+0x5a>
    }

    exit(0);
  }

  sleep(20); // two seconds
    264c:	4551                	li	a0,20
    264e:	00005097          	auipc	ra,0x5
    2652:	25a080e7          	jalr	602(ra) # 78a8 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    2656:	20200593          	li	a1,514
    265a:	00006517          	auipc	a0,0x6
    265e:	47650513          	addi	a0,a0,1142 # 8ad0 <malloc+0xb98>
    2662:	00005097          	auipc	ra,0x5
    2666:	1f6080e7          	jalr	502(ra) # 7858 <open>
    266a:	87aa                	mv	a5,a0
    266c:	853e                	mv	a0,a5
    266e:	00005097          	auipc	ra,0x5
    2672:	1d2080e7          	jalr	466(ra) # 7840 <close>
  wait(0);
    2676:	4501                	li	a0,0
    2678:	00005097          	auipc	ra,0x5
    267c:	1a8080e7          	jalr	424(ra) # 7820 <wait>
  sleep(10); // one second
    2680:	4529                	li	a0,10
    2682:	00005097          	auipc	ra,0x5
    2686:	226080e7          	jalr	550(ra) # 78a8 <sleep>
}
    268a:	0001                	nop
    268c:	70a2                	ld	ra,40(sp)
    268e:	7402                	ld	s0,32(sp)
    2690:	6145                	addi	sp,sp,48
    2692:	8082                	ret

0000000000002694 <reparent2>:
// deadlocks against init's wait()? also used to trigger a "panic:
// release" due to exit() releasing a different p->parent->lock than
// it acquired.
void
reparent2(char *s)
{
    2694:	7179                	addi	sp,sp,-48
    2696:	f406                	sd	ra,40(sp)
    2698:	f022                	sd	s0,32(sp)
    269a:	1800                	addi	s0,sp,48
    269c:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 800; i++){
    26a0:	fe042623          	sw	zero,-20(s0)
    26a4:	a0ad                	j	270e <reparent2+0x7a>
    int pid1 = fork();
    26a6:	00005097          	auipc	ra,0x5
    26aa:	16a080e7          	jalr	362(ra) # 7810 <fork>
    26ae:	87aa                	mv	a5,a0
    26b0:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    26b4:	fe842783          	lw	a5,-24(s0)
    26b8:	2781                	sext.w	a5,a5
    26ba:	0007df63          	bgez	a5,26d8 <reparent2+0x44>
      printf("fork failed\n");
    26be:	00006517          	auipc	a0,0x6
    26c2:	bf250513          	addi	a0,a0,-1038 # 82b0 <malloc+0x378>
    26c6:	00005097          	auipc	ra,0x5
    26ca:	680080e7          	jalr	1664(ra) # 7d46 <printf>
      exit(1);
    26ce:	4505                	li	a0,1
    26d0:	00005097          	auipc	ra,0x5
    26d4:	148080e7          	jalr	328(ra) # 7818 <exit>
    }
    if(pid1 == 0){
    26d8:	fe842783          	lw	a5,-24(s0)
    26dc:	2781                	sext.w	a5,a5
    26de:	ef91                	bnez	a5,26fa <reparent2+0x66>
      fork();
    26e0:	00005097          	auipc	ra,0x5
    26e4:	130080e7          	jalr	304(ra) # 7810 <fork>
      fork();
    26e8:	00005097          	auipc	ra,0x5
    26ec:	128080e7          	jalr	296(ra) # 7810 <fork>
      exit(0);
    26f0:	4501                	li	a0,0
    26f2:	00005097          	auipc	ra,0x5
    26f6:	126080e7          	jalr	294(ra) # 7818 <exit>
    }
    wait(0);
    26fa:	4501                	li	a0,0
    26fc:	00005097          	auipc	ra,0x5
    2700:	124080e7          	jalr	292(ra) # 7820 <wait>
  for(int i = 0; i < 800; i++){
    2704:	fec42783          	lw	a5,-20(s0)
    2708:	2785                	addiw	a5,a5,1
    270a:	fef42623          	sw	a5,-20(s0)
    270e:	fec42783          	lw	a5,-20(s0)
    2712:	0007871b          	sext.w	a4,a5
    2716:	31f00793          	li	a5,799
    271a:	f8e7d6e3          	bge	a5,a4,26a6 <reparent2+0x12>
  }

  exit(0);
    271e:	4501                	li	a0,0
    2720:	00005097          	auipc	ra,0x5
    2724:	0f8080e7          	jalr	248(ra) # 7818 <exit>

0000000000002728 <mem>:
}

// allocate all mem, free it, and allocate again
void
mem(char *s)
{
    2728:	7139                	addi	sp,sp,-64
    272a:	fc06                	sd	ra,56(sp)
    272c:	f822                	sd	s0,48(sp)
    272e:	0080                	addi	s0,sp,64
    2730:	fca43423          	sd	a0,-56(s0)
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    2734:	00005097          	auipc	ra,0x5
    2738:	0dc080e7          	jalr	220(ra) # 7810 <fork>
    273c:	87aa                	mv	a5,a0
    273e:	fef42223          	sw	a5,-28(s0)
    2742:	fe442783          	lw	a5,-28(s0)
    2746:	2781                	sext.w	a5,a5
    2748:	e3c5                	bnez	a5,27e8 <mem+0xc0>
    m1 = 0;
    274a:	fe043423          	sd	zero,-24(s0)
    while((m2 = malloc(10001)) != 0){
    274e:	a811                	j	2762 <mem+0x3a>
      *(char**)m2 = m1;
    2750:	fd843783          	ld	a5,-40(s0)
    2754:	fe843703          	ld	a4,-24(s0)
    2758:	e398                	sd	a4,0(a5)
      m1 = m2;
    275a:	fd843783          	ld	a5,-40(s0)
    275e:	fef43423          	sd	a5,-24(s0)
    while((m2 = malloc(10001)) != 0){
    2762:	6789                	lui	a5,0x2
    2764:	71178513          	addi	a0,a5,1809 # 2711 <reparent2+0x7d>
    2768:	00005097          	auipc	ra,0x5
    276c:	7d0080e7          	jalr	2000(ra) # 7f38 <malloc>
    2770:	fca43c23          	sd	a0,-40(s0)
    2774:	fd843783          	ld	a5,-40(s0)
    2778:	ffe1                	bnez	a5,2750 <mem+0x28>
    }
    while(m1){
    277a:	a005                	j	279a <mem+0x72>
      m2 = *(char**)m1;
    277c:	fe843783          	ld	a5,-24(s0)
    2780:	639c                	ld	a5,0(a5)
    2782:	fcf43c23          	sd	a5,-40(s0)
      free(m1);
    2786:	fe843503          	ld	a0,-24(s0)
    278a:	00005097          	auipc	ra,0x5
    278e:	60c080e7          	jalr	1548(ra) # 7d96 <free>
      m1 = m2;
    2792:	fd843783          	ld	a5,-40(s0)
    2796:	fef43423          	sd	a5,-24(s0)
    while(m1){
    279a:	fe843783          	ld	a5,-24(s0)
    279e:	fff9                	bnez	a5,277c <mem+0x54>
    }
    m1 = malloc(1024*20);
    27a0:	6515                	lui	a0,0x5
    27a2:	00005097          	auipc	ra,0x5
    27a6:	796080e7          	jalr	1942(ra) # 7f38 <malloc>
    27aa:	fea43423          	sd	a0,-24(s0)
    if(m1 == 0){
    27ae:	fe843783          	ld	a5,-24(s0)
    27b2:	e385                	bnez	a5,27d2 <mem+0xaa>
      printf("couldn't allocate mem?!!\n", s);
    27b4:	fc843583          	ld	a1,-56(s0)
    27b8:	00006517          	auipc	a0,0x6
    27bc:	32850513          	addi	a0,a0,808 # 8ae0 <malloc+0xba8>
    27c0:	00005097          	auipc	ra,0x5
    27c4:	586080e7          	jalr	1414(ra) # 7d46 <printf>
      exit(1);
    27c8:	4505                	li	a0,1
    27ca:	00005097          	auipc	ra,0x5
    27ce:	04e080e7          	jalr	78(ra) # 7818 <exit>
    }
    free(m1);
    27d2:	fe843503          	ld	a0,-24(s0)
    27d6:	00005097          	auipc	ra,0x5
    27da:	5c0080e7          	jalr	1472(ra) # 7d96 <free>
    exit(0);
    27de:	4501                	li	a0,0
    27e0:	00005097          	auipc	ra,0x5
    27e4:	038080e7          	jalr	56(ra) # 7818 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    27e8:	fd440793          	addi	a5,s0,-44
    27ec:	853e                	mv	a0,a5
    27ee:	00005097          	auipc	ra,0x5
    27f2:	032080e7          	jalr	50(ra) # 7820 <wait>
    if(xstatus == -1){
    27f6:	fd442783          	lw	a5,-44(s0)
    27fa:	873e                	mv	a4,a5
    27fc:	57fd                	li	a5,-1
    27fe:	00f71763          	bne	a4,a5,280c <mem+0xe4>
      // probably page fault, so might be lazy lab,
      // so OK.
      exit(0);
    2802:	4501                	li	a0,0
    2804:	00005097          	auipc	ra,0x5
    2808:	014080e7          	jalr	20(ra) # 7818 <exit>
    }
    exit(xstatus);
    280c:	fd442783          	lw	a5,-44(s0)
    2810:	853e                	mv	a0,a5
    2812:	00005097          	auipc	ra,0x5
    2816:	006080e7          	jalr	6(ra) # 7818 <exit>

000000000000281a <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(char *s)
{
    281a:	715d                	addi	sp,sp,-80
    281c:	e486                	sd	ra,72(sp)
    281e:	e0a2                	sd	s0,64(sp)
    2820:	0880                	addi	s0,sp,80
    2822:	faa43c23          	sd	a0,-72(s0)
  int fd, pid, i, n, nc, np;
  enum { N = 1000, SZ=10};
  char buf[SZ];

  unlink("sharedfd");
    2826:	00006517          	auipc	a0,0x6
    282a:	2da50513          	addi	a0,a0,730 # 8b00 <malloc+0xbc8>
    282e:	00005097          	auipc	ra,0x5
    2832:	03a080e7          	jalr	58(ra) # 7868 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2836:	20200593          	li	a1,514
    283a:	00006517          	auipc	a0,0x6
    283e:	2c650513          	addi	a0,a0,710 # 8b00 <malloc+0xbc8>
    2842:	00005097          	auipc	ra,0x5
    2846:	016080e7          	jalr	22(ra) # 7858 <open>
    284a:	87aa                	mv	a5,a0
    284c:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2850:	fe042783          	lw	a5,-32(s0)
    2854:	2781                	sext.w	a5,a5
    2856:	0207d163          	bgez	a5,2878 <sharedfd+0x5e>
    printf("%s: cannot open sharedfd for writing", s);
    285a:	fb843583          	ld	a1,-72(s0)
    285e:	00006517          	auipc	a0,0x6
    2862:	2b250513          	addi	a0,a0,690 # 8b10 <malloc+0xbd8>
    2866:	00005097          	auipc	ra,0x5
    286a:	4e0080e7          	jalr	1248(ra) # 7d46 <printf>
    exit(1);
    286e:	4505                	li	a0,1
    2870:	00005097          	auipc	ra,0x5
    2874:	fa8080e7          	jalr	-88(ra) # 7818 <exit>
  }
  pid = fork();
    2878:	00005097          	auipc	ra,0x5
    287c:	f98080e7          	jalr	-104(ra) # 7810 <fork>
    2880:	87aa                	mv	a5,a0
    2882:	fcf42e23          	sw	a5,-36(s0)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2886:	fdc42783          	lw	a5,-36(s0)
    288a:	2781                	sext.w	a5,a5
    288c:	e781                	bnez	a5,2894 <sharedfd+0x7a>
    288e:	06300793          	li	a5,99
    2892:	a019                	j	2898 <sharedfd+0x7e>
    2894:	07000793          	li	a5,112
    2898:	fc840713          	addi	a4,s0,-56
    289c:	4629                	li	a2,10
    289e:	85be                	mv	a1,a5
    28a0:	853a                	mv	a0,a4
    28a2:	00005097          	auipc	ra,0x5
    28a6:	bcc080e7          	jalr	-1076(ra) # 746e <memset>
  for(i = 0; i < N; i++){
    28aa:	fe042623          	sw	zero,-20(s0)
    28ae:	a0a9                	j	28f8 <sharedfd+0xde>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    28b0:	fc840713          	addi	a4,s0,-56
    28b4:	fe042783          	lw	a5,-32(s0)
    28b8:	4629                	li	a2,10
    28ba:	85ba                	mv	a1,a4
    28bc:	853e                	mv	a0,a5
    28be:	00005097          	auipc	ra,0x5
    28c2:	f7a080e7          	jalr	-134(ra) # 7838 <write>
    28c6:	87aa                	mv	a5,a0
    28c8:	873e                	mv	a4,a5
    28ca:	47a9                	li	a5,10
    28cc:	02f70163          	beq	a4,a5,28ee <sharedfd+0xd4>
      printf("%s: write sharedfd failed\n", s);
    28d0:	fb843583          	ld	a1,-72(s0)
    28d4:	00006517          	auipc	a0,0x6
    28d8:	26450513          	addi	a0,a0,612 # 8b38 <malloc+0xc00>
    28dc:	00005097          	auipc	ra,0x5
    28e0:	46a080e7          	jalr	1130(ra) # 7d46 <printf>
      exit(1);
    28e4:	4505                	li	a0,1
    28e6:	00005097          	auipc	ra,0x5
    28ea:	f32080e7          	jalr	-206(ra) # 7818 <exit>
  for(i = 0; i < N; i++){
    28ee:	fec42783          	lw	a5,-20(s0)
    28f2:	2785                	addiw	a5,a5,1
    28f4:	fef42623          	sw	a5,-20(s0)
    28f8:	fec42783          	lw	a5,-20(s0)
    28fc:	0007871b          	sext.w	a4,a5
    2900:	3e700793          	li	a5,999
    2904:	fae7d6e3          	bge	a5,a4,28b0 <sharedfd+0x96>
    }
  }
  if(pid == 0) {
    2908:	fdc42783          	lw	a5,-36(s0)
    290c:	2781                	sext.w	a5,a5
    290e:	e791                	bnez	a5,291a <sharedfd+0x100>
    exit(0);
    2910:	4501                	li	a0,0
    2912:	00005097          	auipc	ra,0x5
    2916:	f06080e7          	jalr	-250(ra) # 7818 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    291a:	fc440793          	addi	a5,s0,-60
    291e:	853e                	mv	a0,a5
    2920:	00005097          	auipc	ra,0x5
    2924:	f00080e7          	jalr	-256(ra) # 7820 <wait>
    if(xstatus != 0)
    2928:	fc442783          	lw	a5,-60(s0)
    292c:	cb81                	beqz	a5,293c <sharedfd+0x122>
      exit(xstatus);
    292e:	fc442783          	lw	a5,-60(s0)
    2932:	853e                	mv	a0,a5
    2934:	00005097          	auipc	ra,0x5
    2938:	ee4080e7          	jalr	-284(ra) # 7818 <exit>
  }

  close(fd);
    293c:	fe042783          	lw	a5,-32(s0)
    2940:	853e                	mv	a0,a5
    2942:	00005097          	auipc	ra,0x5
    2946:	efe080e7          	jalr	-258(ra) # 7840 <close>
  fd = open("sharedfd", 0);
    294a:	4581                	li	a1,0
    294c:	00006517          	auipc	a0,0x6
    2950:	1b450513          	addi	a0,a0,436 # 8b00 <malloc+0xbc8>
    2954:	00005097          	auipc	ra,0x5
    2958:	f04080e7          	jalr	-252(ra) # 7858 <open>
    295c:	87aa                	mv	a5,a0
    295e:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2962:	fe042783          	lw	a5,-32(s0)
    2966:	2781                	sext.w	a5,a5
    2968:	0207d163          	bgez	a5,298a <sharedfd+0x170>
    printf("%s: cannot open sharedfd for reading\n", s);
    296c:	fb843583          	ld	a1,-72(s0)
    2970:	00006517          	auipc	a0,0x6
    2974:	1e850513          	addi	a0,a0,488 # 8b58 <malloc+0xc20>
    2978:	00005097          	auipc	ra,0x5
    297c:	3ce080e7          	jalr	974(ra) # 7d46 <printf>
    exit(1);
    2980:	4505                	li	a0,1
    2982:	00005097          	auipc	ra,0x5
    2986:	e96080e7          	jalr	-362(ra) # 7818 <exit>
  }
  nc = np = 0;
    298a:	fe042223          	sw	zero,-28(s0)
    298e:	fe442783          	lw	a5,-28(s0)
    2992:	fef42423          	sw	a5,-24(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2996:	a08d                	j	29f8 <sharedfd+0x1de>
    for(i = 0; i < sizeof(buf); i++){
    2998:	fe042623          	sw	zero,-20(s0)
    299c:	a881                	j	29ec <sharedfd+0x1d2>
      if(buf[i] == 'c')
    299e:	fec42783          	lw	a5,-20(s0)
    29a2:	ff040713          	addi	a4,s0,-16
    29a6:	97ba                	add	a5,a5,a4
    29a8:	fd87c783          	lbu	a5,-40(a5)
    29ac:	873e                	mv	a4,a5
    29ae:	06300793          	li	a5,99
    29b2:	00f71763          	bne	a4,a5,29c0 <sharedfd+0x1a6>
        nc++;
    29b6:	fe842783          	lw	a5,-24(s0)
    29ba:	2785                	addiw	a5,a5,1
    29bc:	fef42423          	sw	a5,-24(s0)
      if(buf[i] == 'p')
    29c0:	fec42783          	lw	a5,-20(s0)
    29c4:	ff040713          	addi	a4,s0,-16
    29c8:	97ba                	add	a5,a5,a4
    29ca:	fd87c783          	lbu	a5,-40(a5)
    29ce:	873e                	mv	a4,a5
    29d0:	07000793          	li	a5,112
    29d4:	00f71763          	bne	a4,a5,29e2 <sharedfd+0x1c8>
        np++;
    29d8:	fe442783          	lw	a5,-28(s0)
    29dc:	2785                	addiw	a5,a5,1
    29de:	fef42223          	sw	a5,-28(s0)
    for(i = 0; i < sizeof(buf); i++){
    29e2:	fec42783          	lw	a5,-20(s0)
    29e6:	2785                	addiw	a5,a5,1
    29e8:	fef42623          	sw	a5,-20(s0)
    29ec:	fec42783          	lw	a5,-20(s0)
    29f0:	873e                	mv	a4,a5
    29f2:	47a5                	li	a5,9
    29f4:	fae7f5e3          	bgeu	a5,a4,299e <sharedfd+0x184>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    29f8:	fc840713          	addi	a4,s0,-56
    29fc:	fe042783          	lw	a5,-32(s0)
    2a00:	4629                	li	a2,10
    2a02:	85ba                	mv	a1,a4
    2a04:	853e                	mv	a0,a5
    2a06:	00005097          	auipc	ra,0x5
    2a0a:	e2a080e7          	jalr	-470(ra) # 7830 <read>
    2a0e:	87aa                	mv	a5,a0
    2a10:	fcf42c23          	sw	a5,-40(s0)
    2a14:	fd842783          	lw	a5,-40(s0)
    2a18:	2781                	sext.w	a5,a5
    2a1a:	f6f04fe3          	bgtz	a5,2998 <sharedfd+0x17e>
    }
  }
  close(fd);
    2a1e:	fe042783          	lw	a5,-32(s0)
    2a22:	853e                	mv	a0,a5
    2a24:	00005097          	auipc	ra,0x5
    2a28:	e1c080e7          	jalr	-484(ra) # 7840 <close>
  unlink("sharedfd");
    2a2c:	00006517          	auipc	a0,0x6
    2a30:	0d450513          	addi	a0,a0,212 # 8b00 <malloc+0xbc8>
    2a34:	00005097          	auipc	ra,0x5
    2a38:	e34080e7          	jalr	-460(ra) # 7868 <unlink>
  if(nc == N*SZ && np == N*SZ){
    2a3c:	fe842783          	lw	a5,-24(s0)
    2a40:	0007871b          	sext.w	a4,a5
    2a44:	6789                	lui	a5,0x2
    2a46:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x7c>
    2a4a:	02f71063          	bne	a4,a5,2a6a <sharedfd+0x250>
    2a4e:	fe442783          	lw	a5,-28(s0)
    2a52:	0007871b          	sext.w	a4,a5
    2a56:	6789                	lui	a5,0x2
    2a58:	71078793          	addi	a5,a5,1808 # 2710 <reparent2+0x7c>
    2a5c:	00f71763          	bne	a4,a5,2a6a <sharedfd+0x250>
    exit(0);
    2a60:	4501                	li	a0,0
    2a62:	00005097          	auipc	ra,0x5
    2a66:	db6080e7          	jalr	-586(ra) # 7818 <exit>
  } else {
    printf("%s: nc/np test fails\n", s);
    2a6a:	fb843583          	ld	a1,-72(s0)
    2a6e:	00006517          	auipc	a0,0x6
    2a72:	11250513          	addi	a0,a0,274 # 8b80 <malloc+0xc48>
    2a76:	00005097          	auipc	ra,0x5
    2a7a:	2d0080e7          	jalr	720(ra) # 7d46 <printf>
    exit(1);
    2a7e:	4505                	li	a0,1
    2a80:	00005097          	auipc	ra,0x5
    2a84:	d98080e7          	jalr	-616(ra) # 7818 <exit>

0000000000002a88 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(char *s)
{
    2a88:	7159                	addi	sp,sp,-112
    2a8a:	f486                	sd	ra,104(sp)
    2a8c:	f0a2                	sd	s0,96(sp)
    2a8e:	1880                	addi	s0,sp,112
    2a90:	f8a43c23          	sd	a0,-104(s0)
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    2a94:	00006797          	auipc	a5,0x6
    2a98:	15478793          	addi	a5,a5,340 # 8be8 <malloc+0xcb0>
    2a9c:	6390                	ld	a2,0(a5)
    2a9e:	6794                	ld	a3,8(a5)
    2aa0:	6b98                	ld	a4,16(a5)
    2aa2:	6f9c                	ld	a5,24(a5)
    2aa4:	fac43423          	sd	a2,-88(s0)
    2aa8:	fad43823          	sd	a3,-80(s0)
    2aac:	fae43c23          	sd	a4,-72(s0)
    2ab0:	fcf43023          	sd	a5,-64(s0)
  char *fname;
  enum { N=12, NCHILD=4, SZ=500 };

  for(pi = 0; pi < NCHILD; pi++){
    2ab4:	fe042023          	sw	zero,-32(s0)
    2ab8:	a281                	j	2bf8 <fourfiles+0x170>
    fname = names[pi];
    2aba:	fe042783          	lw	a5,-32(s0)
    2abe:	078e                	slli	a5,a5,0x3
    2ac0:	ff040713          	addi	a4,s0,-16
    2ac4:	97ba                	add	a5,a5,a4
    2ac6:	fb87b783          	ld	a5,-72(a5)
    2aca:	fcf43c23          	sd	a5,-40(s0)
    unlink(fname);
    2ace:	fd843503          	ld	a0,-40(s0)
    2ad2:	00005097          	auipc	ra,0x5
    2ad6:	d96080e7          	jalr	-618(ra) # 7868 <unlink>

    pid = fork();
    2ada:	00005097          	auipc	ra,0x5
    2ade:	d36080e7          	jalr	-714(ra) # 7810 <fork>
    2ae2:	87aa                	mv	a5,a0
    2ae4:	fcf42623          	sw	a5,-52(s0)
    if(pid < 0){
    2ae8:	fcc42783          	lw	a5,-52(s0)
    2aec:	2781                	sext.w	a5,a5
    2aee:	0207d163          	bgez	a5,2b10 <fourfiles+0x88>
      printf("fork failed\n", s);
    2af2:	f9843583          	ld	a1,-104(s0)
    2af6:	00005517          	auipc	a0,0x5
    2afa:	7ba50513          	addi	a0,a0,1978 # 82b0 <malloc+0x378>
    2afe:	00005097          	auipc	ra,0x5
    2b02:	248080e7          	jalr	584(ra) # 7d46 <printf>
      exit(1);
    2b06:	4505                	li	a0,1
    2b08:	00005097          	auipc	ra,0x5
    2b0c:	d10080e7          	jalr	-752(ra) # 7818 <exit>
    }

    if(pid == 0){
    2b10:	fcc42783          	lw	a5,-52(s0)
    2b14:	2781                	sext.w	a5,a5
    2b16:	efe1                	bnez	a5,2bee <fourfiles+0x166>
      fd = open(fname, O_CREATE | O_RDWR);
    2b18:	20200593          	li	a1,514
    2b1c:	fd843503          	ld	a0,-40(s0)
    2b20:	00005097          	auipc	ra,0x5
    2b24:	d38080e7          	jalr	-712(ra) # 7858 <open>
    2b28:	87aa                	mv	a5,a0
    2b2a:	fcf42a23          	sw	a5,-44(s0)
      if(fd < 0){
    2b2e:	fd442783          	lw	a5,-44(s0)
    2b32:	2781                	sext.w	a5,a5
    2b34:	0207d163          	bgez	a5,2b56 <fourfiles+0xce>
        printf("create failed\n", s);
    2b38:	f9843583          	ld	a1,-104(s0)
    2b3c:	00006517          	auipc	a0,0x6
    2b40:	05c50513          	addi	a0,a0,92 # 8b98 <malloc+0xc60>
    2b44:	00005097          	auipc	ra,0x5
    2b48:	202080e7          	jalr	514(ra) # 7d46 <printf>
        exit(1);
    2b4c:	4505                	li	a0,1
    2b4e:	00005097          	auipc	ra,0x5
    2b52:	cca080e7          	jalr	-822(ra) # 7818 <exit>
      }

      memset(buf, '0'+pi, SZ);
    2b56:	fe042783          	lw	a5,-32(s0)
    2b5a:	0307879b          	addiw	a5,a5,48
    2b5e:	2781                	sext.w	a5,a5
    2b60:	1f400613          	li	a2,500
    2b64:	85be                	mv	a1,a5
    2b66:	00009517          	auipc	a0,0x9
    2b6a:	8ea50513          	addi	a0,a0,-1814 # b450 <buf>
    2b6e:	00005097          	auipc	ra,0x5
    2b72:	900080e7          	jalr	-1792(ra) # 746e <memset>
      for(i = 0; i < N; i++){
    2b76:	fe042623          	sw	zero,-20(s0)
    2b7a:	a8b1                	j	2bd6 <fourfiles+0x14e>
        if((n = write(fd, buf, SZ)) != SZ){
    2b7c:	fd442783          	lw	a5,-44(s0)
    2b80:	1f400613          	li	a2,500
    2b84:	00009597          	auipc	a1,0x9
    2b88:	8cc58593          	addi	a1,a1,-1844 # b450 <buf>
    2b8c:	853e                	mv	a0,a5
    2b8e:	00005097          	auipc	ra,0x5
    2b92:	caa080e7          	jalr	-854(ra) # 7838 <write>
    2b96:	87aa                	mv	a5,a0
    2b98:	fcf42823          	sw	a5,-48(s0)
    2b9c:	fd042783          	lw	a5,-48(s0)
    2ba0:	0007871b          	sext.w	a4,a5
    2ba4:	1f400793          	li	a5,500
    2ba8:	02f70263          	beq	a4,a5,2bcc <fourfiles+0x144>
          printf("write failed %d\n", n);
    2bac:	fd042783          	lw	a5,-48(s0)
    2bb0:	85be                	mv	a1,a5
    2bb2:	00006517          	auipc	a0,0x6
    2bb6:	ff650513          	addi	a0,a0,-10 # 8ba8 <malloc+0xc70>
    2bba:	00005097          	auipc	ra,0x5
    2bbe:	18c080e7          	jalr	396(ra) # 7d46 <printf>
          exit(1);
    2bc2:	4505                	li	a0,1
    2bc4:	00005097          	auipc	ra,0x5
    2bc8:	c54080e7          	jalr	-940(ra) # 7818 <exit>
      for(i = 0; i < N; i++){
    2bcc:	fec42783          	lw	a5,-20(s0)
    2bd0:	2785                	addiw	a5,a5,1
    2bd2:	fef42623          	sw	a5,-20(s0)
    2bd6:	fec42783          	lw	a5,-20(s0)
    2bda:	0007871b          	sext.w	a4,a5
    2bde:	47ad                	li	a5,11
    2be0:	f8e7dee3          	bge	a5,a4,2b7c <fourfiles+0xf4>
        }
      }
      exit(0);
    2be4:	4501                	li	a0,0
    2be6:	00005097          	auipc	ra,0x5
    2bea:	c32080e7          	jalr	-974(ra) # 7818 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2bee:	fe042783          	lw	a5,-32(s0)
    2bf2:	2785                	addiw	a5,a5,1
    2bf4:	fef42023          	sw	a5,-32(s0)
    2bf8:	fe042783          	lw	a5,-32(s0)
    2bfc:	0007871b          	sext.w	a4,a5
    2c00:	478d                	li	a5,3
    2c02:	eae7dce3          	bge	a5,a4,2aba <fourfiles+0x32>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2c06:	fe042023          	sw	zero,-32(s0)
    2c0a:	a03d                	j	2c38 <fourfiles+0x1b0>
    wait(&xstatus);
    2c0c:	fa440793          	addi	a5,s0,-92
    2c10:	853e                	mv	a0,a5
    2c12:	00005097          	auipc	ra,0x5
    2c16:	c0e080e7          	jalr	-1010(ra) # 7820 <wait>
    if(xstatus != 0)
    2c1a:	fa442783          	lw	a5,-92(s0)
    2c1e:	cb81                	beqz	a5,2c2e <fourfiles+0x1a6>
      exit(xstatus);
    2c20:	fa442783          	lw	a5,-92(s0)
    2c24:	853e                	mv	a0,a5
    2c26:	00005097          	auipc	ra,0x5
    2c2a:	bf2080e7          	jalr	-1038(ra) # 7818 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2c2e:	fe042783          	lw	a5,-32(s0)
    2c32:	2785                	addiw	a5,a5,1
    2c34:	fef42023          	sw	a5,-32(s0)
    2c38:	fe042783          	lw	a5,-32(s0)
    2c3c:	0007871b          	sext.w	a4,a5
    2c40:	478d                	li	a5,3
    2c42:	fce7d5e3          	bge	a5,a4,2c0c <fourfiles+0x184>
  }

  for(i = 0; i < NCHILD; i++){
    2c46:	fe042623          	sw	zero,-20(s0)
    2c4a:	aa39                	j	2d68 <fourfiles+0x2e0>
    fname = names[i];
    2c4c:	fec42783          	lw	a5,-20(s0)
    2c50:	078e                	slli	a5,a5,0x3
    2c52:	ff040713          	addi	a4,s0,-16
    2c56:	97ba                	add	a5,a5,a4
    2c58:	fb87b783          	ld	a5,-72(a5)
    2c5c:	fcf43c23          	sd	a5,-40(s0)
    fd = open(fname, 0);
    2c60:	4581                	li	a1,0
    2c62:	fd843503          	ld	a0,-40(s0)
    2c66:	00005097          	auipc	ra,0x5
    2c6a:	bf2080e7          	jalr	-1038(ra) # 7858 <open>
    2c6e:	87aa                	mv	a5,a0
    2c70:	fcf42a23          	sw	a5,-44(s0)
    total = 0;
    2c74:	fe042223          	sw	zero,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2c78:	a88d                	j	2cea <fourfiles+0x262>
      for(j = 0; j < n; j++){
    2c7a:	fe042423          	sw	zero,-24(s0)
    2c7e:	a0b9                	j	2ccc <fourfiles+0x244>
        if(buf[j] != '0'+i){
    2c80:	00008717          	auipc	a4,0x8
    2c84:	7d070713          	addi	a4,a4,2000 # b450 <buf>
    2c88:	fe842783          	lw	a5,-24(s0)
    2c8c:	97ba                	add	a5,a5,a4
    2c8e:	0007c783          	lbu	a5,0(a5)
    2c92:	0007871b          	sext.w	a4,a5
    2c96:	fec42783          	lw	a5,-20(s0)
    2c9a:	0307879b          	addiw	a5,a5,48
    2c9e:	2781                	sext.w	a5,a5
    2ca0:	02f70163          	beq	a4,a5,2cc2 <fourfiles+0x23a>
          printf("wrong char\n", s);
    2ca4:	f9843583          	ld	a1,-104(s0)
    2ca8:	00006517          	auipc	a0,0x6
    2cac:	f1850513          	addi	a0,a0,-232 # 8bc0 <malloc+0xc88>
    2cb0:	00005097          	auipc	ra,0x5
    2cb4:	096080e7          	jalr	150(ra) # 7d46 <printf>
          exit(1);
    2cb8:	4505                	li	a0,1
    2cba:	00005097          	auipc	ra,0x5
    2cbe:	b5e080e7          	jalr	-1186(ra) # 7818 <exit>
      for(j = 0; j < n; j++){
    2cc2:	fe842783          	lw	a5,-24(s0)
    2cc6:	2785                	addiw	a5,a5,1
    2cc8:	fef42423          	sw	a5,-24(s0)
    2ccc:	fe842703          	lw	a4,-24(s0)
    2cd0:	fd042783          	lw	a5,-48(s0)
    2cd4:	2701                	sext.w	a4,a4
    2cd6:	2781                	sext.w	a5,a5
    2cd8:	faf744e3          	blt	a4,a5,2c80 <fourfiles+0x1f8>
        }
      }
      total += n;
    2cdc:	fe442703          	lw	a4,-28(s0)
    2ce0:	fd042783          	lw	a5,-48(s0)
    2ce4:	9fb9                	addw	a5,a5,a4
    2ce6:	fef42223          	sw	a5,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2cea:	fd442783          	lw	a5,-44(s0)
    2cee:	660d                	lui	a2,0x3
    2cf0:	00008597          	auipc	a1,0x8
    2cf4:	76058593          	addi	a1,a1,1888 # b450 <buf>
    2cf8:	853e                	mv	a0,a5
    2cfa:	00005097          	auipc	ra,0x5
    2cfe:	b36080e7          	jalr	-1226(ra) # 7830 <read>
    2d02:	87aa                	mv	a5,a0
    2d04:	fcf42823          	sw	a5,-48(s0)
    2d08:	fd042783          	lw	a5,-48(s0)
    2d0c:	2781                	sext.w	a5,a5
    2d0e:	f6f046e3          	bgtz	a5,2c7a <fourfiles+0x1f2>
    }
    close(fd);
    2d12:	fd442783          	lw	a5,-44(s0)
    2d16:	853e                	mv	a0,a5
    2d18:	00005097          	auipc	ra,0x5
    2d1c:	b28080e7          	jalr	-1240(ra) # 7840 <close>
    if(total != N*SZ){
    2d20:	fe442783          	lw	a5,-28(s0)
    2d24:	0007871b          	sext.w	a4,a5
    2d28:	6785                	lui	a5,0x1
    2d2a:	77078793          	addi	a5,a5,1904 # 1770 <writebig+0x124>
    2d2e:	02f70263          	beq	a4,a5,2d52 <fourfiles+0x2ca>
      printf("wrong length %d\n", total);
    2d32:	fe442783          	lw	a5,-28(s0)
    2d36:	85be                	mv	a1,a5
    2d38:	00006517          	auipc	a0,0x6
    2d3c:	e9850513          	addi	a0,a0,-360 # 8bd0 <malloc+0xc98>
    2d40:	00005097          	auipc	ra,0x5
    2d44:	006080e7          	jalr	6(ra) # 7d46 <printf>
      exit(1);
    2d48:	4505                	li	a0,1
    2d4a:	00005097          	auipc	ra,0x5
    2d4e:	ace080e7          	jalr	-1330(ra) # 7818 <exit>
    }
    unlink(fname);
    2d52:	fd843503          	ld	a0,-40(s0)
    2d56:	00005097          	auipc	ra,0x5
    2d5a:	b12080e7          	jalr	-1262(ra) # 7868 <unlink>
  for(i = 0; i < NCHILD; i++){
    2d5e:	fec42783          	lw	a5,-20(s0)
    2d62:	2785                	addiw	a5,a5,1
    2d64:	fef42623          	sw	a5,-20(s0)
    2d68:	fec42783          	lw	a5,-20(s0)
    2d6c:	0007871b          	sext.w	a4,a5
    2d70:	478d                	li	a5,3
    2d72:	ece7dde3          	bge	a5,a4,2c4c <fourfiles+0x1c4>
  }
}
    2d76:	0001                	nop
    2d78:	0001                	nop
    2d7a:	70a6                	ld	ra,104(sp)
    2d7c:	7406                	ld	s0,96(sp)
    2d7e:	6165                	addi	sp,sp,112
    2d80:	8082                	ret

0000000000002d82 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(char *s)
{
    2d82:	711d                	addi	sp,sp,-96
    2d84:	ec86                	sd	ra,88(sp)
    2d86:	e8a2                	sd	s0,80(sp)
    2d88:	1080                	addi	s0,sp,96
    2d8a:	faa43423          	sd	a0,-88(s0)
  enum { N = 20, NCHILD=4 };
  int pid, i, fd, pi;
  char name[32];

  for(pi = 0; pi < NCHILD; pi++){
    2d8e:	fe042423          	sw	zero,-24(s0)
    2d92:	aa91                	j	2ee6 <createdelete+0x164>
    pid = fork();
    2d94:	00005097          	auipc	ra,0x5
    2d98:	a7c080e7          	jalr	-1412(ra) # 7810 <fork>
    2d9c:	87aa                	mv	a5,a0
    2d9e:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2da2:	fe042783          	lw	a5,-32(s0)
    2da6:	2781                	sext.w	a5,a5
    2da8:	0207d163          	bgez	a5,2dca <createdelete+0x48>
      printf("fork failed\n", s);
    2dac:	fa843583          	ld	a1,-88(s0)
    2db0:	00005517          	auipc	a0,0x5
    2db4:	50050513          	addi	a0,a0,1280 # 82b0 <malloc+0x378>
    2db8:	00005097          	auipc	ra,0x5
    2dbc:	f8e080e7          	jalr	-114(ra) # 7d46 <printf>
      exit(1);
    2dc0:	4505                	li	a0,1
    2dc2:	00005097          	auipc	ra,0x5
    2dc6:	a56080e7          	jalr	-1450(ra) # 7818 <exit>
    }

    if(pid == 0){
    2dca:	fe042783          	lw	a5,-32(s0)
    2dce:	2781                	sext.w	a5,a5
    2dd0:	10079663          	bnez	a5,2edc <createdelete+0x15a>
      name[0] = 'p' + pi;
    2dd4:	fe842783          	lw	a5,-24(s0)
    2dd8:	0ff7f793          	andi	a5,a5,255
    2ddc:	0707879b          	addiw	a5,a5,112
    2de0:	0ff7f793          	andi	a5,a5,255
    2de4:	fcf40023          	sb	a5,-64(s0)
      name[2] = '\0';
    2de8:	fc040123          	sb	zero,-62(s0)
      for(i = 0; i < N; i++){
    2dec:	fe042623          	sw	zero,-20(s0)
    2df0:	a8d1                	j	2ec4 <createdelete+0x142>
        name[1] = '0' + i;
    2df2:	fec42783          	lw	a5,-20(s0)
    2df6:	0ff7f793          	andi	a5,a5,255
    2dfa:	0307879b          	addiw	a5,a5,48
    2dfe:	0ff7f793          	andi	a5,a5,255
    2e02:	fcf400a3          	sb	a5,-63(s0)
        fd = open(name, O_CREATE | O_RDWR);
    2e06:	fc040793          	addi	a5,s0,-64
    2e0a:	20200593          	li	a1,514
    2e0e:	853e                	mv	a0,a5
    2e10:	00005097          	auipc	ra,0x5
    2e14:	a48080e7          	jalr	-1464(ra) # 7858 <open>
    2e18:	87aa                	mv	a5,a0
    2e1a:	fef42223          	sw	a5,-28(s0)
        if(fd < 0){
    2e1e:	fe442783          	lw	a5,-28(s0)
    2e22:	2781                	sext.w	a5,a5
    2e24:	0207d163          	bgez	a5,2e46 <createdelete+0xc4>
          printf("%s: create failed\n", s);
    2e28:	fa843583          	ld	a1,-88(s0)
    2e2c:	00006517          	auipc	a0,0x6
    2e30:	adc50513          	addi	a0,a0,-1316 # 8908 <malloc+0x9d0>
    2e34:	00005097          	auipc	ra,0x5
    2e38:	f12080e7          	jalr	-238(ra) # 7d46 <printf>
          exit(1);
    2e3c:	4505                	li	a0,1
    2e3e:	00005097          	auipc	ra,0x5
    2e42:	9da080e7          	jalr	-1574(ra) # 7818 <exit>
        }
        close(fd);
    2e46:	fe442783          	lw	a5,-28(s0)
    2e4a:	853e                	mv	a0,a5
    2e4c:	00005097          	auipc	ra,0x5
    2e50:	9f4080e7          	jalr	-1548(ra) # 7840 <close>
        if(i > 0 && (i % 2 ) == 0){
    2e54:	fec42783          	lw	a5,-20(s0)
    2e58:	2781                	sext.w	a5,a5
    2e5a:	06f05063          	blez	a5,2eba <createdelete+0x138>
    2e5e:	fec42783          	lw	a5,-20(s0)
    2e62:	8b85                	andi	a5,a5,1
    2e64:	2781                	sext.w	a5,a5
    2e66:	ebb1                	bnez	a5,2eba <createdelete+0x138>
          name[1] = '0' + (i / 2);
    2e68:	fec42783          	lw	a5,-20(s0)
    2e6c:	01f7d71b          	srliw	a4,a5,0x1f
    2e70:	9fb9                	addw	a5,a5,a4
    2e72:	4017d79b          	sraiw	a5,a5,0x1
    2e76:	2781                	sext.w	a5,a5
    2e78:	0ff7f793          	andi	a5,a5,255
    2e7c:	0307879b          	addiw	a5,a5,48
    2e80:	0ff7f793          	andi	a5,a5,255
    2e84:	fcf400a3          	sb	a5,-63(s0)
          if(unlink(name) < 0){
    2e88:	fc040793          	addi	a5,s0,-64
    2e8c:	853e                	mv	a0,a5
    2e8e:	00005097          	auipc	ra,0x5
    2e92:	9da080e7          	jalr	-1574(ra) # 7868 <unlink>
    2e96:	87aa                	mv	a5,a0
    2e98:	0207d163          	bgez	a5,2eba <createdelete+0x138>
            printf("%s: unlink failed\n", s);
    2e9c:	fa843583          	ld	a1,-88(s0)
    2ea0:	00005517          	auipc	a0,0x5
    2ea4:	7b850513          	addi	a0,a0,1976 # 8658 <malloc+0x720>
    2ea8:	00005097          	auipc	ra,0x5
    2eac:	e9e080e7          	jalr	-354(ra) # 7d46 <printf>
            exit(1);
    2eb0:	4505                	li	a0,1
    2eb2:	00005097          	auipc	ra,0x5
    2eb6:	966080e7          	jalr	-1690(ra) # 7818 <exit>
      for(i = 0; i < N; i++){
    2eba:	fec42783          	lw	a5,-20(s0)
    2ebe:	2785                	addiw	a5,a5,1
    2ec0:	fef42623          	sw	a5,-20(s0)
    2ec4:	fec42783          	lw	a5,-20(s0)
    2ec8:	0007871b          	sext.w	a4,a5
    2ecc:	47cd                	li	a5,19
    2ece:	f2e7d2e3          	bge	a5,a4,2df2 <createdelete+0x70>
          }
        }
      }
      exit(0);
    2ed2:	4501                	li	a0,0
    2ed4:	00005097          	auipc	ra,0x5
    2ed8:	944080e7          	jalr	-1724(ra) # 7818 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2edc:	fe842783          	lw	a5,-24(s0)
    2ee0:	2785                	addiw	a5,a5,1
    2ee2:	fef42423          	sw	a5,-24(s0)
    2ee6:	fe842783          	lw	a5,-24(s0)
    2eea:	0007871b          	sext.w	a4,a5
    2eee:	478d                	li	a5,3
    2ef0:	eae7d2e3          	bge	a5,a4,2d94 <createdelete+0x12>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2ef4:	fe042423          	sw	zero,-24(s0)
    2ef8:	a02d                	j	2f22 <createdelete+0x1a0>
    wait(&xstatus);
    2efa:	fbc40793          	addi	a5,s0,-68
    2efe:	853e                	mv	a0,a5
    2f00:	00005097          	auipc	ra,0x5
    2f04:	920080e7          	jalr	-1760(ra) # 7820 <wait>
    if(xstatus != 0)
    2f08:	fbc42783          	lw	a5,-68(s0)
    2f0c:	c791                	beqz	a5,2f18 <createdelete+0x196>
      exit(1);
    2f0e:	4505                	li	a0,1
    2f10:	00005097          	auipc	ra,0x5
    2f14:	908080e7          	jalr	-1784(ra) # 7818 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2f18:	fe842783          	lw	a5,-24(s0)
    2f1c:	2785                	addiw	a5,a5,1
    2f1e:	fef42423          	sw	a5,-24(s0)
    2f22:	fe842783          	lw	a5,-24(s0)
    2f26:	0007871b          	sext.w	a4,a5
    2f2a:	478d                	li	a5,3
    2f2c:	fce7d7e3          	bge	a5,a4,2efa <createdelete+0x178>
  }

  name[0] = name[1] = name[2] = 0;
    2f30:	fc040123          	sb	zero,-62(s0)
    2f34:	fc244783          	lbu	a5,-62(s0)
    2f38:	fcf400a3          	sb	a5,-63(s0)
    2f3c:	fc144783          	lbu	a5,-63(s0)
    2f40:	fcf40023          	sb	a5,-64(s0)
  for(i = 0; i < N; i++){
    2f44:	fe042623          	sw	zero,-20(s0)
    2f48:	a229                	j	3052 <createdelete+0x2d0>
    for(pi = 0; pi < NCHILD; pi++){
    2f4a:	fe042423          	sw	zero,-24(s0)
    2f4e:	a0f5                	j	303a <createdelete+0x2b8>
      name[0] = 'p' + pi;
    2f50:	fe842783          	lw	a5,-24(s0)
    2f54:	0ff7f793          	andi	a5,a5,255
    2f58:	0707879b          	addiw	a5,a5,112
    2f5c:	0ff7f793          	andi	a5,a5,255
    2f60:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    2f64:	fec42783          	lw	a5,-20(s0)
    2f68:	0ff7f793          	andi	a5,a5,255
    2f6c:	0307879b          	addiw	a5,a5,48
    2f70:	0ff7f793          	andi	a5,a5,255
    2f74:	fcf400a3          	sb	a5,-63(s0)
      fd = open(name, 0);
    2f78:	fc040793          	addi	a5,s0,-64
    2f7c:	4581                	li	a1,0
    2f7e:	853e                	mv	a0,a5
    2f80:	00005097          	auipc	ra,0x5
    2f84:	8d8080e7          	jalr	-1832(ra) # 7858 <open>
    2f88:	87aa                	mv	a5,a0
    2f8a:	fef42223          	sw	a5,-28(s0)
      if((i == 0 || i >= N/2) && fd < 0){
    2f8e:	fec42783          	lw	a5,-20(s0)
    2f92:	2781                	sext.w	a5,a5
    2f94:	cb81                	beqz	a5,2fa4 <createdelete+0x222>
    2f96:	fec42783          	lw	a5,-20(s0)
    2f9a:	0007871b          	sext.w	a4,a5
    2f9e:	47a5                	li	a5,9
    2fa0:	02e7d963          	bge	a5,a4,2fd2 <createdelete+0x250>
    2fa4:	fe442783          	lw	a5,-28(s0)
    2fa8:	2781                	sext.w	a5,a5
    2faa:	0207d463          	bgez	a5,2fd2 <createdelete+0x250>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    2fae:	fc040793          	addi	a5,s0,-64
    2fb2:	863e                	mv	a2,a5
    2fb4:	fa843583          	ld	a1,-88(s0)
    2fb8:	00006517          	auipc	a0,0x6
    2fbc:	c5050513          	addi	a0,a0,-944 # 8c08 <malloc+0xcd0>
    2fc0:	00005097          	auipc	ra,0x5
    2fc4:	d86080e7          	jalr	-634(ra) # 7d46 <printf>
        exit(1);
    2fc8:	4505                	li	a0,1
    2fca:	00005097          	auipc	ra,0x5
    2fce:	84e080e7          	jalr	-1970(ra) # 7818 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2fd2:	fec42783          	lw	a5,-20(s0)
    2fd6:	2781                	sext.w	a5,a5
    2fd8:	04f05063          	blez	a5,3018 <createdelete+0x296>
    2fdc:	fec42783          	lw	a5,-20(s0)
    2fe0:	0007871b          	sext.w	a4,a5
    2fe4:	47a5                	li	a5,9
    2fe6:	02e7c963          	blt	a5,a4,3018 <createdelete+0x296>
    2fea:	fe442783          	lw	a5,-28(s0)
    2fee:	2781                	sext.w	a5,a5
    2ff0:	0207c463          	bltz	a5,3018 <createdelete+0x296>
        printf("%s: oops createdelete %s did exist\n", s, name);
    2ff4:	fc040793          	addi	a5,s0,-64
    2ff8:	863e                	mv	a2,a5
    2ffa:	fa843583          	ld	a1,-88(s0)
    2ffe:	00006517          	auipc	a0,0x6
    3002:	c3250513          	addi	a0,a0,-974 # 8c30 <malloc+0xcf8>
    3006:	00005097          	auipc	ra,0x5
    300a:	d40080e7          	jalr	-704(ra) # 7d46 <printf>
        exit(1);
    300e:	4505                	li	a0,1
    3010:	00005097          	auipc	ra,0x5
    3014:	808080e7          	jalr	-2040(ra) # 7818 <exit>
      }
      if(fd >= 0)
    3018:	fe442783          	lw	a5,-28(s0)
    301c:	2781                	sext.w	a5,a5
    301e:	0007c963          	bltz	a5,3030 <createdelete+0x2ae>
        close(fd);
    3022:	fe442783          	lw	a5,-28(s0)
    3026:	853e                	mv	a0,a5
    3028:	00005097          	auipc	ra,0x5
    302c:	818080e7          	jalr	-2024(ra) # 7840 <close>
    for(pi = 0; pi < NCHILD; pi++){
    3030:	fe842783          	lw	a5,-24(s0)
    3034:	2785                	addiw	a5,a5,1
    3036:	fef42423          	sw	a5,-24(s0)
    303a:	fe842783          	lw	a5,-24(s0)
    303e:	0007871b          	sext.w	a4,a5
    3042:	478d                	li	a5,3
    3044:	f0e7d6e3          	bge	a5,a4,2f50 <createdelete+0x1ce>
  for(i = 0; i < N; i++){
    3048:	fec42783          	lw	a5,-20(s0)
    304c:	2785                	addiw	a5,a5,1
    304e:	fef42623          	sw	a5,-20(s0)
    3052:	fec42783          	lw	a5,-20(s0)
    3056:	0007871b          	sext.w	a4,a5
    305a:	47cd                	li	a5,19
    305c:	eee7d7e3          	bge	a5,a4,2f4a <createdelete+0x1c8>
    }
  }

  for(i = 0; i < N; i++){
    3060:	fe042623          	sw	zero,-20(s0)
    3064:	a085                	j	30c4 <createdelete+0x342>
    for(pi = 0; pi < NCHILD; pi++){
    3066:	fe042423          	sw	zero,-24(s0)
    306a:	a089                	j	30ac <createdelete+0x32a>
      name[0] = 'p' + i;
    306c:	fec42783          	lw	a5,-20(s0)
    3070:	0ff7f793          	andi	a5,a5,255
    3074:	0707879b          	addiw	a5,a5,112
    3078:	0ff7f793          	andi	a5,a5,255
    307c:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    3080:	fec42783          	lw	a5,-20(s0)
    3084:	0ff7f793          	andi	a5,a5,255
    3088:	0307879b          	addiw	a5,a5,48
    308c:	0ff7f793          	andi	a5,a5,255
    3090:	fcf400a3          	sb	a5,-63(s0)
      unlink(name);
    3094:	fc040793          	addi	a5,s0,-64
    3098:	853e                	mv	a0,a5
    309a:	00004097          	auipc	ra,0x4
    309e:	7ce080e7          	jalr	1998(ra) # 7868 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    30a2:	fe842783          	lw	a5,-24(s0)
    30a6:	2785                	addiw	a5,a5,1
    30a8:	fef42423          	sw	a5,-24(s0)
    30ac:	fe842783          	lw	a5,-24(s0)
    30b0:	0007871b          	sext.w	a4,a5
    30b4:	478d                	li	a5,3
    30b6:	fae7dbe3          	bge	a5,a4,306c <createdelete+0x2ea>
  for(i = 0; i < N; i++){
    30ba:	fec42783          	lw	a5,-20(s0)
    30be:	2785                	addiw	a5,a5,1
    30c0:	fef42623          	sw	a5,-20(s0)
    30c4:	fec42783          	lw	a5,-20(s0)
    30c8:	0007871b          	sext.w	a4,a5
    30cc:	47cd                	li	a5,19
    30ce:	f8e7dce3          	bge	a5,a4,3066 <createdelete+0x2e4>
    }
  }
}
    30d2:	0001                	nop
    30d4:	0001                	nop
    30d6:	60e6                	ld	ra,88(sp)
    30d8:	6446                	ld	s0,80(sp)
    30da:	6125                	addi	sp,sp,96
    30dc:	8082                	ret

00000000000030de <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(char *s)
{
    30de:	7179                	addi	sp,sp,-48
    30e0:	f406                	sd	ra,40(sp)
    30e2:	f022                	sd	s0,32(sp)
    30e4:	1800                	addi	s0,sp,48
    30e6:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd, fd1;

  fd = open("unlinkread", O_CREATE | O_RDWR);
    30ea:	20200593          	li	a1,514
    30ee:	00006517          	auipc	a0,0x6
    30f2:	b6a50513          	addi	a0,a0,-1174 # 8c58 <malloc+0xd20>
    30f6:	00004097          	auipc	ra,0x4
    30fa:	762080e7          	jalr	1890(ra) # 7858 <open>
    30fe:	87aa                	mv	a5,a0
    3100:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3104:	fec42783          	lw	a5,-20(s0)
    3108:	2781                	sext.w	a5,a5
    310a:	0207d163          	bgez	a5,312c <unlinkread+0x4e>
    printf("%s: create unlinkread failed\n", s);
    310e:	fd843583          	ld	a1,-40(s0)
    3112:	00006517          	auipc	a0,0x6
    3116:	b5650513          	addi	a0,a0,-1194 # 8c68 <malloc+0xd30>
    311a:	00005097          	auipc	ra,0x5
    311e:	c2c080e7          	jalr	-980(ra) # 7d46 <printf>
    exit(1);
    3122:	4505                	li	a0,1
    3124:	00004097          	auipc	ra,0x4
    3128:	6f4080e7          	jalr	1780(ra) # 7818 <exit>
  }
  write(fd, "hello", SZ);
    312c:	fec42783          	lw	a5,-20(s0)
    3130:	4615                	li	a2,5
    3132:	00006597          	auipc	a1,0x6
    3136:	b5658593          	addi	a1,a1,-1194 # 8c88 <malloc+0xd50>
    313a:	853e                	mv	a0,a5
    313c:	00004097          	auipc	ra,0x4
    3140:	6fc080e7          	jalr	1788(ra) # 7838 <write>
  close(fd);
    3144:	fec42783          	lw	a5,-20(s0)
    3148:	853e                	mv	a0,a5
    314a:	00004097          	auipc	ra,0x4
    314e:	6f6080e7          	jalr	1782(ra) # 7840 <close>

  fd = open("unlinkread", O_RDWR);
    3152:	4589                	li	a1,2
    3154:	00006517          	auipc	a0,0x6
    3158:	b0450513          	addi	a0,a0,-1276 # 8c58 <malloc+0xd20>
    315c:	00004097          	auipc	ra,0x4
    3160:	6fc080e7          	jalr	1788(ra) # 7858 <open>
    3164:	87aa                	mv	a5,a0
    3166:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    316a:	fec42783          	lw	a5,-20(s0)
    316e:	2781                	sext.w	a5,a5
    3170:	0207d163          	bgez	a5,3192 <unlinkread+0xb4>
    printf("%s: open unlinkread failed\n", s);
    3174:	fd843583          	ld	a1,-40(s0)
    3178:	00006517          	auipc	a0,0x6
    317c:	b1850513          	addi	a0,a0,-1256 # 8c90 <malloc+0xd58>
    3180:	00005097          	auipc	ra,0x5
    3184:	bc6080e7          	jalr	-1082(ra) # 7d46 <printf>
    exit(1);
    3188:	4505                	li	a0,1
    318a:	00004097          	auipc	ra,0x4
    318e:	68e080e7          	jalr	1678(ra) # 7818 <exit>
  }
  if(unlink("unlinkread") != 0){
    3192:	00006517          	auipc	a0,0x6
    3196:	ac650513          	addi	a0,a0,-1338 # 8c58 <malloc+0xd20>
    319a:	00004097          	auipc	ra,0x4
    319e:	6ce080e7          	jalr	1742(ra) # 7868 <unlink>
    31a2:	87aa                	mv	a5,a0
    31a4:	c385                	beqz	a5,31c4 <unlinkread+0xe6>
    printf("%s: unlink unlinkread failed\n", s);
    31a6:	fd843583          	ld	a1,-40(s0)
    31aa:	00006517          	auipc	a0,0x6
    31ae:	b0650513          	addi	a0,a0,-1274 # 8cb0 <malloc+0xd78>
    31b2:	00005097          	auipc	ra,0x5
    31b6:	b94080e7          	jalr	-1132(ra) # 7d46 <printf>
    exit(1);
    31ba:	4505                	li	a0,1
    31bc:	00004097          	auipc	ra,0x4
    31c0:	65c080e7          	jalr	1628(ra) # 7818 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    31c4:	20200593          	li	a1,514
    31c8:	00006517          	auipc	a0,0x6
    31cc:	a9050513          	addi	a0,a0,-1392 # 8c58 <malloc+0xd20>
    31d0:	00004097          	auipc	ra,0x4
    31d4:	688080e7          	jalr	1672(ra) # 7858 <open>
    31d8:	87aa                	mv	a5,a0
    31da:	fef42423          	sw	a5,-24(s0)
  write(fd1, "yyy", 3);
    31de:	fe842783          	lw	a5,-24(s0)
    31e2:	460d                	li	a2,3
    31e4:	00006597          	auipc	a1,0x6
    31e8:	aec58593          	addi	a1,a1,-1300 # 8cd0 <malloc+0xd98>
    31ec:	853e                	mv	a0,a5
    31ee:	00004097          	auipc	ra,0x4
    31f2:	64a080e7          	jalr	1610(ra) # 7838 <write>
  close(fd1);
    31f6:	fe842783          	lw	a5,-24(s0)
    31fa:	853e                	mv	a0,a5
    31fc:	00004097          	auipc	ra,0x4
    3200:	644080e7          	jalr	1604(ra) # 7840 <close>

  if(read(fd, buf, sizeof(buf)) != SZ){
    3204:	fec42783          	lw	a5,-20(s0)
    3208:	660d                	lui	a2,0x3
    320a:	00008597          	auipc	a1,0x8
    320e:	24658593          	addi	a1,a1,582 # b450 <buf>
    3212:	853e                	mv	a0,a5
    3214:	00004097          	auipc	ra,0x4
    3218:	61c080e7          	jalr	1564(ra) # 7830 <read>
    321c:	87aa                	mv	a5,a0
    321e:	873e                	mv	a4,a5
    3220:	4795                	li	a5,5
    3222:	02f70163          	beq	a4,a5,3244 <unlinkread+0x166>
    printf("%s: unlinkread read failed", s);
    3226:	fd843583          	ld	a1,-40(s0)
    322a:	00006517          	auipc	a0,0x6
    322e:	aae50513          	addi	a0,a0,-1362 # 8cd8 <malloc+0xda0>
    3232:	00005097          	auipc	ra,0x5
    3236:	b14080e7          	jalr	-1260(ra) # 7d46 <printf>
    exit(1);
    323a:	4505                	li	a0,1
    323c:	00004097          	auipc	ra,0x4
    3240:	5dc080e7          	jalr	1500(ra) # 7818 <exit>
  }
  if(buf[0] != 'h'){
    3244:	00008797          	auipc	a5,0x8
    3248:	20c78793          	addi	a5,a5,524 # b450 <buf>
    324c:	0007c783          	lbu	a5,0(a5)
    3250:	873e                	mv	a4,a5
    3252:	06800793          	li	a5,104
    3256:	02f70163          	beq	a4,a5,3278 <unlinkread+0x19a>
    printf("%s: unlinkread wrong data\n", s);
    325a:	fd843583          	ld	a1,-40(s0)
    325e:	00006517          	auipc	a0,0x6
    3262:	a9a50513          	addi	a0,a0,-1382 # 8cf8 <malloc+0xdc0>
    3266:	00005097          	auipc	ra,0x5
    326a:	ae0080e7          	jalr	-1312(ra) # 7d46 <printf>
    exit(1);
    326e:	4505                	li	a0,1
    3270:	00004097          	auipc	ra,0x4
    3274:	5a8080e7          	jalr	1448(ra) # 7818 <exit>
  }
  if(write(fd, buf, 10) != 10){
    3278:	fec42783          	lw	a5,-20(s0)
    327c:	4629                	li	a2,10
    327e:	00008597          	auipc	a1,0x8
    3282:	1d258593          	addi	a1,a1,466 # b450 <buf>
    3286:	853e                	mv	a0,a5
    3288:	00004097          	auipc	ra,0x4
    328c:	5b0080e7          	jalr	1456(ra) # 7838 <write>
    3290:	87aa                	mv	a5,a0
    3292:	873e                	mv	a4,a5
    3294:	47a9                	li	a5,10
    3296:	02f70163          	beq	a4,a5,32b8 <unlinkread+0x1da>
    printf("%s: unlinkread write failed\n", s);
    329a:	fd843583          	ld	a1,-40(s0)
    329e:	00006517          	auipc	a0,0x6
    32a2:	a7a50513          	addi	a0,a0,-1414 # 8d18 <malloc+0xde0>
    32a6:	00005097          	auipc	ra,0x5
    32aa:	aa0080e7          	jalr	-1376(ra) # 7d46 <printf>
    exit(1);
    32ae:	4505                	li	a0,1
    32b0:	00004097          	auipc	ra,0x4
    32b4:	568080e7          	jalr	1384(ra) # 7818 <exit>
  }
  close(fd);
    32b8:	fec42783          	lw	a5,-20(s0)
    32bc:	853e                	mv	a0,a5
    32be:	00004097          	auipc	ra,0x4
    32c2:	582080e7          	jalr	1410(ra) # 7840 <close>
  unlink("unlinkread");
    32c6:	00006517          	auipc	a0,0x6
    32ca:	99250513          	addi	a0,a0,-1646 # 8c58 <malloc+0xd20>
    32ce:	00004097          	auipc	ra,0x4
    32d2:	59a080e7          	jalr	1434(ra) # 7868 <unlink>
}
    32d6:	0001                	nop
    32d8:	70a2                	ld	ra,40(sp)
    32da:	7402                	ld	s0,32(sp)
    32dc:	6145                	addi	sp,sp,48
    32de:	8082                	ret

00000000000032e0 <linktest>:

void
linktest(char *s)
{
    32e0:	7179                	addi	sp,sp,-48
    32e2:	f406                	sd	ra,40(sp)
    32e4:	f022                	sd	s0,32(sp)
    32e6:	1800                	addi	s0,sp,48
    32e8:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd;

  unlink("lf1");
    32ec:	00006517          	auipc	a0,0x6
    32f0:	a4c50513          	addi	a0,a0,-1460 # 8d38 <malloc+0xe00>
    32f4:	00004097          	auipc	ra,0x4
    32f8:	574080e7          	jalr	1396(ra) # 7868 <unlink>
  unlink("lf2");
    32fc:	00006517          	auipc	a0,0x6
    3300:	a4450513          	addi	a0,a0,-1468 # 8d40 <malloc+0xe08>
    3304:	00004097          	auipc	ra,0x4
    3308:	564080e7          	jalr	1380(ra) # 7868 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    330c:	20200593          	li	a1,514
    3310:	00006517          	auipc	a0,0x6
    3314:	a2850513          	addi	a0,a0,-1496 # 8d38 <malloc+0xe00>
    3318:	00004097          	auipc	ra,0x4
    331c:	540080e7          	jalr	1344(ra) # 7858 <open>
    3320:	87aa                	mv	a5,a0
    3322:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3326:	fec42783          	lw	a5,-20(s0)
    332a:	2781                	sext.w	a5,a5
    332c:	0207d163          	bgez	a5,334e <linktest+0x6e>
    printf("%s: create lf1 failed\n", s);
    3330:	fd843583          	ld	a1,-40(s0)
    3334:	00006517          	auipc	a0,0x6
    3338:	a1450513          	addi	a0,a0,-1516 # 8d48 <malloc+0xe10>
    333c:	00005097          	auipc	ra,0x5
    3340:	a0a080e7          	jalr	-1526(ra) # 7d46 <printf>
    exit(1);
    3344:	4505                	li	a0,1
    3346:	00004097          	auipc	ra,0x4
    334a:	4d2080e7          	jalr	1234(ra) # 7818 <exit>
  }
  if(write(fd, "hello", SZ) != SZ){
    334e:	fec42783          	lw	a5,-20(s0)
    3352:	4615                	li	a2,5
    3354:	00006597          	auipc	a1,0x6
    3358:	93458593          	addi	a1,a1,-1740 # 8c88 <malloc+0xd50>
    335c:	853e                	mv	a0,a5
    335e:	00004097          	auipc	ra,0x4
    3362:	4da080e7          	jalr	1242(ra) # 7838 <write>
    3366:	87aa                	mv	a5,a0
    3368:	873e                	mv	a4,a5
    336a:	4795                	li	a5,5
    336c:	02f70163          	beq	a4,a5,338e <linktest+0xae>
    printf("%s: write lf1 failed\n", s);
    3370:	fd843583          	ld	a1,-40(s0)
    3374:	00006517          	auipc	a0,0x6
    3378:	9ec50513          	addi	a0,a0,-1556 # 8d60 <malloc+0xe28>
    337c:	00005097          	auipc	ra,0x5
    3380:	9ca080e7          	jalr	-1590(ra) # 7d46 <printf>
    exit(1);
    3384:	4505                	li	a0,1
    3386:	00004097          	auipc	ra,0x4
    338a:	492080e7          	jalr	1170(ra) # 7818 <exit>
  }
  close(fd);
    338e:	fec42783          	lw	a5,-20(s0)
    3392:	853e                	mv	a0,a5
    3394:	00004097          	auipc	ra,0x4
    3398:	4ac080e7          	jalr	1196(ra) # 7840 <close>

  if(link("lf1", "lf2") < 0){
    339c:	00006597          	auipc	a1,0x6
    33a0:	9a458593          	addi	a1,a1,-1628 # 8d40 <malloc+0xe08>
    33a4:	00006517          	auipc	a0,0x6
    33a8:	99450513          	addi	a0,a0,-1644 # 8d38 <malloc+0xe00>
    33ac:	00004097          	auipc	ra,0x4
    33b0:	4cc080e7          	jalr	1228(ra) # 7878 <link>
    33b4:	87aa                	mv	a5,a0
    33b6:	0207d163          	bgez	a5,33d8 <linktest+0xf8>
    printf("%s: link lf1 lf2 failed\n", s);
    33ba:	fd843583          	ld	a1,-40(s0)
    33be:	00006517          	auipc	a0,0x6
    33c2:	9ba50513          	addi	a0,a0,-1606 # 8d78 <malloc+0xe40>
    33c6:	00005097          	auipc	ra,0x5
    33ca:	980080e7          	jalr	-1664(ra) # 7d46 <printf>
    exit(1);
    33ce:	4505                	li	a0,1
    33d0:	00004097          	auipc	ra,0x4
    33d4:	448080e7          	jalr	1096(ra) # 7818 <exit>
  }
  unlink("lf1");
    33d8:	00006517          	auipc	a0,0x6
    33dc:	96050513          	addi	a0,a0,-1696 # 8d38 <malloc+0xe00>
    33e0:	00004097          	auipc	ra,0x4
    33e4:	488080e7          	jalr	1160(ra) # 7868 <unlink>

  if(open("lf1", 0) >= 0){
    33e8:	4581                	li	a1,0
    33ea:	00006517          	auipc	a0,0x6
    33ee:	94e50513          	addi	a0,a0,-1714 # 8d38 <malloc+0xe00>
    33f2:	00004097          	auipc	ra,0x4
    33f6:	466080e7          	jalr	1126(ra) # 7858 <open>
    33fa:	87aa                	mv	a5,a0
    33fc:	0207c163          	bltz	a5,341e <linktest+0x13e>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    3400:	fd843583          	ld	a1,-40(s0)
    3404:	00006517          	auipc	a0,0x6
    3408:	99450513          	addi	a0,a0,-1644 # 8d98 <malloc+0xe60>
    340c:	00005097          	auipc	ra,0x5
    3410:	93a080e7          	jalr	-1734(ra) # 7d46 <printf>
    exit(1);
    3414:	4505                	li	a0,1
    3416:	00004097          	auipc	ra,0x4
    341a:	402080e7          	jalr	1026(ra) # 7818 <exit>
  }

  fd = open("lf2", 0);
    341e:	4581                	li	a1,0
    3420:	00006517          	auipc	a0,0x6
    3424:	92050513          	addi	a0,a0,-1760 # 8d40 <malloc+0xe08>
    3428:	00004097          	auipc	ra,0x4
    342c:	430080e7          	jalr	1072(ra) # 7858 <open>
    3430:	87aa                	mv	a5,a0
    3432:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3436:	fec42783          	lw	a5,-20(s0)
    343a:	2781                	sext.w	a5,a5
    343c:	0207d163          	bgez	a5,345e <linktest+0x17e>
    printf("%s: open lf2 failed\n", s);
    3440:	fd843583          	ld	a1,-40(s0)
    3444:	00006517          	auipc	a0,0x6
    3448:	98450513          	addi	a0,a0,-1660 # 8dc8 <malloc+0xe90>
    344c:	00005097          	auipc	ra,0x5
    3450:	8fa080e7          	jalr	-1798(ra) # 7d46 <printf>
    exit(1);
    3454:	4505                	li	a0,1
    3456:	00004097          	auipc	ra,0x4
    345a:	3c2080e7          	jalr	962(ra) # 7818 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != SZ){
    345e:	fec42783          	lw	a5,-20(s0)
    3462:	660d                	lui	a2,0x3
    3464:	00008597          	auipc	a1,0x8
    3468:	fec58593          	addi	a1,a1,-20 # b450 <buf>
    346c:	853e                	mv	a0,a5
    346e:	00004097          	auipc	ra,0x4
    3472:	3c2080e7          	jalr	962(ra) # 7830 <read>
    3476:	87aa                	mv	a5,a0
    3478:	873e                	mv	a4,a5
    347a:	4795                	li	a5,5
    347c:	02f70163          	beq	a4,a5,349e <linktest+0x1be>
    printf("%s: read lf2 failed\n", s);
    3480:	fd843583          	ld	a1,-40(s0)
    3484:	00006517          	auipc	a0,0x6
    3488:	95c50513          	addi	a0,a0,-1700 # 8de0 <malloc+0xea8>
    348c:	00005097          	auipc	ra,0x5
    3490:	8ba080e7          	jalr	-1862(ra) # 7d46 <printf>
    exit(1);
    3494:	4505                	li	a0,1
    3496:	00004097          	auipc	ra,0x4
    349a:	382080e7          	jalr	898(ra) # 7818 <exit>
  }
  close(fd);
    349e:	fec42783          	lw	a5,-20(s0)
    34a2:	853e                	mv	a0,a5
    34a4:	00004097          	auipc	ra,0x4
    34a8:	39c080e7          	jalr	924(ra) # 7840 <close>

  if(link("lf2", "lf2") >= 0){
    34ac:	00006597          	auipc	a1,0x6
    34b0:	89458593          	addi	a1,a1,-1900 # 8d40 <malloc+0xe08>
    34b4:	00006517          	auipc	a0,0x6
    34b8:	88c50513          	addi	a0,a0,-1908 # 8d40 <malloc+0xe08>
    34bc:	00004097          	auipc	ra,0x4
    34c0:	3bc080e7          	jalr	956(ra) # 7878 <link>
    34c4:	87aa                	mv	a5,a0
    34c6:	0207c163          	bltz	a5,34e8 <linktest+0x208>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    34ca:	fd843583          	ld	a1,-40(s0)
    34ce:	00006517          	auipc	a0,0x6
    34d2:	92a50513          	addi	a0,a0,-1750 # 8df8 <malloc+0xec0>
    34d6:	00005097          	auipc	ra,0x5
    34da:	870080e7          	jalr	-1936(ra) # 7d46 <printf>
    exit(1);
    34de:	4505                	li	a0,1
    34e0:	00004097          	auipc	ra,0x4
    34e4:	338080e7          	jalr	824(ra) # 7818 <exit>
  }

  unlink("lf2");
    34e8:	00006517          	auipc	a0,0x6
    34ec:	85850513          	addi	a0,a0,-1960 # 8d40 <malloc+0xe08>
    34f0:	00004097          	auipc	ra,0x4
    34f4:	378080e7          	jalr	888(ra) # 7868 <unlink>
  if(link("lf2", "lf1") >= 0){
    34f8:	00006597          	auipc	a1,0x6
    34fc:	84058593          	addi	a1,a1,-1984 # 8d38 <malloc+0xe00>
    3500:	00006517          	auipc	a0,0x6
    3504:	84050513          	addi	a0,a0,-1984 # 8d40 <malloc+0xe08>
    3508:	00004097          	auipc	ra,0x4
    350c:	370080e7          	jalr	880(ra) # 7878 <link>
    3510:	87aa                	mv	a5,a0
    3512:	0207c163          	bltz	a5,3534 <linktest+0x254>
    printf("%s: link non-existent succeeded! oops\n", s);
    3516:	fd843583          	ld	a1,-40(s0)
    351a:	00006517          	auipc	a0,0x6
    351e:	90650513          	addi	a0,a0,-1786 # 8e20 <malloc+0xee8>
    3522:	00005097          	auipc	ra,0x5
    3526:	824080e7          	jalr	-2012(ra) # 7d46 <printf>
    exit(1);
    352a:	4505                	li	a0,1
    352c:	00004097          	auipc	ra,0x4
    3530:	2ec080e7          	jalr	748(ra) # 7818 <exit>
  }

  if(link(".", "lf1") >= 0){
    3534:	00006597          	auipc	a1,0x6
    3538:	80458593          	addi	a1,a1,-2044 # 8d38 <malloc+0xe00>
    353c:	00006517          	auipc	a0,0x6
    3540:	90c50513          	addi	a0,a0,-1780 # 8e48 <malloc+0xf10>
    3544:	00004097          	auipc	ra,0x4
    3548:	334080e7          	jalr	820(ra) # 7878 <link>
    354c:	87aa                	mv	a5,a0
    354e:	0207c163          	bltz	a5,3570 <linktest+0x290>
    printf("%s: link . lf1 succeeded! oops\n", s);
    3552:	fd843583          	ld	a1,-40(s0)
    3556:	00006517          	auipc	a0,0x6
    355a:	8fa50513          	addi	a0,a0,-1798 # 8e50 <malloc+0xf18>
    355e:	00004097          	auipc	ra,0x4
    3562:	7e8080e7          	jalr	2024(ra) # 7d46 <printf>
    exit(1);
    3566:	4505                	li	a0,1
    3568:	00004097          	auipc	ra,0x4
    356c:	2b0080e7          	jalr	688(ra) # 7818 <exit>
  }
}
    3570:	0001                	nop
    3572:	70a2                	ld	ra,40(sp)
    3574:	7402                	ld	s0,32(sp)
    3576:	6145                	addi	sp,sp,48
    3578:	8082                	ret

000000000000357a <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(char *s)
{
    357a:	7119                	addi	sp,sp,-128
    357c:	fc86                	sd	ra,120(sp)
    357e:	f8a2                	sd	s0,112(sp)
    3580:	0100                	addi	s0,sp,128
    3582:	f8a43423          	sd	a0,-120(s0)
  struct {
    ushort inum;
    char name[DIRSIZ];
  } de;

  file[0] = 'C';
    3586:	04300793          	li	a5,67
    358a:	fcf40c23          	sb	a5,-40(s0)
  file[2] = '\0';
    358e:	fc040d23          	sb	zero,-38(s0)
  for(i = 0; i < N; i++){
    3592:	fe042623          	sw	zero,-20(s0)
    3596:	a215                	j	36ba <concreate+0x140>
    file[1] = '0' + i;
    3598:	fec42783          	lw	a5,-20(s0)
    359c:	0ff7f793          	andi	a5,a5,255
    35a0:	0307879b          	addiw	a5,a5,48
    35a4:	0ff7f793          	andi	a5,a5,255
    35a8:	fcf40ca3          	sb	a5,-39(s0)
    unlink(file);
    35ac:	fd840793          	addi	a5,s0,-40
    35b0:	853e                	mv	a0,a5
    35b2:	00004097          	auipc	ra,0x4
    35b6:	2b6080e7          	jalr	694(ra) # 7868 <unlink>
    pid = fork();
    35ba:	00004097          	auipc	ra,0x4
    35be:	256080e7          	jalr	598(ra) # 7810 <fork>
    35c2:	87aa                	mv	a5,a0
    35c4:	fef42023          	sw	a5,-32(s0)
    if(pid && (i % 3) == 1){
    35c8:	fe042783          	lw	a5,-32(s0)
    35cc:	2781                	sext.w	a5,a5
    35ce:	c79d                	beqz	a5,35fc <concreate+0x82>
    35d0:	fec42703          	lw	a4,-20(s0)
    35d4:	478d                	li	a5,3
    35d6:	02f767bb          	remw	a5,a4,a5
    35da:	2781                	sext.w	a5,a5
    35dc:	873e                	mv	a4,a5
    35de:	4785                	li	a5,1
    35e0:	00f71e63          	bne	a4,a5,35fc <concreate+0x82>
      link("C0", file);
    35e4:	fd840793          	addi	a5,s0,-40
    35e8:	85be                	mv	a1,a5
    35ea:	00006517          	auipc	a0,0x6
    35ee:	88650513          	addi	a0,a0,-1914 # 8e70 <malloc+0xf38>
    35f2:	00004097          	auipc	ra,0x4
    35f6:	286080e7          	jalr	646(ra) # 7878 <link>
    35fa:	a059                	j	3680 <concreate+0x106>
    } else if(pid == 0 && (i % 5) == 1){
    35fc:	fe042783          	lw	a5,-32(s0)
    3600:	2781                	sext.w	a5,a5
    3602:	e79d                	bnez	a5,3630 <concreate+0xb6>
    3604:	fec42703          	lw	a4,-20(s0)
    3608:	4795                	li	a5,5
    360a:	02f767bb          	remw	a5,a4,a5
    360e:	2781                	sext.w	a5,a5
    3610:	873e                	mv	a4,a5
    3612:	4785                	li	a5,1
    3614:	00f71e63          	bne	a4,a5,3630 <concreate+0xb6>
      link("C0", file);
    3618:	fd840793          	addi	a5,s0,-40
    361c:	85be                	mv	a1,a5
    361e:	00006517          	auipc	a0,0x6
    3622:	85250513          	addi	a0,a0,-1966 # 8e70 <malloc+0xf38>
    3626:	00004097          	auipc	ra,0x4
    362a:	252080e7          	jalr	594(ra) # 7878 <link>
    362e:	a889                	j	3680 <concreate+0x106>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    3630:	fd840793          	addi	a5,s0,-40
    3634:	20200593          	li	a1,514
    3638:	853e                	mv	a0,a5
    363a:	00004097          	auipc	ra,0x4
    363e:	21e080e7          	jalr	542(ra) # 7858 <open>
    3642:	87aa                	mv	a5,a0
    3644:	fef42223          	sw	a5,-28(s0)
      if(fd < 0){
    3648:	fe442783          	lw	a5,-28(s0)
    364c:	2781                	sext.w	a5,a5
    364e:	0207d263          	bgez	a5,3672 <concreate+0xf8>
        printf("concreate create %s failed\n", file);
    3652:	fd840793          	addi	a5,s0,-40
    3656:	85be                	mv	a1,a5
    3658:	00006517          	auipc	a0,0x6
    365c:	82050513          	addi	a0,a0,-2016 # 8e78 <malloc+0xf40>
    3660:	00004097          	auipc	ra,0x4
    3664:	6e6080e7          	jalr	1766(ra) # 7d46 <printf>
        exit(1);
    3668:	4505                	li	a0,1
    366a:	00004097          	auipc	ra,0x4
    366e:	1ae080e7          	jalr	430(ra) # 7818 <exit>
      }
      close(fd);
    3672:	fe442783          	lw	a5,-28(s0)
    3676:	853e                	mv	a0,a5
    3678:	00004097          	auipc	ra,0x4
    367c:	1c8080e7          	jalr	456(ra) # 7840 <close>
    }
    if(pid == 0) {
    3680:	fe042783          	lw	a5,-32(s0)
    3684:	2781                	sext.w	a5,a5
    3686:	e791                	bnez	a5,3692 <concreate+0x118>
      exit(0);
    3688:	4501                	li	a0,0
    368a:	00004097          	auipc	ra,0x4
    368e:	18e080e7          	jalr	398(ra) # 7818 <exit>
    } else {
      int xstatus;
      wait(&xstatus);
    3692:	f9c40793          	addi	a5,s0,-100
    3696:	853e                	mv	a0,a5
    3698:	00004097          	auipc	ra,0x4
    369c:	188080e7          	jalr	392(ra) # 7820 <wait>
      if(xstatus != 0)
    36a0:	f9c42783          	lw	a5,-100(s0)
    36a4:	c791                	beqz	a5,36b0 <concreate+0x136>
        exit(1);
    36a6:	4505                	li	a0,1
    36a8:	00004097          	auipc	ra,0x4
    36ac:	170080e7          	jalr	368(ra) # 7818 <exit>
  for(i = 0; i < N; i++){
    36b0:	fec42783          	lw	a5,-20(s0)
    36b4:	2785                	addiw	a5,a5,1
    36b6:	fef42623          	sw	a5,-20(s0)
    36ba:	fec42783          	lw	a5,-20(s0)
    36be:	0007871b          	sext.w	a4,a5
    36c2:	02700793          	li	a5,39
    36c6:	ece7d9e3          	bge	a5,a4,3598 <concreate+0x1e>
    }
  }

  memset(fa, 0, sizeof(fa));
    36ca:	fb040793          	addi	a5,s0,-80
    36ce:	02800613          	li	a2,40
    36d2:	4581                	li	a1,0
    36d4:	853e                	mv	a0,a5
    36d6:	00004097          	auipc	ra,0x4
    36da:	d98080e7          	jalr	-616(ra) # 746e <memset>
  fd = open(".", 0);
    36de:	4581                	li	a1,0
    36e0:	00005517          	auipc	a0,0x5
    36e4:	76850513          	addi	a0,a0,1896 # 8e48 <malloc+0xf10>
    36e8:	00004097          	auipc	ra,0x4
    36ec:	170080e7          	jalr	368(ra) # 7858 <open>
    36f0:	87aa                	mv	a5,a0
    36f2:	fef42223          	sw	a5,-28(s0)
  n = 0;
    36f6:	fe042423          	sw	zero,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    36fa:	a86d                	j	37b4 <concreate+0x23a>
    if(de.inum == 0)
    36fc:	fa045783          	lhu	a5,-96(s0)
    3700:	e391                	bnez	a5,3704 <concreate+0x18a>
      continue;
    3702:	a84d                	j	37b4 <concreate+0x23a>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3704:	fa244783          	lbu	a5,-94(s0)
    3708:	873e                	mv	a4,a5
    370a:	04300793          	li	a5,67
    370e:	0af71363          	bne	a4,a5,37b4 <concreate+0x23a>
    3712:	fa444783          	lbu	a5,-92(s0)
    3716:	efd9                	bnez	a5,37b4 <concreate+0x23a>
      i = de.name[1] - '0';
    3718:	fa344783          	lbu	a5,-93(s0)
    371c:	2781                	sext.w	a5,a5
    371e:	fd07879b          	addiw	a5,a5,-48
    3722:	fef42623          	sw	a5,-20(s0)
      if(i < 0 || i >= sizeof(fa)){
    3726:	fec42783          	lw	a5,-20(s0)
    372a:	2781                	sext.w	a5,a5
    372c:	0007c963          	bltz	a5,373e <concreate+0x1c4>
    3730:	fec42783          	lw	a5,-20(s0)
    3734:	873e                	mv	a4,a5
    3736:	02700793          	li	a5,39
    373a:	02e7f563          	bgeu	a5,a4,3764 <concreate+0x1ea>
        printf("%s: concreate weird file %s\n", s, de.name);
    373e:	fa040793          	addi	a5,s0,-96
    3742:	0789                	addi	a5,a5,2
    3744:	863e                	mv	a2,a5
    3746:	f8843583          	ld	a1,-120(s0)
    374a:	00005517          	auipc	a0,0x5
    374e:	74e50513          	addi	a0,a0,1870 # 8e98 <malloc+0xf60>
    3752:	00004097          	auipc	ra,0x4
    3756:	5f4080e7          	jalr	1524(ra) # 7d46 <printf>
        exit(1);
    375a:	4505                	li	a0,1
    375c:	00004097          	auipc	ra,0x4
    3760:	0bc080e7          	jalr	188(ra) # 7818 <exit>
      }
      if(fa[i]){
    3764:	fec42783          	lw	a5,-20(s0)
    3768:	ff040713          	addi	a4,s0,-16
    376c:	97ba                	add	a5,a5,a4
    376e:	fc07c783          	lbu	a5,-64(a5)
    3772:	c785                	beqz	a5,379a <concreate+0x220>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    3774:	fa040793          	addi	a5,s0,-96
    3778:	0789                	addi	a5,a5,2
    377a:	863e                	mv	a2,a5
    377c:	f8843583          	ld	a1,-120(s0)
    3780:	00005517          	auipc	a0,0x5
    3784:	73850513          	addi	a0,a0,1848 # 8eb8 <malloc+0xf80>
    3788:	00004097          	auipc	ra,0x4
    378c:	5be080e7          	jalr	1470(ra) # 7d46 <printf>
        exit(1);
    3790:	4505                	li	a0,1
    3792:	00004097          	auipc	ra,0x4
    3796:	086080e7          	jalr	134(ra) # 7818 <exit>
      }
      fa[i] = 1;
    379a:	fec42783          	lw	a5,-20(s0)
    379e:	ff040713          	addi	a4,s0,-16
    37a2:	97ba                	add	a5,a5,a4
    37a4:	4705                	li	a4,1
    37a6:	fce78023          	sb	a4,-64(a5)
      n++;
    37aa:	fe842783          	lw	a5,-24(s0)
    37ae:	2785                	addiw	a5,a5,1
    37b0:	fef42423          	sw	a5,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    37b4:	fa040713          	addi	a4,s0,-96
    37b8:	fe442783          	lw	a5,-28(s0)
    37bc:	4641                	li	a2,16
    37be:	85ba                	mv	a1,a4
    37c0:	853e                	mv	a0,a5
    37c2:	00004097          	auipc	ra,0x4
    37c6:	06e080e7          	jalr	110(ra) # 7830 <read>
    37ca:	87aa                	mv	a5,a0
    37cc:	f2f048e3          	bgtz	a5,36fc <concreate+0x182>
    }
  }
  close(fd);
    37d0:	fe442783          	lw	a5,-28(s0)
    37d4:	853e                	mv	a0,a5
    37d6:	00004097          	auipc	ra,0x4
    37da:	06a080e7          	jalr	106(ra) # 7840 <close>

  if(n != N){
    37de:	fe842783          	lw	a5,-24(s0)
    37e2:	0007871b          	sext.w	a4,a5
    37e6:	02800793          	li	a5,40
    37ea:	02f70163          	beq	a4,a5,380c <concreate+0x292>
    printf("%s: concreate not enough files in directory listing\n", s);
    37ee:	f8843583          	ld	a1,-120(s0)
    37f2:	00005517          	auipc	a0,0x5
    37f6:	6ee50513          	addi	a0,a0,1774 # 8ee0 <malloc+0xfa8>
    37fa:	00004097          	auipc	ra,0x4
    37fe:	54c080e7          	jalr	1356(ra) # 7d46 <printf>
    exit(1);
    3802:	4505                	li	a0,1
    3804:	00004097          	auipc	ra,0x4
    3808:	014080e7          	jalr	20(ra) # 7818 <exit>
  }

  for(i = 0; i < N; i++){
    380c:	fe042623          	sw	zero,-20(s0)
    3810:	a24d                	j	39b2 <concreate+0x438>
    file[1] = '0' + i;
    3812:	fec42783          	lw	a5,-20(s0)
    3816:	0ff7f793          	andi	a5,a5,255
    381a:	0307879b          	addiw	a5,a5,48
    381e:	0ff7f793          	andi	a5,a5,255
    3822:	fcf40ca3          	sb	a5,-39(s0)
    pid = fork();
    3826:	00004097          	auipc	ra,0x4
    382a:	fea080e7          	jalr	-22(ra) # 7810 <fork>
    382e:	87aa                	mv	a5,a0
    3830:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    3834:	fe042783          	lw	a5,-32(s0)
    3838:	2781                	sext.w	a5,a5
    383a:	0207d163          	bgez	a5,385c <concreate+0x2e2>
      printf("%s: fork failed\n", s);
    383e:	f8843583          	ld	a1,-120(s0)
    3842:	00005517          	auipc	a0,0x5
    3846:	c9e50513          	addi	a0,a0,-866 # 84e0 <malloc+0x5a8>
    384a:	00004097          	auipc	ra,0x4
    384e:	4fc080e7          	jalr	1276(ra) # 7d46 <printf>
      exit(1);
    3852:	4505                	li	a0,1
    3854:	00004097          	auipc	ra,0x4
    3858:	fc4080e7          	jalr	-60(ra) # 7818 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    385c:	fec42703          	lw	a4,-20(s0)
    3860:	478d                	li	a5,3
    3862:	02f767bb          	remw	a5,a4,a5
    3866:	2781                	sext.w	a5,a5
    3868:	e789                	bnez	a5,3872 <concreate+0x2f8>
    386a:	fe042783          	lw	a5,-32(s0)
    386e:	2781                	sext.w	a5,a5
    3870:	cf99                	beqz	a5,388e <concreate+0x314>
       ((i % 3) == 1 && pid != 0)){
    3872:	fec42703          	lw	a4,-20(s0)
    3876:	478d                	li	a5,3
    3878:	02f767bb          	remw	a5,a4,a5
    387c:	2781                	sext.w	a5,a5
    if(((i % 3) == 0 && pid == 0) ||
    387e:	873e                	mv	a4,a5
    3880:	4785                	li	a5,1
    3882:	0af71b63          	bne	a4,a5,3938 <concreate+0x3be>
       ((i % 3) == 1 && pid != 0)){
    3886:	fe042783          	lw	a5,-32(s0)
    388a:	2781                	sext.w	a5,a5
    388c:	c7d5                	beqz	a5,3938 <concreate+0x3be>
      close(open(file, 0));
    388e:	fd840793          	addi	a5,s0,-40
    3892:	4581                	li	a1,0
    3894:	853e                	mv	a0,a5
    3896:	00004097          	auipc	ra,0x4
    389a:	fc2080e7          	jalr	-62(ra) # 7858 <open>
    389e:	87aa                	mv	a5,a0
    38a0:	853e                	mv	a0,a5
    38a2:	00004097          	auipc	ra,0x4
    38a6:	f9e080e7          	jalr	-98(ra) # 7840 <close>
      close(open(file, 0));
    38aa:	fd840793          	addi	a5,s0,-40
    38ae:	4581                	li	a1,0
    38b0:	853e                	mv	a0,a5
    38b2:	00004097          	auipc	ra,0x4
    38b6:	fa6080e7          	jalr	-90(ra) # 7858 <open>
    38ba:	87aa                	mv	a5,a0
    38bc:	853e                	mv	a0,a5
    38be:	00004097          	auipc	ra,0x4
    38c2:	f82080e7          	jalr	-126(ra) # 7840 <close>
      close(open(file, 0));
    38c6:	fd840793          	addi	a5,s0,-40
    38ca:	4581                	li	a1,0
    38cc:	853e                	mv	a0,a5
    38ce:	00004097          	auipc	ra,0x4
    38d2:	f8a080e7          	jalr	-118(ra) # 7858 <open>
    38d6:	87aa                	mv	a5,a0
    38d8:	853e                	mv	a0,a5
    38da:	00004097          	auipc	ra,0x4
    38de:	f66080e7          	jalr	-154(ra) # 7840 <close>
      close(open(file, 0));
    38e2:	fd840793          	addi	a5,s0,-40
    38e6:	4581                	li	a1,0
    38e8:	853e                	mv	a0,a5
    38ea:	00004097          	auipc	ra,0x4
    38ee:	f6e080e7          	jalr	-146(ra) # 7858 <open>
    38f2:	87aa                	mv	a5,a0
    38f4:	853e                	mv	a0,a5
    38f6:	00004097          	auipc	ra,0x4
    38fa:	f4a080e7          	jalr	-182(ra) # 7840 <close>
      close(open(file, 0));
    38fe:	fd840793          	addi	a5,s0,-40
    3902:	4581                	li	a1,0
    3904:	853e                	mv	a0,a5
    3906:	00004097          	auipc	ra,0x4
    390a:	f52080e7          	jalr	-174(ra) # 7858 <open>
    390e:	87aa                	mv	a5,a0
    3910:	853e                	mv	a0,a5
    3912:	00004097          	auipc	ra,0x4
    3916:	f2e080e7          	jalr	-210(ra) # 7840 <close>
      close(open(file, 0));
    391a:	fd840793          	addi	a5,s0,-40
    391e:	4581                	li	a1,0
    3920:	853e                	mv	a0,a5
    3922:	00004097          	auipc	ra,0x4
    3926:	f36080e7          	jalr	-202(ra) # 7858 <open>
    392a:	87aa                	mv	a5,a0
    392c:	853e                	mv	a0,a5
    392e:	00004097          	auipc	ra,0x4
    3932:	f12080e7          	jalr	-238(ra) # 7840 <close>
    3936:	a899                	j	398c <concreate+0x412>
    } else {
      unlink(file);
    3938:	fd840793          	addi	a5,s0,-40
    393c:	853e                	mv	a0,a5
    393e:	00004097          	auipc	ra,0x4
    3942:	f2a080e7          	jalr	-214(ra) # 7868 <unlink>
      unlink(file);
    3946:	fd840793          	addi	a5,s0,-40
    394a:	853e                	mv	a0,a5
    394c:	00004097          	auipc	ra,0x4
    3950:	f1c080e7          	jalr	-228(ra) # 7868 <unlink>
      unlink(file);
    3954:	fd840793          	addi	a5,s0,-40
    3958:	853e                	mv	a0,a5
    395a:	00004097          	auipc	ra,0x4
    395e:	f0e080e7          	jalr	-242(ra) # 7868 <unlink>
      unlink(file);
    3962:	fd840793          	addi	a5,s0,-40
    3966:	853e                	mv	a0,a5
    3968:	00004097          	auipc	ra,0x4
    396c:	f00080e7          	jalr	-256(ra) # 7868 <unlink>
      unlink(file);
    3970:	fd840793          	addi	a5,s0,-40
    3974:	853e                	mv	a0,a5
    3976:	00004097          	auipc	ra,0x4
    397a:	ef2080e7          	jalr	-270(ra) # 7868 <unlink>
      unlink(file);
    397e:	fd840793          	addi	a5,s0,-40
    3982:	853e                	mv	a0,a5
    3984:	00004097          	auipc	ra,0x4
    3988:	ee4080e7          	jalr	-284(ra) # 7868 <unlink>
    }
    if(pid == 0)
    398c:	fe042783          	lw	a5,-32(s0)
    3990:	2781                	sext.w	a5,a5
    3992:	e791                	bnez	a5,399e <concreate+0x424>
      exit(0);
    3994:	4501                	li	a0,0
    3996:	00004097          	auipc	ra,0x4
    399a:	e82080e7          	jalr	-382(ra) # 7818 <exit>
    else
      wait(0);
    399e:	4501                	li	a0,0
    39a0:	00004097          	auipc	ra,0x4
    39a4:	e80080e7          	jalr	-384(ra) # 7820 <wait>
  for(i = 0; i < N; i++){
    39a8:	fec42783          	lw	a5,-20(s0)
    39ac:	2785                	addiw	a5,a5,1
    39ae:	fef42623          	sw	a5,-20(s0)
    39b2:	fec42783          	lw	a5,-20(s0)
    39b6:	0007871b          	sext.w	a4,a5
    39ba:	02700793          	li	a5,39
    39be:	e4e7dae3          	bge	a5,a4,3812 <concreate+0x298>
  }
}
    39c2:	0001                	nop
    39c4:	0001                	nop
    39c6:	70e6                	ld	ra,120(sp)
    39c8:	7446                	ld	s0,112(sp)
    39ca:	6109                	addi	sp,sp,128
    39cc:	8082                	ret

00000000000039ce <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink(char *s)
{
    39ce:	7179                	addi	sp,sp,-48
    39d0:	f406                	sd	ra,40(sp)
    39d2:	f022                	sd	s0,32(sp)
    39d4:	1800                	addi	s0,sp,48
    39d6:	fca43c23          	sd	a0,-40(s0)
  int pid, i;

  unlink("x");
    39da:	00004517          	auipc	a0,0x4
    39de:	7d650513          	addi	a0,a0,2006 # 81b0 <malloc+0x278>
    39e2:	00004097          	auipc	ra,0x4
    39e6:	e86080e7          	jalr	-378(ra) # 7868 <unlink>
  pid = fork();
    39ea:	00004097          	auipc	ra,0x4
    39ee:	e26080e7          	jalr	-474(ra) # 7810 <fork>
    39f2:	87aa                	mv	a5,a0
    39f4:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
    39f8:	fe442783          	lw	a5,-28(s0)
    39fc:	2781                	sext.w	a5,a5
    39fe:	0207d163          	bgez	a5,3a20 <linkunlink+0x52>
    printf("%s: fork failed\n", s);
    3a02:	fd843583          	ld	a1,-40(s0)
    3a06:	00005517          	auipc	a0,0x5
    3a0a:	ada50513          	addi	a0,a0,-1318 # 84e0 <malloc+0x5a8>
    3a0e:	00004097          	auipc	ra,0x4
    3a12:	338080e7          	jalr	824(ra) # 7d46 <printf>
    exit(1);
    3a16:	4505                	li	a0,1
    3a18:	00004097          	auipc	ra,0x4
    3a1c:	e00080e7          	jalr	-512(ra) # 7818 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    3a20:	fe442783          	lw	a5,-28(s0)
    3a24:	2781                	sext.w	a5,a5
    3a26:	c399                	beqz	a5,3a2c <linkunlink+0x5e>
    3a28:	4785                	li	a5,1
    3a2a:	a019                	j	3a30 <linkunlink+0x62>
    3a2c:	06100793          	li	a5,97
    3a30:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 100; i++){
    3a34:	fe042623          	sw	zero,-20(s0)
    3a38:	a869                	j	3ad2 <linkunlink+0x104>
    x = x * 1103515245 + 12345;
    3a3a:	fe842703          	lw	a4,-24(s0)
    3a3e:	41c657b7          	lui	a5,0x41c65
    3a42:	e6d7879b          	addiw	a5,a5,-403
    3a46:	02f707bb          	mulw	a5,a4,a5
    3a4a:	0007871b          	sext.w	a4,a5
    3a4e:	678d                	lui	a5,0x3
    3a50:	0397879b          	addiw	a5,a5,57
    3a54:	9fb9                	addw	a5,a5,a4
    3a56:	fef42423          	sw	a5,-24(s0)
    if((x % 3) == 0){
    3a5a:	fe842703          	lw	a4,-24(s0)
    3a5e:	478d                	li	a5,3
    3a60:	02f777bb          	remuw	a5,a4,a5
    3a64:	2781                	sext.w	a5,a5
    3a66:	e395                	bnez	a5,3a8a <linkunlink+0xbc>
      close(open("x", O_RDWR | O_CREATE));
    3a68:	20200593          	li	a1,514
    3a6c:	00004517          	auipc	a0,0x4
    3a70:	74450513          	addi	a0,a0,1860 # 81b0 <malloc+0x278>
    3a74:	00004097          	auipc	ra,0x4
    3a78:	de4080e7          	jalr	-540(ra) # 7858 <open>
    3a7c:	87aa                	mv	a5,a0
    3a7e:	853e                	mv	a0,a5
    3a80:	00004097          	auipc	ra,0x4
    3a84:	dc0080e7          	jalr	-576(ra) # 7840 <close>
    3a88:	a081                	j	3ac8 <linkunlink+0xfa>
    } else if((x % 3) == 1){
    3a8a:	fe842703          	lw	a4,-24(s0)
    3a8e:	478d                	li	a5,3
    3a90:	02f777bb          	remuw	a5,a4,a5
    3a94:	2781                	sext.w	a5,a5
    3a96:	873e                	mv	a4,a5
    3a98:	4785                	li	a5,1
    3a9a:	00f71f63          	bne	a4,a5,3ab8 <linkunlink+0xea>
      link("cat", "x");
    3a9e:	00004597          	auipc	a1,0x4
    3aa2:	71258593          	addi	a1,a1,1810 # 81b0 <malloc+0x278>
    3aa6:	00005517          	auipc	a0,0x5
    3aaa:	47250513          	addi	a0,a0,1138 # 8f18 <malloc+0xfe0>
    3aae:	00004097          	auipc	ra,0x4
    3ab2:	dca080e7          	jalr	-566(ra) # 7878 <link>
    3ab6:	a809                	j	3ac8 <linkunlink+0xfa>
    } else {
      unlink("x");
    3ab8:	00004517          	auipc	a0,0x4
    3abc:	6f850513          	addi	a0,a0,1784 # 81b0 <malloc+0x278>
    3ac0:	00004097          	auipc	ra,0x4
    3ac4:	da8080e7          	jalr	-600(ra) # 7868 <unlink>
  for(i = 0; i < 100; i++){
    3ac8:	fec42783          	lw	a5,-20(s0)
    3acc:	2785                	addiw	a5,a5,1
    3ace:	fef42623          	sw	a5,-20(s0)
    3ad2:	fec42783          	lw	a5,-20(s0)
    3ad6:	0007871b          	sext.w	a4,a5
    3ada:	06300793          	li	a5,99
    3ade:	f4e7dee3          	bge	a5,a4,3a3a <linkunlink+0x6c>
    }
  }

  if(pid)
    3ae2:	fe442783          	lw	a5,-28(s0)
    3ae6:	2781                	sext.w	a5,a5
    3ae8:	c799                	beqz	a5,3af6 <linkunlink+0x128>
    wait(0);
    3aea:	4501                	li	a0,0
    3aec:	00004097          	auipc	ra,0x4
    3af0:	d34080e7          	jalr	-716(ra) # 7820 <wait>
  else
    exit(0);
}
    3af4:	a031                	j	3b00 <linkunlink+0x132>
    exit(0);
    3af6:	4501                	li	a0,0
    3af8:	00004097          	auipc	ra,0x4
    3afc:	d20080e7          	jalr	-736(ra) # 7818 <exit>
}
    3b00:	70a2                	ld	ra,40(sp)
    3b02:	7402                	ld	s0,32(sp)
    3b04:	6145                	addi	sp,sp,48
    3b06:	8082                	ret

0000000000003b08 <subdir>:


void
subdir(char *s)
{
    3b08:	7179                	addi	sp,sp,-48
    3b0a:	f406                	sd	ra,40(sp)
    3b0c:	f022                	sd	s0,32(sp)
    3b0e:	1800                	addi	s0,sp,48
    3b10:	fca43c23          	sd	a0,-40(s0)
  int fd, cc;

  unlink("ff");
    3b14:	00005517          	auipc	a0,0x5
    3b18:	40c50513          	addi	a0,a0,1036 # 8f20 <malloc+0xfe8>
    3b1c:	00004097          	auipc	ra,0x4
    3b20:	d4c080e7          	jalr	-692(ra) # 7868 <unlink>
  if(mkdir("dd") != 0){
    3b24:	00005517          	auipc	a0,0x5
    3b28:	40450513          	addi	a0,a0,1028 # 8f28 <malloc+0xff0>
    3b2c:	00004097          	auipc	ra,0x4
    3b30:	d54080e7          	jalr	-684(ra) # 7880 <mkdir>
    3b34:	87aa                	mv	a5,a0
    3b36:	c385                	beqz	a5,3b56 <subdir+0x4e>
    printf("%s: mkdir dd failed\n", s);
    3b38:	fd843583          	ld	a1,-40(s0)
    3b3c:	00005517          	auipc	a0,0x5
    3b40:	3f450513          	addi	a0,a0,1012 # 8f30 <malloc+0xff8>
    3b44:	00004097          	auipc	ra,0x4
    3b48:	202080e7          	jalr	514(ra) # 7d46 <printf>
    exit(1);
    3b4c:	4505                	li	a0,1
    3b4e:	00004097          	auipc	ra,0x4
    3b52:	cca080e7          	jalr	-822(ra) # 7818 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3b56:	20200593          	li	a1,514
    3b5a:	00005517          	auipc	a0,0x5
    3b5e:	3ee50513          	addi	a0,a0,1006 # 8f48 <malloc+0x1010>
    3b62:	00004097          	auipc	ra,0x4
    3b66:	cf6080e7          	jalr	-778(ra) # 7858 <open>
    3b6a:	87aa                	mv	a5,a0
    3b6c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3b70:	fec42783          	lw	a5,-20(s0)
    3b74:	2781                	sext.w	a5,a5
    3b76:	0207d163          	bgez	a5,3b98 <subdir+0x90>
    printf("%s: create dd/ff failed\n", s);
    3b7a:	fd843583          	ld	a1,-40(s0)
    3b7e:	00005517          	auipc	a0,0x5
    3b82:	3d250513          	addi	a0,a0,978 # 8f50 <malloc+0x1018>
    3b86:	00004097          	auipc	ra,0x4
    3b8a:	1c0080e7          	jalr	448(ra) # 7d46 <printf>
    exit(1);
    3b8e:	4505                	li	a0,1
    3b90:	00004097          	auipc	ra,0x4
    3b94:	c88080e7          	jalr	-888(ra) # 7818 <exit>
  }
  write(fd, "ff", 2);
    3b98:	fec42783          	lw	a5,-20(s0)
    3b9c:	4609                	li	a2,2
    3b9e:	00005597          	auipc	a1,0x5
    3ba2:	38258593          	addi	a1,a1,898 # 8f20 <malloc+0xfe8>
    3ba6:	853e                	mv	a0,a5
    3ba8:	00004097          	auipc	ra,0x4
    3bac:	c90080e7          	jalr	-880(ra) # 7838 <write>
  close(fd);
    3bb0:	fec42783          	lw	a5,-20(s0)
    3bb4:	853e                	mv	a0,a5
    3bb6:	00004097          	auipc	ra,0x4
    3bba:	c8a080e7          	jalr	-886(ra) # 7840 <close>

  if(unlink("dd") >= 0){
    3bbe:	00005517          	auipc	a0,0x5
    3bc2:	36a50513          	addi	a0,a0,874 # 8f28 <malloc+0xff0>
    3bc6:	00004097          	auipc	ra,0x4
    3bca:	ca2080e7          	jalr	-862(ra) # 7868 <unlink>
    3bce:	87aa                	mv	a5,a0
    3bd0:	0207c163          	bltz	a5,3bf2 <subdir+0xea>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3bd4:	fd843583          	ld	a1,-40(s0)
    3bd8:	00005517          	auipc	a0,0x5
    3bdc:	39850513          	addi	a0,a0,920 # 8f70 <malloc+0x1038>
    3be0:	00004097          	auipc	ra,0x4
    3be4:	166080e7          	jalr	358(ra) # 7d46 <printf>
    exit(1);
    3be8:	4505                	li	a0,1
    3bea:	00004097          	auipc	ra,0x4
    3bee:	c2e080e7          	jalr	-978(ra) # 7818 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    3bf2:	00005517          	auipc	a0,0x5
    3bf6:	3ae50513          	addi	a0,a0,942 # 8fa0 <malloc+0x1068>
    3bfa:	00004097          	auipc	ra,0x4
    3bfe:	c86080e7          	jalr	-890(ra) # 7880 <mkdir>
    3c02:	87aa                	mv	a5,a0
    3c04:	c385                	beqz	a5,3c24 <subdir+0x11c>
    printf("subdir mkdir dd/dd failed\n", s);
    3c06:	fd843583          	ld	a1,-40(s0)
    3c0a:	00005517          	auipc	a0,0x5
    3c0e:	39e50513          	addi	a0,a0,926 # 8fa8 <malloc+0x1070>
    3c12:	00004097          	auipc	ra,0x4
    3c16:	134080e7          	jalr	308(ra) # 7d46 <printf>
    exit(1);
    3c1a:	4505                	li	a0,1
    3c1c:	00004097          	auipc	ra,0x4
    3c20:	bfc080e7          	jalr	-1028(ra) # 7818 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3c24:	20200593          	li	a1,514
    3c28:	00005517          	auipc	a0,0x5
    3c2c:	3a050513          	addi	a0,a0,928 # 8fc8 <malloc+0x1090>
    3c30:	00004097          	auipc	ra,0x4
    3c34:	c28080e7          	jalr	-984(ra) # 7858 <open>
    3c38:	87aa                	mv	a5,a0
    3c3a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3c3e:	fec42783          	lw	a5,-20(s0)
    3c42:	2781                	sext.w	a5,a5
    3c44:	0207d163          	bgez	a5,3c66 <subdir+0x15e>
    printf("%s: create dd/dd/ff failed\n", s);
    3c48:	fd843583          	ld	a1,-40(s0)
    3c4c:	00005517          	auipc	a0,0x5
    3c50:	38c50513          	addi	a0,a0,908 # 8fd8 <malloc+0x10a0>
    3c54:	00004097          	auipc	ra,0x4
    3c58:	0f2080e7          	jalr	242(ra) # 7d46 <printf>
    exit(1);
    3c5c:	4505                	li	a0,1
    3c5e:	00004097          	auipc	ra,0x4
    3c62:	bba080e7          	jalr	-1094(ra) # 7818 <exit>
  }
  write(fd, "FF", 2);
    3c66:	fec42783          	lw	a5,-20(s0)
    3c6a:	4609                	li	a2,2
    3c6c:	00005597          	auipc	a1,0x5
    3c70:	38c58593          	addi	a1,a1,908 # 8ff8 <malloc+0x10c0>
    3c74:	853e                	mv	a0,a5
    3c76:	00004097          	auipc	ra,0x4
    3c7a:	bc2080e7          	jalr	-1086(ra) # 7838 <write>
  close(fd);
    3c7e:	fec42783          	lw	a5,-20(s0)
    3c82:	853e                	mv	a0,a5
    3c84:	00004097          	auipc	ra,0x4
    3c88:	bbc080e7          	jalr	-1092(ra) # 7840 <close>

  fd = open("dd/dd/../ff", 0);
    3c8c:	4581                	li	a1,0
    3c8e:	00005517          	auipc	a0,0x5
    3c92:	37250513          	addi	a0,a0,882 # 9000 <malloc+0x10c8>
    3c96:	00004097          	auipc	ra,0x4
    3c9a:	bc2080e7          	jalr	-1086(ra) # 7858 <open>
    3c9e:	87aa                	mv	a5,a0
    3ca0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3ca4:	fec42783          	lw	a5,-20(s0)
    3ca8:	2781                	sext.w	a5,a5
    3caa:	0207d163          	bgez	a5,3ccc <subdir+0x1c4>
    printf("%s: open dd/dd/../ff failed\n", s);
    3cae:	fd843583          	ld	a1,-40(s0)
    3cb2:	00005517          	auipc	a0,0x5
    3cb6:	35e50513          	addi	a0,a0,862 # 9010 <malloc+0x10d8>
    3cba:	00004097          	auipc	ra,0x4
    3cbe:	08c080e7          	jalr	140(ra) # 7d46 <printf>
    exit(1);
    3cc2:	4505                	li	a0,1
    3cc4:	00004097          	auipc	ra,0x4
    3cc8:	b54080e7          	jalr	-1196(ra) # 7818 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    3ccc:	fec42783          	lw	a5,-20(s0)
    3cd0:	660d                	lui	a2,0x3
    3cd2:	00007597          	auipc	a1,0x7
    3cd6:	77e58593          	addi	a1,a1,1918 # b450 <buf>
    3cda:	853e                	mv	a0,a5
    3cdc:	00004097          	auipc	ra,0x4
    3ce0:	b54080e7          	jalr	-1196(ra) # 7830 <read>
    3ce4:	87aa                	mv	a5,a0
    3ce6:	fef42423          	sw	a5,-24(s0)
  if(cc != 2 || buf[0] != 'f'){
    3cea:	fe842783          	lw	a5,-24(s0)
    3cee:	0007871b          	sext.w	a4,a5
    3cf2:	4789                	li	a5,2
    3cf4:	00f71d63          	bne	a4,a5,3d0e <subdir+0x206>
    3cf8:	00007797          	auipc	a5,0x7
    3cfc:	75878793          	addi	a5,a5,1880 # b450 <buf>
    3d00:	0007c783          	lbu	a5,0(a5)
    3d04:	873e                	mv	a4,a5
    3d06:	06600793          	li	a5,102
    3d0a:	02f70163          	beq	a4,a5,3d2c <subdir+0x224>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3d0e:	fd843583          	ld	a1,-40(s0)
    3d12:	00005517          	auipc	a0,0x5
    3d16:	31e50513          	addi	a0,a0,798 # 9030 <malloc+0x10f8>
    3d1a:	00004097          	auipc	ra,0x4
    3d1e:	02c080e7          	jalr	44(ra) # 7d46 <printf>
    exit(1);
    3d22:	4505                	li	a0,1
    3d24:	00004097          	auipc	ra,0x4
    3d28:	af4080e7          	jalr	-1292(ra) # 7818 <exit>
  }
  close(fd);
    3d2c:	fec42783          	lw	a5,-20(s0)
    3d30:	853e                	mv	a0,a5
    3d32:	00004097          	auipc	ra,0x4
    3d36:	b0e080e7          	jalr	-1266(ra) # 7840 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3d3a:	00005597          	auipc	a1,0x5
    3d3e:	31658593          	addi	a1,a1,790 # 9050 <malloc+0x1118>
    3d42:	00005517          	auipc	a0,0x5
    3d46:	28650513          	addi	a0,a0,646 # 8fc8 <malloc+0x1090>
    3d4a:	00004097          	auipc	ra,0x4
    3d4e:	b2e080e7          	jalr	-1234(ra) # 7878 <link>
    3d52:	87aa                	mv	a5,a0
    3d54:	c385                	beqz	a5,3d74 <subdir+0x26c>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3d56:	fd843583          	ld	a1,-40(s0)
    3d5a:	00005517          	auipc	a0,0x5
    3d5e:	30650513          	addi	a0,a0,774 # 9060 <malloc+0x1128>
    3d62:	00004097          	auipc	ra,0x4
    3d66:	fe4080e7          	jalr	-28(ra) # 7d46 <printf>
    exit(1);
    3d6a:	4505                	li	a0,1
    3d6c:	00004097          	auipc	ra,0x4
    3d70:	aac080e7          	jalr	-1364(ra) # 7818 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    3d74:	00005517          	auipc	a0,0x5
    3d78:	25450513          	addi	a0,a0,596 # 8fc8 <malloc+0x1090>
    3d7c:	00004097          	auipc	ra,0x4
    3d80:	aec080e7          	jalr	-1300(ra) # 7868 <unlink>
    3d84:	87aa                	mv	a5,a0
    3d86:	c385                	beqz	a5,3da6 <subdir+0x29e>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3d88:	fd843583          	ld	a1,-40(s0)
    3d8c:	00005517          	auipc	a0,0x5
    3d90:	2fc50513          	addi	a0,a0,764 # 9088 <malloc+0x1150>
    3d94:	00004097          	auipc	ra,0x4
    3d98:	fb2080e7          	jalr	-78(ra) # 7d46 <printf>
    exit(1);
    3d9c:	4505                	li	a0,1
    3d9e:	00004097          	auipc	ra,0x4
    3da2:	a7a080e7          	jalr	-1414(ra) # 7818 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3da6:	4581                	li	a1,0
    3da8:	00005517          	auipc	a0,0x5
    3dac:	22050513          	addi	a0,a0,544 # 8fc8 <malloc+0x1090>
    3db0:	00004097          	auipc	ra,0x4
    3db4:	aa8080e7          	jalr	-1368(ra) # 7858 <open>
    3db8:	87aa                	mv	a5,a0
    3dba:	0207c163          	bltz	a5,3ddc <subdir+0x2d4>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3dbe:	fd843583          	ld	a1,-40(s0)
    3dc2:	00005517          	auipc	a0,0x5
    3dc6:	2e650513          	addi	a0,a0,742 # 90a8 <malloc+0x1170>
    3dca:	00004097          	auipc	ra,0x4
    3dce:	f7c080e7          	jalr	-132(ra) # 7d46 <printf>
    exit(1);
    3dd2:	4505                	li	a0,1
    3dd4:	00004097          	auipc	ra,0x4
    3dd8:	a44080e7          	jalr	-1468(ra) # 7818 <exit>
  }

  if(chdir("dd") != 0){
    3ddc:	00005517          	auipc	a0,0x5
    3de0:	14c50513          	addi	a0,a0,332 # 8f28 <malloc+0xff0>
    3de4:	00004097          	auipc	ra,0x4
    3de8:	aa4080e7          	jalr	-1372(ra) # 7888 <chdir>
    3dec:	87aa                	mv	a5,a0
    3dee:	c385                	beqz	a5,3e0e <subdir+0x306>
    printf("%s: chdir dd failed\n", s);
    3df0:	fd843583          	ld	a1,-40(s0)
    3df4:	00005517          	auipc	a0,0x5
    3df8:	2dc50513          	addi	a0,a0,732 # 90d0 <malloc+0x1198>
    3dfc:	00004097          	auipc	ra,0x4
    3e00:	f4a080e7          	jalr	-182(ra) # 7d46 <printf>
    exit(1);
    3e04:	4505                	li	a0,1
    3e06:	00004097          	auipc	ra,0x4
    3e0a:	a12080e7          	jalr	-1518(ra) # 7818 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    3e0e:	00005517          	auipc	a0,0x5
    3e12:	2da50513          	addi	a0,a0,730 # 90e8 <malloc+0x11b0>
    3e16:	00004097          	auipc	ra,0x4
    3e1a:	a72080e7          	jalr	-1422(ra) # 7888 <chdir>
    3e1e:	87aa                	mv	a5,a0
    3e20:	c385                	beqz	a5,3e40 <subdir+0x338>
    printf("%s: chdir dd/../../dd failed\n", s);
    3e22:	fd843583          	ld	a1,-40(s0)
    3e26:	00005517          	auipc	a0,0x5
    3e2a:	2d250513          	addi	a0,a0,722 # 90f8 <malloc+0x11c0>
    3e2e:	00004097          	auipc	ra,0x4
    3e32:	f18080e7          	jalr	-232(ra) # 7d46 <printf>
    exit(1);
    3e36:	4505                	li	a0,1
    3e38:	00004097          	auipc	ra,0x4
    3e3c:	9e0080e7          	jalr	-1568(ra) # 7818 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    3e40:	00005517          	auipc	a0,0x5
    3e44:	2d850513          	addi	a0,a0,728 # 9118 <malloc+0x11e0>
    3e48:	00004097          	auipc	ra,0x4
    3e4c:	a40080e7          	jalr	-1472(ra) # 7888 <chdir>
    3e50:	87aa                	mv	a5,a0
    3e52:	c385                	beqz	a5,3e72 <subdir+0x36a>
    printf("chdir dd/../../dd failed\n", s);
    3e54:	fd843583          	ld	a1,-40(s0)
    3e58:	00005517          	auipc	a0,0x5
    3e5c:	2d050513          	addi	a0,a0,720 # 9128 <malloc+0x11f0>
    3e60:	00004097          	auipc	ra,0x4
    3e64:	ee6080e7          	jalr	-282(ra) # 7d46 <printf>
    exit(1);
    3e68:	4505                	li	a0,1
    3e6a:	00004097          	auipc	ra,0x4
    3e6e:	9ae080e7          	jalr	-1618(ra) # 7818 <exit>
  }
  if(chdir("./..") != 0){
    3e72:	00005517          	auipc	a0,0x5
    3e76:	2d650513          	addi	a0,a0,726 # 9148 <malloc+0x1210>
    3e7a:	00004097          	auipc	ra,0x4
    3e7e:	a0e080e7          	jalr	-1522(ra) # 7888 <chdir>
    3e82:	87aa                	mv	a5,a0
    3e84:	c385                	beqz	a5,3ea4 <subdir+0x39c>
    printf("%s: chdir ./.. failed\n", s);
    3e86:	fd843583          	ld	a1,-40(s0)
    3e8a:	00005517          	auipc	a0,0x5
    3e8e:	2c650513          	addi	a0,a0,710 # 9150 <malloc+0x1218>
    3e92:	00004097          	auipc	ra,0x4
    3e96:	eb4080e7          	jalr	-332(ra) # 7d46 <printf>
    exit(1);
    3e9a:	4505                	li	a0,1
    3e9c:	00004097          	auipc	ra,0x4
    3ea0:	97c080e7          	jalr	-1668(ra) # 7818 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    3ea4:	4581                	li	a1,0
    3ea6:	00005517          	auipc	a0,0x5
    3eaa:	1aa50513          	addi	a0,a0,426 # 9050 <malloc+0x1118>
    3eae:	00004097          	auipc	ra,0x4
    3eb2:	9aa080e7          	jalr	-1622(ra) # 7858 <open>
    3eb6:	87aa                	mv	a5,a0
    3eb8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3ebc:	fec42783          	lw	a5,-20(s0)
    3ec0:	2781                	sext.w	a5,a5
    3ec2:	0207d163          	bgez	a5,3ee4 <subdir+0x3dc>
    printf("%s: open dd/dd/ffff failed\n", s);
    3ec6:	fd843583          	ld	a1,-40(s0)
    3eca:	00005517          	auipc	a0,0x5
    3ece:	29e50513          	addi	a0,a0,670 # 9168 <malloc+0x1230>
    3ed2:	00004097          	auipc	ra,0x4
    3ed6:	e74080e7          	jalr	-396(ra) # 7d46 <printf>
    exit(1);
    3eda:	4505                	li	a0,1
    3edc:	00004097          	auipc	ra,0x4
    3ee0:	93c080e7          	jalr	-1732(ra) # 7818 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    3ee4:	fec42783          	lw	a5,-20(s0)
    3ee8:	660d                	lui	a2,0x3
    3eea:	00007597          	auipc	a1,0x7
    3eee:	56658593          	addi	a1,a1,1382 # b450 <buf>
    3ef2:	853e                	mv	a0,a5
    3ef4:	00004097          	auipc	ra,0x4
    3ef8:	93c080e7          	jalr	-1732(ra) # 7830 <read>
    3efc:	87aa                	mv	a5,a0
    3efe:	873e                	mv	a4,a5
    3f00:	4789                	li	a5,2
    3f02:	02f70163          	beq	a4,a5,3f24 <subdir+0x41c>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3f06:	fd843583          	ld	a1,-40(s0)
    3f0a:	00005517          	auipc	a0,0x5
    3f0e:	27e50513          	addi	a0,a0,638 # 9188 <malloc+0x1250>
    3f12:	00004097          	auipc	ra,0x4
    3f16:	e34080e7          	jalr	-460(ra) # 7d46 <printf>
    exit(1);
    3f1a:	4505                	li	a0,1
    3f1c:	00004097          	auipc	ra,0x4
    3f20:	8fc080e7          	jalr	-1796(ra) # 7818 <exit>
  }
  close(fd);
    3f24:	fec42783          	lw	a5,-20(s0)
    3f28:	853e                	mv	a0,a5
    3f2a:	00004097          	auipc	ra,0x4
    3f2e:	916080e7          	jalr	-1770(ra) # 7840 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3f32:	4581                	li	a1,0
    3f34:	00005517          	auipc	a0,0x5
    3f38:	09450513          	addi	a0,a0,148 # 8fc8 <malloc+0x1090>
    3f3c:	00004097          	auipc	ra,0x4
    3f40:	91c080e7          	jalr	-1764(ra) # 7858 <open>
    3f44:	87aa                	mv	a5,a0
    3f46:	0207c163          	bltz	a5,3f68 <subdir+0x460>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3f4a:	fd843583          	ld	a1,-40(s0)
    3f4e:	00005517          	auipc	a0,0x5
    3f52:	25a50513          	addi	a0,a0,602 # 91a8 <malloc+0x1270>
    3f56:	00004097          	auipc	ra,0x4
    3f5a:	df0080e7          	jalr	-528(ra) # 7d46 <printf>
    exit(1);
    3f5e:	4505                	li	a0,1
    3f60:	00004097          	auipc	ra,0x4
    3f64:	8b8080e7          	jalr	-1864(ra) # 7818 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3f68:	20200593          	li	a1,514
    3f6c:	00005517          	auipc	a0,0x5
    3f70:	26c50513          	addi	a0,a0,620 # 91d8 <malloc+0x12a0>
    3f74:	00004097          	auipc	ra,0x4
    3f78:	8e4080e7          	jalr	-1820(ra) # 7858 <open>
    3f7c:	87aa                	mv	a5,a0
    3f7e:	0207c163          	bltz	a5,3fa0 <subdir+0x498>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3f82:	fd843583          	ld	a1,-40(s0)
    3f86:	00005517          	auipc	a0,0x5
    3f8a:	26250513          	addi	a0,a0,610 # 91e8 <malloc+0x12b0>
    3f8e:	00004097          	auipc	ra,0x4
    3f92:	db8080e7          	jalr	-584(ra) # 7d46 <printf>
    exit(1);
    3f96:	4505                	li	a0,1
    3f98:	00004097          	auipc	ra,0x4
    3f9c:	880080e7          	jalr	-1920(ra) # 7818 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    3fa0:	20200593          	li	a1,514
    3fa4:	00005517          	auipc	a0,0x5
    3fa8:	26450513          	addi	a0,a0,612 # 9208 <malloc+0x12d0>
    3fac:	00004097          	auipc	ra,0x4
    3fb0:	8ac080e7          	jalr	-1876(ra) # 7858 <open>
    3fb4:	87aa                	mv	a5,a0
    3fb6:	0207c163          	bltz	a5,3fd8 <subdir+0x4d0>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3fba:	fd843583          	ld	a1,-40(s0)
    3fbe:	00005517          	auipc	a0,0x5
    3fc2:	25a50513          	addi	a0,a0,602 # 9218 <malloc+0x12e0>
    3fc6:	00004097          	auipc	ra,0x4
    3fca:	d80080e7          	jalr	-640(ra) # 7d46 <printf>
    exit(1);
    3fce:	4505                	li	a0,1
    3fd0:	00004097          	auipc	ra,0x4
    3fd4:	848080e7          	jalr	-1976(ra) # 7818 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    3fd8:	20000593          	li	a1,512
    3fdc:	00005517          	auipc	a0,0x5
    3fe0:	f4c50513          	addi	a0,a0,-180 # 8f28 <malloc+0xff0>
    3fe4:	00004097          	auipc	ra,0x4
    3fe8:	874080e7          	jalr	-1932(ra) # 7858 <open>
    3fec:	87aa                	mv	a5,a0
    3fee:	0207c163          	bltz	a5,4010 <subdir+0x508>
    printf("%s: create dd succeeded!\n", s);
    3ff2:	fd843583          	ld	a1,-40(s0)
    3ff6:	00005517          	auipc	a0,0x5
    3ffa:	24250513          	addi	a0,a0,578 # 9238 <malloc+0x1300>
    3ffe:	00004097          	auipc	ra,0x4
    4002:	d48080e7          	jalr	-696(ra) # 7d46 <printf>
    exit(1);
    4006:	4505                	li	a0,1
    4008:	00004097          	auipc	ra,0x4
    400c:	810080e7          	jalr	-2032(ra) # 7818 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    4010:	4589                	li	a1,2
    4012:	00005517          	auipc	a0,0x5
    4016:	f1650513          	addi	a0,a0,-234 # 8f28 <malloc+0xff0>
    401a:	00004097          	auipc	ra,0x4
    401e:	83e080e7          	jalr	-1986(ra) # 7858 <open>
    4022:	87aa                	mv	a5,a0
    4024:	0207c163          	bltz	a5,4046 <subdir+0x53e>
    printf("%s: open dd rdwr succeeded!\n", s);
    4028:	fd843583          	ld	a1,-40(s0)
    402c:	00005517          	auipc	a0,0x5
    4030:	22c50513          	addi	a0,a0,556 # 9258 <malloc+0x1320>
    4034:	00004097          	auipc	ra,0x4
    4038:	d12080e7          	jalr	-750(ra) # 7d46 <printf>
    exit(1);
    403c:	4505                	li	a0,1
    403e:	00003097          	auipc	ra,0x3
    4042:	7da080e7          	jalr	2010(ra) # 7818 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    4046:	4585                	li	a1,1
    4048:	00005517          	auipc	a0,0x5
    404c:	ee050513          	addi	a0,a0,-288 # 8f28 <malloc+0xff0>
    4050:	00004097          	auipc	ra,0x4
    4054:	808080e7          	jalr	-2040(ra) # 7858 <open>
    4058:	87aa                	mv	a5,a0
    405a:	0207c163          	bltz	a5,407c <subdir+0x574>
    printf("%s: open dd wronly succeeded!\n", s);
    405e:	fd843583          	ld	a1,-40(s0)
    4062:	00005517          	auipc	a0,0x5
    4066:	21650513          	addi	a0,a0,534 # 9278 <malloc+0x1340>
    406a:	00004097          	auipc	ra,0x4
    406e:	cdc080e7          	jalr	-804(ra) # 7d46 <printf>
    exit(1);
    4072:	4505                	li	a0,1
    4074:	00003097          	auipc	ra,0x3
    4078:	7a4080e7          	jalr	1956(ra) # 7818 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    407c:	00005597          	auipc	a1,0x5
    4080:	21c58593          	addi	a1,a1,540 # 9298 <malloc+0x1360>
    4084:	00005517          	auipc	a0,0x5
    4088:	15450513          	addi	a0,a0,340 # 91d8 <malloc+0x12a0>
    408c:	00003097          	auipc	ra,0x3
    4090:	7ec080e7          	jalr	2028(ra) # 7878 <link>
    4094:	87aa                	mv	a5,a0
    4096:	e385                	bnez	a5,40b6 <subdir+0x5ae>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    4098:	fd843583          	ld	a1,-40(s0)
    409c:	00005517          	auipc	a0,0x5
    40a0:	20c50513          	addi	a0,a0,524 # 92a8 <malloc+0x1370>
    40a4:	00004097          	auipc	ra,0x4
    40a8:	ca2080e7          	jalr	-862(ra) # 7d46 <printf>
    exit(1);
    40ac:	4505                	li	a0,1
    40ae:	00003097          	auipc	ra,0x3
    40b2:	76a080e7          	jalr	1898(ra) # 7818 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    40b6:	00005597          	auipc	a1,0x5
    40ba:	1e258593          	addi	a1,a1,482 # 9298 <malloc+0x1360>
    40be:	00005517          	auipc	a0,0x5
    40c2:	14a50513          	addi	a0,a0,330 # 9208 <malloc+0x12d0>
    40c6:	00003097          	auipc	ra,0x3
    40ca:	7b2080e7          	jalr	1970(ra) # 7878 <link>
    40ce:	87aa                	mv	a5,a0
    40d0:	e385                	bnez	a5,40f0 <subdir+0x5e8>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    40d2:	fd843583          	ld	a1,-40(s0)
    40d6:	00005517          	auipc	a0,0x5
    40da:	1fa50513          	addi	a0,a0,506 # 92d0 <malloc+0x1398>
    40de:	00004097          	auipc	ra,0x4
    40e2:	c68080e7          	jalr	-920(ra) # 7d46 <printf>
    exit(1);
    40e6:	4505                	li	a0,1
    40e8:	00003097          	auipc	ra,0x3
    40ec:	730080e7          	jalr	1840(ra) # 7818 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    40f0:	00005597          	auipc	a1,0x5
    40f4:	f6058593          	addi	a1,a1,-160 # 9050 <malloc+0x1118>
    40f8:	00005517          	auipc	a0,0x5
    40fc:	e5050513          	addi	a0,a0,-432 # 8f48 <malloc+0x1010>
    4100:	00003097          	auipc	ra,0x3
    4104:	778080e7          	jalr	1912(ra) # 7878 <link>
    4108:	87aa                	mv	a5,a0
    410a:	e385                	bnez	a5,412a <subdir+0x622>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    410c:	fd843583          	ld	a1,-40(s0)
    4110:	00005517          	auipc	a0,0x5
    4114:	1e850513          	addi	a0,a0,488 # 92f8 <malloc+0x13c0>
    4118:	00004097          	auipc	ra,0x4
    411c:	c2e080e7          	jalr	-978(ra) # 7d46 <printf>
    exit(1);
    4120:	4505                	li	a0,1
    4122:	00003097          	auipc	ra,0x3
    4126:	6f6080e7          	jalr	1782(ra) # 7818 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    412a:	00005517          	auipc	a0,0x5
    412e:	0ae50513          	addi	a0,a0,174 # 91d8 <malloc+0x12a0>
    4132:	00003097          	auipc	ra,0x3
    4136:	74e080e7          	jalr	1870(ra) # 7880 <mkdir>
    413a:	87aa                	mv	a5,a0
    413c:	e385                	bnez	a5,415c <subdir+0x654>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    413e:	fd843583          	ld	a1,-40(s0)
    4142:	00005517          	auipc	a0,0x5
    4146:	1de50513          	addi	a0,a0,478 # 9320 <malloc+0x13e8>
    414a:	00004097          	auipc	ra,0x4
    414e:	bfc080e7          	jalr	-1028(ra) # 7d46 <printf>
    exit(1);
    4152:	4505                	li	a0,1
    4154:	00003097          	auipc	ra,0x3
    4158:	6c4080e7          	jalr	1732(ra) # 7818 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    415c:	00005517          	auipc	a0,0x5
    4160:	0ac50513          	addi	a0,a0,172 # 9208 <malloc+0x12d0>
    4164:	00003097          	auipc	ra,0x3
    4168:	71c080e7          	jalr	1820(ra) # 7880 <mkdir>
    416c:	87aa                	mv	a5,a0
    416e:	e385                	bnez	a5,418e <subdir+0x686>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    4170:	fd843583          	ld	a1,-40(s0)
    4174:	00005517          	auipc	a0,0x5
    4178:	1cc50513          	addi	a0,a0,460 # 9340 <malloc+0x1408>
    417c:	00004097          	auipc	ra,0x4
    4180:	bca080e7          	jalr	-1078(ra) # 7d46 <printf>
    exit(1);
    4184:	4505                	li	a0,1
    4186:	00003097          	auipc	ra,0x3
    418a:	692080e7          	jalr	1682(ra) # 7818 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    418e:	00005517          	auipc	a0,0x5
    4192:	ec250513          	addi	a0,a0,-318 # 9050 <malloc+0x1118>
    4196:	00003097          	auipc	ra,0x3
    419a:	6ea080e7          	jalr	1770(ra) # 7880 <mkdir>
    419e:	87aa                	mv	a5,a0
    41a0:	e385                	bnez	a5,41c0 <subdir+0x6b8>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    41a2:	fd843583          	ld	a1,-40(s0)
    41a6:	00005517          	auipc	a0,0x5
    41aa:	1ba50513          	addi	a0,a0,442 # 9360 <malloc+0x1428>
    41ae:	00004097          	auipc	ra,0x4
    41b2:	b98080e7          	jalr	-1128(ra) # 7d46 <printf>
    exit(1);
    41b6:	4505                	li	a0,1
    41b8:	00003097          	auipc	ra,0x3
    41bc:	660080e7          	jalr	1632(ra) # 7818 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    41c0:	00005517          	auipc	a0,0x5
    41c4:	04850513          	addi	a0,a0,72 # 9208 <malloc+0x12d0>
    41c8:	00003097          	auipc	ra,0x3
    41cc:	6a0080e7          	jalr	1696(ra) # 7868 <unlink>
    41d0:	87aa                	mv	a5,a0
    41d2:	e385                	bnez	a5,41f2 <subdir+0x6ea>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    41d4:	fd843583          	ld	a1,-40(s0)
    41d8:	00005517          	auipc	a0,0x5
    41dc:	1b050513          	addi	a0,a0,432 # 9388 <malloc+0x1450>
    41e0:	00004097          	auipc	ra,0x4
    41e4:	b66080e7          	jalr	-1178(ra) # 7d46 <printf>
    exit(1);
    41e8:	4505                	li	a0,1
    41ea:	00003097          	auipc	ra,0x3
    41ee:	62e080e7          	jalr	1582(ra) # 7818 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    41f2:	00005517          	auipc	a0,0x5
    41f6:	fe650513          	addi	a0,a0,-26 # 91d8 <malloc+0x12a0>
    41fa:	00003097          	auipc	ra,0x3
    41fe:	66e080e7          	jalr	1646(ra) # 7868 <unlink>
    4202:	87aa                	mv	a5,a0
    4204:	e385                	bnez	a5,4224 <subdir+0x71c>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    4206:	fd843583          	ld	a1,-40(s0)
    420a:	00005517          	auipc	a0,0x5
    420e:	19e50513          	addi	a0,a0,414 # 93a8 <malloc+0x1470>
    4212:	00004097          	auipc	ra,0x4
    4216:	b34080e7          	jalr	-1228(ra) # 7d46 <printf>
    exit(1);
    421a:	4505                	li	a0,1
    421c:	00003097          	auipc	ra,0x3
    4220:	5fc080e7          	jalr	1532(ra) # 7818 <exit>
  }
  if(chdir("dd/ff") == 0){
    4224:	00005517          	auipc	a0,0x5
    4228:	d2450513          	addi	a0,a0,-732 # 8f48 <malloc+0x1010>
    422c:	00003097          	auipc	ra,0x3
    4230:	65c080e7          	jalr	1628(ra) # 7888 <chdir>
    4234:	87aa                	mv	a5,a0
    4236:	e385                	bnez	a5,4256 <subdir+0x74e>
    printf("%s: chdir dd/ff succeeded!\n", s);
    4238:	fd843583          	ld	a1,-40(s0)
    423c:	00005517          	auipc	a0,0x5
    4240:	18c50513          	addi	a0,a0,396 # 93c8 <malloc+0x1490>
    4244:	00004097          	auipc	ra,0x4
    4248:	b02080e7          	jalr	-1278(ra) # 7d46 <printf>
    exit(1);
    424c:	4505                	li	a0,1
    424e:	00003097          	auipc	ra,0x3
    4252:	5ca080e7          	jalr	1482(ra) # 7818 <exit>
  }
  if(chdir("dd/xx") == 0){
    4256:	00005517          	auipc	a0,0x5
    425a:	19250513          	addi	a0,a0,402 # 93e8 <malloc+0x14b0>
    425e:	00003097          	auipc	ra,0x3
    4262:	62a080e7          	jalr	1578(ra) # 7888 <chdir>
    4266:	87aa                	mv	a5,a0
    4268:	e385                	bnez	a5,4288 <subdir+0x780>
    printf("%s: chdir dd/xx succeeded!\n", s);
    426a:	fd843583          	ld	a1,-40(s0)
    426e:	00005517          	auipc	a0,0x5
    4272:	18250513          	addi	a0,a0,386 # 93f0 <malloc+0x14b8>
    4276:	00004097          	auipc	ra,0x4
    427a:	ad0080e7          	jalr	-1328(ra) # 7d46 <printf>
    exit(1);
    427e:	4505                	li	a0,1
    4280:	00003097          	auipc	ra,0x3
    4284:	598080e7          	jalr	1432(ra) # 7818 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    4288:	00005517          	auipc	a0,0x5
    428c:	dc850513          	addi	a0,a0,-568 # 9050 <malloc+0x1118>
    4290:	00003097          	auipc	ra,0x3
    4294:	5d8080e7          	jalr	1496(ra) # 7868 <unlink>
    4298:	87aa                	mv	a5,a0
    429a:	c385                	beqz	a5,42ba <subdir+0x7b2>
    printf("%s: unlink dd/dd/ff failed\n", s);
    429c:	fd843583          	ld	a1,-40(s0)
    42a0:	00005517          	auipc	a0,0x5
    42a4:	de850513          	addi	a0,a0,-536 # 9088 <malloc+0x1150>
    42a8:	00004097          	auipc	ra,0x4
    42ac:	a9e080e7          	jalr	-1378(ra) # 7d46 <printf>
    exit(1);
    42b0:	4505                	li	a0,1
    42b2:	00003097          	auipc	ra,0x3
    42b6:	566080e7          	jalr	1382(ra) # 7818 <exit>
  }
  if(unlink("dd/ff") != 0){
    42ba:	00005517          	auipc	a0,0x5
    42be:	c8e50513          	addi	a0,a0,-882 # 8f48 <malloc+0x1010>
    42c2:	00003097          	auipc	ra,0x3
    42c6:	5a6080e7          	jalr	1446(ra) # 7868 <unlink>
    42ca:	87aa                	mv	a5,a0
    42cc:	c385                	beqz	a5,42ec <subdir+0x7e4>
    printf("%s: unlink dd/ff failed\n", s);
    42ce:	fd843583          	ld	a1,-40(s0)
    42d2:	00005517          	auipc	a0,0x5
    42d6:	13e50513          	addi	a0,a0,318 # 9410 <malloc+0x14d8>
    42da:	00004097          	auipc	ra,0x4
    42de:	a6c080e7          	jalr	-1428(ra) # 7d46 <printf>
    exit(1);
    42e2:	4505                	li	a0,1
    42e4:	00003097          	auipc	ra,0x3
    42e8:	534080e7          	jalr	1332(ra) # 7818 <exit>
  }
  if(unlink("dd") == 0){
    42ec:	00005517          	auipc	a0,0x5
    42f0:	c3c50513          	addi	a0,a0,-964 # 8f28 <malloc+0xff0>
    42f4:	00003097          	auipc	ra,0x3
    42f8:	574080e7          	jalr	1396(ra) # 7868 <unlink>
    42fc:	87aa                	mv	a5,a0
    42fe:	e385                	bnez	a5,431e <subdir+0x816>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    4300:	fd843583          	ld	a1,-40(s0)
    4304:	00005517          	auipc	a0,0x5
    4308:	12c50513          	addi	a0,a0,300 # 9430 <malloc+0x14f8>
    430c:	00004097          	auipc	ra,0x4
    4310:	a3a080e7          	jalr	-1478(ra) # 7d46 <printf>
    exit(1);
    4314:	4505                	li	a0,1
    4316:	00003097          	auipc	ra,0x3
    431a:	502080e7          	jalr	1282(ra) # 7818 <exit>
  }
  if(unlink("dd/dd") < 0){
    431e:	00005517          	auipc	a0,0x5
    4322:	13a50513          	addi	a0,a0,314 # 9458 <malloc+0x1520>
    4326:	00003097          	auipc	ra,0x3
    432a:	542080e7          	jalr	1346(ra) # 7868 <unlink>
    432e:	87aa                	mv	a5,a0
    4330:	0207d163          	bgez	a5,4352 <subdir+0x84a>
    printf("%s: unlink dd/dd failed\n", s);
    4334:	fd843583          	ld	a1,-40(s0)
    4338:	00005517          	auipc	a0,0x5
    433c:	12850513          	addi	a0,a0,296 # 9460 <malloc+0x1528>
    4340:	00004097          	auipc	ra,0x4
    4344:	a06080e7          	jalr	-1530(ra) # 7d46 <printf>
    exit(1);
    4348:	4505                	li	a0,1
    434a:	00003097          	auipc	ra,0x3
    434e:	4ce080e7          	jalr	1230(ra) # 7818 <exit>
  }
  if(unlink("dd") < 0){
    4352:	00005517          	auipc	a0,0x5
    4356:	bd650513          	addi	a0,a0,-1066 # 8f28 <malloc+0xff0>
    435a:	00003097          	auipc	ra,0x3
    435e:	50e080e7          	jalr	1294(ra) # 7868 <unlink>
    4362:	87aa                	mv	a5,a0
    4364:	0207d163          	bgez	a5,4386 <subdir+0x87e>
    printf("%s: unlink dd failed\n", s);
    4368:	fd843583          	ld	a1,-40(s0)
    436c:	00005517          	auipc	a0,0x5
    4370:	11450513          	addi	a0,a0,276 # 9480 <malloc+0x1548>
    4374:	00004097          	auipc	ra,0x4
    4378:	9d2080e7          	jalr	-1582(ra) # 7d46 <printf>
    exit(1);
    437c:	4505                	li	a0,1
    437e:	00003097          	auipc	ra,0x3
    4382:	49a080e7          	jalr	1178(ra) # 7818 <exit>
  }
}
    4386:	0001                	nop
    4388:	70a2                	ld	ra,40(sp)
    438a:	7402                	ld	s0,32(sp)
    438c:	6145                	addi	sp,sp,48
    438e:	8082                	ret

0000000000004390 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(char *s)
{
    4390:	7179                	addi	sp,sp,-48
    4392:	f406                	sd	ra,40(sp)
    4394:	f022                	sd	s0,32(sp)
    4396:	1800                	addi	s0,sp,48
    4398:	fca43c23          	sd	a0,-40(s0)
  int fd, sz;

  unlink("bigwrite");
    439c:	00005517          	auipc	a0,0x5
    43a0:	0fc50513          	addi	a0,a0,252 # 9498 <malloc+0x1560>
    43a4:	00003097          	auipc	ra,0x3
    43a8:	4c4080e7          	jalr	1220(ra) # 7868 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    43ac:	1f300793          	li	a5,499
    43b0:	fef42623          	sw	a5,-20(s0)
    43b4:	a0e5                	j	449c <bigwrite+0x10c>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    43b6:	20200593          	li	a1,514
    43ba:	00005517          	auipc	a0,0x5
    43be:	0de50513          	addi	a0,a0,222 # 9498 <malloc+0x1560>
    43c2:	00003097          	auipc	ra,0x3
    43c6:	496080e7          	jalr	1174(ra) # 7858 <open>
    43ca:	87aa                	mv	a5,a0
    43cc:	fef42223          	sw	a5,-28(s0)
    if(fd < 0){
    43d0:	fe442783          	lw	a5,-28(s0)
    43d4:	2781                	sext.w	a5,a5
    43d6:	0207d163          	bgez	a5,43f8 <bigwrite+0x68>
      printf("%s: cannot create bigwrite\n", s);
    43da:	fd843583          	ld	a1,-40(s0)
    43de:	00005517          	auipc	a0,0x5
    43e2:	0ca50513          	addi	a0,a0,202 # 94a8 <malloc+0x1570>
    43e6:	00004097          	auipc	ra,0x4
    43ea:	960080e7          	jalr	-1696(ra) # 7d46 <printf>
      exit(1);
    43ee:	4505                	li	a0,1
    43f0:	00003097          	auipc	ra,0x3
    43f4:	428080e7          	jalr	1064(ra) # 7818 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    43f8:	fe042423          	sw	zero,-24(s0)
    43fc:	a0a5                	j	4464 <bigwrite+0xd4>
      int cc = write(fd, buf, sz);
    43fe:	fec42703          	lw	a4,-20(s0)
    4402:	fe442783          	lw	a5,-28(s0)
    4406:	863a                	mv	a2,a4
    4408:	00007597          	auipc	a1,0x7
    440c:	04858593          	addi	a1,a1,72 # b450 <buf>
    4410:	853e                	mv	a0,a5
    4412:	00003097          	auipc	ra,0x3
    4416:	426080e7          	jalr	1062(ra) # 7838 <write>
    441a:	87aa                	mv	a5,a0
    441c:	fef42023          	sw	a5,-32(s0)
      if(cc != sz){
    4420:	fe042703          	lw	a4,-32(s0)
    4424:	fec42783          	lw	a5,-20(s0)
    4428:	2701                	sext.w	a4,a4
    442a:	2781                	sext.w	a5,a5
    442c:	02f70763          	beq	a4,a5,445a <bigwrite+0xca>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
    4430:	fe042703          	lw	a4,-32(s0)
    4434:	fec42783          	lw	a5,-20(s0)
    4438:	86ba                	mv	a3,a4
    443a:	863e                	mv	a2,a5
    443c:	fd843583          	ld	a1,-40(s0)
    4440:	00005517          	auipc	a0,0x5
    4444:	08850513          	addi	a0,a0,136 # 94c8 <malloc+0x1590>
    4448:	00004097          	auipc	ra,0x4
    444c:	8fe080e7          	jalr	-1794(ra) # 7d46 <printf>
        exit(1);
    4450:	4505                	li	a0,1
    4452:	00003097          	auipc	ra,0x3
    4456:	3c6080e7          	jalr	966(ra) # 7818 <exit>
    for(i = 0; i < 2; i++){
    445a:	fe842783          	lw	a5,-24(s0)
    445e:	2785                	addiw	a5,a5,1
    4460:	fef42423          	sw	a5,-24(s0)
    4464:	fe842783          	lw	a5,-24(s0)
    4468:	0007871b          	sext.w	a4,a5
    446c:	4785                	li	a5,1
    446e:	f8e7d8e3          	bge	a5,a4,43fe <bigwrite+0x6e>
      }
    }
    close(fd);
    4472:	fe442783          	lw	a5,-28(s0)
    4476:	853e                	mv	a0,a5
    4478:	00003097          	auipc	ra,0x3
    447c:	3c8080e7          	jalr	968(ra) # 7840 <close>
    unlink("bigwrite");
    4480:	00005517          	auipc	a0,0x5
    4484:	01850513          	addi	a0,a0,24 # 9498 <malloc+0x1560>
    4488:	00003097          	auipc	ra,0x3
    448c:	3e0080e7          	jalr	992(ra) # 7868 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    4490:	fec42783          	lw	a5,-20(s0)
    4494:	1d77879b          	addiw	a5,a5,471
    4498:	fef42623          	sw	a5,-20(s0)
    449c:	fec42783          	lw	a5,-20(s0)
    44a0:	0007871b          	sext.w	a4,a5
    44a4:	678d                	lui	a5,0x3
    44a6:	f0f748e3          	blt	a4,a5,43b6 <bigwrite+0x26>
  }
}
    44aa:	0001                	nop
    44ac:	0001                	nop
    44ae:	70a2                	ld	ra,40(sp)
    44b0:	7402                	ld	s0,32(sp)
    44b2:	6145                	addi	sp,sp,48
    44b4:	8082                	ret

00000000000044b6 <bigfile>:


void
bigfile(char *s)
{
    44b6:	7179                	addi	sp,sp,-48
    44b8:	f406                	sd	ra,40(sp)
    44ba:	f022                	sd	s0,32(sp)
    44bc:	1800                	addi	s0,sp,48
    44be:	fca43c23          	sd	a0,-40(s0)
  enum { N = 20, SZ=600 };
  int fd, i, total, cc;

  unlink("bigfile.dat");
    44c2:	00005517          	auipc	a0,0x5
    44c6:	01e50513          	addi	a0,a0,30 # 94e0 <malloc+0x15a8>
    44ca:	00003097          	auipc	ra,0x3
    44ce:	39e080e7          	jalr	926(ra) # 7868 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    44d2:	20200593          	li	a1,514
    44d6:	00005517          	auipc	a0,0x5
    44da:	00a50513          	addi	a0,a0,10 # 94e0 <malloc+0x15a8>
    44de:	00003097          	auipc	ra,0x3
    44e2:	37a080e7          	jalr	890(ra) # 7858 <open>
    44e6:	87aa                	mv	a5,a0
    44e8:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    44ec:	fe442783          	lw	a5,-28(s0)
    44f0:	2781                	sext.w	a5,a5
    44f2:	0207d163          	bgez	a5,4514 <bigfile+0x5e>
    printf("%s: cannot create bigfile", s);
    44f6:	fd843583          	ld	a1,-40(s0)
    44fa:	00005517          	auipc	a0,0x5
    44fe:	ff650513          	addi	a0,a0,-10 # 94f0 <malloc+0x15b8>
    4502:	00004097          	auipc	ra,0x4
    4506:	844080e7          	jalr	-1980(ra) # 7d46 <printf>
    exit(1);
    450a:	4505                	li	a0,1
    450c:	00003097          	auipc	ra,0x3
    4510:	30c080e7          	jalr	780(ra) # 7818 <exit>
  }
  for(i = 0; i < N; i++){
    4514:	fe042623          	sw	zero,-20(s0)
    4518:	a0ad                	j	4582 <bigfile+0xcc>
    memset(buf, i, SZ);
    451a:	fec42783          	lw	a5,-20(s0)
    451e:	25800613          	li	a2,600
    4522:	85be                	mv	a1,a5
    4524:	00007517          	auipc	a0,0x7
    4528:	f2c50513          	addi	a0,a0,-212 # b450 <buf>
    452c:	00003097          	auipc	ra,0x3
    4530:	f42080e7          	jalr	-190(ra) # 746e <memset>
    if(write(fd, buf, SZ) != SZ){
    4534:	fe442783          	lw	a5,-28(s0)
    4538:	25800613          	li	a2,600
    453c:	00007597          	auipc	a1,0x7
    4540:	f1458593          	addi	a1,a1,-236 # b450 <buf>
    4544:	853e                	mv	a0,a5
    4546:	00003097          	auipc	ra,0x3
    454a:	2f2080e7          	jalr	754(ra) # 7838 <write>
    454e:	87aa                	mv	a5,a0
    4550:	873e                	mv	a4,a5
    4552:	25800793          	li	a5,600
    4556:	02f70163          	beq	a4,a5,4578 <bigfile+0xc2>
      printf("%s: write bigfile failed\n", s);
    455a:	fd843583          	ld	a1,-40(s0)
    455e:	00005517          	auipc	a0,0x5
    4562:	fb250513          	addi	a0,a0,-78 # 9510 <malloc+0x15d8>
    4566:	00003097          	auipc	ra,0x3
    456a:	7e0080e7          	jalr	2016(ra) # 7d46 <printf>
      exit(1);
    456e:	4505                	li	a0,1
    4570:	00003097          	auipc	ra,0x3
    4574:	2a8080e7          	jalr	680(ra) # 7818 <exit>
  for(i = 0; i < N; i++){
    4578:	fec42783          	lw	a5,-20(s0)
    457c:	2785                	addiw	a5,a5,1
    457e:	fef42623          	sw	a5,-20(s0)
    4582:	fec42783          	lw	a5,-20(s0)
    4586:	0007871b          	sext.w	a4,a5
    458a:	47cd                	li	a5,19
    458c:	f8e7d7e3          	bge	a5,a4,451a <bigfile+0x64>
    }
  }
  close(fd);
    4590:	fe442783          	lw	a5,-28(s0)
    4594:	853e                	mv	a0,a5
    4596:	00003097          	auipc	ra,0x3
    459a:	2aa080e7          	jalr	682(ra) # 7840 <close>

  fd = open("bigfile.dat", 0);
    459e:	4581                	li	a1,0
    45a0:	00005517          	auipc	a0,0x5
    45a4:	f4050513          	addi	a0,a0,-192 # 94e0 <malloc+0x15a8>
    45a8:	00003097          	auipc	ra,0x3
    45ac:	2b0080e7          	jalr	688(ra) # 7858 <open>
    45b0:	87aa                	mv	a5,a0
    45b2:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    45b6:	fe442783          	lw	a5,-28(s0)
    45ba:	2781                	sext.w	a5,a5
    45bc:	0207d163          	bgez	a5,45de <bigfile+0x128>
    printf("%s: cannot open bigfile\n", s);
    45c0:	fd843583          	ld	a1,-40(s0)
    45c4:	00005517          	auipc	a0,0x5
    45c8:	f6c50513          	addi	a0,a0,-148 # 9530 <malloc+0x15f8>
    45cc:	00003097          	auipc	ra,0x3
    45d0:	77a080e7          	jalr	1914(ra) # 7d46 <printf>
    exit(1);
    45d4:	4505                	li	a0,1
    45d6:	00003097          	auipc	ra,0x3
    45da:	242080e7          	jalr	578(ra) # 7818 <exit>
  }
  total = 0;
    45de:	fe042423          	sw	zero,-24(s0)
  for(i = 0; ; i++){
    45e2:	fe042623          	sw	zero,-20(s0)
    cc = read(fd, buf, SZ/2);
    45e6:	fe442783          	lw	a5,-28(s0)
    45ea:	12c00613          	li	a2,300
    45ee:	00007597          	auipc	a1,0x7
    45f2:	e6258593          	addi	a1,a1,-414 # b450 <buf>
    45f6:	853e                	mv	a0,a5
    45f8:	00003097          	auipc	ra,0x3
    45fc:	238080e7          	jalr	568(ra) # 7830 <read>
    4600:	87aa                	mv	a5,a0
    4602:	fef42023          	sw	a5,-32(s0)
    if(cc < 0){
    4606:	fe042783          	lw	a5,-32(s0)
    460a:	2781                	sext.w	a5,a5
    460c:	0207d163          	bgez	a5,462e <bigfile+0x178>
      printf("%s: read bigfile failed\n", s);
    4610:	fd843583          	ld	a1,-40(s0)
    4614:	00005517          	auipc	a0,0x5
    4618:	f3c50513          	addi	a0,a0,-196 # 9550 <malloc+0x1618>
    461c:	00003097          	auipc	ra,0x3
    4620:	72a080e7          	jalr	1834(ra) # 7d46 <printf>
      exit(1);
    4624:	4505                	li	a0,1
    4626:	00003097          	auipc	ra,0x3
    462a:	1f2080e7          	jalr	498(ra) # 7818 <exit>
    }
    if(cc == 0)
    462e:	fe042783          	lw	a5,-32(s0)
    4632:	2781                	sext.w	a5,a5
    4634:	cbd5                	beqz	a5,46e8 <bigfile+0x232>
      break;
    if(cc != SZ/2){
    4636:	fe042783          	lw	a5,-32(s0)
    463a:	0007871b          	sext.w	a4,a5
    463e:	12c00793          	li	a5,300
    4642:	02f70163          	beq	a4,a5,4664 <bigfile+0x1ae>
      printf("%s: short read bigfile\n", s);
    4646:	fd843583          	ld	a1,-40(s0)
    464a:	00005517          	auipc	a0,0x5
    464e:	f2650513          	addi	a0,a0,-218 # 9570 <malloc+0x1638>
    4652:	00003097          	auipc	ra,0x3
    4656:	6f4080e7          	jalr	1780(ra) # 7d46 <printf>
      exit(1);
    465a:	4505                	li	a0,1
    465c:	00003097          	auipc	ra,0x3
    4660:	1bc080e7          	jalr	444(ra) # 7818 <exit>
    }
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4664:	00007797          	auipc	a5,0x7
    4668:	dec78793          	addi	a5,a5,-532 # b450 <buf>
    466c:	0007c783          	lbu	a5,0(a5)
    4670:	0007869b          	sext.w	a3,a5
    4674:	fec42783          	lw	a5,-20(s0)
    4678:	01f7d71b          	srliw	a4,a5,0x1f
    467c:	9fb9                	addw	a5,a5,a4
    467e:	4017d79b          	sraiw	a5,a5,0x1
    4682:	2781                	sext.w	a5,a5
    4684:	8736                	mv	a4,a3
    4686:	02f71563          	bne	a4,a5,46b0 <bigfile+0x1fa>
    468a:	00007797          	auipc	a5,0x7
    468e:	dc678793          	addi	a5,a5,-570 # b450 <buf>
    4692:	12b7c783          	lbu	a5,299(a5)
    4696:	0007869b          	sext.w	a3,a5
    469a:	fec42783          	lw	a5,-20(s0)
    469e:	01f7d71b          	srliw	a4,a5,0x1f
    46a2:	9fb9                	addw	a5,a5,a4
    46a4:	4017d79b          	sraiw	a5,a5,0x1
    46a8:	2781                	sext.w	a5,a5
    46aa:	8736                	mv	a4,a3
    46ac:	02f70163          	beq	a4,a5,46ce <bigfile+0x218>
      printf("%s: read bigfile wrong data\n", s);
    46b0:	fd843583          	ld	a1,-40(s0)
    46b4:	00005517          	auipc	a0,0x5
    46b8:	ed450513          	addi	a0,a0,-300 # 9588 <malloc+0x1650>
    46bc:	00003097          	auipc	ra,0x3
    46c0:	68a080e7          	jalr	1674(ra) # 7d46 <printf>
      exit(1);
    46c4:	4505                	li	a0,1
    46c6:	00003097          	auipc	ra,0x3
    46ca:	152080e7          	jalr	338(ra) # 7818 <exit>
    }
    total += cc;
    46ce:	fe842703          	lw	a4,-24(s0)
    46d2:	fe042783          	lw	a5,-32(s0)
    46d6:	9fb9                	addw	a5,a5,a4
    46d8:	fef42423          	sw	a5,-24(s0)
  for(i = 0; ; i++){
    46dc:	fec42783          	lw	a5,-20(s0)
    46e0:	2785                	addiw	a5,a5,1
    46e2:	fef42623          	sw	a5,-20(s0)
    cc = read(fd, buf, SZ/2);
    46e6:	b701                	j	45e6 <bigfile+0x130>
      break;
    46e8:	0001                	nop
  }
  close(fd);
    46ea:	fe442783          	lw	a5,-28(s0)
    46ee:	853e                	mv	a0,a5
    46f0:	00003097          	auipc	ra,0x3
    46f4:	150080e7          	jalr	336(ra) # 7840 <close>
  if(total != N*SZ){
    46f8:	fe842783          	lw	a5,-24(s0)
    46fc:	0007871b          	sext.w	a4,a5
    4700:	678d                	lui	a5,0x3
    4702:	ee078793          	addi	a5,a5,-288 # 2ee0 <createdelete+0x15e>
    4706:	02f70163          	beq	a4,a5,4728 <bigfile+0x272>
    printf("%s: read bigfile wrong total\n", s);
    470a:	fd843583          	ld	a1,-40(s0)
    470e:	00005517          	auipc	a0,0x5
    4712:	e9a50513          	addi	a0,a0,-358 # 95a8 <malloc+0x1670>
    4716:	00003097          	auipc	ra,0x3
    471a:	630080e7          	jalr	1584(ra) # 7d46 <printf>
    exit(1);
    471e:	4505                	li	a0,1
    4720:	00003097          	auipc	ra,0x3
    4724:	0f8080e7          	jalr	248(ra) # 7818 <exit>
  }
  unlink("bigfile.dat");
    4728:	00005517          	auipc	a0,0x5
    472c:	db850513          	addi	a0,a0,-584 # 94e0 <malloc+0x15a8>
    4730:	00003097          	auipc	ra,0x3
    4734:	138080e7          	jalr	312(ra) # 7868 <unlink>
}
    4738:	0001                	nop
    473a:	70a2                	ld	ra,40(sp)
    473c:	7402                	ld	s0,32(sp)
    473e:	6145                	addi	sp,sp,48
    4740:	8082                	ret

0000000000004742 <fourteen>:

void
fourteen(char *s)
{
    4742:	7179                	addi	sp,sp,-48
    4744:	f406                	sd	ra,40(sp)
    4746:	f022                	sd	s0,32(sp)
    4748:	1800                	addi	s0,sp,48
    474a:	fca43c23          	sd	a0,-40(s0)
  int fd;

  // DIRSIZ is 14.

  if(mkdir("12345678901234") != 0){
    474e:	00005517          	auipc	a0,0x5
    4752:	e7a50513          	addi	a0,a0,-390 # 95c8 <malloc+0x1690>
    4756:	00003097          	auipc	ra,0x3
    475a:	12a080e7          	jalr	298(ra) # 7880 <mkdir>
    475e:	87aa                	mv	a5,a0
    4760:	c385                	beqz	a5,4780 <fourteen+0x3e>
    printf("%s: mkdir 12345678901234 failed\n", s);
    4762:	fd843583          	ld	a1,-40(s0)
    4766:	00005517          	auipc	a0,0x5
    476a:	e7250513          	addi	a0,a0,-398 # 95d8 <malloc+0x16a0>
    476e:	00003097          	auipc	ra,0x3
    4772:	5d8080e7          	jalr	1496(ra) # 7d46 <printf>
    exit(1);
    4776:	4505                	li	a0,1
    4778:	00003097          	auipc	ra,0x3
    477c:	0a0080e7          	jalr	160(ra) # 7818 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    4780:	00005517          	auipc	a0,0x5
    4784:	e8050513          	addi	a0,a0,-384 # 9600 <malloc+0x16c8>
    4788:	00003097          	auipc	ra,0x3
    478c:	0f8080e7          	jalr	248(ra) # 7880 <mkdir>
    4790:	87aa                	mv	a5,a0
    4792:	c385                	beqz	a5,47b2 <fourteen+0x70>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    4794:	fd843583          	ld	a1,-40(s0)
    4798:	00005517          	auipc	a0,0x5
    479c:	e8850513          	addi	a0,a0,-376 # 9620 <malloc+0x16e8>
    47a0:	00003097          	auipc	ra,0x3
    47a4:	5a6080e7          	jalr	1446(ra) # 7d46 <printf>
    exit(1);
    47a8:	4505                	li	a0,1
    47aa:	00003097          	auipc	ra,0x3
    47ae:	06e080e7          	jalr	110(ra) # 7818 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    47b2:	20000593          	li	a1,512
    47b6:	00005517          	auipc	a0,0x5
    47ba:	ea250513          	addi	a0,a0,-350 # 9658 <malloc+0x1720>
    47be:	00003097          	auipc	ra,0x3
    47c2:	09a080e7          	jalr	154(ra) # 7858 <open>
    47c6:	87aa                	mv	a5,a0
    47c8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    47cc:	fec42783          	lw	a5,-20(s0)
    47d0:	2781                	sext.w	a5,a5
    47d2:	0207d163          	bgez	a5,47f4 <fourteen+0xb2>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    47d6:	fd843583          	ld	a1,-40(s0)
    47da:	00005517          	auipc	a0,0x5
    47de:	eae50513          	addi	a0,a0,-338 # 9688 <malloc+0x1750>
    47e2:	00003097          	auipc	ra,0x3
    47e6:	564080e7          	jalr	1380(ra) # 7d46 <printf>
    exit(1);
    47ea:	4505                	li	a0,1
    47ec:	00003097          	auipc	ra,0x3
    47f0:	02c080e7          	jalr	44(ra) # 7818 <exit>
  }
  close(fd);
    47f4:	fec42783          	lw	a5,-20(s0)
    47f8:	853e                	mv	a0,a5
    47fa:	00003097          	auipc	ra,0x3
    47fe:	046080e7          	jalr	70(ra) # 7840 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    4802:	4581                	li	a1,0
    4804:	00005517          	auipc	a0,0x5
    4808:	ecc50513          	addi	a0,a0,-308 # 96d0 <malloc+0x1798>
    480c:	00003097          	auipc	ra,0x3
    4810:	04c080e7          	jalr	76(ra) # 7858 <open>
    4814:	87aa                	mv	a5,a0
    4816:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    481a:	fec42783          	lw	a5,-20(s0)
    481e:	2781                	sext.w	a5,a5
    4820:	0207d163          	bgez	a5,4842 <fourteen+0x100>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    4824:	fd843583          	ld	a1,-40(s0)
    4828:	00005517          	auipc	a0,0x5
    482c:	ed850513          	addi	a0,a0,-296 # 9700 <malloc+0x17c8>
    4830:	00003097          	auipc	ra,0x3
    4834:	516080e7          	jalr	1302(ra) # 7d46 <printf>
    exit(1);
    4838:	4505                	li	a0,1
    483a:	00003097          	auipc	ra,0x3
    483e:	fde080e7          	jalr	-34(ra) # 7818 <exit>
  }
  close(fd);
    4842:	fec42783          	lw	a5,-20(s0)
    4846:	853e                	mv	a0,a5
    4848:	00003097          	auipc	ra,0x3
    484c:	ff8080e7          	jalr	-8(ra) # 7840 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    4850:	00005517          	auipc	a0,0x5
    4854:	ef050513          	addi	a0,a0,-272 # 9740 <malloc+0x1808>
    4858:	00003097          	auipc	ra,0x3
    485c:	028080e7          	jalr	40(ra) # 7880 <mkdir>
    4860:	87aa                	mv	a5,a0
    4862:	e385                	bnez	a5,4882 <fourteen+0x140>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    4864:	fd843583          	ld	a1,-40(s0)
    4868:	00005517          	auipc	a0,0x5
    486c:	ef850513          	addi	a0,a0,-264 # 9760 <malloc+0x1828>
    4870:	00003097          	auipc	ra,0x3
    4874:	4d6080e7          	jalr	1238(ra) # 7d46 <printf>
    exit(1);
    4878:	4505                	li	a0,1
    487a:	00003097          	auipc	ra,0x3
    487e:	f9e080e7          	jalr	-98(ra) # 7818 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    4882:	00005517          	auipc	a0,0x5
    4886:	f1650513          	addi	a0,a0,-234 # 9798 <malloc+0x1860>
    488a:	00003097          	auipc	ra,0x3
    488e:	ff6080e7          	jalr	-10(ra) # 7880 <mkdir>
    4892:	87aa                	mv	a5,a0
    4894:	e385                	bnez	a5,48b4 <fourteen+0x172>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    4896:	fd843583          	ld	a1,-40(s0)
    489a:	00005517          	auipc	a0,0x5
    489e:	f1e50513          	addi	a0,a0,-226 # 97b8 <malloc+0x1880>
    48a2:	00003097          	auipc	ra,0x3
    48a6:	4a4080e7          	jalr	1188(ra) # 7d46 <printf>
    exit(1);
    48aa:	4505                	li	a0,1
    48ac:	00003097          	auipc	ra,0x3
    48b0:	f6c080e7          	jalr	-148(ra) # 7818 <exit>
  }

  // clean up
  unlink("123456789012345/12345678901234");
    48b4:	00005517          	auipc	a0,0x5
    48b8:	ee450513          	addi	a0,a0,-284 # 9798 <malloc+0x1860>
    48bc:	00003097          	auipc	ra,0x3
    48c0:	fac080e7          	jalr	-84(ra) # 7868 <unlink>
  unlink("12345678901234/12345678901234");
    48c4:	00005517          	auipc	a0,0x5
    48c8:	e7c50513          	addi	a0,a0,-388 # 9740 <malloc+0x1808>
    48cc:	00003097          	auipc	ra,0x3
    48d0:	f9c080e7          	jalr	-100(ra) # 7868 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    48d4:	00005517          	auipc	a0,0x5
    48d8:	dfc50513          	addi	a0,a0,-516 # 96d0 <malloc+0x1798>
    48dc:	00003097          	auipc	ra,0x3
    48e0:	f8c080e7          	jalr	-116(ra) # 7868 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    48e4:	00005517          	auipc	a0,0x5
    48e8:	d7450513          	addi	a0,a0,-652 # 9658 <malloc+0x1720>
    48ec:	00003097          	auipc	ra,0x3
    48f0:	f7c080e7          	jalr	-132(ra) # 7868 <unlink>
  unlink("12345678901234/123456789012345");
    48f4:	00005517          	auipc	a0,0x5
    48f8:	d0c50513          	addi	a0,a0,-756 # 9600 <malloc+0x16c8>
    48fc:	00003097          	auipc	ra,0x3
    4900:	f6c080e7          	jalr	-148(ra) # 7868 <unlink>
  unlink("12345678901234");
    4904:	00005517          	auipc	a0,0x5
    4908:	cc450513          	addi	a0,a0,-828 # 95c8 <malloc+0x1690>
    490c:	00003097          	auipc	ra,0x3
    4910:	f5c080e7          	jalr	-164(ra) # 7868 <unlink>
}
    4914:	0001                	nop
    4916:	70a2                	ld	ra,40(sp)
    4918:	7402                	ld	s0,32(sp)
    491a:	6145                	addi	sp,sp,48
    491c:	8082                	ret

000000000000491e <rmdot>:

void
rmdot(char *s)
{
    491e:	1101                	addi	sp,sp,-32
    4920:	ec06                	sd	ra,24(sp)
    4922:	e822                	sd	s0,16(sp)
    4924:	1000                	addi	s0,sp,32
    4926:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dots") != 0){
    492a:	00005517          	auipc	a0,0x5
    492e:	ec650513          	addi	a0,a0,-314 # 97f0 <malloc+0x18b8>
    4932:	00003097          	auipc	ra,0x3
    4936:	f4e080e7          	jalr	-178(ra) # 7880 <mkdir>
    493a:	87aa                	mv	a5,a0
    493c:	c385                	beqz	a5,495c <rmdot+0x3e>
    printf("%s: mkdir dots failed\n", s);
    493e:	fe843583          	ld	a1,-24(s0)
    4942:	00005517          	auipc	a0,0x5
    4946:	eb650513          	addi	a0,a0,-330 # 97f8 <malloc+0x18c0>
    494a:	00003097          	auipc	ra,0x3
    494e:	3fc080e7          	jalr	1020(ra) # 7d46 <printf>
    exit(1);
    4952:	4505                	li	a0,1
    4954:	00003097          	auipc	ra,0x3
    4958:	ec4080e7          	jalr	-316(ra) # 7818 <exit>
  }
  if(chdir("dots") != 0){
    495c:	00005517          	auipc	a0,0x5
    4960:	e9450513          	addi	a0,a0,-364 # 97f0 <malloc+0x18b8>
    4964:	00003097          	auipc	ra,0x3
    4968:	f24080e7          	jalr	-220(ra) # 7888 <chdir>
    496c:	87aa                	mv	a5,a0
    496e:	c385                	beqz	a5,498e <rmdot+0x70>
    printf("%s: chdir dots failed\n", s);
    4970:	fe843583          	ld	a1,-24(s0)
    4974:	00005517          	auipc	a0,0x5
    4978:	e9c50513          	addi	a0,a0,-356 # 9810 <malloc+0x18d8>
    497c:	00003097          	auipc	ra,0x3
    4980:	3ca080e7          	jalr	970(ra) # 7d46 <printf>
    exit(1);
    4984:	4505                	li	a0,1
    4986:	00003097          	auipc	ra,0x3
    498a:	e92080e7          	jalr	-366(ra) # 7818 <exit>
  }
  if(unlink(".") == 0){
    498e:	00004517          	auipc	a0,0x4
    4992:	4ba50513          	addi	a0,a0,1210 # 8e48 <malloc+0xf10>
    4996:	00003097          	auipc	ra,0x3
    499a:	ed2080e7          	jalr	-302(ra) # 7868 <unlink>
    499e:	87aa                	mv	a5,a0
    49a0:	e385                	bnez	a5,49c0 <rmdot+0xa2>
    printf("%s: rm . worked!\n", s);
    49a2:	fe843583          	ld	a1,-24(s0)
    49a6:	00005517          	auipc	a0,0x5
    49aa:	e8250513          	addi	a0,a0,-382 # 9828 <malloc+0x18f0>
    49ae:	00003097          	auipc	ra,0x3
    49b2:	398080e7          	jalr	920(ra) # 7d46 <printf>
    exit(1);
    49b6:	4505                	li	a0,1
    49b8:	00003097          	auipc	ra,0x3
    49bc:	e60080e7          	jalr	-416(ra) # 7818 <exit>
  }
  if(unlink("..") == 0){
    49c0:	00004517          	auipc	a0,0x4
    49c4:	f0050513          	addi	a0,a0,-256 # 88c0 <malloc+0x988>
    49c8:	00003097          	auipc	ra,0x3
    49cc:	ea0080e7          	jalr	-352(ra) # 7868 <unlink>
    49d0:	87aa                	mv	a5,a0
    49d2:	e385                	bnez	a5,49f2 <rmdot+0xd4>
    printf("%s: rm .. worked!\n", s);
    49d4:	fe843583          	ld	a1,-24(s0)
    49d8:	00005517          	auipc	a0,0x5
    49dc:	e6850513          	addi	a0,a0,-408 # 9840 <malloc+0x1908>
    49e0:	00003097          	auipc	ra,0x3
    49e4:	366080e7          	jalr	870(ra) # 7d46 <printf>
    exit(1);
    49e8:	4505                	li	a0,1
    49ea:	00003097          	auipc	ra,0x3
    49ee:	e2e080e7          	jalr	-466(ra) # 7818 <exit>
  }
  if(chdir("/") != 0){
    49f2:	00004517          	auipc	a0,0x4
    49f6:	be650513          	addi	a0,a0,-1050 # 85d8 <malloc+0x6a0>
    49fa:	00003097          	auipc	ra,0x3
    49fe:	e8e080e7          	jalr	-370(ra) # 7888 <chdir>
    4a02:	87aa                	mv	a5,a0
    4a04:	c385                	beqz	a5,4a24 <rmdot+0x106>
    printf("%s: chdir / failed\n", s);
    4a06:	fe843583          	ld	a1,-24(s0)
    4a0a:	00004517          	auipc	a0,0x4
    4a0e:	bd650513          	addi	a0,a0,-1066 # 85e0 <malloc+0x6a8>
    4a12:	00003097          	auipc	ra,0x3
    4a16:	334080e7          	jalr	820(ra) # 7d46 <printf>
    exit(1);
    4a1a:	4505                	li	a0,1
    4a1c:	00003097          	auipc	ra,0x3
    4a20:	dfc080e7          	jalr	-516(ra) # 7818 <exit>
  }
  if(unlink("dots/.") == 0){
    4a24:	00005517          	auipc	a0,0x5
    4a28:	e3450513          	addi	a0,a0,-460 # 9858 <malloc+0x1920>
    4a2c:	00003097          	auipc	ra,0x3
    4a30:	e3c080e7          	jalr	-452(ra) # 7868 <unlink>
    4a34:	87aa                	mv	a5,a0
    4a36:	e385                	bnez	a5,4a56 <rmdot+0x138>
    printf("%s: unlink dots/. worked!\n", s);
    4a38:	fe843583          	ld	a1,-24(s0)
    4a3c:	00005517          	auipc	a0,0x5
    4a40:	e2450513          	addi	a0,a0,-476 # 9860 <malloc+0x1928>
    4a44:	00003097          	auipc	ra,0x3
    4a48:	302080e7          	jalr	770(ra) # 7d46 <printf>
    exit(1);
    4a4c:	4505                	li	a0,1
    4a4e:	00003097          	auipc	ra,0x3
    4a52:	dca080e7          	jalr	-566(ra) # 7818 <exit>
  }
  if(unlink("dots/..") == 0){
    4a56:	00005517          	auipc	a0,0x5
    4a5a:	e2a50513          	addi	a0,a0,-470 # 9880 <malloc+0x1948>
    4a5e:	00003097          	auipc	ra,0x3
    4a62:	e0a080e7          	jalr	-502(ra) # 7868 <unlink>
    4a66:	87aa                	mv	a5,a0
    4a68:	e385                	bnez	a5,4a88 <rmdot+0x16a>
    printf("%s: unlink dots/.. worked!\n", s);
    4a6a:	fe843583          	ld	a1,-24(s0)
    4a6e:	00005517          	auipc	a0,0x5
    4a72:	e1a50513          	addi	a0,a0,-486 # 9888 <malloc+0x1950>
    4a76:	00003097          	auipc	ra,0x3
    4a7a:	2d0080e7          	jalr	720(ra) # 7d46 <printf>
    exit(1);
    4a7e:	4505                	li	a0,1
    4a80:	00003097          	auipc	ra,0x3
    4a84:	d98080e7          	jalr	-616(ra) # 7818 <exit>
  }
  if(unlink("dots") != 0){
    4a88:	00005517          	auipc	a0,0x5
    4a8c:	d6850513          	addi	a0,a0,-664 # 97f0 <malloc+0x18b8>
    4a90:	00003097          	auipc	ra,0x3
    4a94:	dd8080e7          	jalr	-552(ra) # 7868 <unlink>
    4a98:	87aa                	mv	a5,a0
    4a9a:	c385                	beqz	a5,4aba <rmdot+0x19c>
    printf("%s: unlink dots failed!\n", s);
    4a9c:	fe843583          	ld	a1,-24(s0)
    4aa0:	00005517          	auipc	a0,0x5
    4aa4:	e0850513          	addi	a0,a0,-504 # 98a8 <malloc+0x1970>
    4aa8:	00003097          	auipc	ra,0x3
    4aac:	29e080e7          	jalr	670(ra) # 7d46 <printf>
    exit(1);
    4ab0:	4505                	li	a0,1
    4ab2:	00003097          	auipc	ra,0x3
    4ab6:	d66080e7          	jalr	-666(ra) # 7818 <exit>
  }
}
    4aba:	0001                	nop
    4abc:	60e2                	ld	ra,24(sp)
    4abe:	6442                	ld	s0,16(sp)
    4ac0:	6105                	addi	sp,sp,32
    4ac2:	8082                	ret

0000000000004ac4 <dirfile>:

void
dirfile(char *s)
{
    4ac4:	7179                	addi	sp,sp,-48
    4ac6:	f406                	sd	ra,40(sp)
    4ac8:	f022                	sd	s0,32(sp)
    4aca:	1800                	addi	s0,sp,48
    4acc:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("dirfile", O_CREATE);
    4ad0:	20000593          	li	a1,512
    4ad4:	00005517          	auipc	a0,0x5
    4ad8:	df450513          	addi	a0,a0,-524 # 98c8 <malloc+0x1990>
    4adc:	00003097          	auipc	ra,0x3
    4ae0:	d7c080e7          	jalr	-644(ra) # 7858 <open>
    4ae4:	87aa                	mv	a5,a0
    4ae6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4aea:	fec42783          	lw	a5,-20(s0)
    4aee:	2781                	sext.w	a5,a5
    4af0:	0207d163          	bgez	a5,4b12 <dirfile+0x4e>
    printf("%s: create dirfile failed\n", s);
    4af4:	fd843583          	ld	a1,-40(s0)
    4af8:	00005517          	auipc	a0,0x5
    4afc:	dd850513          	addi	a0,a0,-552 # 98d0 <malloc+0x1998>
    4b00:	00003097          	auipc	ra,0x3
    4b04:	246080e7          	jalr	582(ra) # 7d46 <printf>
    exit(1);
    4b08:	4505                	li	a0,1
    4b0a:	00003097          	auipc	ra,0x3
    4b0e:	d0e080e7          	jalr	-754(ra) # 7818 <exit>
  }
  close(fd);
    4b12:	fec42783          	lw	a5,-20(s0)
    4b16:	853e                	mv	a0,a5
    4b18:	00003097          	auipc	ra,0x3
    4b1c:	d28080e7          	jalr	-728(ra) # 7840 <close>
  if(chdir("dirfile") == 0){
    4b20:	00005517          	auipc	a0,0x5
    4b24:	da850513          	addi	a0,a0,-600 # 98c8 <malloc+0x1990>
    4b28:	00003097          	auipc	ra,0x3
    4b2c:	d60080e7          	jalr	-672(ra) # 7888 <chdir>
    4b30:	87aa                	mv	a5,a0
    4b32:	e385                	bnez	a5,4b52 <dirfile+0x8e>
    printf("%s: chdir dirfile succeeded!\n", s);
    4b34:	fd843583          	ld	a1,-40(s0)
    4b38:	00005517          	auipc	a0,0x5
    4b3c:	db850513          	addi	a0,a0,-584 # 98f0 <malloc+0x19b8>
    4b40:	00003097          	auipc	ra,0x3
    4b44:	206080e7          	jalr	518(ra) # 7d46 <printf>
    exit(1);
    4b48:	4505                	li	a0,1
    4b4a:	00003097          	auipc	ra,0x3
    4b4e:	cce080e7          	jalr	-818(ra) # 7818 <exit>
  }
  fd = open("dirfile/xx", 0);
    4b52:	4581                	li	a1,0
    4b54:	00005517          	auipc	a0,0x5
    4b58:	dbc50513          	addi	a0,a0,-580 # 9910 <malloc+0x19d8>
    4b5c:	00003097          	auipc	ra,0x3
    4b60:	cfc080e7          	jalr	-772(ra) # 7858 <open>
    4b64:	87aa                	mv	a5,a0
    4b66:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4b6a:	fec42783          	lw	a5,-20(s0)
    4b6e:	2781                	sext.w	a5,a5
    4b70:	0207c163          	bltz	a5,4b92 <dirfile+0xce>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4b74:	fd843583          	ld	a1,-40(s0)
    4b78:	00005517          	auipc	a0,0x5
    4b7c:	da850513          	addi	a0,a0,-600 # 9920 <malloc+0x19e8>
    4b80:	00003097          	auipc	ra,0x3
    4b84:	1c6080e7          	jalr	454(ra) # 7d46 <printf>
    exit(1);
    4b88:	4505                	li	a0,1
    4b8a:	00003097          	auipc	ra,0x3
    4b8e:	c8e080e7          	jalr	-882(ra) # 7818 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    4b92:	20000593          	li	a1,512
    4b96:	00005517          	auipc	a0,0x5
    4b9a:	d7a50513          	addi	a0,a0,-646 # 9910 <malloc+0x19d8>
    4b9e:	00003097          	auipc	ra,0x3
    4ba2:	cba080e7          	jalr	-838(ra) # 7858 <open>
    4ba6:	87aa                	mv	a5,a0
    4ba8:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4bac:	fec42783          	lw	a5,-20(s0)
    4bb0:	2781                	sext.w	a5,a5
    4bb2:	0207c163          	bltz	a5,4bd4 <dirfile+0x110>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4bb6:	fd843583          	ld	a1,-40(s0)
    4bba:	00005517          	auipc	a0,0x5
    4bbe:	d6650513          	addi	a0,a0,-666 # 9920 <malloc+0x19e8>
    4bc2:	00003097          	auipc	ra,0x3
    4bc6:	184080e7          	jalr	388(ra) # 7d46 <printf>
    exit(1);
    4bca:	4505                	li	a0,1
    4bcc:	00003097          	auipc	ra,0x3
    4bd0:	c4c080e7          	jalr	-948(ra) # 7818 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    4bd4:	00005517          	auipc	a0,0x5
    4bd8:	d3c50513          	addi	a0,a0,-708 # 9910 <malloc+0x19d8>
    4bdc:	00003097          	auipc	ra,0x3
    4be0:	ca4080e7          	jalr	-860(ra) # 7880 <mkdir>
    4be4:	87aa                	mv	a5,a0
    4be6:	e385                	bnez	a5,4c06 <dirfile+0x142>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4be8:	fd843583          	ld	a1,-40(s0)
    4bec:	00005517          	auipc	a0,0x5
    4bf0:	d5c50513          	addi	a0,a0,-676 # 9948 <malloc+0x1a10>
    4bf4:	00003097          	auipc	ra,0x3
    4bf8:	152080e7          	jalr	338(ra) # 7d46 <printf>
    exit(1);
    4bfc:	4505                	li	a0,1
    4bfe:	00003097          	auipc	ra,0x3
    4c02:	c1a080e7          	jalr	-998(ra) # 7818 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    4c06:	00005517          	auipc	a0,0x5
    4c0a:	d0a50513          	addi	a0,a0,-758 # 9910 <malloc+0x19d8>
    4c0e:	00003097          	auipc	ra,0x3
    4c12:	c5a080e7          	jalr	-934(ra) # 7868 <unlink>
    4c16:	87aa                	mv	a5,a0
    4c18:	e385                	bnez	a5,4c38 <dirfile+0x174>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    4c1a:	fd843583          	ld	a1,-40(s0)
    4c1e:	00005517          	auipc	a0,0x5
    4c22:	d5250513          	addi	a0,a0,-686 # 9970 <malloc+0x1a38>
    4c26:	00003097          	auipc	ra,0x3
    4c2a:	120080e7          	jalr	288(ra) # 7d46 <printf>
    exit(1);
    4c2e:	4505                	li	a0,1
    4c30:	00003097          	auipc	ra,0x3
    4c34:	be8080e7          	jalr	-1048(ra) # 7818 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    4c38:	00005597          	auipc	a1,0x5
    4c3c:	cd858593          	addi	a1,a1,-808 # 9910 <malloc+0x19d8>
    4c40:	00003517          	auipc	a0,0x3
    4c44:	52050513          	addi	a0,a0,1312 # 8160 <malloc+0x228>
    4c48:	00003097          	auipc	ra,0x3
    4c4c:	c30080e7          	jalr	-976(ra) # 7878 <link>
    4c50:	87aa                	mv	a5,a0
    4c52:	e385                	bnez	a5,4c72 <dirfile+0x1ae>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    4c54:	fd843583          	ld	a1,-40(s0)
    4c58:	00005517          	auipc	a0,0x5
    4c5c:	d4050513          	addi	a0,a0,-704 # 9998 <malloc+0x1a60>
    4c60:	00003097          	auipc	ra,0x3
    4c64:	0e6080e7          	jalr	230(ra) # 7d46 <printf>
    exit(1);
    4c68:	4505                	li	a0,1
    4c6a:	00003097          	auipc	ra,0x3
    4c6e:	bae080e7          	jalr	-1106(ra) # 7818 <exit>
  }
  if(unlink("dirfile") != 0){
    4c72:	00005517          	auipc	a0,0x5
    4c76:	c5650513          	addi	a0,a0,-938 # 98c8 <malloc+0x1990>
    4c7a:	00003097          	auipc	ra,0x3
    4c7e:	bee080e7          	jalr	-1042(ra) # 7868 <unlink>
    4c82:	87aa                	mv	a5,a0
    4c84:	c385                	beqz	a5,4ca4 <dirfile+0x1e0>
    printf("%s: unlink dirfile failed!\n", s);
    4c86:	fd843583          	ld	a1,-40(s0)
    4c8a:	00005517          	auipc	a0,0x5
    4c8e:	d3650513          	addi	a0,a0,-714 # 99c0 <malloc+0x1a88>
    4c92:	00003097          	auipc	ra,0x3
    4c96:	0b4080e7          	jalr	180(ra) # 7d46 <printf>
    exit(1);
    4c9a:	4505                	li	a0,1
    4c9c:	00003097          	auipc	ra,0x3
    4ca0:	b7c080e7          	jalr	-1156(ra) # 7818 <exit>
  }

  fd = open(".", O_RDWR);
    4ca4:	4589                	li	a1,2
    4ca6:	00004517          	auipc	a0,0x4
    4caa:	1a250513          	addi	a0,a0,418 # 8e48 <malloc+0xf10>
    4cae:	00003097          	auipc	ra,0x3
    4cb2:	baa080e7          	jalr	-1110(ra) # 7858 <open>
    4cb6:	87aa                	mv	a5,a0
    4cb8:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4cbc:	fec42783          	lw	a5,-20(s0)
    4cc0:	2781                	sext.w	a5,a5
    4cc2:	0207c163          	bltz	a5,4ce4 <dirfile+0x220>
    printf("%s: open . for writing succeeded!\n", s);
    4cc6:	fd843583          	ld	a1,-40(s0)
    4cca:	00005517          	auipc	a0,0x5
    4cce:	d1650513          	addi	a0,a0,-746 # 99e0 <malloc+0x1aa8>
    4cd2:	00003097          	auipc	ra,0x3
    4cd6:	074080e7          	jalr	116(ra) # 7d46 <printf>
    exit(1);
    4cda:	4505                	li	a0,1
    4cdc:	00003097          	auipc	ra,0x3
    4ce0:	b3c080e7          	jalr	-1220(ra) # 7818 <exit>
  }
  fd = open(".", 0);
    4ce4:	4581                	li	a1,0
    4ce6:	00004517          	auipc	a0,0x4
    4cea:	16250513          	addi	a0,a0,354 # 8e48 <malloc+0xf10>
    4cee:	00003097          	auipc	ra,0x3
    4cf2:	b6a080e7          	jalr	-1174(ra) # 7858 <open>
    4cf6:	87aa                	mv	a5,a0
    4cf8:	fef42623          	sw	a5,-20(s0)
  if(write(fd, "x", 1) > 0){
    4cfc:	fec42783          	lw	a5,-20(s0)
    4d00:	4605                	li	a2,1
    4d02:	00003597          	auipc	a1,0x3
    4d06:	4ae58593          	addi	a1,a1,1198 # 81b0 <malloc+0x278>
    4d0a:	853e                	mv	a0,a5
    4d0c:	00003097          	auipc	ra,0x3
    4d10:	b2c080e7          	jalr	-1236(ra) # 7838 <write>
    4d14:	87aa                	mv	a5,a0
    4d16:	02f05163          	blez	a5,4d38 <dirfile+0x274>
    printf("%s: write . succeeded!\n", s);
    4d1a:	fd843583          	ld	a1,-40(s0)
    4d1e:	00005517          	auipc	a0,0x5
    4d22:	cea50513          	addi	a0,a0,-790 # 9a08 <malloc+0x1ad0>
    4d26:	00003097          	auipc	ra,0x3
    4d2a:	020080e7          	jalr	32(ra) # 7d46 <printf>
    exit(1);
    4d2e:	4505                	li	a0,1
    4d30:	00003097          	auipc	ra,0x3
    4d34:	ae8080e7          	jalr	-1304(ra) # 7818 <exit>
  }
  close(fd);
    4d38:	fec42783          	lw	a5,-20(s0)
    4d3c:	853e                	mv	a0,a5
    4d3e:	00003097          	auipc	ra,0x3
    4d42:	b02080e7          	jalr	-1278(ra) # 7840 <close>
}
    4d46:	0001                	nop
    4d48:	70a2                	ld	ra,40(sp)
    4d4a:	7402                	ld	s0,32(sp)
    4d4c:	6145                	addi	sp,sp,48
    4d4e:	8082                	ret

0000000000004d50 <iref>:

// test that iput() is called at the end of _namei().
// also tests empty file names.
void
iref(char *s)
{
    4d50:	7179                	addi	sp,sp,-48
    4d52:	f406                	sd	ra,40(sp)
    4d54:	f022                	sd	s0,32(sp)
    4d56:	1800                	addi	s0,sp,48
    4d58:	fca43c23          	sd	a0,-40(s0)
  int i, fd;

  for(i = 0; i < NINODE + 1; i++){
    4d5c:	fe042623          	sw	zero,-20(s0)
    4d60:	a231                	j	4e6c <iref+0x11c>
    if(mkdir("irefd") != 0){
    4d62:	00005517          	auipc	a0,0x5
    4d66:	cbe50513          	addi	a0,a0,-834 # 9a20 <malloc+0x1ae8>
    4d6a:	00003097          	auipc	ra,0x3
    4d6e:	b16080e7          	jalr	-1258(ra) # 7880 <mkdir>
    4d72:	87aa                	mv	a5,a0
    4d74:	c385                	beqz	a5,4d94 <iref+0x44>
      printf("%s: mkdir irefd failed\n", s);
    4d76:	fd843583          	ld	a1,-40(s0)
    4d7a:	00005517          	auipc	a0,0x5
    4d7e:	cae50513          	addi	a0,a0,-850 # 9a28 <malloc+0x1af0>
    4d82:	00003097          	auipc	ra,0x3
    4d86:	fc4080e7          	jalr	-60(ra) # 7d46 <printf>
      exit(1);
    4d8a:	4505                	li	a0,1
    4d8c:	00003097          	auipc	ra,0x3
    4d90:	a8c080e7          	jalr	-1396(ra) # 7818 <exit>
    }
    if(chdir("irefd") != 0){
    4d94:	00005517          	auipc	a0,0x5
    4d98:	c8c50513          	addi	a0,a0,-884 # 9a20 <malloc+0x1ae8>
    4d9c:	00003097          	auipc	ra,0x3
    4da0:	aec080e7          	jalr	-1300(ra) # 7888 <chdir>
    4da4:	87aa                	mv	a5,a0
    4da6:	c385                	beqz	a5,4dc6 <iref+0x76>
      printf("%s: chdir irefd failed\n", s);
    4da8:	fd843583          	ld	a1,-40(s0)
    4dac:	00005517          	auipc	a0,0x5
    4db0:	c9450513          	addi	a0,a0,-876 # 9a40 <malloc+0x1b08>
    4db4:	00003097          	auipc	ra,0x3
    4db8:	f92080e7          	jalr	-110(ra) # 7d46 <printf>
      exit(1);
    4dbc:	4505                	li	a0,1
    4dbe:	00003097          	auipc	ra,0x3
    4dc2:	a5a080e7          	jalr	-1446(ra) # 7818 <exit>
    }

    mkdir("");
    4dc6:	00005517          	auipc	a0,0x5
    4dca:	c9250513          	addi	a0,a0,-878 # 9a58 <malloc+0x1b20>
    4dce:	00003097          	auipc	ra,0x3
    4dd2:	ab2080e7          	jalr	-1358(ra) # 7880 <mkdir>
    link("README", "");
    4dd6:	00005597          	auipc	a1,0x5
    4dda:	c8258593          	addi	a1,a1,-894 # 9a58 <malloc+0x1b20>
    4dde:	00003517          	auipc	a0,0x3
    4de2:	38250513          	addi	a0,a0,898 # 8160 <malloc+0x228>
    4de6:	00003097          	auipc	ra,0x3
    4dea:	a92080e7          	jalr	-1390(ra) # 7878 <link>
    fd = open("", O_CREATE);
    4dee:	20000593          	li	a1,512
    4df2:	00005517          	auipc	a0,0x5
    4df6:	c6650513          	addi	a0,a0,-922 # 9a58 <malloc+0x1b20>
    4dfa:	00003097          	auipc	ra,0x3
    4dfe:	a5e080e7          	jalr	-1442(ra) # 7858 <open>
    4e02:	87aa                	mv	a5,a0
    4e04:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    4e08:	fe842783          	lw	a5,-24(s0)
    4e0c:	2781                	sext.w	a5,a5
    4e0e:	0007c963          	bltz	a5,4e20 <iref+0xd0>
      close(fd);
    4e12:	fe842783          	lw	a5,-24(s0)
    4e16:	853e                	mv	a0,a5
    4e18:	00003097          	auipc	ra,0x3
    4e1c:	a28080e7          	jalr	-1496(ra) # 7840 <close>
    fd = open("xx", O_CREATE);
    4e20:	20000593          	li	a1,512
    4e24:	00003517          	auipc	a0,0x3
    4e28:	46450513          	addi	a0,a0,1124 # 8288 <malloc+0x350>
    4e2c:	00003097          	auipc	ra,0x3
    4e30:	a2c080e7          	jalr	-1492(ra) # 7858 <open>
    4e34:	87aa                	mv	a5,a0
    4e36:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    4e3a:	fe842783          	lw	a5,-24(s0)
    4e3e:	2781                	sext.w	a5,a5
    4e40:	0007c963          	bltz	a5,4e52 <iref+0x102>
      close(fd);
    4e44:	fe842783          	lw	a5,-24(s0)
    4e48:	853e                	mv	a0,a5
    4e4a:	00003097          	auipc	ra,0x3
    4e4e:	9f6080e7          	jalr	-1546(ra) # 7840 <close>
    unlink("xx");
    4e52:	00003517          	auipc	a0,0x3
    4e56:	43650513          	addi	a0,a0,1078 # 8288 <malloc+0x350>
    4e5a:	00003097          	auipc	ra,0x3
    4e5e:	a0e080e7          	jalr	-1522(ra) # 7868 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4e62:	fec42783          	lw	a5,-20(s0)
    4e66:	2785                	addiw	a5,a5,1
    4e68:	fef42623          	sw	a5,-20(s0)
    4e6c:	fec42783          	lw	a5,-20(s0)
    4e70:	0007871b          	sext.w	a4,a5
    4e74:	03200793          	li	a5,50
    4e78:	eee7d5e3          	bge	a5,a4,4d62 <iref+0x12>
  }

  // clean up
  for(i = 0; i < NINODE + 1; i++){
    4e7c:	fe042623          	sw	zero,-20(s0)
    4e80:	a035                	j	4eac <iref+0x15c>
    chdir("..");
    4e82:	00004517          	auipc	a0,0x4
    4e86:	a3e50513          	addi	a0,a0,-1474 # 88c0 <malloc+0x988>
    4e8a:	00003097          	auipc	ra,0x3
    4e8e:	9fe080e7          	jalr	-1538(ra) # 7888 <chdir>
    unlink("irefd");
    4e92:	00005517          	auipc	a0,0x5
    4e96:	b8e50513          	addi	a0,a0,-1138 # 9a20 <malloc+0x1ae8>
    4e9a:	00003097          	auipc	ra,0x3
    4e9e:	9ce080e7          	jalr	-1586(ra) # 7868 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4ea2:	fec42783          	lw	a5,-20(s0)
    4ea6:	2785                	addiw	a5,a5,1
    4ea8:	fef42623          	sw	a5,-20(s0)
    4eac:	fec42783          	lw	a5,-20(s0)
    4eb0:	0007871b          	sext.w	a4,a5
    4eb4:	03200793          	li	a5,50
    4eb8:	fce7d5e3          	bge	a5,a4,4e82 <iref+0x132>
  }

  chdir("/");
    4ebc:	00003517          	auipc	a0,0x3
    4ec0:	71c50513          	addi	a0,a0,1820 # 85d8 <malloc+0x6a0>
    4ec4:	00003097          	auipc	ra,0x3
    4ec8:	9c4080e7          	jalr	-1596(ra) # 7888 <chdir>
}
    4ecc:	0001                	nop
    4ece:	70a2                	ld	ra,40(sp)
    4ed0:	7402                	ld	s0,32(sp)
    4ed2:	6145                	addi	sp,sp,48
    4ed4:	8082                	ret

0000000000004ed6 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(char *s)
{
    4ed6:	7179                	addi	sp,sp,-48
    4ed8:	f406                	sd	ra,40(sp)
    4eda:	f022                	sd	s0,32(sp)
    4edc:	1800                	addi	s0,sp,48
    4ede:	fca43c23          	sd	a0,-40(s0)
  enum{ N = 1000 };
  int n, pid;

  for(n=0; n<N; n++){
    4ee2:	fe042623          	sw	zero,-20(s0)
    4ee6:	a81d                	j	4f1c <forktest+0x46>
    pid = fork();
    4ee8:	00003097          	auipc	ra,0x3
    4eec:	928080e7          	jalr	-1752(ra) # 7810 <fork>
    4ef0:	87aa                	mv	a5,a0
    4ef2:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
    4ef6:	fe842783          	lw	a5,-24(s0)
    4efa:	2781                	sext.w	a5,a5
    4efc:	0207c963          	bltz	a5,4f2e <forktest+0x58>
      break;
    if(pid == 0)
    4f00:	fe842783          	lw	a5,-24(s0)
    4f04:	2781                	sext.w	a5,a5
    4f06:	e791                	bnez	a5,4f12 <forktest+0x3c>
      exit(0);
    4f08:	4501                	li	a0,0
    4f0a:	00003097          	auipc	ra,0x3
    4f0e:	90e080e7          	jalr	-1778(ra) # 7818 <exit>
  for(n=0; n<N; n++){
    4f12:	fec42783          	lw	a5,-20(s0)
    4f16:	2785                	addiw	a5,a5,1
    4f18:	fef42623          	sw	a5,-20(s0)
    4f1c:	fec42783          	lw	a5,-20(s0)
    4f20:	0007871b          	sext.w	a4,a5
    4f24:	3e700793          	li	a5,999
    4f28:	fce7d0e3          	bge	a5,a4,4ee8 <forktest+0x12>
    4f2c:	a011                	j	4f30 <forktest+0x5a>
      break;
    4f2e:	0001                	nop
  }

  if (n == 0) {
    4f30:	fec42783          	lw	a5,-20(s0)
    4f34:	2781                	sext.w	a5,a5
    4f36:	e385                	bnez	a5,4f56 <forktest+0x80>
    printf("%s: no fork at all!\n", s);
    4f38:	fd843583          	ld	a1,-40(s0)
    4f3c:	00005517          	auipc	a0,0x5
    4f40:	b2450513          	addi	a0,a0,-1244 # 9a60 <malloc+0x1b28>
    4f44:	00003097          	auipc	ra,0x3
    4f48:	e02080e7          	jalr	-510(ra) # 7d46 <printf>
    exit(1);
    4f4c:	4505                	li	a0,1
    4f4e:	00003097          	auipc	ra,0x3
    4f52:	8ca080e7          	jalr	-1846(ra) # 7818 <exit>
  }

  if(n == N){
    4f56:	fec42783          	lw	a5,-20(s0)
    4f5a:	0007871b          	sext.w	a4,a5
    4f5e:	3e800793          	li	a5,1000
    4f62:	04f71d63          	bne	a4,a5,4fbc <forktest+0xe6>
    printf("%s: fork claimed to work 1000 times!\n", s);
    4f66:	fd843583          	ld	a1,-40(s0)
    4f6a:	00005517          	auipc	a0,0x5
    4f6e:	b0e50513          	addi	a0,a0,-1266 # 9a78 <malloc+0x1b40>
    4f72:	00003097          	auipc	ra,0x3
    4f76:	dd4080e7          	jalr	-556(ra) # 7d46 <printf>
    exit(1);
    4f7a:	4505                	li	a0,1
    4f7c:	00003097          	auipc	ra,0x3
    4f80:	89c080e7          	jalr	-1892(ra) # 7818 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
    4f84:	4501                	li	a0,0
    4f86:	00003097          	auipc	ra,0x3
    4f8a:	89a080e7          	jalr	-1894(ra) # 7820 <wait>
    4f8e:	87aa                	mv	a5,a0
    4f90:	0207d163          	bgez	a5,4fb2 <forktest+0xdc>
      printf("%s: wait stopped early\n", s);
    4f94:	fd843583          	ld	a1,-40(s0)
    4f98:	00005517          	auipc	a0,0x5
    4f9c:	b0850513          	addi	a0,a0,-1272 # 9aa0 <malloc+0x1b68>
    4fa0:	00003097          	auipc	ra,0x3
    4fa4:	da6080e7          	jalr	-602(ra) # 7d46 <printf>
      exit(1);
    4fa8:	4505                	li	a0,1
    4faa:	00003097          	auipc	ra,0x3
    4fae:	86e080e7          	jalr	-1938(ra) # 7818 <exit>
  for(; n > 0; n--){
    4fb2:	fec42783          	lw	a5,-20(s0)
    4fb6:	37fd                	addiw	a5,a5,-1
    4fb8:	fef42623          	sw	a5,-20(s0)
    4fbc:	fec42783          	lw	a5,-20(s0)
    4fc0:	2781                	sext.w	a5,a5
    4fc2:	fcf041e3          	bgtz	a5,4f84 <forktest+0xae>
    }
  }

  if(wait(0) != -1){
    4fc6:	4501                	li	a0,0
    4fc8:	00003097          	auipc	ra,0x3
    4fcc:	858080e7          	jalr	-1960(ra) # 7820 <wait>
    4fd0:	87aa                	mv	a5,a0
    4fd2:	873e                	mv	a4,a5
    4fd4:	57fd                	li	a5,-1
    4fd6:	02f70163          	beq	a4,a5,4ff8 <forktest+0x122>
    printf("%s: wait got too many\n", s);
    4fda:	fd843583          	ld	a1,-40(s0)
    4fde:	00005517          	auipc	a0,0x5
    4fe2:	ada50513          	addi	a0,a0,-1318 # 9ab8 <malloc+0x1b80>
    4fe6:	00003097          	auipc	ra,0x3
    4fea:	d60080e7          	jalr	-672(ra) # 7d46 <printf>
    exit(1);
    4fee:	4505                	li	a0,1
    4ff0:	00003097          	auipc	ra,0x3
    4ff4:	828080e7          	jalr	-2008(ra) # 7818 <exit>
  }
}
    4ff8:	0001                	nop
    4ffa:	70a2                	ld	ra,40(sp)
    4ffc:	7402                	ld	s0,32(sp)
    4ffe:	6145                	addi	sp,sp,48
    5000:	8082                	ret

0000000000005002 <sbrkbasic>:

void
sbrkbasic(char *s)
{
    5002:	715d                	addi	sp,sp,-80
    5004:	e486                	sd	ra,72(sp)
    5006:	e0a2                	sd	s0,64(sp)
    5008:	0880                	addi	s0,sp,80
    500a:	faa43c23          	sd	a0,-72(s0)
  enum { TOOMUCH=1024*1024*1024};
  int i, pid, xstatus;
  char *c, *a, *b;

  // does sbrk() return the expected failure value?
  pid = fork();
    500e:	00003097          	auipc	ra,0x3
    5012:	802080e7          	jalr	-2046(ra) # 7810 <fork>
    5016:	87aa                	mv	a5,a0
    5018:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    501c:	fd442783          	lw	a5,-44(s0)
    5020:	2781                	sext.w	a5,a5
    5022:	0007df63          	bgez	a5,5040 <sbrkbasic+0x3e>
    printf("fork failed in sbrkbasic\n");
    5026:	00005517          	auipc	a0,0x5
    502a:	aaa50513          	addi	a0,a0,-1366 # 9ad0 <malloc+0x1b98>
    502e:	00003097          	auipc	ra,0x3
    5032:	d18080e7          	jalr	-744(ra) # 7d46 <printf>
    exit(1);
    5036:	4505                	li	a0,1
    5038:	00002097          	auipc	ra,0x2
    503c:	7e0080e7          	jalr	2016(ra) # 7818 <exit>
  }
  if(pid == 0){
    5040:	fd442783          	lw	a5,-44(s0)
    5044:	2781                	sext.w	a5,a5
    5046:	e3b5                	bnez	a5,50aa <sbrkbasic+0xa8>
    a = sbrk(TOOMUCH);
    5048:	40000537          	lui	a0,0x40000
    504c:	00003097          	auipc	ra,0x3
    5050:	854080e7          	jalr	-1964(ra) # 78a0 <sbrk>
    5054:	fea43023          	sd	a0,-32(s0)
    if(a == (char*)0xffffffffffffffffL){
    5058:	fe043703          	ld	a4,-32(s0)
    505c:	57fd                	li	a5,-1
    505e:	00f71763          	bne	a4,a5,506c <sbrkbasic+0x6a>
      // it's OK if this fails.
      exit(0);
    5062:	4501                	li	a0,0
    5064:	00002097          	auipc	ra,0x2
    5068:	7b4080e7          	jalr	1972(ra) # 7818 <exit>
    }

    for(b = a; b < a+TOOMUCH; b += 4096){
    506c:	fe043783          	ld	a5,-32(s0)
    5070:	fcf43c23          	sd	a5,-40(s0)
    5074:	a829                	j	508e <sbrkbasic+0x8c>
      *b = 99;
    5076:	fd843783          	ld	a5,-40(s0)
    507a:	06300713          	li	a4,99
    507e:	00e78023          	sb	a4,0(a5)
    for(b = a; b < a+TOOMUCH; b += 4096){
    5082:	fd843703          	ld	a4,-40(s0)
    5086:	6785                	lui	a5,0x1
    5088:	97ba                	add	a5,a5,a4
    508a:	fcf43c23          	sd	a5,-40(s0)
    508e:	fe043703          	ld	a4,-32(s0)
    5092:	400007b7          	lui	a5,0x40000
    5096:	97ba                	add	a5,a5,a4
    5098:	fd843703          	ld	a4,-40(s0)
    509c:	fcf76de3          	bltu	a4,a5,5076 <sbrkbasic+0x74>
    }

    // we should not get here! either sbrk(TOOMUCH)
    // should have failed, or (with lazy allocation)
    // a pagefault should have killed this process.
    exit(1);
    50a0:	4505                	li	a0,1
    50a2:	00002097          	auipc	ra,0x2
    50a6:	776080e7          	jalr	1910(ra) # 7818 <exit>
  }

  wait(&xstatus);
    50aa:	fc440793          	addi	a5,s0,-60
    50ae:	853e                	mv	a0,a5
    50b0:	00002097          	auipc	ra,0x2
    50b4:	770080e7          	jalr	1904(ra) # 7820 <wait>
  if(xstatus == 1){
    50b8:	fc442783          	lw	a5,-60(s0)
    50bc:	873e                	mv	a4,a5
    50be:	4785                	li	a5,1
    50c0:	02f71163          	bne	a4,a5,50e2 <sbrkbasic+0xe0>
    printf("%s: too much memory allocated!\n", s);
    50c4:	fb843583          	ld	a1,-72(s0)
    50c8:	00005517          	auipc	a0,0x5
    50cc:	a2850513          	addi	a0,a0,-1496 # 9af0 <malloc+0x1bb8>
    50d0:	00003097          	auipc	ra,0x3
    50d4:	c76080e7          	jalr	-906(ra) # 7d46 <printf>
    exit(1);
    50d8:	4505                	li	a0,1
    50da:	00002097          	auipc	ra,0x2
    50de:	73e080e7          	jalr	1854(ra) # 7818 <exit>
  }

  // can one sbrk() less than a page?
  a = sbrk(0);
    50e2:	4501                	li	a0,0
    50e4:	00002097          	auipc	ra,0x2
    50e8:	7bc080e7          	jalr	1980(ra) # 78a0 <sbrk>
    50ec:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < 5000; i++){
    50f0:	fe042623          	sw	zero,-20(s0)
    50f4:	a09d                	j	515a <sbrkbasic+0x158>
    b = sbrk(1);
    50f6:	4505                	li	a0,1
    50f8:	00002097          	auipc	ra,0x2
    50fc:	7a8080e7          	jalr	1960(ra) # 78a0 <sbrk>
    5100:	fca43c23          	sd	a0,-40(s0)
    if(b != a){
    5104:	fd843703          	ld	a4,-40(s0)
    5108:	fe043783          	ld	a5,-32(s0)
    510c:	02f70863          	beq	a4,a5,513c <sbrkbasic+0x13a>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    5110:	fec42783          	lw	a5,-20(s0)
    5114:	fd843703          	ld	a4,-40(s0)
    5118:	fe043683          	ld	a3,-32(s0)
    511c:	863e                	mv	a2,a5
    511e:	fb843583          	ld	a1,-72(s0)
    5122:	00005517          	auipc	a0,0x5
    5126:	9ee50513          	addi	a0,a0,-1554 # 9b10 <malloc+0x1bd8>
    512a:	00003097          	auipc	ra,0x3
    512e:	c1c080e7          	jalr	-996(ra) # 7d46 <printf>
      exit(1);
    5132:	4505                	li	a0,1
    5134:	00002097          	auipc	ra,0x2
    5138:	6e4080e7          	jalr	1764(ra) # 7818 <exit>
    }
    *b = 1;
    513c:	fd843783          	ld	a5,-40(s0)
    5140:	4705                	li	a4,1
    5142:	00e78023          	sb	a4,0(a5) # 40000000 <freep+0x3ffee388>
    a = b + 1;
    5146:	fd843783          	ld	a5,-40(s0)
    514a:	0785                	addi	a5,a5,1
    514c:	fef43023          	sd	a5,-32(s0)
  for(i = 0; i < 5000; i++){
    5150:	fec42783          	lw	a5,-20(s0)
    5154:	2785                	addiw	a5,a5,1
    5156:	fef42623          	sw	a5,-20(s0)
    515a:	fec42783          	lw	a5,-20(s0)
    515e:	0007871b          	sext.w	a4,a5
    5162:	6785                	lui	a5,0x1
    5164:	38778793          	addi	a5,a5,903 # 1387 <openiputtest+0xe1>
    5168:	f8e7d7e3          	bge	a5,a4,50f6 <sbrkbasic+0xf4>
  }
  pid = fork();
    516c:	00002097          	auipc	ra,0x2
    5170:	6a4080e7          	jalr	1700(ra) # 7810 <fork>
    5174:	87aa                	mv	a5,a0
    5176:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    517a:	fd442783          	lw	a5,-44(s0)
    517e:	2781                	sext.w	a5,a5
    5180:	0207d163          	bgez	a5,51a2 <sbrkbasic+0x1a0>
    printf("%s: sbrk test fork failed\n", s);
    5184:	fb843583          	ld	a1,-72(s0)
    5188:	00005517          	auipc	a0,0x5
    518c:	9a850513          	addi	a0,a0,-1624 # 9b30 <malloc+0x1bf8>
    5190:	00003097          	auipc	ra,0x3
    5194:	bb6080e7          	jalr	-1098(ra) # 7d46 <printf>
    exit(1);
    5198:	4505                	li	a0,1
    519a:	00002097          	auipc	ra,0x2
    519e:	67e080e7          	jalr	1662(ra) # 7818 <exit>
  }
  c = sbrk(1);
    51a2:	4505                	li	a0,1
    51a4:	00002097          	auipc	ra,0x2
    51a8:	6fc080e7          	jalr	1788(ra) # 78a0 <sbrk>
    51ac:	fca43423          	sd	a0,-56(s0)
  c = sbrk(1);
    51b0:	4505                	li	a0,1
    51b2:	00002097          	auipc	ra,0x2
    51b6:	6ee080e7          	jalr	1774(ra) # 78a0 <sbrk>
    51ba:	fca43423          	sd	a0,-56(s0)
  if(c != a + 1){
    51be:	fe043783          	ld	a5,-32(s0)
    51c2:	0785                	addi	a5,a5,1
    51c4:	fc843703          	ld	a4,-56(s0)
    51c8:	02f70163          	beq	a4,a5,51ea <sbrkbasic+0x1e8>
    printf("%s: sbrk test failed post-fork\n", s);
    51cc:	fb843583          	ld	a1,-72(s0)
    51d0:	00005517          	auipc	a0,0x5
    51d4:	98050513          	addi	a0,a0,-1664 # 9b50 <malloc+0x1c18>
    51d8:	00003097          	auipc	ra,0x3
    51dc:	b6e080e7          	jalr	-1170(ra) # 7d46 <printf>
    exit(1);
    51e0:	4505                	li	a0,1
    51e2:	00002097          	auipc	ra,0x2
    51e6:	636080e7          	jalr	1590(ra) # 7818 <exit>
  }
  if(pid == 0)
    51ea:	fd442783          	lw	a5,-44(s0)
    51ee:	2781                	sext.w	a5,a5
    51f0:	e791                	bnez	a5,51fc <sbrkbasic+0x1fa>
    exit(0);
    51f2:	4501                	li	a0,0
    51f4:	00002097          	auipc	ra,0x2
    51f8:	624080e7          	jalr	1572(ra) # 7818 <exit>
  wait(&xstatus);
    51fc:	fc440793          	addi	a5,s0,-60
    5200:	853e                	mv	a0,a5
    5202:	00002097          	auipc	ra,0x2
    5206:	61e080e7          	jalr	1566(ra) # 7820 <wait>
  exit(xstatus);
    520a:	fc442783          	lw	a5,-60(s0)
    520e:	853e                	mv	a0,a5
    5210:	00002097          	auipc	ra,0x2
    5214:	608080e7          	jalr	1544(ra) # 7818 <exit>

0000000000005218 <sbrkmuch>:
}

void
sbrkmuch(char *s)
{
    5218:	711d                	addi	sp,sp,-96
    521a:	ec86                	sd	ra,88(sp)
    521c:	e8a2                	sd	s0,80(sp)
    521e:	1080                	addi	s0,sp,96
    5220:	faa43423          	sd	a0,-88(s0)
  enum { BIG=18*1024*1024 };
  char *c, *oldbrk, *a, *lastaddr, *p;
  uint64 amt;

  oldbrk = sbrk(0);
    5224:	4501                	li	a0,0
    5226:	00002097          	auipc	ra,0x2
    522a:	67a080e7          	jalr	1658(ra) # 78a0 <sbrk>
    522e:	fea43023          	sd	a0,-32(s0)

  // can one grow address space to something big?
  a = sbrk(0);
    5232:	4501                	li	a0,0
    5234:	00002097          	auipc	ra,0x2
    5238:	66c080e7          	jalr	1644(ra) # 78a0 <sbrk>
    523c:	fca43c23          	sd	a0,-40(s0)
  amt = BIG - (uint64)a;
    5240:	fd843783          	ld	a5,-40(s0)
    5244:	01200737          	lui	a4,0x1200
    5248:	40f707b3          	sub	a5,a4,a5
    524c:	fcf43823          	sd	a5,-48(s0)
  p = sbrk(amt);
    5250:	fd043783          	ld	a5,-48(s0)
    5254:	2781                	sext.w	a5,a5
    5256:	853e                	mv	a0,a5
    5258:	00002097          	auipc	ra,0x2
    525c:	648080e7          	jalr	1608(ra) # 78a0 <sbrk>
    5260:	fca43423          	sd	a0,-56(s0)

  if (p != a) {
    5264:	fc843703          	ld	a4,-56(s0)
    5268:	fd843783          	ld	a5,-40(s0)
    526c:	02f70163          	beq	a4,a5,528e <sbrkmuch+0x76>
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    5270:	fa843583          	ld	a1,-88(s0)
    5274:	00005517          	auipc	a0,0x5
    5278:	8fc50513          	addi	a0,a0,-1796 # 9b70 <malloc+0x1c38>
    527c:	00003097          	auipc	ra,0x3
    5280:	aca080e7          	jalr	-1334(ra) # 7d46 <printf>
    exit(1);
    5284:	4505                	li	a0,1
    5286:	00002097          	auipc	ra,0x2
    528a:	592080e7          	jalr	1426(ra) # 7818 <exit>
  }

  // touch each page to make sure it exists.
  char *eee = sbrk(0);
    528e:	4501                	li	a0,0
    5290:	00002097          	auipc	ra,0x2
    5294:	610080e7          	jalr	1552(ra) # 78a0 <sbrk>
    5298:	fca43023          	sd	a0,-64(s0)
  for(char *pp = eee-4096; pp > a; pp -= 4096)
    529c:	fc043703          	ld	a4,-64(s0)
    52a0:	77fd                	lui	a5,0xfffff
    52a2:	97ba                	add	a5,a5,a4
    52a4:	fef43423          	sd	a5,-24(s0)
    52a8:	a821                	j	52c0 <sbrkmuch+0xa8>
    *pp = 1;
    52aa:	fe843783          	ld	a5,-24(s0)
    52ae:	4705                	li	a4,1
    52b0:	00e78023          	sb	a4,0(a5) # fffffffffffff000 <freep+0xfffffffffffed388>
  for(char *pp = eee-4096; pp > a; pp -= 4096)
    52b4:	fe843703          	ld	a4,-24(s0)
    52b8:	77fd                	lui	a5,0xfffff
    52ba:	97ba                	add	a5,a5,a4
    52bc:	fef43423          	sd	a5,-24(s0)
    52c0:	fe843703          	ld	a4,-24(s0)
    52c4:	fd843783          	ld	a5,-40(s0)
    52c8:	fee7e1e3          	bltu	a5,a4,52aa <sbrkmuch+0x92>

  lastaddr = (char*) (BIG-1);
    52cc:	012007b7          	lui	a5,0x1200
    52d0:	17fd                	addi	a5,a5,-1
    52d2:	faf43c23          	sd	a5,-72(s0)
  *lastaddr = 99;
    52d6:	fb843783          	ld	a5,-72(s0)
    52da:	06300713          	li	a4,99
    52de:	00e78023          	sb	a4,0(a5) # 1200000 <freep+0x11ee388>

  // can one de-allocate?
  a = sbrk(0);
    52e2:	4501                	li	a0,0
    52e4:	00002097          	auipc	ra,0x2
    52e8:	5bc080e7          	jalr	1468(ra) # 78a0 <sbrk>
    52ec:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-PGSIZE);
    52f0:	757d                	lui	a0,0xfffff
    52f2:	00002097          	auipc	ra,0x2
    52f6:	5ae080e7          	jalr	1454(ra) # 78a0 <sbrk>
    52fa:	faa43823          	sd	a0,-80(s0)
  if(c == (char*)0xffffffffffffffffL){
    52fe:	fb043703          	ld	a4,-80(s0)
    5302:	57fd                	li	a5,-1
    5304:	02f71163          	bne	a4,a5,5326 <sbrkmuch+0x10e>
    printf("%s: sbrk could not deallocate\n", s);
    5308:	fa843583          	ld	a1,-88(s0)
    530c:	00005517          	auipc	a0,0x5
    5310:	8ac50513          	addi	a0,a0,-1876 # 9bb8 <malloc+0x1c80>
    5314:	00003097          	auipc	ra,0x3
    5318:	a32080e7          	jalr	-1486(ra) # 7d46 <printf>
    exit(1);
    531c:	4505                	li	a0,1
    531e:	00002097          	auipc	ra,0x2
    5322:	4fa080e7          	jalr	1274(ra) # 7818 <exit>
  }

  c = sbrk(0);
    5326:	4501                	li	a0,0
    5328:	00002097          	auipc	ra,0x2
    532c:	578080e7          	jalr	1400(ra) # 78a0 <sbrk>
    5330:	faa43823          	sd	a0,-80(s0)
  if(c != a - PGSIZE){
    5334:	fd843703          	ld	a4,-40(s0)
    5338:	77fd                	lui	a5,0xfffff
    533a:	97ba                	add	a5,a5,a4
    533c:	fb043703          	ld	a4,-80(s0)
    5340:	02f70563          	beq	a4,a5,536a <sbrkmuch+0x152>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    5344:	fb043683          	ld	a3,-80(s0)
    5348:	fd843603          	ld	a2,-40(s0)
    534c:	fa843583          	ld	a1,-88(s0)
    5350:	00005517          	auipc	a0,0x5
    5354:	88850513          	addi	a0,a0,-1912 # 9bd8 <malloc+0x1ca0>
    5358:	00003097          	auipc	ra,0x3
    535c:	9ee080e7          	jalr	-1554(ra) # 7d46 <printf>
    exit(1);
    5360:	4505                	li	a0,1
    5362:	00002097          	auipc	ra,0x2
    5366:	4b6080e7          	jalr	1206(ra) # 7818 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    536a:	4501                	li	a0,0
    536c:	00002097          	auipc	ra,0x2
    5370:	534080e7          	jalr	1332(ra) # 78a0 <sbrk>
    5374:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(PGSIZE);
    5378:	6505                	lui	a0,0x1
    537a:	00002097          	auipc	ra,0x2
    537e:	526080e7          	jalr	1318(ra) # 78a0 <sbrk>
    5382:	faa43823          	sd	a0,-80(s0)
  if(c != a || sbrk(0) != a + PGSIZE){
    5386:	fb043703          	ld	a4,-80(s0)
    538a:	fd843783          	ld	a5,-40(s0)
    538e:	00f71e63          	bne	a4,a5,53aa <sbrkmuch+0x192>
    5392:	4501                	li	a0,0
    5394:	00002097          	auipc	ra,0x2
    5398:	50c080e7          	jalr	1292(ra) # 78a0 <sbrk>
    539c:	86aa                	mv	a3,a0
    539e:	fd843703          	ld	a4,-40(s0)
    53a2:	6785                	lui	a5,0x1
    53a4:	97ba                	add	a5,a5,a4
    53a6:	02f68563          	beq	a3,a5,53d0 <sbrkmuch+0x1b8>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    53aa:	fb043683          	ld	a3,-80(s0)
    53ae:	fd843603          	ld	a2,-40(s0)
    53b2:	fa843583          	ld	a1,-88(s0)
    53b6:	00005517          	auipc	a0,0x5
    53ba:	86250513          	addi	a0,a0,-1950 # 9c18 <malloc+0x1ce0>
    53be:	00003097          	auipc	ra,0x3
    53c2:	988080e7          	jalr	-1656(ra) # 7d46 <printf>
    exit(1);
    53c6:	4505                	li	a0,1
    53c8:	00002097          	auipc	ra,0x2
    53cc:	450080e7          	jalr	1104(ra) # 7818 <exit>
  }

  if(*lastaddr == 99){
    53d0:	fb843783          	ld	a5,-72(s0)
    53d4:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    53d8:	873e                	mv	a4,a5
    53da:	06300793          	li	a5,99
    53de:	02f71163          	bne	a4,a5,5400 <sbrkmuch+0x1e8>
    // should be zero
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    53e2:	fa843583          	ld	a1,-88(s0)
    53e6:	00005517          	auipc	a0,0x5
    53ea:	86250513          	addi	a0,a0,-1950 # 9c48 <malloc+0x1d10>
    53ee:	00003097          	auipc	ra,0x3
    53f2:	958080e7          	jalr	-1704(ra) # 7d46 <printf>
    exit(1);
    53f6:	4505                	li	a0,1
    53f8:	00002097          	auipc	ra,0x2
    53fc:	420080e7          	jalr	1056(ra) # 7818 <exit>
  }

  a = sbrk(0);
    5400:	4501                	li	a0,0
    5402:	00002097          	auipc	ra,0x2
    5406:	49e080e7          	jalr	1182(ra) # 78a0 <sbrk>
    540a:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-(sbrk(0) - oldbrk));
    540e:	4501                	li	a0,0
    5410:	00002097          	auipc	ra,0x2
    5414:	490080e7          	jalr	1168(ra) # 78a0 <sbrk>
    5418:	872a                	mv	a4,a0
    541a:	fe043783          	ld	a5,-32(s0)
    541e:	8f99                	sub	a5,a5,a4
    5420:	2781                	sext.w	a5,a5
    5422:	853e                	mv	a0,a5
    5424:	00002097          	auipc	ra,0x2
    5428:	47c080e7          	jalr	1148(ra) # 78a0 <sbrk>
    542c:	faa43823          	sd	a0,-80(s0)
  if(c != a){
    5430:	fb043703          	ld	a4,-80(s0)
    5434:	fd843783          	ld	a5,-40(s0)
    5438:	02f70563          	beq	a4,a5,5462 <sbrkmuch+0x24a>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    543c:	fb043683          	ld	a3,-80(s0)
    5440:	fd843603          	ld	a2,-40(s0)
    5444:	fa843583          	ld	a1,-88(s0)
    5448:	00005517          	auipc	a0,0x5
    544c:	83850513          	addi	a0,a0,-1992 # 9c80 <malloc+0x1d48>
    5450:	00003097          	auipc	ra,0x3
    5454:	8f6080e7          	jalr	-1802(ra) # 7d46 <printf>
    exit(1);
    5458:	4505                	li	a0,1
    545a:	00002097          	auipc	ra,0x2
    545e:	3be080e7          	jalr	958(ra) # 7818 <exit>
  }
}
    5462:	0001                	nop
    5464:	60e6                	ld	ra,88(sp)
    5466:	6446                	ld	s0,80(sp)
    5468:	6125                	addi	sp,sp,96
    546a:	8082                	ret

000000000000546c <kernmem>:

// can we read the kernel's memory?
void
kernmem(char *s)
{
    546c:	7179                	addi	sp,sp,-48
    546e:	f406                	sd	ra,40(sp)
    5470:	f022                	sd	s0,32(sp)
    5472:	1800                	addi	s0,sp,48
    5474:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int pid;

  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5478:	4785                	li	a5,1
    547a:	07fe                	slli	a5,a5,0x1f
    547c:	fef43423          	sd	a5,-24(s0)
    5480:	a04d                	j	5522 <kernmem+0xb6>
    pid = fork();
    5482:	00002097          	auipc	ra,0x2
    5486:	38e080e7          	jalr	910(ra) # 7810 <fork>
    548a:	87aa                	mv	a5,a0
    548c:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    5490:	fe442783          	lw	a5,-28(s0)
    5494:	2781                	sext.w	a5,a5
    5496:	0207d163          	bgez	a5,54b8 <kernmem+0x4c>
      printf("%s: fork failed\n", s);
    549a:	fd843583          	ld	a1,-40(s0)
    549e:	00003517          	auipc	a0,0x3
    54a2:	04250513          	addi	a0,a0,66 # 84e0 <malloc+0x5a8>
    54a6:	00003097          	auipc	ra,0x3
    54aa:	8a0080e7          	jalr	-1888(ra) # 7d46 <printf>
      exit(1);
    54ae:	4505                	li	a0,1
    54b0:	00002097          	auipc	ra,0x2
    54b4:	368080e7          	jalr	872(ra) # 7818 <exit>
    }
    if(pid == 0){
    54b8:	fe442783          	lw	a5,-28(s0)
    54bc:	2781                	sext.w	a5,a5
    54be:	eb85                	bnez	a5,54ee <kernmem+0x82>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    54c0:	fe843783          	ld	a5,-24(s0)
    54c4:	0007c783          	lbu	a5,0(a5)
    54c8:	2781                	sext.w	a5,a5
    54ca:	86be                	mv	a3,a5
    54cc:	fe843603          	ld	a2,-24(s0)
    54d0:	fd843583          	ld	a1,-40(s0)
    54d4:	00004517          	auipc	a0,0x4
    54d8:	7d450513          	addi	a0,a0,2004 # 9ca8 <malloc+0x1d70>
    54dc:	00003097          	auipc	ra,0x3
    54e0:	86a080e7          	jalr	-1942(ra) # 7d46 <printf>
      exit(1);
    54e4:	4505                	li	a0,1
    54e6:	00002097          	auipc	ra,0x2
    54ea:	332080e7          	jalr	818(ra) # 7818 <exit>
    }
    int xstatus;
    wait(&xstatus);
    54ee:	fe040793          	addi	a5,s0,-32
    54f2:	853e                	mv	a0,a5
    54f4:	00002097          	auipc	ra,0x2
    54f8:	32c080e7          	jalr	812(ra) # 7820 <wait>
    if(xstatus != -1)  // did kernel kill child?
    54fc:	fe042783          	lw	a5,-32(s0)
    5500:	873e                	mv	a4,a5
    5502:	57fd                	li	a5,-1
    5504:	00f70763          	beq	a4,a5,5512 <kernmem+0xa6>
      exit(1);
    5508:	4505                	li	a0,1
    550a:	00002097          	auipc	ra,0x2
    550e:	30e080e7          	jalr	782(ra) # 7818 <exit>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5512:	fe843703          	ld	a4,-24(s0)
    5516:	67b1                	lui	a5,0xc
    5518:	35078793          	addi	a5,a5,848 # c350 <buf+0xf00>
    551c:	97ba                	add	a5,a5,a4
    551e:	fef43423          	sd	a5,-24(s0)
    5522:	fe843703          	ld	a4,-24(s0)
    5526:	1003d7b7          	lui	a5,0x1003d
    552a:	078e                	slli	a5,a5,0x3
    552c:	47f78793          	addi	a5,a5,1151 # 1003d47f <freep+0x1002b807>
    5530:	f4e7f9e3          	bgeu	a5,a4,5482 <kernmem+0x16>
  }
}
    5534:	0001                	nop
    5536:	0001                	nop
    5538:	70a2                	ld	ra,40(sp)
    553a:	7402                	ld	s0,32(sp)
    553c:	6145                	addi	sp,sp,48
    553e:	8082                	ret

0000000000005540 <MAXVAplus>:

// user code should not be able to write to addresses above MAXVA.
void
MAXVAplus(char *s)
{
    5540:	7139                	addi	sp,sp,-64
    5542:	fc06                	sd	ra,56(sp)
    5544:	f822                	sd	s0,48(sp)
    5546:	0080                	addi	s0,sp,64
    5548:	fca43423          	sd	a0,-56(s0)
  volatile uint64 a = MAXVA;
    554c:	4785                	li	a5,1
    554e:	179a                	slli	a5,a5,0x26
    5550:	fef43023          	sd	a5,-32(s0)
  for( ; a != 0; a <<= 1){
    5554:	a045                	j	55f4 <MAXVAplus+0xb4>
    int pid;
    pid = fork();
    5556:	00002097          	auipc	ra,0x2
    555a:	2ba080e7          	jalr	698(ra) # 7810 <fork>
    555e:	87aa                	mv	a5,a0
    5560:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
    5564:	fec42783          	lw	a5,-20(s0)
    5568:	2781                	sext.w	a5,a5
    556a:	0207d163          	bgez	a5,558c <MAXVAplus+0x4c>
      printf("%s: fork failed\n", s);
    556e:	fc843583          	ld	a1,-56(s0)
    5572:	00003517          	auipc	a0,0x3
    5576:	f6e50513          	addi	a0,a0,-146 # 84e0 <malloc+0x5a8>
    557a:	00002097          	auipc	ra,0x2
    557e:	7cc080e7          	jalr	1996(ra) # 7d46 <printf>
      exit(1);
    5582:	4505                	li	a0,1
    5584:	00002097          	auipc	ra,0x2
    5588:	294080e7          	jalr	660(ra) # 7818 <exit>
    }
    if(pid == 0){
    558c:	fec42783          	lw	a5,-20(s0)
    5590:	2781                	sext.w	a5,a5
    5592:	eb95                	bnez	a5,55c6 <MAXVAplus+0x86>
      *(char*)a = 99;
    5594:	fe043783          	ld	a5,-32(s0)
    5598:	873e                	mv	a4,a5
    559a:	06300793          	li	a5,99
    559e:	00f70023          	sb	a5,0(a4) # 1200000 <freep+0x11ee388>
      printf("%s: oops wrote %x\n", s, a);
    55a2:	fe043783          	ld	a5,-32(s0)
    55a6:	863e                	mv	a2,a5
    55a8:	fc843583          	ld	a1,-56(s0)
    55ac:	00004517          	auipc	a0,0x4
    55b0:	71c50513          	addi	a0,a0,1820 # 9cc8 <malloc+0x1d90>
    55b4:	00002097          	auipc	ra,0x2
    55b8:	792080e7          	jalr	1938(ra) # 7d46 <printf>
      exit(1);
    55bc:	4505                	li	a0,1
    55be:	00002097          	auipc	ra,0x2
    55c2:	25a080e7          	jalr	602(ra) # 7818 <exit>
    }
    int xstatus;
    wait(&xstatus);
    55c6:	fdc40793          	addi	a5,s0,-36
    55ca:	853e                	mv	a0,a5
    55cc:	00002097          	auipc	ra,0x2
    55d0:	254080e7          	jalr	596(ra) # 7820 <wait>
    if(xstatus != -1)  // did kernel kill child?
    55d4:	fdc42783          	lw	a5,-36(s0)
    55d8:	873e                	mv	a4,a5
    55da:	57fd                	li	a5,-1
    55dc:	00f70763          	beq	a4,a5,55ea <MAXVAplus+0xaa>
      exit(1);
    55e0:	4505                	li	a0,1
    55e2:	00002097          	auipc	ra,0x2
    55e6:	236080e7          	jalr	566(ra) # 7818 <exit>
  for( ; a != 0; a <<= 1){
    55ea:	fe043783          	ld	a5,-32(s0)
    55ee:	0786                	slli	a5,a5,0x1
    55f0:	fef43023          	sd	a5,-32(s0)
    55f4:	fe043783          	ld	a5,-32(s0)
    55f8:	ffb9                	bnez	a5,5556 <MAXVAplus+0x16>
  }
}
    55fa:	0001                	nop
    55fc:	0001                	nop
    55fe:	70e2                	ld	ra,56(sp)
    5600:	7442                	ld	s0,48(sp)
    5602:	6121                	addi	sp,sp,64
    5604:	8082                	ret

0000000000005606 <sbrkfail>:

// if we run the system out of memory, does it clean up the last
// failed allocation?
void
sbrkfail(char *s)
{
    5606:	7119                	addi	sp,sp,-128
    5608:	fc86                	sd	ra,120(sp)
    560a:	f8a2                	sd	s0,112(sp)
    560c:	0100                	addi	s0,sp,128
    560e:	f8a43423          	sd	a0,-120(s0)
  char scratch;
  char *c, *a;
  int pids[10];
  int pid;

  if(pipe(fds) != 0){
    5612:	fc040793          	addi	a5,s0,-64
    5616:	853e                	mv	a0,a5
    5618:	00002097          	auipc	ra,0x2
    561c:	210080e7          	jalr	528(ra) # 7828 <pipe>
    5620:	87aa                	mv	a5,a0
    5622:	c385                	beqz	a5,5642 <sbrkfail+0x3c>
    printf("%s: pipe() failed\n", s);
    5624:	f8843583          	ld	a1,-120(s0)
    5628:	00003517          	auipc	a0,0x3
    562c:	35050513          	addi	a0,a0,848 # 8978 <malloc+0xa40>
    5630:	00002097          	auipc	ra,0x2
    5634:	716080e7          	jalr	1814(ra) # 7d46 <printf>
    exit(1);
    5638:	4505                	li	a0,1
    563a:	00002097          	auipc	ra,0x2
    563e:	1de080e7          	jalr	478(ra) # 7818 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5642:	fe042623          	sw	zero,-20(s0)
    5646:	a84d                	j	56f8 <sbrkfail+0xf2>
    if((pids[i] = fork()) == 0){
    5648:	00002097          	auipc	ra,0x2
    564c:	1c8080e7          	jalr	456(ra) # 7810 <fork>
    5650:	87aa                	mv	a5,a0
    5652:	873e                	mv	a4,a5
    5654:	fec42783          	lw	a5,-20(s0)
    5658:	078a                	slli	a5,a5,0x2
    565a:	ff040693          	addi	a3,s0,-16
    565e:	97b6                	add	a5,a5,a3
    5660:	fae7a023          	sw	a4,-96(a5)
    5664:	fec42783          	lw	a5,-20(s0)
    5668:	078a                	slli	a5,a5,0x2
    566a:	ff040713          	addi	a4,s0,-16
    566e:	97ba                	add	a5,a5,a4
    5670:	fa07a783          	lw	a5,-96(a5)
    5674:	e7b1                	bnez	a5,56c0 <sbrkfail+0xba>
      // allocate a lot of memory
      sbrk(BIG - (uint64)sbrk(0));
    5676:	4501                	li	a0,0
    5678:	00002097          	auipc	ra,0x2
    567c:	228080e7          	jalr	552(ra) # 78a0 <sbrk>
    5680:	87aa                	mv	a5,a0
    5682:	2781                	sext.w	a5,a5
    5684:	06400737          	lui	a4,0x6400
    5688:	40f707bb          	subw	a5,a4,a5
    568c:	2781                	sext.w	a5,a5
    568e:	2781                	sext.w	a5,a5
    5690:	853e                	mv	a0,a5
    5692:	00002097          	auipc	ra,0x2
    5696:	20e080e7          	jalr	526(ra) # 78a0 <sbrk>
      write(fds[1], "x", 1);
    569a:	fc442783          	lw	a5,-60(s0)
    569e:	4605                	li	a2,1
    56a0:	00003597          	auipc	a1,0x3
    56a4:	b1058593          	addi	a1,a1,-1264 # 81b0 <malloc+0x278>
    56a8:	853e                	mv	a0,a5
    56aa:	00002097          	auipc	ra,0x2
    56ae:	18e080e7          	jalr	398(ra) # 7838 <write>
      // sit around until killed
      for(;;) sleep(1000);
    56b2:	3e800513          	li	a0,1000
    56b6:	00002097          	auipc	ra,0x2
    56ba:	1f2080e7          	jalr	498(ra) # 78a8 <sleep>
    56be:	bfd5                	j	56b2 <sbrkfail+0xac>
    }
    if(pids[i] != -1)
    56c0:	fec42783          	lw	a5,-20(s0)
    56c4:	078a                	slli	a5,a5,0x2
    56c6:	ff040713          	addi	a4,s0,-16
    56ca:	97ba                	add	a5,a5,a4
    56cc:	fa07a783          	lw	a5,-96(a5)
    56d0:	873e                	mv	a4,a5
    56d2:	57fd                	li	a5,-1
    56d4:	00f70d63          	beq	a4,a5,56ee <sbrkfail+0xe8>
      read(fds[0], &scratch, 1);
    56d8:	fc042783          	lw	a5,-64(s0)
    56dc:	fbf40713          	addi	a4,s0,-65
    56e0:	4605                	li	a2,1
    56e2:	85ba                	mv	a1,a4
    56e4:	853e                	mv	a0,a5
    56e6:	00002097          	auipc	ra,0x2
    56ea:	14a080e7          	jalr	330(ra) # 7830 <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    56ee:	fec42783          	lw	a5,-20(s0)
    56f2:	2785                	addiw	a5,a5,1
    56f4:	fef42623          	sw	a5,-20(s0)
    56f8:	fec42783          	lw	a5,-20(s0)
    56fc:	873e                	mv	a4,a5
    56fe:	47a5                	li	a5,9
    5700:	f4e7f4e3          	bgeu	a5,a4,5648 <sbrkfail+0x42>
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(PGSIZE);
    5704:	6505                	lui	a0,0x1
    5706:	00002097          	auipc	ra,0x2
    570a:	19a080e7          	jalr	410(ra) # 78a0 <sbrk>
    570e:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5712:	fe042623          	sw	zero,-20(s0)
    5716:	a0b1                	j	5762 <sbrkfail+0x15c>
    if(pids[i] == -1)
    5718:	fec42783          	lw	a5,-20(s0)
    571c:	078a                	slli	a5,a5,0x2
    571e:	ff040713          	addi	a4,s0,-16
    5722:	97ba                	add	a5,a5,a4
    5724:	fa07a783          	lw	a5,-96(a5)
    5728:	873e                	mv	a4,a5
    572a:	57fd                	li	a5,-1
    572c:	02f70563          	beq	a4,a5,5756 <sbrkfail+0x150>
      continue;
    kill(pids[i]);
    5730:	fec42783          	lw	a5,-20(s0)
    5734:	078a                	slli	a5,a5,0x2
    5736:	ff040713          	addi	a4,s0,-16
    573a:	97ba                	add	a5,a5,a4
    573c:	fa07a783          	lw	a5,-96(a5)
    5740:	853e                	mv	a0,a5
    5742:	00002097          	auipc	ra,0x2
    5746:	106080e7          	jalr	262(ra) # 7848 <kill>
    wait(0);
    574a:	4501                	li	a0,0
    574c:	00002097          	auipc	ra,0x2
    5750:	0d4080e7          	jalr	212(ra) # 7820 <wait>
    5754:	a011                	j	5758 <sbrkfail+0x152>
      continue;
    5756:	0001                	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5758:	fec42783          	lw	a5,-20(s0)
    575c:	2785                	addiw	a5,a5,1
    575e:	fef42623          	sw	a5,-20(s0)
    5762:	fec42783          	lw	a5,-20(s0)
    5766:	873e                	mv	a4,a5
    5768:	47a5                	li	a5,9
    576a:	fae7f7e3          	bgeu	a5,a4,5718 <sbrkfail+0x112>
  }
  if(c == (char*)0xffffffffffffffffL){
    576e:	fe043703          	ld	a4,-32(s0)
    5772:	57fd                	li	a5,-1
    5774:	02f71163          	bne	a4,a5,5796 <sbrkfail+0x190>
    printf("%s: failed sbrk leaked memory\n", s);
    5778:	f8843583          	ld	a1,-120(s0)
    577c:	00004517          	auipc	a0,0x4
    5780:	56450513          	addi	a0,a0,1380 # 9ce0 <malloc+0x1da8>
    5784:	00002097          	auipc	ra,0x2
    5788:	5c2080e7          	jalr	1474(ra) # 7d46 <printf>
    exit(1);
    578c:	4505                	li	a0,1
    578e:	00002097          	auipc	ra,0x2
    5792:	08a080e7          	jalr	138(ra) # 7818 <exit>
  }

  // test running fork with the above allocated page
  pid = fork();
    5796:	00002097          	auipc	ra,0x2
    579a:	07a080e7          	jalr	122(ra) # 7810 <fork>
    579e:	87aa                	mv	a5,a0
    57a0:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
    57a4:	fdc42783          	lw	a5,-36(s0)
    57a8:	2781                	sext.w	a5,a5
    57aa:	0207d163          	bgez	a5,57cc <sbrkfail+0x1c6>
    printf("%s: fork failed\n", s);
    57ae:	f8843583          	ld	a1,-120(s0)
    57b2:	00003517          	auipc	a0,0x3
    57b6:	d2e50513          	addi	a0,a0,-722 # 84e0 <malloc+0x5a8>
    57ba:	00002097          	auipc	ra,0x2
    57be:	58c080e7          	jalr	1420(ra) # 7d46 <printf>
    exit(1);
    57c2:	4505                	li	a0,1
    57c4:	00002097          	auipc	ra,0x2
    57c8:	054080e7          	jalr	84(ra) # 7818 <exit>
  }
  if(pid == 0){
    57cc:	fdc42783          	lw	a5,-36(s0)
    57d0:	2781                	sext.w	a5,a5
    57d2:	e3c1                	bnez	a5,5852 <sbrkfail+0x24c>
    // allocate a lot of memory.
    // this should produce a page fault,
    // and thus not complete.
    a = sbrk(0);
    57d4:	4501                	li	a0,0
    57d6:	00002097          	auipc	ra,0x2
    57da:	0ca080e7          	jalr	202(ra) # 78a0 <sbrk>
    57de:	fca43823          	sd	a0,-48(s0)
    sbrk(10*BIG);
    57e2:	3e800537          	lui	a0,0x3e800
    57e6:	00002097          	auipc	ra,0x2
    57ea:	0ba080e7          	jalr	186(ra) # 78a0 <sbrk>
    int n = 0;
    57ee:	fe042423          	sw	zero,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    57f2:	fe042623          	sw	zero,-20(s0)
    57f6:	a025                	j	581e <sbrkfail+0x218>
      n += *(a+i);
    57f8:	fec42783          	lw	a5,-20(s0)
    57fc:	fd043703          	ld	a4,-48(s0)
    5800:	97ba                	add	a5,a5,a4
    5802:	0007c783          	lbu	a5,0(a5)
    5806:	2781                	sext.w	a5,a5
    5808:	fe842703          	lw	a4,-24(s0)
    580c:	9fb9                	addw	a5,a5,a4
    580e:	fef42423          	sw	a5,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    5812:	fec42703          	lw	a4,-20(s0)
    5816:	6785                	lui	a5,0x1
    5818:	9fb9                	addw	a5,a5,a4
    581a:	fef42623          	sw	a5,-20(s0)
    581e:	fec42783          	lw	a5,-20(s0)
    5822:	0007871b          	sext.w	a4,a5
    5826:	3e8007b7          	lui	a5,0x3e800
    582a:	fcf747e3          	blt	a4,a5,57f8 <sbrkfail+0x1f2>
    }
    // print n so the compiler doesn't optimize away
    // the for loop.
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    582e:	fe842783          	lw	a5,-24(s0)
    5832:	863e                	mv	a2,a5
    5834:	f8843583          	ld	a1,-120(s0)
    5838:	00004517          	auipc	a0,0x4
    583c:	4c850513          	addi	a0,a0,1224 # 9d00 <malloc+0x1dc8>
    5840:	00002097          	auipc	ra,0x2
    5844:	506080e7          	jalr	1286(ra) # 7d46 <printf>
    exit(1);
    5848:	4505                	li	a0,1
    584a:	00002097          	auipc	ra,0x2
    584e:	fce080e7          	jalr	-50(ra) # 7818 <exit>
  }
  wait(&xstatus);
    5852:	fcc40793          	addi	a5,s0,-52
    5856:	853e                	mv	a0,a5
    5858:	00002097          	auipc	ra,0x2
    585c:	fc8080e7          	jalr	-56(ra) # 7820 <wait>
  if(xstatus != -1 && xstatus != 2)
    5860:	fcc42783          	lw	a5,-52(s0)
    5864:	873e                	mv	a4,a5
    5866:	57fd                	li	a5,-1
    5868:	00f70d63          	beq	a4,a5,5882 <sbrkfail+0x27c>
    586c:	fcc42783          	lw	a5,-52(s0)
    5870:	873e                	mv	a4,a5
    5872:	4789                	li	a5,2
    5874:	00f70763          	beq	a4,a5,5882 <sbrkfail+0x27c>
    exit(1);
    5878:	4505                	li	a0,1
    587a:	00002097          	auipc	ra,0x2
    587e:	f9e080e7          	jalr	-98(ra) # 7818 <exit>
}
    5882:	0001                	nop
    5884:	70e6                	ld	ra,120(sp)
    5886:	7446                	ld	s0,112(sp)
    5888:	6109                	addi	sp,sp,128
    588a:	8082                	ret

000000000000588c <sbrkarg>:


// test reads/writes from/to allocated memory
void
sbrkarg(char *s)
{
    588c:	7179                	addi	sp,sp,-48
    588e:	f406                	sd	ra,40(sp)
    5890:	f022                	sd	s0,32(sp)
    5892:	1800                	addi	s0,sp,48
    5894:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int fd, n;

  a = sbrk(PGSIZE);
    5898:	6505                	lui	a0,0x1
    589a:	00002097          	auipc	ra,0x2
    589e:	006080e7          	jalr	6(ra) # 78a0 <sbrk>
    58a2:	fea43423          	sd	a0,-24(s0)
  fd = open("sbrk", O_CREATE|O_WRONLY);
    58a6:	20100593          	li	a1,513
    58aa:	00004517          	auipc	a0,0x4
    58ae:	48650513          	addi	a0,a0,1158 # 9d30 <malloc+0x1df8>
    58b2:	00002097          	auipc	ra,0x2
    58b6:	fa6080e7          	jalr	-90(ra) # 7858 <open>
    58ba:	87aa                	mv	a5,a0
    58bc:	fef42223          	sw	a5,-28(s0)
  unlink("sbrk");
    58c0:	00004517          	auipc	a0,0x4
    58c4:	47050513          	addi	a0,a0,1136 # 9d30 <malloc+0x1df8>
    58c8:	00002097          	auipc	ra,0x2
    58cc:	fa0080e7          	jalr	-96(ra) # 7868 <unlink>
  if(fd < 0)  {
    58d0:	fe442783          	lw	a5,-28(s0)
    58d4:	2781                	sext.w	a5,a5
    58d6:	0207d163          	bgez	a5,58f8 <sbrkarg+0x6c>
    printf("%s: open sbrk failed\n", s);
    58da:	fd843583          	ld	a1,-40(s0)
    58de:	00004517          	auipc	a0,0x4
    58e2:	45a50513          	addi	a0,a0,1114 # 9d38 <malloc+0x1e00>
    58e6:	00002097          	auipc	ra,0x2
    58ea:	460080e7          	jalr	1120(ra) # 7d46 <printf>
    exit(1);
    58ee:	4505                	li	a0,1
    58f0:	00002097          	auipc	ra,0x2
    58f4:	f28080e7          	jalr	-216(ra) # 7818 <exit>
  }
  if ((n = write(fd, a, PGSIZE)) < 0) {
    58f8:	fe442783          	lw	a5,-28(s0)
    58fc:	6605                	lui	a2,0x1
    58fe:	fe843583          	ld	a1,-24(s0)
    5902:	853e                	mv	a0,a5
    5904:	00002097          	auipc	ra,0x2
    5908:	f34080e7          	jalr	-204(ra) # 7838 <write>
    590c:	87aa                	mv	a5,a0
    590e:	fef42023          	sw	a5,-32(s0)
    5912:	fe042783          	lw	a5,-32(s0)
    5916:	2781                	sext.w	a5,a5
    5918:	0207d163          	bgez	a5,593a <sbrkarg+0xae>
    printf("%s: write sbrk failed\n", s);
    591c:	fd843583          	ld	a1,-40(s0)
    5920:	00004517          	auipc	a0,0x4
    5924:	43050513          	addi	a0,a0,1072 # 9d50 <malloc+0x1e18>
    5928:	00002097          	auipc	ra,0x2
    592c:	41e080e7          	jalr	1054(ra) # 7d46 <printf>
    exit(1);
    5930:	4505                	li	a0,1
    5932:	00002097          	auipc	ra,0x2
    5936:	ee6080e7          	jalr	-282(ra) # 7818 <exit>
  }
  close(fd);
    593a:	fe442783          	lw	a5,-28(s0)
    593e:	853e                	mv	a0,a5
    5940:	00002097          	auipc	ra,0x2
    5944:	f00080e7          	jalr	-256(ra) # 7840 <close>

  // test writes to allocated memory
  a = sbrk(PGSIZE);
    5948:	6505                	lui	a0,0x1
    594a:	00002097          	auipc	ra,0x2
    594e:	f56080e7          	jalr	-170(ra) # 78a0 <sbrk>
    5952:	fea43423          	sd	a0,-24(s0)
  if(pipe((int *) a) != 0){
    5956:	fe843503          	ld	a0,-24(s0)
    595a:	00002097          	auipc	ra,0x2
    595e:	ece080e7          	jalr	-306(ra) # 7828 <pipe>
    5962:	87aa                	mv	a5,a0
    5964:	c385                	beqz	a5,5984 <sbrkarg+0xf8>
    printf("%s: pipe() failed\n", s);
    5966:	fd843583          	ld	a1,-40(s0)
    596a:	00003517          	auipc	a0,0x3
    596e:	00e50513          	addi	a0,a0,14 # 8978 <malloc+0xa40>
    5972:	00002097          	auipc	ra,0x2
    5976:	3d4080e7          	jalr	980(ra) # 7d46 <printf>
    exit(1);
    597a:	4505                	li	a0,1
    597c:	00002097          	auipc	ra,0x2
    5980:	e9c080e7          	jalr	-356(ra) # 7818 <exit>
  }
}
    5984:	0001                	nop
    5986:	70a2                	ld	ra,40(sp)
    5988:	7402                	ld	s0,32(sp)
    598a:	6145                	addi	sp,sp,48
    598c:	8082                	ret

000000000000598e <validatetest>:

void
validatetest(char *s)
{
    598e:	7179                	addi	sp,sp,-48
    5990:	f406                	sd	ra,40(sp)
    5992:	f022                	sd	s0,32(sp)
    5994:	1800                	addi	s0,sp,48
    5996:	fca43c23          	sd	a0,-40(s0)
  int hi;
  uint64 p;

  hi = 1100*1024;
    599a:	001137b7          	lui	a5,0x113
    599e:	fef42223          	sw	a5,-28(s0)
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    59a2:	fe043423          	sd	zero,-24(s0)
    59a6:	a0b1                	j	59f2 <validatetest+0x64>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    59a8:	fe843783          	ld	a5,-24(s0)
    59ac:	85be                	mv	a1,a5
    59ae:	00004517          	auipc	a0,0x4
    59b2:	3ba50513          	addi	a0,a0,954 # 9d68 <malloc+0x1e30>
    59b6:	00002097          	auipc	ra,0x2
    59ba:	ec2080e7          	jalr	-318(ra) # 7878 <link>
    59be:	87aa                	mv	a5,a0
    59c0:	873e                	mv	a4,a5
    59c2:	57fd                	li	a5,-1
    59c4:	02f70163          	beq	a4,a5,59e6 <validatetest+0x58>
      printf("%s: link should not succeed\n", s);
    59c8:	fd843583          	ld	a1,-40(s0)
    59cc:	00004517          	auipc	a0,0x4
    59d0:	3ac50513          	addi	a0,a0,940 # 9d78 <malloc+0x1e40>
    59d4:	00002097          	auipc	ra,0x2
    59d8:	372080e7          	jalr	882(ra) # 7d46 <printf>
      exit(1);
    59dc:	4505                	li	a0,1
    59de:	00002097          	auipc	ra,0x2
    59e2:	e3a080e7          	jalr	-454(ra) # 7818 <exit>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    59e6:	fe843703          	ld	a4,-24(s0)
    59ea:	6785                	lui	a5,0x1
    59ec:	97ba                	add	a5,a5,a4
    59ee:	fef43423          	sd	a5,-24(s0)
    59f2:	fe442783          	lw	a5,-28(s0)
    59f6:	1782                	slli	a5,a5,0x20
    59f8:	9381                	srli	a5,a5,0x20
    59fa:	fe843703          	ld	a4,-24(s0)
    59fe:	fae7f5e3          	bgeu	a5,a4,59a8 <validatetest+0x1a>
    }
  }
}
    5a02:	0001                	nop
    5a04:	0001                	nop
    5a06:	70a2                	ld	ra,40(sp)
    5a08:	7402                	ld	s0,32(sp)
    5a0a:	6145                	addi	sp,sp,48
    5a0c:	8082                	ret

0000000000005a0e <bsstest>:

// does uninitialized data start out zero?
char uninit[10000];
void
bsstest(char *s)
{
    5a0e:	7179                	addi	sp,sp,-48
    5a10:	f406                	sd	ra,40(sp)
    5a12:	f022                	sd	s0,32(sp)
    5a14:	1800                	addi	s0,sp,48
    5a16:	fca43c23          	sd	a0,-40(s0)
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    5a1a:	fe042623          	sw	zero,-20(s0)
    5a1e:	a83d                	j	5a5c <bsstest+0x4e>
    if(uninit[i] != '\0'){
    5a20:	00009717          	auipc	a4,0x9
    5a24:	a3070713          	addi	a4,a4,-1488 # e450 <uninit>
    5a28:	fec42783          	lw	a5,-20(s0)
    5a2c:	97ba                	add	a5,a5,a4
    5a2e:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    5a32:	c385                	beqz	a5,5a52 <bsstest+0x44>
      printf("%s: bss test failed\n", s);
    5a34:	fd843583          	ld	a1,-40(s0)
    5a38:	00004517          	auipc	a0,0x4
    5a3c:	36050513          	addi	a0,a0,864 # 9d98 <malloc+0x1e60>
    5a40:	00002097          	auipc	ra,0x2
    5a44:	306080e7          	jalr	774(ra) # 7d46 <printf>
      exit(1);
    5a48:	4505                	li	a0,1
    5a4a:	00002097          	auipc	ra,0x2
    5a4e:	dce080e7          	jalr	-562(ra) # 7818 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    5a52:	fec42783          	lw	a5,-20(s0)
    5a56:	2785                	addiw	a5,a5,1
    5a58:	fef42623          	sw	a5,-20(s0)
    5a5c:	fec42783          	lw	a5,-20(s0)
    5a60:	873e                	mv	a4,a5
    5a62:	6789                	lui	a5,0x2
    5a64:	70f78793          	addi	a5,a5,1807 # 270f <reparent2+0x7b>
    5a68:	fae7fce3          	bgeu	a5,a4,5a20 <bsstest+0x12>
    }
  }
}
    5a6c:	0001                	nop
    5a6e:	0001                	nop
    5a70:	70a2                	ld	ra,40(sp)
    5a72:	7402                	ld	s0,32(sp)
    5a74:	6145                	addi	sp,sp,48
    5a76:	8082                	ret

0000000000005a78 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(char *s)
{
    5a78:	7179                	addi	sp,sp,-48
    5a7a:	f406                	sd	ra,40(sp)
    5a7c:	f022                	sd	s0,32(sp)
    5a7e:	1800                	addi	s0,sp,48
    5a80:	fca43c23          	sd	a0,-40(s0)
  int pid, fd, xstatus;

  unlink("bigarg-ok");
    5a84:	00004517          	auipc	a0,0x4
    5a88:	32c50513          	addi	a0,a0,812 # 9db0 <malloc+0x1e78>
    5a8c:	00002097          	auipc	ra,0x2
    5a90:	ddc080e7          	jalr	-548(ra) # 7868 <unlink>
  pid = fork();
    5a94:	00002097          	auipc	ra,0x2
    5a98:	d7c080e7          	jalr	-644(ra) # 7810 <fork>
    5a9c:	87aa                	mv	a5,a0
    5a9e:	fef42423          	sw	a5,-24(s0)
  if(pid == 0){
    5aa2:	fe842783          	lw	a5,-24(s0)
    5aa6:	2781                	sext.w	a5,a5
    5aa8:	ebc1                	bnez	a5,5b38 <bigargtest+0xc0>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    5aaa:	fe042623          	sw	zero,-20(s0)
    5aae:	a01d                	j	5ad4 <bigargtest+0x5c>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5ab0:	0000c717          	auipc	a4,0xc
    5ab4:	0b870713          	addi	a4,a4,184 # 11b68 <args.1814>
    5ab8:	fec42783          	lw	a5,-20(s0)
    5abc:	078e                	slli	a5,a5,0x3
    5abe:	97ba                	add	a5,a5,a4
    5ac0:	00004717          	auipc	a4,0x4
    5ac4:	30070713          	addi	a4,a4,768 # 9dc0 <malloc+0x1e88>
    5ac8:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    5aca:	fec42783          	lw	a5,-20(s0)
    5ace:	2785                	addiw	a5,a5,1
    5ad0:	fef42623          	sw	a5,-20(s0)
    5ad4:	fec42783          	lw	a5,-20(s0)
    5ad8:	0007871b          	sext.w	a4,a5
    5adc:	47f9                	li	a5,30
    5ade:	fce7d9e3          	bge	a5,a4,5ab0 <bigargtest+0x38>
    args[MAXARG-1] = 0;
    5ae2:	0000c797          	auipc	a5,0xc
    5ae6:	08678793          	addi	a5,a5,134 # 11b68 <args.1814>
    5aea:	0e07bc23          	sd	zero,248(a5)
    exec("echo", args);
    5aee:	0000c597          	auipc	a1,0xc
    5af2:	07a58593          	addi	a1,a1,122 # 11b68 <args.1814>
    5af6:	00002517          	auipc	a0,0x2
    5afa:	7ca50513          	addi	a0,a0,1994 # 82c0 <malloc+0x388>
    5afe:	00002097          	auipc	ra,0x2
    5b02:	d52080e7          	jalr	-686(ra) # 7850 <exec>
    fd = open("bigarg-ok", O_CREATE);
    5b06:	20000593          	li	a1,512
    5b0a:	00004517          	auipc	a0,0x4
    5b0e:	2a650513          	addi	a0,a0,678 # 9db0 <malloc+0x1e78>
    5b12:	00002097          	auipc	ra,0x2
    5b16:	d46080e7          	jalr	-698(ra) # 7858 <open>
    5b1a:	87aa                	mv	a5,a0
    5b1c:	fef42223          	sw	a5,-28(s0)
    close(fd);
    5b20:	fe442783          	lw	a5,-28(s0)
    5b24:	853e                	mv	a0,a5
    5b26:	00002097          	auipc	ra,0x2
    5b2a:	d1a080e7          	jalr	-742(ra) # 7840 <close>
    exit(0);
    5b2e:	4501                	li	a0,0
    5b30:	00002097          	auipc	ra,0x2
    5b34:	ce8080e7          	jalr	-792(ra) # 7818 <exit>
  } else if(pid < 0){
    5b38:	fe842783          	lw	a5,-24(s0)
    5b3c:	2781                	sext.w	a5,a5
    5b3e:	0207d163          	bgez	a5,5b60 <bigargtest+0xe8>
    printf("%s: bigargtest: fork failed\n", s);
    5b42:	fd843583          	ld	a1,-40(s0)
    5b46:	00004517          	auipc	a0,0x4
    5b4a:	35a50513          	addi	a0,a0,858 # 9ea0 <malloc+0x1f68>
    5b4e:	00002097          	auipc	ra,0x2
    5b52:	1f8080e7          	jalr	504(ra) # 7d46 <printf>
    exit(1);
    5b56:	4505                	li	a0,1
    5b58:	00002097          	auipc	ra,0x2
    5b5c:	cc0080e7          	jalr	-832(ra) # 7818 <exit>
  }

  wait(&xstatus);
    5b60:	fe040793          	addi	a5,s0,-32
    5b64:	853e                	mv	a0,a5
    5b66:	00002097          	auipc	ra,0x2
    5b6a:	cba080e7          	jalr	-838(ra) # 7820 <wait>
  if(xstatus != 0)
    5b6e:	fe042783          	lw	a5,-32(s0)
    5b72:	cb81                	beqz	a5,5b82 <bigargtest+0x10a>
    exit(xstatus);
    5b74:	fe042783          	lw	a5,-32(s0)
    5b78:	853e                	mv	a0,a5
    5b7a:	00002097          	auipc	ra,0x2
    5b7e:	c9e080e7          	jalr	-866(ra) # 7818 <exit>
  fd = open("bigarg-ok", 0);
    5b82:	4581                	li	a1,0
    5b84:	00004517          	auipc	a0,0x4
    5b88:	22c50513          	addi	a0,a0,556 # 9db0 <malloc+0x1e78>
    5b8c:	00002097          	auipc	ra,0x2
    5b90:	ccc080e7          	jalr	-820(ra) # 7858 <open>
    5b94:	87aa                	mv	a5,a0
    5b96:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    5b9a:	fe442783          	lw	a5,-28(s0)
    5b9e:	2781                	sext.w	a5,a5
    5ba0:	0207d163          	bgez	a5,5bc2 <bigargtest+0x14a>
    printf("%s: bigarg test failed!\n", s);
    5ba4:	fd843583          	ld	a1,-40(s0)
    5ba8:	00004517          	auipc	a0,0x4
    5bac:	31850513          	addi	a0,a0,792 # 9ec0 <malloc+0x1f88>
    5bb0:	00002097          	auipc	ra,0x2
    5bb4:	196080e7          	jalr	406(ra) # 7d46 <printf>
    exit(1);
    5bb8:	4505                	li	a0,1
    5bba:	00002097          	auipc	ra,0x2
    5bbe:	c5e080e7          	jalr	-930(ra) # 7818 <exit>
  }
  close(fd);
    5bc2:	fe442783          	lw	a5,-28(s0)
    5bc6:	853e                	mv	a0,a5
    5bc8:	00002097          	auipc	ra,0x2
    5bcc:	c78080e7          	jalr	-904(ra) # 7840 <close>
}
    5bd0:	0001                	nop
    5bd2:	70a2                	ld	ra,40(sp)
    5bd4:	7402                	ld	s0,32(sp)
    5bd6:	6145                	addi	sp,sp,48
    5bd8:	8082                	ret

0000000000005bda <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    5bda:	7159                	addi	sp,sp,-112
    5bdc:	f486                	sd	ra,104(sp)
    5bde:	f0a2                	sd	s0,96(sp)
    5be0:	1880                	addi	s0,sp,112
  int nfiles;
  int fsblocks = 0;
    5be2:	fe042423          	sw	zero,-24(s0)

  printf("fsfull test\n");
    5be6:	00004517          	auipc	a0,0x4
    5bea:	2fa50513          	addi	a0,a0,762 # 9ee0 <malloc+0x1fa8>
    5bee:	00002097          	auipc	ra,0x2
    5bf2:	158080e7          	jalr	344(ra) # 7d46 <printf>

  for(nfiles = 0; ; nfiles++){
    5bf6:	fe042623          	sw	zero,-20(s0)
    char name[64];
    name[0] = 'f';
    5bfa:	06600793          	li	a5,102
    5bfe:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    5c02:	fec42703          	lw	a4,-20(s0)
    5c06:	3e800793          	li	a5,1000
    5c0a:	02f747bb          	divw	a5,a4,a5
    5c0e:	2781                	sext.w	a5,a5
    5c10:	0ff7f793          	andi	a5,a5,255
    5c14:	0307879b          	addiw	a5,a5,48
    5c18:	0ff7f793          	andi	a5,a5,255
    5c1c:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5c20:	fec42703          	lw	a4,-20(s0)
    5c24:	3e800793          	li	a5,1000
    5c28:	02f767bb          	remw	a5,a4,a5
    5c2c:	2781                	sext.w	a5,a5
    5c2e:	873e                	mv	a4,a5
    5c30:	06400793          	li	a5,100
    5c34:	02f747bb          	divw	a5,a4,a5
    5c38:	2781                	sext.w	a5,a5
    5c3a:	0ff7f793          	andi	a5,a5,255
    5c3e:	0307879b          	addiw	a5,a5,48
    5c42:	0ff7f793          	andi	a5,a5,255
    5c46:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5c4a:	fec42703          	lw	a4,-20(s0)
    5c4e:	06400793          	li	a5,100
    5c52:	02f767bb          	remw	a5,a4,a5
    5c56:	2781                	sext.w	a5,a5
    5c58:	873e                	mv	a4,a5
    5c5a:	47a9                	li	a5,10
    5c5c:	02f747bb          	divw	a5,a4,a5
    5c60:	2781                	sext.w	a5,a5
    5c62:	0ff7f793          	andi	a5,a5,255
    5c66:	0307879b          	addiw	a5,a5,48
    5c6a:	0ff7f793          	andi	a5,a5,255
    5c6e:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    5c72:	fec42703          	lw	a4,-20(s0)
    5c76:	47a9                	li	a5,10
    5c78:	02f767bb          	remw	a5,a4,a5
    5c7c:	2781                	sext.w	a5,a5
    5c7e:	0ff7f793          	andi	a5,a5,255
    5c82:	0307879b          	addiw	a5,a5,48
    5c86:	0ff7f793          	andi	a5,a5,255
    5c8a:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    5c8e:	f8040ea3          	sb	zero,-99(s0)
    printf("writing %s\n", name);
    5c92:	f9840793          	addi	a5,s0,-104
    5c96:	85be                	mv	a1,a5
    5c98:	00004517          	auipc	a0,0x4
    5c9c:	25850513          	addi	a0,a0,600 # 9ef0 <malloc+0x1fb8>
    5ca0:	00002097          	auipc	ra,0x2
    5ca4:	0a6080e7          	jalr	166(ra) # 7d46 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5ca8:	f9840793          	addi	a5,s0,-104
    5cac:	20200593          	li	a1,514
    5cb0:	853e                	mv	a0,a5
    5cb2:	00002097          	auipc	ra,0x2
    5cb6:	ba6080e7          	jalr	-1114(ra) # 7858 <open>
    5cba:	87aa                	mv	a5,a0
    5cbc:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    5cc0:	fe042783          	lw	a5,-32(s0)
    5cc4:	2781                	sext.w	a5,a5
    5cc6:	0007de63          	bgez	a5,5ce2 <fsfull+0x108>
      printf("open %s failed\n", name);
    5cca:	f9840793          	addi	a5,s0,-104
    5cce:	85be                	mv	a1,a5
    5cd0:	00004517          	auipc	a0,0x4
    5cd4:	23050513          	addi	a0,a0,560 # 9f00 <malloc+0x1fc8>
    5cd8:	00002097          	auipc	ra,0x2
    5cdc:	06e080e7          	jalr	110(ra) # 7d46 <printf>
      break;
    5ce0:	a071                	j	5d6c <fsfull+0x192>
    }
    int total = 0;
    5ce2:	fe042223          	sw	zero,-28(s0)
    while(1){
      int cc = write(fd, buf, BSIZE);
    5ce6:	fe042783          	lw	a5,-32(s0)
    5cea:	40000613          	li	a2,1024
    5cee:	00005597          	auipc	a1,0x5
    5cf2:	76258593          	addi	a1,a1,1890 # b450 <buf>
    5cf6:	853e                	mv	a0,a5
    5cf8:	00002097          	auipc	ra,0x2
    5cfc:	b40080e7          	jalr	-1216(ra) # 7838 <write>
    5d00:	87aa                	mv	a5,a0
    5d02:	fcf42e23          	sw	a5,-36(s0)
      if(cc < BSIZE)
    5d06:	fdc42783          	lw	a5,-36(s0)
    5d0a:	0007871b          	sext.w	a4,a5
    5d0e:	3ff00793          	li	a5,1023
    5d12:	00e7df63          	bge	a5,a4,5d30 <fsfull+0x156>
        break;
      total += cc;
    5d16:	fe442703          	lw	a4,-28(s0)
    5d1a:	fdc42783          	lw	a5,-36(s0)
    5d1e:	9fb9                	addw	a5,a5,a4
    5d20:	fef42223          	sw	a5,-28(s0)
      fsblocks++;
    5d24:	fe842783          	lw	a5,-24(s0)
    5d28:	2785                	addiw	a5,a5,1
    5d2a:	fef42423          	sw	a5,-24(s0)
    while(1){
    5d2e:	bf65                	j	5ce6 <fsfull+0x10c>
        break;
    5d30:	0001                	nop
    }
    printf("wrote %d bytes\n", total);
    5d32:	fe442783          	lw	a5,-28(s0)
    5d36:	85be                	mv	a1,a5
    5d38:	00004517          	auipc	a0,0x4
    5d3c:	1d850513          	addi	a0,a0,472 # 9f10 <malloc+0x1fd8>
    5d40:	00002097          	auipc	ra,0x2
    5d44:	006080e7          	jalr	6(ra) # 7d46 <printf>
    close(fd);
    5d48:	fe042783          	lw	a5,-32(s0)
    5d4c:	853e                	mv	a0,a5
    5d4e:	00002097          	auipc	ra,0x2
    5d52:	af2080e7          	jalr	-1294(ra) # 7840 <close>
    if(total == 0)
    5d56:	fe442783          	lw	a5,-28(s0)
    5d5a:	2781                	sext.w	a5,a5
    5d5c:	c799                	beqz	a5,5d6a <fsfull+0x190>
  for(nfiles = 0; ; nfiles++){
    5d5e:	fec42783          	lw	a5,-20(s0)
    5d62:	2785                	addiw	a5,a5,1
    5d64:	fef42623          	sw	a5,-20(s0)
    5d68:	bd49                	j	5bfa <fsfull+0x20>
      break;
    5d6a:	0001                	nop
  }

  while(nfiles >= 0){
    5d6c:	a84d                	j	5e1e <fsfull+0x244>
    char name[64];
    name[0] = 'f';
    5d6e:	06600793          	li	a5,102
    5d72:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    5d76:	fec42703          	lw	a4,-20(s0)
    5d7a:	3e800793          	li	a5,1000
    5d7e:	02f747bb          	divw	a5,a4,a5
    5d82:	2781                	sext.w	a5,a5
    5d84:	0ff7f793          	andi	a5,a5,255
    5d88:	0307879b          	addiw	a5,a5,48
    5d8c:	0ff7f793          	andi	a5,a5,255
    5d90:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5d94:	fec42703          	lw	a4,-20(s0)
    5d98:	3e800793          	li	a5,1000
    5d9c:	02f767bb          	remw	a5,a4,a5
    5da0:	2781                	sext.w	a5,a5
    5da2:	873e                	mv	a4,a5
    5da4:	06400793          	li	a5,100
    5da8:	02f747bb          	divw	a5,a4,a5
    5dac:	2781                	sext.w	a5,a5
    5dae:	0ff7f793          	andi	a5,a5,255
    5db2:	0307879b          	addiw	a5,a5,48
    5db6:	0ff7f793          	andi	a5,a5,255
    5dba:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5dbe:	fec42703          	lw	a4,-20(s0)
    5dc2:	06400793          	li	a5,100
    5dc6:	02f767bb          	remw	a5,a4,a5
    5dca:	2781                	sext.w	a5,a5
    5dcc:	873e                	mv	a4,a5
    5dce:	47a9                	li	a5,10
    5dd0:	02f747bb          	divw	a5,a4,a5
    5dd4:	2781                	sext.w	a5,a5
    5dd6:	0ff7f793          	andi	a5,a5,255
    5dda:	0307879b          	addiw	a5,a5,48
    5dde:	0ff7f793          	andi	a5,a5,255
    5de2:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    5de6:	fec42703          	lw	a4,-20(s0)
    5dea:	47a9                	li	a5,10
    5dec:	02f767bb          	remw	a5,a4,a5
    5df0:	2781                	sext.w	a5,a5
    5df2:	0ff7f793          	andi	a5,a5,255
    5df6:	0307879b          	addiw	a5,a5,48
    5dfa:	0ff7f793          	andi	a5,a5,255
    5dfe:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    5e02:	f8040ea3          	sb	zero,-99(s0)
    unlink(name);
    5e06:	f9840793          	addi	a5,s0,-104
    5e0a:	853e                	mv	a0,a5
    5e0c:	00002097          	auipc	ra,0x2
    5e10:	a5c080e7          	jalr	-1444(ra) # 7868 <unlink>
    nfiles--;
    5e14:	fec42783          	lw	a5,-20(s0)
    5e18:	37fd                	addiw	a5,a5,-1
    5e1a:	fef42623          	sw	a5,-20(s0)
  while(nfiles >= 0){
    5e1e:	fec42783          	lw	a5,-20(s0)
    5e22:	2781                	sext.w	a5,a5
    5e24:	f407d5e3          	bgez	a5,5d6e <fsfull+0x194>
  }

  printf("fsfull test finished\n");
    5e28:	00004517          	auipc	a0,0x4
    5e2c:	0f850513          	addi	a0,a0,248 # 9f20 <malloc+0x1fe8>
    5e30:	00002097          	auipc	ra,0x2
    5e34:	f16080e7          	jalr	-234(ra) # 7d46 <printf>
}
    5e38:	0001                	nop
    5e3a:	70a6                	ld	ra,104(sp)
    5e3c:	7406                	ld	s0,96(sp)
    5e3e:	6165                	addi	sp,sp,112
    5e40:	8082                	ret

0000000000005e42 <argptest>:

void argptest(char *s)
{
    5e42:	7179                	addi	sp,sp,-48
    5e44:	f406                	sd	ra,40(sp)
    5e46:	f022                	sd	s0,32(sp)
    5e48:	1800                	addi	s0,sp,48
    5e4a:	fca43c23          	sd	a0,-40(s0)
  int fd;
  fd = open("init", O_RDONLY);
    5e4e:	4581                	li	a1,0
    5e50:	00004517          	auipc	a0,0x4
    5e54:	0e850513          	addi	a0,a0,232 # 9f38 <malloc+0x2000>
    5e58:	00002097          	auipc	ra,0x2
    5e5c:	a00080e7          	jalr	-1536(ra) # 7858 <open>
    5e60:	87aa                	mv	a5,a0
    5e62:	fef42623          	sw	a5,-20(s0)
  if (fd < 0) {
    5e66:	fec42783          	lw	a5,-20(s0)
    5e6a:	2781                	sext.w	a5,a5
    5e6c:	0207d163          	bgez	a5,5e8e <argptest+0x4c>
    printf("%s: open failed\n", s);
    5e70:	fd843583          	ld	a1,-40(s0)
    5e74:	00002517          	auipc	a0,0x2
    5e78:	68450513          	addi	a0,a0,1668 # 84f8 <malloc+0x5c0>
    5e7c:	00002097          	auipc	ra,0x2
    5e80:	eca080e7          	jalr	-310(ra) # 7d46 <printf>
    exit(1);
    5e84:	4505                	li	a0,1
    5e86:	00002097          	auipc	ra,0x2
    5e8a:	992080e7          	jalr	-1646(ra) # 7818 <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    5e8e:	4501                	li	a0,0
    5e90:	00002097          	auipc	ra,0x2
    5e94:	a10080e7          	jalr	-1520(ra) # 78a0 <sbrk>
    5e98:	87aa                	mv	a5,a0
    5e9a:	fff78713          	addi	a4,a5,-1
    5e9e:	fec42783          	lw	a5,-20(s0)
    5ea2:	567d                	li	a2,-1
    5ea4:	85ba                	mv	a1,a4
    5ea6:	853e                	mv	a0,a5
    5ea8:	00002097          	auipc	ra,0x2
    5eac:	988080e7          	jalr	-1656(ra) # 7830 <read>
  close(fd);
    5eb0:	fec42783          	lw	a5,-20(s0)
    5eb4:	853e                	mv	a0,a5
    5eb6:	00002097          	auipc	ra,0x2
    5eba:	98a080e7          	jalr	-1654(ra) # 7840 <close>
}
    5ebe:	0001                	nop
    5ec0:	70a2                	ld	ra,40(sp)
    5ec2:	7402                	ld	s0,32(sp)
    5ec4:	6145                	addi	sp,sp,48
    5ec6:	8082                	ret

0000000000005ec8 <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
    5ec8:	7139                	addi	sp,sp,-64
    5eca:	fc06                	sd	ra,56(sp)
    5ecc:	f822                	sd	s0,48(sp)
    5ece:	0080                	addi	s0,sp,64
    5ed0:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;

  pid = fork();
    5ed4:	00002097          	auipc	ra,0x2
    5ed8:	93c080e7          	jalr	-1732(ra) # 7810 <fork>
    5edc:	87aa                	mv	a5,a0
    5ede:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    5ee2:	fec42783          	lw	a5,-20(s0)
    5ee6:	2781                	sext.w	a5,a5
    5ee8:	e3b9                	bnez	a5,5f2e <stacktest+0x66>
    char *sp = (char *) r_sp();
    5eea:	ffffa097          	auipc	ra,0xffffa
    5eee:	116080e7          	jalr	278(ra) # 0 <r_sp>
    5ef2:	87aa                	mv	a5,a0
    5ef4:	fef43023          	sd	a5,-32(s0)
    sp -= PGSIZE;
    5ef8:	fe043703          	ld	a4,-32(s0)
    5efc:	77fd                	lui	a5,0xfffff
    5efe:	97ba                	add	a5,a5,a4
    5f00:	fef43023          	sd	a5,-32(s0)
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    5f04:	fe043783          	ld	a5,-32(s0)
    5f08:	0007c783          	lbu	a5,0(a5) # fffffffffffff000 <freep+0xfffffffffffed388>
    5f0c:	2781                	sext.w	a5,a5
    5f0e:	863e                	mv	a2,a5
    5f10:	fc843583          	ld	a1,-56(s0)
    5f14:	00004517          	auipc	a0,0x4
    5f18:	02c50513          	addi	a0,a0,44 # 9f40 <malloc+0x2008>
    5f1c:	00002097          	auipc	ra,0x2
    5f20:	e2a080e7          	jalr	-470(ra) # 7d46 <printf>
    exit(1);
    5f24:	4505                	li	a0,1
    5f26:	00002097          	auipc	ra,0x2
    5f2a:	8f2080e7          	jalr	-1806(ra) # 7818 <exit>
  } else if(pid < 0){
    5f2e:	fec42783          	lw	a5,-20(s0)
    5f32:	2781                	sext.w	a5,a5
    5f34:	0207d163          	bgez	a5,5f56 <stacktest+0x8e>
    printf("%s: fork failed\n", s);
    5f38:	fc843583          	ld	a1,-56(s0)
    5f3c:	00002517          	auipc	a0,0x2
    5f40:	5a450513          	addi	a0,a0,1444 # 84e0 <malloc+0x5a8>
    5f44:	00002097          	auipc	ra,0x2
    5f48:	e02080e7          	jalr	-510(ra) # 7d46 <printf>
    exit(1);
    5f4c:	4505                	li	a0,1
    5f4e:	00002097          	auipc	ra,0x2
    5f52:	8ca080e7          	jalr	-1846(ra) # 7818 <exit>
  }
  wait(&xstatus);
    5f56:	fdc40793          	addi	a5,s0,-36
    5f5a:	853e                	mv	a0,a5
    5f5c:	00002097          	auipc	ra,0x2
    5f60:	8c4080e7          	jalr	-1852(ra) # 7820 <wait>
  if(xstatus == -1)  // kernel killed child?
    5f64:	fdc42783          	lw	a5,-36(s0)
    5f68:	873e                	mv	a4,a5
    5f6a:	57fd                	li	a5,-1
    5f6c:	00f71763          	bne	a4,a5,5f7a <stacktest+0xb2>
    exit(0);
    5f70:	4501                	li	a0,0
    5f72:	00002097          	auipc	ra,0x2
    5f76:	8a6080e7          	jalr	-1882(ra) # 7818 <exit>
  else
    exit(xstatus);
    5f7a:	fdc42783          	lw	a5,-36(s0)
    5f7e:	853e                	mv	a0,a5
    5f80:	00002097          	auipc	ra,0x2
    5f84:	898080e7          	jalr	-1896(ra) # 7818 <exit>

0000000000005f88 <textwrite>:
}

// check that writes to text segment fault
void
textwrite(char *s)
{
    5f88:	7139                	addi	sp,sp,-64
    5f8a:	fc06                	sd	ra,56(sp)
    5f8c:	f822                	sd	s0,48(sp)
    5f8e:	0080                	addi	s0,sp,64
    5f90:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;

  pid = fork();
    5f94:	00002097          	auipc	ra,0x2
    5f98:	87c080e7          	jalr	-1924(ra) # 7810 <fork>
    5f9c:	87aa                	mv	a5,a0
    5f9e:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    5fa2:	fec42783          	lw	a5,-20(s0)
    5fa6:	2781                	sext.w	a5,a5
    5fa8:	ef81                	bnez	a5,5fc0 <textwrite+0x38>
    volatile int *addr = (int *) 0;
    5faa:	fe043023          	sd	zero,-32(s0)
    *addr = 10;
    5fae:	fe043783          	ld	a5,-32(s0)
    5fb2:	4729                	li	a4,10
    5fb4:	c398                	sw	a4,0(a5)
    exit(1);
    5fb6:	4505                	li	a0,1
    5fb8:	00002097          	auipc	ra,0x2
    5fbc:	860080e7          	jalr	-1952(ra) # 7818 <exit>
  } else if(pid < 0){
    5fc0:	fec42783          	lw	a5,-20(s0)
    5fc4:	2781                	sext.w	a5,a5
    5fc6:	0207d163          	bgez	a5,5fe8 <textwrite+0x60>
    printf("%s: fork failed\n", s);
    5fca:	fc843583          	ld	a1,-56(s0)
    5fce:	00002517          	auipc	a0,0x2
    5fd2:	51250513          	addi	a0,a0,1298 # 84e0 <malloc+0x5a8>
    5fd6:	00002097          	auipc	ra,0x2
    5fda:	d70080e7          	jalr	-656(ra) # 7d46 <printf>
    exit(1);
    5fde:	4505                	li	a0,1
    5fe0:	00002097          	auipc	ra,0x2
    5fe4:	838080e7          	jalr	-1992(ra) # 7818 <exit>
  }
  wait(&xstatus);
    5fe8:	fdc40793          	addi	a5,s0,-36
    5fec:	853e                	mv	a0,a5
    5fee:	00002097          	auipc	ra,0x2
    5ff2:	832080e7          	jalr	-1998(ra) # 7820 <wait>
  if(xstatus == -1)  // kernel killed child?
    5ff6:	fdc42783          	lw	a5,-36(s0)
    5ffa:	873e                	mv	a4,a5
    5ffc:	57fd                	li	a5,-1
    5ffe:	00f71763          	bne	a4,a5,600c <textwrite+0x84>
    exit(0);
    6002:	4501                	li	a0,0
    6004:	00002097          	auipc	ra,0x2
    6008:	814080e7          	jalr	-2028(ra) # 7818 <exit>
  else
    exit(xstatus);
    600c:	fdc42783          	lw	a5,-36(s0)
    6010:	853e                	mv	a0,a5
    6012:	00002097          	auipc	ra,0x2
    6016:	806080e7          	jalr	-2042(ra) # 7818 <exit>

000000000000601a <pgbug>:
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void *big = (void*) 0xeaeb0b5b00002f5e;
void
pgbug(char *s)
{
    601a:	7179                	addi	sp,sp,-48
    601c:	f406                	sd	ra,40(sp)
    601e:	f022                	sd	s0,32(sp)
    6020:	1800                	addi	s0,sp,48
    6022:	fca43c23          	sd	a0,-40(s0)
  char *argv[1];
  argv[0] = 0;
    6026:	fe043423          	sd	zero,-24(s0)
  exec(big, argv);
    602a:	00005797          	auipc	a5,0x5
    602e:	fd678793          	addi	a5,a5,-42 # b000 <big>
    6032:	639c                	ld	a5,0(a5)
    6034:	fe840713          	addi	a4,s0,-24
    6038:	85ba                	mv	a1,a4
    603a:	853e                	mv	a0,a5
    603c:	00002097          	auipc	ra,0x2
    6040:	814080e7          	jalr	-2028(ra) # 7850 <exec>
  pipe(big);
    6044:	00005797          	auipc	a5,0x5
    6048:	fbc78793          	addi	a5,a5,-68 # b000 <big>
    604c:	639c                	ld	a5,0(a5)
    604e:	853e                	mv	a0,a5
    6050:	00001097          	auipc	ra,0x1
    6054:	7d8080e7          	jalr	2008(ra) # 7828 <pipe>

  exit(0);
    6058:	4501                	li	a0,0
    605a:	00001097          	auipc	ra,0x1
    605e:	7be080e7          	jalr	1982(ra) # 7818 <exit>

0000000000006062 <sbrkbugs>:
// regression test. does the kernel panic if a process sbrk()s its
// size to be less than a page, or zero, or reduces the break by an
// amount too small to cause a page to be freed?
void
sbrkbugs(char *s)
{
    6062:	7179                	addi	sp,sp,-48
    6064:	f406                	sd	ra,40(sp)
    6066:	f022                	sd	s0,32(sp)
    6068:	1800                	addi	s0,sp,48
    606a:	fca43c23          	sd	a0,-40(s0)
  int pid = fork();
    606e:	00001097          	auipc	ra,0x1
    6072:	7a2080e7          	jalr	1954(ra) # 7810 <fork>
    6076:	87aa                	mv	a5,a0
    6078:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    607c:	fec42783          	lw	a5,-20(s0)
    6080:	2781                	sext.w	a5,a5
    6082:	0007df63          	bgez	a5,60a0 <sbrkbugs+0x3e>
    printf("fork failed\n");
    6086:	00002517          	auipc	a0,0x2
    608a:	22a50513          	addi	a0,a0,554 # 82b0 <malloc+0x378>
    608e:	00002097          	auipc	ra,0x2
    6092:	cb8080e7          	jalr	-840(ra) # 7d46 <printf>
    exit(1);
    6096:	4505                	li	a0,1
    6098:	00001097          	auipc	ra,0x1
    609c:	780080e7          	jalr	1920(ra) # 7818 <exit>
  }
  if(pid == 0){
    60a0:	fec42783          	lw	a5,-20(s0)
    60a4:	2781                	sext.w	a5,a5
    60a6:	eb85                	bnez	a5,60d6 <sbrkbugs+0x74>
    int sz = (uint64) sbrk(0);
    60a8:	4501                	li	a0,0
    60aa:	00001097          	auipc	ra,0x1
    60ae:	7f6080e7          	jalr	2038(ra) # 78a0 <sbrk>
    60b2:	87aa                	mv	a5,a0
    60b4:	fef42223          	sw	a5,-28(s0)
    // free all user memory; there used to be a bug that
    // would not adjust p->sz correctly in this case,
    // causing exit() to panic.
    sbrk(-sz);
    60b8:	fe442783          	lw	a5,-28(s0)
    60bc:	40f007bb          	negw	a5,a5
    60c0:	2781                	sext.w	a5,a5
    60c2:	853e                	mv	a0,a5
    60c4:	00001097          	auipc	ra,0x1
    60c8:	7dc080e7          	jalr	2012(ra) # 78a0 <sbrk>
    // user page fault here.
    exit(0);
    60cc:	4501                	li	a0,0
    60ce:	00001097          	auipc	ra,0x1
    60d2:	74a080e7          	jalr	1866(ra) # 7818 <exit>
  }
  wait(0);
    60d6:	4501                	li	a0,0
    60d8:	00001097          	auipc	ra,0x1
    60dc:	748080e7          	jalr	1864(ra) # 7820 <wait>

  pid = fork();
    60e0:	00001097          	auipc	ra,0x1
    60e4:	730080e7          	jalr	1840(ra) # 7810 <fork>
    60e8:	87aa                	mv	a5,a0
    60ea:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    60ee:	fec42783          	lw	a5,-20(s0)
    60f2:	2781                	sext.w	a5,a5
    60f4:	0007df63          	bgez	a5,6112 <sbrkbugs+0xb0>
    printf("fork failed\n");
    60f8:	00002517          	auipc	a0,0x2
    60fc:	1b850513          	addi	a0,a0,440 # 82b0 <malloc+0x378>
    6100:	00002097          	auipc	ra,0x2
    6104:	c46080e7          	jalr	-954(ra) # 7d46 <printf>
    exit(1);
    6108:	4505                	li	a0,1
    610a:	00001097          	auipc	ra,0x1
    610e:	70e080e7          	jalr	1806(ra) # 7818 <exit>
  }
  if(pid == 0){
    6112:	fec42783          	lw	a5,-20(s0)
    6116:	2781                	sext.w	a5,a5
    6118:	eb9d                	bnez	a5,614e <sbrkbugs+0xec>
    int sz = (uint64) sbrk(0);
    611a:	4501                	li	a0,0
    611c:	00001097          	auipc	ra,0x1
    6120:	784080e7          	jalr	1924(ra) # 78a0 <sbrk>
    6124:	87aa                	mv	a5,a0
    6126:	fef42423          	sw	a5,-24(s0)
    // set the break to somewhere in the very first
    // page; there used to be a bug that would incorrectly
    // free the first page.
    sbrk(-(sz - 3500));
    612a:	6785                	lui	a5,0x1
    612c:	dac7871b          	addiw	a4,a5,-596
    6130:	fe842783          	lw	a5,-24(s0)
    6134:	40f707bb          	subw	a5,a4,a5
    6138:	2781                	sext.w	a5,a5
    613a:	853e                	mv	a0,a5
    613c:	00001097          	auipc	ra,0x1
    6140:	764080e7          	jalr	1892(ra) # 78a0 <sbrk>
    exit(0);
    6144:	4501                	li	a0,0
    6146:	00001097          	auipc	ra,0x1
    614a:	6d2080e7          	jalr	1746(ra) # 7818 <exit>
  }
  wait(0);
    614e:	4501                	li	a0,0
    6150:	00001097          	auipc	ra,0x1
    6154:	6d0080e7          	jalr	1744(ra) # 7820 <wait>

  pid = fork();
    6158:	00001097          	auipc	ra,0x1
    615c:	6b8080e7          	jalr	1720(ra) # 7810 <fork>
    6160:	87aa                	mv	a5,a0
    6162:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    6166:	fec42783          	lw	a5,-20(s0)
    616a:	2781                	sext.w	a5,a5
    616c:	0007df63          	bgez	a5,618a <sbrkbugs+0x128>
    printf("fork failed\n");
    6170:	00002517          	auipc	a0,0x2
    6174:	14050513          	addi	a0,a0,320 # 82b0 <malloc+0x378>
    6178:	00002097          	auipc	ra,0x2
    617c:	bce080e7          	jalr	-1074(ra) # 7d46 <printf>
    exit(1);
    6180:	4505                	li	a0,1
    6182:	00001097          	auipc	ra,0x1
    6186:	696080e7          	jalr	1686(ra) # 7818 <exit>
  }
  if(pid == 0){
    618a:	fec42783          	lw	a5,-20(s0)
    618e:	2781                	sext.w	a5,a5
    6190:	ef95                	bnez	a5,61cc <sbrkbugs+0x16a>
    // set the break in the middle of a page.
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    6192:	4501                	li	a0,0
    6194:	00001097          	auipc	ra,0x1
    6198:	70c080e7          	jalr	1804(ra) # 78a0 <sbrk>
    619c:	87aa                	mv	a5,a0
    619e:	2781                	sext.w	a5,a5
    61a0:	672d                	lui	a4,0xb
    61a2:	8007071b          	addiw	a4,a4,-2048
    61a6:	40f707bb          	subw	a5,a4,a5
    61aa:	2781                	sext.w	a5,a5
    61ac:	2781                	sext.w	a5,a5
    61ae:	853e                	mv	a0,a5
    61b0:	00001097          	auipc	ra,0x1
    61b4:	6f0080e7          	jalr	1776(ra) # 78a0 <sbrk>

    // reduce the break a bit, but not enough to
    // cause a page to be freed. this used to cause
    // a panic.
    sbrk(-10);
    61b8:	5559                	li	a0,-10
    61ba:	00001097          	auipc	ra,0x1
    61be:	6e6080e7          	jalr	1766(ra) # 78a0 <sbrk>

    exit(0);
    61c2:	4501                	li	a0,0
    61c4:	00001097          	auipc	ra,0x1
    61c8:	654080e7          	jalr	1620(ra) # 7818 <exit>
  }
  wait(0);
    61cc:	4501                	li	a0,0
    61ce:	00001097          	auipc	ra,0x1
    61d2:	652080e7          	jalr	1618(ra) # 7820 <wait>

  exit(0);
    61d6:	4501                	li	a0,0
    61d8:	00001097          	auipc	ra,0x1
    61dc:	640080e7          	jalr	1600(ra) # 7818 <exit>

00000000000061e0 <sbrklast>:
// if process size was somewhat more than a page boundary, and then
// shrunk to be somewhat less than that page boundary, can the kernel
// still copyin() from addresses in the last page?
void
sbrklast(char *s)
{
    61e0:	7139                	addi	sp,sp,-64
    61e2:	fc06                	sd	ra,56(sp)
    61e4:	f822                	sd	s0,48(sp)
    61e6:	0080                	addi	s0,sp,64
    61e8:	fca43423          	sd	a0,-56(s0)
  uint64 top = (uint64) sbrk(0);
    61ec:	4501                	li	a0,0
    61ee:	00001097          	auipc	ra,0x1
    61f2:	6b2080e7          	jalr	1714(ra) # 78a0 <sbrk>
    61f6:	87aa                	mv	a5,a0
    61f8:	fef43423          	sd	a5,-24(s0)
  if((top % 4096) != 0)
    61fc:	fe843703          	ld	a4,-24(s0)
    6200:	6785                	lui	a5,0x1
    6202:	17fd                	addi	a5,a5,-1
    6204:	8ff9                	and	a5,a5,a4
    6206:	c39d                	beqz	a5,622c <sbrklast+0x4c>
    sbrk(4096 - (top % 4096));
    6208:	fe843783          	ld	a5,-24(s0)
    620c:	2781                	sext.w	a5,a5
    620e:	873e                	mv	a4,a5
    6210:	6785                	lui	a5,0x1
    6212:	17fd                	addi	a5,a5,-1
    6214:	8ff9                	and	a5,a5,a4
    6216:	2781                	sext.w	a5,a5
    6218:	6705                	lui	a4,0x1
    621a:	40f707bb          	subw	a5,a4,a5
    621e:	2781                	sext.w	a5,a5
    6220:	2781                	sext.w	a5,a5
    6222:	853e                	mv	a0,a5
    6224:	00001097          	auipc	ra,0x1
    6228:	67c080e7          	jalr	1660(ra) # 78a0 <sbrk>
  sbrk(4096);
    622c:	6505                	lui	a0,0x1
    622e:	00001097          	auipc	ra,0x1
    6232:	672080e7          	jalr	1650(ra) # 78a0 <sbrk>
  sbrk(10);
    6236:	4529                	li	a0,10
    6238:	00001097          	auipc	ra,0x1
    623c:	668080e7          	jalr	1640(ra) # 78a0 <sbrk>
  sbrk(-20);
    6240:	5531                	li	a0,-20
    6242:	00001097          	auipc	ra,0x1
    6246:	65e080e7          	jalr	1630(ra) # 78a0 <sbrk>
  top = (uint64) sbrk(0);
    624a:	4501                	li	a0,0
    624c:	00001097          	auipc	ra,0x1
    6250:	654080e7          	jalr	1620(ra) # 78a0 <sbrk>
    6254:	87aa                	mv	a5,a0
    6256:	fef43423          	sd	a5,-24(s0)
  char *p = (char *) (top - 64);
    625a:	fe843783          	ld	a5,-24(s0)
    625e:	fc078793          	addi	a5,a5,-64 # fc0 <truncate3+0x16a>
    6262:	fef43023          	sd	a5,-32(s0)
  p[0] = 'x';
    6266:	fe043783          	ld	a5,-32(s0)
    626a:	07800713          	li	a4,120
    626e:	00e78023          	sb	a4,0(a5)
  p[1] = '\0';
    6272:	fe043783          	ld	a5,-32(s0)
    6276:	0785                	addi	a5,a5,1
    6278:	00078023          	sb	zero,0(a5)
  int fd = open(p, O_RDWR|O_CREATE);
    627c:	20200593          	li	a1,514
    6280:	fe043503          	ld	a0,-32(s0)
    6284:	00001097          	auipc	ra,0x1
    6288:	5d4080e7          	jalr	1492(ra) # 7858 <open>
    628c:	87aa                	mv	a5,a0
    628e:	fcf42e23          	sw	a5,-36(s0)
  write(fd, p, 1);
    6292:	fdc42783          	lw	a5,-36(s0)
    6296:	4605                	li	a2,1
    6298:	fe043583          	ld	a1,-32(s0)
    629c:	853e                	mv	a0,a5
    629e:	00001097          	auipc	ra,0x1
    62a2:	59a080e7          	jalr	1434(ra) # 7838 <write>
  close(fd);
    62a6:	fdc42783          	lw	a5,-36(s0)
    62aa:	853e                	mv	a0,a5
    62ac:	00001097          	auipc	ra,0x1
    62b0:	594080e7          	jalr	1428(ra) # 7840 <close>
  fd = open(p, O_RDWR);
    62b4:	4589                	li	a1,2
    62b6:	fe043503          	ld	a0,-32(s0)
    62ba:	00001097          	auipc	ra,0x1
    62be:	59e080e7          	jalr	1438(ra) # 7858 <open>
    62c2:	87aa                	mv	a5,a0
    62c4:	fcf42e23          	sw	a5,-36(s0)
  p[0] = '\0';
    62c8:	fe043783          	ld	a5,-32(s0)
    62cc:	00078023          	sb	zero,0(a5)
  read(fd, p, 1);
    62d0:	fdc42783          	lw	a5,-36(s0)
    62d4:	4605                	li	a2,1
    62d6:	fe043583          	ld	a1,-32(s0)
    62da:	853e                	mv	a0,a5
    62dc:	00001097          	auipc	ra,0x1
    62e0:	554080e7          	jalr	1364(ra) # 7830 <read>
  if(p[0] != 'x')
    62e4:	fe043783          	ld	a5,-32(s0)
    62e8:	0007c783          	lbu	a5,0(a5)
    62ec:	873e                	mv	a4,a5
    62ee:	07800793          	li	a5,120
    62f2:	00f70763          	beq	a4,a5,6300 <sbrklast+0x120>
    exit(1);
    62f6:	4505                	li	a0,1
    62f8:	00001097          	auipc	ra,0x1
    62fc:	520080e7          	jalr	1312(ra) # 7818 <exit>
}
    6300:	0001                	nop
    6302:	70e2                	ld	ra,56(sp)
    6304:	7442                	ld	s0,48(sp)
    6306:	6121                	addi	sp,sp,64
    6308:	8082                	ret

000000000000630a <sbrk8000>:

// does sbrk handle signed int32 wrap-around with
// negative arguments?
void
sbrk8000(char *s)
{
    630a:	7179                	addi	sp,sp,-48
    630c:	f406                	sd	ra,40(sp)
    630e:	f022                	sd	s0,32(sp)
    6310:	1800                	addi	s0,sp,48
    6312:	fca43c23          	sd	a0,-40(s0)
  sbrk(0x80000004);
    6316:	800007b7          	lui	a5,0x80000
    631a:	00478513          	addi	a0,a5,4 # ffffffff80000004 <freep+0xffffffff7ffee38c>
    631e:	00001097          	auipc	ra,0x1
    6322:	582080e7          	jalr	1410(ra) # 78a0 <sbrk>
  volatile char *top = sbrk(0);
    6326:	4501                	li	a0,0
    6328:	00001097          	auipc	ra,0x1
    632c:	578080e7          	jalr	1400(ra) # 78a0 <sbrk>
    6330:	fea43423          	sd	a0,-24(s0)
  *(top-1) = *(top-1) + 1;
    6334:	fe843783          	ld	a5,-24(s0)
    6338:	17fd                	addi	a5,a5,-1
    633a:	0007c783          	lbu	a5,0(a5)
    633e:	0ff7f713          	andi	a4,a5,255
    6342:	fe843783          	ld	a5,-24(s0)
    6346:	17fd                	addi	a5,a5,-1
    6348:	2705                	addiw	a4,a4,1
    634a:	0ff77713          	andi	a4,a4,255
    634e:	00e78023          	sb	a4,0(a5)
}
    6352:	0001                	nop
    6354:	70a2                	ld	ra,40(sp)
    6356:	7402                	ld	s0,32(sp)
    6358:	6145                	addi	sp,sp,48
    635a:	8082                	ret

000000000000635c <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    635c:	7139                	addi	sp,sp,-64
    635e:	fc06                	sd	ra,56(sp)
    6360:	f822                	sd	s0,48(sp)
    6362:	0080                	addi	s0,sp,64
    6364:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 50000; i++){
    6368:	fe042623          	sw	zero,-20(s0)
    636c:	a03d                	j	639a <badarg+0x3e>
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    636e:	57fd                	li	a5,-1
    6370:	9381                	srli	a5,a5,0x20
    6372:	fcf43c23          	sd	a5,-40(s0)
    argv[1] = 0;
    6376:	fe043023          	sd	zero,-32(s0)
    exec("echo", argv);
    637a:	fd840793          	addi	a5,s0,-40
    637e:	85be                	mv	a1,a5
    6380:	00002517          	auipc	a0,0x2
    6384:	f4050513          	addi	a0,a0,-192 # 82c0 <malloc+0x388>
    6388:	00001097          	auipc	ra,0x1
    638c:	4c8080e7          	jalr	1224(ra) # 7850 <exec>
  for(int i = 0; i < 50000; i++){
    6390:	fec42783          	lw	a5,-20(s0)
    6394:	2785                	addiw	a5,a5,1
    6396:	fef42623          	sw	a5,-20(s0)
    639a:	fec42783          	lw	a5,-20(s0)
    639e:	0007871b          	sext.w	a4,a5
    63a2:	67b1                	lui	a5,0xc
    63a4:	34f78793          	addi	a5,a5,847 # c34f <buf+0xeff>
    63a8:	fce7d3e3          	bge	a5,a4,636e <badarg+0x12>
  }

  exit(0);
    63ac:	4501                	li	a0,0
    63ae:	00001097          	auipc	ra,0x1
    63b2:	46a080e7          	jalr	1130(ra) # 7818 <exit>

00000000000063b6 <bigdir>:
//

// directory that uses indirect blocks
void
bigdir(char *s)
{
    63b6:	7139                	addi	sp,sp,-64
    63b8:	fc06                	sd	ra,56(sp)
    63ba:	f822                	sd	s0,48(sp)
    63bc:	0080                	addi	s0,sp,64
    63be:	fca43423          	sd	a0,-56(s0)
  enum { N = 500 };
  int i, fd;
  char name[10];

  unlink("bd");
    63c2:	00004517          	auipc	a0,0x4
    63c6:	e7e50513          	addi	a0,a0,-386 # a240 <malloc+0x2308>
    63ca:	00001097          	auipc	ra,0x1
    63ce:	49e080e7          	jalr	1182(ra) # 7868 <unlink>

  fd = open("bd", O_CREATE);
    63d2:	20000593          	li	a1,512
    63d6:	00004517          	auipc	a0,0x4
    63da:	e6a50513          	addi	a0,a0,-406 # a240 <malloc+0x2308>
    63de:	00001097          	auipc	ra,0x1
    63e2:	47a080e7          	jalr	1146(ra) # 7858 <open>
    63e6:	87aa                	mv	a5,a0
    63e8:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    63ec:	fe842783          	lw	a5,-24(s0)
    63f0:	2781                	sext.w	a5,a5
    63f2:	0207d163          	bgez	a5,6414 <bigdir+0x5e>
    printf("%s: bigdir create failed\n", s);
    63f6:	fc843583          	ld	a1,-56(s0)
    63fa:	00004517          	auipc	a0,0x4
    63fe:	e4e50513          	addi	a0,a0,-434 # a248 <malloc+0x2310>
    6402:	00002097          	auipc	ra,0x2
    6406:	944080e7          	jalr	-1724(ra) # 7d46 <printf>
    exit(1);
    640a:	4505                	li	a0,1
    640c:	00001097          	auipc	ra,0x1
    6410:	40c080e7          	jalr	1036(ra) # 7818 <exit>
  }
  close(fd);
    6414:	fe842783          	lw	a5,-24(s0)
    6418:	853e                	mv	a0,a5
    641a:	00001097          	auipc	ra,0x1
    641e:	426080e7          	jalr	1062(ra) # 7840 <close>

  for(i = 0; i < N; i++){
    6422:	fe042623          	sw	zero,-20(s0)
    6426:	a04d                	j	64c8 <bigdir+0x112>
    name[0] = 'x';
    6428:	07800793          	li	a5,120
    642c:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    6430:	fec42783          	lw	a5,-20(s0)
    6434:	41f7d71b          	sraiw	a4,a5,0x1f
    6438:	01a7571b          	srliw	a4,a4,0x1a
    643c:	9fb9                	addw	a5,a5,a4
    643e:	4067d79b          	sraiw	a5,a5,0x6
    6442:	2781                	sext.w	a5,a5
    6444:	0ff7f793          	andi	a5,a5,255
    6448:	0307879b          	addiw	a5,a5,48
    644c:	0ff7f793          	andi	a5,a5,255
    6450:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    6454:	fec42703          	lw	a4,-20(s0)
    6458:	41f7579b          	sraiw	a5,a4,0x1f
    645c:	01a7d79b          	srliw	a5,a5,0x1a
    6460:	9f3d                	addw	a4,a4,a5
    6462:	03f77713          	andi	a4,a4,63
    6466:	40f707bb          	subw	a5,a4,a5
    646a:	2781                	sext.w	a5,a5
    646c:	0ff7f793          	andi	a5,a5,255
    6470:	0307879b          	addiw	a5,a5,48
    6474:	0ff7f793          	andi	a5,a5,255
    6478:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    647c:	fc040da3          	sb	zero,-37(s0)
    if(link("bd", name) != 0){
    6480:	fd840793          	addi	a5,s0,-40
    6484:	85be                	mv	a1,a5
    6486:	00004517          	auipc	a0,0x4
    648a:	dba50513          	addi	a0,a0,-582 # a240 <malloc+0x2308>
    648e:	00001097          	auipc	ra,0x1
    6492:	3ea080e7          	jalr	1002(ra) # 7878 <link>
    6496:	87aa                	mv	a5,a0
    6498:	c39d                	beqz	a5,64be <bigdir+0x108>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    649a:	fd840793          	addi	a5,s0,-40
    649e:	863e                	mv	a2,a5
    64a0:	fc843583          	ld	a1,-56(s0)
    64a4:	00004517          	auipc	a0,0x4
    64a8:	dc450513          	addi	a0,a0,-572 # a268 <malloc+0x2330>
    64ac:	00002097          	auipc	ra,0x2
    64b0:	89a080e7          	jalr	-1894(ra) # 7d46 <printf>
      exit(1);
    64b4:	4505                	li	a0,1
    64b6:	00001097          	auipc	ra,0x1
    64ba:	362080e7          	jalr	866(ra) # 7818 <exit>
  for(i = 0; i < N; i++){
    64be:	fec42783          	lw	a5,-20(s0)
    64c2:	2785                	addiw	a5,a5,1
    64c4:	fef42623          	sw	a5,-20(s0)
    64c8:	fec42783          	lw	a5,-20(s0)
    64cc:	0007871b          	sext.w	a4,a5
    64d0:	1f300793          	li	a5,499
    64d4:	f4e7dae3          	bge	a5,a4,6428 <bigdir+0x72>
    }
  }

  unlink("bd");
    64d8:	00004517          	auipc	a0,0x4
    64dc:	d6850513          	addi	a0,a0,-664 # a240 <malloc+0x2308>
    64e0:	00001097          	auipc	ra,0x1
    64e4:	388080e7          	jalr	904(ra) # 7868 <unlink>
  for(i = 0; i < N; i++){
    64e8:	fe042623          	sw	zero,-20(s0)
    64ec:	a851                	j	6580 <bigdir+0x1ca>
    name[0] = 'x';
    64ee:	07800793          	li	a5,120
    64f2:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    64f6:	fec42783          	lw	a5,-20(s0)
    64fa:	41f7d71b          	sraiw	a4,a5,0x1f
    64fe:	01a7571b          	srliw	a4,a4,0x1a
    6502:	9fb9                	addw	a5,a5,a4
    6504:	4067d79b          	sraiw	a5,a5,0x6
    6508:	2781                	sext.w	a5,a5
    650a:	0ff7f793          	andi	a5,a5,255
    650e:	0307879b          	addiw	a5,a5,48
    6512:	0ff7f793          	andi	a5,a5,255
    6516:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    651a:	fec42703          	lw	a4,-20(s0)
    651e:	41f7579b          	sraiw	a5,a4,0x1f
    6522:	01a7d79b          	srliw	a5,a5,0x1a
    6526:	9f3d                	addw	a4,a4,a5
    6528:	03f77713          	andi	a4,a4,63
    652c:	40f707bb          	subw	a5,a4,a5
    6530:	2781                	sext.w	a5,a5
    6532:	0ff7f793          	andi	a5,a5,255
    6536:	0307879b          	addiw	a5,a5,48
    653a:	0ff7f793          	andi	a5,a5,255
    653e:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    6542:	fc040da3          	sb	zero,-37(s0)
    if(unlink(name) != 0){
    6546:	fd840793          	addi	a5,s0,-40
    654a:	853e                	mv	a0,a5
    654c:	00001097          	auipc	ra,0x1
    6550:	31c080e7          	jalr	796(ra) # 7868 <unlink>
    6554:	87aa                	mv	a5,a0
    6556:	c385                	beqz	a5,6576 <bigdir+0x1c0>
      printf("%s: bigdir unlink failed", s);
    6558:	fc843583          	ld	a1,-56(s0)
    655c:	00004517          	auipc	a0,0x4
    6560:	d2c50513          	addi	a0,a0,-724 # a288 <malloc+0x2350>
    6564:	00001097          	auipc	ra,0x1
    6568:	7e2080e7          	jalr	2018(ra) # 7d46 <printf>
      exit(1);
    656c:	4505                	li	a0,1
    656e:	00001097          	auipc	ra,0x1
    6572:	2aa080e7          	jalr	682(ra) # 7818 <exit>
  for(i = 0; i < N; i++){
    6576:	fec42783          	lw	a5,-20(s0)
    657a:	2785                	addiw	a5,a5,1
    657c:	fef42623          	sw	a5,-20(s0)
    6580:	fec42783          	lw	a5,-20(s0)
    6584:	0007871b          	sext.w	a4,a5
    6588:	1f300793          	li	a5,499
    658c:	f6e7d1e3          	bge	a5,a4,64ee <bigdir+0x138>
    }
  }
}
    6590:	0001                	nop
    6592:	0001                	nop
    6594:	70e2                	ld	ra,56(sp)
    6596:	7442                	ld	s0,48(sp)
    6598:	6121                	addi	sp,sp,64
    659a:	8082                	ret

000000000000659c <manywrites>:

// concurrent writes to try to provoke deadlock in the virtio disk
// driver.
void
manywrites(char *s)
{
    659c:	711d                	addi	sp,sp,-96
    659e:	ec86                	sd	ra,88(sp)
    65a0:	e8a2                	sd	s0,80(sp)
    65a2:	1080                	addi	s0,sp,96
    65a4:	faa43423          	sd	a0,-88(s0)
  int nchildren = 4;
    65a8:	4791                	li	a5,4
    65aa:	fcf42e23          	sw	a5,-36(s0)
  int howmany = 30; // increase to look for deadlock
    65ae:	47f9                	li	a5,30
    65b0:	fcf42c23          	sw	a5,-40(s0)

  for(int ci = 0; ci < nchildren; ci++){
    65b4:	fe042623          	sw	zero,-20(s0)
    65b8:	aa49                	j	674a <manywrites+0x1ae>
    int pid = fork();
    65ba:	00001097          	auipc	ra,0x1
    65be:	256080e7          	jalr	598(ra) # 7810 <fork>
    65c2:	87aa                	mv	a5,a0
    65c4:	fcf42a23          	sw	a5,-44(s0)
    if(pid < 0){
    65c8:	fd442783          	lw	a5,-44(s0)
    65cc:	2781                	sext.w	a5,a5
    65ce:	0007df63          	bgez	a5,65ec <manywrites+0x50>
      printf("fork failed\n");
    65d2:	00002517          	auipc	a0,0x2
    65d6:	cde50513          	addi	a0,a0,-802 # 82b0 <malloc+0x378>
    65da:	00001097          	auipc	ra,0x1
    65de:	76c080e7          	jalr	1900(ra) # 7d46 <printf>
      exit(1);
    65e2:	4505                	li	a0,1
    65e4:	00001097          	auipc	ra,0x1
    65e8:	234080e7          	jalr	564(ra) # 7818 <exit>
    }

    if(pid == 0){
    65ec:	fd442783          	lw	a5,-44(s0)
    65f0:	2781                	sext.w	a5,a5
    65f2:	14079763          	bnez	a5,6740 <manywrites+0x1a4>
      char name[3];
      name[0] = 'b';
    65f6:	06200793          	li	a5,98
    65fa:	fcf40023          	sb	a5,-64(s0)
      name[1] = 'a' + ci;
    65fe:	fec42783          	lw	a5,-20(s0)
    6602:	0ff7f793          	andi	a5,a5,255
    6606:	0617879b          	addiw	a5,a5,97
    660a:	0ff7f793          	andi	a5,a5,255
    660e:	fcf400a3          	sb	a5,-63(s0)
      name[2] = '\0';
    6612:	fc040123          	sb	zero,-62(s0)
      unlink(name);
    6616:	fc040793          	addi	a5,s0,-64
    661a:	853e                	mv	a0,a5
    661c:	00001097          	auipc	ra,0x1
    6620:	24c080e7          	jalr	588(ra) # 7868 <unlink>

      for(int iters = 0; iters < howmany; iters++){
    6624:	fe042423          	sw	zero,-24(s0)
    6628:	a8c5                	j	6718 <manywrites+0x17c>
        for(int i = 0; i < ci+1; i++){
    662a:	fe042223          	sw	zero,-28(s0)
    662e:	a0c9                	j	66f0 <manywrites+0x154>
          int fd = open(name, O_CREATE | O_RDWR);
    6630:	fc040793          	addi	a5,s0,-64
    6634:	20200593          	li	a1,514
    6638:	853e                	mv	a0,a5
    663a:	00001097          	auipc	ra,0x1
    663e:	21e080e7          	jalr	542(ra) # 7858 <open>
    6642:	87aa                	mv	a5,a0
    6644:	fcf42823          	sw	a5,-48(s0)
          if(fd < 0){
    6648:	fd042783          	lw	a5,-48(s0)
    664c:	2781                	sext.w	a5,a5
    664e:	0207d463          	bgez	a5,6676 <manywrites+0xda>
            printf("%s: cannot create %s\n", s, name);
    6652:	fc040793          	addi	a5,s0,-64
    6656:	863e                	mv	a2,a5
    6658:	fa843583          	ld	a1,-88(s0)
    665c:	00004517          	auipc	a0,0x4
    6660:	c4c50513          	addi	a0,a0,-948 # a2a8 <malloc+0x2370>
    6664:	00001097          	auipc	ra,0x1
    6668:	6e2080e7          	jalr	1762(ra) # 7d46 <printf>
            exit(1);
    666c:	4505                	li	a0,1
    666e:	00001097          	auipc	ra,0x1
    6672:	1aa080e7          	jalr	426(ra) # 7818 <exit>
          }
          int sz = sizeof(buf);
    6676:	678d                	lui	a5,0x3
    6678:	fcf42623          	sw	a5,-52(s0)
          int cc = write(fd, buf, sz);
    667c:	fcc42703          	lw	a4,-52(s0)
    6680:	fd042783          	lw	a5,-48(s0)
    6684:	863a                	mv	a2,a4
    6686:	00005597          	auipc	a1,0x5
    668a:	dca58593          	addi	a1,a1,-566 # b450 <buf>
    668e:	853e                	mv	a0,a5
    6690:	00001097          	auipc	ra,0x1
    6694:	1a8080e7          	jalr	424(ra) # 7838 <write>
    6698:	87aa                	mv	a5,a0
    669a:	fcf42423          	sw	a5,-56(s0)
          if(cc != sz){
    669e:	fc842703          	lw	a4,-56(s0)
    66a2:	fcc42783          	lw	a5,-52(s0)
    66a6:	2701                	sext.w	a4,a4
    66a8:	2781                	sext.w	a5,a5
    66aa:	02f70763          	beq	a4,a5,66d8 <manywrites+0x13c>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    66ae:	fc842703          	lw	a4,-56(s0)
    66b2:	fcc42783          	lw	a5,-52(s0)
    66b6:	86ba                	mv	a3,a4
    66b8:	863e                	mv	a2,a5
    66ba:	fa843583          	ld	a1,-88(s0)
    66be:	00003517          	auipc	a0,0x3
    66c2:	e0a50513          	addi	a0,a0,-502 # 94c8 <malloc+0x1590>
    66c6:	00001097          	auipc	ra,0x1
    66ca:	680080e7          	jalr	1664(ra) # 7d46 <printf>
            exit(1);
    66ce:	4505                	li	a0,1
    66d0:	00001097          	auipc	ra,0x1
    66d4:	148080e7          	jalr	328(ra) # 7818 <exit>
          }
          close(fd);
    66d8:	fd042783          	lw	a5,-48(s0)
    66dc:	853e                	mv	a0,a5
    66de:	00001097          	auipc	ra,0x1
    66e2:	162080e7          	jalr	354(ra) # 7840 <close>
        for(int i = 0; i < ci+1; i++){
    66e6:	fe442783          	lw	a5,-28(s0)
    66ea:	2785                	addiw	a5,a5,1
    66ec:	fef42223          	sw	a5,-28(s0)
    66f0:	fec42703          	lw	a4,-20(s0)
    66f4:	fe442783          	lw	a5,-28(s0)
    66f8:	2701                	sext.w	a4,a4
    66fa:	2781                	sext.w	a5,a5
    66fc:	f2f75ae3          	bge	a4,a5,6630 <manywrites+0x94>
        }
        unlink(name);
    6700:	fc040793          	addi	a5,s0,-64
    6704:	853e                	mv	a0,a5
    6706:	00001097          	auipc	ra,0x1
    670a:	162080e7          	jalr	354(ra) # 7868 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    670e:	fe842783          	lw	a5,-24(s0)
    6712:	2785                	addiw	a5,a5,1
    6714:	fef42423          	sw	a5,-24(s0)
    6718:	fe842703          	lw	a4,-24(s0)
    671c:	fd842783          	lw	a5,-40(s0)
    6720:	2701                	sext.w	a4,a4
    6722:	2781                	sext.w	a5,a5
    6724:	f0f743e3          	blt	a4,a5,662a <manywrites+0x8e>
      }

      unlink(name);
    6728:	fc040793          	addi	a5,s0,-64
    672c:	853e                	mv	a0,a5
    672e:	00001097          	auipc	ra,0x1
    6732:	13a080e7          	jalr	314(ra) # 7868 <unlink>
      exit(0);
    6736:	4501                	li	a0,0
    6738:	00001097          	auipc	ra,0x1
    673c:	0e0080e7          	jalr	224(ra) # 7818 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    6740:	fec42783          	lw	a5,-20(s0)
    6744:	2785                	addiw	a5,a5,1
    6746:	fef42623          	sw	a5,-20(s0)
    674a:	fec42703          	lw	a4,-20(s0)
    674e:	fdc42783          	lw	a5,-36(s0)
    6752:	2701                	sext.w	a4,a4
    6754:	2781                	sext.w	a5,a5
    6756:	e6f742e3          	blt	a4,a5,65ba <manywrites+0x1e>
    }
  }

  for(int ci = 0; ci < nchildren; ci++){
    675a:	fe042023          	sw	zero,-32(s0)
    675e:	a80d                	j	6790 <manywrites+0x1f4>
    int st = 0;
    6760:	fa042e23          	sw	zero,-68(s0)
    wait(&st);
    6764:	fbc40793          	addi	a5,s0,-68
    6768:	853e                	mv	a0,a5
    676a:	00001097          	auipc	ra,0x1
    676e:	0b6080e7          	jalr	182(ra) # 7820 <wait>
    if(st != 0)
    6772:	fbc42783          	lw	a5,-68(s0)
    6776:	cb81                	beqz	a5,6786 <manywrites+0x1ea>
      exit(st);
    6778:	fbc42783          	lw	a5,-68(s0)
    677c:	853e                	mv	a0,a5
    677e:	00001097          	auipc	ra,0x1
    6782:	09a080e7          	jalr	154(ra) # 7818 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    6786:	fe042783          	lw	a5,-32(s0)
    678a:	2785                	addiw	a5,a5,1
    678c:	fef42023          	sw	a5,-32(s0)
    6790:	fe042703          	lw	a4,-32(s0)
    6794:	fdc42783          	lw	a5,-36(s0)
    6798:	2701                	sext.w	a4,a4
    679a:	2781                	sext.w	a5,a5
    679c:	fcf742e3          	blt	a4,a5,6760 <manywrites+0x1c4>
  }
  exit(0);
    67a0:	4501                	li	a0,0
    67a2:	00001097          	auipc	ra,0x1
    67a6:	076080e7          	jalr	118(ra) # 7818 <exit>

00000000000067aa <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
    67aa:	7179                	addi	sp,sp,-48
    67ac:	f406                	sd	ra,40(sp)
    67ae:	f022                	sd	s0,32(sp)
    67b0:	1800                	addi	s0,sp,48
    67b2:	fca43c23          	sd	a0,-40(s0)
  int assumed_free = 600;
    67b6:	25800793          	li	a5,600
    67ba:	fef42423          	sw	a5,-24(s0)

  unlink("junk");
    67be:	00004517          	auipc	a0,0x4
    67c2:	b0250513          	addi	a0,a0,-1278 # a2c0 <malloc+0x2388>
    67c6:	00001097          	auipc	ra,0x1
    67ca:	0a2080e7          	jalr	162(ra) # 7868 <unlink>
  for(int i = 0; i < assumed_free; i++){
    67ce:	fe042623          	sw	zero,-20(s0)
    67d2:	a8bd                	j	6850 <badwrite+0xa6>
    int fd = open("junk", O_CREATE|O_WRONLY);
    67d4:	20100593          	li	a1,513
    67d8:	00004517          	auipc	a0,0x4
    67dc:	ae850513          	addi	a0,a0,-1304 # a2c0 <malloc+0x2388>
    67e0:	00001097          	auipc	ra,0x1
    67e4:	078080e7          	jalr	120(ra) # 7858 <open>
    67e8:	87aa                	mv	a5,a0
    67ea:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    67ee:	fe042783          	lw	a5,-32(s0)
    67f2:	2781                	sext.w	a5,a5
    67f4:	0007df63          	bgez	a5,6812 <badwrite+0x68>
      printf("open junk failed\n");
    67f8:	00004517          	auipc	a0,0x4
    67fc:	ad050513          	addi	a0,a0,-1328 # a2c8 <malloc+0x2390>
    6800:	00001097          	auipc	ra,0x1
    6804:	546080e7          	jalr	1350(ra) # 7d46 <printf>
      exit(1);
    6808:	4505                	li	a0,1
    680a:	00001097          	auipc	ra,0x1
    680e:	00e080e7          	jalr	14(ra) # 7818 <exit>
    }
    write(fd, (char*)0xffffffffffL, 1);
    6812:	fe042703          	lw	a4,-32(s0)
    6816:	4605                	li	a2,1
    6818:	57fd                	li	a5,-1
    681a:	0187d593          	srli	a1,a5,0x18
    681e:	853a                	mv	a0,a4
    6820:	00001097          	auipc	ra,0x1
    6824:	018080e7          	jalr	24(ra) # 7838 <write>
    close(fd);
    6828:	fe042783          	lw	a5,-32(s0)
    682c:	853e                	mv	a0,a5
    682e:	00001097          	auipc	ra,0x1
    6832:	012080e7          	jalr	18(ra) # 7840 <close>
    unlink("junk");
    6836:	00004517          	auipc	a0,0x4
    683a:	a8a50513          	addi	a0,a0,-1398 # a2c0 <malloc+0x2388>
    683e:	00001097          	auipc	ra,0x1
    6842:	02a080e7          	jalr	42(ra) # 7868 <unlink>
  for(int i = 0; i < assumed_free; i++){
    6846:	fec42783          	lw	a5,-20(s0)
    684a:	2785                	addiw	a5,a5,1
    684c:	fef42623          	sw	a5,-20(s0)
    6850:	fec42703          	lw	a4,-20(s0)
    6854:	fe842783          	lw	a5,-24(s0)
    6858:	2701                	sext.w	a4,a4
    685a:	2781                	sext.w	a5,a5
    685c:	f6f74ce3          	blt	a4,a5,67d4 <badwrite+0x2a>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
    6860:	20100593          	li	a1,513
    6864:	00004517          	auipc	a0,0x4
    6868:	a5c50513          	addi	a0,a0,-1444 # a2c0 <malloc+0x2388>
    686c:	00001097          	auipc	ra,0x1
    6870:	fec080e7          	jalr	-20(ra) # 7858 <open>
    6874:	87aa                	mv	a5,a0
    6876:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    687a:	fe442783          	lw	a5,-28(s0)
    687e:	2781                	sext.w	a5,a5
    6880:	0007df63          	bgez	a5,689e <badwrite+0xf4>
    printf("open junk failed\n");
    6884:	00004517          	auipc	a0,0x4
    6888:	a4450513          	addi	a0,a0,-1468 # a2c8 <malloc+0x2390>
    688c:	00001097          	auipc	ra,0x1
    6890:	4ba080e7          	jalr	1210(ra) # 7d46 <printf>
    exit(1);
    6894:	4505                	li	a0,1
    6896:	00001097          	auipc	ra,0x1
    689a:	f82080e7          	jalr	-126(ra) # 7818 <exit>
  }
  if(write(fd, "x", 1) != 1){
    689e:	fe442783          	lw	a5,-28(s0)
    68a2:	4605                	li	a2,1
    68a4:	00002597          	auipc	a1,0x2
    68a8:	90c58593          	addi	a1,a1,-1780 # 81b0 <malloc+0x278>
    68ac:	853e                	mv	a0,a5
    68ae:	00001097          	auipc	ra,0x1
    68b2:	f8a080e7          	jalr	-118(ra) # 7838 <write>
    68b6:	87aa                	mv	a5,a0
    68b8:	873e                	mv	a4,a5
    68ba:	4785                	li	a5,1
    68bc:	00f70f63          	beq	a4,a5,68da <badwrite+0x130>
    printf("write failed\n");
    68c0:	00004517          	auipc	a0,0x4
    68c4:	a2050513          	addi	a0,a0,-1504 # a2e0 <malloc+0x23a8>
    68c8:	00001097          	auipc	ra,0x1
    68cc:	47e080e7          	jalr	1150(ra) # 7d46 <printf>
    exit(1);
    68d0:	4505                	li	a0,1
    68d2:	00001097          	auipc	ra,0x1
    68d6:	f46080e7          	jalr	-186(ra) # 7818 <exit>
  }
  close(fd);
    68da:	fe442783          	lw	a5,-28(s0)
    68de:	853e                	mv	a0,a5
    68e0:	00001097          	auipc	ra,0x1
    68e4:	f60080e7          	jalr	-160(ra) # 7840 <close>
  unlink("junk");
    68e8:	00004517          	auipc	a0,0x4
    68ec:	9d850513          	addi	a0,a0,-1576 # a2c0 <malloc+0x2388>
    68f0:	00001097          	auipc	ra,0x1
    68f4:	f78080e7          	jalr	-136(ra) # 7868 <unlink>

  exit(0);
    68f8:	4501                	li	a0,0
    68fa:	00001097          	auipc	ra,0x1
    68fe:	f1e080e7          	jalr	-226(ra) # 7818 <exit>

0000000000006902 <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    6902:	715d                	addi	sp,sp,-80
    6904:	e486                	sd	ra,72(sp)
    6906:	e0a2                	sd	s0,64(sp)
    6908:	0880                	addi	s0,sp,80
    690a:	faa43c23          	sd	a0,-72(s0)
  for(int avail = 0; avail < 15; avail++){
    690e:	fe042623          	sw	zero,-20(s0)
    6912:	a8c5                	j	6a02 <execout+0x100>
    int pid = fork();
    6914:	00001097          	auipc	ra,0x1
    6918:	efc080e7          	jalr	-260(ra) # 7810 <fork>
    691c:	87aa                	mv	a5,a0
    691e:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    6922:	fe442783          	lw	a5,-28(s0)
    6926:	2781                	sext.w	a5,a5
    6928:	0007df63          	bgez	a5,6946 <execout+0x44>
      printf("fork failed\n");
    692c:	00002517          	auipc	a0,0x2
    6930:	98450513          	addi	a0,a0,-1660 # 82b0 <malloc+0x378>
    6934:	00001097          	auipc	ra,0x1
    6938:	412080e7          	jalr	1042(ra) # 7d46 <printf>
      exit(1);
    693c:	4505                	li	a0,1
    693e:	00001097          	auipc	ra,0x1
    6942:	eda080e7          	jalr	-294(ra) # 7818 <exit>
    } else if(pid == 0){
    6946:	fe442783          	lw	a5,-28(s0)
    694a:	2781                	sext.w	a5,a5
    694c:	e3cd                	bnez	a5,69ee <execout+0xec>
      // allocate all of memory.
      while(1){
        uint64 a = (uint64) sbrk(4096);
    694e:	6505                	lui	a0,0x1
    6950:	00001097          	auipc	ra,0x1
    6954:	f50080e7          	jalr	-176(ra) # 78a0 <sbrk>
    6958:	87aa                	mv	a5,a0
    695a:	fcf43c23          	sd	a5,-40(s0)
        if(a == 0xffffffffffffffffLL)
    695e:	fd843703          	ld	a4,-40(s0)
    6962:	57fd                	li	a5,-1
    6964:	00f70c63          	beq	a4,a5,697c <execout+0x7a>
          break;
        *(char*)(a + 4096 - 1) = 1;
    6968:	fd843703          	ld	a4,-40(s0)
    696c:	6785                	lui	a5,0x1
    696e:	17fd                	addi	a5,a5,-1
    6970:	97ba                	add	a5,a5,a4
    6972:	873e                	mv	a4,a5
    6974:	4785                	li	a5,1
    6976:	00f70023          	sb	a5,0(a4) # 1000 <truncate3+0x1aa>
      while(1){
    697a:	bfd1                	j	694e <execout+0x4c>
          break;
    697c:	0001                	nop
      }

      // free a few pages, in order to let exec() make some
      // progress.
      for(int i = 0; i < avail; i++)
    697e:	fe042423          	sw	zero,-24(s0)
    6982:	a819                	j	6998 <execout+0x96>
        sbrk(-4096);
    6984:	757d                	lui	a0,0xfffff
    6986:	00001097          	auipc	ra,0x1
    698a:	f1a080e7          	jalr	-230(ra) # 78a0 <sbrk>
      for(int i = 0; i < avail; i++)
    698e:	fe842783          	lw	a5,-24(s0)
    6992:	2785                	addiw	a5,a5,1
    6994:	fef42423          	sw	a5,-24(s0)
    6998:	fe842703          	lw	a4,-24(s0)
    699c:	fec42783          	lw	a5,-20(s0)
    69a0:	2701                	sext.w	a4,a4
    69a2:	2781                	sext.w	a5,a5
    69a4:	fef740e3          	blt	a4,a5,6984 <execout+0x82>

      close(1);
    69a8:	4505                	li	a0,1
    69aa:	00001097          	auipc	ra,0x1
    69ae:	e96080e7          	jalr	-362(ra) # 7840 <close>
      char *args[] = { "echo", "x", 0 };
    69b2:	00002797          	auipc	a5,0x2
    69b6:	90e78793          	addi	a5,a5,-1778 # 82c0 <malloc+0x388>
    69ba:	fcf43023          	sd	a5,-64(s0)
    69be:	00001797          	auipc	a5,0x1
    69c2:	7f278793          	addi	a5,a5,2034 # 81b0 <malloc+0x278>
    69c6:	fcf43423          	sd	a5,-56(s0)
    69ca:	fc043823          	sd	zero,-48(s0)
      exec("echo", args);
    69ce:	fc040793          	addi	a5,s0,-64
    69d2:	85be                	mv	a1,a5
    69d4:	00002517          	auipc	a0,0x2
    69d8:	8ec50513          	addi	a0,a0,-1812 # 82c0 <malloc+0x388>
    69dc:	00001097          	auipc	ra,0x1
    69e0:	e74080e7          	jalr	-396(ra) # 7850 <exec>
      exit(0);
    69e4:	4501                	li	a0,0
    69e6:	00001097          	auipc	ra,0x1
    69ea:	e32080e7          	jalr	-462(ra) # 7818 <exit>
    } else {
      wait((int*)0);
    69ee:	4501                	li	a0,0
    69f0:	00001097          	auipc	ra,0x1
    69f4:	e30080e7          	jalr	-464(ra) # 7820 <wait>
  for(int avail = 0; avail < 15; avail++){
    69f8:	fec42783          	lw	a5,-20(s0)
    69fc:	2785                	addiw	a5,a5,1
    69fe:	fef42623          	sw	a5,-20(s0)
    6a02:	fec42783          	lw	a5,-20(s0)
    6a06:	0007871b          	sext.w	a4,a5
    6a0a:	47b9                	li	a5,14
    6a0c:	f0e7d4e3          	bge	a5,a4,6914 <execout+0x12>
    }
  }

  exit(0);
    6a10:	4501                	li	a0,0
    6a12:	00001097          	auipc	ra,0x1
    6a16:	e06080e7          	jalr	-506(ra) # 7818 <exit>

0000000000006a1a <diskfull>:
}

// can the kernel tolerate running out of disk space?
void
diskfull(char *s)
{
    6a1a:	b9010113          	addi	sp,sp,-1136
    6a1e:	46113423          	sd	ra,1128(sp)
    6a22:	46813023          	sd	s0,1120(sp)
    6a26:	47010413          	addi	s0,sp,1136
    6a2a:	b8a43c23          	sd	a0,-1128(s0)
  int fi;
  int done = 0;
    6a2e:	fe042423          	sw	zero,-24(s0)

  unlink("diskfulldir");
    6a32:	00004517          	auipc	a0,0x4
    6a36:	8be50513          	addi	a0,a0,-1858 # a2f0 <malloc+0x23b8>
    6a3a:	00001097          	auipc	ra,0x1
    6a3e:	e2e080e7          	jalr	-466(ra) # 7868 <unlink>

  for(fi = 0; done == 0; fi++){
    6a42:	fe042623          	sw	zero,-20(s0)
    6a46:	a8d5                	j	6b3a <diskfull+0x120>
    char name[32];
    name[0] = 'b';
    6a48:	06200793          	li	a5,98
    6a4c:	baf40423          	sb	a5,-1112(s0)
    name[1] = 'i';
    6a50:	06900793          	li	a5,105
    6a54:	baf404a3          	sb	a5,-1111(s0)
    name[2] = 'g';
    6a58:	06700793          	li	a5,103
    6a5c:	baf40523          	sb	a5,-1110(s0)
    name[3] = '0' + fi;
    6a60:	fec42783          	lw	a5,-20(s0)
    6a64:	0ff7f793          	andi	a5,a5,255
    6a68:	0307879b          	addiw	a5,a5,48
    6a6c:	0ff7f793          	andi	a5,a5,255
    6a70:	baf405a3          	sb	a5,-1109(s0)
    name[4] = '\0';
    6a74:	ba040623          	sb	zero,-1108(s0)
    unlink(name);
    6a78:	ba840793          	addi	a5,s0,-1112
    6a7c:	853e                	mv	a0,a5
    6a7e:	00001097          	auipc	ra,0x1
    6a82:	dea080e7          	jalr	-534(ra) # 7868 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    6a86:	ba840793          	addi	a5,s0,-1112
    6a8a:	60200593          	li	a1,1538
    6a8e:	853e                	mv	a0,a5
    6a90:	00001097          	auipc	ra,0x1
    6a94:	dc8080e7          	jalr	-568(ra) # 7858 <open>
    6a98:	87aa                	mv	a5,a0
    6a9a:	fcf42a23          	sw	a5,-44(s0)
    if(fd < 0){
    6a9e:	fd442783          	lw	a5,-44(s0)
    6aa2:	2781                	sext.w	a5,a5
    6aa4:	0207d363          	bgez	a5,6aca <diskfull+0xb0>
      // oops, ran out of inodes before running out of blocks.
      printf("%s: could not create file %s\n", s, name);
    6aa8:	ba840793          	addi	a5,s0,-1112
    6aac:	863e                	mv	a2,a5
    6aae:	b9843583          	ld	a1,-1128(s0)
    6ab2:	00004517          	auipc	a0,0x4
    6ab6:	84e50513          	addi	a0,a0,-1970 # a300 <malloc+0x23c8>
    6aba:	00001097          	auipc	ra,0x1
    6abe:	28c080e7          	jalr	652(ra) # 7d46 <printf>
      done = 1;
    6ac2:	4785                	li	a5,1
    6ac4:	fef42423          	sw	a5,-24(s0)
    6ac8:	a8ad                	j	6b42 <diskfull+0x128>
      break;
    }
    for(int i = 0; i < MAXFILE; i++){
    6aca:	fe042223          	sw	zero,-28(s0)
    6ace:	a099                	j	6b14 <diskfull+0xfa>
      char buf[BSIZE];
      if(write(fd, buf, BSIZE) != BSIZE){
    6ad0:	bc840713          	addi	a4,s0,-1080
    6ad4:	fd442783          	lw	a5,-44(s0)
    6ad8:	40000613          	li	a2,1024
    6adc:	85ba                	mv	a1,a4
    6ade:	853e                	mv	a0,a5
    6ae0:	00001097          	auipc	ra,0x1
    6ae4:	d58080e7          	jalr	-680(ra) # 7838 <write>
    6ae8:	87aa                	mv	a5,a0
    6aea:	873e                	mv	a4,a5
    6aec:	40000793          	li	a5,1024
    6af0:	00f70d63          	beq	a4,a5,6b0a <diskfull+0xf0>
        done = 1;
    6af4:	4785                	li	a5,1
    6af6:	fef42423          	sw	a5,-24(s0)
        close(fd);
    6afa:	fd442783          	lw	a5,-44(s0)
    6afe:	853e                	mv	a0,a5
    6b00:	00001097          	auipc	ra,0x1
    6b04:	d40080e7          	jalr	-704(ra) # 7840 <close>
    6b08:	a829                	j	6b22 <diskfull+0x108>
    for(int i = 0; i < MAXFILE; i++){
    6b0a:	fe442783          	lw	a5,-28(s0)
    6b0e:	2785                	addiw	a5,a5,1
    6b10:	fef42223          	sw	a5,-28(s0)
    6b14:	fe442783          	lw	a5,-28(s0)
    6b18:	873e                	mv	a4,a5
    6b1a:	10b00793          	li	a5,267
    6b1e:	fae7f9e3          	bgeu	a5,a4,6ad0 <diskfull+0xb6>
        break;
      }
    }
    close(fd);
    6b22:	fd442783          	lw	a5,-44(s0)
    6b26:	853e                	mv	a0,a5
    6b28:	00001097          	auipc	ra,0x1
    6b2c:	d18080e7          	jalr	-744(ra) # 7840 <close>
  for(fi = 0; done == 0; fi++){
    6b30:	fec42783          	lw	a5,-20(s0)
    6b34:	2785                	addiw	a5,a5,1
    6b36:	fef42623          	sw	a5,-20(s0)
    6b3a:	fe842783          	lw	a5,-24(s0)
    6b3e:	2781                	sext.w	a5,a5
    6b40:	d781                	beqz	a5,6a48 <diskfull+0x2e>

  // now that there are no free blocks, test that dirlink()
  // merely fails (doesn't panic) if it can't extend
  // directory content. one of these file creations
  // is expected to fail.
  int nzz = 128;
    6b42:	08000793          	li	a5,128
    6b46:	fcf42823          	sw	a5,-48(s0)
  for(int i = 0; i < nzz; i++){
    6b4a:	fe042023          	sw	zero,-32(s0)
    6b4e:	a065                	j	6bf6 <diskfull+0x1dc>
    char name[32];
    name[0] = 'z';
    6b50:	07a00793          	li	a5,122
    6b54:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'z';
    6b58:	07a00793          	li	a5,122
    6b5c:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = '0' + (i / 32);
    6b60:	fe042783          	lw	a5,-32(s0)
    6b64:	41f7d71b          	sraiw	a4,a5,0x1f
    6b68:	01b7571b          	srliw	a4,a4,0x1b
    6b6c:	9fb9                	addw	a5,a5,a4
    6b6e:	4057d79b          	sraiw	a5,a5,0x5
    6b72:	2781                	sext.w	a5,a5
    6b74:	0ff7f793          	andi	a5,a5,255
    6b78:	0307879b          	addiw	a5,a5,48
    6b7c:	0ff7f793          	andi	a5,a5,255
    6b80:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + (i % 32);
    6b84:	fe042703          	lw	a4,-32(s0)
    6b88:	41f7579b          	sraiw	a5,a4,0x1f
    6b8c:	01b7d79b          	srliw	a5,a5,0x1b
    6b90:	9f3d                	addw	a4,a4,a5
    6b92:	8b7d                	andi	a4,a4,31
    6b94:	40f707bb          	subw	a5,a4,a5
    6b98:	2781                	sext.w	a5,a5
    6b9a:	0ff7f793          	andi	a5,a5,255
    6b9e:	0307879b          	addiw	a5,a5,48
    6ba2:	0ff7f793          	andi	a5,a5,255
    6ba6:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    6baa:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    6bae:	bc840793          	addi	a5,s0,-1080
    6bb2:	853e                	mv	a0,a5
    6bb4:	00001097          	auipc	ra,0x1
    6bb8:	cb4080e7          	jalr	-844(ra) # 7868 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    6bbc:	bc840793          	addi	a5,s0,-1080
    6bc0:	60200593          	li	a1,1538
    6bc4:	853e                	mv	a0,a5
    6bc6:	00001097          	auipc	ra,0x1
    6bca:	c92080e7          	jalr	-878(ra) # 7858 <open>
    6bce:	87aa                	mv	a5,a0
    6bd0:	fcf42623          	sw	a5,-52(s0)
    if(fd < 0)
    6bd4:	fcc42783          	lw	a5,-52(s0)
    6bd8:	2781                	sext.w	a5,a5
    6bda:	0207c763          	bltz	a5,6c08 <diskfull+0x1ee>
      break;
    close(fd);
    6bde:	fcc42783          	lw	a5,-52(s0)
    6be2:	853e                	mv	a0,a5
    6be4:	00001097          	auipc	ra,0x1
    6be8:	c5c080e7          	jalr	-932(ra) # 7840 <close>
  for(int i = 0; i < nzz; i++){
    6bec:	fe042783          	lw	a5,-32(s0)
    6bf0:	2785                	addiw	a5,a5,1
    6bf2:	fef42023          	sw	a5,-32(s0)
    6bf6:	fe042703          	lw	a4,-32(s0)
    6bfa:	fd042783          	lw	a5,-48(s0)
    6bfe:	2701                	sext.w	a4,a4
    6c00:	2781                	sext.w	a5,a5
    6c02:	f4f747e3          	blt	a4,a5,6b50 <diskfull+0x136>
    6c06:	a011                	j	6c0a <diskfull+0x1f0>
      break;
    6c08:	0001                	nop
  }

  // this mkdir() is expected to fail.
  if(mkdir("diskfulldir") == 0)
    6c0a:	00003517          	auipc	a0,0x3
    6c0e:	6e650513          	addi	a0,a0,1766 # a2f0 <malloc+0x23b8>
    6c12:	00001097          	auipc	ra,0x1
    6c16:	c6e080e7          	jalr	-914(ra) # 7880 <mkdir>
    6c1a:	87aa                	mv	a5,a0
    6c1c:	eb89                	bnez	a5,6c2e <diskfull+0x214>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    6c1e:	00003517          	auipc	a0,0x3
    6c22:	70250513          	addi	a0,a0,1794 # a320 <malloc+0x23e8>
    6c26:	00001097          	auipc	ra,0x1
    6c2a:	120080e7          	jalr	288(ra) # 7d46 <printf>

  unlink("diskfulldir");
    6c2e:	00003517          	auipc	a0,0x3
    6c32:	6c250513          	addi	a0,a0,1730 # a2f0 <malloc+0x23b8>
    6c36:	00001097          	auipc	ra,0x1
    6c3a:	c32080e7          	jalr	-974(ra) # 7868 <unlink>

  for(int i = 0; i < nzz; i++){
    6c3e:	fc042e23          	sw	zero,-36(s0)
    6c42:	a8a5                	j	6cba <diskfull+0x2a0>
    char name[32];
    name[0] = 'z';
    6c44:	07a00793          	li	a5,122
    6c48:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'z';
    6c4c:	07a00793          	li	a5,122
    6c50:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = '0' + (i / 32);
    6c54:	fdc42783          	lw	a5,-36(s0)
    6c58:	41f7d71b          	sraiw	a4,a5,0x1f
    6c5c:	01b7571b          	srliw	a4,a4,0x1b
    6c60:	9fb9                	addw	a5,a5,a4
    6c62:	4057d79b          	sraiw	a5,a5,0x5
    6c66:	2781                	sext.w	a5,a5
    6c68:	0ff7f793          	andi	a5,a5,255
    6c6c:	0307879b          	addiw	a5,a5,48
    6c70:	0ff7f793          	andi	a5,a5,255
    6c74:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + (i % 32);
    6c78:	fdc42703          	lw	a4,-36(s0)
    6c7c:	41f7579b          	sraiw	a5,a4,0x1f
    6c80:	01b7d79b          	srliw	a5,a5,0x1b
    6c84:	9f3d                	addw	a4,a4,a5
    6c86:	8b7d                	andi	a4,a4,31
    6c88:	40f707bb          	subw	a5,a4,a5
    6c8c:	2781                	sext.w	a5,a5
    6c8e:	0ff7f793          	andi	a5,a5,255
    6c92:	0307879b          	addiw	a5,a5,48
    6c96:	0ff7f793          	andi	a5,a5,255
    6c9a:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    6c9e:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    6ca2:	bc840793          	addi	a5,s0,-1080
    6ca6:	853e                	mv	a0,a5
    6ca8:	00001097          	auipc	ra,0x1
    6cac:	bc0080e7          	jalr	-1088(ra) # 7868 <unlink>
  for(int i = 0; i < nzz; i++){
    6cb0:	fdc42783          	lw	a5,-36(s0)
    6cb4:	2785                	addiw	a5,a5,1
    6cb6:	fcf42e23          	sw	a5,-36(s0)
    6cba:	fdc42703          	lw	a4,-36(s0)
    6cbe:	fd042783          	lw	a5,-48(s0)
    6cc2:	2701                	sext.w	a4,a4
    6cc4:	2781                	sext.w	a5,a5
    6cc6:	f6f74fe3          	blt	a4,a5,6c44 <diskfull+0x22a>
  }

  for(int i = 0; i < fi; i++){
    6cca:	fc042c23          	sw	zero,-40(s0)
    6cce:	a0a9                	j	6d18 <diskfull+0x2fe>
    char name[32];
    name[0] = 'b';
    6cd0:	06200793          	li	a5,98
    6cd4:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'i';
    6cd8:	06900793          	li	a5,105
    6cdc:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = 'g';
    6ce0:	06700793          	li	a5,103
    6ce4:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + i;
    6ce8:	fd842783          	lw	a5,-40(s0)
    6cec:	0ff7f793          	andi	a5,a5,255
    6cf0:	0307879b          	addiw	a5,a5,48
    6cf4:	0ff7f793          	andi	a5,a5,255
    6cf8:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    6cfc:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    6d00:	bc840793          	addi	a5,s0,-1080
    6d04:	853e                	mv	a0,a5
    6d06:	00001097          	auipc	ra,0x1
    6d0a:	b62080e7          	jalr	-1182(ra) # 7868 <unlink>
  for(int i = 0; i < fi; i++){
    6d0e:	fd842783          	lw	a5,-40(s0)
    6d12:	2785                	addiw	a5,a5,1
    6d14:	fcf42c23          	sw	a5,-40(s0)
    6d18:	fd842703          	lw	a4,-40(s0)
    6d1c:	fec42783          	lw	a5,-20(s0)
    6d20:	2701                	sext.w	a4,a4
    6d22:	2781                	sext.w	a5,a5
    6d24:	faf746e3          	blt	a4,a5,6cd0 <diskfull+0x2b6>
  }
}
    6d28:	0001                	nop
    6d2a:	0001                	nop
    6d2c:	46813083          	ld	ra,1128(sp)
    6d30:	46013403          	ld	s0,1120(sp)
    6d34:	47010113          	addi	sp,sp,1136
    6d38:	8082                	ret

0000000000006d3a <outofinodes>:

void
outofinodes(char *s)
{
    6d3a:	715d                	addi	sp,sp,-80
    6d3c:	e486                	sd	ra,72(sp)
    6d3e:	e0a2                	sd	s0,64(sp)
    6d40:	0880                	addi	s0,sp,80
    6d42:	faa43c23          	sd	a0,-72(s0)
  int nzz = 32*32;
    6d46:	40000793          	li	a5,1024
    6d4a:	fef42223          	sw	a5,-28(s0)
  for(int i = 0; i < nzz; i++){
    6d4e:	fe042623          	sw	zero,-20(s0)
    6d52:	a065                	j	6dfa <outofinodes+0xc0>
    char name[32];
    name[0] = 'z';
    6d54:	07a00793          	li	a5,122
    6d58:	fcf40023          	sb	a5,-64(s0)
    name[1] = 'z';
    6d5c:	07a00793          	li	a5,122
    6d60:	fcf400a3          	sb	a5,-63(s0)
    name[2] = '0' + (i / 32);
    6d64:	fec42783          	lw	a5,-20(s0)
    6d68:	41f7d71b          	sraiw	a4,a5,0x1f
    6d6c:	01b7571b          	srliw	a4,a4,0x1b
    6d70:	9fb9                	addw	a5,a5,a4
    6d72:	4057d79b          	sraiw	a5,a5,0x5
    6d76:	2781                	sext.w	a5,a5
    6d78:	0ff7f793          	andi	a5,a5,255
    6d7c:	0307879b          	addiw	a5,a5,48
    6d80:	0ff7f793          	andi	a5,a5,255
    6d84:	fcf40123          	sb	a5,-62(s0)
    name[3] = '0' + (i % 32);
    6d88:	fec42703          	lw	a4,-20(s0)
    6d8c:	41f7579b          	sraiw	a5,a4,0x1f
    6d90:	01b7d79b          	srliw	a5,a5,0x1b
    6d94:	9f3d                	addw	a4,a4,a5
    6d96:	8b7d                	andi	a4,a4,31
    6d98:	40f707bb          	subw	a5,a4,a5
    6d9c:	2781                	sext.w	a5,a5
    6d9e:	0ff7f793          	andi	a5,a5,255
    6da2:	0307879b          	addiw	a5,a5,48
    6da6:	0ff7f793          	andi	a5,a5,255
    6daa:	fcf401a3          	sb	a5,-61(s0)
    name[4] = '\0';
    6dae:	fc040223          	sb	zero,-60(s0)
    unlink(name);
    6db2:	fc040793          	addi	a5,s0,-64
    6db6:	853e                	mv	a0,a5
    6db8:	00001097          	auipc	ra,0x1
    6dbc:	ab0080e7          	jalr	-1360(ra) # 7868 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    6dc0:	fc040793          	addi	a5,s0,-64
    6dc4:	60200593          	li	a1,1538
    6dc8:	853e                	mv	a0,a5
    6dca:	00001097          	auipc	ra,0x1
    6dce:	a8e080e7          	jalr	-1394(ra) # 7858 <open>
    6dd2:	87aa                	mv	a5,a0
    6dd4:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    6dd8:	fe042783          	lw	a5,-32(s0)
    6ddc:	2781                	sext.w	a5,a5
    6dde:	0207c763          	bltz	a5,6e0c <outofinodes+0xd2>
      // failure is eventually expected.
      break;
    }
    close(fd);
    6de2:	fe042783          	lw	a5,-32(s0)
    6de6:	853e                	mv	a0,a5
    6de8:	00001097          	auipc	ra,0x1
    6dec:	a58080e7          	jalr	-1448(ra) # 7840 <close>
  for(int i = 0; i < nzz; i++){
    6df0:	fec42783          	lw	a5,-20(s0)
    6df4:	2785                	addiw	a5,a5,1
    6df6:	fef42623          	sw	a5,-20(s0)
    6dfa:	fec42703          	lw	a4,-20(s0)
    6dfe:	fe442783          	lw	a5,-28(s0)
    6e02:	2701                	sext.w	a4,a4
    6e04:	2781                	sext.w	a5,a5
    6e06:	f4f747e3          	blt	a4,a5,6d54 <outofinodes+0x1a>
    6e0a:	a011                	j	6e0e <outofinodes+0xd4>
      break;
    6e0c:	0001                	nop
  }

  for(int i = 0; i < nzz; i++){
    6e0e:	fe042423          	sw	zero,-24(s0)
    6e12:	a8a5                	j	6e8a <outofinodes+0x150>
    char name[32];
    name[0] = 'z';
    6e14:	07a00793          	li	a5,122
    6e18:	fcf40023          	sb	a5,-64(s0)
    name[1] = 'z';
    6e1c:	07a00793          	li	a5,122
    6e20:	fcf400a3          	sb	a5,-63(s0)
    name[2] = '0' + (i / 32);
    6e24:	fe842783          	lw	a5,-24(s0)
    6e28:	41f7d71b          	sraiw	a4,a5,0x1f
    6e2c:	01b7571b          	srliw	a4,a4,0x1b
    6e30:	9fb9                	addw	a5,a5,a4
    6e32:	4057d79b          	sraiw	a5,a5,0x5
    6e36:	2781                	sext.w	a5,a5
    6e38:	0ff7f793          	andi	a5,a5,255
    6e3c:	0307879b          	addiw	a5,a5,48
    6e40:	0ff7f793          	andi	a5,a5,255
    6e44:	fcf40123          	sb	a5,-62(s0)
    name[3] = '0' + (i % 32);
    6e48:	fe842703          	lw	a4,-24(s0)
    6e4c:	41f7579b          	sraiw	a5,a4,0x1f
    6e50:	01b7d79b          	srliw	a5,a5,0x1b
    6e54:	9f3d                	addw	a4,a4,a5
    6e56:	8b7d                	andi	a4,a4,31
    6e58:	40f707bb          	subw	a5,a4,a5
    6e5c:	2781                	sext.w	a5,a5
    6e5e:	0ff7f793          	andi	a5,a5,255
    6e62:	0307879b          	addiw	a5,a5,48
    6e66:	0ff7f793          	andi	a5,a5,255
    6e6a:	fcf401a3          	sb	a5,-61(s0)
    name[4] = '\0';
    6e6e:	fc040223          	sb	zero,-60(s0)
    unlink(name);
    6e72:	fc040793          	addi	a5,s0,-64
    6e76:	853e                	mv	a0,a5
    6e78:	00001097          	auipc	ra,0x1
    6e7c:	9f0080e7          	jalr	-1552(ra) # 7868 <unlink>
  for(int i = 0; i < nzz; i++){
    6e80:	fe842783          	lw	a5,-24(s0)
    6e84:	2785                	addiw	a5,a5,1
    6e86:	fef42423          	sw	a5,-24(s0)
    6e8a:	fe842703          	lw	a4,-24(s0)
    6e8e:	fe442783          	lw	a5,-28(s0)
    6e92:	2701                	sext.w	a4,a4
    6e94:	2781                	sext.w	a5,a5
    6e96:	f6f74fe3          	blt	a4,a5,6e14 <outofinodes+0xda>
  }
}
    6e9a:	0001                	nop
    6e9c:	0001                	nop
    6e9e:	60a6                	ld	ra,72(sp)
    6ea0:	6406                	ld	s0,64(sp)
    6ea2:	6161                	addi	sp,sp,80
    6ea4:	8082                	ret

0000000000006ea6 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    6ea6:	7179                	addi	sp,sp,-48
    6ea8:	f406                	sd	ra,40(sp)
    6eaa:	f022                	sd	s0,32(sp)
    6eac:	1800                	addi	s0,sp,48
    6eae:	fca43c23          	sd	a0,-40(s0)
    6eb2:	fcb43823          	sd	a1,-48(s0)
  int pid;
  int xstatus;

  printf("test %s: ", s);
    6eb6:	fd043583          	ld	a1,-48(s0)
    6eba:	00003517          	auipc	a0,0x3
    6ebe:	4e650513          	addi	a0,a0,1254 # a3a0 <malloc+0x2468>
    6ec2:	00001097          	auipc	ra,0x1
    6ec6:	e84080e7          	jalr	-380(ra) # 7d46 <printf>
  if((pid = fork()) < 0) {
    6eca:	00001097          	auipc	ra,0x1
    6ece:	946080e7          	jalr	-1722(ra) # 7810 <fork>
    6ed2:	87aa                	mv	a5,a0
    6ed4:	fef42623          	sw	a5,-20(s0)
    6ed8:	fec42783          	lw	a5,-20(s0)
    6edc:	2781                	sext.w	a5,a5
    6ede:	0007df63          	bgez	a5,6efc <run+0x56>
    printf("runtest: fork error\n");
    6ee2:	00003517          	auipc	a0,0x3
    6ee6:	4ce50513          	addi	a0,a0,1230 # a3b0 <malloc+0x2478>
    6eea:	00001097          	auipc	ra,0x1
    6eee:	e5c080e7          	jalr	-420(ra) # 7d46 <printf>
    exit(1);
    6ef2:	4505                	li	a0,1
    6ef4:	00001097          	auipc	ra,0x1
    6ef8:	924080e7          	jalr	-1756(ra) # 7818 <exit>
  }
  if(pid == 0) {
    6efc:	fec42783          	lw	a5,-20(s0)
    6f00:	2781                	sext.w	a5,a5
    6f02:	eb99                	bnez	a5,6f18 <run+0x72>
    f(s);
    6f04:	fd843783          	ld	a5,-40(s0)
    6f08:	fd043503          	ld	a0,-48(s0)
    6f0c:	9782                	jalr	a5
    exit(0);
    6f0e:	4501                	li	a0,0
    6f10:	00001097          	auipc	ra,0x1
    6f14:	908080e7          	jalr	-1784(ra) # 7818 <exit>
  } else {
    wait(&xstatus);
    6f18:	fe840793          	addi	a5,s0,-24
    6f1c:	853e                	mv	a0,a5
    6f1e:	00001097          	auipc	ra,0x1
    6f22:	902080e7          	jalr	-1790(ra) # 7820 <wait>
    if(xstatus != 0)
    6f26:	fe842783          	lw	a5,-24(s0)
    6f2a:	cb91                	beqz	a5,6f3e <run+0x98>
      printf("FAILED\n");
    6f2c:	00003517          	auipc	a0,0x3
    6f30:	49c50513          	addi	a0,a0,1180 # a3c8 <malloc+0x2490>
    6f34:	00001097          	auipc	ra,0x1
    6f38:	e12080e7          	jalr	-494(ra) # 7d46 <printf>
    6f3c:	a809                	j	6f4e <run+0xa8>
    else
      printf("OK\n");
    6f3e:	00003517          	auipc	a0,0x3
    6f42:	49250513          	addi	a0,a0,1170 # a3d0 <malloc+0x2498>
    6f46:	00001097          	auipc	ra,0x1
    6f4a:	e00080e7          	jalr	-512(ra) # 7d46 <printf>
    return xstatus == 0;
    6f4e:	fe842783          	lw	a5,-24(s0)
    6f52:	0017b793          	seqz	a5,a5
    6f56:	0ff7f793          	andi	a5,a5,255
    6f5a:	2781                	sext.w	a5,a5
  }
}
    6f5c:	853e                	mv	a0,a5
    6f5e:	70a2                	ld	ra,40(sp)
    6f60:	7402                	ld	s0,32(sp)
    6f62:	6145                	addi	sp,sp,48
    6f64:	8082                	ret

0000000000006f66 <runtests>:

int
runtests(struct test *tests, char *justone) {
    6f66:	7179                	addi	sp,sp,-48
    6f68:	f406                	sd	ra,40(sp)
    6f6a:	f022                	sd	s0,32(sp)
    6f6c:	1800                	addi	s0,sp,48
    6f6e:	fca43c23          	sd	a0,-40(s0)
    6f72:	fcb43823          	sd	a1,-48(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6f76:	fd843783          	ld	a5,-40(s0)
    6f7a:	fef43423          	sd	a5,-24(s0)
    6f7e:	a8a9                	j	6fd8 <runtests+0x72>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    6f80:	fd043783          	ld	a5,-48(s0)
    6f84:	cf89                	beqz	a5,6f9e <runtests+0x38>
    6f86:	fe843783          	ld	a5,-24(s0)
    6f8a:	679c                	ld	a5,8(a5)
    6f8c:	fd043583          	ld	a1,-48(s0)
    6f90:	853e                	mv	a0,a5
    6f92:	00000097          	auipc	ra,0x0
    6f96:	440080e7          	jalr	1088(ra) # 73d2 <strcmp>
    6f9a:	87aa                	mv	a5,a0
    6f9c:	eb8d                	bnez	a5,6fce <runtests+0x68>
      if(!run(t->f, t->s)){
    6f9e:	fe843783          	ld	a5,-24(s0)
    6fa2:	6398                	ld	a4,0(a5)
    6fa4:	fe843783          	ld	a5,-24(s0)
    6fa8:	679c                	ld	a5,8(a5)
    6faa:	85be                	mv	a1,a5
    6fac:	853a                	mv	a0,a4
    6fae:	00000097          	auipc	ra,0x0
    6fb2:	ef8080e7          	jalr	-264(ra) # 6ea6 <run>
    6fb6:	87aa                	mv	a5,a0
    6fb8:	eb99                	bnez	a5,6fce <runtests+0x68>
        printf("SOME TESTS FAILED\n");
    6fba:	00003517          	auipc	a0,0x3
    6fbe:	41e50513          	addi	a0,a0,1054 # a3d8 <malloc+0x24a0>
    6fc2:	00001097          	auipc	ra,0x1
    6fc6:	d84080e7          	jalr	-636(ra) # 7d46 <printf>
        return 1;
    6fca:	4785                	li	a5,1
    6fcc:	a819                	j	6fe2 <runtests+0x7c>
  for (struct test *t = tests; t->s != 0; t++) {
    6fce:	fe843783          	ld	a5,-24(s0)
    6fd2:	07c1                	addi	a5,a5,16
    6fd4:	fef43423          	sd	a5,-24(s0)
    6fd8:	fe843783          	ld	a5,-24(s0)
    6fdc:	679c                	ld	a5,8(a5)
    6fde:	f3cd                	bnez	a5,6f80 <runtests+0x1a>
      }
    }
  }
  return 0;
    6fe0:	4781                	li	a5,0
}
    6fe2:	853e                	mv	a0,a5
    6fe4:	70a2                	ld	ra,40(sp)
    6fe6:	7402                	ld	s0,32(sp)
    6fe8:	6145                	addi	sp,sp,48
    6fea:	8082                	ret

0000000000006fec <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    6fec:	7139                	addi	sp,sp,-64
    6fee:	fc06                	sd	ra,56(sp)
    6ff0:	f822                	sd	s0,48(sp)
    6ff2:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    6ff4:	fd040793          	addi	a5,s0,-48
    6ff8:	853e                	mv	a0,a5
    6ffa:	00001097          	auipc	ra,0x1
    6ffe:	82e080e7          	jalr	-2002(ra) # 7828 <pipe>
    7002:	87aa                	mv	a5,a0
    7004:	0007df63          	bgez	a5,7022 <countfree+0x36>
    printf("pipe() failed in countfree()\n");
    7008:	00003517          	auipc	a0,0x3
    700c:	3e850513          	addi	a0,a0,1000 # a3f0 <malloc+0x24b8>
    7010:	00001097          	auipc	ra,0x1
    7014:	d36080e7          	jalr	-714(ra) # 7d46 <printf>
    exit(1);
    7018:	4505                	li	a0,1
    701a:	00000097          	auipc	ra,0x0
    701e:	7fe080e7          	jalr	2046(ra) # 7818 <exit>
  }

  int pid = fork();
    7022:	00000097          	auipc	ra,0x0
    7026:	7ee080e7          	jalr	2030(ra) # 7810 <fork>
    702a:	87aa                	mv	a5,a0
    702c:	fef42423          	sw	a5,-24(s0)

  if(pid < 0){
    7030:	fe842783          	lw	a5,-24(s0)
    7034:	2781                	sext.w	a5,a5
    7036:	0007df63          	bgez	a5,7054 <countfree+0x68>
    printf("fork failed in countfree()\n");
    703a:	00003517          	auipc	a0,0x3
    703e:	3d650513          	addi	a0,a0,982 # a410 <malloc+0x24d8>
    7042:	00001097          	auipc	ra,0x1
    7046:	d04080e7          	jalr	-764(ra) # 7d46 <printf>
    exit(1);
    704a:	4505                	li	a0,1
    704c:	00000097          	auipc	ra,0x0
    7050:	7cc080e7          	jalr	1996(ra) # 7818 <exit>
  }

  if(pid == 0){
    7054:	fe842783          	lw	a5,-24(s0)
    7058:	2781                	sext.w	a5,a5
    705a:	e3d1                	bnez	a5,70de <countfree+0xf2>
    close(fds[0]);
    705c:	fd042783          	lw	a5,-48(s0)
    7060:	853e                	mv	a0,a5
    7062:	00000097          	auipc	ra,0x0
    7066:	7de080e7          	jalr	2014(ra) # 7840 <close>

    while(1){
      uint64 a = (uint64) sbrk(4096);
    706a:	6505                	lui	a0,0x1
    706c:	00001097          	auipc	ra,0x1
    7070:	834080e7          	jalr	-1996(ra) # 78a0 <sbrk>
    7074:	87aa                	mv	a5,a0
    7076:	fcf43c23          	sd	a5,-40(s0)
      if(a == 0xffffffffffffffff){
    707a:	fd843703          	ld	a4,-40(s0)
    707e:	57fd                	li	a5,-1
    7080:	04f70963          	beq	a4,a5,70d2 <countfree+0xe6>
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    7084:	fd843703          	ld	a4,-40(s0)
    7088:	6785                	lui	a5,0x1
    708a:	17fd                	addi	a5,a5,-1
    708c:	97ba                	add	a5,a5,a4
    708e:	873e                	mv	a4,a5
    7090:	4785                	li	a5,1
    7092:	00f70023          	sb	a5,0(a4)

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    7096:	fd442783          	lw	a5,-44(s0)
    709a:	4605                	li	a2,1
    709c:	00001597          	auipc	a1,0x1
    70a0:	11458593          	addi	a1,a1,276 # 81b0 <malloc+0x278>
    70a4:	853e                	mv	a0,a5
    70a6:	00000097          	auipc	ra,0x0
    70aa:	792080e7          	jalr	1938(ra) # 7838 <write>
    70ae:	87aa                	mv	a5,a0
    70b0:	873e                	mv	a4,a5
    70b2:	4785                	li	a5,1
    70b4:	faf70be3          	beq	a4,a5,706a <countfree+0x7e>
        printf("write() failed in countfree()\n");
    70b8:	00003517          	auipc	a0,0x3
    70bc:	37850513          	addi	a0,a0,888 # a430 <malloc+0x24f8>
    70c0:	00001097          	auipc	ra,0x1
    70c4:	c86080e7          	jalr	-890(ra) # 7d46 <printf>
        exit(1);
    70c8:	4505                	li	a0,1
    70ca:	00000097          	auipc	ra,0x0
    70ce:	74e080e7          	jalr	1870(ra) # 7818 <exit>
        break;
    70d2:	0001                	nop
      }
    }

    exit(0);
    70d4:	4501                	li	a0,0
    70d6:	00000097          	auipc	ra,0x0
    70da:	742080e7          	jalr	1858(ra) # 7818 <exit>
  }

  close(fds[1]);
    70de:	fd442783          	lw	a5,-44(s0)
    70e2:	853e                	mv	a0,a5
    70e4:	00000097          	auipc	ra,0x0
    70e8:	75c080e7          	jalr	1884(ra) # 7840 <close>

  int n = 0;
    70ec:	fe042623          	sw	zero,-20(s0)
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    70f0:	fd042783          	lw	a5,-48(s0)
    70f4:	fcf40713          	addi	a4,s0,-49
    70f8:	4605                	li	a2,1
    70fa:	85ba                	mv	a1,a4
    70fc:	853e                	mv	a0,a5
    70fe:	00000097          	auipc	ra,0x0
    7102:	732080e7          	jalr	1842(ra) # 7830 <read>
    7106:	87aa                	mv	a5,a0
    7108:	fef42223          	sw	a5,-28(s0)
    if(cc < 0){
    710c:	fe442783          	lw	a5,-28(s0)
    7110:	2781                	sext.w	a5,a5
    7112:	0007df63          	bgez	a5,7130 <countfree+0x144>
      printf("read() failed in countfree()\n");
    7116:	00003517          	auipc	a0,0x3
    711a:	33a50513          	addi	a0,a0,826 # a450 <malloc+0x2518>
    711e:	00001097          	auipc	ra,0x1
    7122:	c28080e7          	jalr	-984(ra) # 7d46 <printf>
      exit(1);
    7126:	4505                	li	a0,1
    7128:	00000097          	auipc	ra,0x0
    712c:	6f0080e7          	jalr	1776(ra) # 7818 <exit>
    }
    if(cc == 0)
    7130:	fe442783          	lw	a5,-28(s0)
    7134:	2781                	sext.w	a5,a5
    7136:	e385                	bnez	a5,7156 <countfree+0x16a>
      break;
    n += 1;
  }

  close(fds[0]);
    7138:	fd042783          	lw	a5,-48(s0)
    713c:	853e                	mv	a0,a5
    713e:	00000097          	auipc	ra,0x0
    7142:	702080e7          	jalr	1794(ra) # 7840 <close>
  wait((int*)0);
    7146:	4501                	li	a0,0
    7148:	00000097          	auipc	ra,0x0
    714c:	6d8080e7          	jalr	1752(ra) # 7820 <wait>

  return n;
    7150:	fec42783          	lw	a5,-20(s0)
    7154:	a039                	j	7162 <countfree+0x176>
    n += 1;
    7156:	fec42783          	lw	a5,-20(s0)
    715a:	2785                	addiw	a5,a5,1
    715c:	fef42623          	sw	a5,-20(s0)
  while(1){
    7160:	bf41                	j	70f0 <countfree+0x104>
}
    7162:	853e                	mv	a0,a5
    7164:	70e2                	ld	ra,56(sp)
    7166:	7442                	ld	s0,48(sp)
    7168:	6121                	addi	sp,sp,64
    716a:	8082                	ret

000000000000716c <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    716c:	1101                	addi	sp,sp,-32
    716e:	ec06                	sd	ra,24(sp)
    7170:	e822                	sd	s0,16(sp)
    7172:	1000                	addi	s0,sp,32
    7174:	87aa                	mv	a5,a0
    7176:	872e                	mv	a4,a1
    7178:	fec43023          	sd	a2,-32(s0)
    717c:	fef42623          	sw	a5,-20(s0)
    7180:	87ba                	mv	a5,a4
    7182:	fef42423          	sw	a5,-24(s0)
  do {
    printf("usertests starting\n");
    7186:	00003517          	auipc	a0,0x3
    718a:	2ea50513          	addi	a0,a0,746 # a470 <malloc+0x2538>
    718e:	00001097          	auipc	ra,0x1
    7192:	bb8080e7          	jalr	-1096(ra) # 7d46 <printf>
    if (runtests(quicktests, justone)) {
    7196:	fe043583          	ld	a1,-32(s0)
    719a:	00004517          	auipc	a0,0x4
    719e:	e7650513          	addi	a0,a0,-394 # b010 <quicktests>
    71a2:	00000097          	auipc	ra,0x0
    71a6:	dc4080e7          	jalr	-572(ra) # 6f66 <runtests>
    71aa:	87aa                	mv	a5,a0
    71ac:	cb91                	beqz	a5,71c0 <drivetests+0x54>
      if(continuous != 2) {
    71ae:	fe842783          	lw	a5,-24(s0)
    71b2:	0007871b          	sext.w	a4,a5
    71b6:	4789                	li	a5,2
    71b8:	00f70463          	beq	a4,a5,71c0 <drivetests+0x54>
        return 1;
    71bc:	4785                	li	a5,1
    71be:	a891                	j	7212 <drivetests+0xa6>
      }
    }
    if(!quick) {
    71c0:	fec42783          	lw	a5,-20(s0)
    71c4:	2781                	sext.w	a5,a5
    71c6:	e3a9                	bnez	a5,7208 <drivetests+0x9c>
      if (justone == 0)
    71c8:	fe043783          	ld	a5,-32(s0)
    71cc:	eb89                	bnez	a5,71de <drivetests+0x72>
        printf("usertests slow tests starting\n");
    71ce:	00003517          	auipc	a0,0x3
    71d2:	2ba50513          	addi	a0,a0,698 # a488 <malloc+0x2550>
    71d6:	00001097          	auipc	ra,0x1
    71da:	b70080e7          	jalr	-1168(ra) # 7d46 <printf>
      if (runtests(slowtests, justone)) {
    71de:	fe043583          	ld	a1,-32(s0)
    71e2:	00004517          	auipc	a0,0x4
    71e6:	1de50513          	addi	a0,a0,478 # b3c0 <slowtests>
    71ea:	00000097          	auipc	ra,0x0
    71ee:	d7c080e7          	jalr	-644(ra) # 6f66 <runtests>
    71f2:	87aa                	mv	a5,a0
    71f4:	cb91                	beqz	a5,7208 <drivetests+0x9c>
        if(continuous != 2) {
    71f6:	fe842783          	lw	a5,-24(s0)
    71fa:	0007871b          	sext.w	a4,a5
    71fe:	4789                	li	a5,2
    7200:	00f70463          	beq	a4,a5,7208 <drivetests+0x9c>
          return 1;
    7204:	4785                	li	a5,1
    7206:	a031                	j	7212 <drivetests+0xa6>
        }
      }
    }
  } while(continuous);
    7208:	fe842783          	lw	a5,-24(s0)
    720c:	2781                	sext.w	a5,a5
    720e:	ffa5                	bnez	a5,7186 <drivetests+0x1a>
  return 0;
    7210:	4781                	li	a5,0
}
    7212:	853e                	mv	a0,a5
    7214:	60e2                	ld	ra,24(sp)
    7216:	6442                	ld	s0,16(sp)
    7218:	6105                	addi	sp,sp,32
    721a:	8082                	ret

000000000000721c <main>:

int
main(int argc, char *argv[])
{
    721c:	7179                	addi	sp,sp,-48
    721e:	f406                	sd	ra,40(sp)
    7220:	f022                	sd	s0,32(sp)
    7222:	1800                	addi	s0,sp,48
    7224:	87aa                	mv	a5,a0
    7226:	fcb43823          	sd	a1,-48(s0)
    722a:	fcf42e23          	sw	a5,-36(s0)
  int continuous = 0;
    722e:	fe042623          	sw	zero,-20(s0)
  int quick = 0;
    7232:	fe042423          	sw	zero,-24(s0)
  char *justone = 0;
    7236:	fe043023          	sd	zero,-32(s0)

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    723a:	fdc42783          	lw	a5,-36(s0)
    723e:	0007871b          	sext.w	a4,a5
    7242:	4789                	li	a5,2
    7244:	02f71563          	bne	a4,a5,726e <main+0x52>
    7248:	fd043783          	ld	a5,-48(s0)
    724c:	07a1                	addi	a5,a5,8
    724e:	639c                	ld	a5,0(a5)
    7250:	00003597          	auipc	a1,0x3
    7254:	25858593          	addi	a1,a1,600 # a4a8 <malloc+0x2570>
    7258:	853e                	mv	a0,a5
    725a:	00000097          	auipc	ra,0x0
    725e:	178080e7          	jalr	376(ra) # 73d2 <strcmp>
    7262:	87aa                	mv	a5,a0
    7264:	e789                	bnez	a5,726e <main+0x52>
    quick = 1;
    7266:	4785                	li	a5,1
    7268:	fef42423          	sw	a5,-24(s0)
    726c:	a0c9                	j	732e <main+0x112>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    726e:	fdc42783          	lw	a5,-36(s0)
    7272:	0007871b          	sext.w	a4,a5
    7276:	4789                	li	a5,2
    7278:	02f71563          	bne	a4,a5,72a2 <main+0x86>
    727c:	fd043783          	ld	a5,-48(s0)
    7280:	07a1                	addi	a5,a5,8
    7282:	639c                	ld	a5,0(a5)
    7284:	00003597          	auipc	a1,0x3
    7288:	22c58593          	addi	a1,a1,556 # a4b0 <malloc+0x2578>
    728c:	853e                	mv	a0,a5
    728e:	00000097          	auipc	ra,0x0
    7292:	144080e7          	jalr	324(ra) # 73d2 <strcmp>
    7296:	87aa                	mv	a5,a0
    7298:	e789                	bnez	a5,72a2 <main+0x86>
    continuous = 1;
    729a:	4785                	li	a5,1
    729c:	fef42623          	sw	a5,-20(s0)
    72a0:	a079                	j	732e <main+0x112>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    72a2:	fdc42783          	lw	a5,-36(s0)
    72a6:	0007871b          	sext.w	a4,a5
    72aa:	4789                	li	a5,2
    72ac:	02f71563          	bne	a4,a5,72d6 <main+0xba>
    72b0:	fd043783          	ld	a5,-48(s0)
    72b4:	07a1                	addi	a5,a5,8
    72b6:	639c                	ld	a5,0(a5)
    72b8:	00003597          	auipc	a1,0x3
    72bc:	20058593          	addi	a1,a1,512 # a4b8 <malloc+0x2580>
    72c0:	853e                	mv	a0,a5
    72c2:	00000097          	auipc	ra,0x0
    72c6:	110080e7          	jalr	272(ra) # 73d2 <strcmp>
    72ca:	87aa                	mv	a5,a0
    72cc:	e789                	bnez	a5,72d6 <main+0xba>
    continuous = 2;
    72ce:	4789                	li	a5,2
    72d0:	fef42623          	sw	a5,-20(s0)
    72d4:	a8a9                	j	732e <main+0x112>
  } else if(argc == 2 && argv[1][0] != '-'){
    72d6:	fdc42783          	lw	a5,-36(s0)
    72da:	0007871b          	sext.w	a4,a5
    72de:	4789                	li	a5,2
    72e0:	02f71363          	bne	a4,a5,7306 <main+0xea>
    72e4:	fd043783          	ld	a5,-48(s0)
    72e8:	07a1                	addi	a5,a5,8
    72ea:	639c                	ld	a5,0(a5)
    72ec:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    72f0:	873e                	mv	a4,a5
    72f2:	02d00793          	li	a5,45
    72f6:	00f70863          	beq	a4,a5,7306 <main+0xea>
    justone = argv[1];
    72fa:	fd043783          	ld	a5,-48(s0)
    72fe:	679c                	ld	a5,8(a5)
    7300:	fef43023          	sd	a5,-32(s0)
    7304:	a02d                	j	732e <main+0x112>
  } else if(argc > 1){
    7306:	fdc42783          	lw	a5,-36(s0)
    730a:	0007871b          	sext.w	a4,a5
    730e:	4785                	li	a5,1
    7310:	00e7df63          	bge	a5,a4,732e <main+0x112>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    7314:	00003517          	auipc	a0,0x3
    7318:	1ac50513          	addi	a0,a0,428 # a4c0 <malloc+0x2588>
    731c:	00001097          	auipc	ra,0x1
    7320:	a2a080e7          	jalr	-1494(ra) # 7d46 <printf>
    exit(1);
    7324:	4505                	li	a0,1
    7326:	00000097          	auipc	ra,0x0
    732a:	4f2080e7          	jalr	1266(ra) # 7818 <exit>
  }
  if (drivetests(quick, continuous, justone)) {
    732e:	fec42703          	lw	a4,-20(s0)
    7332:	fe842783          	lw	a5,-24(s0)
    7336:	fe043603          	ld	a2,-32(s0)
    733a:	85ba                	mv	a1,a4
    733c:	853e                	mv	a0,a5
    733e:	00000097          	auipc	ra,0x0
    7342:	e2e080e7          	jalr	-466(ra) # 716c <drivetests>
    7346:	87aa                	mv	a5,a0
    7348:	c791                	beqz	a5,7354 <main+0x138>
    exit(1);
    734a:	4505                	li	a0,1
    734c:	00000097          	auipc	ra,0x0
    7350:	4cc080e7          	jalr	1228(ra) # 7818 <exit>
  }
  printf("ALL TESTS PASSED\n");
    7354:	00003517          	auipc	a0,0x3
    7358:	19c50513          	addi	a0,a0,412 # a4f0 <malloc+0x25b8>
    735c:	00001097          	auipc	ra,0x1
    7360:	9ea080e7          	jalr	-1558(ra) # 7d46 <printf>
  exit(0);
    7364:	4501                	li	a0,0
    7366:	00000097          	auipc	ra,0x0
    736a:	4b2080e7          	jalr	1202(ra) # 7818 <exit>

000000000000736e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    736e:	1141                	addi	sp,sp,-16
    7370:	e406                	sd	ra,8(sp)
    7372:	e022                	sd	s0,0(sp)
    7374:	0800                	addi	s0,sp,16
  extern int main();
  main();
    7376:	00000097          	auipc	ra,0x0
    737a:	ea6080e7          	jalr	-346(ra) # 721c <main>
  exit(0);
    737e:	4501                	li	a0,0
    7380:	00000097          	auipc	ra,0x0
    7384:	498080e7          	jalr	1176(ra) # 7818 <exit>

0000000000007388 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    7388:	7179                	addi	sp,sp,-48
    738a:	f422                	sd	s0,40(sp)
    738c:	1800                	addi	s0,sp,48
    738e:	fca43c23          	sd	a0,-40(s0)
    7392:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
    7396:	fd843783          	ld	a5,-40(s0)
    739a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
    739e:	0001                	nop
    73a0:	fd043703          	ld	a4,-48(s0)
    73a4:	00170793          	addi	a5,a4,1
    73a8:	fcf43823          	sd	a5,-48(s0)
    73ac:	fd843783          	ld	a5,-40(s0)
    73b0:	00178693          	addi	a3,a5,1
    73b4:	fcd43c23          	sd	a3,-40(s0)
    73b8:	00074703          	lbu	a4,0(a4)
    73bc:	00e78023          	sb	a4,0(a5)
    73c0:	0007c783          	lbu	a5,0(a5)
    73c4:	fff1                	bnez	a5,73a0 <strcpy+0x18>
    ;
  return os;
    73c6:	fe843783          	ld	a5,-24(s0)
}
    73ca:	853e                	mv	a0,a5
    73cc:	7422                	ld	s0,40(sp)
    73ce:	6145                	addi	sp,sp,48
    73d0:	8082                	ret

00000000000073d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    73d2:	1101                	addi	sp,sp,-32
    73d4:	ec22                	sd	s0,24(sp)
    73d6:	1000                	addi	s0,sp,32
    73d8:	fea43423          	sd	a0,-24(s0)
    73dc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
    73e0:	a819                	j	73f6 <strcmp+0x24>
    p++, q++;
    73e2:	fe843783          	ld	a5,-24(s0)
    73e6:	0785                	addi	a5,a5,1
    73e8:	fef43423          	sd	a5,-24(s0)
    73ec:	fe043783          	ld	a5,-32(s0)
    73f0:	0785                	addi	a5,a5,1
    73f2:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
    73f6:	fe843783          	ld	a5,-24(s0)
    73fa:	0007c783          	lbu	a5,0(a5)
    73fe:	cb99                	beqz	a5,7414 <strcmp+0x42>
    7400:	fe843783          	ld	a5,-24(s0)
    7404:	0007c703          	lbu	a4,0(a5)
    7408:	fe043783          	ld	a5,-32(s0)
    740c:	0007c783          	lbu	a5,0(a5)
    7410:	fcf709e3          	beq	a4,a5,73e2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
    7414:	fe843783          	ld	a5,-24(s0)
    7418:	0007c783          	lbu	a5,0(a5)
    741c:	0007871b          	sext.w	a4,a5
    7420:	fe043783          	ld	a5,-32(s0)
    7424:	0007c783          	lbu	a5,0(a5)
    7428:	2781                	sext.w	a5,a5
    742a:	40f707bb          	subw	a5,a4,a5
    742e:	2781                	sext.w	a5,a5
}
    7430:	853e                	mv	a0,a5
    7432:	6462                	ld	s0,24(sp)
    7434:	6105                	addi	sp,sp,32
    7436:	8082                	ret

0000000000007438 <strlen>:

uint
strlen(const char *s)
{
    7438:	7179                	addi	sp,sp,-48
    743a:	f422                	sd	s0,40(sp)
    743c:	1800                	addi	s0,sp,48
    743e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    7442:	fe042623          	sw	zero,-20(s0)
    7446:	a031                	j	7452 <strlen+0x1a>
    7448:	fec42783          	lw	a5,-20(s0)
    744c:	2785                	addiw	a5,a5,1
    744e:	fef42623          	sw	a5,-20(s0)
    7452:	fec42783          	lw	a5,-20(s0)
    7456:	fd843703          	ld	a4,-40(s0)
    745a:	97ba                	add	a5,a5,a4
    745c:	0007c783          	lbu	a5,0(a5)
    7460:	f7e5                	bnez	a5,7448 <strlen+0x10>
    ;
  return n;
    7462:	fec42783          	lw	a5,-20(s0)
}
    7466:	853e                	mv	a0,a5
    7468:	7422                	ld	s0,40(sp)
    746a:	6145                	addi	sp,sp,48
    746c:	8082                	ret

000000000000746e <memset>:

void*
memset(void *dst, int c, uint n)
{
    746e:	7179                	addi	sp,sp,-48
    7470:	f422                	sd	s0,40(sp)
    7472:	1800                	addi	s0,sp,48
    7474:	fca43c23          	sd	a0,-40(s0)
    7478:	87ae                	mv	a5,a1
    747a:	8732                	mv	a4,a2
    747c:	fcf42a23          	sw	a5,-44(s0)
    7480:	87ba                	mv	a5,a4
    7482:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    7486:	fd843783          	ld	a5,-40(s0)
    748a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    748e:	fe042623          	sw	zero,-20(s0)
    7492:	a00d                	j	74b4 <memset+0x46>
    cdst[i] = c;
    7494:	fec42783          	lw	a5,-20(s0)
    7498:	fe043703          	ld	a4,-32(s0)
    749c:	97ba                	add	a5,a5,a4
    749e:	fd442703          	lw	a4,-44(s0)
    74a2:	0ff77713          	andi	a4,a4,255
    74a6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    74aa:	fec42783          	lw	a5,-20(s0)
    74ae:	2785                	addiw	a5,a5,1
    74b0:	fef42623          	sw	a5,-20(s0)
    74b4:	fec42703          	lw	a4,-20(s0)
    74b8:	fd042783          	lw	a5,-48(s0)
    74bc:	2781                	sext.w	a5,a5
    74be:	fcf76be3          	bltu	a4,a5,7494 <memset+0x26>
  }
  return dst;
    74c2:	fd843783          	ld	a5,-40(s0)
}
    74c6:	853e                	mv	a0,a5
    74c8:	7422                	ld	s0,40(sp)
    74ca:	6145                	addi	sp,sp,48
    74cc:	8082                	ret

00000000000074ce <strchr>:

char*
strchr(const char *s, char c)
{
    74ce:	1101                	addi	sp,sp,-32
    74d0:	ec22                	sd	s0,24(sp)
    74d2:	1000                	addi	s0,sp,32
    74d4:	fea43423          	sd	a0,-24(s0)
    74d8:	87ae                	mv	a5,a1
    74da:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    74de:	a01d                	j	7504 <strchr+0x36>
    if(*s == c)
    74e0:	fe843783          	ld	a5,-24(s0)
    74e4:	0007c703          	lbu	a4,0(a5)
    74e8:	fe744783          	lbu	a5,-25(s0)
    74ec:	0ff7f793          	andi	a5,a5,255
    74f0:	00e79563          	bne	a5,a4,74fa <strchr+0x2c>
      return (char*)s;
    74f4:	fe843783          	ld	a5,-24(s0)
    74f8:	a821                	j	7510 <strchr+0x42>
  for(; *s; s++)
    74fa:	fe843783          	ld	a5,-24(s0)
    74fe:	0785                	addi	a5,a5,1
    7500:	fef43423          	sd	a5,-24(s0)
    7504:	fe843783          	ld	a5,-24(s0)
    7508:	0007c783          	lbu	a5,0(a5)
    750c:	fbf1                	bnez	a5,74e0 <strchr+0x12>
  return 0;
    750e:	4781                	li	a5,0
}
    7510:	853e                	mv	a0,a5
    7512:	6462                	ld	s0,24(sp)
    7514:	6105                	addi	sp,sp,32
    7516:	8082                	ret

0000000000007518 <gets>:

char*
gets(char *buf, int max)
{
    7518:	7179                	addi	sp,sp,-48
    751a:	f406                	sd	ra,40(sp)
    751c:	f022                	sd	s0,32(sp)
    751e:	1800                	addi	s0,sp,48
    7520:	fca43c23          	sd	a0,-40(s0)
    7524:	87ae                	mv	a5,a1
    7526:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    752a:	fe042623          	sw	zero,-20(s0)
    752e:	a8a1                	j	7586 <gets+0x6e>
    cc = read(0, &c, 1);
    7530:	fe740793          	addi	a5,s0,-25
    7534:	4605                	li	a2,1
    7536:	85be                	mv	a1,a5
    7538:	4501                	li	a0,0
    753a:	00000097          	auipc	ra,0x0
    753e:	2f6080e7          	jalr	758(ra) # 7830 <read>
    7542:	87aa                	mv	a5,a0
    7544:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    7548:	fe842783          	lw	a5,-24(s0)
    754c:	2781                	sext.w	a5,a5
    754e:	04f05763          	blez	a5,759c <gets+0x84>
      break;
    buf[i++] = c;
    7552:	fec42783          	lw	a5,-20(s0)
    7556:	0017871b          	addiw	a4,a5,1
    755a:	fee42623          	sw	a4,-20(s0)
    755e:	873e                	mv	a4,a5
    7560:	fd843783          	ld	a5,-40(s0)
    7564:	97ba                	add	a5,a5,a4
    7566:	fe744703          	lbu	a4,-25(s0)
    756a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    756e:	fe744783          	lbu	a5,-25(s0)
    7572:	873e                	mv	a4,a5
    7574:	47a9                	li	a5,10
    7576:	02f70463          	beq	a4,a5,759e <gets+0x86>
    757a:	fe744783          	lbu	a5,-25(s0)
    757e:	873e                	mv	a4,a5
    7580:	47b5                	li	a5,13
    7582:	00f70e63          	beq	a4,a5,759e <gets+0x86>
  for(i=0; i+1 < max; ){
    7586:	fec42783          	lw	a5,-20(s0)
    758a:	2785                	addiw	a5,a5,1
    758c:	0007871b          	sext.w	a4,a5
    7590:	fd442783          	lw	a5,-44(s0)
    7594:	2781                	sext.w	a5,a5
    7596:	f8f74de3          	blt	a4,a5,7530 <gets+0x18>
    759a:	a011                	j	759e <gets+0x86>
      break;
    759c:	0001                	nop
      break;
  }
  buf[i] = '\0';
    759e:	fec42783          	lw	a5,-20(s0)
    75a2:	fd843703          	ld	a4,-40(s0)
    75a6:	97ba                	add	a5,a5,a4
    75a8:	00078023          	sb	zero,0(a5)
  return buf;
    75ac:	fd843783          	ld	a5,-40(s0)
}
    75b0:	853e                	mv	a0,a5
    75b2:	70a2                	ld	ra,40(sp)
    75b4:	7402                	ld	s0,32(sp)
    75b6:	6145                	addi	sp,sp,48
    75b8:	8082                	ret

00000000000075ba <stat>:

int
stat(const char *n, struct stat *st)
{
    75ba:	7179                	addi	sp,sp,-48
    75bc:	f406                	sd	ra,40(sp)
    75be:	f022                	sd	s0,32(sp)
    75c0:	1800                	addi	s0,sp,48
    75c2:	fca43c23          	sd	a0,-40(s0)
    75c6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    75ca:	4581                	li	a1,0
    75cc:	fd843503          	ld	a0,-40(s0)
    75d0:	00000097          	auipc	ra,0x0
    75d4:	288080e7          	jalr	648(ra) # 7858 <open>
    75d8:	87aa                	mv	a5,a0
    75da:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    75de:	fec42783          	lw	a5,-20(s0)
    75e2:	2781                	sext.w	a5,a5
    75e4:	0007d463          	bgez	a5,75ec <stat+0x32>
    return -1;
    75e8:	57fd                	li	a5,-1
    75ea:	a035                	j	7616 <stat+0x5c>
  r = fstat(fd, st);
    75ec:	fec42783          	lw	a5,-20(s0)
    75f0:	fd043583          	ld	a1,-48(s0)
    75f4:	853e                	mv	a0,a5
    75f6:	00000097          	auipc	ra,0x0
    75fa:	27a080e7          	jalr	634(ra) # 7870 <fstat>
    75fe:	87aa                	mv	a5,a0
    7600:	fef42423          	sw	a5,-24(s0)
  close(fd);
    7604:	fec42783          	lw	a5,-20(s0)
    7608:	853e                	mv	a0,a5
    760a:	00000097          	auipc	ra,0x0
    760e:	236080e7          	jalr	566(ra) # 7840 <close>
  return r;
    7612:	fe842783          	lw	a5,-24(s0)
}
    7616:	853e                	mv	a0,a5
    7618:	70a2                	ld	ra,40(sp)
    761a:	7402                	ld	s0,32(sp)
    761c:	6145                	addi	sp,sp,48
    761e:	8082                	ret

0000000000007620 <atoi>:

int
atoi(const char *s)
{
    7620:	7179                	addi	sp,sp,-48
    7622:	f422                	sd	s0,40(sp)
    7624:	1800                	addi	s0,sp,48
    7626:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    762a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    762e:	a815                	j	7662 <atoi+0x42>
    n = n*10 + *s++ - '0';
    7630:	fec42703          	lw	a4,-20(s0)
    7634:	87ba                	mv	a5,a4
    7636:	0027979b          	slliw	a5,a5,0x2
    763a:	9fb9                	addw	a5,a5,a4
    763c:	0017979b          	slliw	a5,a5,0x1
    7640:	0007871b          	sext.w	a4,a5
    7644:	fd843783          	ld	a5,-40(s0)
    7648:	00178693          	addi	a3,a5,1
    764c:	fcd43c23          	sd	a3,-40(s0)
    7650:	0007c783          	lbu	a5,0(a5)
    7654:	2781                	sext.w	a5,a5
    7656:	9fb9                	addw	a5,a5,a4
    7658:	2781                	sext.w	a5,a5
    765a:	fd07879b          	addiw	a5,a5,-48
    765e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    7662:	fd843783          	ld	a5,-40(s0)
    7666:	0007c783          	lbu	a5,0(a5)
    766a:	873e                	mv	a4,a5
    766c:	02f00793          	li	a5,47
    7670:	00e7fb63          	bgeu	a5,a4,7686 <atoi+0x66>
    7674:	fd843783          	ld	a5,-40(s0)
    7678:	0007c783          	lbu	a5,0(a5)
    767c:	873e                	mv	a4,a5
    767e:	03900793          	li	a5,57
    7682:	fae7f7e3          	bgeu	a5,a4,7630 <atoi+0x10>
  return n;
    7686:	fec42783          	lw	a5,-20(s0)
}
    768a:	853e                	mv	a0,a5
    768c:	7422                	ld	s0,40(sp)
    768e:	6145                	addi	sp,sp,48
    7690:	8082                	ret

0000000000007692 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    7692:	7139                	addi	sp,sp,-64
    7694:	fc22                	sd	s0,56(sp)
    7696:	0080                	addi	s0,sp,64
    7698:	fca43c23          	sd	a0,-40(s0)
    769c:	fcb43823          	sd	a1,-48(s0)
    76a0:	87b2                	mv	a5,a2
    76a2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    76a6:	fd843783          	ld	a5,-40(s0)
    76aa:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    76ae:	fd043783          	ld	a5,-48(s0)
    76b2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    76b6:	fe043703          	ld	a4,-32(s0)
    76ba:	fe843783          	ld	a5,-24(s0)
    76be:	02e7fc63          	bgeu	a5,a4,76f6 <memmove+0x64>
    while(n-- > 0)
    76c2:	a00d                	j	76e4 <memmove+0x52>
      *dst++ = *src++;
    76c4:	fe043703          	ld	a4,-32(s0)
    76c8:	00170793          	addi	a5,a4,1
    76cc:	fef43023          	sd	a5,-32(s0)
    76d0:	fe843783          	ld	a5,-24(s0)
    76d4:	00178693          	addi	a3,a5,1
    76d8:	fed43423          	sd	a3,-24(s0)
    76dc:	00074703          	lbu	a4,0(a4)
    76e0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    76e4:	fcc42783          	lw	a5,-52(s0)
    76e8:	fff7871b          	addiw	a4,a5,-1
    76ec:	fce42623          	sw	a4,-52(s0)
    76f0:	fcf04ae3          	bgtz	a5,76c4 <memmove+0x32>
    76f4:	a891                	j	7748 <memmove+0xb6>
  } else {
    dst += n;
    76f6:	fcc42783          	lw	a5,-52(s0)
    76fa:	fe843703          	ld	a4,-24(s0)
    76fe:	97ba                	add	a5,a5,a4
    7700:	fef43423          	sd	a5,-24(s0)
    src += n;
    7704:	fcc42783          	lw	a5,-52(s0)
    7708:	fe043703          	ld	a4,-32(s0)
    770c:	97ba                	add	a5,a5,a4
    770e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    7712:	a01d                	j	7738 <memmove+0xa6>
      *--dst = *--src;
    7714:	fe043783          	ld	a5,-32(s0)
    7718:	17fd                	addi	a5,a5,-1
    771a:	fef43023          	sd	a5,-32(s0)
    771e:	fe843783          	ld	a5,-24(s0)
    7722:	17fd                	addi	a5,a5,-1
    7724:	fef43423          	sd	a5,-24(s0)
    7728:	fe043783          	ld	a5,-32(s0)
    772c:	0007c703          	lbu	a4,0(a5)
    7730:	fe843783          	ld	a5,-24(s0)
    7734:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    7738:	fcc42783          	lw	a5,-52(s0)
    773c:	fff7871b          	addiw	a4,a5,-1
    7740:	fce42623          	sw	a4,-52(s0)
    7744:	fcf048e3          	bgtz	a5,7714 <memmove+0x82>
  }
  return vdst;
    7748:	fd843783          	ld	a5,-40(s0)
}
    774c:	853e                	mv	a0,a5
    774e:	7462                	ld	s0,56(sp)
    7750:	6121                	addi	sp,sp,64
    7752:	8082                	ret

0000000000007754 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    7754:	7139                	addi	sp,sp,-64
    7756:	fc22                	sd	s0,56(sp)
    7758:	0080                	addi	s0,sp,64
    775a:	fca43c23          	sd	a0,-40(s0)
    775e:	fcb43823          	sd	a1,-48(s0)
    7762:	87b2                	mv	a5,a2
    7764:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    7768:	fd843783          	ld	a5,-40(s0)
    776c:	fef43423          	sd	a5,-24(s0)
    7770:	fd043783          	ld	a5,-48(s0)
    7774:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    7778:	a0a1                	j	77c0 <memcmp+0x6c>
    if (*p1 != *p2) {
    777a:	fe843783          	ld	a5,-24(s0)
    777e:	0007c703          	lbu	a4,0(a5)
    7782:	fe043783          	ld	a5,-32(s0)
    7786:	0007c783          	lbu	a5,0(a5)
    778a:	02f70163          	beq	a4,a5,77ac <memcmp+0x58>
      return *p1 - *p2;
    778e:	fe843783          	ld	a5,-24(s0)
    7792:	0007c783          	lbu	a5,0(a5)
    7796:	0007871b          	sext.w	a4,a5
    779a:	fe043783          	ld	a5,-32(s0)
    779e:	0007c783          	lbu	a5,0(a5)
    77a2:	2781                	sext.w	a5,a5
    77a4:	40f707bb          	subw	a5,a4,a5
    77a8:	2781                	sext.w	a5,a5
    77aa:	a01d                	j	77d0 <memcmp+0x7c>
    }
    p1++;
    77ac:	fe843783          	ld	a5,-24(s0)
    77b0:	0785                	addi	a5,a5,1
    77b2:	fef43423          	sd	a5,-24(s0)
    p2++;
    77b6:	fe043783          	ld	a5,-32(s0)
    77ba:	0785                	addi	a5,a5,1
    77bc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    77c0:	fcc42783          	lw	a5,-52(s0)
    77c4:	fff7871b          	addiw	a4,a5,-1
    77c8:	fce42623          	sw	a4,-52(s0)
    77cc:	f7dd                	bnez	a5,777a <memcmp+0x26>
  }
  return 0;
    77ce:	4781                	li	a5,0
}
    77d0:	853e                	mv	a0,a5
    77d2:	7462                	ld	s0,56(sp)
    77d4:	6121                	addi	sp,sp,64
    77d6:	8082                	ret

00000000000077d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    77d8:	7179                	addi	sp,sp,-48
    77da:	f406                	sd	ra,40(sp)
    77dc:	f022                	sd	s0,32(sp)
    77de:	1800                	addi	s0,sp,48
    77e0:	fea43423          	sd	a0,-24(s0)
    77e4:	feb43023          	sd	a1,-32(s0)
    77e8:	87b2                	mv	a5,a2
    77ea:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    77ee:	fdc42783          	lw	a5,-36(s0)
    77f2:	863e                	mv	a2,a5
    77f4:	fe043583          	ld	a1,-32(s0)
    77f8:	fe843503          	ld	a0,-24(s0)
    77fc:	00000097          	auipc	ra,0x0
    7800:	e96080e7          	jalr	-362(ra) # 7692 <memmove>
    7804:	87aa                	mv	a5,a0
}
    7806:	853e                	mv	a0,a5
    7808:	70a2                	ld	ra,40(sp)
    780a:	7402                	ld	s0,32(sp)
    780c:	6145                	addi	sp,sp,48
    780e:	8082                	ret

0000000000007810 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    7810:	4885                	li	a7,1
 ecall
    7812:	00000073          	ecall
 ret
    7816:	8082                	ret

0000000000007818 <exit>:
.global exit
exit:
 li a7, SYS_exit
    7818:	4889                	li	a7,2
 ecall
    781a:	00000073          	ecall
 ret
    781e:	8082                	ret

0000000000007820 <wait>:
.global wait
wait:
 li a7, SYS_wait
    7820:	488d                	li	a7,3
 ecall
    7822:	00000073          	ecall
 ret
    7826:	8082                	ret

0000000000007828 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    7828:	4891                	li	a7,4
 ecall
    782a:	00000073          	ecall
 ret
    782e:	8082                	ret

0000000000007830 <read>:
.global read
read:
 li a7, SYS_read
    7830:	4895                	li	a7,5
 ecall
    7832:	00000073          	ecall
 ret
    7836:	8082                	ret

0000000000007838 <write>:
.global write
write:
 li a7, SYS_write
    7838:	48c1                	li	a7,16
 ecall
    783a:	00000073          	ecall
 ret
    783e:	8082                	ret

0000000000007840 <close>:
.global close
close:
 li a7, SYS_close
    7840:	48d5                	li	a7,21
 ecall
    7842:	00000073          	ecall
 ret
    7846:	8082                	ret

0000000000007848 <kill>:
.global kill
kill:
 li a7, SYS_kill
    7848:	4899                	li	a7,6
 ecall
    784a:	00000073          	ecall
 ret
    784e:	8082                	ret

0000000000007850 <exec>:
.global exec
exec:
 li a7, SYS_exec
    7850:	489d                	li	a7,7
 ecall
    7852:	00000073          	ecall
 ret
    7856:	8082                	ret

0000000000007858 <open>:
.global open
open:
 li a7, SYS_open
    7858:	48bd                	li	a7,15
 ecall
    785a:	00000073          	ecall
 ret
    785e:	8082                	ret

0000000000007860 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    7860:	48c5                	li	a7,17
 ecall
    7862:	00000073          	ecall
 ret
    7866:	8082                	ret

0000000000007868 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    7868:	48c9                	li	a7,18
 ecall
    786a:	00000073          	ecall
 ret
    786e:	8082                	ret

0000000000007870 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    7870:	48a1                	li	a7,8
 ecall
    7872:	00000073          	ecall
 ret
    7876:	8082                	ret

0000000000007878 <link>:
.global link
link:
 li a7, SYS_link
    7878:	48cd                	li	a7,19
 ecall
    787a:	00000073          	ecall
 ret
    787e:	8082                	ret

0000000000007880 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    7880:	48d1                	li	a7,20
 ecall
    7882:	00000073          	ecall
 ret
    7886:	8082                	ret

0000000000007888 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    7888:	48a5                	li	a7,9
 ecall
    788a:	00000073          	ecall
 ret
    788e:	8082                	ret

0000000000007890 <dup>:
.global dup
dup:
 li a7, SYS_dup
    7890:	48a9                	li	a7,10
 ecall
    7892:	00000073          	ecall
 ret
    7896:	8082                	ret

0000000000007898 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    7898:	48ad                	li	a7,11
 ecall
    789a:	00000073          	ecall
 ret
    789e:	8082                	ret

00000000000078a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    78a0:	48b1                	li	a7,12
 ecall
    78a2:	00000073          	ecall
 ret
    78a6:	8082                	ret

00000000000078a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    78a8:	48b5                	li	a7,13
 ecall
    78aa:	00000073          	ecall
 ret
    78ae:	8082                	ret

00000000000078b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    78b0:	48b9                	li	a7,14
 ecall
    78b2:	00000073          	ecall
 ret
    78b6:	8082                	ret

00000000000078b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    78b8:	1101                	addi	sp,sp,-32
    78ba:	ec06                	sd	ra,24(sp)
    78bc:	e822                	sd	s0,16(sp)
    78be:	1000                	addi	s0,sp,32
    78c0:	87aa                	mv	a5,a0
    78c2:	872e                	mv	a4,a1
    78c4:	fef42623          	sw	a5,-20(s0)
    78c8:	87ba                	mv	a5,a4
    78ca:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    78ce:	feb40713          	addi	a4,s0,-21
    78d2:	fec42783          	lw	a5,-20(s0)
    78d6:	4605                	li	a2,1
    78d8:	85ba                	mv	a1,a4
    78da:	853e                	mv	a0,a5
    78dc:	00000097          	auipc	ra,0x0
    78e0:	f5c080e7          	jalr	-164(ra) # 7838 <write>
}
    78e4:	0001                	nop
    78e6:	60e2                	ld	ra,24(sp)
    78e8:	6442                	ld	s0,16(sp)
    78ea:	6105                	addi	sp,sp,32
    78ec:	8082                	ret

00000000000078ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    78ee:	7139                	addi	sp,sp,-64
    78f0:	fc06                	sd	ra,56(sp)
    78f2:	f822                	sd	s0,48(sp)
    78f4:	0080                	addi	s0,sp,64
    78f6:	87aa                	mv	a5,a0
    78f8:	8736                	mv	a4,a3
    78fa:	fcf42623          	sw	a5,-52(s0)
    78fe:	87ae                	mv	a5,a1
    7900:	fcf42423          	sw	a5,-56(s0)
    7904:	87b2                	mv	a5,a2
    7906:	fcf42223          	sw	a5,-60(s0)
    790a:	87ba                	mv	a5,a4
    790c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    7910:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    7914:	fc042783          	lw	a5,-64(s0)
    7918:	2781                	sext.w	a5,a5
    791a:	c38d                	beqz	a5,793c <printint+0x4e>
    791c:	fc842783          	lw	a5,-56(s0)
    7920:	2781                	sext.w	a5,a5
    7922:	0007dd63          	bgez	a5,793c <printint+0x4e>
    neg = 1;
    7926:	4785                	li	a5,1
    7928:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    792c:	fc842783          	lw	a5,-56(s0)
    7930:	40f007bb          	negw	a5,a5
    7934:	2781                	sext.w	a5,a5
    7936:	fef42223          	sw	a5,-28(s0)
    793a:	a029                	j	7944 <printint+0x56>
  } else {
    x = xx;
    793c:	fc842783          	lw	a5,-56(s0)
    7940:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    7944:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    7948:	fc442783          	lw	a5,-60(s0)
    794c:	fe442703          	lw	a4,-28(s0)
    7950:	02f777bb          	remuw	a5,a4,a5
    7954:	0007861b          	sext.w	a2,a5
    7958:	fec42783          	lw	a5,-20(s0)
    795c:	0017871b          	addiw	a4,a5,1
    7960:	fee42623          	sw	a4,-20(s0)
    7964:	00004697          	auipc	a3,0x4
    7968:	acc68693          	addi	a3,a3,-1332 # b430 <digits>
    796c:	02061713          	slli	a4,a2,0x20
    7970:	9301                	srli	a4,a4,0x20
    7972:	9736                	add	a4,a4,a3
    7974:	00074703          	lbu	a4,0(a4)
    7978:	ff040693          	addi	a3,s0,-16
    797c:	97b6                	add	a5,a5,a3
    797e:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    7982:	fc442783          	lw	a5,-60(s0)
    7986:	fe442703          	lw	a4,-28(s0)
    798a:	02f757bb          	divuw	a5,a4,a5
    798e:	fef42223          	sw	a5,-28(s0)
    7992:	fe442783          	lw	a5,-28(s0)
    7996:	2781                	sext.w	a5,a5
    7998:	fbc5                	bnez	a5,7948 <printint+0x5a>
  if(neg)
    799a:	fe842783          	lw	a5,-24(s0)
    799e:	2781                	sext.w	a5,a5
    79a0:	cf95                	beqz	a5,79dc <printint+0xee>
    buf[i++] = '-';
    79a2:	fec42783          	lw	a5,-20(s0)
    79a6:	0017871b          	addiw	a4,a5,1
    79aa:	fee42623          	sw	a4,-20(s0)
    79ae:	ff040713          	addi	a4,s0,-16
    79b2:	97ba                	add	a5,a5,a4
    79b4:	02d00713          	li	a4,45
    79b8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    79bc:	a005                	j	79dc <printint+0xee>
    putc(fd, buf[i]);
    79be:	fec42783          	lw	a5,-20(s0)
    79c2:	ff040713          	addi	a4,s0,-16
    79c6:	97ba                	add	a5,a5,a4
    79c8:	fe07c703          	lbu	a4,-32(a5)
    79cc:	fcc42783          	lw	a5,-52(s0)
    79d0:	85ba                	mv	a1,a4
    79d2:	853e                	mv	a0,a5
    79d4:	00000097          	auipc	ra,0x0
    79d8:	ee4080e7          	jalr	-284(ra) # 78b8 <putc>
  while(--i >= 0)
    79dc:	fec42783          	lw	a5,-20(s0)
    79e0:	37fd                	addiw	a5,a5,-1
    79e2:	fef42623          	sw	a5,-20(s0)
    79e6:	fec42783          	lw	a5,-20(s0)
    79ea:	2781                	sext.w	a5,a5
    79ec:	fc07d9e3          	bgez	a5,79be <printint+0xd0>
}
    79f0:	0001                	nop
    79f2:	0001                	nop
    79f4:	70e2                	ld	ra,56(sp)
    79f6:	7442                	ld	s0,48(sp)
    79f8:	6121                	addi	sp,sp,64
    79fa:	8082                	ret

00000000000079fc <printptr>:

static void
printptr(int fd, uint64 x) {
    79fc:	7179                	addi	sp,sp,-48
    79fe:	f406                	sd	ra,40(sp)
    7a00:	f022                	sd	s0,32(sp)
    7a02:	1800                	addi	s0,sp,48
    7a04:	87aa                	mv	a5,a0
    7a06:	fcb43823          	sd	a1,-48(s0)
    7a0a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    7a0e:	fdc42783          	lw	a5,-36(s0)
    7a12:	03000593          	li	a1,48
    7a16:	853e                	mv	a0,a5
    7a18:	00000097          	auipc	ra,0x0
    7a1c:	ea0080e7          	jalr	-352(ra) # 78b8 <putc>
  putc(fd, 'x');
    7a20:	fdc42783          	lw	a5,-36(s0)
    7a24:	07800593          	li	a1,120
    7a28:	853e                	mv	a0,a5
    7a2a:	00000097          	auipc	ra,0x0
    7a2e:	e8e080e7          	jalr	-370(ra) # 78b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    7a32:	fe042623          	sw	zero,-20(s0)
    7a36:	a82d                	j	7a70 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    7a38:	fd043783          	ld	a5,-48(s0)
    7a3c:	93f1                	srli	a5,a5,0x3c
    7a3e:	00004717          	auipc	a4,0x4
    7a42:	9f270713          	addi	a4,a4,-1550 # b430 <digits>
    7a46:	97ba                	add	a5,a5,a4
    7a48:	0007c703          	lbu	a4,0(a5)
    7a4c:	fdc42783          	lw	a5,-36(s0)
    7a50:	85ba                	mv	a1,a4
    7a52:	853e                	mv	a0,a5
    7a54:	00000097          	auipc	ra,0x0
    7a58:	e64080e7          	jalr	-412(ra) # 78b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    7a5c:	fec42783          	lw	a5,-20(s0)
    7a60:	2785                	addiw	a5,a5,1
    7a62:	fef42623          	sw	a5,-20(s0)
    7a66:	fd043783          	ld	a5,-48(s0)
    7a6a:	0792                	slli	a5,a5,0x4
    7a6c:	fcf43823          	sd	a5,-48(s0)
    7a70:	fec42783          	lw	a5,-20(s0)
    7a74:	873e                	mv	a4,a5
    7a76:	47bd                	li	a5,15
    7a78:	fce7f0e3          	bgeu	a5,a4,7a38 <printptr+0x3c>
}
    7a7c:	0001                	nop
    7a7e:	0001                	nop
    7a80:	70a2                	ld	ra,40(sp)
    7a82:	7402                	ld	s0,32(sp)
    7a84:	6145                	addi	sp,sp,48
    7a86:	8082                	ret

0000000000007a88 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    7a88:	715d                	addi	sp,sp,-80
    7a8a:	e486                	sd	ra,72(sp)
    7a8c:	e0a2                	sd	s0,64(sp)
    7a8e:	0880                	addi	s0,sp,80
    7a90:	87aa                	mv	a5,a0
    7a92:	fcb43023          	sd	a1,-64(s0)
    7a96:	fac43c23          	sd	a2,-72(s0)
    7a9a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    7a9e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    7aa2:	fe042223          	sw	zero,-28(s0)
    7aa6:	a42d                	j	7cd0 <vprintf+0x248>
    c = fmt[i] & 0xff;
    7aa8:	fe442783          	lw	a5,-28(s0)
    7aac:	fc043703          	ld	a4,-64(s0)
    7ab0:	97ba                	add	a5,a5,a4
    7ab2:	0007c783          	lbu	a5,0(a5)
    7ab6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    7aba:	fe042783          	lw	a5,-32(s0)
    7abe:	2781                	sext.w	a5,a5
    7ac0:	eb9d                	bnez	a5,7af6 <vprintf+0x6e>
      if(c == '%'){
    7ac2:	fdc42783          	lw	a5,-36(s0)
    7ac6:	0007871b          	sext.w	a4,a5
    7aca:	02500793          	li	a5,37
    7ace:	00f71763          	bne	a4,a5,7adc <vprintf+0x54>
        state = '%';
    7ad2:	02500793          	li	a5,37
    7ad6:	fef42023          	sw	a5,-32(s0)
    7ada:	a2f5                	j	7cc6 <vprintf+0x23e>
      } else {
        putc(fd, c);
    7adc:	fdc42783          	lw	a5,-36(s0)
    7ae0:	0ff7f713          	andi	a4,a5,255
    7ae4:	fcc42783          	lw	a5,-52(s0)
    7ae8:	85ba                	mv	a1,a4
    7aea:	853e                	mv	a0,a5
    7aec:	00000097          	auipc	ra,0x0
    7af0:	dcc080e7          	jalr	-564(ra) # 78b8 <putc>
    7af4:	aac9                	j	7cc6 <vprintf+0x23e>
      }
    } else if(state == '%'){
    7af6:	fe042783          	lw	a5,-32(s0)
    7afa:	0007871b          	sext.w	a4,a5
    7afe:	02500793          	li	a5,37
    7b02:	1cf71263          	bne	a4,a5,7cc6 <vprintf+0x23e>
      if(c == 'd'){
    7b06:	fdc42783          	lw	a5,-36(s0)
    7b0a:	0007871b          	sext.w	a4,a5
    7b0e:	06400793          	li	a5,100
    7b12:	02f71463          	bne	a4,a5,7b3a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    7b16:	fb843783          	ld	a5,-72(s0)
    7b1a:	00878713          	addi	a4,a5,8
    7b1e:	fae43c23          	sd	a4,-72(s0)
    7b22:	4398                	lw	a4,0(a5)
    7b24:	fcc42783          	lw	a5,-52(s0)
    7b28:	4685                	li	a3,1
    7b2a:	4629                	li	a2,10
    7b2c:	85ba                	mv	a1,a4
    7b2e:	853e                	mv	a0,a5
    7b30:	00000097          	auipc	ra,0x0
    7b34:	dbe080e7          	jalr	-578(ra) # 78ee <printint>
    7b38:	a269                	j	7cc2 <vprintf+0x23a>
      } else if(c == 'l') {
    7b3a:	fdc42783          	lw	a5,-36(s0)
    7b3e:	0007871b          	sext.w	a4,a5
    7b42:	06c00793          	li	a5,108
    7b46:	02f71663          	bne	a4,a5,7b72 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    7b4a:	fb843783          	ld	a5,-72(s0)
    7b4e:	00878713          	addi	a4,a5,8
    7b52:	fae43c23          	sd	a4,-72(s0)
    7b56:	639c                	ld	a5,0(a5)
    7b58:	0007871b          	sext.w	a4,a5
    7b5c:	fcc42783          	lw	a5,-52(s0)
    7b60:	4681                	li	a3,0
    7b62:	4629                	li	a2,10
    7b64:	85ba                	mv	a1,a4
    7b66:	853e                	mv	a0,a5
    7b68:	00000097          	auipc	ra,0x0
    7b6c:	d86080e7          	jalr	-634(ra) # 78ee <printint>
    7b70:	aa89                	j	7cc2 <vprintf+0x23a>
      } else if(c == 'x') {
    7b72:	fdc42783          	lw	a5,-36(s0)
    7b76:	0007871b          	sext.w	a4,a5
    7b7a:	07800793          	li	a5,120
    7b7e:	02f71463          	bne	a4,a5,7ba6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    7b82:	fb843783          	ld	a5,-72(s0)
    7b86:	00878713          	addi	a4,a5,8
    7b8a:	fae43c23          	sd	a4,-72(s0)
    7b8e:	4398                	lw	a4,0(a5)
    7b90:	fcc42783          	lw	a5,-52(s0)
    7b94:	4681                	li	a3,0
    7b96:	4641                	li	a2,16
    7b98:	85ba                	mv	a1,a4
    7b9a:	853e                	mv	a0,a5
    7b9c:	00000097          	auipc	ra,0x0
    7ba0:	d52080e7          	jalr	-686(ra) # 78ee <printint>
    7ba4:	aa39                	j	7cc2 <vprintf+0x23a>
      } else if(c == 'p') {
    7ba6:	fdc42783          	lw	a5,-36(s0)
    7baa:	0007871b          	sext.w	a4,a5
    7bae:	07000793          	li	a5,112
    7bb2:	02f71263          	bne	a4,a5,7bd6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    7bb6:	fb843783          	ld	a5,-72(s0)
    7bba:	00878713          	addi	a4,a5,8
    7bbe:	fae43c23          	sd	a4,-72(s0)
    7bc2:	6398                	ld	a4,0(a5)
    7bc4:	fcc42783          	lw	a5,-52(s0)
    7bc8:	85ba                	mv	a1,a4
    7bca:	853e                	mv	a0,a5
    7bcc:	00000097          	auipc	ra,0x0
    7bd0:	e30080e7          	jalr	-464(ra) # 79fc <printptr>
    7bd4:	a0fd                	j	7cc2 <vprintf+0x23a>
      } else if(c == 's'){
    7bd6:	fdc42783          	lw	a5,-36(s0)
    7bda:	0007871b          	sext.w	a4,a5
    7bde:	07300793          	li	a5,115
    7be2:	04f71c63          	bne	a4,a5,7c3a <vprintf+0x1b2>
        s = va_arg(ap, char*);
    7be6:	fb843783          	ld	a5,-72(s0)
    7bea:	00878713          	addi	a4,a5,8
    7bee:	fae43c23          	sd	a4,-72(s0)
    7bf2:	639c                	ld	a5,0(a5)
    7bf4:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    7bf8:	fe843783          	ld	a5,-24(s0)
    7bfc:	eb8d                	bnez	a5,7c2e <vprintf+0x1a6>
          s = "(null)";
    7bfe:	00003797          	auipc	a5,0x3
    7c02:	90a78793          	addi	a5,a5,-1782 # a508 <malloc+0x25d0>
    7c06:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    7c0a:	a015                	j	7c2e <vprintf+0x1a6>
          putc(fd, *s);
    7c0c:	fe843783          	ld	a5,-24(s0)
    7c10:	0007c703          	lbu	a4,0(a5)
    7c14:	fcc42783          	lw	a5,-52(s0)
    7c18:	85ba                	mv	a1,a4
    7c1a:	853e                	mv	a0,a5
    7c1c:	00000097          	auipc	ra,0x0
    7c20:	c9c080e7          	jalr	-868(ra) # 78b8 <putc>
          s++;
    7c24:	fe843783          	ld	a5,-24(s0)
    7c28:	0785                	addi	a5,a5,1
    7c2a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    7c2e:	fe843783          	ld	a5,-24(s0)
    7c32:	0007c783          	lbu	a5,0(a5)
    7c36:	fbf9                	bnez	a5,7c0c <vprintf+0x184>
    7c38:	a069                	j	7cc2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    7c3a:	fdc42783          	lw	a5,-36(s0)
    7c3e:	0007871b          	sext.w	a4,a5
    7c42:	06300793          	li	a5,99
    7c46:	02f71463          	bne	a4,a5,7c6e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    7c4a:	fb843783          	ld	a5,-72(s0)
    7c4e:	00878713          	addi	a4,a5,8
    7c52:	fae43c23          	sd	a4,-72(s0)
    7c56:	439c                	lw	a5,0(a5)
    7c58:	0ff7f713          	andi	a4,a5,255
    7c5c:	fcc42783          	lw	a5,-52(s0)
    7c60:	85ba                	mv	a1,a4
    7c62:	853e                	mv	a0,a5
    7c64:	00000097          	auipc	ra,0x0
    7c68:	c54080e7          	jalr	-940(ra) # 78b8 <putc>
    7c6c:	a899                	j	7cc2 <vprintf+0x23a>
      } else if(c == '%'){
    7c6e:	fdc42783          	lw	a5,-36(s0)
    7c72:	0007871b          	sext.w	a4,a5
    7c76:	02500793          	li	a5,37
    7c7a:	00f71f63          	bne	a4,a5,7c98 <vprintf+0x210>
        putc(fd, c);
    7c7e:	fdc42783          	lw	a5,-36(s0)
    7c82:	0ff7f713          	andi	a4,a5,255
    7c86:	fcc42783          	lw	a5,-52(s0)
    7c8a:	85ba                	mv	a1,a4
    7c8c:	853e                	mv	a0,a5
    7c8e:	00000097          	auipc	ra,0x0
    7c92:	c2a080e7          	jalr	-982(ra) # 78b8 <putc>
    7c96:	a035                	j	7cc2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    7c98:	fcc42783          	lw	a5,-52(s0)
    7c9c:	02500593          	li	a1,37
    7ca0:	853e                	mv	a0,a5
    7ca2:	00000097          	auipc	ra,0x0
    7ca6:	c16080e7          	jalr	-1002(ra) # 78b8 <putc>
        putc(fd, c);
    7caa:	fdc42783          	lw	a5,-36(s0)
    7cae:	0ff7f713          	andi	a4,a5,255
    7cb2:	fcc42783          	lw	a5,-52(s0)
    7cb6:	85ba                	mv	a1,a4
    7cb8:	853e                	mv	a0,a5
    7cba:	00000097          	auipc	ra,0x0
    7cbe:	bfe080e7          	jalr	-1026(ra) # 78b8 <putc>
      }
      state = 0;
    7cc2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    7cc6:	fe442783          	lw	a5,-28(s0)
    7cca:	2785                	addiw	a5,a5,1
    7ccc:	fef42223          	sw	a5,-28(s0)
    7cd0:	fe442783          	lw	a5,-28(s0)
    7cd4:	fc043703          	ld	a4,-64(s0)
    7cd8:	97ba                	add	a5,a5,a4
    7cda:	0007c783          	lbu	a5,0(a5)
    7cde:	dc0795e3          	bnez	a5,7aa8 <vprintf+0x20>
    }
  }
}
    7ce2:	0001                	nop
    7ce4:	0001                	nop
    7ce6:	60a6                	ld	ra,72(sp)
    7ce8:	6406                	ld	s0,64(sp)
    7cea:	6161                	addi	sp,sp,80
    7cec:	8082                	ret

0000000000007cee <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    7cee:	7159                	addi	sp,sp,-112
    7cf0:	fc06                	sd	ra,56(sp)
    7cf2:	f822                	sd	s0,48(sp)
    7cf4:	0080                	addi	s0,sp,64
    7cf6:	fcb43823          	sd	a1,-48(s0)
    7cfa:	e010                	sd	a2,0(s0)
    7cfc:	e414                	sd	a3,8(s0)
    7cfe:	e818                	sd	a4,16(s0)
    7d00:	ec1c                	sd	a5,24(s0)
    7d02:	03043023          	sd	a6,32(s0)
    7d06:	03143423          	sd	a7,40(s0)
    7d0a:	87aa                	mv	a5,a0
    7d0c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    7d10:	03040793          	addi	a5,s0,48
    7d14:	fcf43423          	sd	a5,-56(s0)
    7d18:	fc843783          	ld	a5,-56(s0)
    7d1c:	fd078793          	addi	a5,a5,-48
    7d20:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    7d24:	fe843703          	ld	a4,-24(s0)
    7d28:	fdc42783          	lw	a5,-36(s0)
    7d2c:	863a                	mv	a2,a4
    7d2e:	fd043583          	ld	a1,-48(s0)
    7d32:	853e                	mv	a0,a5
    7d34:	00000097          	auipc	ra,0x0
    7d38:	d54080e7          	jalr	-684(ra) # 7a88 <vprintf>
}
    7d3c:	0001                	nop
    7d3e:	70e2                	ld	ra,56(sp)
    7d40:	7442                	ld	s0,48(sp)
    7d42:	6165                	addi	sp,sp,112
    7d44:	8082                	ret

0000000000007d46 <printf>:

void
printf(const char *fmt, ...)
{
    7d46:	7159                	addi	sp,sp,-112
    7d48:	f406                	sd	ra,40(sp)
    7d4a:	f022                	sd	s0,32(sp)
    7d4c:	1800                	addi	s0,sp,48
    7d4e:	fca43c23          	sd	a0,-40(s0)
    7d52:	e40c                	sd	a1,8(s0)
    7d54:	e810                	sd	a2,16(s0)
    7d56:	ec14                	sd	a3,24(s0)
    7d58:	f018                	sd	a4,32(s0)
    7d5a:	f41c                	sd	a5,40(s0)
    7d5c:	03043823          	sd	a6,48(s0)
    7d60:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    7d64:	04040793          	addi	a5,s0,64
    7d68:	fcf43823          	sd	a5,-48(s0)
    7d6c:	fd043783          	ld	a5,-48(s0)
    7d70:	fc878793          	addi	a5,a5,-56
    7d74:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    7d78:	fe843783          	ld	a5,-24(s0)
    7d7c:	863e                	mv	a2,a5
    7d7e:	fd843583          	ld	a1,-40(s0)
    7d82:	4505                	li	a0,1
    7d84:	00000097          	auipc	ra,0x0
    7d88:	d04080e7          	jalr	-764(ra) # 7a88 <vprintf>
}
    7d8c:	0001                	nop
    7d8e:	70a2                	ld	ra,40(sp)
    7d90:	7402                	ld	s0,32(sp)
    7d92:	6165                	addi	sp,sp,112
    7d94:	8082                	ret

0000000000007d96 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    7d96:	7179                	addi	sp,sp,-48
    7d98:	f422                	sd	s0,40(sp)
    7d9a:	1800                	addi	s0,sp,48
    7d9c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    7da0:	fd843783          	ld	a5,-40(s0)
    7da4:	17c1                	addi	a5,a5,-16
    7da6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7daa:	0000a797          	auipc	a5,0xa
    7dae:	ece78793          	addi	a5,a5,-306 # 11c78 <freep>
    7db2:	639c                	ld	a5,0(a5)
    7db4:	fef43423          	sd	a5,-24(s0)
    7db8:	a815                	j	7dec <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    7dba:	fe843783          	ld	a5,-24(s0)
    7dbe:	639c                	ld	a5,0(a5)
    7dc0:	fe843703          	ld	a4,-24(s0)
    7dc4:	00f76f63          	bltu	a4,a5,7de2 <free+0x4c>
    7dc8:	fe043703          	ld	a4,-32(s0)
    7dcc:	fe843783          	ld	a5,-24(s0)
    7dd0:	02e7eb63          	bltu	a5,a4,7e06 <free+0x70>
    7dd4:	fe843783          	ld	a5,-24(s0)
    7dd8:	639c                	ld	a5,0(a5)
    7dda:	fe043703          	ld	a4,-32(s0)
    7dde:	02f76463          	bltu	a4,a5,7e06 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7de2:	fe843783          	ld	a5,-24(s0)
    7de6:	639c                	ld	a5,0(a5)
    7de8:	fef43423          	sd	a5,-24(s0)
    7dec:	fe043703          	ld	a4,-32(s0)
    7df0:	fe843783          	ld	a5,-24(s0)
    7df4:	fce7f3e3          	bgeu	a5,a4,7dba <free+0x24>
    7df8:	fe843783          	ld	a5,-24(s0)
    7dfc:	639c                	ld	a5,0(a5)
    7dfe:	fe043703          	ld	a4,-32(s0)
    7e02:	faf77ce3          	bgeu	a4,a5,7dba <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    7e06:	fe043783          	ld	a5,-32(s0)
    7e0a:	479c                	lw	a5,8(a5)
    7e0c:	1782                	slli	a5,a5,0x20
    7e0e:	9381                	srli	a5,a5,0x20
    7e10:	0792                	slli	a5,a5,0x4
    7e12:	fe043703          	ld	a4,-32(s0)
    7e16:	973e                	add	a4,a4,a5
    7e18:	fe843783          	ld	a5,-24(s0)
    7e1c:	639c                	ld	a5,0(a5)
    7e1e:	02f71763          	bne	a4,a5,7e4c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    7e22:	fe043783          	ld	a5,-32(s0)
    7e26:	4798                	lw	a4,8(a5)
    7e28:	fe843783          	ld	a5,-24(s0)
    7e2c:	639c                	ld	a5,0(a5)
    7e2e:	479c                	lw	a5,8(a5)
    7e30:	9fb9                	addw	a5,a5,a4
    7e32:	0007871b          	sext.w	a4,a5
    7e36:	fe043783          	ld	a5,-32(s0)
    7e3a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    7e3c:	fe843783          	ld	a5,-24(s0)
    7e40:	639c                	ld	a5,0(a5)
    7e42:	6398                	ld	a4,0(a5)
    7e44:	fe043783          	ld	a5,-32(s0)
    7e48:	e398                	sd	a4,0(a5)
    7e4a:	a039                	j	7e58 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    7e4c:	fe843783          	ld	a5,-24(s0)
    7e50:	6398                	ld	a4,0(a5)
    7e52:	fe043783          	ld	a5,-32(s0)
    7e56:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    7e58:	fe843783          	ld	a5,-24(s0)
    7e5c:	479c                	lw	a5,8(a5)
    7e5e:	1782                	slli	a5,a5,0x20
    7e60:	9381                	srli	a5,a5,0x20
    7e62:	0792                	slli	a5,a5,0x4
    7e64:	fe843703          	ld	a4,-24(s0)
    7e68:	97ba                	add	a5,a5,a4
    7e6a:	fe043703          	ld	a4,-32(s0)
    7e6e:	02f71563          	bne	a4,a5,7e98 <free+0x102>
    p->s.size += bp->s.size;
    7e72:	fe843783          	ld	a5,-24(s0)
    7e76:	4798                	lw	a4,8(a5)
    7e78:	fe043783          	ld	a5,-32(s0)
    7e7c:	479c                	lw	a5,8(a5)
    7e7e:	9fb9                	addw	a5,a5,a4
    7e80:	0007871b          	sext.w	a4,a5
    7e84:	fe843783          	ld	a5,-24(s0)
    7e88:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    7e8a:	fe043783          	ld	a5,-32(s0)
    7e8e:	6398                	ld	a4,0(a5)
    7e90:	fe843783          	ld	a5,-24(s0)
    7e94:	e398                	sd	a4,0(a5)
    7e96:	a031                	j	7ea2 <free+0x10c>
  } else
    p->s.ptr = bp;
    7e98:	fe843783          	ld	a5,-24(s0)
    7e9c:	fe043703          	ld	a4,-32(s0)
    7ea0:	e398                	sd	a4,0(a5)
  freep = p;
    7ea2:	0000a797          	auipc	a5,0xa
    7ea6:	dd678793          	addi	a5,a5,-554 # 11c78 <freep>
    7eaa:	fe843703          	ld	a4,-24(s0)
    7eae:	e398                	sd	a4,0(a5)
}
    7eb0:	0001                	nop
    7eb2:	7422                	ld	s0,40(sp)
    7eb4:	6145                	addi	sp,sp,48
    7eb6:	8082                	ret

0000000000007eb8 <morecore>:

static Header*
morecore(uint nu)
{
    7eb8:	7179                	addi	sp,sp,-48
    7eba:	f406                	sd	ra,40(sp)
    7ebc:	f022                	sd	s0,32(sp)
    7ebe:	1800                	addi	s0,sp,48
    7ec0:	87aa                	mv	a5,a0
    7ec2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    7ec6:	fdc42783          	lw	a5,-36(s0)
    7eca:	0007871b          	sext.w	a4,a5
    7ece:	6785                	lui	a5,0x1
    7ed0:	00f77563          	bgeu	a4,a5,7eda <morecore+0x22>
    nu = 4096;
    7ed4:	6785                	lui	a5,0x1
    7ed6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    7eda:	fdc42783          	lw	a5,-36(s0)
    7ede:	0047979b          	slliw	a5,a5,0x4
    7ee2:	2781                	sext.w	a5,a5
    7ee4:	2781                	sext.w	a5,a5
    7ee6:	853e                	mv	a0,a5
    7ee8:	00000097          	auipc	ra,0x0
    7eec:	9b8080e7          	jalr	-1608(ra) # 78a0 <sbrk>
    7ef0:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    7ef4:	fe843703          	ld	a4,-24(s0)
    7ef8:	57fd                	li	a5,-1
    7efa:	00f71463          	bne	a4,a5,7f02 <morecore+0x4a>
    return 0;
    7efe:	4781                	li	a5,0
    7f00:	a03d                	j	7f2e <morecore+0x76>
  hp = (Header*)p;
    7f02:	fe843783          	ld	a5,-24(s0)
    7f06:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    7f0a:	fe043783          	ld	a5,-32(s0)
    7f0e:	fdc42703          	lw	a4,-36(s0)
    7f12:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    7f14:	fe043783          	ld	a5,-32(s0)
    7f18:	07c1                	addi	a5,a5,16
    7f1a:	853e                	mv	a0,a5
    7f1c:	00000097          	auipc	ra,0x0
    7f20:	e7a080e7          	jalr	-390(ra) # 7d96 <free>
  return freep;
    7f24:	0000a797          	auipc	a5,0xa
    7f28:	d5478793          	addi	a5,a5,-684 # 11c78 <freep>
    7f2c:	639c                	ld	a5,0(a5)
}
    7f2e:	853e                	mv	a0,a5
    7f30:	70a2                	ld	ra,40(sp)
    7f32:	7402                	ld	s0,32(sp)
    7f34:	6145                	addi	sp,sp,48
    7f36:	8082                	ret

0000000000007f38 <malloc>:

void*
malloc(uint nbytes)
{
    7f38:	7139                	addi	sp,sp,-64
    7f3a:	fc06                	sd	ra,56(sp)
    7f3c:	f822                	sd	s0,48(sp)
    7f3e:	0080                	addi	s0,sp,64
    7f40:	87aa                	mv	a5,a0
    7f42:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    7f46:	fcc46783          	lwu	a5,-52(s0)
    7f4a:	07bd                	addi	a5,a5,15
    7f4c:	8391                	srli	a5,a5,0x4
    7f4e:	2781                	sext.w	a5,a5
    7f50:	2785                	addiw	a5,a5,1
    7f52:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    7f56:	0000a797          	auipc	a5,0xa
    7f5a:	d2278793          	addi	a5,a5,-734 # 11c78 <freep>
    7f5e:	639c                	ld	a5,0(a5)
    7f60:	fef43023          	sd	a5,-32(s0)
    7f64:	fe043783          	ld	a5,-32(s0)
    7f68:	ef95                	bnez	a5,7fa4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    7f6a:	0000a797          	auipc	a5,0xa
    7f6e:	cfe78793          	addi	a5,a5,-770 # 11c68 <base>
    7f72:	fef43023          	sd	a5,-32(s0)
    7f76:	0000a797          	auipc	a5,0xa
    7f7a:	d0278793          	addi	a5,a5,-766 # 11c78 <freep>
    7f7e:	fe043703          	ld	a4,-32(s0)
    7f82:	e398                	sd	a4,0(a5)
    7f84:	0000a797          	auipc	a5,0xa
    7f88:	cf478793          	addi	a5,a5,-780 # 11c78 <freep>
    7f8c:	6398                	ld	a4,0(a5)
    7f8e:	0000a797          	auipc	a5,0xa
    7f92:	cda78793          	addi	a5,a5,-806 # 11c68 <base>
    7f96:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    7f98:	0000a797          	auipc	a5,0xa
    7f9c:	cd078793          	addi	a5,a5,-816 # 11c68 <base>
    7fa0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7fa4:	fe043783          	ld	a5,-32(s0)
    7fa8:	639c                	ld	a5,0(a5)
    7faa:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7fae:	fe843783          	ld	a5,-24(s0)
    7fb2:	4798                	lw	a4,8(a5)
    7fb4:	fdc42783          	lw	a5,-36(s0)
    7fb8:	2781                	sext.w	a5,a5
    7fba:	06f76863          	bltu	a4,a5,802a <malloc+0xf2>
      if(p->s.size == nunits)
    7fbe:	fe843783          	ld	a5,-24(s0)
    7fc2:	4798                	lw	a4,8(a5)
    7fc4:	fdc42783          	lw	a5,-36(s0)
    7fc8:	2781                	sext.w	a5,a5
    7fca:	00e79963          	bne	a5,a4,7fdc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    7fce:	fe843783          	ld	a5,-24(s0)
    7fd2:	6398                	ld	a4,0(a5)
    7fd4:	fe043783          	ld	a5,-32(s0)
    7fd8:	e398                	sd	a4,0(a5)
    7fda:	a82d                	j	8014 <malloc+0xdc>
      else {
        p->s.size -= nunits;
    7fdc:	fe843783          	ld	a5,-24(s0)
    7fe0:	4798                	lw	a4,8(a5)
    7fe2:	fdc42783          	lw	a5,-36(s0)
    7fe6:	40f707bb          	subw	a5,a4,a5
    7fea:	0007871b          	sext.w	a4,a5
    7fee:	fe843783          	ld	a5,-24(s0)
    7ff2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    7ff4:	fe843783          	ld	a5,-24(s0)
    7ff8:	479c                	lw	a5,8(a5)
    7ffa:	1782                	slli	a5,a5,0x20
    7ffc:	9381                	srli	a5,a5,0x20
    7ffe:	0792                	slli	a5,a5,0x4
    8000:	fe843703          	ld	a4,-24(s0)
    8004:	97ba                	add	a5,a5,a4
    8006:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    800a:	fe843783          	ld	a5,-24(s0)
    800e:	fdc42703          	lw	a4,-36(s0)
    8012:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    8014:	0000a797          	auipc	a5,0xa
    8018:	c6478793          	addi	a5,a5,-924 # 11c78 <freep>
    801c:	fe043703          	ld	a4,-32(s0)
    8020:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    8022:	fe843783          	ld	a5,-24(s0)
    8026:	07c1                	addi	a5,a5,16
    8028:	a091                	j	806c <malloc+0x134>
    }
    if(p == freep)
    802a:	0000a797          	auipc	a5,0xa
    802e:	c4e78793          	addi	a5,a5,-946 # 11c78 <freep>
    8032:	639c                	ld	a5,0(a5)
    8034:	fe843703          	ld	a4,-24(s0)
    8038:	02f71063          	bne	a4,a5,8058 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    803c:	fdc42783          	lw	a5,-36(s0)
    8040:	853e                	mv	a0,a5
    8042:	00000097          	auipc	ra,0x0
    8046:	e76080e7          	jalr	-394(ra) # 7eb8 <morecore>
    804a:	fea43423          	sd	a0,-24(s0)
    804e:	fe843783          	ld	a5,-24(s0)
    8052:	e399                	bnez	a5,8058 <malloc+0x120>
        return 0;
    8054:	4781                	li	a5,0
    8056:	a819                	j	806c <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    8058:	fe843783          	ld	a5,-24(s0)
    805c:	fef43023          	sd	a5,-32(s0)
    8060:	fe843783          	ld	a5,-24(s0)
    8064:	639c                	ld	a5,0(a5)
    8066:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    806a:	b791                	j	7fae <malloc+0x76>
  }
}
    806c:	853e                	mv	a0,a5
    806e:	70e2                	ld	ra,56(sp)
    8070:	7442                	ld	s0,48(sp)
    8072:	6121                	addi	sp,sp,64
    8074:	8082                	ret
