
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
  12:	fdc42783          	lw	a5,-36(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	4785                	li	a5,1
  1c:	02e7c063          	blt	a5,a4,3c <main+0x3c>
    fprintf(2, "usage: kill pid...\n");
  20:	00001597          	auipc	a1,0x1
  24:	d8058593          	addi	a1,a1,-640 # da0 <malloc+0x14a>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9e2080e7          	jalr	-1566(ra) # a0c <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	502080e7          	jalr	1282(ra) # 536 <exit>
  }
  for(i=1; i<argc; i++)
  3c:	4785                	li	a5,1
  3e:	fef42623          	sw	a5,-20(s0)
  42:	a805                	j	72 <main+0x72>
    kill(atoi(argv[i]));
  44:	fec42783          	lw	a5,-20(s0)
  48:	078e                	slli	a5,a5,0x3
  4a:	fd043703          	ld	a4,-48(s0)
  4e:	97ba                	add	a5,a5,a4
  50:	639c                	ld	a5,0(a5)
  52:	853e                	mv	a0,a5
  54:	00000097          	auipc	ra,0x0
  58:	2ea080e7          	jalr	746(ra) # 33e <atoi>
  5c:	87aa                	mv	a5,a0
  5e:	853e                	mv	a0,a5
  60:	00000097          	auipc	ra,0x0
  64:	506080e7          	jalr	1286(ra) # 566 <kill>
  for(i=1; i<argc; i++)
  68:	fec42783          	lw	a5,-20(s0)
  6c:	2785                	addiw	a5,a5,1
  6e:	fef42623          	sw	a5,-20(s0)
  72:	fec42703          	lw	a4,-20(s0)
  76:	fdc42783          	lw	a5,-36(s0)
  7a:	2701                	sext.w	a4,a4
  7c:	2781                	sext.w	a5,a5
  7e:	fcf743e3          	blt	a4,a5,44 <main+0x44>
  exit(0);
  82:	4501                	li	a0,0
  84:	00000097          	auipc	ra,0x0
  88:	4b2080e7          	jalr	1202(ra) # 536 <exit>

000000000000008c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  8c:	1141                	addi	sp,sp,-16
  8e:	e406                	sd	ra,8(sp)
  90:	e022                	sd	s0,0(sp)
  92:	0800                	addi	s0,sp,16
  extern int main();
  main();
  94:	00000097          	auipc	ra,0x0
  98:	f6c080e7          	jalr	-148(ra) # 0 <main>
  exit(0);
  9c:	4501                	li	a0,0
  9e:	00000097          	auipc	ra,0x0
  a2:	498080e7          	jalr	1176(ra) # 536 <exit>

00000000000000a6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  a6:	7179                	addi	sp,sp,-48
  a8:	f422                	sd	s0,40(sp)
  aa:	1800                	addi	s0,sp,48
  ac:	fca43c23          	sd	a0,-40(s0)
  b0:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  b4:	fd843783          	ld	a5,-40(s0)
  b8:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  bc:	0001                	nop
  be:	fd043703          	ld	a4,-48(s0)
  c2:	00170793          	addi	a5,a4,1
  c6:	fcf43823          	sd	a5,-48(s0)
  ca:	fd843783          	ld	a5,-40(s0)
  ce:	00178693          	addi	a3,a5,1
  d2:	fcd43c23          	sd	a3,-40(s0)
  d6:	00074703          	lbu	a4,0(a4)
  da:	00e78023          	sb	a4,0(a5)
  de:	0007c783          	lbu	a5,0(a5)
  e2:	fff1                	bnez	a5,be <strcpy+0x18>
    ;
  return os;
  e4:	fe843783          	ld	a5,-24(s0)
}
  e8:	853e                	mv	a0,a5
  ea:	7422                	ld	s0,40(sp)
  ec:	6145                	addi	sp,sp,48
  ee:	8082                	ret

00000000000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	1101                	addi	sp,sp,-32
  f2:	ec22                	sd	s0,24(sp)
  f4:	1000                	addi	s0,sp,32
  f6:	fea43423          	sd	a0,-24(s0)
  fa:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  fe:	a819                	j	114 <strcmp+0x24>
    p++, q++;
 100:	fe843783          	ld	a5,-24(s0)
 104:	0785                	addi	a5,a5,1
 106:	fef43423          	sd	a5,-24(s0)
 10a:	fe043783          	ld	a5,-32(s0)
 10e:	0785                	addi	a5,a5,1
 110:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 114:	fe843783          	ld	a5,-24(s0)
 118:	0007c783          	lbu	a5,0(a5)
 11c:	cb99                	beqz	a5,132 <strcmp+0x42>
 11e:	fe843783          	ld	a5,-24(s0)
 122:	0007c703          	lbu	a4,0(a5)
 126:	fe043783          	ld	a5,-32(s0)
 12a:	0007c783          	lbu	a5,0(a5)
 12e:	fcf709e3          	beq	a4,a5,100 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 132:	fe843783          	ld	a5,-24(s0)
 136:	0007c783          	lbu	a5,0(a5)
 13a:	0007871b          	sext.w	a4,a5
 13e:	fe043783          	ld	a5,-32(s0)
 142:	0007c783          	lbu	a5,0(a5)
 146:	2781                	sext.w	a5,a5
 148:	40f707bb          	subw	a5,a4,a5
 14c:	2781                	sext.w	a5,a5
}
 14e:	853e                	mv	a0,a5
 150:	6462                	ld	s0,24(sp)
 152:	6105                	addi	sp,sp,32
 154:	8082                	ret

0000000000000156 <strlen>:

uint
strlen(const char *s)
{
 156:	7179                	addi	sp,sp,-48
 158:	f422                	sd	s0,40(sp)
 15a:	1800                	addi	s0,sp,48
 15c:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 160:	fe042623          	sw	zero,-20(s0)
 164:	a031                	j	170 <strlen+0x1a>
 166:	fec42783          	lw	a5,-20(s0)
 16a:	2785                	addiw	a5,a5,1
 16c:	fef42623          	sw	a5,-20(s0)
 170:	fec42783          	lw	a5,-20(s0)
 174:	fd843703          	ld	a4,-40(s0)
 178:	97ba                	add	a5,a5,a4
 17a:	0007c783          	lbu	a5,0(a5)
 17e:	f7e5                	bnez	a5,166 <strlen+0x10>
    ;
  return n;
 180:	fec42783          	lw	a5,-20(s0)
}
 184:	853e                	mv	a0,a5
 186:	7422                	ld	s0,40(sp)
 188:	6145                	addi	sp,sp,48
 18a:	8082                	ret

000000000000018c <memset>:

void*
memset(void *dst, int c, uint n)
{
 18c:	7179                	addi	sp,sp,-48
 18e:	f422                	sd	s0,40(sp)
 190:	1800                	addi	s0,sp,48
 192:	fca43c23          	sd	a0,-40(s0)
 196:	87ae                	mv	a5,a1
 198:	8732                	mv	a4,a2
 19a:	fcf42a23          	sw	a5,-44(s0)
 19e:	87ba                	mv	a5,a4
 1a0:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1a4:	fd843783          	ld	a5,-40(s0)
 1a8:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1ac:	fe042623          	sw	zero,-20(s0)
 1b0:	a00d                	j	1d2 <memset+0x46>
    cdst[i] = c;
 1b2:	fec42783          	lw	a5,-20(s0)
 1b6:	fe043703          	ld	a4,-32(s0)
 1ba:	97ba                	add	a5,a5,a4
 1bc:	fd442703          	lw	a4,-44(s0)
 1c0:	0ff77713          	andi	a4,a4,255
 1c4:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1c8:	fec42783          	lw	a5,-20(s0)
 1cc:	2785                	addiw	a5,a5,1
 1ce:	fef42623          	sw	a5,-20(s0)
 1d2:	fec42703          	lw	a4,-20(s0)
 1d6:	fd042783          	lw	a5,-48(s0)
 1da:	2781                	sext.w	a5,a5
 1dc:	fcf76be3          	bltu	a4,a5,1b2 <memset+0x26>
  }
  return dst;
 1e0:	fd843783          	ld	a5,-40(s0)
}
 1e4:	853e                	mv	a0,a5
 1e6:	7422                	ld	s0,40(sp)
 1e8:	6145                	addi	sp,sp,48
 1ea:	8082                	ret

