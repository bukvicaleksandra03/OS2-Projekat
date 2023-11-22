
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	fea43423          	sd	a0,-24(s0)
  write(1, s, strlen(s));
   c:	fe843503          	ld	a0,-24(s0)
  10:	00000097          	auipc	ra,0x0
  14:	222080e7          	jalr	546(ra) # 232 <strlen>
  18:	87aa                	mv	a5,a0
  1a:	2781                	sext.w	a5,a5
  1c:	2781                	sext.w	a5,a5
  1e:	863e                	mv	a2,a5
  20:	fe843583          	ld	a1,-24(s0)
  24:	4505                	li	a0,1
  26:	00000097          	auipc	ra,0x0
  2a:	60c080e7          	jalr	1548(ra) # 632 <write>
}
  2e:	0001                	nop
  30:	60e2                	ld	ra,24(sp)
  32:	6442                	ld	s0,16(sp)
  34:	6105                	addi	sp,sp,32
  36:	8082                	ret

0000000000000038 <forktest>:

void
forktest(void)
{
  38:	1101                	addi	sp,sp,-32
  3a:	ec06                	sd	ra,24(sp)
  3c:	e822                	sd	s0,16(sp)
  3e:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  40:	00000517          	auipc	a0,0x0
  44:	67850513          	addi	a0,a0,1656 # 6b8 <uptime+0xe>
  48:	00000097          	auipc	ra,0x0
  4c:	fb8080e7          	jalr	-72(ra) # 0 <print>

  for(n=0; n<N; n++){
  50:	fe042623          	sw	zero,-20(s0)
  54:	a81d                	j	8a <forktest+0x52>
    pid = fork();
  56:	00000097          	auipc	ra,0x0
  5a:	5b4080e7          	jalr	1460(ra) # 60a <fork>
  5e:	87aa                	mv	a5,a0
  60:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
  64:	fe842783          	lw	a5,-24(s0)
  68:	2781                	sext.w	a5,a5
  6a:	0207c963          	bltz	a5,9c <forktest+0x64>
      break;
    if(pid == 0)
  6e:	fe842783          	lw	a5,-24(s0)
  72:	2781                	sext.w	a5,a5
  74:	e791                	bnez	a5,80 <forktest+0x48>
      exit(0);
  76:	4501                	li	a0,0
  78:	00000097          	auipc	ra,0x0
  7c:	59a080e7          	jalr	1434(ra) # 612 <exit>
  for(n=0; n<N; n++){
  80:	fec42783          	lw	a5,-20(s0)
  84:	2785                	addiw	a5,a5,1
  86:	fef42623          	sw	a5,-20(s0)
  8a:	fec42783          	lw	a5,-20(s0)
  8e:	0007871b          	sext.w	a4,a5
  92:	3e700793          	li	a5,999
  96:	fce7d0e3          	bge	a5,a4,56 <forktest+0x1e>
  9a:	a011                	j	9e <forktest+0x66>
      break;
  9c:	0001                	nop
  }

  if(n == N){
  9e:	fec42783          	lw	a5,-20(s0)
  a2:	0007871b          	sext.w	a4,a5
  a6:	3e800793          	li	a5,1000
  aa:	04f71963          	bne	a4,a5,fc <forktest+0xc4>
    print("fork claimed to work N times!\n");
  ae:	00000517          	auipc	a0,0x0
  b2:	61a50513          	addi	a0,a0,1562 # 6c8 <uptime+0x1e>
  b6:	00000097          	auipc	ra,0x0
  ba:	f4a080e7          	jalr	-182(ra) # 0 <print>
    exit(1);
  be:	4505                	li	a0,1
  c0:	00000097          	auipc	ra,0x0
  c4:	552080e7          	jalr	1362(ra) # 612 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
  c8:	4501                	li	a0,0
  ca:	00000097          	auipc	ra,0x0
  ce:	550080e7          	jalr	1360(ra) # 61a <wait>
  d2:	87aa                	mv	a5,a0
  d4:	0007df63          	bgez	a5,f2 <forktest+0xba>
      print("wait stopped early\n");
  d8:	00000517          	auipc	a0,0x0
  dc:	61050513          	addi	a0,a0,1552 # 6e8 <uptime+0x3e>
  e0:	00000097          	auipc	ra,0x0
  e4:	f20080e7          	jalr	-224(ra) # 0 <print>
      exit(1);
  e8:	4505                	li	a0,1
  ea:	00000097          	auipc	ra,0x0
  ee:	528080e7          	jalr	1320(ra) # 612 <exit>
  for(; n > 0; n--){
  f2:	fec42783          	lw	a5,-20(s0)
  f6:	37fd                	addiw	a5,a5,-1
  f8:	fef42623          	sw	a5,-20(s0)
  fc:	fec42783          	lw	a5,-20(s0)
 100:	2781                	sext.w	a5,a5
 102:	fcf043e3          	bgtz	a5,c8 <forktest+0x90>
    }
  }

  if(wait(0) != -1){
 106:	4501                	li	a0,0
 108:	00000097          	auipc	ra,0x0
 10c:	512080e7          	jalr	1298(ra) # 61a <wait>
 110:	87aa                	mv	a5,a0
 112:	873e                	mv	a4,a5
 114:	57fd                	li	a5,-1
 116:	00f70f63          	beq	a4,a5,134 <forktest+0xfc>
    print("wait got too many\n");
 11a:	00000517          	auipc	a0,0x0
 11e:	5e650513          	addi	a0,a0,1510 # 700 <uptime+0x56>
 122:	00000097          	auipc	ra,0x0
 126:	ede080e7          	jalr	-290(ra) # 0 <print>
    exit(1);
 12a:	4505                	li	a0,1
 12c:	00000097          	auipc	ra,0x0
 130:	4e6080e7          	jalr	1254(ra) # 612 <exit>
  }

  print("fork test OK\n");
 134:	00000517          	auipc	a0,0x0
 138:	5e450513          	addi	a0,a0,1508 # 718 <uptime+0x6e>
 13c:	00000097          	auipc	ra,0x0
 140:	ec4080e7          	jalr	-316(ra) # 0 <print>
}
 144:	0001                	nop
 146:	60e2                	ld	ra,24(sp)
 148:	6442                	ld	s0,16(sp)
 14a:	6105                	addi	sp,sp,32
 14c:	8082                	ret

000000000000014e <main>:

int
main(void)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e406                	sd	ra,8(sp)
 152:	e022                	sd	s0,0(sp)
 154:	0800                	addi	s0,sp,16
  forktest();
 156:	00000097          	auipc	ra,0x0
 15a:	ee2080e7          	jalr	-286(ra) # 38 <forktest>
  exit(0);
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	4b2080e7          	jalr	1202(ra) # 612 <exit>

0000000000000168 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 168:	1141                	addi	sp,sp,-16
 16a:	e406                	sd	ra,8(sp)
 16c:	e022                	sd	s0,0(sp)
 16e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 170:	00000097          	auipc	ra,0x0
 174:	fde080e7          	jalr	-34(ra) # 14e <main>
  exit(0);
 178:	4501                	li	a0,0
 17a:	00000097          	auipc	ra,0x0
 17e:	498080e7          	jalr	1176(ra) # 612 <exit>

0000000000000182 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 182:	7179                	addi	sp,sp,-48
 184:	f422                	sd	s0,40(sp)
 186:	1800                	addi	s0,sp,48
 188:	fca43c23          	sd	a0,-40(s0)
 18c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 190:	fd843783          	ld	a5,-40(s0)
 194:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 198:	0001                	nop
 19a:	fd043703          	ld	a4,-48(s0)
 19e:	00170793          	addi	a5,a4,1
 1a2:	fcf43823          	sd	a5,-48(s0)
 1a6:	fd843783          	ld	a5,-40(s0)
 1aa:	00178693          	addi	a3,a5,1
 1ae:	fcd43c23          	sd	a3,-40(s0)
 1b2:	00074703          	lbu	a4,0(a4)
 1b6:	00e78023          	sb	a4,0(a5)
 1ba:	0007c783          	lbu	a5,0(a5)
 1be:	fff1                	bnez	a5,19a <strcpy+0x18>
    ;
  return os;
 1c0:	fe843783          	ld	a5,-24(s0)
}
 1c4:	853e                	mv	a0,a5
 1c6:	7422                	ld	s0,40(sp)
 1c8:	6145                	addi	sp,sp,48
 1ca:	8082                	ret

