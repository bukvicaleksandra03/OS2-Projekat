
user/_maxout_vm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

int
main(int argc, char *argv[]) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
    for (int i = 0; i < 6000; i++) {
  12:	fe042623          	sw	zero,-20(s0)
  16:	a825                	j	4e <main+0x4e>
        uint64 a = (uint64) sbrk(4096);
  18:	6505                	lui	a0,0x1
  1a:	00000097          	auipc	ra,0x0
  1e:	586080e7          	jalr	1414(ra) # 5a0 <sbrk>
  22:	87aa                	mv	a5,a0
  24:	fef43023          	sd	a5,-32(s0)
        if (a == 0xffffffffffffffff) {
  28:	fe043703          	ld	a4,-32(s0)
  2c:	57fd                	li	a5,-1
  2e:	02f70a63          	beq	a4,a5,62 <main+0x62>
            break;
        }

        // modify the memory to make sure it's really allocated.
        *(char *) (a + 4096 - 1) = 1;
  32:	fe043703          	ld	a4,-32(s0)
  36:	6785                	lui	a5,0x1
  38:	17fd                	addi	a5,a5,-1
  3a:	97ba                	add	a5,a5,a4
  3c:	873e                	mv	a4,a5
  3e:	4785                	li	a5,1
  40:	00f70023          	sb	a5,0(a4)
    for (int i = 0; i < 6000; i++) {
  44:	fec42783          	lw	a5,-20(s0)
  48:	2785                	addiw	a5,a5,1
  4a:	fef42623          	sw	a5,-20(s0)
  4e:	fec42783          	lw	a5,-20(s0)
  52:	0007871b          	sext.w	a4,a5
  56:	6785                	lui	a5,0x1
  58:	76f78793          	addi	a5,a5,1903 # 176f <freep+0x73f>
  5c:	fae7dee3          	bge	a5,a4,18 <main+0x18>
  60:	a011                	j	64 <main+0x64>
            break;
  62:	0001                	nop
    }

    exit(0);
  64:	4501                	li	a0,0
  66:	00000097          	auipc	ra,0x0
  6a:	4b2080e7          	jalr	1202(ra) # 518 <exit>

000000000000006e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  6e:	1141                	addi	sp,sp,-16
  70:	e406                	sd	ra,8(sp)
  72:	e022                	sd	s0,0(sp)
  74:	0800                	addi	s0,sp,16
  extern int main();
  main();
  76:	00000097          	auipc	ra,0x0
  7a:	f8a080e7          	jalr	-118(ra) # 0 <main>
  exit(0);
  7e:	4501                	li	a0,0
  80:	00000097          	auipc	ra,0x0
  84:	498080e7          	jalr	1176(ra) # 518 <exit>

0000000000000088 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  88:	7179                	addi	sp,sp,-48
  8a:	f422                	sd	s0,40(sp)
  8c:	1800                	addi	s0,sp,48
  8e:	fca43c23          	sd	a0,-40(s0)
  92:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  96:	fd843783          	ld	a5,-40(s0)
  9a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  9e:	0001                	nop
  a0:	fd043703          	ld	a4,-48(s0)
  a4:	00170793          	addi	a5,a4,1
  a8:	fcf43823          	sd	a5,-48(s0)
  ac:	fd843783          	ld	a5,-40(s0)
  b0:	00178693          	addi	a3,a5,1
  b4:	fcd43c23          	sd	a3,-40(s0)
  b8:	00074703          	lbu	a4,0(a4)
  bc:	00e78023          	sb	a4,0(a5)
  c0:	0007c783          	lbu	a5,0(a5)
  c4:	fff1                	bnez	a5,a0 <strcpy+0x18>
    ;
  return os;
  c6:	fe843783          	ld	a5,-24(s0)
}
  ca:	853e                	mv	a0,a5
  cc:	7422                	ld	s0,40(sp)
  ce:	6145                	addi	sp,sp,48
  d0:	8082                	ret

00000000000000d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d2:	1101                	addi	sp,sp,-32
  d4:	ec22                	sd	s0,24(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	fea43423          	sd	a0,-24(s0)
  dc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  e0:	a819                	j	f6 <strcmp+0x24>
    p++, q++;
  e2:	fe843783          	ld	a5,-24(s0)
  e6:	0785                	addi	a5,a5,1
  e8:	fef43423          	sd	a5,-24(s0)
  ec:	fe043783          	ld	a5,-32(s0)
  f0:	0785                	addi	a5,a5,1
  f2:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  f6:	fe843783          	ld	a5,-24(s0)
  fa:	0007c783          	lbu	a5,0(a5)
  fe:	cb99                	beqz	a5,114 <strcmp+0x42>
 100:	fe843783          	ld	a5,-24(s0)
 104:	0007c703          	lbu	a4,0(a5)
 108:	fe043783          	ld	a5,-32(s0)
 10c:	0007c783          	lbu	a5,0(a5)
 110:	fcf709e3          	beq	a4,a5,e2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 114:	fe843783          	ld	a5,-24(s0)
 118:	0007c783          	lbu	a5,0(a5)
 11c:	0007871b          	sext.w	a4,a5
 120:	fe043783          	ld	a5,-32(s0)
 124:	0007c783          	lbu	a5,0(a5)
 128:	2781                	sext.w	a5,a5
 12a:	40f707bb          	subw	a5,a4,a5
 12e:	2781                	sext.w	a5,a5
}
 130:	853e                	mv	a0,a5
 132:	6462                	ld	s0,24(sp)
 134:	6105                	addi	sp,sp,32
 136:	8082                	ret

0000000000000138 <strlen>:

uint
strlen(const char *s)
{
 138:	7179                	addi	sp,sp,-48
 13a:	f422                	sd	s0,40(sp)
 13c:	1800                	addi	s0,sp,48
 13e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 142:	fe042623          	sw	zero,-20(s0)
 146:	a031                	j	152 <strlen+0x1a>
 148:	fec42783          	lw	a5,-20(s0)
 14c:	2785                	addiw	a5,a5,1
 14e:	fef42623          	sw	a5,-20(s0)
 152:	fec42783          	lw	a5,-20(s0)
 156:	fd843703          	ld	a4,-40(s0)
 15a:	97ba                	add	a5,a5,a4
 15c:	0007c783          	lbu	a5,0(a5)
 160:	f7e5                	bnez	a5,148 <strlen+0x10>
    ;
  return n;
 162:	fec42783          	lw	a5,-20(s0)
}
 166:	853e                	mv	a0,a5
 168:	7422                	ld	s0,40(sp)
 16a:	6145                	addi	sp,sp,48
 16c:	8082                	ret

000000000000016e <memset>:

void*
memset(void *dst, int c, uint n)
{
 16e:	7179                	addi	sp,sp,-48
 170:	f422                	sd	s0,40(sp)
 172:	1800                	addi	s0,sp,48
 174:	fca43c23          	sd	a0,-40(s0)
 178:	87ae                	mv	a5,a1
 17a:	8732                	mv	a4,a2
 17c:	fcf42a23          	sw	a5,-44(s0)
 180:	87ba                	mv	a5,a4
 182:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 186:	fd843783          	ld	a5,-40(s0)
 18a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 18e:	fe042623          	sw	zero,-20(s0)
 192:	a00d                	j	1b4 <memset+0x46>
    cdst[i] = c;
 194:	fec42783          	lw	a5,-20(s0)
 198:	fe043703          	ld	a4,-32(s0)
 19c:	97ba                	add	a5,a5,a4
 19e:	fd442703          	lw	a4,-44(s0)
 1a2:	0ff77713          	andi	a4,a4,255
 1a6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1aa:	fec42783          	lw	a5,-20(s0)
 1ae:	2785                	addiw	a5,a5,1
 1b0:	fef42623          	sw	a5,-20(s0)
 1b4:	fec42703          	lw	a4,-20(s0)
 1b8:	fd042783          	lw	a5,-48(s0)
 1bc:	2781                	sext.w	a5,a5
 1be:	fcf76be3          	bltu	a4,a5,194 <memset+0x26>
  }
  return dst;
 1c2:	fd843783          	ld	a5,-40(s0)
}
 1c6:	853e                	mv	a0,a5
 1c8:	7422                	ld	s0,40(sp)
 1ca:	6145                	addi	sp,sp,48
 1cc:	8082                	ret