00000000000001ec <strchr>:

char*
strchr(const char *s, char c)
{
 1ec:	1101                	addi	sp,sp,-32
 1ee:	ec22                	sd	s0,24(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	fea43423          	sd	a0,-24(s0)
 1f6:	87ae                	mv	a5,a1
 1f8:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1fc:	a01d                	j	222 <strchr+0x36>
    if(*s == c)
 1fe:	fe843783          	ld	a5,-24(s0)
 202:	0007c703          	lbu	a4,0(a5)
 206:	fe744783          	lbu	a5,-25(s0)
 20a:	0ff7f793          	andi	a5,a5,255
 20e:	00e79563          	bne	a5,a4,218 <strchr+0x2c>
      return (char*)s;
 212:	fe843783          	ld	a5,-24(s0)
 216:	a821                	j	22e <strchr+0x42>
  for(; *s; s++)
 218:	fe843783          	ld	a5,-24(s0)
 21c:	0785                	addi	a5,a5,1
 21e:	fef43423          	sd	a5,-24(s0)
 222:	fe843783          	ld	a5,-24(s0)
 226:	0007c783          	lbu	a5,0(a5)
 22a:	fbf1                	bnez	a5,1fe <strchr+0x12>
  return 0;
 22c:	4781                	li	a5,0
}
 22e:	853e                	mv	a0,a5
 230:	6462                	ld	s0,24(sp)
 232:	6105                	addi	sp,sp,32
 234:	8082                	ret

0000000000000236 <gets>:

char*
gets(char *buf, int max)
{
 236:	7179                	addi	sp,sp,-48
 238:	f406                	sd	ra,40(sp)
 23a:	f022                	sd	s0,32(sp)
 23c:	1800                	addi	s0,sp,48
 23e:	fca43c23          	sd	a0,-40(s0)
 242:	87ae                	mv	a5,a1
 244:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 248:	fe042623          	sw	zero,-20(s0)
 24c:	a8a1                	j	2a4 <gets+0x6e>
    cc = read(0, &c, 1);
 24e:	fe740793          	addi	a5,s0,-25
 252:	4605                	li	a2,1
 254:	85be                	mv	a1,a5
 256:	4501                	li	a0,0
 258:	00000097          	auipc	ra,0x0
 25c:	2f6080e7          	jalr	758(ra) # 54e <read>
 260:	87aa                	mv	a5,a0
 262:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 266:	fe842783          	lw	a5,-24(s0)
 26a:	2781                	sext.w	a5,a5
 26c:	04f05763          	blez	a5,2ba <gets+0x84>
      break;
    buf[i++] = c;
 270:	fec42783          	lw	a5,-20(s0)
 274:	0017871b          	addiw	a4,a5,1
 278:	fee42623          	sw	a4,-20(s0)
 27c:	873e                	mv	a4,a5
 27e:	fd843783          	ld	a5,-40(s0)
 282:	97ba                	add	a5,a5,a4
 284:	fe744703          	lbu	a4,-25(s0)
 288:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 28c:	fe744783          	lbu	a5,-25(s0)
 290:	873e                	mv	a4,a5
 292:	47a9                	li	a5,10
 294:	02f70463          	beq	a4,a5,2bc <gets+0x86>
 298:	fe744783          	lbu	a5,-25(s0)
 29c:	873e                	mv	a4,a5
 29e:	47b5                	li	a5,13
 2a0:	00f70e63          	beq	a4,a5,2bc <gets+0x86>
  for(i=0; i+1 < max; ){
 2a4:	fec42783          	lw	a5,-20(s0)
 2a8:	2785                	addiw	a5,a5,1
 2aa:	0007871b          	sext.w	a4,a5
 2ae:	fd442783          	lw	a5,-44(s0)
 2b2:	2781                	sext.w	a5,a5
 2b4:	f8f74de3          	blt	a4,a5,24e <gets+0x18>
 2b8:	a011                	j	2bc <gets+0x86>
      break;
 2ba:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2bc:	fec42783          	lw	a5,-20(s0)
 2c0:	fd843703          	ld	a4,-40(s0)
 2c4:	97ba                	add	a5,a5,a4
 2c6:	00078023          	sb	zero,0(a5)
  return buf;
 2ca:	fd843783          	ld	a5,-40(s0)
}
 2ce:	853e                	mv	a0,a5
 2d0:	70a2                	ld	ra,40(sp)
 2d2:	7402                	ld	s0,32(sp)
 2d4:	6145                	addi	sp,sp,48
 2d6:	8082                	ret

00000000000002d8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d8:	7179                	addi	sp,sp,-48
 2da:	f406                	sd	ra,40(sp)
 2dc:	f022                	sd	s0,32(sp)
 2de:	1800                	addi	s0,sp,48
 2e0:	fca43c23          	sd	a0,-40(s0)
 2e4:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e8:	4581                	li	a1,0
 2ea:	fd843503          	ld	a0,-40(s0)
 2ee:	00000097          	auipc	ra,0x0
 2f2:	288080e7          	jalr	648(ra) # 576 <open>
 2f6:	87aa                	mv	a5,a0
 2f8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2fc:	fec42783          	lw	a5,-20(s0)
 300:	2781                	sext.w	a5,a5
 302:	0007d463          	bgez	a5,30a <stat+0x32>
    return -1;
 306:	57fd                	li	a5,-1
 308:	a035                	j	334 <stat+0x5c>
  r = fstat(fd, st);
 30a:	fec42783          	lw	a5,-20(s0)
 30e:	fd043583          	ld	a1,-48(s0)
 312:	853e                	mv	a0,a5
 314:	00000097          	auipc	ra,0x0
 318:	27a080e7          	jalr	634(ra) # 58e <fstat>
 31c:	87aa                	mv	a5,a0
 31e:	fef42423          	sw	a5,-24(s0)
  close(fd);
 322:	fec42783          	lw	a5,-20(s0)
 326:	853e                	mv	a0,a5
 328:	00000097          	auipc	ra,0x0
 32c:	236080e7          	jalr	566(ra) # 55e <close>
  return r;
 330:	fe842783          	lw	a5,-24(s0)
}
 334:	853e                	mv	a0,a5
 336:	70a2                	ld	ra,40(sp)
 338:	7402                	ld	s0,32(sp)
 33a:	6145                	addi	sp,sp,48
 33c:	8082                	ret

000000000000033e <atoi>:

int
atoi(const char *s)
{
 33e:	7179                	addi	sp,sp,-48
 340:	f422                	sd	s0,40(sp)
 342:	1800                	addi	s0,sp,48
 344:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 348:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 34c:	a815                	j	380 <atoi+0x42>
    n = n*10 + *s++ - '0';
 34e:	fec42703          	lw	a4,-20(s0)
 352:	87ba                	mv	a5,a4
 354:	0027979b          	slliw	a5,a5,0x2
 358:	9fb9                	addw	a5,a5,a4
 35a:	0017979b          	slliw	a5,a5,0x1
 35e:	0007871b          	sext.w	a4,a5
 362:	fd843783          	ld	a5,-40(s0)
 366:	00178693          	addi	a3,a5,1
 36a:	fcd43c23          	sd	a3,-40(s0)
 36e:	0007c783          	lbu	a5,0(a5)
 372:	2781                	sext.w	a5,a5
 374:	9fb9                	addw	a5,a5,a4
 376:	2781                	sext.w	a5,a5
 378:	fd07879b          	addiw	a5,a5,-48
 37c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 380:	fd843783          	ld	a5,-40(s0)
 384:	0007c783          	lbu	a5,0(a5)
 388:	873e                	mv	a4,a5
 38a:	02f00793          	li	a5,47
 38e:	00e7fb63          	bgeu	a5,a4,3a4 <atoi+0x66>
 392:	fd843783          	ld	a5,-40(s0)
 396:	0007c783          	lbu	a5,0(a5)
 39a:	873e                	mv	a4,a5
 39c:	03900793          	li	a5,57
 3a0:	fae7f7e3          	bgeu	a5,a4,34e <atoi+0x10>
  return n;
 3a4:	fec42783          	lw	a5,-20(s0)
}
 3a8:	853e                	mv	a0,a5
 3aa:	7422                	ld	s0,40(sp)
 3ac:	6145                	addi	sp,sp,48
 3ae:	8082                	ret

00000000000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	7139                	addi	sp,sp,-64
 3b2:	fc22                	sd	s0,56(sp)
 3b4:	0080                	addi	s0,sp,64
 3b6:	fca43c23          	sd	a0,-40(s0)
 3ba:	fcb43823          	sd	a1,-48(s0)
 3be:	87b2                	mv	a5,a2
 3c0:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3c4:	fd843783          	ld	a5,-40(s0)
 3c8:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3cc:	fd043783          	ld	a5,-48(s0)
 3d0:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3d4:	fe043703          	ld	a4,-32(s0)
 3d8:	fe843783          	ld	a5,-24(s0)
 3dc:	02e7fc63          	bgeu	a5,a4,414 <memmove+0x64>
    while(n-- > 0)
 3e0:	a00d                	j	402 <memmove+0x52>
      *dst++ = *src++;
 3e2:	fe043703          	ld	a4,-32(s0)
 3e6:	00170793          	addi	a5,a4,1
 3ea:	fef43023          	sd	a5,-32(s0)
 3ee:	fe843783          	ld	a5,-24(s0)
 3f2:	00178693          	addi	a3,a5,1
 3f6:	fed43423          	sd	a3,-24(s0)
 3fa:	00074703          	lbu	a4,0(a4)
 3fe:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 402:	fcc42783          	lw	a5,-52(s0)
 406:	fff7871b          	addiw	a4,a5,-1
 40a:	fce42623          	sw	a4,-52(s0)
 40e:	fcf04ae3          	bgtz	a5,3e2 <memmove+0x32>
 412:	a891                	j	466 <memmove+0xb6>
  } else {
    dst += n;
 414:	fcc42783          	lw	a5,-52(s0)
 418:	fe843703          	ld	a4,-24(s0)
 41c:	97ba                	add	a5,a5,a4
 41e:	fef43423          	sd	a5,-24(s0)
    src += n;
 422:	fcc42783          	lw	a5,-52(s0)
 426:	fe043703          	ld	a4,-32(s0)
 42a:	97ba                	add	a5,a5,a4
 42c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 430:	a01d                	j	456 <memmove+0xa6>
      *--dst = *--src;
 432:	fe043783          	ld	a5,-32(s0)
 436:	17fd                	addi	a5,a5,-1
 438:	fef43023          	sd	a5,-32(s0)
 43c:	fe843783          	ld	a5,-24(s0)
 440:	17fd                	addi	a5,a5,-1
 442:	fef43423          	sd	a5,-24(s0)
 446:	fe043783          	ld	a5,-32(s0)
 44a:	0007c703          	lbu	a4,0(a5)
 44e:	fe843783          	ld	a5,-24(s0)
 452:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 456:	fcc42783          	lw	a5,-52(s0)
 45a:	fff7871b          	addiw	a4,a5,-1
 45e:	fce42623          	sw	a4,-52(s0)
 462:	fcf048e3          	bgtz	a5,432 <memmove+0x82>
  }
  return vdst;
 466:	fd843783          	ld	a5,-40(s0)
}
 46a:	853e                	mv	a0,a5
 46c:	7462                	ld	s0,56(sp)
 46e:	6121                	addi	sp,sp,64
 470:	8082                	ret

