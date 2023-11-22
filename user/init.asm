
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   8:	4589                	li	a1,2
   a:	00001517          	auipc	a0,0x1
   e:	e2e50513          	addi	a0,a0,-466 # e38 <malloc+0x150>
  12:	00000097          	auipc	ra,0x0
  16:	5f6080e7          	jalr	1526(ra) # 608 <open>
  1a:	87aa                	mv	a5,a0
  1c:	0207d563          	bgez	a5,46 <main+0x46>
    mknod("console", CONSOLE, 0);
  20:	4601                	li	a2,0
  22:	4585                	li	a1,1
  24:	00001517          	auipc	a0,0x1
  28:	e1450513          	addi	a0,a0,-492 # e38 <malloc+0x150>
  2c:	00000097          	auipc	ra,0x0
  30:	5e4080e7          	jalr	1508(ra) # 610 <mknod>
    open("console", O_RDWR);
  34:	4589                	li	a1,2
  36:	00001517          	auipc	a0,0x1
  3a:	e0250513          	addi	a0,a0,-510 # e38 <malloc+0x150>
  3e:	00000097          	auipc	ra,0x0
  42:	5ca080e7          	jalr	1482(ra) # 608 <open>
  }
  dup(0);  // stdout
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	5f8080e7          	jalr	1528(ra) # 640 <dup>
  dup(0);  // stderr
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	5ee080e7          	jalr	1518(ra) # 640 <dup>

  for(;;){
    printf("init: starting sh\n");
  5a:	00001517          	auipc	a0,0x1
  5e:	de650513          	addi	a0,a0,-538 # e40 <malloc+0x158>
  62:	00001097          	auipc	ra,0x1
  66:	a94080e7          	jalr	-1388(ra) # af6 <printf>
    pid = fork();
  6a:	00000097          	auipc	ra,0x0
  6e:	556080e7          	jalr	1366(ra) # 5c0 <fork>
  72:	87aa                	mv	a5,a0
  74:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
  78:	fec42783          	lw	a5,-20(s0)
  7c:	2781                	sext.w	a5,a5
  7e:	0007df63          	bgez	a5,9c <main+0x9c>
      printf("init: fork failed\n");
  82:	00001517          	auipc	a0,0x1
  86:	dd650513          	addi	a0,a0,-554 # e58 <malloc+0x170>
  8a:	00001097          	auipc	ra,0x1
  8e:	a6c080e7          	jalr	-1428(ra) # af6 <printf>
      exit(1);
  92:	4505                	li	a0,1
  94:	00000097          	auipc	ra,0x0
  98:	534080e7          	jalr	1332(ra) # 5c8 <exit>
    }
    if(pid == 0){
  9c:	fec42783          	lw	a5,-20(s0)
  a0:	2781                	sext.w	a5,a5
  a2:	eb95                	bnez	a5,d6 <main+0xd6>
      exec("sh", argv);
  a4:	00001597          	auipc	a1,0x1
  a8:	f5c58593          	addi	a1,a1,-164 # 1000 <argv>
  ac:	00001517          	auipc	a0,0x1
  b0:	d8450513          	addi	a0,a0,-636 # e30 <malloc+0x148>
  b4:	00000097          	auipc	ra,0x0
  b8:	54c080e7          	jalr	1356(ra) # 600 <exec>
      printf("init: exec sh failed\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	db450513          	addi	a0,a0,-588 # e70 <malloc+0x188>
  c4:	00001097          	auipc	ra,0x1
  c8:	a32080e7          	jalr	-1486(ra) # af6 <printf>
      exit(1);
  cc:	4505                	li	a0,1
  ce:	00000097          	auipc	ra,0x0
  d2:	4fa080e7          	jalr	1274(ra) # 5c8 <exit>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	4f8080e7          	jalr	1272(ra) # 5d0 <wait>
  e0:	87aa                	mv	a5,a0
  e2:	fef42423          	sw	a5,-24(s0)
      if(wpid == pid){
  e6:	fe842703          	lw	a4,-24(s0)
  ea:	fec42783          	lw	a5,-20(s0)
  ee:	2701                	sext.w	a4,a4
  f0:	2781                	sext.w	a5,a5
  f2:	02f70463          	beq	a4,a5,11a <main+0x11a>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  f6:	fe842783          	lw	a5,-24(s0)
  fa:	2781                	sext.w	a5,a5
  fc:	fc07dde3          	bgez	a5,d6 <main+0xd6>
        printf("init: wait returned an error\n");
 100:	00001517          	auipc	a0,0x1
 104:	d8850513          	addi	a0,a0,-632 # e88 <malloc+0x1a0>
 108:	00001097          	auipc	ra,0x1
 10c:	9ee080e7          	jalr	-1554(ra) # af6 <printf>
        exit(1);
 110:	4505                	li	a0,1
 112:	00000097          	auipc	ra,0x0
 116:	4b6080e7          	jalr	1206(ra) # 5c8 <exit>
        break;
 11a:	0001                	nop
    printf("init: starting sh\n");
 11c:	bf3d                	j	5a <main+0x5a>

000000000000011e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  extern int main();
  main();
 126:	00000097          	auipc	ra,0x0
 12a:	eda080e7          	jalr	-294(ra) # 0 <main>
  exit(0);
 12e:	4501                	li	a0,0
 130:	00000097          	auipc	ra,0x0
 134:	498080e7          	jalr	1176(ra) # 5c8 <exit>

0000000000000138 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 138:	7179                	addi	sp,sp,-48
 13a:	f422                	sd	s0,40(sp)
 13c:	1800                	addi	s0,sp,48
 13e:	fca43c23          	sd	a0,-40(s0)
 142:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 146:	fd843783          	ld	a5,-40(s0)
 14a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 14e:	0001                	nop
 150:	fd043703          	ld	a4,-48(s0)
 154:	00170793          	addi	a5,a4,1
 158:	fcf43823          	sd	a5,-48(s0)
 15c:	fd843783          	ld	a5,-40(s0)
 160:	00178693          	addi	a3,a5,1
 164:	fcd43c23          	sd	a3,-40(s0)
 168:	00074703          	lbu	a4,0(a4)
 16c:	00e78023          	sb	a4,0(a5)
 170:	0007c783          	lbu	a5,0(a5)
 174:	fff1                	bnez	a5,150 <strcpy+0x18>
    ;
  return os;
 176:	fe843783          	ld	a5,-24(s0)
}
 17a:	853e                	mv	a0,a5
 17c:	7422                	ld	s0,40(sp)
 17e:	6145                	addi	sp,sp,48
 180:	8082                	ret

0000000000000182 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 182:	1101                	addi	sp,sp,-32
 184:	ec22                	sd	s0,24(sp)
 186:	1000                	addi	s0,sp,32
 188:	fea43423          	sd	a0,-24(s0)
 18c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 190:	a819                	j	1a6 <strcmp+0x24>
    p++, q++;
 192:	fe843783          	ld	a5,-24(s0)
 196:	0785                	addi	a5,a5,1
 198:	fef43423          	sd	a5,-24(s0)
 19c:	fe043783          	ld	a5,-32(s0)
 1a0:	0785                	addi	a5,a5,1
 1a2:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1a6:	fe843783          	ld	a5,-24(s0)
 1aa:	0007c783          	lbu	a5,0(a5)
 1ae:	cb99                	beqz	a5,1c4 <strcmp+0x42>
 1b0:	fe843783          	ld	a5,-24(s0)
 1b4:	0007c703          	lbu	a4,0(a5)
 1b8:	fe043783          	ld	a5,-32(s0)
 1bc:	0007c783          	lbu	a5,0(a5)
 1c0:	fcf709e3          	beq	a4,a5,192 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1c4:	fe843783          	ld	a5,-24(s0)
 1c8:	0007c783          	lbu	a5,0(a5)
 1cc:	0007871b          	sext.w	a4,a5
 1d0:	fe043783          	ld	a5,-32(s0)
 1d4:	0007c783          	lbu	a5,0(a5)
 1d8:	2781                	sext.w	a5,a5
 1da:	40f707bb          	subw	a5,a4,a5
 1de:	2781                	sext.w	a5,a5
}
 1e0:	853e                	mv	a0,a5
 1e2:	6462                	ld	s0,24(sp)
 1e4:	6105                	addi	sp,sp,32
 1e6:	8082                	ret

00000000000001e8 <strlen>:

uint
strlen(const char *s)
{
 1e8:	7179                	addi	sp,sp,-48
 1ea:	f422                	sd	s0,40(sp)
 1ec:	1800                	addi	s0,sp,48
 1ee:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 1f2:	fe042623          	sw	zero,-20(s0)
 1f6:	a031                	j	202 <strlen+0x1a>
 1f8:	fec42783          	lw	a5,-20(s0)
 1fc:	2785                	addiw	a5,a5,1
 1fe:	fef42623          	sw	a5,-20(s0)
 202:	fec42783          	lw	a5,-20(s0)
 206:	fd843703          	ld	a4,-40(s0)
 20a:	97ba                	add	a5,a5,a4
 20c:	0007c783          	lbu	a5,0(a5)
 210:	f7e5                	bnez	a5,1f8 <strlen+0x10>
    ;
  return n;
 212:	fec42783          	lw	a5,-20(s0)
}
 216:	853e                	mv	a0,a5
 218:	7422                	ld	s0,40(sp)
 21a:	6145                	addi	sp,sp,48
 21c:	8082                	ret

000000000000021e <memset>:

void*
memset(void *dst, int c, uint n)
{
 21e:	7179                	addi	sp,sp,-48
 220:	f422                	sd	s0,40(sp)
 222:	1800                	addi	s0,sp,48
 224:	fca43c23          	sd	a0,-40(s0)
 228:	87ae                	mv	a5,a1
 22a:	8732                	mv	a4,a2
 22c:	fcf42a23          	sw	a5,-44(s0)
 230:	87ba                	mv	a5,a4
 232:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 236:	fd843783          	ld	a5,-40(s0)
 23a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 23e:	fe042623          	sw	zero,-20(s0)
 242:	a00d                	j	264 <memset+0x46>
    cdst[i] = c;
 244:	fec42783          	lw	a5,-20(s0)
 248:	fe043703          	ld	a4,-32(s0)
 24c:	97ba                	add	a5,a5,a4
 24e:	fd442703          	lw	a4,-44(s0)
 252:	0ff77713          	andi	a4,a4,255
 256:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 25a:	fec42783          	lw	a5,-20(s0)
 25e:	2785                	addiw	a5,a5,1
 260:	fef42623          	sw	a5,-20(s0)
 264:	fec42703          	lw	a4,-20(s0)
 268:	fd042783          	lw	a5,-48(s0)
 26c:	2781                	sext.w	a5,a5
 26e:	fcf76be3          	bltu	a4,a5,244 <memset+0x26>
  }
  return dst;
 272:	fd843783          	ld	a5,-40(s0)
}
 276:	853e                	mv	a0,a5
 278:	7422                	ld	s0,40(sp)
 27a:	6145                	addi	sp,sp,48
 27c:	8082                	ret