00000000000001cc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1cc:	1101                	addi	sp,sp,-32
 1ce:	ec22                	sd	s0,24(sp)
 1d0:	1000                	addi	s0,sp,32
 1d2:	fea43423          	sd	a0,-24(s0)
 1d6:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1da:	a819                	j	1f0 <strcmp+0x24>
    p++, q++;
 1dc:	fe843783          	ld	a5,-24(s0)
 1e0:	0785                	addi	a5,a5,1
 1e2:	fef43423          	sd	a5,-24(s0)
 1e6:	fe043783          	ld	a5,-32(s0)
 1ea:	0785                	addi	a5,a5,1
 1ec:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1f0:	fe843783          	ld	a5,-24(s0)
 1f4:	0007c783          	lbu	a5,0(a5)
 1f8:	cb99                	beqz	a5,20e <strcmp+0x42>
 1fa:	fe843783          	ld	a5,-24(s0)
 1fe:	0007c703          	lbu	a4,0(a5)
 202:	fe043783          	ld	a5,-32(s0)
 206:	0007c783          	lbu	a5,0(a5)
 20a:	fcf709e3          	beq	a4,a5,1dc <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 20e:	fe843783          	ld	a5,-24(s0)
 212:	0007c783          	lbu	a5,0(a5)
 216:	0007871b          	sext.w	a4,a5
 21a:	fe043783          	ld	a5,-32(s0)
 21e:	0007c783          	lbu	a5,0(a5)
 222:	2781                	sext.w	a5,a5
 224:	40f707bb          	subw	a5,a4,a5
 228:	2781                	sext.w	a5,a5
}
 22a:	853e                	mv	a0,a5
 22c:	6462                	ld	s0,24(sp)
 22e:	6105                	addi	sp,sp,32
 230:	8082                	ret