0000000000000472 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 472:	7139                	addi	sp,sp,-64
 474:	fc22                	sd	s0,56(sp)
 476:	0080                	addi	s0,sp,64
 478:	fca43c23          	sd	a0,-40(s0)
 47c:	fcb43823          	sd	a1,-48(s0)
 480:	87b2                	mv	a5,a2
 482:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 486:	fd843783          	ld	a5,-40(s0)
 48a:	fef43423          	sd	a5,-24(s0)
 48e:	fd043783          	ld	a5,-48(s0)
 492:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 496:	a0a1                	j	4de <memcmp+0x6c>
    if (*p1 != *p2) {
 498:	fe843783          	ld	a5,-24(s0)
 49c:	0007c703          	lbu	a4,0(a5)
 4a0:	fe043783          	ld	a5,-32(s0)
 4a4:	0007c783          	lbu	a5,0(a5)
 4a8:	02f70163          	beq	a4,a5,4ca <memcmp+0x58>
      return *p1 - *p2;
 4ac:	fe843783          	ld	a5,-24(s0)
 4b0:	0007c783          	lbu	a5,0(a5)
 4b4:	0007871b          	sext.w	a4,a5
 4b8:	fe043783          	ld	a5,-32(s0)
 4bc:	0007c783          	lbu	a5,0(a5)
 4c0:	2781                	sext.w	a5,a5
 4c2:	40f707bb          	subw	a5,a4,a5
 4c6:	2781                	sext.w	a5,a5
 4c8:	a01d                	j	4ee <memcmp+0x7c>
    }
    p1++;
 4ca:	fe843783          	ld	a5,-24(s0)
 4ce:	0785                	addi	a5,a5,1
 4d0:	fef43423          	sd	a5,-24(s0)
    p2++;
 4d4:	fe043783          	ld	a5,-32(s0)
 4d8:	0785                	addi	a5,a5,1
 4da:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4de:	fcc42783          	lw	a5,-52(s0)
 4e2:	fff7871b          	addiw	a4,a5,-1
 4e6:	fce42623          	sw	a4,-52(s0)
 4ea:	f7dd                	bnez	a5,498 <memcmp+0x26>
  }
  return 0;
 4ec:	4781                	li	a5,0
}
 4ee:	853e                	mv	a0,a5
 4f0:	7462                	ld	s0,56(sp)
 4f2:	6121                	addi	sp,sp,64
 4f4:	8082                	ret