000000000000027e <strchr>:

char*
strchr(const char *s, char c)
{
 27e:	1101                	addi	sp,sp,-32
 280:	ec22                	sd	s0,24(sp)
 282:	1000                	addi	s0,sp,32
 284:	fea43423          	sd	a0,-24(s0)
 288:	87ae                	mv	a5,a1
 28a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 28e:	a01d                	j	2b4 <strchr+0x36>
    if(*s == c)
 290:	fe843783          	ld	a5,-24(s0)
 294:	0007c703          	lbu	a4,0(a5)
 298:	fe744783          	lbu	a5,-25(s0)
 29c:	0ff7f793          	andi	a5,a5,255
 2a0:	00e79563          	bne	a5,a4,2aa <strchr+0x2c>
      return (char*)s;
 2a4:	fe843783          	ld	a5,-24(s0)
 2a8:	a821                	j	2c0 <strchr+0x42>
  for(; *s; s++)
 2aa:	fe843783          	ld	a5,-24(s0)
 2ae:	0785                	addi	a5,a5,1
 2b0:	fef43423          	sd	a5,-24(s0)
 2b4:	fe843783          	ld	a5,-24(s0)
 2b8:	0007c783          	lbu	a5,0(a5)
 2bc:	fbf1                	bnez	a5,290 <strchr+0x12>
  return 0;
 2be:	4781                	li	a5,0
}
 2c0:	853e                	mv	a0,a5
 2c2:	6462                	ld	s0,24(sp)
 2c4:	6105                	addi	sp,sp,32
 2c6:	8082                	ret

00000000000002c8 <gets>:

char*
gets(char *buf, int max)
{
 2c8:	7179                	addi	sp,sp,-48
 2ca:	f406                	sd	ra,40(sp)
 2cc:	f022                	sd	s0,32(sp)
 2ce:	1800                	addi	s0,sp,48
 2d0:	fca43c23          	sd	a0,-40(s0)
 2d4:	87ae                	mv	a5,a1
 2d6:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2da:	fe042623          	sw	zero,-20(s0)
 2de:	a8a1                	j	336 <gets+0x6e>
    cc = read(0, &c, 1);
 2e0:	fe740793          	addi	a5,s0,-25
 2e4:	4605                	li	a2,1
 2e6:	85be                	mv	a1,a5
 2e8:	4501                	li	a0,0
 2ea:	00000097          	auipc	ra,0x0
 2ee:	2f6080e7          	jalr	758(ra) # 5e0 <read>
 2f2:	87aa                	mv	a5,a0
 2f4:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2f8:	fe842783          	lw	a5,-24(s0)
 2fc:	2781                	sext.w	a5,a5
 2fe:	04f05763          	blez	a5,34c <gets+0x84>
      break;
    buf[i++] = c;
 302:	fec42783          	lw	a5,-20(s0)
 306:	0017871b          	addiw	a4,a5,1
 30a:	fee42623          	sw	a4,-20(s0)
 30e:	873e                	mv	a4,a5
 310:	fd843783          	ld	a5,-40(s0)
 314:	97ba                	add	a5,a5,a4
 316:	fe744703          	lbu	a4,-25(s0)
 31a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 31e:	fe744783          	lbu	a5,-25(s0)
 322:	873e                	mv	a4,a5
 324:	47a9                	li	a5,10
 326:	02f70463          	beq	a4,a5,34e <gets+0x86>
 32a:	fe744783          	lbu	a5,-25(s0)
 32e:	873e                	mv	a4,a5
 330:	47b5                	li	a5,13
 332:	00f70e63          	beq	a4,a5,34e <gets+0x86>
  for(i=0; i+1 < max; ){
 336:	fec42783          	lw	a5,-20(s0)
 33a:	2785                	addiw	a5,a5,1
 33c:	0007871b          	sext.w	a4,a5
 340:	fd442783          	lw	a5,-44(s0)
 344:	2781                	sext.w	a5,a5
 346:	f8f74de3          	blt	a4,a5,2e0 <gets+0x18>
 34a:	a011                	j	34e <gets+0x86>
      break;
 34c:	0001                	nop
      break;
  }
  buf[i] = '\0';
 34e:	fec42783          	lw	a5,-20(s0)
 352:	fd843703          	ld	a4,-40(s0)
 356:	97ba                	add	a5,a5,a4
 358:	00078023          	sb	zero,0(a5)
  return buf;
 35c:	fd843783          	ld	a5,-40(s0)
}
 360:	853e                	mv	a0,a5
 362:	70a2                	ld	ra,40(sp)
 364:	7402                	ld	s0,32(sp)
 366:	6145                	addi	sp,sp,48
 368:	8082                	ret