0000000000000232 <strlen>:

uint
strlen(const char *s)
{
 232:	7179                	addi	sp,sp,-48
 234:	f422                	sd	s0,40(sp)
 236:	1800                	addi	s0,sp,48
 238:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 23c:	fe042623          	sw	zero,-20(s0)
 240:	a031                	j	24c <strlen+0x1a>
 242:	fec42783          	lw	a5,-20(s0)
 246:	2785                	addiw	a5,a5,1
 248:	fef42623          	sw	a5,-20(s0)
 24c:	fec42783          	lw	a5,-20(s0)
 250:	fd843703          	ld	a4,-40(s0)
 254:	97ba                	add	a5,a5,a4
 256:	0007c783          	lbu	a5,0(a5)
 25a:	f7e5                	bnez	a5,242 <strlen+0x10>
    ;
  return n;
 25c:	fec42783          	lw	a5,-20(s0)
}
 260:	853e                	mv	a0,a5
 262:	7422                	ld	s0,40(sp)
 264:	6145                	addi	sp,sp,48
 266:	8082                	ret

0000000000000268 <memset>:

void*
memset(void *dst, int c, uint n)
{
 268:	7179                	addi	sp,sp,-48
 26a:	f422                	sd	s0,40(sp)
 26c:	1800                	addi	s0,sp,48
 26e:	fca43c23          	sd	a0,-40(s0)
 272:	87ae                	mv	a5,a1
 274:	8732                	mv	a4,a2
 276:	fcf42a23          	sw	a5,-44(s0)
 27a:	87ba                	mv	a5,a4
 27c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 280:	fd843783          	ld	a5,-40(s0)
 284:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 288:	fe042623          	sw	zero,-20(s0)
 28c:	a00d                	j	2ae <memset+0x46>
    cdst[i] = c;
 28e:	fec42783          	lw	a5,-20(s0)
 292:	fe043703          	ld	a4,-32(s0)
 296:	97ba                	add	a5,a5,a4
 298:	fd442703          	lw	a4,-44(s0)
 29c:	0ff77713          	andi	a4,a4,255
 2a0:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 2a4:	fec42783          	lw	a5,-20(s0)
 2a8:	2785                	addiw	a5,a5,1
 2aa:	fef42623          	sw	a5,-20(s0)
 2ae:	fec42703          	lw	a4,-20(s0)
 2b2:	fd042783          	lw	a5,-48(s0)
 2b6:	2781                	sext.w	a5,a5
 2b8:	fcf76be3          	bltu	a4,a5,28e <memset+0x26>
  }
  return dst;
 2bc:	fd843783          	ld	a5,-40(s0)
}
 2c0:	853e                	mv	a0,a5
 2c2:	7422                	ld	s0,40(sp)
 2c4:	6145                	addi	sp,sp,48
 2c6:	8082                	ret