00000000000004f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4f6:	7179                	addi	sp,sp,-48
 4f8:	f406                	sd	ra,40(sp)
 4fa:	f022                	sd	s0,32(sp)
 4fc:	1800                	addi	s0,sp,48
 4fe:	fea43423          	sd	a0,-24(s0)
 502:	feb43023          	sd	a1,-32(s0)
 506:	87b2                	mv	a5,a2
 508:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 50c:	fdc42783          	lw	a5,-36(s0)
 510:	863e                	mv	a2,a5
 512:	fe043583          	ld	a1,-32(s0)
 516:	fe843503          	ld	a0,-24(s0)
 51a:	00000097          	auipc	ra,0x0
 51e:	e96080e7          	jalr	-362(ra) # 3b0 <memmove>
 522:	87aa                	mv	a5,a0
}
 524:	853e                	mv	a0,a5
 526:	70a2                	ld	ra,40(sp)
 528:	7402                	ld	s0,32(sp)
 52a:	6145                	addi	sp,sp,48
 52c:	8082                	ret

000000000000052e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 52e:	4885                	li	a7,1
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <exit>:
.global exit
exit:
 li a7, SYS_exit
 536:	4889                	li	a7,2
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <wait>:
.global wait
wait:
 li a7, SYS_wait
 53e:	488d                	li	a7,3
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 546:	4891                	li	a7,4
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <read>:
.global read
read:
 li a7, SYS_read
 54e:	4895                	li	a7,5
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <write>:
.global write
write:
 li a7, SYS_write
 556:	48c1                	li	a7,16
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <close>:
.global close
close:
 li a7, SYS_close
 55e:	48d5                	li	a7,21
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <kill>:
.global kill
kill:
 li a7, SYS_kill
 566:	4899                	li	a7,6
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <exec>:
.global exec
exec:
 li a7, SYS_exec
 56e:	489d                	li	a7,7
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <open>:
.global open
open:
 li a7, SYS_open
 576:	48bd                	li	a7,15
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 57e:	48c5                	li	a7,17
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 586:	48c9                	li	a7,18
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 58e:	48a1                	li	a7,8
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <link>:
.global link
link:
 li a7, SYS_link
 596:	48cd                	li	a7,19
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 59e:	48d1                	li	a7,20
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a6:	48a5                	li	a7,9
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ae:	48a9                	li	a7,10
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b6:	48ad                	li	a7,11
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5be:	48b1                	li	a7,12
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c6:	48b5                	li	a7,13
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ce:	48b9                	li	a7,14
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d6:	1101                	addi	sp,sp,-32
 5d8:	ec06                	sd	ra,24(sp)
 5da:	e822                	sd	s0,16(sp)
 5dc:	1000                	addi	s0,sp,32
 5de:	87aa                	mv	a5,a0
 5e0:	872e                	mv	a4,a1
 5e2:	fef42623          	sw	a5,-20(s0)
 5e6:	87ba                	mv	a5,a4
 5e8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5ec:	feb40713          	addi	a4,s0,-21
 5f0:	fec42783          	lw	a5,-20(s0)
 5f4:	4605                	li	a2,1
 5f6:	85ba                	mv	a1,a4
 5f8:	853e                	mv	a0,a5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	f5c080e7          	jalr	-164(ra) # 556 <write>
}
 602:	0001                	nop
 604:	60e2                	ld	ra,24(sp)
 606:	6442                	ld	s0,16(sp)
 608:	6105                	addi	sp,sp,32
 60a:	8082                	ret

000000000000060c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 60c:	7139                	addi	sp,sp,-64
 60e:	fc06                	sd	ra,56(sp)
 610:	f822                	sd	s0,48(sp)
 612:	0080                	addi	s0,sp,64
 614:	87aa                	mv	a5,a0
 616:	8736                	mv	a4,a3
 618:	fcf42623          	sw	a5,-52(s0)
 61c:	87ae                	mv	a5,a1
 61e:	fcf42423          	sw	a5,-56(s0)
 622:	87b2                	mv	a5,a2
 624:	fcf42223          	sw	a5,-60(s0)
 628:	87ba                	mv	a5,a4
 62a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 62e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 632:	fc042783          	lw	a5,-64(s0)
 636:	2781                	sext.w	a5,a5
 638:	c38d                	beqz	a5,65a <printint+0x4e>
 63a:	fc842783          	lw	a5,-56(s0)
 63e:	2781                	sext.w	a5,a5
 640:	0007dd63          	bgez	a5,65a <printint+0x4e>
    neg = 1;
 644:	4785                	li	a5,1
 646:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 64a:	fc842783          	lw	a5,-56(s0)
 64e:	40f007bb          	negw	a5,a5
 652:	2781                	sext.w	a5,a5
 654:	fef42223          	sw	a5,-28(s0)
 658:	a029                	j	662 <printint+0x56>
  } else {
    x = xx;
 65a:	fc842783          	lw	a5,-56(s0)
 65e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 662:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 666:	fc442783          	lw	a5,-60(s0)
 66a:	fe442703          	lw	a4,-28(s0)
 66e:	02f777bb          	remuw	a5,a4,a5
 672:	0007861b          	sext.w	a2,a5
 676:	fec42783          	lw	a5,-20(s0)
 67a:	0017871b          	addiw	a4,a5,1
 67e:	fee42623          	sw	a4,-20(s0)
 682:	00001697          	auipc	a3,0x1
 686:	97e68693          	addi	a3,a3,-1666 # 1000 <digits>
 68a:	02061713          	slli	a4,a2,0x20
 68e:	9301                	srli	a4,a4,0x20
 690:	9736                	add	a4,a4,a3
 692:	00074703          	lbu	a4,0(a4)
 696:	ff040693          	addi	a3,s0,-16
 69a:	97b6                	add	a5,a5,a3
 69c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6a0:	fc442783          	lw	a5,-60(s0)
 6a4:	fe442703          	lw	a4,-28(s0)
 6a8:	02f757bb          	divuw	a5,a4,a5
 6ac:	fef42223          	sw	a5,-28(s0)
 6b0:	fe442783          	lw	a5,-28(s0)
 6b4:	2781                	sext.w	a5,a5
 6b6:	fbc5                	bnez	a5,666 <printint+0x5a>
  if(neg)
 6b8:	fe842783          	lw	a5,-24(s0)
 6bc:	2781                	sext.w	a5,a5
 6be:	cf95                	beqz	a5,6fa <printint+0xee>
    buf[i++] = '-';
 6c0:	fec42783          	lw	a5,-20(s0)
 6c4:	0017871b          	addiw	a4,a5,1
 6c8:	fee42623          	sw	a4,-20(s0)
 6cc:	ff040713          	addi	a4,s0,-16
 6d0:	97ba                	add	a5,a5,a4
 6d2:	02d00713          	li	a4,45
 6d6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6da:	a005                	j	6fa <printint+0xee>
    putc(fd, buf[i]);
 6dc:	fec42783          	lw	a5,-20(s0)
 6e0:	ff040713          	addi	a4,s0,-16
 6e4:	97ba                	add	a5,a5,a4
 6e6:	fe07c703          	lbu	a4,-32(a5)
 6ea:	fcc42783          	lw	a5,-52(s0)
 6ee:	85ba                	mv	a1,a4
 6f0:	853e                	mv	a0,a5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	ee4080e7          	jalr	-284(ra) # 5d6 <putc>
  while(--i >= 0)
 6fa:	fec42783          	lw	a5,-20(s0)
 6fe:	37fd                	addiw	a5,a5,-1
 700:	fef42623          	sw	a5,-20(s0)
 704:	fec42783          	lw	a5,-20(s0)
 708:	2781                	sext.w	a5,a5
 70a:	fc07d9e3          	bgez	a5,6dc <printint+0xd0>
}
 70e:	0001                	nop
 710:	0001                	nop
 712:	70e2                	ld	ra,56(sp)
 714:	7442                	ld	s0,48(sp)
 716:	6121                	addi	sp,sp,64
 718:	8082                	ret