000000000000036a <stat>:

int
stat(const char *n, struct stat *st)
{
 36a:	7179                	addi	sp,sp,-48
 36c:	f406                	sd	ra,40(sp)
 36e:	f022                	sd	s0,32(sp)
 370:	1800                	addi	s0,sp,48
 372:	fca43c23          	sd	a0,-40(s0)
 376:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 37a:	4581                	li	a1,0
 37c:	fd843503          	ld	a0,-40(s0)
 380:	00000097          	auipc	ra,0x0
 384:	288080e7          	jalr	648(ra) # 608 <open>
 388:	87aa                	mv	a5,a0
 38a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 38e:	fec42783          	lw	a5,-20(s0)
 392:	2781                	sext.w	a5,a5
 394:	0007d463          	bgez	a5,39c <stat+0x32>
    return -1;
 398:	57fd                	li	a5,-1
 39a:	a035                	j	3c6 <stat+0x5c>
  r = fstat(fd, st);
 39c:	fec42783          	lw	a5,-20(s0)
 3a0:	fd043583          	ld	a1,-48(s0)
 3a4:	853e                	mv	a0,a5
 3a6:	00000097          	auipc	ra,0x0
 3aa:	27a080e7          	jalr	634(ra) # 620 <fstat>
 3ae:	87aa                	mv	a5,a0
 3b0:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3b4:	fec42783          	lw	a5,-20(s0)
 3b8:	853e                	mv	a0,a5
 3ba:	00000097          	auipc	ra,0x0
 3be:	236080e7          	jalr	566(ra) # 5f0 <close>
  return r;
 3c2:	fe842783          	lw	a5,-24(s0)
}
 3c6:	853e                	mv	a0,a5
 3c8:	70a2                	ld	ra,40(sp)
 3ca:	7402                	ld	s0,32(sp)
 3cc:	6145                	addi	sp,sp,48
 3ce:	8082                	ret

00000000000003d0 <atoi>:

int
atoi(const char *s)
{
 3d0:	7179                	addi	sp,sp,-48
 3d2:	f422                	sd	s0,40(sp)
 3d4:	1800                	addi	s0,sp,48
 3d6:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3da:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3de:	a815                	j	412 <atoi+0x42>
    n = n*10 + *s++ - '0';
 3e0:	fec42703          	lw	a4,-20(s0)
 3e4:	87ba                	mv	a5,a4
 3e6:	0027979b          	slliw	a5,a5,0x2
 3ea:	9fb9                	addw	a5,a5,a4
 3ec:	0017979b          	slliw	a5,a5,0x1
 3f0:	0007871b          	sext.w	a4,a5
 3f4:	fd843783          	ld	a5,-40(s0)
 3f8:	00178693          	addi	a3,a5,1
 3fc:	fcd43c23          	sd	a3,-40(s0)
 400:	0007c783          	lbu	a5,0(a5)
 404:	2781                	sext.w	a5,a5
 406:	9fb9                	addw	a5,a5,a4
 408:	2781                	sext.w	a5,a5
 40a:	fd07879b          	addiw	a5,a5,-48
 40e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 412:	fd843783          	ld	a5,-40(s0)
 416:	0007c783          	lbu	a5,0(a5)
 41a:	873e                	mv	a4,a5
 41c:	02f00793          	li	a5,47
 420:	00e7fb63          	bgeu	a5,a4,436 <atoi+0x66>
 424:	fd843783          	ld	a5,-40(s0)
 428:	0007c783          	lbu	a5,0(a5)
 42c:	873e                	mv	a4,a5
 42e:	03900793          	li	a5,57
 432:	fae7f7e3          	bgeu	a5,a4,3e0 <atoi+0x10>
  return n;
 436:	fec42783          	lw	a5,-20(s0)
}
 43a:	853e                	mv	a0,a5
 43c:	7422                	ld	s0,40(sp)
 43e:	6145                	addi	sp,sp,48
 440:	8082                	ret

0000000000000442 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 442:	7139                	addi	sp,sp,-64
 444:	fc22                	sd	s0,56(sp)
 446:	0080                	addi	s0,sp,64
 448:	fca43c23          	sd	a0,-40(s0)
 44c:	fcb43823          	sd	a1,-48(s0)
 450:	87b2                	mv	a5,a2
 452:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 456:	fd843783          	ld	a5,-40(s0)
 45a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 45e:	fd043783          	ld	a5,-48(s0)
 462:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 466:	fe043703          	ld	a4,-32(s0)
 46a:	fe843783          	ld	a5,-24(s0)
 46e:	02e7fc63          	bgeu	a5,a4,4a6 <memmove+0x64>
    while(n-- > 0)
 472:	a00d                	j	494 <memmove+0x52>
      *dst++ = *src++;
 474:	fe043703          	ld	a4,-32(s0)
 478:	00170793          	addi	a5,a4,1
 47c:	fef43023          	sd	a5,-32(s0)
 480:	fe843783          	ld	a5,-24(s0)
 484:	00178693          	addi	a3,a5,1
 488:	fed43423          	sd	a3,-24(s0)
 48c:	00074703          	lbu	a4,0(a4)
 490:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 494:	fcc42783          	lw	a5,-52(s0)
 498:	fff7871b          	addiw	a4,a5,-1
 49c:	fce42623          	sw	a4,-52(s0)
 4a0:	fcf04ae3          	bgtz	a5,474 <memmove+0x32>
 4a4:	a891                	j	4f8 <memmove+0xb6>
  } else {
    dst += n;
 4a6:	fcc42783          	lw	a5,-52(s0)
 4aa:	fe843703          	ld	a4,-24(s0)
 4ae:	97ba                	add	a5,a5,a4
 4b0:	fef43423          	sd	a5,-24(s0)
    src += n;
 4b4:	fcc42783          	lw	a5,-52(s0)
 4b8:	fe043703          	ld	a4,-32(s0)
 4bc:	97ba                	add	a5,a5,a4
 4be:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4c2:	a01d                	j	4e8 <memmove+0xa6>
      *--dst = *--src;
 4c4:	fe043783          	ld	a5,-32(s0)
 4c8:	17fd                	addi	a5,a5,-1
 4ca:	fef43023          	sd	a5,-32(s0)
 4ce:	fe843783          	ld	a5,-24(s0)
 4d2:	17fd                	addi	a5,a5,-1
 4d4:	fef43423          	sd	a5,-24(s0)
 4d8:	fe043783          	ld	a5,-32(s0)
 4dc:	0007c703          	lbu	a4,0(a5)
 4e0:	fe843783          	ld	a5,-24(s0)
 4e4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4e8:	fcc42783          	lw	a5,-52(s0)
 4ec:	fff7871b          	addiw	a4,a5,-1
 4f0:	fce42623          	sw	a4,-52(s0)
 4f4:	fcf048e3          	bgtz	a5,4c4 <memmove+0x82>
  }
  return vdst;
 4f8:	fd843783          	ld	a5,-40(s0)
}
 4fc:	853e                	mv	a0,a5
 4fe:	7462                	ld	s0,56(sp)
 500:	6121                	addi	sp,sp,64
 502:	8082                	ret