00000000000002c8 <strchr>:

char*
strchr(const char *s, char c)
{
 2c8:	1101                	addi	sp,sp,-32
 2ca:	ec22                	sd	s0,24(sp)
 2cc:	1000                	addi	s0,sp,32
 2ce:	fea43423          	sd	a0,-24(s0)
 2d2:	87ae                	mv	a5,a1
 2d4:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2d8:	a01d                	j	2fe <strchr+0x36>
    if(*s == c)
 2da:	fe843783          	ld	a5,-24(s0)
 2de:	0007c703          	lbu	a4,0(a5)
 2e2:	fe744783          	lbu	a5,-25(s0)
 2e6:	0ff7f793          	andi	a5,a5,255
 2ea:	00e79563          	bne	a5,a4,2f4 <strchr+0x2c>
      return (char*)s;
 2ee:	fe843783          	ld	a5,-24(s0)
 2f2:	a821                	j	30a <strchr+0x42>
  for(; *s; s++)
 2f4:	fe843783          	ld	a5,-24(s0)
 2f8:	0785                	addi	a5,a5,1
 2fa:	fef43423          	sd	a5,-24(s0)
 2fe:	fe843783          	ld	a5,-24(s0)
 302:	0007c783          	lbu	a5,0(a5)
 306:	fbf1                	bnez	a5,2da <strchr+0x12>
  return 0;
 308:	4781                	li	a5,0
}
 30a:	853e                	mv	a0,a5
 30c:	6462                	ld	s0,24(sp)
 30e:	6105                	addi	sp,sp,32
 310:	8082                	ret

0000000000000312 <gets>:

char*
gets(char *buf, int max)
{
 312:	7179                	addi	sp,sp,-48
 314:	f406                	sd	ra,40(sp)
 316:	f022                	sd	s0,32(sp)
 318:	1800                	addi	s0,sp,48
 31a:	fca43c23          	sd	a0,-40(s0)
 31e:	87ae                	mv	a5,a1
 320:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 324:	fe042623          	sw	zero,-20(s0)
 328:	a8a1                	j	380 <gets+0x6e>
    cc = read(0, &c, 1);
 32a:	fe740793          	addi	a5,s0,-25
 32e:	4605                	li	a2,1
 330:	85be                	mv	a1,a5
 332:	4501                	li	a0,0
 334:	00000097          	auipc	ra,0x0
 338:	2f6080e7          	jalr	758(ra) # 62a <read>
 33c:	87aa                	mv	a5,a0
 33e:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 342:	fe842783          	lw	a5,-24(s0)
 346:	2781                	sext.w	a5,a5
 348:	04f05763          	blez	a5,396 <gets+0x84>
      break;
    buf[i++] = c;
 34c:	fec42783          	lw	a5,-20(s0)
 350:	0017871b          	addiw	a4,a5,1
 354:	fee42623          	sw	a4,-20(s0)
 358:	873e                	mv	a4,a5
 35a:	fd843783          	ld	a5,-40(s0)
 35e:	97ba                	add	a5,a5,a4
 360:	fe744703          	lbu	a4,-25(s0)
 364:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 368:	fe744783          	lbu	a5,-25(s0)
 36c:	873e                	mv	a4,a5
 36e:	47a9                	li	a5,10
 370:	02f70463          	beq	a4,a5,398 <gets+0x86>
 374:	fe744783          	lbu	a5,-25(s0)
 378:	873e                	mv	a4,a5
 37a:	47b5                	li	a5,13
 37c:	00f70e63          	beq	a4,a5,398 <gets+0x86>
  for(i=0; i+1 < max; ){
 380:	fec42783          	lw	a5,-20(s0)
 384:	2785                	addiw	a5,a5,1
 386:	0007871b          	sext.w	a4,a5
 38a:	fd442783          	lw	a5,-44(s0)
 38e:	2781                	sext.w	a5,a5
 390:	f8f74de3          	blt	a4,a5,32a <gets+0x18>
 394:	a011                	j	398 <gets+0x86>
      break;
 396:	0001                	nop
      break;
  }
  buf[i] = '\0';
 398:	fec42783          	lw	a5,-20(s0)
 39c:	fd843703          	ld	a4,-40(s0)
 3a0:	97ba                	add	a5,a5,a4
 3a2:	00078023          	sb	zero,0(a5)
  return buf;
 3a6:	fd843783          	ld	a5,-40(s0)
}
 3aa:	853e                	mv	a0,a5
 3ac:	70a2                	ld	ra,40(sp)
 3ae:	7402                	ld	s0,32(sp)
 3b0:	6145                	addi	sp,sp,48
 3b2:	8082                	ret