00000000000001ce <strchr>:

char*
strchr(const char *s, char c)
{
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec22                	sd	s0,24(sp)
 1d2:	1000                	addi	s0,sp,32
 1d4:	fea43423          	sd	a0,-24(s0)
 1d8:	87ae                	mv	a5,a1
 1da:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1de:	a01d                	j	204 <strchr+0x36>
    if(*s == c)
 1e0:	fe843783          	ld	a5,-24(s0)
 1e4:	0007c703          	lbu	a4,0(a5)
 1e8:	fe744783          	lbu	a5,-25(s0)
 1ec:	0ff7f793          	andi	a5,a5,255
 1f0:	00e79563          	bne	a5,a4,1fa <strchr+0x2c>
      return (char*)s;
 1f4:	fe843783          	ld	a5,-24(s0)
 1f8:	a821                	j	210 <strchr+0x42>
  for(; *s; s++)
 1fa:	fe843783          	ld	a5,-24(s0)
 1fe:	0785                	addi	a5,a5,1
 200:	fef43423          	sd	a5,-24(s0)
 204:	fe843783          	ld	a5,-24(s0)
 208:	0007c783          	lbu	a5,0(a5)
 20c:	fbf1                	bnez	a5,1e0 <strchr+0x12>
  return 0;
 20e:	4781                	li	a5,0
}
 210:	853e                	mv	a0,a5
 212:	6462                	ld	s0,24(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret

0000000000000218 <gets>:

char*
gets(char *buf, int max)
{
 218:	7179                	addi	sp,sp,-48
 21a:	f406                	sd	ra,40(sp)
 21c:	f022                	sd	s0,32(sp)
 21e:	1800                	addi	s0,sp,48
 220:	fca43c23          	sd	a0,-40(s0)
 224:	87ae                	mv	a5,a1
 226:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22a:	fe042623          	sw	zero,-20(s0)
 22e:	a8a1                	j	286 <gets+0x6e>
    cc = read(0, &c, 1);
 230:	fe740793          	addi	a5,s0,-25
 234:	4605                	li	a2,1
 236:	85be                	mv	a1,a5
 238:	4501                	li	a0,0
 23a:	00000097          	auipc	ra,0x0
 23e:	2f6080e7          	jalr	758(ra) # 530 <read>
 242:	87aa                	mv	a5,a0
 244:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 248:	fe842783          	lw	a5,-24(s0)
 24c:	2781                	sext.w	a5,a5
 24e:	04f05763          	blez	a5,29c <gets+0x84>
      break;
    buf[i++] = c;
 252:	fec42783          	lw	a5,-20(s0)
 256:	0017871b          	addiw	a4,a5,1
 25a:	fee42623          	sw	a4,-20(s0)
 25e:	873e                	mv	a4,a5
 260:	fd843783          	ld	a5,-40(s0)
 264:	97ba                	add	a5,a5,a4
 266:	fe744703          	lbu	a4,-25(s0)
 26a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 26e:	fe744783          	lbu	a5,-25(s0)
 272:	873e                	mv	a4,a5
 274:	47a9                	li	a5,10
 276:	02f70463          	beq	a4,a5,29e <gets+0x86>
 27a:	fe744783          	lbu	a5,-25(s0)
 27e:	873e                	mv	a4,a5
 280:	47b5                	li	a5,13
 282:	00f70e63          	beq	a4,a5,29e <gets+0x86>
  for(i=0; i+1 < max; ){
 286:	fec42783          	lw	a5,-20(s0)
 28a:	2785                	addiw	a5,a5,1
 28c:	0007871b          	sext.w	a4,a5
 290:	fd442783          	lw	a5,-44(s0)
 294:	2781                	sext.w	a5,a5
 296:	f8f74de3          	blt	a4,a5,230 <gets+0x18>
 29a:	a011                	j	29e <gets+0x86>
      break;
 29c:	0001                	nop
      break;
  }
  buf[i] = '\0';
 29e:	fec42783          	lw	a5,-20(s0)
 2a2:	fd843703          	ld	a4,-40(s0)
 2a6:	97ba                	add	a5,a5,a4
 2a8:	00078023          	sb	zero,0(a5)
  return buf;
 2ac:	fd843783          	ld	a5,-40(s0)
}
 2b0:	853e                	mv	a0,a5
 2b2:	70a2                	ld	ra,40(sp)
 2b4:	7402                	ld	s0,32(sp)
 2b6:	6145                	addi	sp,sp,48
 2b8:	8082                	ret

00000000000002ba <stat>:

int
stat(const char *n, struct stat *st)
{
 2ba:	7179                	addi	sp,sp,-48
 2bc:	f406                	sd	ra,40(sp)
 2be:	f022                	sd	s0,32(sp)
 2c0:	1800                	addi	s0,sp,48
 2c2:	fca43c23          	sd	a0,-40(s0)
 2c6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ca:	4581                	li	a1,0
 2cc:	fd843503          	ld	a0,-40(s0)
 2d0:	00000097          	auipc	ra,0x0
 2d4:	288080e7          	jalr	648(ra) # 558 <open>
 2d8:	87aa                	mv	a5,a0
 2da:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2de:	fec42783          	lw	a5,-20(s0)
 2e2:	2781                	sext.w	a5,a5
 2e4:	0007d463          	bgez	a5,2ec <stat+0x32>
    return -1;
 2e8:	57fd                	li	a5,-1
 2ea:	a035                	j	316 <stat+0x5c>
  r = fstat(fd, st);
 2ec:	fec42783          	lw	a5,-20(s0)
 2f0:	fd043583          	ld	a1,-48(s0)
 2f4:	853e                	mv	a0,a5
 2f6:	00000097          	auipc	ra,0x0
 2fa:	27a080e7          	jalr	634(ra) # 570 <fstat>
 2fe:	87aa                	mv	a5,a0
 300:	fef42423          	sw	a5,-24(s0)
  close(fd);
 304:	fec42783          	lw	a5,-20(s0)
 308:	853e                	mv	a0,a5
 30a:	00000097          	auipc	ra,0x0
 30e:	236080e7          	jalr	566(ra) # 540 <close>
  return r;
 312:	fe842783          	lw	a5,-24(s0)
}
 316:	853e                	mv	a0,a5
 318:	70a2                	ld	ra,40(sp)
 31a:	7402                	ld	s0,32(sp)
 31c:	6145                	addi	sp,sp,48
 31e:	8082                	ret

0000000000000320 <atoi>:

int
atoi(const char *s)
{
 320:	7179                	addi	sp,sp,-48
 322:	f422                	sd	s0,40(sp)
 324:	1800                	addi	s0,sp,48
 326:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 32a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 32e:	a815                	j	362 <atoi+0x42>
    n = n*10 + *s++ - '0';
 330:	fec42703          	lw	a4,-20(s0)
 334:	87ba                	mv	a5,a4
 336:	0027979b          	slliw	a5,a5,0x2
 33a:	9fb9                	addw	a5,a5,a4
 33c:	0017979b          	slliw	a5,a5,0x1
 340:	0007871b          	sext.w	a4,a5
 344:	fd843783          	ld	a5,-40(s0)
 348:	00178693          	addi	a3,a5,1
 34c:	fcd43c23          	sd	a3,-40(s0)
 350:	0007c783          	lbu	a5,0(a5)
 354:	2781                	sext.w	a5,a5
 356:	9fb9                	addw	a5,a5,a4
 358:	2781                	sext.w	a5,a5
 35a:	fd07879b          	addiw	a5,a5,-48
 35e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 362:	fd843783          	ld	a5,-40(s0)
 366:	0007c783          	lbu	a5,0(a5)
 36a:	873e                	mv	a4,a5
 36c:	02f00793          	li	a5,47
 370:	00e7fb63          	bgeu	a5,a4,386 <atoi+0x66>
 374:	fd843783          	ld	a5,-40(s0)
 378:	0007c783          	lbu	a5,0(a5)
 37c:	873e                	mv	a4,a5
 37e:	03900793          	li	a5,57
 382:	fae7f7e3          	bgeu	a5,a4,330 <atoi+0x10>
  return n;
 386:	fec42783          	lw	a5,-20(s0)
}
 38a:	853e                	mv	a0,a5
 38c:	7422                	ld	s0,40(sp)
 38e:	6145                	addi	sp,sp,48
 390:	8082                	ret

0000000000000392 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 392:	7139                	addi	sp,sp,-64
 394:	fc22                	sd	s0,56(sp)
 396:	0080                	addi	s0,sp,64
 398:	fca43c23          	sd	a0,-40(s0)
 39c:	fcb43823          	sd	a1,-48(s0)
 3a0:	87b2                	mv	a5,a2
 3a2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3a6:	fd843783          	ld	a5,-40(s0)
 3aa:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3ae:	fd043783          	ld	a5,-48(s0)
 3b2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3b6:	fe043703          	ld	a4,-32(s0)
 3ba:	fe843783          	ld	a5,-24(s0)
 3be:	02e7fc63          	bgeu	a5,a4,3f6 <memmove+0x64>
    while(n-- > 0)
 3c2:	a00d                	j	3e4 <memmove+0x52>
      *dst++ = *src++;
 3c4:	fe043703          	ld	a4,-32(s0)
 3c8:	00170793          	addi	a5,a4,1
 3cc:	fef43023          	sd	a5,-32(s0)
 3d0:	fe843783          	ld	a5,-24(s0)
 3d4:	00178693          	addi	a3,a5,1
 3d8:	fed43423          	sd	a3,-24(s0)
 3dc:	00074703          	lbu	a4,0(a4)
 3e0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3e4:	fcc42783          	lw	a5,-52(s0)
 3e8:	fff7871b          	addiw	a4,a5,-1
 3ec:	fce42623          	sw	a4,-52(s0)
 3f0:	fcf04ae3          	bgtz	a5,3c4 <memmove+0x32>
 3f4:	a891                	j	448 <memmove+0xb6>
  } else {
    dst += n;
 3f6:	fcc42783          	lw	a5,-52(s0)
 3fa:	fe843703          	ld	a4,-24(s0)
 3fe:	97ba                	add	a5,a5,a4
 400:	fef43423          	sd	a5,-24(s0)
    src += n;
 404:	fcc42783          	lw	a5,-52(s0)
 408:	fe043703          	ld	a4,-32(s0)
 40c:	97ba                	add	a5,a5,a4
 40e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 412:	a01d                	j	438 <memmove+0xa6>
      *--dst = *--src;
 414:	fe043783          	ld	a5,-32(s0)
 418:	17fd                	addi	a5,a5,-1
 41a:	fef43023          	sd	a5,-32(s0)
 41e:	fe843783          	ld	a5,-24(s0)
 422:	17fd                	addi	a5,a5,-1
 424:	fef43423          	sd	a5,-24(s0)
 428:	fe043783          	ld	a5,-32(s0)
 42c:	0007c703          	lbu	a4,0(a5)
 430:	fe843783          	ld	a5,-24(s0)
 434:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 438:	fcc42783          	lw	a5,-52(s0)
 43c:	fff7871b          	addiw	a4,a5,-1
 440:	fce42623          	sw	a4,-52(s0)
 444:	fcf048e3          	bgtz	a5,414 <memmove+0x82>
  }
  return vdst;
 448:	fd843783          	ld	a5,-40(s0)
}
 44c:	853e                	mv	a0,a5
 44e:	7462                	ld	s0,56(sp)
 450:	6121                	addi	sp,sp,64
 452:	8082                	ret