000000000000071a <printptr>:

static void
printptr(int fd, uint64 x) {
 71a:	7179                	addi	sp,sp,-48
 71c:	f406                	sd	ra,40(sp)
 71e:	f022                	sd	s0,32(sp)
 720:	1800                	addi	s0,sp,48
 722:	87aa                	mv	a5,a0
 724:	fcb43823          	sd	a1,-48(s0)
 728:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 72c:	fdc42783          	lw	a5,-36(s0)
 730:	03000593          	li	a1,48
 734:	853e                	mv	a0,a5
 736:	00000097          	auipc	ra,0x0
 73a:	ea0080e7          	jalr	-352(ra) # 5d6 <putc>
  putc(fd, 'x');
 73e:	fdc42783          	lw	a5,-36(s0)
 742:	07800593          	li	a1,120
 746:	853e                	mv	a0,a5
 748:	00000097          	auipc	ra,0x0
 74c:	e8e080e7          	jalr	-370(ra) # 5d6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 750:	fe042623          	sw	zero,-20(s0)
 754:	a82d                	j	78e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 756:	fd043783          	ld	a5,-48(s0)
 75a:	93f1                	srli	a5,a5,0x3c
 75c:	00001717          	auipc	a4,0x1
 760:	8a470713          	addi	a4,a4,-1884 # 1000 <digits>
 764:	97ba                	add	a5,a5,a4
 766:	0007c703          	lbu	a4,0(a5)
 76a:	fdc42783          	lw	a5,-36(s0)
 76e:	85ba                	mv	a1,a4
 770:	853e                	mv	a0,a5
 772:	00000097          	auipc	ra,0x0
 776:	e64080e7          	jalr	-412(ra) # 5d6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 77a:	fec42783          	lw	a5,-20(s0)
 77e:	2785                	addiw	a5,a5,1
 780:	fef42623          	sw	a5,-20(s0)
 784:	fd043783          	ld	a5,-48(s0)
 788:	0792                	slli	a5,a5,0x4
 78a:	fcf43823          	sd	a5,-48(s0)
 78e:	fec42783          	lw	a5,-20(s0)
 792:	873e                	mv	a4,a5
 794:	47bd                	li	a5,15
 796:	fce7f0e3          	bgeu	a5,a4,756 <printptr+0x3c>
}
 79a:	0001                	nop
 79c:	0001                	nop
 79e:	70a2                	ld	ra,40(sp)
 7a0:	7402                	ld	s0,32(sp)
 7a2:	6145                	addi	sp,sp,48
 7a4:	8082                	ret