00000000000003b4 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b4:	7179                	addi	sp,sp,-48
 3b6:	f406                	sd	ra,40(sp)
 3b8:	f022                	sd	s0,32(sp)
 3ba:	1800                	addi	s0,sp,48
 3bc:	fca43c23          	sd	a0,-40(s0)
 3c0:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c4:	4581                	li	a1,0
 3c6:	fd843503          	ld	a0,-40(s0)
 3ca:	00000097          	auipc	ra,0x0
 3ce:	288080e7          	jalr	648(ra) # 652 <open>
 3d2:	87aa                	mv	a5,a0
 3d4:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3d8:	fec42783          	lw	a5,-20(s0)
 3dc:	2781                	sext.w	a5,a5
 3de:	0007d463          	bgez	a5,3e6 <stat+0x32>
    return -1;
 3e2:	57fd                	li	a5,-1
 3e4:	a035                	j	410 <stat+0x5c>
  r = fstat(fd, st);
 3e6:	fec42783          	lw	a5,-20(s0)
 3ea:	fd043583          	ld	a1,-48(s0)
 3ee:	853e                	mv	a0,a5
 3f0:	00000097          	auipc	ra,0x0
 3f4:	27a080e7          	jalr	634(ra) # 66a <fstat>
 3f8:	87aa                	mv	a5,a0
 3fa:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3fe:	fec42783          	lw	a5,-20(s0)
 402:	853e                	mv	a0,a5
 404:	00000097          	auipc	ra,0x0
 408:	236080e7          	jalr	566(ra) # 63a <close>
  return r;
 40c:	fe842783          	lw	a5,-24(s0)
}
 410:	853e                	mv	a0,a5
 412:	70a2                	ld	ra,40(sp)
 414:	7402                	ld	s0,32(sp)
 416:	6145                	addi	sp,sp,48
 418:	8082                	ret

000000000000041a <atoi>:

int
atoi(const char *s)
{
 41a:	7179                	addi	sp,sp,-48
 41c:	f422                	sd	s0,40(sp)
 41e:	1800                	addi	s0,sp,48
 420:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 424:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 428:	a815                	j	45c <atoi+0x42>
    n = n*10 + *s++ - '0';
 42a:	fec42703          	lw	a4,-20(s0)
 42e:	87ba                	mv	a5,a4
 430:	0027979b          	slliw	a5,a5,0x2
 434:	9fb9                	addw	a5,a5,a4
 436:	0017979b          	slliw	a5,a5,0x1
 43a:	0007871b          	sext.w	a4,a5
 43e:	fd843783          	ld	a5,-40(s0)
 442:	00178693          	addi	a3,a5,1
 446:	fcd43c23          	sd	a3,-40(s0)
 44a:	0007c783          	lbu	a5,0(a5)
 44e:	2781                	sext.w	a5,a5
 450:	9fb9                	addw	a5,a5,a4
 452:	2781                	sext.w	a5,a5
 454:	fd07879b          	addiw	a5,a5,-48
 458:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 45c:	fd843783          	ld	a5,-40(s0)
 460:	0007c783          	lbu	a5,0(a5)
 464:	873e                	mv	a4,a5
 466:	02f00793          	li	a5,47
 46a:	00e7fb63          	bgeu	a5,a4,480 <atoi+0x66>
 46e:	fd843783          	ld	a5,-40(s0)
 472:	0007c783          	lbu	a5,0(a5)
 476:	873e                	mv	a4,a5
 478:	03900793          	li	a5,57
 47c:	fae7f7e3          	bgeu	a5,a4,42a <atoi+0x10>
  return n;
 480:	fec42783          	lw	a5,-20(s0)
}
 484:	853e                	mv	a0,a5
 486:	7422                	ld	s0,40(sp)
 488:	6145                	addi	sp,sp,48
 48a:	8082                	ret