0000000000000504 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 504:	7139                	addi	sp,sp,-64
 506:	fc22                	sd	s0,56(sp)
 508:	0080                	addi	s0,sp,64
 50a:	fca43c23          	sd	a0,-40(s0)
 50e:	fcb43823          	sd	a1,-48(s0)
 512:	87b2                	mv	a5,a2
 514:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 518:	fd843783          	ld	a5,-40(s0)
 51c:	fef43423          	sd	a5,-24(s0)
 520:	fd043783          	ld	a5,-48(s0)
 524:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 528:	a0a1                	j	570 <memcmp+0x6c>
    if (*p1 != *p2) {
 52a:	fe843783          	ld	a5,-24(s0)
 52e:	0007c703          	lbu	a4,0(a5)
 532:	fe043783          	ld	a5,-32(s0)
 536:	0007c783          	lbu	a5,0(a5)
 53a:	02f70163          	beq	a4,a5,55c <memcmp+0x58>
      return *p1 - *p2;
 53e:	fe843783          	ld	a5,-24(s0)
 542:	0007c783          	lbu	a5,0(a5)
 546:	0007871b          	sext.w	a4,a5
 54a:	fe043783          	ld	a5,-32(s0)
 54e:	0007c783          	lbu	a5,0(a5)
 552:	2781                	sext.w	a5,a5
 554:	40f707bb          	subw	a5,a4,a5
 558:	2781                	sext.w	a5,a5
 55a:	a01d                	j	580 <memcmp+0x7c>
    }
    p1++;
 55c:	fe843783          	ld	a5,-24(s0)
 560:	0785                	addi	a5,a5,1
 562:	fef43423          	sd	a5,-24(s0)
    p2++;
 566:	fe043783          	ld	a5,-32(s0)
 56a:	0785                	addi	a5,a5,1
 56c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 570:	fcc42783          	lw	a5,-52(s0)
 574:	fff7871b          	addiw	a4,a5,-1
 578:	fce42623          	sw	a4,-52(s0)
 57c:	f7dd                	bnez	a5,52a <memcmp+0x26>
  }
  return 0;
 57e:	4781                	li	a5,0
}
 580:	853e                	mv	a0,a5
 582:	7462                	ld	s0,56(sp)
 584:	6121                	addi	sp,sp,64
 586:	8082                	ret

0000000000000588 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 588:	7179                	addi	sp,sp,-48
 58a:	f406                	sd	ra,40(sp)
 58c:	f022                	sd	s0,32(sp)
 58e:	1800                	addi	s0,sp,48
 590:	fea43423          	sd	a0,-24(s0)
 594:	feb43023          	sd	a1,-32(s0)
 598:	87b2                	mv	a5,a2
 59a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 59e:	fdc42783          	lw	a5,-36(s0)
 5a2:	863e                	mv	a2,a5
 5a4:	fe043583          	ld	a1,-32(s0)
 5a8:	fe843503          	ld	a0,-24(s0)
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e96080e7          	jalr	-362(ra) # 442 <memmove>
 5b4:	87aa                	mv	a5,a0
}
 5b6:	853e                	mv	a0,a5
 5b8:	70a2                	ld	ra,40(sp)
 5ba:	7402                	ld	s0,32(sp)
 5bc:	6145                	addi	sp,sp,48
 5be:	8082                	ret

00000000000005c0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c0:	4885                	li	a7,1
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5c8:	4889                	li	a7,2
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d0:	488d                	li	a7,3
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5d8:	4891                	li	a7,4
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <read>:
.global read
read:
 li a7, SYS_read
 5e0:	4895                	li	a7,5
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <write>:
.global write
write:
 li a7, SYS_write
 5e8:	48c1                	li	a7,16
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <close>:
.global close
close:
 li a7, SYS_close
 5f0:	48d5                	li	a7,21
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5f8:	4899                	li	a7,6
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <exec>:
.global exec
exec:
 li a7, SYS_exec
 600:	489d                	li	a7,7
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <open>:
.global open
open:
 li a7, SYS_open
 608:	48bd                	li	a7,15
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 610:	48c5                	li	a7,17
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 618:	48c9                	li	a7,18
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 620:	48a1                	li	a7,8
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <link>:
.global link
link:
 li a7, SYS_link
 628:	48cd                	li	a7,19
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 630:	48d1                	li	a7,20
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 638:	48a5                	li	a7,9
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <dup>:
.global dup
dup:
 li a7, SYS_dup
 640:	48a9                	li	a7,10
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 648:	48ad                	li	a7,11
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 650:	48b1                	li	a7,12
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 658:	48b5                	li	a7,13
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 660:	48b9                	li	a7,14
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 668:	1101                	addi	sp,sp,-32
 66a:	ec06                	sd	ra,24(sp)
 66c:	e822                	sd	s0,16(sp)
 66e:	1000                	addi	s0,sp,32
 670:	87aa                	mv	a5,a0
 672:	872e                	mv	a4,a1
 674:	fef42623          	sw	a5,-20(s0)
 678:	87ba                	mv	a5,a4
 67a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 67e:	feb40713          	addi	a4,s0,-21
 682:	fec42783          	lw	a5,-20(s0)
 686:	4605                	li	a2,1
 688:	85ba                	mv	a1,a4
 68a:	853e                	mv	a0,a5
 68c:	00000097          	auipc	ra,0x0
 690:	f5c080e7          	jalr	-164(ra) # 5e8 <write>
}
 694:	0001                	nop
 696:	60e2                	ld	ra,24(sp)
 698:	6442                	ld	s0,16(sp)
 69a:	6105                	addi	sp,sp,32
 69c:	8082                	ret

000000000000069e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 69e:	7139                	addi	sp,sp,-64
 6a0:	fc06                	sd	ra,56(sp)
 6a2:	f822                	sd	s0,48(sp)
 6a4:	0080                	addi	s0,sp,64
 6a6:	87aa                	mv	a5,a0
 6a8:	8736                	mv	a4,a3
 6aa:	fcf42623          	sw	a5,-52(s0)
 6ae:	87ae                	mv	a5,a1
 6b0:	fcf42423          	sw	a5,-56(s0)
 6b4:	87b2                	mv	a5,a2
 6b6:	fcf42223          	sw	a5,-60(s0)
 6ba:	87ba                	mv	a5,a4
 6bc:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6c0:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6c4:	fc042783          	lw	a5,-64(s0)
 6c8:	2781                	sext.w	a5,a5
 6ca:	c38d                	beqz	a5,6ec <printint+0x4e>
 6cc:	fc842783          	lw	a5,-56(s0)
 6d0:	2781                	sext.w	a5,a5
 6d2:	0007dd63          	bgez	a5,6ec <printint+0x4e>
    neg = 1;
 6d6:	4785                	li	a5,1
 6d8:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6dc:	fc842783          	lw	a5,-56(s0)
 6e0:	40f007bb          	negw	a5,a5
 6e4:	2781                	sext.w	a5,a5
 6e6:	fef42223          	sw	a5,-28(s0)
 6ea:	a029                	j	6f4 <printint+0x56>
  } else {
    x = xx;
 6ec:	fc842783          	lw	a5,-56(s0)
 6f0:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 6f4:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6f8:	fc442783          	lw	a5,-60(s0)
 6fc:	fe442703          	lw	a4,-28(s0)
 700:	02f777bb          	remuw	a5,a4,a5
 704:	0007861b          	sext.w	a2,a5
 708:	fec42783          	lw	a5,-20(s0)
 70c:	0017871b          	addiw	a4,a5,1
 710:	fee42623          	sw	a4,-20(s0)
 714:	00001697          	auipc	a3,0x1
 718:	8fc68693          	addi	a3,a3,-1796 # 1010 <digits>
 71c:	02061713          	slli	a4,a2,0x20
 720:	9301                	srli	a4,a4,0x20
 722:	9736                	add	a4,a4,a3
 724:	00074703          	lbu	a4,0(a4)
 728:	ff040693          	addi	a3,s0,-16
 72c:	97b6                	add	a5,a5,a3
 72e:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 732:	fc442783          	lw	a5,-60(s0)
 736:	fe442703          	lw	a4,-28(s0)
 73a:	02f757bb          	divuw	a5,a4,a5
 73e:	fef42223          	sw	a5,-28(s0)
 742:	fe442783          	lw	a5,-28(s0)
 746:	2781                	sext.w	a5,a5
 748:	fbc5                	bnez	a5,6f8 <printint+0x5a>
  if(neg)
 74a:	fe842783          	lw	a5,-24(s0)
 74e:	2781                	sext.w	a5,a5
 750:	cf95                	beqz	a5,78c <printint+0xee>
    buf[i++] = '-';
 752:	fec42783          	lw	a5,-20(s0)
 756:	0017871b          	addiw	a4,a5,1
 75a:	fee42623          	sw	a4,-20(s0)
 75e:	ff040713          	addi	a4,s0,-16
 762:	97ba                	add	a5,a5,a4
 764:	02d00713          	li	a4,45
 768:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 76c:	a005                	j	78c <printint+0xee>
    putc(fd, buf[i]);
 76e:	fec42783          	lw	a5,-20(s0)
 772:	ff040713          	addi	a4,s0,-16
 776:	97ba                	add	a5,a5,a4
 778:	fe07c703          	lbu	a4,-32(a5)
 77c:	fcc42783          	lw	a5,-52(s0)
 780:	85ba                	mv	a1,a4
 782:	853e                	mv	a0,a5
 784:	00000097          	auipc	ra,0x0
 788:	ee4080e7          	jalr	-284(ra) # 668 <putc>
  while(--i >= 0)
 78c:	fec42783          	lw	a5,-20(s0)
 790:	37fd                	addiw	a5,a5,-1
 792:	fef42623          	sw	a5,-20(s0)
 796:	fec42783          	lw	a5,-20(s0)
 79a:	2781                	sext.w	a5,a5
 79c:	fc07d9e3          	bgez	a5,76e <printint+0xd0>
}
 7a0:	0001                	nop
 7a2:	0001                	nop
 7a4:	70e2                	ld	ra,56(sp)
 7a6:	7442                	ld	s0,48(sp)
 7a8:	6121                	addi	sp,sp,64
 7aa:	8082                	ret

00000000000007ac <printptr>:

static void
printptr(int fd, uint64 x) {
 7ac:	7179                	addi	sp,sp,-48
 7ae:	f406                	sd	ra,40(sp)
 7b0:	f022                	sd	s0,32(sp)
 7b2:	1800                	addi	s0,sp,48
 7b4:	87aa                	mv	a5,a0
 7b6:	fcb43823          	sd	a1,-48(s0)
 7ba:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7be:	fdc42783          	lw	a5,-36(s0)
 7c2:	03000593          	li	a1,48
 7c6:	853e                	mv	a0,a5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	ea0080e7          	jalr	-352(ra) # 668 <putc>
  putc(fd, 'x');
 7d0:	fdc42783          	lw	a5,-36(s0)
 7d4:	07800593          	li	a1,120
 7d8:	853e                	mv	a0,a5
 7da:	00000097          	auipc	ra,0x0
 7de:	e8e080e7          	jalr	-370(ra) # 668 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e2:	fe042623          	sw	zero,-20(s0)
 7e6:	a82d                	j	820 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7e8:	fd043783          	ld	a5,-48(s0)
 7ec:	93f1                	srli	a5,a5,0x3c
 7ee:	00001717          	auipc	a4,0x1
 7f2:	82270713          	addi	a4,a4,-2014 # 1010 <digits>
 7f6:	97ba                	add	a5,a5,a4
 7f8:	0007c703          	lbu	a4,0(a5)
 7fc:	fdc42783          	lw	a5,-36(s0)
 800:	85ba                	mv	a1,a4
 802:	853e                	mv	a0,a5
 804:	00000097          	auipc	ra,0x0
 808:	e64080e7          	jalr	-412(ra) # 668 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 80c:	fec42783          	lw	a5,-20(s0)
 810:	2785                	addiw	a5,a5,1
 812:	fef42623          	sw	a5,-20(s0)
 816:	fd043783          	ld	a5,-48(s0)
 81a:	0792                	slli	a5,a5,0x4
 81c:	fcf43823          	sd	a5,-48(s0)
 820:	fec42783          	lw	a5,-20(s0)
 824:	873e                	mv	a4,a5
 826:	47bd                	li	a5,15
 828:	fce7f0e3          	bgeu	a5,a4,7e8 <printptr+0x3c>
}
 82c:	0001                	nop
 82e:	0001                	nop
 830:	70a2                	ld	ra,40(sp)
 832:	7402                	ld	s0,32(sp)
 834:	6145                	addi	sp,sp,48
 836:	8082                	ret

0000000000000838 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 838:	715d                	addi	sp,sp,-80
 83a:	e486                	sd	ra,72(sp)
 83c:	e0a2                	sd	s0,64(sp)
 83e:	0880                	addi	s0,sp,80
 840:	87aa                	mv	a5,a0
 842:	fcb43023          	sd	a1,-64(s0)
 846:	fac43c23          	sd	a2,-72(s0)
 84a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 84e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 852:	fe042223          	sw	zero,-28(s0)
 856:	a42d                	j	a80 <vprintf+0x248>
    c = fmt[i] & 0xff;
 858:	fe442783          	lw	a5,-28(s0)
 85c:	fc043703          	ld	a4,-64(s0)
 860:	97ba                	add	a5,a5,a4
 862:	0007c783          	lbu	a5,0(a5)
 866:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 86a:	fe042783          	lw	a5,-32(s0)
 86e:	2781                	sext.w	a5,a5
 870:	eb9d                	bnez	a5,8a6 <vprintf+0x6e>
      if(c == '%'){
 872:	fdc42783          	lw	a5,-36(s0)
 876:	0007871b          	sext.w	a4,a5
 87a:	02500793          	li	a5,37
 87e:	00f71763          	bne	a4,a5,88c <vprintf+0x54>
        state = '%';
 882:	02500793          	li	a5,37
 886:	fef42023          	sw	a5,-32(s0)
 88a:	a2f5                	j	a76 <vprintf+0x23e>
      } else {
        putc(fd, c);
 88c:	fdc42783          	lw	a5,-36(s0)
 890:	0ff7f713          	andi	a4,a5,255
 894:	fcc42783          	lw	a5,-52(s0)
 898:	85ba                	mv	a1,a4
 89a:	853e                	mv	a0,a5
 89c:	00000097          	auipc	ra,0x0
 8a0:	dcc080e7          	jalr	-564(ra) # 668 <putc>
 8a4:	aac9                	j	a76 <vprintf+0x23e>
      }
    } else if(state == '%'){
 8a6:	fe042783          	lw	a5,-32(s0)
 8aa:	0007871b          	sext.w	a4,a5
 8ae:	02500793          	li	a5,37
 8b2:	1cf71263          	bne	a4,a5,a76 <vprintf+0x23e>
      if(c == 'd'){
 8b6:	fdc42783          	lw	a5,-36(s0)
 8ba:	0007871b          	sext.w	a4,a5
 8be:	06400793          	li	a5,100
 8c2:	02f71463          	bne	a4,a5,8ea <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8c6:	fb843783          	ld	a5,-72(s0)
 8ca:	00878713          	addi	a4,a5,8
 8ce:	fae43c23          	sd	a4,-72(s0)
 8d2:	4398                	lw	a4,0(a5)
 8d4:	fcc42783          	lw	a5,-52(s0)
 8d8:	4685                	li	a3,1
 8da:	4629                	li	a2,10
 8dc:	85ba                	mv	a1,a4
 8de:	853e                	mv	a0,a5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	dbe080e7          	jalr	-578(ra) # 69e <printint>
 8e8:	a269                	j	a72 <vprintf+0x23a>
      } else if(c == 'l') {
 8ea:	fdc42783          	lw	a5,-36(s0)
 8ee:	0007871b          	sext.w	a4,a5
 8f2:	06c00793          	li	a5,108
 8f6:	02f71663          	bne	a4,a5,922 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8fa:	fb843783          	ld	a5,-72(s0)
 8fe:	00878713          	addi	a4,a5,8
 902:	fae43c23          	sd	a4,-72(s0)
 906:	639c                	ld	a5,0(a5)
 908:	0007871b          	sext.w	a4,a5
 90c:	fcc42783          	lw	a5,-52(s0)
 910:	4681                	li	a3,0
 912:	4629                	li	a2,10
 914:	85ba                	mv	a1,a4
 916:	853e                	mv	a0,a5
 918:	00000097          	auipc	ra,0x0
 91c:	d86080e7          	jalr	-634(ra) # 69e <printint>
 920:	aa89                	j	a72 <vprintf+0x23a>
      } else if(c == 'x') {
 922:	fdc42783          	lw	a5,-36(s0)
 926:	0007871b          	sext.w	a4,a5
 92a:	07800793          	li	a5,120
 92e:	02f71463          	bne	a4,a5,956 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 932:	fb843783          	ld	a5,-72(s0)
 936:	00878713          	addi	a4,a5,8
 93a:	fae43c23          	sd	a4,-72(s0)
 93e:	4398                	lw	a4,0(a5)
 940:	fcc42783          	lw	a5,-52(s0)
 944:	4681                	li	a3,0
 946:	4641                	li	a2,16
 948:	85ba                	mv	a1,a4
 94a:	853e                	mv	a0,a5
 94c:	00000097          	auipc	ra,0x0
 950:	d52080e7          	jalr	-686(ra) # 69e <printint>
 954:	aa39                	j	a72 <vprintf+0x23a>
      } else if(c == 'p') {
 956:	fdc42783          	lw	a5,-36(s0)
 95a:	0007871b          	sext.w	a4,a5
 95e:	07000793          	li	a5,112
 962:	02f71263          	bne	a4,a5,986 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 966:	fb843783          	ld	a5,-72(s0)
 96a:	00878713          	addi	a4,a5,8
 96e:	fae43c23          	sd	a4,-72(s0)
 972:	6398                	ld	a4,0(a5)
 974:	fcc42783          	lw	a5,-52(s0)
 978:	85ba                	mv	a1,a4
 97a:	853e                	mv	a0,a5
 97c:	00000097          	auipc	ra,0x0
 980:	e30080e7          	jalr	-464(ra) # 7ac <printptr>
 984:	a0fd                	j	a72 <vprintf+0x23a>
      } else if(c == 's'){
 986:	fdc42783          	lw	a5,-36(s0)
 98a:	0007871b          	sext.w	a4,a5
 98e:	07300793          	li	a5,115
 992:	04f71c63          	bne	a4,a5,9ea <vprintf+0x1b2>
        s = va_arg(ap, char*);
 996:	fb843783          	ld	a5,-72(s0)
 99a:	00878713          	addi	a4,a5,8
 99e:	fae43c23          	sd	a4,-72(s0)
 9a2:	639c                	ld	a5,0(a5)
 9a4:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 9a8:	fe843783          	ld	a5,-24(s0)
 9ac:	eb8d                	bnez	a5,9de <vprintf+0x1a6>
          s = "(null)";
 9ae:	00000797          	auipc	a5,0x0
 9b2:	4fa78793          	addi	a5,a5,1274 # ea8 <malloc+0x1c0>
 9b6:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9ba:	a015                	j	9de <vprintf+0x1a6>
          putc(fd, *s);
 9bc:	fe843783          	ld	a5,-24(s0)
 9c0:	0007c703          	lbu	a4,0(a5)
 9c4:	fcc42783          	lw	a5,-52(s0)
 9c8:	85ba                	mv	a1,a4
 9ca:	853e                	mv	a0,a5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	c9c080e7          	jalr	-868(ra) # 668 <putc>
          s++;
 9d4:	fe843783          	ld	a5,-24(s0)
 9d8:	0785                	addi	a5,a5,1
 9da:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9de:	fe843783          	ld	a5,-24(s0)
 9e2:	0007c783          	lbu	a5,0(a5)
 9e6:	fbf9                	bnez	a5,9bc <vprintf+0x184>
 9e8:	a069                	j	a72 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 9ea:	fdc42783          	lw	a5,-36(s0)
 9ee:	0007871b          	sext.w	a4,a5
 9f2:	06300793          	li	a5,99
 9f6:	02f71463          	bne	a4,a5,a1e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 9fa:	fb843783          	ld	a5,-72(s0)
 9fe:	00878713          	addi	a4,a5,8
 a02:	fae43c23          	sd	a4,-72(s0)
 a06:	439c                	lw	a5,0(a5)
 a08:	0ff7f713          	andi	a4,a5,255
 a0c:	fcc42783          	lw	a5,-52(s0)
 a10:	85ba                	mv	a1,a4
 a12:	853e                	mv	a0,a5
 a14:	00000097          	auipc	ra,0x0
 a18:	c54080e7          	jalr	-940(ra) # 668 <putc>
 a1c:	a899                	j	a72 <vprintf+0x23a>
      } else if(c == '%'){
 a1e:	fdc42783          	lw	a5,-36(s0)
 a22:	0007871b          	sext.w	a4,a5
 a26:	02500793          	li	a5,37
 a2a:	00f71f63          	bne	a4,a5,a48 <vprintf+0x210>
        putc(fd, c);
 a2e:	fdc42783          	lw	a5,-36(s0)
 a32:	0ff7f713          	andi	a4,a5,255
 a36:	fcc42783          	lw	a5,-52(s0)
 a3a:	85ba                	mv	a1,a4
 a3c:	853e                	mv	a0,a5
 a3e:	00000097          	auipc	ra,0x0
 a42:	c2a080e7          	jalr	-982(ra) # 668 <putc>
 a46:	a035                	j	a72 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a48:	fcc42783          	lw	a5,-52(s0)
 a4c:	02500593          	li	a1,37
 a50:	853e                	mv	a0,a5
 a52:	00000097          	auipc	ra,0x0
 a56:	c16080e7          	jalr	-1002(ra) # 668 <putc>
        putc(fd, c);
 a5a:	fdc42783          	lw	a5,-36(s0)
 a5e:	0ff7f713          	andi	a4,a5,255
 a62:	fcc42783          	lw	a5,-52(s0)
 a66:	85ba                	mv	a1,a4
 a68:	853e                	mv	a0,a5
 a6a:	00000097          	auipc	ra,0x0
 a6e:	bfe080e7          	jalr	-1026(ra) # 668 <putc>
      }
      state = 0;
 a72:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a76:	fe442783          	lw	a5,-28(s0)
 a7a:	2785                	addiw	a5,a5,1
 a7c:	fef42223          	sw	a5,-28(s0)
 a80:	fe442783          	lw	a5,-28(s0)
 a84:	fc043703          	ld	a4,-64(s0)
 a88:	97ba                	add	a5,a5,a4
 a8a:	0007c783          	lbu	a5,0(a5)
 a8e:	dc0795e3          	bnez	a5,858 <vprintf+0x20>
    }
  }
}
 a92:	0001                	nop
 a94:	0001                	nop
 a96:	60a6                	ld	ra,72(sp)
 a98:	6406                	ld	s0,64(sp)
 a9a:	6161                	addi	sp,sp,80
 a9c:	8082                	ret

0000000000000a9e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a9e:	7159                	addi	sp,sp,-112
 aa0:	fc06                	sd	ra,56(sp)
 aa2:	f822                	sd	s0,48(sp)
 aa4:	0080                	addi	s0,sp,64
 aa6:	fcb43823          	sd	a1,-48(s0)
 aaa:	e010                	sd	a2,0(s0)
 aac:	e414                	sd	a3,8(s0)
 aae:	e818                	sd	a4,16(s0)
 ab0:	ec1c                	sd	a5,24(s0)
 ab2:	03043023          	sd	a6,32(s0)
 ab6:	03143423          	sd	a7,40(s0)
 aba:	87aa                	mv	a5,a0
 abc:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 ac0:	03040793          	addi	a5,s0,48
 ac4:	fcf43423          	sd	a5,-56(s0)
 ac8:	fc843783          	ld	a5,-56(s0)
 acc:	fd078793          	addi	a5,a5,-48
 ad0:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 ad4:	fe843703          	ld	a4,-24(s0)
 ad8:	fdc42783          	lw	a5,-36(s0)
 adc:	863a                	mv	a2,a4
 ade:	fd043583          	ld	a1,-48(s0)
 ae2:	853e                	mv	a0,a5
 ae4:	00000097          	auipc	ra,0x0
 ae8:	d54080e7          	jalr	-684(ra) # 838 <vprintf>
}
 aec:	0001                	nop
 aee:	70e2                	ld	ra,56(sp)
 af0:	7442                	ld	s0,48(sp)
 af2:	6165                	addi	sp,sp,112
 af4:	8082                	ret

0000000000000af6 <printf>:

void
printf(const char *fmt, ...)
{
 af6:	7159                	addi	sp,sp,-112
 af8:	f406                	sd	ra,40(sp)
 afa:	f022                	sd	s0,32(sp)
 afc:	1800                	addi	s0,sp,48
 afe:	fca43c23          	sd	a0,-40(s0)
 b02:	e40c                	sd	a1,8(s0)
 b04:	e810                	sd	a2,16(s0)
 b06:	ec14                	sd	a3,24(s0)
 b08:	f018                	sd	a4,32(s0)
 b0a:	f41c                	sd	a5,40(s0)
 b0c:	03043823          	sd	a6,48(s0)
 b10:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b14:	04040793          	addi	a5,s0,64
 b18:	fcf43823          	sd	a5,-48(s0)
 b1c:	fd043783          	ld	a5,-48(s0)
 b20:	fc878793          	addi	a5,a5,-56
 b24:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b28:	fe843783          	ld	a5,-24(s0)
 b2c:	863e                	mv	a2,a5
 b2e:	fd843583          	ld	a1,-40(s0)
 b32:	4505                	li	a0,1
 b34:	00000097          	auipc	ra,0x0
 b38:	d04080e7          	jalr	-764(ra) # 838 <vprintf>
}
 b3c:	0001                	nop
 b3e:	70a2                	ld	ra,40(sp)
 b40:	7402                	ld	s0,32(sp)
 b42:	6165                	addi	sp,sp,112
 b44:	8082                	ret

0000000000000b46 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b46:	7179                	addi	sp,sp,-48
 b48:	f422                	sd	s0,40(sp)
 b4a:	1800                	addi	s0,sp,48
 b4c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b50:	fd843783          	ld	a5,-40(s0)
 b54:	17c1                	addi	a5,a5,-16
 b56:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b5a:	00000797          	auipc	a5,0x0
 b5e:	4e678793          	addi	a5,a5,1254 # 1040 <freep>
 b62:	639c                	ld	a5,0(a5)
 b64:	fef43423          	sd	a5,-24(s0)
 b68:	a815                	j	b9c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6a:	fe843783          	ld	a5,-24(s0)
 b6e:	639c                	ld	a5,0(a5)
 b70:	fe843703          	ld	a4,-24(s0)
 b74:	00f76f63          	bltu	a4,a5,b92 <free+0x4c>
 b78:	fe043703          	ld	a4,-32(s0)
 b7c:	fe843783          	ld	a5,-24(s0)
 b80:	02e7eb63          	bltu	a5,a4,bb6 <free+0x70>
 b84:	fe843783          	ld	a5,-24(s0)
 b88:	639c                	ld	a5,0(a5)
 b8a:	fe043703          	ld	a4,-32(s0)
 b8e:	02f76463          	bltu	a4,a5,bb6 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b92:	fe843783          	ld	a5,-24(s0)
 b96:	639c                	ld	a5,0(a5)
 b98:	fef43423          	sd	a5,-24(s0)
 b9c:	fe043703          	ld	a4,-32(s0)
 ba0:	fe843783          	ld	a5,-24(s0)
 ba4:	fce7f3e3          	bgeu	a5,a4,b6a <free+0x24>
 ba8:	fe843783          	ld	a5,-24(s0)
 bac:	639c                	ld	a5,0(a5)
 bae:	fe043703          	ld	a4,-32(s0)
 bb2:	faf77ce3          	bgeu	a4,a5,b6a <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bb6:	fe043783          	ld	a5,-32(s0)
 bba:	479c                	lw	a5,8(a5)
 bbc:	1782                	slli	a5,a5,0x20
 bbe:	9381                	srli	a5,a5,0x20
 bc0:	0792                	slli	a5,a5,0x4
 bc2:	fe043703          	ld	a4,-32(s0)
 bc6:	973e                	add	a4,a4,a5
 bc8:	fe843783          	ld	a5,-24(s0)
 bcc:	639c                	ld	a5,0(a5)
 bce:	02f71763          	bne	a4,a5,bfc <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 bd2:	fe043783          	ld	a5,-32(s0)
 bd6:	4798                	lw	a4,8(a5)
 bd8:	fe843783          	ld	a5,-24(s0)
 bdc:	639c                	ld	a5,0(a5)
 bde:	479c                	lw	a5,8(a5)
 be0:	9fb9                	addw	a5,a5,a4
 be2:	0007871b          	sext.w	a4,a5
 be6:	fe043783          	ld	a5,-32(s0)
 bea:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 bec:	fe843783          	ld	a5,-24(s0)
 bf0:	639c                	ld	a5,0(a5)
 bf2:	6398                	ld	a4,0(a5)
 bf4:	fe043783          	ld	a5,-32(s0)
 bf8:	e398                	sd	a4,0(a5)
 bfa:	a039                	j	c08 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 bfc:	fe843783          	ld	a5,-24(s0)
 c00:	6398                	ld	a4,0(a5)
 c02:	fe043783          	ld	a5,-32(s0)
 c06:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c08:	fe843783          	ld	a5,-24(s0)
 c0c:	479c                	lw	a5,8(a5)
 c0e:	1782                	slli	a5,a5,0x20
 c10:	9381                	srli	a5,a5,0x20
 c12:	0792                	slli	a5,a5,0x4
 c14:	fe843703          	ld	a4,-24(s0)
 c18:	97ba                	add	a5,a5,a4
 c1a:	fe043703          	ld	a4,-32(s0)
 c1e:	02f71563          	bne	a4,a5,c48 <free+0x102>
    p->s.size += bp->s.size;
 c22:	fe843783          	ld	a5,-24(s0)
 c26:	4798                	lw	a4,8(a5)
 c28:	fe043783          	ld	a5,-32(s0)
 c2c:	479c                	lw	a5,8(a5)
 c2e:	9fb9                	addw	a5,a5,a4
 c30:	0007871b          	sext.w	a4,a5
 c34:	fe843783          	ld	a5,-24(s0)
 c38:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c3a:	fe043783          	ld	a5,-32(s0)
 c3e:	6398                	ld	a4,0(a5)
 c40:	fe843783          	ld	a5,-24(s0)
 c44:	e398                	sd	a4,0(a5)
 c46:	a031                	j	c52 <free+0x10c>
  } else
    p->s.ptr = bp;
 c48:	fe843783          	ld	a5,-24(s0)
 c4c:	fe043703          	ld	a4,-32(s0)
 c50:	e398                	sd	a4,0(a5)
  freep = p;
 c52:	00000797          	auipc	a5,0x0
 c56:	3ee78793          	addi	a5,a5,1006 # 1040 <freep>
 c5a:	fe843703          	ld	a4,-24(s0)
 c5e:	e398                	sd	a4,0(a5)
}
 c60:	0001                	nop
 c62:	7422                	ld	s0,40(sp)
 c64:	6145                	addi	sp,sp,48
 c66:	8082                	ret

0000000000000c68 <morecore>:

static Header*
morecore(uint nu)
{
 c68:	7179                	addi	sp,sp,-48
 c6a:	f406                	sd	ra,40(sp)
 c6c:	f022                	sd	s0,32(sp)
 c6e:	1800                	addi	s0,sp,48
 c70:	87aa                	mv	a5,a0
 c72:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c76:	fdc42783          	lw	a5,-36(s0)
 c7a:	0007871b          	sext.w	a4,a5
 c7e:	6785                	lui	a5,0x1
 c80:	00f77563          	bgeu	a4,a5,c8a <morecore+0x22>
    nu = 4096;
 c84:	6785                	lui	a5,0x1
 c86:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c8a:	fdc42783          	lw	a5,-36(s0)
 c8e:	0047979b          	slliw	a5,a5,0x4
 c92:	2781                	sext.w	a5,a5
 c94:	2781                	sext.w	a5,a5
 c96:	853e                	mv	a0,a5
 c98:	00000097          	auipc	ra,0x0
 c9c:	9b8080e7          	jalr	-1608(ra) # 650 <sbrk>
 ca0:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 ca4:	fe843703          	ld	a4,-24(s0)
 ca8:	57fd                	li	a5,-1
 caa:	00f71463          	bne	a4,a5,cb2 <morecore+0x4a>
    return 0;
 cae:	4781                	li	a5,0
 cb0:	a03d                	j	cde <morecore+0x76>
  hp = (Header*)p;
 cb2:	fe843783          	ld	a5,-24(s0)
 cb6:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 cba:	fe043783          	ld	a5,-32(s0)
 cbe:	fdc42703          	lw	a4,-36(s0)
 cc2:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 cc4:	fe043783          	ld	a5,-32(s0)
 cc8:	07c1                	addi	a5,a5,16
 cca:	853e                	mv	a0,a5
 ccc:	00000097          	auipc	ra,0x0
 cd0:	e7a080e7          	jalr	-390(ra) # b46 <free>
  return freep;
 cd4:	00000797          	auipc	a5,0x0
 cd8:	36c78793          	addi	a5,a5,876 # 1040 <freep>
 cdc:	639c                	ld	a5,0(a5)
}
 cde:	853e                	mv	a0,a5
 ce0:	70a2                	ld	ra,40(sp)
 ce2:	7402                	ld	s0,32(sp)
 ce4:	6145                	addi	sp,sp,48
 ce6:	8082                	ret

0000000000000ce8 <malloc>:

void*
malloc(uint nbytes)
{
 ce8:	7139                	addi	sp,sp,-64
 cea:	fc06                	sd	ra,56(sp)
 cec:	f822                	sd	s0,48(sp)
 cee:	0080                	addi	s0,sp,64
 cf0:	87aa                	mv	a5,a0
 cf2:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cf6:	fcc46783          	lwu	a5,-52(s0)
 cfa:	07bd                	addi	a5,a5,15
 cfc:	8391                	srli	a5,a5,0x4
 cfe:	2781                	sext.w	a5,a5
 d00:	2785                	addiw	a5,a5,1
 d02:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d06:	00000797          	auipc	a5,0x0
 d0a:	33a78793          	addi	a5,a5,826 # 1040 <freep>
 d0e:	639c                	ld	a5,0(a5)
 d10:	fef43023          	sd	a5,-32(s0)
 d14:	fe043783          	ld	a5,-32(s0)
 d18:	ef95                	bnez	a5,d54 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d1a:	00000797          	auipc	a5,0x0
 d1e:	31678793          	addi	a5,a5,790 # 1030 <base>
 d22:	fef43023          	sd	a5,-32(s0)
 d26:	00000797          	auipc	a5,0x0
 d2a:	31a78793          	addi	a5,a5,794 # 1040 <freep>
 d2e:	fe043703          	ld	a4,-32(s0)
 d32:	e398                	sd	a4,0(a5)
 d34:	00000797          	auipc	a5,0x0
 d38:	30c78793          	addi	a5,a5,780 # 1040 <freep>
 d3c:	6398                	ld	a4,0(a5)
 d3e:	00000797          	auipc	a5,0x0
 d42:	2f278793          	addi	a5,a5,754 # 1030 <base>
 d46:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d48:	00000797          	auipc	a5,0x0
 d4c:	2e878793          	addi	a5,a5,744 # 1030 <base>
 d50:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d54:	fe043783          	ld	a5,-32(s0)
 d58:	639c                	ld	a5,0(a5)
 d5a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	4798                	lw	a4,8(a5)
 d64:	fdc42783          	lw	a5,-36(s0)
 d68:	2781                	sext.w	a5,a5
 d6a:	06f76863          	bltu	a4,a5,dda <malloc+0xf2>
      if(p->s.size == nunits)
 d6e:	fe843783          	ld	a5,-24(s0)
 d72:	4798                	lw	a4,8(a5)
 d74:	fdc42783          	lw	a5,-36(s0)
 d78:	2781                	sext.w	a5,a5
 d7a:	00e79963          	bne	a5,a4,d8c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d7e:	fe843783          	ld	a5,-24(s0)
 d82:	6398                	ld	a4,0(a5)
 d84:	fe043783          	ld	a5,-32(s0)
 d88:	e398                	sd	a4,0(a5)
 d8a:	a82d                	j	dc4 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 d8c:	fe843783          	ld	a5,-24(s0)
 d90:	4798                	lw	a4,8(a5)
 d92:	fdc42783          	lw	a5,-36(s0)
 d96:	40f707bb          	subw	a5,a4,a5
 d9a:	0007871b          	sext.w	a4,a5
 d9e:	fe843783          	ld	a5,-24(s0)
 da2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 da4:	fe843783          	ld	a5,-24(s0)
 da8:	479c                	lw	a5,8(a5)
 daa:	1782                	slli	a5,a5,0x20
 dac:	9381                	srli	a5,a5,0x20
 dae:	0792                	slli	a5,a5,0x4
 db0:	fe843703          	ld	a4,-24(s0)
 db4:	97ba                	add	a5,a5,a4
 db6:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 dba:	fe843783          	ld	a5,-24(s0)
 dbe:	fdc42703          	lw	a4,-36(s0)
 dc2:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 dc4:	00000797          	auipc	a5,0x0
 dc8:	27c78793          	addi	a5,a5,636 # 1040 <freep>
 dcc:	fe043703          	ld	a4,-32(s0)
 dd0:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 dd2:	fe843783          	ld	a5,-24(s0)
 dd6:	07c1                	addi	a5,a5,16
 dd8:	a091                	j	e1c <malloc+0x134>
    }
    if(p == freep)
 dda:	00000797          	auipc	a5,0x0
 dde:	26678793          	addi	a5,a5,614 # 1040 <freep>
 de2:	639c                	ld	a5,0(a5)
 de4:	fe843703          	ld	a4,-24(s0)
 de8:	02f71063          	bne	a4,a5,e08 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 dec:	fdc42783          	lw	a5,-36(s0)
 df0:	853e                	mv	a0,a5
 df2:	00000097          	auipc	ra,0x0
 df6:	e76080e7          	jalr	-394(ra) # c68 <morecore>
 dfa:	fea43423          	sd	a0,-24(s0)
 dfe:	fe843783          	ld	a5,-24(s0)
 e02:	e399                	bnez	a5,e08 <malloc+0x120>
        return 0;
 e04:	4781                	li	a5,0
 e06:	a819                	j	e1c <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e08:	fe843783          	ld	a5,-24(s0)
 e0c:	fef43023          	sd	a5,-32(s0)
 e10:	fe843783          	ld	a5,-24(s0)
 e14:	639c                	ld	a5,0(a5)
 e16:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e1a:	b791                	j	d5e <malloc+0x76>
  }
}
 e1c:	853e                	mv	a0,a5
 e1e:	70e2                	ld	ra,56(sp)
 e20:	7442                	ld	s0,48(sp)
 e22:	6121                	addi	sp,sp,64
 e24:	8082                	ret