00000000000007a6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7a6:	715d                	addi	sp,sp,-80
 7a8:	e486                	sd	ra,72(sp)
 7aa:	e0a2                	sd	s0,64(sp)
 7ac:	0880                	addi	s0,sp,80
 7ae:	87aa                	mv	a5,a0
 7b0:	fcb43023          	sd	a1,-64(s0)
 7b4:	fac43c23          	sd	a2,-72(s0)
 7b8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7bc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7c0:	fe042223          	sw	zero,-28(s0)
 7c4:	a42d                	j	9ee <vprintf+0x248>
    c = fmt[i] & 0xff;
 7c6:	fe442783          	lw	a5,-28(s0)
 7ca:	fc043703          	ld	a4,-64(s0)
 7ce:	97ba                	add	a5,a5,a4
 7d0:	0007c783          	lbu	a5,0(a5)
 7d4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7d8:	fe042783          	lw	a5,-32(s0)
 7dc:	2781                	sext.w	a5,a5
 7de:	eb9d                	bnez	a5,814 <vprintf+0x6e>
      if(c == '%'){
 7e0:	fdc42783          	lw	a5,-36(s0)
 7e4:	0007871b          	sext.w	a4,a5
 7e8:	02500793          	li	a5,37
 7ec:	00f71763          	bne	a4,a5,7fa <vprintf+0x54>
        state = '%';
 7f0:	02500793          	li	a5,37
 7f4:	fef42023          	sw	a5,-32(s0)
 7f8:	a2f5                	j	9e4 <vprintf+0x23e>
      } else {
        putc(fd, c);
 7fa:	fdc42783          	lw	a5,-36(s0)
 7fe:	0ff7f713          	andi	a4,a5,255
 802:	fcc42783          	lw	a5,-52(s0)
 806:	85ba                	mv	a1,a4
 808:	853e                	mv	a0,a5
 80a:	00000097          	auipc	ra,0x0
 80e:	dcc080e7          	jalr	-564(ra) # 5d6 <putc>
 812:	aac9                	j	9e4 <vprintf+0x23e>
      }
    } else if(state == '%'){
 814:	fe042783          	lw	a5,-32(s0)
 818:	0007871b          	sext.w	a4,a5
 81c:	02500793          	li	a5,37
 820:	1cf71263          	bne	a4,a5,9e4 <vprintf+0x23e>
      if(c == 'd'){
 824:	fdc42783          	lw	a5,-36(s0)
 828:	0007871b          	sext.w	a4,a5
 82c:	06400793          	li	a5,100
 830:	02f71463          	bne	a4,a5,858 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 834:	fb843783          	ld	a5,-72(s0)
 838:	00878713          	addi	a4,a5,8
 83c:	fae43c23          	sd	a4,-72(s0)
 840:	4398                	lw	a4,0(a5)
 842:	fcc42783          	lw	a5,-52(s0)
 846:	4685                	li	a3,1
 848:	4629                	li	a2,10
 84a:	85ba                	mv	a1,a4
 84c:	853e                	mv	a0,a5
 84e:	00000097          	auipc	ra,0x0
 852:	dbe080e7          	jalr	-578(ra) # 60c <printint>
 856:	a269                	j	9e0 <vprintf+0x23a>
      } else if(c == 'l') {
 858:	fdc42783          	lw	a5,-36(s0)
 85c:	0007871b          	sext.w	a4,a5
 860:	06c00793          	li	a5,108
 864:	02f71663          	bne	a4,a5,890 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 868:	fb843783          	ld	a5,-72(s0)
 86c:	00878713          	addi	a4,a5,8
 870:	fae43c23          	sd	a4,-72(s0)
 874:	639c                	ld	a5,0(a5)
 876:	0007871b          	sext.w	a4,a5
 87a:	fcc42783          	lw	a5,-52(s0)
 87e:	4681                	li	a3,0
 880:	4629                	li	a2,10
 882:	85ba                	mv	a1,a4
 884:	853e                	mv	a0,a5
 886:	00000097          	auipc	ra,0x0
 88a:	d86080e7          	jalr	-634(ra) # 60c <printint>
 88e:	aa89                	j	9e0 <vprintf+0x23a>
      } else if(c == 'x') {
 890:	fdc42783          	lw	a5,-36(s0)
 894:	0007871b          	sext.w	a4,a5
 898:	07800793          	li	a5,120
 89c:	02f71463          	bne	a4,a5,8c4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8a0:	fb843783          	ld	a5,-72(s0)
 8a4:	00878713          	addi	a4,a5,8
 8a8:	fae43c23          	sd	a4,-72(s0)
 8ac:	4398                	lw	a4,0(a5)
 8ae:	fcc42783          	lw	a5,-52(s0)
 8b2:	4681                	li	a3,0
 8b4:	4641                	li	a2,16
 8b6:	85ba                	mv	a1,a4
 8b8:	853e                	mv	a0,a5
 8ba:	00000097          	auipc	ra,0x0
 8be:	d52080e7          	jalr	-686(ra) # 60c <printint>
 8c2:	aa39                	j	9e0 <vprintf+0x23a>
      } else if(c == 'p') {
 8c4:	fdc42783          	lw	a5,-36(s0)
 8c8:	0007871b          	sext.w	a4,a5
 8cc:	07000793          	li	a5,112
 8d0:	02f71263          	bne	a4,a5,8f4 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8d4:	fb843783          	ld	a5,-72(s0)
 8d8:	00878713          	addi	a4,a5,8
 8dc:	fae43c23          	sd	a4,-72(s0)
 8e0:	6398                	ld	a4,0(a5)
 8e2:	fcc42783          	lw	a5,-52(s0)
 8e6:	85ba                	mv	a1,a4
 8e8:	853e                	mv	a0,a5
 8ea:	00000097          	auipc	ra,0x0
 8ee:	e30080e7          	jalr	-464(ra) # 71a <printptr>
 8f2:	a0fd                	j	9e0 <vprintf+0x23a>
      } else if(c == 's'){
 8f4:	fdc42783          	lw	a5,-36(s0)
 8f8:	0007871b          	sext.w	a4,a5
 8fc:	07300793          	li	a5,115
 900:	04f71c63          	bne	a4,a5,958 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 904:	fb843783          	ld	a5,-72(s0)
 908:	00878713          	addi	a4,a5,8
 90c:	fae43c23          	sd	a4,-72(s0)
 910:	639c                	ld	a5,0(a5)
 912:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 916:	fe843783          	ld	a5,-24(s0)
 91a:	eb8d                	bnez	a5,94c <vprintf+0x1a6>
          s = "(null)";
 91c:	00000797          	auipc	a5,0x0
 920:	49c78793          	addi	a5,a5,1180 # db8 <malloc+0x162>
 924:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 928:	a015                	j	94c <vprintf+0x1a6>
          putc(fd, *s);
 92a:	fe843783          	ld	a5,-24(s0)
 92e:	0007c703          	lbu	a4,0(a5)
 932:	fcc42783          	lw	a5,-52(s0)
 936:	85ba                	mv	a1,a4
 938:	853e                	mv	a0,a5
 93a:	00000097          	auipc	ra,0x0
 93e:	c9c080e7          	jalr	-868(ra) # 5d6 <putc>
          s++;
 942:	fe843783          	ld	a5,-24(s0)
 946:	0785                	addi	a5,a5,1
 948:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 94c:	fe843783          	ld	a5,-24(s0)
 950:	0007c783          	lbu	a5,0(a5)
 954:	fbf9                	bnez	a5,92a <vprintf+0x184>
 956:	a069                	j	9e0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 958:	fdc42783          	lw	a5,-36(s0)
 95c:	0007871b          	sext.w	a4,a5
 960:	06300793          	li	a5,99
 964:	02f71463          	bne	a4,a5,98c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 968:	fb843783          	ld	a5,-72(s0)
 96c:	00878713          	addi	a4,a5,8
 970:	fae43c23          	sd	a4,-72(s0)
 974:	439c                	lw	a5,0(a5)
 976:	0ff7f713          	andi	a4,a5,255
 97a:	fcc42783          	lw	a5,-52(s0)
 97e:	85ba                	mv	a1,a4
 980:	853e                	mv	a0,a5
 982:	00000097          	auipc	ra,0x0
 986:	c54080e7          	jalr	-940(ra) # 5d6 <putc>
 98a:	a899                	j	9e0 <vprintf+0x23a>
      } else if(c == '%'){
 98c:	fdc42783          	lw	a5,-36(s0)
 990:	0007871b          	sext.w	a4,a5
 994:	02500793          	li	a5,37
 998:	00f71f63          	bne	a4,a5,9b6 <vprintf+0x210>
        putc(fd, c);
 99c:	fdc42783          	lw	a5,-36(s0)
 9a0:	0ff7f713          	andi	a4,a5,255
 9a4:	fcc42783          	lw	a5,-52(s0)
 9a8:	85ba                	mv	a1,a4
 9aa:	853e                	mv	a0,a5
 9ac:	00000097          	auipc	ra,0x0
 9b0:	c2a080e7          	jalr	-982(ra) # 5d6 <putc>
 9b4:	a035                	j	9e0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9b6:	fcc42783          	lw	a5,-52(s0)
 9ba:	02500593          	li	a1,37
 9be:	853e                	mv	a0,a5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	c16080e7          	jalr	-1002(ra) # 5d6 <putc>
        putc(fd, c);
 9c8:	fdc42783          	lw	a5,-36(s0)
 9cc:	0ff7f713          	andi	a4,a5,255
 9d0:	fcc42783          	lw	a5,-52(s0)
 9d4:	85ba                	mv	a1,a4
 9d6:	853e                	mv	a0,a5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	bfe080e7          	jalr	-1026(ra) # 5d6 <putc>
      }
      state = 0;
 9e0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9e4:	fe442783          	lw	a5,-28(s0)
 9e8:	2785                	addiw	a5,a5,1
 9ea:	fef42223          	sw	a5,-28(s0)
 9ee:	fe442783          	lw	a5,-28(s0)
 9f2:	fc043703          	ld	a4,-64(s0)
 9f6:	97ba                	add	a5,a5,a4
 9f8:	0007c783          	lbu	a5,0(a5)
 9fc:	dc0795e3          	bnez	a5,7c6 <vprintf+0x20>
    }
  }
}
 a00:	0001                	nop
 a02:	0001                	nop
 a04:	60a6                	ld	ra,72(sp)
 a06:	6406                	ld	s0,64(sp)
 a08:	6161                	addi	sp,sp,80
 a0a:	8082                	ret

0000000000000a0c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a0c:	7159                	addi	sp,sp,-112
 a0e:	fc06                	sd	ra,56(sp)
 a10:	f822                	sd	s0,48(sp)
 a12:	0080                	addi	s0,sp,64
 a14:	fcb43823          	sd	a1,-48(s0)
 a18:	e010                	sd	a2,0(s0)
 a1a:	e414                	sd	a3,8(s0)
 a1c:	e818                	sd	a4,16(s0)
 a1e:	ec1c                	sd	a5,24(s0)
 a20:	03043023          	sd	a6,32(s0)
 a24:	03143423          	sd	a7,40(s0)
 a28:	87aa                	mv	a5,a0
 a2a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a2e:	03040793          	addi	a5,s0,48
 a32:	fcf43423          	sd	a5,-56(s0)
 a36:	fc843783          	ld	a5,-56(s0)
 a3a:	fd078793          	addi	a5,a5,-48
 a3e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a42:	fe843703          	ld	a4,-24(s0)
 a46:	fdc42783          	lw	a5,-36(s0)
 a4a:	863a                	mv	a2,a4
 a4c:	fd043583          	ld	a1,-48(s0)
 a50:	853e                	mv	a0,a5
 a52:	00000097          	auipc	ra,0x0
 a56:	d54080e7          	jalr	-684(ra) # 7a6 <vprintf>
}
 a5a:	0001                	nop
 a5c:	70e2                	ld	ra,56(sp)
 a5e:	7442                	ld	s0,48(sp)
 a60:	6165                	addi	sp,sp,112
 a62:	8082                	ret

0000000000000a64 <printf>:

void
printf(const char *fmt, ...)
{
 a64:	7159                	addi	sp,sp,-112
 a66:	f406                	sd	ra,40(sp)
 a68:	f022                	sd	s0,32(sp)
 a6a:	1800                	addi	s0,sp,48
 a6c:	fca43c23          	sd	a0,-40(s0)
 a70:	e40c                	sd	a1,8(s0)
 a72:	e810                	sd	a2,16(s0)
 a74:	ec14                	sd	a3,24(s0)
 a76:	f018                	sd	a4,32(s0)
 a78:	f41c                	sd	a5,40(s0)
 a7a:	03043823          	sd	a6,48(s0)
 a7e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a82:	04040793          	addi	a5,s0,64
 a86:	fcf43823          	sd	a5,-48(s0)
 a8a:	fd043783          	ld	a5,-48(s0)
 a8e:	fc878793          	addi	a5,a5,-56
 a92:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a96:	fe843783          	ld	a5,-24(s0)
 a9a:	863e                	mv	a2,a5
 a9c:	fd843583          	ld	a1,-40(s0)
 aa0:	4505                	li	a0,1
 aa2:	00000097          	auipc	ra,0x0
 aa6:	d04080e7          	jalr	-764(ra) # 7a6 <vprintf>
}
 aaa:	0001                	nop
 aac:	70a2                	ld	ra,40(sp)
 aae:	7402                	ld	s0,32(sp)
 ab0:	6165                	addi	sp,sp,112
 ab2:	8082                	ret

0000000000000ab4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ab4:	7179                	addi	sp,sp,-48
 ab6:	f422                	sd	s0,40(sp)
 ab8:	1800                	addi	s0,sp,48
 aba:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 abe:	fd843783          	ld	a5,-40(s0)
 ac2:	17c1                	addi	a5,a5,-16
 ac4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac8:	00000797          	auipc	a5,0x0
 acc:	56878793          	addi	a5,a5,1384 # 1030 <freep>
 ad0:	639c                	ld	a5,0(a5)
 ad2:	fef43423          	sd	a5,-24(s0)
 ad6:	a815                	j	b0a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad8:	fe843783          	ld	a5,-24(s0)
 adc:	639c                	ld	a5,0(a5)
 ade:	fe843703          	ld	a4,-24(s0)
 ae2:	00f76f63          	bltu	a4,a5,b00 <free+0x4c>
 ae6:	fe043703          	ld	a4,-32(s0)
 aea:	fe843783          	ld	a5,-24(s0)
 aee:	02e7eb63          	bltu	a5,a4,b24 <free+0x70>
 af2:	fe843783          	ld	a5,-24(s0)
 af6:	639c                	ld	a5,0(a5)
 af8:	fe043703          	ld	a4,-32(s0)
 afc:	02f76463          	bltu	a4,a5,b24 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b00:	fe843783          	ld	a5,-24(s0)
 b04:	639c                	ld	a5,0(a5)
 b06:	fef43423          	sd	a5,-24(s0)
 b0a:	fe043703          	ld	a4,-32(s0)
 b0e:	fe843783          	ld	a5,-24(s0)
 b12:	fce7f3e3          	bgeu	a5,a4,ad8 <free+0x24>
 b16:	fe843783          	ld	a5,-24(s0)
 b1a:	639c                	ld	a5,0(a5)
 b1c:	fe043703          	ld	a4,-32(s0)
 b20:	faf77ce3          	bgeu	a4,a5,ad8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b24:	fe043783          	ld	a5,-32(s0)
 b28:	479c                	lw	a5,8(a5)
 b2a:	1782                	slli	a5,a5,0x20
 b2c:	9381                	srli	a5,a5,0x20
 b2e:	0792                	slli	a5,a5,0x4
 b30:	fe043703          	ld	a4,-32(s0)
 b34:	973e                	add	a4,a4,a5
 b36:	fe843783          	ld	a5,-24(s0)
 b3a:	639c                	ld	a5,0(a5)
 b3c:	02f71763          	bne	a4,a5,b6a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b40:	fe043783          	ld	a5,-32(s0)
 b44:	4798                	lw	a4,8(a5)
 b46:	fe843783          	ld	a5,-24(s0)
 b4a:	639c                	ld	a5,0(a5)
 b4c:	479c                	lw	a5,8(a5)
 b4e:	9fb9                	addw	a5,a5,a4
 b50:	0007871b          	sext.w	a4,a5
 b54:	fe043783          	ld	a5,-32(s0)
 b58:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b5a:	fe843783          	ld	a5,-24(s0)
 b5e:	639c                	ld	a5,0(a5)
 b60:	6398                	ld	a4,0(a5)
 b62:	fe043783          	ld	a5,-32(s0)
 b66:	e398                	sd	a4,0(a5)
 b68:	a039                	j	b76 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b6a:	fe843783          	ld	a5,-24(s0)
 b6e:	6398                	ld	a4,0(a5)
 b70:	fe043783          	ld	a5,-32(s0)
 b74:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b76:	fe843783          	ld	a5,-24(s0)
 b7a:	479c                	lw	a5,8(a5)
 b7c:	1782                	slli	a5,a5,0x20
 b7e:	9381                	srli	a5,a5,0x20
 b80:	0792                	slli	a5,a5,0x4
 b82:	fe843703          	ld	a4,-24(s0)
 b86:	97ba                	add	a5,a5,a4
 b88:	fe043703          	ld	a4,-32(s0)
 b8c:	02f71563          	bne	a4,a5,bb6 <free+0x102>
    p->s.size += bp->s.size;
 b90:	fe843783          	ld	a5,-24(s0)
 b94:	4798                	lw	a4,8(a5)
 b96:	fe043783          	ld	a5,-32(s0)
 b9a:	479c                	lw	a5,8(a5)
 b9c:	9fb9                	addw	a5,a5,a4
 b9e:	0007871b          	sext.w	a4,a5
 ba2:	fe843783          	ld	a5,-24(s0)
 ba6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 ba8:	fe043783          	ld	a5,-32(s0)
 bac:	6398                	ld	a4,0(a5)
 bae:	fe843783          	ld	a5,-24(s0)
 bb2:	e398                	sd	a4,0(a5)
 bb4:	a031                	j	bc0 <free+0x10c>
  } else
    p->s.ptr = bp;
 bb6:	fe843783          	ld	a5,-24(s0)
 bba:	fe043703          	ld	a4,-32(s0)
 bbe:	e398                	sd	a4,0(a5)
  freep = p;
 bc0:	00000797          	auipc	a5,0x0
 bc4:	47078793          	addi	a5,a5,1136 # 1030 <freep>
 bc8:	fe843703          	ld	a4,-24(s0)
 bcc:	e398                	sd	a4,0(a5)
}
 bce:	0001                	nop
 bd0:	7422                	ld	s0,40(sp)
 bd2:	6145                	addi	sp,sp,48
 bd4:	8082                	ret

0000000000000bd6 <morecore>:

static Header*
morecore(uint nu)
{
 bd6:	7179                	addi	sp,sp,-48
 bd8:	f406                	sd	ra,40(sp)
 bda:	f022                	sd	s0,32(sp)
 bdc:	1800                	addi	s0,sp,48
 bde:	87aa                	mv	a5,a0
 be0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 be4:	fdc42783          	lw	a5,-36(s0)
 be8:	0007871b          	sext.w	a4,a5
 bec:	6785                	lui	a5,0x1
 bee:	00f77563          	bgeu	a4,a5,bf8 <morecore+0x22>
    nu = 4096;
 bf2:	6785                	lui	a5,0x1
 bf4:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bf8:	fdc42783          	lw	a5,-36(s0)
 bfc:	0047979b          	slliw	a5,a5,0x4
 c00:	2781                	sext.w	a5,a5
 c02:	2781                	sext.w	a5,a5
 c04:	853e                	mv	a0,a5
 c06:	00000097          	auipc	ra,0x0
 c0a:	9b8080e7          	jalr	-1608(ra) # 5be <sbrk>
 c0e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c12:	fe843703          	ld	a4,-24(s0)
 c16:	57fd                	li	a5,-1
 c18:	00f71463          	bne	a4,a5,c20 <morecore+0x4a>
    return 0;
 c1c:	4781                	li	a5,0
 c1e:	a03d                	j	c4c <morecore+0x76>
  hp = (Header*)p;
 c20:	fe843783          	ld	a5,-24(s0)
 c24:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c28:	fe043783          	ld	a5,-32(s0)
 c2c:	fdc42703          	lw	a4,-36(s0)
 c30:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c32:	fe043783          	ld	a5,-32(s0)
 c36:	07c1                	addi	a5,a5,16
 c38:	853e                	mv	a0,a5
 c3a:	00000097          	auipc	ra,0x0
 c3e:	e7a080e7          	jalr	-390(ra) # ab4 <free>
  return freep;
 c42:	00000797          	auipc	a5,0x0
 c46:	3ee78793          	addi	a5,a5,1006 # 1030 <freep>
 c4a:	639c                	ld	a5,0(a5)
}
 c4c:	853e                	mv	a0,a5
 c4e:	70a2                	ld	ra,40(sp)
 c50:	7402                	ld	s0,32(sp)
 c52:	6145                	addi	sp,sp,48
 c54:	8082                	ret

0000000000000c56 <malloc>:

void*
malloc(uint nbytes)
{
 c56:	7139                	addi	sp,sp,-64
 c58:	fc06                	sd	ra,56(sp)
 c5a:	f822                	sd	s0,48(sp)
 c5c:	0080                	addi	s0,sp,64
 c5e:	87aa                	mv	a5,a0
 c60:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c64:	fcc46783          	lwu	a5,-52(s0)
 c68:	07bd                	addi	a5,a5,15
 c6a:	8391                	srli	a5,a5,0x4
 c6c:	2781                	sext.w	a5,a5
 c6e:	2785                	addiw	a5,a5,1
 c70:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c74:	00000797          	auipc	a5,0x0
 c78:	3bc78793          	addi	a5,a5,956 # 1030 <freep>
 c7c:	639c                	ld	a5,0(a5)
 c7e:	fef43023          	sd	a5,-32(s0)
 c82:	fe043783          	ld	a5,-32(s0)
 c86:	ef95                	bnez	a5,cc2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c88:	00000797          	auipc	a5,0x0
 c8c:	39878793          	addi	a5,a5,920 # 1020 <base>
 c90:	fef43023          	sd	a5,-32(s0)
 c94:	00000797          	auipc	a5,0x0
 c98:	39c78793          	addi	a5,a5,924 # 1030 <freep>
 c9c:	fe043703          	ld	a4,-32(s0)
 ca0:	e398                	sd	a4,0(a5)
 ca2:	00000797          	auipc	a5,0x0
 ca6:	38e78793          	addi	a5,a5,910 # 1030 <freep>
 caa:	6398                	ld	a4,0(a5)
 cac:	00000797          	auipc	a5,0x0
 cb0:	37478793          	addi	a5,a5,884 # 1020 <base>
 cb4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cb6:	00000797          	auipc	a5,0x0
 cba:	36a78793          	addi	a5,a5,874 # 1020 <base>
 cbe:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc2:	fe043783          	ld	a5,-32(s0)
 cc6:	639c                	ld	a5,0(a5)
 cc8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ccc:	fe843783          	ld	a5,-24(s0)
 cd0:	4798                	lw	a4,8(a5)
 cd2:	fdc42783          	lw	a5,-36(s0)
 cd6:	2781                	sext.w	a5,a5
 cd8:	06f76863          	bltu	a4,a5,d48 <malloc+0xf2>
      if(p->s.size == nunits)
 cdc:	fe843783          	ld	a5,-24(s0)
 ce0:	4798                	lw	a4,8(a5)
 ce2:	fdc42783          	lw	a5,-36(s0)
 ce6:	2781                	sext.w	a5,a5
 ce8:	00e79963          	bne	a5,a4,cfa <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 cec:	fe843783          	ld	a5,-24(s0)
 cf0:	6398                	ld	a4,0(a5)
 cf2:	fe043783          	ld	a5,-32(s0)
 cf6:	e398                	sd	a4,0(a5)
 cf8:	a82d                	j	d32 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 cfa:	fe843783          	ld	a5,-24(s0)
 cfe:	4798                	lw	a4,8(a5)
 d00:	fdc42783          	lw	a5,-36(s0)
 d04:	40f707bb          	subw	a5,a4,a5
 d08:	0007871b          	sext.w	a4,a5
 d0c:	fe843783          	ld	a5,-24(s0)
 d10:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d12:	fe843783          	ld	a5,-24(s0)
 d16:	479c                	lw	a5,8(a5)
 d18:	1782                	slli	a5,a5,0x20
 d1a:	9381                	srli	a5,a5,0x20
 d1c:	0792                	slli	a5,a5,0x4
 d1e:	fe843703          	ld	a4,-24(s0)
 d22:	97ba                	add	a5,a5,a4
 d24:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d28:	fe843783          	ld	a5,-24(s0)
 d2c:	fdc42703          	lw	a4,-36(s0)
 d30:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d32:	00000797          	auipc	a5,0x0
 d36:	2fe78793          	addi	a5,a5,766 # 1030 <freep>
 d3a:	fe043703          	ld	a4,-32(s0)
 d3e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d40:	fe843783          	ld	a5,-24(s0)
 d44:	07c1                	addi	a5,a5,16
 d46:	a091                	j	d8a <malloc+0x134>
    }
    if(p == freep)
 d48:	00000797          	auipc	a5,0x0
 d4c:	2e878793          	addi	a5,a5,744 # 1030 <freep>
 d50:	639c                	ld	a5,0(a5)
 d52:	fe843703          	ld	a4,-24(s0)
 d56:	02f71063          	bne	a4,a5,d76 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d5a:	fdc42783          	lw	a5,-36(s0)
 d5e:	853e                	mv	a0,a5
 d60:	00000097          	auipc	ra,0x0
 d64:	e76080e7          	jalr	-394(ra) # bd6 <morecore>
 d68:	fea43423          	sd	a0,-24(s0)
 d6c:	fe843783          	ld	a5,-24(s0)
 d70:	e399                	bnez	a5,d76 <malloc+0x120>
        return 0;
 d72:	4781                	li	a5,0
 d74:	a819                	j	d8a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d76:	fe843783          	ld	a5,-24(s0)
 d7a:	fef43023          	sd	a5,-32(s0)
 d7e:	fe843783          	ld	a5,-24(s0)
 d82:	639c                	ld	a5,0(a5)
 d84:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d88:	b791                	j	ccc <malloc+0x76>
  }
}
 d8a:	853e                	mv	a0,a5
 d8c:	70e2                	ld	ra,56(sp)
 d8e:	7442                	ld	s0,48(sp)
 d90:	6121                	addi	sp,sp,64
 d92:	8082                	ret