000000000000048c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 48c:	7139                	addi	sp,sp,-64
 48e:	fc22                	sd	s0,56(sp)
 490:	0080                	addi	s0,sp,64
 492:	fca43c23          	sd	a0,-40(s0)
 496:	fcb43823          	sd	a1,-48(s0)
 49a:	87b2                	mv	a5,a2
 49c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 4a0:	fd843783          	ld	a5,-40(s0)
 4a4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 4a8:	fd043783          	ld	a5,-48(s0)
 4ac:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 4b0:	fe043703          	ld	a4,-32(s0)
 4b4:	fe843783          	ld	a5,-24(s0)
 4b8:	02e7fc63          	bgeu	a5,a4,4f0 <memmove+0x64>
    while(n-- > 0)
 4bc:	a00d                	j	4de <memmove+0x52>
      *dst++ = *src++;
 4be:	fe043703          	ld	a4,-32(s0)
 4c2:	00170793          	addi	a5,a4,1
 4c6:	fef43023          	sd	a5,-32(s0)
 4ca:	fe843783          	ld	a5,-24(s0)
 4ce:	00178693          	addi	a3,a5,1
 4d2:	fed43423          	sd	a3,-24(s0)
 4d6:	00074703          	lbu	a4,0(a4)
 4da:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4de:	fcc42783          	lw	a5,-52(s0)
 4e2:	fff7871b          	addiw	a4,a5,-1
 4e6:	fce42623          	sw	a4,-52(s0)
 4ea:	fcf04ae3          	bgtz	a5,4be <memmove+0x32>
 4ee:	a891                	j	542 <memmove+0xb6>
  } else {
    dst += n;
 4f0:	fcc42783          	lw	a5,-52(s0)
 4f4:	fe843703          	ld	a4,-24(s0)
 4f8:	97ba                	add	a5,a5,a4
 4fa:	fef43423          	sd	a5,-24(s0)
    src += n;
 4fe:	fcc42783          	lw	a5,-52(s0)
 502:	fe043703          	ld	a4,-32(s0)
 506:	97ba                	add	a5,a5,a4
 508:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 50c:	a01d                	j	532 <memmove+0xa6>
      *--dst = *--src;
 50e:	fe043783          	ld	a5,-32(s0)
 512:	17fd                	addi	a5,a5,-1
 514:	fef43023          	sd	a5,-32(s0)
 518:	fe843783          	ld	a5,-24(s0)
 51c:	17fd                	addi	a5,a5,-1
 51e:	fef43423          	sd	a5,-24(s0)
 522:	fe043783          	ld	a5,-32(s0)
 526:	0007c703          	lbu	a4,0(a5)
 52a:	fe843783          	ld	a5,-24(s0)
 52e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 532:	fcc42783          	lw	a5,-52(s0)
 536:	fff7871b          	addiw	a4,a5,-1
 53a:	fce42623          	sw	a4,-52(s0)
 53e:	fcf048e3          	bgtz	a5,50e <memmove+0x82>
  }
  return vdst;
 542:	fd843783          	ld	a5,-40(s0)
}
 546:	853e                	mv	a0,a5
 548:	7462                	ld	s0,56(sp)
 54a:	6121                	addi	sp,sp,64
 54c:	8082                	ret