0000000000000454 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 454:	7139                	addi	sp,sp,-64
 456:	fc22                	sd	s0,56(sp)
 458:	0080                	addi	s0,sp,64
 45a:	fca43c23          	sd	a0,-40(s0)
 45e:	fcb43823          	sd	a1,-48(s0)
 462:	87b2                	mv	a5,a2
 464:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 468:	fd843783          	ld	a5,-40(s0)
 46c:	fef43423          	sd	a5,-24(s0)
 470:	fd043783          	ld	a5,-48(s0)
 474:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 478:	a0a1                	j	4c0 <memcmp+0x6c>
    if (*p1 != *p2) {
 47a:	fe843783          	ld	a5,-24(s0)
 47e:	0007c703          	lbu	a4,0(a5)
 482:	fe043783          	ld	a5,-32(s0)
 486:	0007c783          	lbu	a5,0(a5)
 48a:	02f70163          	beq	a4,a5,4ac <memcmp+0x58>
      return *p1 - *p2;
 48e:	fe843783          	ld	a5,-24(s0)
 492:	0007c783          	lbu	a5,0(a5)
 496:	0007871b          	sext.w	a4,a5
 49a:	fe043783          	ld	a5,-32(s0)
 49e:	0007c783          	lbu	a5,0(a5)
 4a2:	2781                	sext.w	a5,a5
 4a4:	40f707bb          	subw	a5,a4,a5
 4a8:	2781                	sext.w	a5,a5
 4aa:	a01d                	j	4d0 <memcmp+0x7c>
    }
    p1++;
 4ac:	fe843783          	ld	a5,-24(s0)
 4b0:	0785                	addi	a5,a5,1
 4b2:	fef43423          	sd	a5,-24(s0)
    p2++;
 4b6:	fe043783          	ld	a5,-32(s0)
 4ba:	0785                	addi	a5,a5,1
 4bc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c0:	fcc42783          	lw	a5,-52(s0)
 4c4:	fff7871b          	addiw	a4,a5,-1
 4c8:	fce42623          	sw	a4,-52(s0)
 4cc:	f7dd                	bnez	a5,47a <memcmp+0x26>
  }
  return 0;
 4ce:	4781                	li	a5,0
}
 4d0:	853e                	mv	a0,a5
 4d2:	7462                	ld	s0,56(sp)
 4d4:	6121                	addi	sp,sp,64
 4d6:	8082                	ret

00000000000004d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4d8:	7179                	addi	sp,sp,-48
 4da:	f406                	sd	ra,40(sp)
 4dc:	f022                	sd	s0,32(sp)
 4de:	1800                	addi	s0,sp,48
 4e0:	fea43423          	sd	a0,-24(s0)
 4e4:	feb43023          	sd	a1,-32(s0)
 4e8:	87b2                	mv	a5,a2
 4ea:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4ee:	fdc42783          	lw	a5,-36(s0)
 4f2:	863e                	mv	a2,a5
 4f4:	fe043583          	ld	a1,-32(s0)
 4f8:	fe843503          	ld	a0,-24(s0)
 4fc:	00000097          	auipc	ra,0x0
 500:	e96080e7          	jalr	-362(ra) # 392 <memmove>
 504:	87aa                	mv	a5,a0
}
 506:	853e                	mv	a0,a5
 508:	70a2                	ld	ra,40(sp)
 50a:	7402                	ld	s0,32(sp)
 50c:	6145                	addi	sp,sp,48
 50e:	8082                	ret

0000000000000510 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 510:	4885                	li	a7,1
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <exit>:
.global exit
exit:
 li a7, SYS_exit
 518:	4889                	li	a7,2
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <wait>:
.global wait
wait:
 li a7, SYS_wait
 520:	488d                	li	a7,3
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 528:	4891                	li	a7,4
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <read>:
.global read
read:
 li a7, SYS_read
 530:	4895                	li	a7,5
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <write>:
.global write
write:
 li a7, SYS_write
 538:	48c1                	li	a7,16
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <close>:
.global close
close:
 li a7, SYS_close
 540:	48d5                	li	a7,21
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <kill>:
.global kill
kill:
 li a7, SYS_kill
 548:	4899                	li	a7,6
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <exec>:
.global exec
exec:
 li a7, SYS_exec
 550:	489d                	li	a7,7
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <open>:
.global open
open:
 li a7, SYS_open
 558:	48bd                	li	a7,15
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 560:	48c5                	li	a7,17
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 568:	48c9                	li	a7,18
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 570:	48a1                	li	a7,8
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <link>:
.global link
link:
 li a7, SYS_link
 578:	48cd                	li	a7,19
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 580:	48d1                	li	a7,20
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 588:	48a5                	li	a7,9
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <dup>:
.global dup
dup:
 li a7, SYS_dup
 590:	48a9                	li	a7,10
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 598:	48ad                	li	a7,11
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a0:	48b1                	li	a7,12
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5a8:	48b5                	li	a7,13
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b0:	48b9                	li	a7,14
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5b8:	1101                	addi	sp,sp,-32
 5ba:	ec06                	sd	ra,24(sp)
 5bc:	e822                	sd	s0,16(sp)
 5be:	1000                	addi	s0,sp,32
 5c0:	87aa                	mv	a5,a0
 5c2:	872e                	mv	a4,a1
 5c4:	fef42623          	sw	a5,-20(s0)
 5c8:	87ba                	mv	a5,a4
 5ca:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5ce:	feb40713          	addi	a4,s0,-21
 5d2:	fec42783          	lw	a5,-20(s0)
 5d6:	4605                	li	a2,1
 5d8:	85ba                	mv	a1,a4
 5da:	853e                	mv	a0,a5
 5dc:	00000097          	auipc	ra,0x0
 5e0:	f5c080e7          	jalr	-164(ra) # 538 <write>
}
 5e4:	0001                	nop
 5e6:	60e2                	ld	ra,24(sp)
 5e8:	6442                	ld	s0,16(sp)
 5ea:	6105                	addi	sp,sp,32
 5ec:	8082                	ret

00000000000005ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ee:	7139                	addi	sp,sp,-64
 5f0:	fc06                	sd	ra,56(sp)
 5f2:	f822                	sd	s0,48(sp)
 5f4:	0080                	addi	s0,sp,64
 5f6:	87aa                	mv	a5,a0
 5f8:	8736                	mv	a4,a3
 5fa:	fcf42623          	sw	a5,-52(s0)
 5fe:	87ae                	mv	a5,a1
 600:	fcf42423          	sw	a5,-56(s0)
 604:	87b2                	mv	a5,a2
 606:	fcf42223          	sw	a5,-60(s0)
 60a:	87ba                	mv	a5,a4
 60c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 610:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 614:	fc042783          	lw	a5,-64(s0)
 618:	2781                	sext.w	a5,a5
 61a:	c38d                	beqz	a5,63c <printint+0x4e>
 61c:	fc842783          	lw	a5,-56(s0)
 620:	2781                	sext.w	a5,a5
 622:	0007dd63          	bgez	a5,63c <printint+0x4e>
    neg = 1;
 626:	4785                	li	a5,1
 628:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 62c:	fc842783          	lw	a5,-56(s0)
 630:	40f007bb          	negw	a5,a5
 634:	2781                	sext.w	a5,a5
 636:	fef42223          	sw	a5,-28(s0)
 63a:	a029                	j	644 <printint+0x56>
  } else {
    x = xx;
 63c:	fc842783          	lw	a5,-56(s0)
 640:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 644:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 648:	fc442783          	lw	a5,-60(s0)
 64c:	fe442703          	lw	a4,-28(s0)
 650:	02f777bb          	remuw	a5,a4,a5
 654:	0007861b          	sext.w	a2,a5
 658:	fec42783          	lw	a5,-20(s0)
 65c:	0017871b          	addiw	a4,a5,1
 660:	fee42623          	sw	a4,-20(s0)
 664:	00001697          	auipc	a3,0x1
 668:	99c68693          	addi	a3,a3,-1636 # 1000 <digits>
 66c:	02061713          	slli	a4,a2,0x20
 670:	9301                	srli	a4,a4,0x20
 672:	9736                	add	a4,a4,a3
 674:	00074703          	lbu	a4,0(a4)
 678:	ff040693          	addi	a3,s0,-16
 67c:	97b6                	add	a5,a5,a3
 67e:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 682:	fc442783          	lw	a5,-60(s0)
 686:	fe442703          	lw	a4,-28(s0)
 68a:	02f757bb          	divuw	a5,a4,a5
 68e:	fef42223          	sw	a5,-28(s0)
 692:	fe442783          	lw	a5,-28(s0)
 696:	2781                	sext.w	a5,a5
 698:	fbc5                	bnez	a5,648 <printint+0x5a>
  if(neg)
 69a:	fe842783          	lw	a5,-24(s0)
 69e:	2781                	sext.w	a5,a5
 6a0:	cf95                	beqz	a5,6dc <printint+0xee>
    buf[i++] = '-';
 6a2:	fec42783          	lw	a5,-20(s0)
 6a6:	0017871b          	addiw	a4,a5,1
 6aa:	fee42623          	sw	a4,-20(s0)
 6ae:	ff040713          	addi	a4,s0,-16
 6b2:	97ba                	add	a5,a5,a4
 6b4:	02d00713          	li	a4,45
 6b8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6bc:	a005                	j	6dc <printint+0xee>
    putc(fd, buf[i]);
 6be:	fec42783          	lw	a5,-20(s0)
 6c2:	ff040713          	addi	a4,s0,-16
 6c6:	97ba                	add	a5,a5,a4
 6c8:	fe07c703          	lbu	a4,-32(a5)
 6cc:	fcc42783          	lw	a5,-52(s0)
 6d0:	85ba                	mv	a1,a4
 6d2:	853e                	mv	a0,a5
 6d4:	00000097          	auipc	ra,0x0
 6d8:	ee4080e7          	jalr	-284(ra) # 5b8 <putc>
  while(--i >= 0)
 6dc:	fec42783          	lw	a5,-20(s0)
 6e0:	37fd                	addiw	a5,a5,-1
 6e2:	fef42623          	sw	a5,-20(s0)
 6e6:	fec42783          	lw	a5,-20(s0)
 6ea:	2781                	sext.w	a5,a5
 6ec:	fc07d9e3          	bgez	a5,6be <printint+0xd0>
}
 6f0:	0001                	nop
 6f2:	0001                	nop
 6f4:	70e2                	ld	ra,56(sp)
 6f6:	7442                	ld	s0,48(sp)
 6f8:	6121                	addi	sp,sp,64
 6fa:	8082                	ret

00000000000006fc <printptr>:

static void
printptr(int fd, uint64 x) {
 6fc:	7179                	addi	sp,sp,-48
 6fe:	f406                	sd	ra,40(sp)
 700:	f022                	sd	s0,32(sp)
 702:	1800                	addi	s0,sp,48
 704:	87aa                	mv	a5,a0
 706:	fcb43823          	sd	a1,-48(s0)
 70a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 70e:	fdc42783          	lw	a5,-36(s0)
 712:	03000593          	li	a1,48
 716:	853e                	mv	a0,a5
 718:	00000097          	auipc	ra,0x0
 71c:	ea0080e7          	jalr	-352(ra) # 5b8 <putc>
  putc(fd, 'x');
 720:	fdc42783          	lw	a5,-36(s0)
 724:	07800593          	li	a1,120
 728:	853e                	mv	a0,a5
 72a:	00000097          	auipc	ra,0x0
 72e:	e8e080e7          	jalr	-370(ra) # 5b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 732:	fe042623          	sw	zero,-20(s0)
 736:	a82d                	j	770 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 738:	fd043783          	ld	a5,-48(s0)
 73c:	93f1                	srli	a5,a5,0x3c
 73e:	00001717          	auipc	a4,0x1
 742:	8c270713          	addi	a4,a4,-1854 # 1000 <digits>
 746:	97ba                	add	a5,a5,a4
 748:	0007c703          	lbu	a4,0(a5)
 74c:	fdc42783          	lw	a5,-36(s0)
 750:	85ba                	mv	a1,a4
 752:	853e                	mv	a0,a5
 754:	00000097          	auipc	ra,0x0
 758:	e64080e7          	jalr	-412(ra) # 5b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 75c:	fec42783          	lw	a5,-20(s0)
 760:	2785                	addiw	a5,a5,1
 762:	fef42623          	sw	a5,-20(s0)
 766:	fd043783          	ld	a5,-48(s0)
 76a:	0792                	slli	a5,a5,0x4
 76c:	fcf43823          	sd	a5,-48(s0)
 770:	fec42783          	lw	a5,-20(s0)
 774:	873e                	mv	a4,a5
 776:	47bd                	li	a5,15
 778:	fce7f0e3          	bgeu	a5,a4,738 <printptr+0x3c>
}
 77c:	0001                	nop
 77e:	0001                	nop
 780:	70a2                	ld	ra,40(sp)
 782:	7402                	ld	s0,32(sp)
 784:	6145                	addi	sp,sp,48
 786:	8082                	ret

0000000000000788 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 788:	715d                	addi	sp,sp,-80
 78a:	e486                	sd	ra,72(sp)
 78c:	e0a2                	sd	s0,64(sp)
 78e:	0880                	addi	s0,sp,80
 790:	87aa                	mv	a5,a0
 792:	fcb43023          	sd	a1,-64(s0)
 796:	fac43c23          	sd	a2,-72(s0)
 79a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 79e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7a2:	fe042223          	sw	zero,-28(s0)
 7a6:	a42d                	j	9d0 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7a8:	fe442783          	lw	a5,-28(s0)
 7ac:	fc043703          	ld	a4,-64(s0)
 7b0:	97ba                	add	a5,a5,a4
 7b2:	0007c783          	lbu	a5,0(a5)
 7b6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7ba:	fe042783          	lw	a5,-32(s0)
 7be:	2781                	sext.w	a5,a5
 7c0:	eb9d                	bnez	a5,7f6 <vprintf+0x6e>
      if(c == '%'){
 7c2:	fdc42783          	lw	a5,-36(s0)
 7c6:	0007871b          	sext.w	a4,a5
 7ca:	02500793          	li	a5,37
 7ce:	00f71763          	bne	a4,a5,7dc <vprintf+0x54>
        state = '%';
 7d2:	02500793          	li	a5,37
 7d6:	fef42023          	sw	a5,-32(s0)
 7da:	a2f5                	j	9c6 <vprintf+0x23e>
      } else {
        putc(fd, c);
 7dc:	fdc42783          	lw	a5,-36(s0)
 7e0:	0ff7f713          	andi	a4,a5,255
 7e4:	fcc42783          	lw	a5,-52(s0)
 7e8:	85ba                	mv	a1,a4
 7ea:	853e                	mv	a0,a5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	dcc080e7          	jalr	-564(ra) # 5b8 <putc>
 7f4:	aac9                	j	9c6 <vprintf+0x23e>
      }
    } else if(state == '%'){
 7f6:	fe042783          	lw	a5,-32(s0)
 7fa:	0007871b          	sext.w	a4,a5
 7fe:	02500793          	li	a5,37
 802:	1cf71263          	bne	a4,a5,9c6 <vprintf+0x23e>
      if(c == 'd'){
 806:	fdc42783          	lw	a5,-36(s0)
 80a:	0007871b          	sext.w	a4,a5
 80e:	06400793          	li	a5,100
 812:	02f71463          	bne	a4,a5,83a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 816:	fb843783          	ld	a5,-72(s0)
 81a:	00878713          	addi	a4,a5,8
 81e:	fae43c23          	sd	a4,-72(s0)
 822:	4398                	lw	a4,0(a5)
 824:	fcc42783          	lw	a5,-52(s0)
 828:	4685                	li	a3,1
 82a:	4629                	li	a2,10
 82c:	85ba                	mv	a1,a4
 82e:	853e                	mv	a0,a5
 830:	00000097          	auipc	ra,0x0
 834:	dbe080e7          	jalr	-578(ra) # 5ee <printint>
 838:	a269                	j	9c2 <vprintf+0x23a>
      } else if(c == 'l') {
 83a:	fdc42783          	lw	a5,-36(s0)
 83e:	0007871b          	sext.w	a4,a5
 842:	06c00793          	li	a5,108
 846:	02f71663          	bne	a4,a5,872 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 84a:	fb843783          	ld	a5,-72(s0)
 84e:	00878713          	addi	a4,a5,8
 852:	fae43c23          	sd	a4,-72(s0)
 856:	639c                	ld	a5,0(a5)
 858:	0007871b          	sext.w	a4,a5
 85c:	fcc42783          	lw	a5,-52(s0)
 860:	4681                	li	a3,0
 862:	4629                	li	a2,10
 864:	85ba                	mv	a1,a4
 866:	853e                	mv	a0,a5
 868:	00000097          	auipc	ra,0x0
 86c:	d86080e7          	jalr	-634(ra) # 5ee <printint>
 870:	aa89                	j	9c2 <vprintf+0x23a>
      } else if(c == 'x') {
 872:	fdc42783          	lw	a5,-36(s0)
 876:	0007871b          	sext.w	a4,a5
 87a:	07800793          	li	a5,120
 87e:	02f71463          	bne	a4,a5,8a6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 882:	fb843783          	ld	a5,-72(s0)
 886:	00878713          	addi	a4,a5,8
 88a:	fae43c23          	sd	a4,-72(s0)
 88e:	4398                	lw	a4,0(a5)
 890:	fcc42783          	lw	a5,-52(s0)
 894:	4681                	li	a3,0
 896:	4641                	li	a2,16
 898:	85ba                	mv	a1,a4
 89a:	853e                	mv	a0,a5
 89c:	00000097          	auipc	ra,0x0
 8a0:	d52080e7          	jalr	-686(ra) # 5ee <printint>
 8a4:	aa39                	j	9c2 <vprintf+0x23a>
      } else if(c == 'p') {
 8a6:	fdc42783          	lw	a5,-36(s0)
 8aa:	0007871b          	sext.w	a4,a5
 8ae:	07000793          	li	a5,112
 8b2:	02f71263          	bne	a4,a5,8d6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8b6:	fb843783          	ld	a5,-72(s0)
 8ba:	00878713          	addi	a4,a5,8
 8be:	fae43c23          	sd	a4,-72(s0)
 8c2:	6398                	ld	a4,0(a5)
 8c4:	fcc42783          	lw	a5,-52(s0)
 8c8:	85ba                	mv	a1,a4
 8ca:	853e                	mv	a0,a5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	e30080e7          	jalr	-464(ra) # 6fc <printptr>
 8d4:	a0fd                	j	9c2 <vprintf+0x23a>
      } else if(c == 's'){
 8d6:	fdc42783          	lw	a5,-36(s0)
 8da:	0007871b          	sext.w	a4,a5
 8de:	07300793          	li	a5,115
 8e2:	04f71c63          	bne	a4,a5,93a <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8e6:	fb843783          	ld	a5,-72(s0)
 8ea:	00878713          	addi	a4,a5,8
 8ee:	fae43c23          	sd	a4,-72(s0)
 8f2:	639c                	ld	a5,0(a5)
 8f4:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 8f8:	fe843783          	ld	a5,-24(s0)
 8fc:	eb8d                	bnez	a5,92e <vprintf+0x1a6>
          s = "(null)";
 8fe:	00000797          	auipc	a5,0x0
 902:	48278793          	addi	a5,a5,1154 # d80 <malloc+0x148>
 906:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 90a:	a015                	j	92e <vprintf+0x1a6>
          putc(fd, *s);
 90c:	fe843783          	ld	a5,-24(s0)
 910:	0007c703          	lbu	a4,0(a5)
 914:	fcc42783          	lw	a5,-52(s0)
 918:	85ba                	mv	a1,a4
 91a:	853e                	mv	a0,a5
 91c:	00000097          	auipc	ra,0x0
 920:	c9c080e7          	jalr	-868(ra) # 5b8 <putc>
          s++;
 924:	fe843783          	ld	a5,-24(s0)
 928:	0785                	addi	a5,a5,1
 92a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 92e:	fe843783          	ld	a5,-24(s0)
 932:	0007c783          	lbu	a5,0(a5)
 936:	fbf9                	bnez	a5,90c <vprintf+0x184>
 938:	a069                	j	9c2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 93a:	fdc42783          	lw	a5,-36(s0)
 93e:	0007871b          	sext.w	a4,a5
 942:	06300793          	li	a5,99
 946:	02f71463          	bne	a4,a5,96e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 94a:	fb843783          	ld	a5,-72(s0)
 94e:	00878713          	addi	a4,a5,8
 952:	fae43c23          	sd	a4,-72(s0)
 956:	439c                	lw	a5,0(a5)
 958:	0ff7f713          	andi	a4,a5,255
 95c:	fcc42783          	lw	a5,-52(s0)
 960:	85ba                	mv	a1,a4
 962:	853e                	mv	a0,a5
 964:	00000097          	auipc	ra,0x0
 968:	c54080e7          	jalr	-940(ra) # 5b8 <putc>
 96c:	a899                	j	9c2 <vprintf+0x23a>
      } else if(c == '%'){
 96e:	fdc42783          	lw	a5,-36(s0)
 972:	0007871b          	sext.w	a4,a5
 976:	02500793          	li	a5,37
 97a:	00f71f63          	bne	a4,a5,998 <vprintf+0x210>
        putc(fd, c);
 97e:	fdc42783          	lw	a5,-36(s0)
 982:	0ff7f713          	andi	a4,a5,255
 986:	fcc42783          	lw	a5,-52(s0)
 98a:	85ba                	mv	a1,a4
 98c:	853e                	mv	a0,a5
 98e:	00000097          	auipc	ra,0x0
 992:	c2a080e7          	jalr	-982(ra) # 5b8 <putc>
 996:	a035                	j	9c2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 998:	fcc42783          	lw	a5,-52(s0)
 99c:	02500593          	li	a1,37
 9a0:	853e                	mv	a0,a5
 9a2:	00000097          	auipc	ra,0x0
 9a6:	c16080e7          	jalr	-1002(ra) # 5b8 <putc>
        putc(fd, c);
 9aa:	fdc42783          	lw	a5,-36(s0)
 9ae:	0ff7f713          	andi	a4,a5,255
 9b2:	fcc42783          	lw	a5,-52(s0)
 9b6:	85ba                	mv	a1,a4
 9b8:	853e                	mv	a0,a5
 9ba:	00000097          	auipc	ra,0x0
 9be:	bfe080e7          	jalr	-1026(ra) # 5b8 <putc>
      }
      state = 0;
 9c2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9c6:	fe442783          	lw	a5,-28(s0)
 9ca:	2785                	addiw	a5,a5,1
 9cc:	fef42223          	sw	a5,-28(s0)
 9d0:	fe442783          	lw	a5,-28(s0)
 9d4:	fc043703          	ld	a4,-64(s0)
 9d8:	97ba                	add	a5,a5,a4
 9da:	0007c783          	lbu	a5,0(a5)
 9de:	dc0795e3          	bnez	a5,7a8 <vprintf+0x20>
    }
  }
}
 9e2:	0001                	nop
 9e4:	0001                	nop
 9e6:	60a6                	ld	ra,72(sp)
 9e8:	6406                	ld	s0,64(sp)
 9ea:	6161                	addi	sp,sp,80
 9ec:	8082                	ret

00000000000009ee <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9ee:	7159                	addi	sp,sp,-112
 9f0:	fc06                	sd	ra,56(sp)
 9f2:	f822                	sd	s0,48(sp)
 9f4:	0080                	addi	s0,sp,64
 9f6:	fcb43823          	sd	a1,-48(s0)
 9fa:	e010                	sd	a2,0(s0)
 9fc:	e414                	sd	a3,8(s0)
 9fe:	e818                	sd	a4,16(s0)
 a00:	ec1c                	sd	a5,24(s0)
 a02:	03043023          	sd	a6,32(s0)
 a06:	03143423          	sd	a7,40(s0)
 a0a:	87aa                	mv	a5,a0
 a0c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a10:	03040793          	addi	a5,s0,48
 a14:	fcf43423          	sd	a5,-56(s0)
 a18:	fc843783          	ld	a5,-56(s0)
 a1c:	fd078793          	addi	a5,a5,-48
 a20:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a24:	fe843703          	ld	a4,-24(s0)
 a28:	fdc42783          	lw	a5,-36(s0)
 a2c:	863a                	mv	a2,a4
 a2e:	fd043583          	ld	a1,-48(s0)
 a32:	853e                	mv	a0,a5
 a34:	00000097          	auipc	ra,0x0
 a38:	d54080e7          	jalr	-684(ra) # 788 <vprintf>
}
 a3c:	0001                	nop
 a3e:	70e2                	ld	ra,56(sp)
 a40:	7442                	ld	s0,48(sp)
 a42:	6165                	addi	sp,sp,112
 a44:	8082                	ret

0000000000000a46 <printf>:

void
printf(const char *fmt, ...)
{
 a46:	7159                	addi	sp,sp,-112
 a48:	f406                	sd	ra,40(sp)
 a4a:	f022                	sd	s0,32(sp)
 a4c:	1800                	addi	s0,sp,48
 a4e:	fca43c23          	sd	a0,-40(s0)
 a52:	e40c                	sd	a1,8(s0)
 a54:	e810                	sd	a2,16(s0)
 a56:	ec14                	sd	a3,24(s0)
 a58:	f018                	sd	a4,32(s0)
 a5a:	f41c                	sd	a5,40(s0)
 a5c:	03043823          	sd	a6,48(s0)
 a60:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a64:	04040793          	addi	a5,s0,64
 a68:	fcf43823          	sd	a5,-48(s0)
 a6c:	fd043783          	ld	a5,-48(s0)
 a70:	fc878793          	addi	a5,a5,-56
 a74:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a78:	fe843783          	ld	a5,-24(s0)
 a7c:	863e                	mv	a2,a5
 a7e:	fd843583          	ld	a1,-40(s0)
 a82:	4505                	li	a0,1
 a84:	00000097          	auipc	ra,0x0
 a88:	d04080e7          	jalr	-764(ra) # 788 <vprintf>
}
 a8c:	0001                	nop
 a8e:	70a2                	ld	ra,40(sp)
 a90:	7402                	ld	s0,32(sp)
 a92:	6165                	addi	sp,sp,112
 a94:	8082                	ret

0000000000000a96 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a96:	7179                	addi	sp,sp,-48
 a98:	f422                	sd	s0,40(sp)
 a9a:	1800                	addi	s0,sp,48
 a9c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 aa0:	fd843783          	ld	a5,-40(s0)
 aa4:	17c1                	addi	a5,a5,-16
 aa6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aaa:	00000797          	auipc	a5,0x0
 aae:	58678793          	addi	a5,a5,1414 # 1030 <freep>
 ab2:	639c                	ld	a5,0(a5)
 ab4:	fef43423          	sd	a5,-24(s0)
 ab8:	a815                	j	aec <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aba:	fe843783          	ld	a5,-24(s0)
 abe:	639c                	ld	a5,0(a5)
 ac0:	fe843703          	ld	a4,-24(s0)
 ac4:	00f76f63          	bltu	a4,a5,ae2 <free+0x4c>
 ac8:	fe043703          	ld	a4,-32(s0)
 acc:	fe843783          	ld	a5,-24(s0)
 ad0:	02e7eb63          	bltu	a5,a4,b06 <free+0x70>
 ad4:	fe843783          	ld	a5,-24(s0)
 ad8:	639c                	ld	a5,0(a5)
 ada:	fe043703          	ld	a4,-32(s0)
 ade:	02f76463          	bltu	a4,a5,b06 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae2:	fe843783          	ld	a5,-24(s0)
 ae6:	639c                	ld	a5,0(a5)
 ae8:	fef43423          	sd	a5,-24(s0)
 aec:	fe043703          	ld	a4,-32(s0)
 af0:	fe843783          	ld	a5,-24(s0)
 af4:	fce7f3e3          	bgeu	a5,a4,aba <free+0x24>
 af8:	fe843783          	ld	a5,-24(s0)
 afc:	639c                	ld	a5,0(a5)
 afe:	fe043703          	ld	a4,-32(s0)
 b02:	faf77ce3          	bgeu	a4,a5,aba <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b06:	fe043783          	ld	a5,-32(s0)
 b0a:	479c                	lw	a5,8(a5)
 b0c:	1782                	slli	a5,a5,0x20
 b0e:	9381                	srli	a5,a5,0x20
 b10:	0792                	slli	a5,a5,0x4
 b12:	fe043703          	ld	a4,-32(s0)
 b16:	973e                	add	a4,a4,a5
 b18:	fe843783          	ld	a5,-24(s0)
 b1c:	639c                	ld	a5,0(a5)
 b1e:	02f71763          	bne	a4,a5,b4c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b22:	fe043783          	ld	a5,-32(s0)
 b26:	4798                	lw	a4,8(a5)
 b28:	fe843783          	ld	a5,-24(s0)
 b2c:	639c                	ld	a5,0(a5)
 b2e:	479c                	lw	a5,8(a5)
 b30:	9fb9                	addw	a5,a5,a4
 b32:	0007871b          	sext.w	a4,a5
 b36:	fe043783          	ld	a5,-32(s0)
 b3a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b3c:	fe843783          	ld	a5,-24(s0)
 b40:	639c                	ld	a5,0(a5)
 b42:	6398                	ld	a4,0(a5)
 b44:	fe043783          	ld	a5,-32(s0)
 b48:	e398                	sd	a4,0(a5)
 b4a:	a039                	j	b58 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b4c:	fe843783          	ld	a5,-24(s0)
 b50:	6398                	ld	a4,0(a5)
 b52:	fe043783          	ld	a5,-32(s0)
 b56:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b58:	fe843783          	ld	a5,-24(s0)
 b5c:	479c                	lw	a5,8(a5)
 b5e:	1782                	slli	a5,a5,0x20
 b60:	9381                	srli	a5,a5,0x20
 b62:	0792                	slli	a5,a5,0x4
 b64:	fe843703          	ld	a4,-24(s0)
 b68:	97ba                	add	a5,a5,a4
 b6a:	fe043703          	ld	a4,-32(s0)
 b6e:	02f71563          	bne	a4,a5,b98 <free+0x102>
    p->s.size += bp->s.size;
 b72:	fe843783          	ld	a5,-24(s0)
 b76:	4798                	lw	a4,8(a5)
 b78:	fe043783          	ld	a5,-32(s0)
 b7c:	479c                	lw	a5,8(a5)
 b7e:	9fb9                	addw	a5,a5,a4
 b80:	0007871b          	sext.w	a4,a5
 b84:	fe843783          	ld	a5,-24(s0)
 b88:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b8a:	fe043783          	ld	a5,-32(s0)
 b8e:	6398                	ld	a4,0(a5)
 b90:	fe843783          	ld	a5,-24(s0)
 b94:	e398                	sd	a4,0(a5)
 b96:	a031                	j	ba2 <free+0x10c>
  } else
    p->s.ptr = bp;
 b98:	fe843783          	ld	a5,-24(s0)
 b9c:	fe043703          	ld	a4,-32(s0)
 ba0:	e398                	sd	a4,0(a5)
  freep = p;
 ba2:	00000797          	auipc	a5,0x0
 ba6:	48e78793          	addi	a5,a5,1166 # 1030 <freep>
 baa:	fe843703          	ld	a4,-24(s0)
 bae:	e398                	sd	a4,0(a5)
}
 bb0:	0001                	nop
 bb2:	7422                	ld	s0,40(sp)
 bb4:	6145                	addi	sp,sp,48
 bb6:	8082                	ret

0000000000000bb8 <morecore>:

static Header*
morecore(uint nu)
{
 bb8:	7179                	addi	sp,sp,-48
 bba:	f406                	sd	ra,40(sp)
 bbc:	f022                	sd	s0,32(sp)
 bbe:	1800                	addi	s0,sp,48
 bc0:	87aa                	mv	a5,a0
 bc2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bc6:	fdc42783          	lw	a5,-36(s0)
 bca:	0007871b          	sext.w	a4,a5
 bce:	6785                	lui	a5,0x1
 bd0:	00f77563          	bgeu	a4,a5,bda <morecore+0x22>
    nu = 4096;
 bd4:	6785                	lui	a5,0x1
 bd6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bda:	fdc42783          	lw	a5,-36(s0)
 bde:	0047979b          	slliw	a5,a5,0x4
 be2:	2781                	sext.w	a5,a5
 be4:	2781                	sext.w	a5,a5
 be6:	853e                	mv	a0,a5
 be8:	00000097          	auipc	ra,0x0
 bec:	9b8080e7          	jalr	-1608(ra) # 5a0 <sbrk>
 bf0:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 bf4:	fe843703          	ld	a4,-24(s0)
 bf8:	57fd                	li	a5,-1
 bfa:	00f71463          	bne	a4,a5,c02 <morecore+0x4a>
    return 0;
 bfe:	4781                	li	a5,0
 c00:	a03d                	j	c2e <morecore+0x76>
  hp = (Header*)p;
 c02:	fe843783          	ld	a5,-24(s0)
 c06:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c0a:	fe043783          	ld	a5,-32(s0)
 c0e:	fdc42703          	lw	a4,-36(s0)
 c12:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c14:	fe043783          	ld	a5,-32(s0)
 c18:	07c1                	addi	a5,a5,16
 c1a:	853e                	mv	a0,a5
 c1c:	00000097          	auipc	ra,0x0
 c20:	e7a080e7          	jalr	-390(ra) # a96 <free>
  return freep;
 c24:	00000797          	auipc	a5,0x0
 c28:	40c78793          	addi	a5,a5,1036 # 1030 <freep>
 c2c:	639c                	ld	a5,0(a5)
}
 c2e:	853e                	mv	a0,a5
 c30:	70a2                	ld	ra,40(sp)
 c32:	7402                	ld	s0,32(sp)
 c34:	6145                	addi	sp,sp,48
 c36:	8082                	ret

0000000000000c38 <malloc>:

void*
malloc(uint nbytes)
{
 c38:	7139                	addi	sp,sp,-64
 c3a:	fc06                	sd	ra,56(sp)
 c3c:	f822                	sd	s0,48(sp)
 c3e:	0080                	addi	s0,sp,64
 c40:	87aa                	mv	a5,a0
 c42:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c46:	fcc46783          	lwu	a5,-52(s0)
 c4a:	07bd                	addi	a5,a5,15
 c4c:	8391                	srli	a5,a5,0x4
 c4e:	2781                	sext.w	a5,a5
 c50:	2785                	addiw	a5,a5,1
 c52:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c56:	00000797          	auipc	a5,0x0
 c5a:	3da78793          	addi	a5,a5,986 # 1030 <freep>
 c5e:	639c                	ld	a5,0(a5)
 c60:	fef43023          	sd	a5,-32(s0)
 c64:	fe043783          	ld	a5,-32(s0)
 c68:	ef95                	bnez	a5,ca4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c6a:	00000797          	auipc	a5,0x0
 c6e:	3b678793          	addi	a5,a5,950 # 1020 <base>
 c72:	fef43023          	sd	a5,-32(s0)
 c76:	00000797          	auipc	a5,0x0
 c7a:	3ba78793          	addi	a5,a5,954 # 1030 <freep>
 c7e:	fe043703          	ld	a4,-32(s0)
 c82:	e398                	sd	a4,0(a5)
 c84:	00000797          	auipc	a5,0x0
 c88:	3ac78793          	addi	a5,a5,940 # 1030 <freep>
 c8c:	6398                	ld	a4,0(a5)
 c8e:	00000797          	auipc	a5,0x0
 c92:	39278793          	addi	a5,a5,914 # 1020 <base>
 c96:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 c98:	00000797          	auipc	a5,0x0
 c9c:	38878793          	addi	a5,a5,904 # 1020 <base>
 ca0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ca4:	fe043783          	ld	a5,-32(s0)
 ca8:	639c                	ld	a5,0(a5)
 caa:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cae:	fe843783          	ld	a5,-24(s0)
 cb2:	4798                	lw	a4,8(a5)
 cb4:	fdc42783          	lw	a5,-36(s0)
 cb8:	2781                	sext.w	a5,a5
 cba:	06f76863          	bltu	a4,a5,d2a <malloc+0xf2>
      if(p->s.size == nunits)
 cbe:	fe843783          	ld	a5,-24(s0)
 cc2:	4798                	lw	a4,8(a5)
 cc4:	fdc42783          	lw	a5,-36(s0)
 cc8:	2781                	sext.w	a5,a5
 cca:	00e79963          	bne	a5,a4,cdc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 cce:	fe843783          	ld	a5,-24(s0)
 cd2:	6398                	ld	a4,0(a5)
 cd4:	fe043783          	ld	a5,-32(s0)
 cd8:	e398                	sd	a4,0(a5)
 cda:	a82d                	j	d14 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 cdc:	fe843783          	ld	a5,-24(s0)
 ce0:	4798                	lw	a4,8(a5)
 ce2:	fdc42783          	lw	a5,-36(s0)
 ce6:	40f707bb          	subw	a5,a4,a5
 cea:	0007871b          	sext.w	a4,a5
 cee:	fe843783          	ld	a5,-24(s0)
 cf2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cf4:	fe843783          	ld	a5,-24(s0)
 cf8:	479c                	lw	a5,8(a5)
 cfa:	1782                	slli	a5,a5,0x20
 cfc:	9381                	srli	a5,a5,0x20
 cfe:	0792                	slli	a5,a5,0x4
 d00:	fe843703          	ld	a4,-24(s0)
 d04:	97ba                	add	a5,a5,a4
 d06:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d0a:	fe843783          	ld	a5,-24(s0)
 d0e:	fdc42703          	lw	a4,-36(s0)
 d12:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d14:	00000797          	auipc	a5,0x0
 d18:	31c78793          	addi	a5,a5,796 # 1030 <freep>
 d1c:	fe043703          	ld	a4,-32(s0)
 d20:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d22:	fe843783          	ld	a5,-24(s0)
 d26:	07c1                	addi	a5,a5,16
 d28:	a091                	j	d6c <malloc+0x134>
    }
    if(p == freep)
 d2a:	00000797          	auipc	a5,0x0
 d2e:	30678793          	addi	a5,a5,774 # 1030 <freep>
 d32:	639c                	ld	a5,0(a5)
 d34:	fe843703          	ld	a4,-24(s0)
 d38:	02f71063          	bne	a4,a5,d58 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d3c:	fdc42783          	lw	a5,-36(s0)
 d40:	853e                	mv	a0,a5
 d42:	00000097          	auipc	ra,0x0
 d46:	e76080e7          	jalr	-394(ra) # bb8 <morecore>
 d4a:	fea43423          	sd	a0,-24(s0)
 d4e:	fe843783          	ld	a5,-24(s0)
 d52:	e399                	bnez	a5,d58 <malloc+0x120>
        return 0;
 d54:	4781                	li	a5,0
 d56:	a819                	j	d6c <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d58:	fe843783          	ld	a5,-24(s0)
 d5c:	fef43023          	sd	a5,-32(s0)
 d60:	fe843783          	ld	a5,-24(s0)
 d64:	639c                	ld	a5,0(a5)
 d66:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d6a:	b791                	j	cae <malloc+0x76>
  }
}
 d6c:	853e                	mv	a0,a5
 d6e:	70e2                	ld	ra,56(sp)
 d70:	7442                	ld	s0,48(sp)
 d72:	6121                	addi	sp,sp,64
 d74:	8082                	ret