000000000000054e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 54e:	7139                	addi	sp,sp,-64
 550:	fc22                	sd	s0,56(sp)
 552:	0080                	addi	s0,sp,64
 554:	fca43c23          	sd	a0,-40(s0)
 558:	fcb43823          	sd	a1,-48(s0)
 55c:	87b2                	mv	a5,a2
 55e:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 562:	fd843783          	ld	a5,-40(s0)
 566:	fef43423          	sd	a5,-24(s0)
 56a:	fd043783          	ld	a5,-48(s0)
 56e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 572:	a0a1                	j	5ba <memcmp+0x6c>
    if (*p1 != *p2) {
 574:	fe843783          	ld	a5,-24(s0)
 578:	0007c703          	lbu	a4,0(a5)
 57c:	fe043783          	ld	a5,-32(s0)
 580:	0007c783          	lbu	a5,0(a5)
 584:	02f70163          	beq	a4,a5,5a6 <memcmp+0x58>
      return *p1 - *p2;
 588:	fe843783          	ld	a5,-24(s0)
 58c:	0007c783          	lbu	a5,0(a5)
 590:	0007871b          	sext.w	a4,a5
 594:	fe043783          	ld	a5,-32(s0)
 598:	0007c783          	lbu	a5,0(a5)
 59c:	2781                	sext.w	a5,a5
 59e:	40f707bb          	subw	a5,a4,a5
 5a2:	2781                	sext.w	a5,a5
 5a4:	a01d                	j	5ca <memcmp+0x7c>
    }
    p1++;
 5a6:	fe843783          	ld	a5,-24(s0)
 5aa:	0785                	addi	a5,a5,1
 5ac:	fef43423          	sd	a5,-24(s0)
    p2++;
 5b0:	fe043783          	ld	a5,-32(s0)
 5b4:	0785                	addi	a5,a5,1
 5b6:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5ba:	fcc42783          	lw	a5,-52(s0)
 5be:	fff7871b          	addiw	a4,a5,-1
 5c2:	fce42623          	sw	a4,-52(s0)
 5c6:	f7dd                	bnez	a5,574 <memcmp+0x26>
  }
  return 0;
 5c8:	4781                	li	a5,0
}
 5ca:	853e                	mv	a0,a5
 5cc:	7462                	ld	s0,56(sp)
 5ce:	6121                	addi	sp,sp,64
 5d0:	8082                	ret

00000000000005d2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5d2:	7179                	addi	sp,sp,-48
 5d4:	f406                	sd	ra,40(sp)
 5d6:	f022                	sd	s0,32(sp)
 5d8:	1800                	addi	s0,sp,48
 5da:	fea43423          	sd	a0,-24(s0)
 5de:	feb43023          	sd	a1,-32(s0)
 5e2:	87b2                	mv	a5,a2
 5e4:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5e8:	fdc42783          	lw	a5,-36(s0)
 5ec:	863e                	mv	a2,a5
 5ee:	fe043583          	ld	a1,-32(s0)
 5f2:	fe843503          	ld	a0,-24(s0)
 5f6:	00000097          	auipc	ra,0x0
 5fa:	e96080e7          	jalr	-362(ra) # 48c <memmove>
 5fe:	87aa                	mv	a5,a0
}
 600:	853e                	mv	a0,a5
 602:	70a2                	ld	ra,40(sp)
 604:	7402                	ld	s0,32(sp)
 606:	6145                	addi	sp,sp,48
 608:	8082                	ret

000000000000060a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 60a:	4885                	li	a7,1
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <exit>:
.global exit
exit:
 li a7, SYS_exit
 612:	4889                	li	a7,2
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <wait>:
.global wait
wait:
 li a7, SYS_wait
 61a:	488d                	li	a7,3
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 622:	4891                	li	a7,4
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <read>:
.global read
read:
 li a7, SYS_read
 62a:	4895                	li	a7,5
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <write>:
.global write
write:
 li a7, SYS_write
 632:	48c1                	li	a7,16
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <close>:
.global close
close:
 li a7, SYS_close
 63a:	48d5                	li	a7,21
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <kill>:
.global kill
kill:
 li a7, SYS_kill
 642:	4899                	li	a7,6
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <exec>:
.global exec
exec:
 li a7, SYS_exec
 64a:	489d                	li	a7,7
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <open>:
.global open
open:
 li a7, SYS_open
 652:	48bd                	li	a7,15
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 65a:	48c5                	li	a7,17
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 662:	48c9                	li	a7,18
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 66a:	48a1                	li	a7,8
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <link>:
.global link
link:
 li a7, SYS_link
 672:	48cd                	li	a7,19
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 67a:	48d1                	li	a7,20
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 682:	48a5                	li	a7,9
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <dup>:
.global dup
dup:
 li a7, SYS_dup
 68a:	48a9                	li	a7,10
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 692:	48ad                	li	a7,11
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 69a:	48b1                	li	a7,12
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6a2:	48b5                	li	a7,13
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6aa:	48b9                	li	a7,14
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret
