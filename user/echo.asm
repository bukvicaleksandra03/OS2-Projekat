
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	87aa                	mv	a5,a0
   c:	fcb43023          	sd	a1,-64(s0)
  10:	fcf42623          	sw	a5,-52(s0)
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	fcf42e23          	sw	a5,-36(s0)
  1a:	a051                	j	9e <main+0x9e>
    write(1, argv[i], strlen(argv[i]));
  1c:	fdc42783          	lw	a5,-36(s0)
  20:	078e                	slli	a5,a5,0x3
  22:	fc043703          	ld	a4,-64(s0)
  26:	97ba                	add	a5,a5,a4
  28:	6384                	ld	s1,0(a5)
  2a:	fdc42783          	lw	a5,-36(s0)
  2e:	078e                	slli	a5,a5,0x3
  30:	fc043703          	ld	a4,-64(s0)
  34:	97ba                	add	a5,a5,a4
  36:	639c                	ld	a5,0(a5)
  38:	853e                	mv	a0,a5
  3a:	00000097          	auipc	ra,0x0
  3e:	148080e7          	jalr	328(ra) # 182 <strlen>
  42:	87aa                	mv	a5,a0
  44:	2781                	sext.w	a5,a5
  46:	2781                	sext.w	a5,a5
  48:	863e                	mv	a2,a5
  4a:	85a6                	mv	a1,s1
  4c:	4505                	li	a0,1
  4e:	00000097          	auipc	ra,0x0
  52:	534080e7          	jalr	1332(ra) # 582 <write>
    if(i + 1 < argc){
  56:	fdc42783          	lw	a5,-36(s0)
  5a:	2785                	addiw	a5,a5,1
  5c:	0007871b          	sext.w	a4,a5
  60:	fcc42783          	lw	a5,-52(s0)
  64:	2781                	sext.w	a5,a5
  66:	00f75d63          	bge	a4,a5,80 <main+0x80>
      write(1, " ", 1);
  6a:	4605                	li	a2,1
  6c:	00001597          	auipc	a1,0x1
  70:	d5458593          	addi	a1,a1,-684 # dc0 <malloc+0x13e>
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	50c080e7          	jalr	1292(ra) # 582 <write>
  7e:	a819                	j	94 <main+0x94>
    } else {
      write(1, "\n", 1);
  80:	4605                	li	a2,1
  82:	00001597          	auipc	a1,0x1
  86:	d4658593          	addi	a1,a1,-698 # dc8 <malloc+0x146>
  8a:	4505                	li	a0,1
  8c:	00000097          	auipc	ra,0x0
  90:	4f6080e7          	jalr	1270(ra) # 582 <write>
  for(i = 1; i < argc; i++){
  94:	fdc42783          	lw	a5,-36(s0)
  98:	2785                	addiw	a5,a5,1
  9a:	fcf42e23          	sw	a5,-36(s0)
  9e:	fdc42703          	lw	a4,-36(s0)
  a2:	fcc42783          	lw	a5,-52(s0)
  a6:	2701                	sext.w	a4,a4
  a8:	2781                	sext.w	a5,a5
  aa:	f6f749e3          	blt	a4,a5,1c <main+0x1c>
    }
  }
  exit(0);
  ae:	4501                	li	a0,0
  b0:	00000097          	auipc	ra,0x0
  b4:	4b2080e7          	jalr	1202(ra) # 562 <exit>

00000000000000b8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  b8:	1141                	addi	sp,sp,-16
  ba:	e406                	sd	ra,8(sp)
  bc:	e022                	sd	s0,0(sp)
  be:	0800                	addi	s0,sp,16
  extern int main();
  main();
  c0:	00000097          	auipc	ra,0x0
  c4:	f40080e7          	jalr	-192(ra) # 0 <main>
  exit(0);
  c8:	4501                	li	a0,0
  ca:	00000097          	auipc	ra,0x0
  ce:	498080e7          	jalr	1176(ra) # 562 <exit>

00000000000000d2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d2:	7179                	addi	sp,sp,-48
  d4:	f422                	sd	s0,40(sp)
  d6:	1800                	addi	s0,sp,48
  d8:	fca43c23          	sd	a0,-40(s0)
  dc:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  e0:	fd843783          	ld	a5,-40(s0)
  e4:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  e8:	0001                	nop
  ea:	fd043703          	ld	a4,-48(s0)
  ee:	00170793          	addi	a5,a4,1
  f2:	fcf43823          	sd	a5,-48(s0)
  f6:	fd843783          	ld	a5,-40(s0)
  fa:	00178693          	addi	a3,a5,1
  fe:	fcd43c23          	sd	a3,-40(s0)
 102:	00074703          	lbu	a4,0(a4)
 106:	00e78023          	sb	a4,0(a5)
 10a:	0007c783          	lbu	a5,0(a5)
 10e:	fff1                	bnez	a5,ea <strcpy+0x18>
    ;
  return os;
 110:	fe843783          	ld	a5,-24(s0)
}
 114:	853e                	mv	a0,a5
 116:	7422                	ld	s0,40(sp)
 118:	6145                	addi	sp,sp,48
 11a:	8082                	ret

000000000000011c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11c:	1101                	addi	sp,sp,-32
 11e:	ec22                	sd	s0,24(sp)
 120:	1000                	addi	s0,sp,32
 122:	fea43423          	sd	a0,-24(s0)
 126:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 12a:	a819                	j	140 <strcmp+0x24>
    p++, q++;
 12c:	fe843783          	ld	a5,-24(s0)
 130:	0785                	addi	a5,a5,1
 132:	fef43423          	sd	a5,-24(s0)
 136:	fe043783          	ld	a5,-32(s0)
 13a:	0785                	addi	a5,a5,1
 13c:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 140:	fe843783          	ld	a5,-24(s0)
 144:	0007c783          	lbu	a5,0(a5)
 148:	cb99                	beqz	a5,15e <strcmp+0x42>
 14a:	fe843783          	ld	a5,-24(s0)
 14e:	0007c703          	lbu	a4,0(a5)
 152:	fe043783          	ld	a5,-32(s0)
 156:	0007c783          	lbu	a5,0(a5)
 15a:	fcf709e3          	beq	a4,a5,12c <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 15e:	fe843783          	ld	a5,-24(s0)
 162:	0007c783          	lbu	a5,0(a5)
 166:	0007871b          	sext.w	a4,a5
 16a:	fe043783          	ld	a5,-32(s0)
 16e:	0007c783          	lbu	a5,0(a5)
 172:	2781                	sext.w	a5,a5
 174:	40f707bb          	subw	a5,a4,a5
 178:	2781                	sext.w	a5,a5
}
 17a:	853e                	mv	a0,a5
 17c:	6462                	ld	s0,24(sp)
 17e:	6105                	addi	sp,sp,32
 180:	8082                	ret

0000000000000182 <strlen>:

uint
strlen(const char *s)
{
 182:	7179                	addi	sp,sp,-48
 184:	f422                	sd	s0,40(sp)
 186:	1800                	addi	s0,sp,48
 188:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 18c:	fe042623          	sw	zero,-20(s0)
 190:	a031                	j	19c <strlen+0x1a>
 192:	fec42783          	lw	a5,-20(s0)
 196:	2785                	addiw	a5,a5,1
 198:	fef42623          	sw	a5,-20(s0)
 19c:	fec42783          	lw	a5,-20(s0)
 1a0:	fd843703          	ld	a4,-40(s0)
 1a4:	97ba                	add	a5,a5,a4
 1a6:	0007c783          	lbu	a5,0(a5)
 1aa:	f7e5                	bnez	a5,192 <strlen+0x10>
    ;
  return n;
 1ac:	fec42783          	lw	a5,-20(s0)
}
 1b0:	853e                	mv	a0,a5
 1b2:	7422                	ld	s0,40(sp)
 1b4:	6145                	addi	sp,sp,48
 1b6:	8082                	ret

00000000000001b8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b8:	7179                	addi	sp,sp,-48
 1ba:	f422                	sd	s0,40(sp)
 1bc:	1800                	addi	s0,sp,48
 1be:	fca43c23          	sd	a0,-40(s0)
 1c2:	87ae                	mv	a5,a1
 1c4:	8732                	mv	a4,a2
 1c6:	fcf42a23          	sw	a5,-44(s0)
 1ca:	87ba                	mv	a5,a4
 1cc:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1d0:	fd843783          	ld	a5,-40(s0)
 1d4:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1d8:	fe042623          	sw	zero,-20(s0)
 1dc:	a00d                	j	1fe <memset+0x46>
    cdst[i] = c;
 1de:	fec42783          	lw	a5,-20(s0)
 1e2:	fe043703          	ld	a4,-32(s0)
 1e6:	97ba                	add	a5,a5,a4
 1e8:	fd442703          	lw	a4,-44(s0)
 1ec:	0ff77713          	andi	a4,a4,255
 1f0:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1f4:	fec42783          	lw	a5,-20(s0)
 1f8:	2785                	addiw	a5,a5,1
 1fa:	fef42623          	sw	a5,-20(s0)
 1fe:	fec42703          	lw	a4,-20(s0)
 202:	fd042783          	lw	a5,-48(s0)
 206:	2781                	sext.w	a5,a5
 208:	fcf76be3          	bltu	a4,a5,1de <memset+0x26>
  }
  return dst;
 20c:	fd843783          	ld	a5,-40(s0)
}
 210:	853e                	mv	a0,a5
 212:	7422                	ld	s0,40(sp)
 214:	6145                	addi	sp,sp,48
 216:	8082                	ret

0000000000000218 <strchr>:

char*
strchr(const char *s, char c)
{
 218:	1101                	addi	sp,sp,-32
 21a:	ec22                	sd	s0,24(sp)
 21c:	1000                	addi	s0,sp,32
 21e:	fea43423          	sd	a0,-24(s0)
 222:	87ae                	mv	a5,a1
 224:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 228:	a01d                	j	24e <strchr+0x36>
    if(*s == c)
 22a:	fe843783          	ld	a5,-24(s0)
 22e:	0007c703          	lbu	a4,0(a5)
 232:	fe744783          	lbu	a5,-25(s0)
 236:	0ff7f793          	andi	a5,a5,255
 23a:	00e79563          	bne	a5,a4,244 <strchr+0x2c>
      return (char*)s;
 23e:	fe843783          	ld	a5,-24(s0)
 242:	a821                	j	25a <strchr+0x42>
  for(; *s; s++)
 244:	fe843783          	ld	a5,-24(s0)
 248:	0785                	addi	a5,a5,1
 24a:	fef43423          	sd	a5,-24(s0)
 24e:	fe843783          	ld	a5,-24(s0)
 252:	0007c783          	lbu	a5,0(a5)
 256:	fbf1                	bnez	a5,22a <strchr+0x12>
  return 0;
 258:	4781                	li	a5,0
}
 25a:	853e                	mv	a0,a5
 25c:	6462                	ld	s0,24(sp)
 25e:	6105                	addi	sp,sp,32
 260:	8082                	ret

0000000000000262 <gets>:

char*
gets(char *buf, int max)
{
 262:	7179                	addi	sp,sp,-48
 264:	f406                	sd	ra,40(sp)
 266:	f022                	sd	s0,32(sp)
 268:	1800                	addi	s0,sp,48
 26a:	fca43c23          	sd	a0,-40(s0)
 26e:	87ae                	mv	a5,a1
 270:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 274:	fe042623          	sw	zero,-20(s0)
 278:	a8a1                	j	2d0 <gets+0x6e>
    cc = read(0, &c, 1);
 27a:	fe740793          	addi	a5,s0,-25
 27e:	4605                	li	a2,1
 280:	85be                	mv	a1,a5
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	2f6080e7          	jalr	758(ra) # 57a <read>
 28c:	87aa                	mv	a5,a0
 28e:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 292:	fe842783          	lw	a5,-24(s0)
 296:	2781                	sext.w	a5,a5
 298:	04f05763          	blez	a5,2e6 <gets+0x84>
      break;
    buf[i++] = c;
 29c:	fec42783          	lw	a5,-20(s0)
 2a0:	0017871b          	addiw	a4,a5,1
 2a4:	fee42623          	sw	a4,-20(s0)
 2a8:	873e                	mv	a4,a5
 2aa:	fd843783          	ld	a5,-40(s0)
 2ae:	97ba                	add	a5,a5,a4
 2b0:	fe744703          	lbu	a4,-25(s0)
 2b4:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2b8:	fe744783          	lbu	a5,-25(s0)
 2bc:	873e                	mv	a4,a5
 2be:	47a9                	li	a5,10
 2c0:	02f70463          	beq	a4,a5,2e8 <gets+0x86>
 2c4:	fe744783          	lbu	a5,-25(s0)
 2c8:	873e                	mv	a4,a5
 2ca:	47b5                	li	a5,13
 2cc:	00f70e63          	beq	a4,a5,2e8 <gets+0x86>
  for(i=0; i+1 < max; ){
 2d0:	fec42783          	lw	a5,-20(s0)
 2d4:	2785                	addiw	a5,a5,1
 2d6:	0007871b          	sext.w	a4,a5
 2da:	fd442783          	lw	a5,-44(s0)
 2de:	2781                	sext.w	a5,a5
 2e0:	f8f74de3          	blt	a4,a5,27a <gets+0x18>
 2e4:	a011                	j	2e8 <gets+0x86>
      break;
 2e6:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2e8:	fec42783          	lw	a5,-20(s0)
 2ec:	fd843703          	ld	a4,-40(s0)
 2f0:	97ba                	add	a5,a5,a4
 2f2:	00078023          	sb	zero,0(a5)
  return buf;
 2f6:	fd843783          	ld	a5,-40(s0)
}
 2fa:	853e                	mv	a0,a5
 2fc:	70a2                	ld	ra,40(sp)
 2fe:	7402                	ld	s0,32(sp)
 300:	6145                	addi	sp,sp,48
 302:	8082                	ret

0000000000000304 <stat>:

int
stat(const char *n, struct stat *st)
{
 304:	7179                	addi	sp,sp,-48
 306:	f406                	sd	ra,40(sp)
 308:	f022                	sd	s0,32(sp)
 30a:	1800                	addi	s0,sp,48
 30c:	fca43c23          	sd	a0,-40(s0)
 310:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 314:	4581                	li	a1,0
 316:	fd843503          	ld	a0,-40(s0)
 31a:	00000097          	auipc	ra,0x0
 31e:	288080e7          	jalr	648(ra) # 5a2 <open>
 322:	87aa                	mv	a5,a0
 324:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 328:	fec42783          	lw	a5,-20(s0)
 32c:	2781                	sext.w	a5,a5
 32e:	0007d463          	bgez	a5,336 <stat+0x32>
    return -1;
 332:	57fd                	li	a5,-1
 334:	a035                	j	360 <stat+0x5c>
  r = fstat(fd, st);
 336:	fec42783          	lw	a5,-20(s0)
 33a:	fd043583          	ld	a1,-48(s0)
 33e:	853e                	mv	a0,a5
 340:	00000097          	auipc	ra,0x0
 344:	27a080e7          	jalr	634(ra) # 5ba <fstat>
 348:	87aa                	mv	a5,a0
 34a:	fef42423          	sw	a5,-24(s0)
  close(fd);
 34e:	fec42783          	lw	a5,-20(s0)
 352:	853e                	mv	a0,a5
 354:	00000097          	auipc	ra,0x0
 358:	236080e7          	jalr	566(ra) # 58a <close>
  return r;
 35c:	fe842783          	lw	a5,-24(s0)
}
 360:	853e                	mv	a0,a5
 362:	70a2                	ld	ra,40(sp)
 364:	7402                	ld	s0,32(sp)
 366:	6145                	addi	sp,sp,48
 368:	8082                	ret

000000000000036a <atoi>:

int
atoi(const char *s)
{
 36a:	7179                	addi	sp,sp,-48
 36c:	f422                	sd	s0,40(sp)
 36e:	1800                	addi	s0,sp,48
 370:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 374:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 378:	a815                	j	3ac <atoi+0x42>
    n = n*10 + *s++ - '0';
 37a:	fec42703          	lw	a4,-20(s0)
 37e:	87ba                	mv	a5,a4
 380:	0027979b          	slliw	a5,a5,0x2
 384:	9fb9                	addw	a5,a5,a4
 386:	0017979b          	slliw	a5,a5,0x1
 38a:	0007871b          	sext.w	a4,a5
 38e:	fd843783          	ld	a5,-40(s0)
 392:	00178693          	addi	a3,a5,1
 396:	fcd43c23          	sd	a3,-40(s0)
 39a:	0007c783          	lbu	a5,0(a5)
 39e:	2781                	sext.w	a5,a5
 3a0:	9fb9                	addw	a5,a5,a4
 3a2:	2781                	sext.w	a5,a5
 3a4:	fd07879b          	addiw	a5,a5,-48
 3a8:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3ac:	fd843783          	ld	a5,-40(s0)
 3b0:	0007c783          	lbu	a5,0(a5)
 3b4:	873e                	mv	a4,a5
 3b6:	02f00793          	li	a5,47
 3ba:	00e7fb63          	bgeu	a5,a4,3d0 <atoi+0x66>
 3be:	fd843783          	ld	a5,-40(s0)
 3c2:	0007c783          	lbu	a5,0(a5)
 3c6:	873e                	mv	a4,a5
 3c8:	03900793          	li	a5,57
 3cc:	fae7f7e3          	bgeu	a5,a4,37a <atoi+0x10>
  return n;
 3d0:	fec42783          	lw	a5,-20(s0)
}
 3d4:	853e                	mv	a0,a5
 3d6:	7422                	ld	s0,40(sp)
 3d8:	6145                	addi	sp,sp,48
 3da:	8082                	ret

00000000000003dc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3dc:	7139                	addi	sp,sp,-64
 3de:	fc22                	sd	s0,56(sp)
 3e0:	0080                	addi	s0,sp,64
 3e2:	fca43c23          	sd	a0,-40(s0)
 3e6:	fcb43823          	sd	a1,-48(s0)
 3ea:	87b2                	mv	a5,a2
 3ec:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3f0:	fd843783          	ld	a5,-40(s0)
 3f4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3f8:	fd043783          	ld	a5,-48(s0)
 3fc:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 400:	fe043703          	ld	a4,-32(s0)
 404:	fe843783          	ld	a5,-24(s0)
 408:	02e7fc63          	bgeu	a5,a4,440 <memmove+0x64>
    while(n-- > 0)
 40c:	a00d                	j	42e <memmove+0x52>
      *dst++ = *src++;
 40e:	fe043703          	ld	a4,-32(s0)
 412:	00170793          	addi	a5,a4,1
 416:	fef43023          	sd	a5,-32(s0)
 41a:	fe843783          	ld	a5,-24(s0)
 41e:	00178693          	addi	a3,a5,1
 422:	fed43423          	sd	a3,-24(s0)
 426:	00074703          	lbu	a4,0(a4)
 42a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 42e:	fcc42783          	lw	a5,-52(s0)
 432:	fff7871b          	addiw	a4,a5,-1
 436:	fce42623          	sw	a4,-52(s0)
 43a:	fcf04ae3          	bgtz	a5,40e <memmove+0x32>
 43e:	a891                	j	492 <memmove+0xb6>
  } else {
    dst += n;
 440:	fcc42783          	lw	a5,-52(s0)
 444:	fe843703          	ld	a4,-24(s0)
 448:	97ba                	add	a5,a5,a4
 44a:	fef43423          	sd	a5,-24(s0)
    src += n;
 44e:	fcc42783          	lw	a5,-52(s0)
 452:	fe043703          	ld	a4,-32(s0)
 456:	97ba                	add	a5,a5,a4
 458:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 45c:	a01d                	j	482 <memmove+0xa6>
      *--dst = *--src;
 45e:	fe043783          	ld	a5,-32(s0)
 462:	17fd                	addi	a5,a5,-1
 464:	fef43023          	sd	a5,-32(s0)
 468:	fe843783          	ld	a5,-24(s0)
 46c:	17fd                	addi	a5,a5,-1
 46e:	fef43423          	sd	a5,-24(s0)
 472:	fe043783          	ld	a5,-32(s0)
 476:	0007c703          	lbu	a4,0(a5)
 47a:	fe843783          	ld	a5,-24(s0)
 47e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 482:	fcc42783          	lw	a5,-52(s0)
 486:	fff7871b          	addiw	a4,a5,-1
 48a:	fce42623          	sw	a4,-52(s0)
 48e:	fcf048e3          	bgtz	a5,45e <memmove+0x82>
  }
  return vdst;
 492:	fd843783          	ld	a5,-40(s0)
}
 496:	853e                	mv	a0,a5
 498:	7462                	ld	s0,56(sp)
 49a:	6121                	addi	sp,sp,64
 49c:	8082                	ret

000000000000049e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 49e:	7139                	addi	sp,sp,-64
 4a0:	fc22                	sd	s0,56(sp)
 4a2:	0080                	addi	s0,sp,64
 4a4:	fca43c23          	sd	a0,-40(s0)
 4a8:	fcb43823          	sd	a1,-48(s0)
 4ac:	87b2                	mv	a5,a2
 4ae:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4b2:	fd843783          	ld	a5,-40(s0)
 4b6:	fef43423          	sd	a5,-24(s0)
 4ba:	fd043783          	ld	a5,-48(s0)
 4be:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c2:	a0a1                	j	50a <memcmp+0x6c>
    if (*p1 != *p2) {
 4c4:	fe843783          	ld	a5,-24(s0)
 4c8:	0007c703          	lbu	a4,0(a5)
 4cc:	fe043783          	ld	a5,-32(s0)
 4d0:	0007c783          	lbu	a5,0(a5)
 4d4:	02f70163          	beq	a4,a5,4f6 <memcmp+0x58>
      return *p1 - *p2;
 4d8:	fe843783          	ld	a5,-24(s0)
 4dc:	0007c783          	lbu	a5,0(a5)
 4e0:	0007871b          	sext.w	a4,a5
 4e4:	fe043783          	ld	a5,-32(s0)
 4e8:	0007c783          	lbu	a5,0(a5)
 4ec:	2781                	sext.w	a5,a5
 4ee:	40f707bb          	subw	a5,a4,a5
 4f2:	2781                	sext.w	a5,a5
 4f4:	a01d                	j	51a <memcmp+0x7c>
    }
    p1++;
 4f6:	fe843783          	ld	a5,-24(s0)
 4fa:	0785                	addi	a5,a5,1
 4fc:	fef43423          	sd	a5,-24(s0)
    p2++;
 500:	fe043783          	ld	a5,-32(s0)
 504:	0785                	addi	a5,a5,1
 506:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 50a:	fcc42783          	lw	a5,-52(s0)
 50e:	fff7871b          	addiw	a4,a5,-1
 512:	fce42623          	sw	a4,-52(s0)
 516:	f7dd                	bnez	a5,4c4 <memcmp+0x26>
  }
  return 0;
 518:	4781                	li	a5,0
}
 51a:	853e                	mv	a0,a5
 51c:	7462                	ld	s0,56(sp)
 51e:	6121                	addi	sp,sp,64
 520:	8082                	ret

0000000000000522 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 522:	7179                	addi	sp,sp,-48
 524:	f406                	sd	ra,40(sp)
 526:	f022                	sd	s0,32(sp)
 528:	1800                	addi	s0,sp,48
 52a:	fea43423          	sd	a0,-24(s0)
 52e:	feb43023          	sd	a1,-32(s0)
 532:	87b2                	mv	a5,a2
 534:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 538:	fdc42783          	lw	a5,-36(s0)
 53c:	863e                	mv	a2,a5
 53e:	fe043583          	ld	a1,-32(s0)
 542:	fe843503          	ld	a0,-24(s0)
 546:	00000097          	auipc	ra,0x0
 54a:	e96080e7          	jalr	-362(ra) # 3dc <memmove>
 54e:	87aa                	mv	a5,a0
}
 550:	853e                	mv	a0,a5
 552:	70a2                	ld	ra,40(sp)
 554:	7402                	ld	s0,32(sp)
 556:	6145                	addi	sp,sp,48
 558:	8082                	ret

000000000000055a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 55a:	4885                	li	a7,1
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <exit>:
.global exit
exit:
 li a7, SYS_exit
 562:	4889                	li	a7,2
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <wait>:
.global wait
wait:
 li a7, SYS_wait
 56a:	488d                	li	a7,3
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 572:	4891                	li	a7,4
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <read>:
.global read
read:
 li a7, SYS_read
 57a:	4895                	li	a7,5
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <write>:
.global write
write:
 li a7, SYS_write
 582:	48c1                	li	a7,16
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <close>:
.global close
close:
 li a7, SYS_close
 58a:	48d5                	li	a7,21
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <kill>:
.global kill
kill:
 li a7, SYS_kill
 592:	4899                	li	a7,6
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <exec>:
.global exec
exec:
 li a7, SYS_exec
 59a:	489d                	li	a7,7
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <open>:
.global open
open:
 li a7, SYS_open
 5a2:	48bd                	li	a7,15
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5aa:	48c5                	li	a7,17
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b2:	48c9                	li	a7,18
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5ba:	48a1                	li	a7,8
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <link>:
.global link
link:
 li a7, SYS_link
 5c2:	48cd                	li	a7,19
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ca:	48d1                	li	a7,20
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d2:	48a5                	li	a7,9
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <dup>:
.global dup
dup:
 li a7, SYS_dup
 5da:	48a9                	li	a7,10
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e2:	48ad                	li	a7,11
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ea:	48b1                	li	a7,12
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f2:	48b5                	li	a7,13
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5fa:	48b9                	li	a7,14
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 602:	1101                	addi	sp,sp,-32
 604:	ec06                	sd	ra,24(sp)
 606:	e822                	sd	s0,16(sp)
 608:	1000                	addi	s0,sp,32
 60a:	87aa                	mv	a5,a0
 60c:	872e                	mv	a4,a1
 60e:	fef42623          	sw	a5,-20(s0)
 612:	87ba                	mv	a5,a4
 614:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 618:	feb40713          	addi	a4,s0,-21
 61c:	fec42783          	lw	a5,-20(s0)
 620:	4605                	li	a2,1
 622:	85ba                	mv	a1,a4
 624:	853e                	mv	a0,a5
 626:	00000097          	auipc	ra,0x0
 62a:	f5c080e7          	jalr	-164(ra) # 582 <write>
}
 62e:	0001                	nop
 630:	60e2                	ld	ra,24(sp)
 632:	6442                	ld	s0,16(sp)
 634:	6105                	addi	sp,sp,32
 636:	8082                	ret

0000000000000638 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 638:	7139                	addi	sp,sp,-64
 63a:	fc06                	sd	ra,56(sp)
 63c:	f822                	sd	s0,48(sp)
 63e:	0080                	addi	s0,sp,64
 640:	87aa                	mv	a5,a0
 642:	8736                	mv	a4,a3
 644:	fcf42623          	sw	a5,-52(s0)
 648:	87ae                	mv	a5,a1
 64a:	fcf42423          	sw	a5,-56(s0)
 64e:	87b2                	mv	a5,a2
 650:	fcf42223          	sw	a5,-60(s0)
 654:	87ba                	mv	a5,a4
 656:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 65a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 65e:	fc042783          	lw	a5,-64(s0)
 662:	2781                	sext.w	a5,a5
 664:	c38d                	beqz	a5,686 <printint+0x4e>
 666:	fc842783          	lw	a5,-56(s0)
 66a:	2781                	sext.w	a5,a5
 66c:	0007dd63          	bgez	a5,686 <printint+0x4e>
    neg = 1;
 670:	4785                	li	a5,1
 672:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 676:	fc842783          	lw	a5,-56(s0)
 67a:	40f007bb          	negw	a5,a5
 67e:	2781                	sext.w	a5,a5
 680:	fef42223          	sw	a5,-28(s0)
 684:	a029                	j	68e <printint+0x56>
  } else {
    x = xx;
 686:	fc842783          	lw	a5,-56(s0)
 68a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 68e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 692:	fc442783          	lw	a5,-60(s0)
 696:	fe442703          	lw	a4,-28(s0)
 69a:	02f777bb          	remuw	a5,a4,a5
 69e:	0007861b          	sext.w	a2,a5
 6a2:	fec42783          	lw	a5,-20(s0)
 6a6:	0017871b          	addiw	a4,a5,1
 6aa:	fee42623          	sw	a4,-20(s0)
 6ae:	00001697          	auipc	a3,0x1
 6b2:	95268693          	addi	a3,a3,-1710 # 1000 <digits>
 6b6:	02061713          	slli	a4,a2,0x20
 6ba:	9301                	srli	a4,a4,0x20
 6bc:	9736                	add	a4,a4,a3
 6be:	00074703          	lbu	a4,0(a4)
 6c2:	ff040693          	addi	a3,s0,-16
 6c6:	97b6                	add	a5,a5,a3
 6c8:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6cc:	fc442783          	lw	a5,-60(s0)
 6d0:	fe442703          	lw	a4,-28(s0)
 6d4:	02f757bb          	divuw	a5,a4,a5
 6d8:	fef42223          	sw	a5,-28(s0)
 6dc:	fe442783          	lw	a5,-28(s0)
 6e0:	2781                	sext.w	a5,a5
 6e2:	fbc5                	bnez	a5,692 <printint+0x5a>
  if(neg)
 6e4:	fe842783          	lw	a5,-24(s0)
 6e8:	2781                	sext.w	a5,a5
 6ea:	cf95                	beqz	a5,726 <printint+0xee>
    buf[i++] = '-';
 6ec:	fec42783          	lw	a5,-20(s0)
 6f0:	0017871b          	addiw	a4,a5,1
 6f4:	fee42623          	sw	a4,-20(s0)
 6f8:	ff040713          	addi	a4,s0,-16
 6fc:	97ba                	add	a5,a5,a4
 6fe:	02d00713          	li	a4,45
 702:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 706:	a005                	j	726 <printint+0xee>
    putc(fd, buf[i]);
 708:	fec42783          	lw	a5,-20(s0)
 70c:	ff040713          	addi	a4,s0,-16
 710:	97ba                	add	a5,a5,a4
 712:	fe07c703          	lbu	a4,-32(a5)
 716:	fcc42783          	lw	a5,-52(s0)
 71a:	85ba                	mv	a1,a4
 71c:	853e                	mv	a0,a5
 71e:	00000097          	auipc	ra,0x0
 722:	ee4080e7          	jalr	-284(ra) # 602 <putc>
  while(--i >= 0)
 726:	fec42783          	lw	a5,-20(s0)
 72a:	37fd                	addiw	a5,a5,-1
 72c:	fef42623          	sw	a5,-20(s0)
 730:	fec42783          	lw	a5,-20(s0)
 734:	2781                	sext.w	a5,a5
 736:	fc07d9e3          	bgez	a5,708 <printint+0xd0>
}
 73a:	0001                	nop
 73c:	0001                	nop
 73e:	70e2                	ld	ra,56(sp)
 740:	7442                	ld	s0,48(sp)
 742:	6121                	addi	sp,sp,64
 744:	8082                	ret

0000000000000746 <printptr>:

static void
printptr(int fd, uint64 x) {
 746:	7179                	addi	sp,sp,-48
 748:	f406                	sd	ra,40(sp)
 74a:	f022                	sd	s0,32(sp)
 74c:	1800                	addi	s0,sp,48
 74e:	87aa                	mv	a5,a0
 750:	fcb43823          	sd	a1,-48(s0)
 754:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 758:	fdc42783          	lw	a5,-36(s0)
 75c:	03000593          	li	a1,48
 760:	853e                	mv	a0,a5
 762:	00000097          	auipc	ra,0x0
 766:	ea0080e7          	jalr	-352(ra) # 602 <putc>
  putc(fd, 'x');
 76a:	fdc42783          	lw	a5,-36(s0)
 76e:	07800593          	li	a1,120
 772:	853e                	mv	a0,a5
 774:	00000097          	auipc	ra,0x0
 778:	e8e080e7          	jalr	-370(ra) # 602 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 77c:	fe042623          	sw	zero,-20(s0)
 780:	a82d                	j	7ba <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 782:	fd043783          	ld	a5,-48(s0)
 786:	93f1                	srli	a5,a5,0x3c
 788:	00001717          	auipc	a4,0x1
 78c:	87870713          	addi	a4,a4,-1928 # 1000 <digits>
 790:	97ba                	add	a5,a5,a4
 792:	0007c703          	lbu	a4,0(a5)
 796:	fdc42783          	lw	a5,-36(s0)
 79a:	85ba                	mv	a1,a4
 79c:	853e                	mv	a0,a5
 79e:	00000097          	auipc	ra,0x0
 7a2:	e64080e7          	jalr	-412(ra) # 602 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a6:	fec42783          	lw	a5,-20(s0)
 7aa:	2785                	addiw	a5,a5,1
 7ac:	fef42623          	sw	a5,-20(s0)
 7b0:	fd043783          	ld	a5,-48(s0)
 7b4:	0792                	slli	a5,a5,0x4
 7b6:	fcf43823          	sd	a5,-48(s0)
 7ba:	fec42783          	lw	a5,-20(s0)
 7be:	873e                	mv	a4,a5
 7c0:	47bd                	li	a5,15
 7c2:	fce7f0e3          	bgeu	a5,a4,782 <printptr+0x3c>
}
 7c6:	0001                	nop
 7c8:	0001                	nop
 7ca:	70a2                	ld	ra,40(sp)
 7cc:	7402                	ld	s0,32(sp)
 7ce:	6145                	addi	sp,sp,48
 7d0:	8082                	ret

00000000000007d2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7d2:	715d                	addi	sp,sp,-80
 7d4:	e486                	sd	ra,72(sp)
 7d6:	e0a2                	sd	s0,64(sp)
 7d8:	0880                	addi	s0,sp,80
 7da:	87aa                	mv	a5,a0
 7dc:	fcb43023          	sd	a1,-64(s0)
 7e0:	fac43c23          	sd	a2,-72(s0)
 7e4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7e8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7ec:	fe042223          	sw	zero,-28(s0)
 7f0:	a42d                	j	a1a <vprintf+0x248>
    c = fmt[i] & 0xff;
 7f2:	fe442783          	lw	a5,-28(s0)
 7f6:	fc043703          	ld	a4,-64(s0)
 7fa:	97ba                	add	a5,a5,a4
 7fc:	0007c783          	lbu	a5,0(a5)
 800:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 804:	fe042783          	lw	a5,-32(s0)
 808:	2781                	sext.w	a5,a5
 80a:	eb9d                	bnez	a5,840 <vprintf+0x6e>
      if(c == '%'){
 80c:	fdc42783          	lw	a5,-36(s0)
 810:	0007871b          	sext.w	a4,a5
 814:	02500793          	li	a5,37
 818:	00f71763          	bne	a4,a5,826 <vprintf+0x54>
        state = '%';
 81c:	02500793          	li	a5,37
 820:	fef42023          	sw	a5,-32(s0)
 824:	a2f5                	j	a10 <vprintf+0x23e>
      } else {
        putc(fd, c);
 826:	fdc42783          	lw	a5,-36(s0)
 82a:	0ff7f713          	andi	a4,a5,255
 82e:	fcc42783          	lw	a5,-52(s0)
 832:	85ba                	mv	a1,a4
 834:	853e                	mv	a0,a5
 836:	00000097          	auipc	ra,0x0
 83a:	dcc080e7          	jalr	-564(ra) # 602 <putc>
 83e:	aac9                	j	a10 <vprintf+0x23e>
      }
    } else if(state == '%'){
 840:	fe042783          	lw	a5,-32(s0)
 844:	0007871b          	sext.w	a4,a5
 848:	02500793          	li	a5,37
 84c:	1cf71263          	bne	a4,a5,a10 <vprintf+0x23e>
      if(c == 'd'){
 850:	fdc42783          	lw	a5,-36(s0)
 854:	0007871b          	sext.w	a4,a5
 858:	06400793          	li	a5,100
 85c:	02f71463          	bne	a4,a5,884 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 860:	fb843783          	ld	a5,-72(s0)
 864:	00878713          	addi	a4,a5,8
 868:	fae43c23          	sd	a4,-72(s0)
 86c:	4398                	lw	a4,0(a5)
 86e:	fcc42783          	lw	a5,-52(s0)
 872:	4685                	li	a3,1
 874:	4629                	li	a2,10
 876:	85ba                	mv	a1,a4
 878:	853e                	mv	a0,a5
 87a:	00000097          	auipc	ra,0x0
 87e:	dbe080e7          	jalr	-578(ra) # 638 <printint>
 882:	a269                	j	a0c <vprintf+0x23a>
      } else if(c == 'l') {
 884:	fdc42783          	lw	a5,-36(s0)
 888:	0007871b          	sext.w	a4,a5
 88c:	06c00793          	li	a5,108
 890:	02f71663          	bne	a4,a5,8bc <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 894:	fb843783          	ld	a5,-72(s0)
 898:	00878713          	addi	a4,a5,8
 89c:	fae43c23          	sd	a4,-72(s0)
 8a0:	639c                	ld	a5,0(a5)
 8a2:	0007871b          	sext.w	a4,a5
 8a6:	fcc42783          	lw	a5,-52(s0)
 8aa:	4681                	li	a3,0
 8ac:	4629                	li	a2,10
 8ae:	85ba                	mv	a1,a4
 8b0:	853e                	mv	a0,a5
 8b2:	00000097          	auipc	ra,0x0
 8b6:	d86080e7          	jalr	-634(ra) # 638 <printint>
 8ba:	aa89                	j	a0c <vprintf+0x23a>
      } else if(c == 'x') {
 8bc:	fdc42783          	lw	a5,-36(s0)
 8c0:	0007871b          	sext.w	a4,a5
 8c4:	07800793          	li	a5,120
 8c8:	02f71463          	bne	a4,a5,8f0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8cc:	fb843783          	ld	a5,-72(s0)
 8d0:	00878713          	addi	a4,a5,8
 8d4:	fae43c23          	sd	a4,-72(s0)
 8d8:	4398                	lw	a4,0(a5)
 8da:	fcc42783          	lw	a5,-52(s0)
 8de:	4681                	li	a3,0
 8e0:	4641                	li	a2,16
 8e2:	85ba                	mv	a1,a4
 8e4:	853e                	mv	a0,a5
 8e6:	00000097          	auipc	ra,0x0
 8ea:	d52080e7          	jalr	-686(ra) # 638 <printint>
 8ee:	aa39                	j	a0c <vprintf+0x23a>
      } else if(c == 'p') {
 8f0:	fdc42783          	lw	a5,-36(s0)
 8f4:	0007871b          	sext.w	a4,a5
 8f8:	07000793          	li	a5,112
 8fc:	02f71263          	bne	a4,a5,920 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 900:	fb843783          	ld	a5,-72(s0)
 904:	00878713          	addi	a4,a5,8
 908:	fae43c23          	sd	a4,-72(s0)
 90c:	6398                	ld	a4,0(a5)
 90e:	fcc42783          	lw	a5,-52(s0)
 912:	85ba                	mv	a1,a4
 914:	853e                	mv	a0,a5
 916:	00000097          	auipc	ra,0x0
 91a:	e30080e7          	jalr	-464(ra) # 746 <printptr>
 91e:	a0fd                	j	a0c <vprintf+0x23a>
      } else if(c == 's'){
 920:	fdc42783          	lw	a5,-36(s0)
 924:	0007871b          	sext.w	a4,a5
 928:	07300793          	li	a5,115
 92c:	04f71c63          	bne	a4,a5,984 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 930:	fb843783          	ld	a5,-72(s0)
 934:	00878713          	addi	a4,a5,8
 938:	fae43c23          	sd	a4,-72(s0)
 93c:	639c                	ld	a5,0(a5)
 93e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 942:	fe843783          	ld	a5,-24(s0)
 946:	eb8d                	bnez	a5,978 <vprintf+0x1a6>
          s = "(null)";
 948:	00000797          	auipc	a5,0x0
 94c:	48878793          	addi	a5,a5,1160 # dd0 <malloc+0x14e>
 950:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 954:	a015                	j	978 <vprintf+0x1a6>
          putc(fd, *s);
 956:	fe843783          	ld	a5,-24(s0)
 95a:	0007c703          	lbu	a4,0(a5)
 95e:	fcc42783          	lw	a5,-52(s0)
 962:	85ba                	mv	a1,a4
 964:	853e                	mv	a0,a5
 966:	00000097          	auipc	ra,0x0
 96a:	c9c080e7          	jalr	-868(ra) # 602 <putc>
          s++;
 96e:	fe843783          	ld	a5,-24(s0)
 972:	0785                	addi	a5,a5,1
 974:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 978:	fe843783          	ld	a5,-24(s0)
 97c:	0007c783          	lbu	a5,0(a5)
 980:	fbf9                	bnez	a5,956 <vprintf+0x184>
 982:	a069                	j	a0c <vprintf+0x23a>
        }
      } else if(c == 'c'){
 984:	fdc42783          	lw	a5,-36(s0)
 988:	0007871b          	sext.w	a4,a5
 98c:	06300793          	li	a5,99
 990:	02f71463          	bne	a4,a5,9b8 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 994:	fb843783          	ld	a5,-72(s0)
 998:	00878713          	addi	a4,a5,8
 99c:	fae43c23          	sd	a4,-72(s0)
 9a0:	439c                	lw	a5,0(a5)
 9a2:	0ff7f713          	andi	a4,a5,255
 9a6:	fcc42783          	lw	a5,-52(s0)
 9aa:	85ba                	mv	a1,a4
 9ac:	853e                	mv	a0,a5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	c54080e7          	jalr	-940(ra) # 602 <putc>
 9b6:	a899                	j	a0c <vprintf+0x23a>
      } else if(c == '%'){
 9b8:	fdc42783          	lw	a5,-36(s0)
 9bc:	0007871b          	sext.w	a4,a5
 9c0:	02500793          	li	a5,37
 9c4:	00f71f63          	bne	a4,a5,9e2 <vprintf+0x210>
        putc(fd, c);
 9c8:	fdc42783          	lw	a5,-36(s0)
 9cc:	0ff7f713          	andi	a4,a5,255
 9d0:	fcc42783          	lw	a5,-52(s0)
 9d4:	85ba                	mv	a1,a4
 9d6:	853e                	mv	a0,a5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	c2a080e7          	jalr	-982(ra) # 602 <putc>
 9e0:	a035                	j	a0c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9e2:	fcc42783          	lw	a5,-52(s0)
 9e6:	02500593          	li	a1,37
 9ea:	853e                	mv	a0,a5
 9ec:	00000097          	auipc	ra,0x0
 9f0:	c16080e7          	jalr	-1002(ra) # 602 <putc>
        putc(fd, c);
 9f4:	fdc42783          	lw	a5,-36(s0)
 9f8:	0ff7f713          	andi	a4,a5,255
 9fc:	fcc42783          	lw	a5,-52(s0)
 a00:	85ba                	mv	a1,a4
 a02:	853e                	mv	a0,a5
 a04:	00000097          	auipc	ra,0x0
 a08:	bfe080e7          	jalr	-1026(ra) # 602 <putc>
      }
      state = 0;
 a0c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a10:	fe442783          	lw	a5,-28(s0)
 a14:	2785                	addiw	a5,a5,1
 a16:	fef42223          	sw	a5,-28(s0)
 a1a:	fe442783          	lw	a5,-28(s0)
 a1e:	fc043703          	ld	a4,-64(s0)
 a22:	97ba                	add	a5,a5,a4
 a24:	0007c783          	lbu	a5,0(a5)
 a28:	dc0795e3          	bnez	a5,7f2 <vprintf+0x20>
    }
  }
}
 a2c:	0001                	nop
 a2e:	0001                	nop
 a30:	60a6                	ld	ra,72(sp)
 a32:	6406                	ld	s0,64(sp)
 a34:	6161                	addi	sp,sp,80
 a36:	8082                	ret

0000000000000a38 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a38:	7159                	addi	sp,sp,-112
 a3a:	fc06                	sd	ra,56(sp)
 a3c:	f822                	sd	s0,48(sp)
 a3e:	0080                	addi	s0,sp,64
 a40:	fcb43823          	sd	a1,-48(s0)
 a44:	e010                	sd	a2,0(s0)
 a46:	e414                	sd	a3,8(s0)
 a48:	e818                	sd	a4,16(s0)
 a4a:	ec1c                	sd	a5,24(s0)
 a4c:	03043023          	sd	a6,32(s0)
 a50:	03143423          	sd	a7,40(s0)
 a54:	87aa                	mv	a5,a0
 a56:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a5a:	03040793          	addi	a5,s0,48
 a5e:	fcf43423          	sd	a5,-56(s0)
 a62:	fc843783          	ld	a5,-56(s0)
 a66:	fd078793          	addi	a5,a5,-48
 a6a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a6e:	fe843703          	ld	a4,-24(s0)
 a72:	fdc42783          	lw	a5,-36(s0)
 a76:	863a                	mv	a2,a4
 a78:	fd043583          	ld	a1,-48(s0)
 a7c:	853e                	mv	a0,a5
 a7e:	00000097          	auipc	ra,0x0
 a82:	d54080e7          	jalr	-684(ra) # 7d2 <vprintf>
}
 a86:	0001                	nop
 a88:	70e2                	ld	ra,56(sp)
 a8a:	7442                	ld	s0,48(sp)
 a8c:	6165                	addi	sp,sp,112
 a8e:	8082                	ret

0000000000000a90 <printf>:

void
printf(const char *fmt, ...)
{
 a90:	7159                	addi	sp,sp,-112
 a92:	f406                	sd	ra,40(sp)
 a94:	f022                	sd	s0,32(sp)
 a96:	1800                	addi	s0,sp,48
 a98:	fca43c23          	sd	a0,-40(s0)
 a9c:	e40c                	sd	a1,8(s0)
 a9e:	e810                	sd	a2,16(s0)
 aa0:	ec14                	sd	a3,24(s0)
 aa2:	f018                	sd	a4,32(s0)
 aa4:	f41c                	sd	a5,40(s0)
 aa6:	03043823          	sd	a6,48(s0)
 aaa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 aae:	04040793          	addi	a5,s0,64
 ab2:	fcf43823          	sd	a5,-48(s0)
 ab6:	fd043783          	ld	a5,-48(s0)
 aba:	fc878793          	addi	a5,a5,-56
 abe:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ac2:	fe843783          	ld	a5,-24(s0)
 ac6:	863e                	mv	a2,a5
 ac8:	fd843583          	ld	a1,-40(s0)
 acc:	4505                	li	a0,1
 ace:	00000097          	auipc	ra,0x0
 ad2:	d04080e7          	jalr	-764(ra) # 7d2 <vprintf>
}
 ad6:	0001                	nop
 ad8:	70a2                	ld	ra,40(sp)
 ada:	7402                	ld	s0,32(sp)
 adc:	6165                	addi	sp,sp,112
 ade:	8082                	ret

0000000000000ae0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae0:	7179                	addi	sp,sp,-48
 ae2:	f422                	sd	s0,40(sp)
 ae4:	1800                	addi	s0,sp,48
 ae6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 aea:	fd843783          	ld	a5,-40(s0)
 aee:	17c1                	addi	a5,a5,-16
 af0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af4:	00000797          	auipc	a5,0x0
 af8:	53c78793          	addi	a5,a5,1340 # 1030 <freep>
 afc:	639c                	ld	a5,0(a5)
 afe:	fef43423          	sd	a5,-24(s0)
 b02:	a815                	j	b36 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b04:	fe843783          	ld	a5,-24(s0)
 b08:	639c                	ld	a5,0(a5)
 b0a:	fe843703          	ld	a4,-24(s0)
 b0e:	00f76f63          	bltu	a4,a5,b2c <free+0x4c>
 b12:	fe043703          	ld	a4,-32(s0)
 b16:	fe843783          	ld	a5,-24(s0)
 b1a:	02e7eb63          	bltu	a5,a4,b50 <free+0x70>
 b1e:	fe843783          	ld	a5,-24(s0)
 b22:	639c                	ld	a5,0(a5)
 b24:	fe043703          	ld	a4,-32(s0)
 b28:	02f76463          	bltu	a4,a5,b50 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2c:	fe843783          	ld	a5,-24(s0)
 b30:	639c                	ld	a5,0(a5)
 b32:	fef43423          	sd	a5,-24(s0)
 b36:	fe043703          	ld	a4,-32(s0)
 b3a:	fe843783          	ld	a5,-24(s0)
 b3e:	fce7f3e3          	bgeu	a5,a4,b04 <free+0x24>
 b42:	fe843783          	ld	a5,-24(s0)
 b46:	639c                	ld	a5,0(a5)
 b48:	fe043703          	ld	a4,-32(s0)
 b4c:	faf77ce3          	bgeu	a4,a5,b04 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b50:	fe043783          	ld	a5,-32(s0)
 b54:	479c                	lw	a5,8(a5)
 b56:	1782                	slli	a5,a5,0x20
 b58:	9381                	srli	a5,a5,0x20
 b5a:	0792                	slli	a5,a5,0x4
 b5c:	fe043703          	ld	a4,-32(s0)
 b60:	973e                	add	a4,a4,a5
 b62:	fe843783          	ld	a5,-24(s0)
 b66:	639c                	ld	a5,0(a5)
 b68:	02f71763          	bne	a4,a5,b96 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b6c:	fe043783          	ld	a5,-32(s0)
 b70:	4798                	lw	a4,8(a5)
 b72:	fe843783          	ld	a5,-24(s0)
 b76:	639c                	ld	a5,0(a5)
 b78:	479c                	lw	a5,8(a5)
 b7a:	9fb9                	addw	a5,a5,a4
 b7c:	0007871b          	sext.w	a4,a5
 b80:	fe043783          	ld	a5,-32(s0)
 b84:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b86:	fe843783          	ld	a5,-24(s0)
 b8a:	639c                	ld	a5,0(a5)
 b8c:	6398                	ld	a4,0(a5)
 b8e:	fe043783          	ld	a5,-32(s0)
 b92:	e398                	sd	a4,0(a5)
 b94:	a039                	j	ba2 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b96:	fe843783          	ld	a5,-24(s0)
 b9a:	6398                	ld	a4,0(a5)
 b9c:	fe043783          	ld	a5,-32(s0)
 ba0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 ba2:	fe843783          	ld	a5,-24(s0)
 ba6:	479c                	lw	a5,8(a5)
 ba8:	1782                	slli	a5,a5,0x20
 baa:	9381                	srli	a5,a5,0x20
 bac:	0792                	slli	a5,a5,0x4
 bae:	fe843703          	ld	a4,-24(s0)
 bb2:	97ba                	add	a5,a5,a4
 bb4:	fe043703          	ld	a4,-32(s0)
 bb8:	02f71563          	bne	a4,a5,be2 <free+0x102>
    p->s.size += bp->s.size;
 bbc:	fe843783          	ld	a5,-24(s0)
 bc0:	4798                	lw	a4,8(a5)
 bc2:	fe043783          	ld	a5,-32(s0)
 bc6:	479c                	lw	a5,8(a5)
 bc8:	9fb9                	addw	a5,a5,a4
 bca:	0007871b          	sext.w	a4,a5
 bce:	fe843783          	ld	a5,-24(s0)
 bd2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bd4:	fe043783          	ld	a5,-32(s0)
 bd8:	6398                	ld	a4,0(a5)
 bda:	fe843783          	ld	a5,-24(s0)
 bde:	e398                	sd	a4,0(a5)
 be0:	a031                	j	bec <free+0x10c>
  } else
    p->s.ptr = bp;
 be2:	fe843783          	ld	a5,-24(s0)
 be6:	fe043703          	ld	a4,-32(s0)
 bea:	e398                	sd	a4,0(a5)
  freep = p;
 bec:	00000797          	auipc	a5,0x0
 bf0:	44478793          	addi	a5,a5,1092 # 1030 <freep>
 bf4:	fe843703          	ld	a4,-24(s0)
 bf8:	e398                	sd	a4,0(a5)
}
 bfa:	0001                	nop
 bfc:	7422                	ld	s0,40(sp)
 bfe:	6145                	addi	sp,sp,48
 c00:	8082                	ret

0000000000000c02 <morecore>:

static Header*
morecore(uint nu)
{
 c02:	7179                	addi	sp,sp,-48
 c04:	f406                	sd	ra,40(sp)
 c06:	f022                	sd	s0,32(sp)
 c08:	1800                	addi	s0,sp,48
 c0a:	87aa                	mv	a5,a0
 c0c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c10:	fdc42783          	lw	a5,-36(s0)
 c14:	0007871b          	sext.w	a4,a5
 c18:	6785                	lui	a5,0x1
 c1a:	00f77563          	bgeu	a4,a5,c24 <morecore+0x22>
    nu = 4096;
 c1e:	6785                	lui	a5,0x1
 c20:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c24:	fdc42783          	lw	a5,-36(s0)
 c28:	0047979b          	slliw	a5,a5,0x4
 c2c:	2781                	sext.w	a5,a5
 c2e:	2781                	sext.w	a5,a5
 c30:	853e                	mv	a0,a5
 c32:	00000097          	auipc	ra,0x0
 c36:	9b8080e7          	jalr	-1608(ra) # 5ea <sbrk>
 c3a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c3e:	fe843703          	ld	a4,-24(s0)
 c42:	57fd                	li	a5,-1
 c44:	00f71463          	bne	a4,a5,c4c <morecore+0x4a>
    return 0;
 c48:	4781                	li	a5,0
 c4a:	a03d                	j	c78 <morecore+0x76>
  hp = (Header*)p;
 c4c:	fe843783          	ld	a5,-24(s0)
 c50:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c54:	fe043783          	ld	a5,-32(s0)
 c58:	fdc42703          	lw	a4,-36(s0)
 c5c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c5e:	fe043783          	ld	a5,-32(s0)
 c62:	07c1                	addi	a5,a5,16
 c64:	853e                	mv	a0,a5
 c66:	00000097          	auipc	ra,0x0
 c6a:	e7a080e7          	jalr	-390(ra) # ae0 <free>
  return freep;
 c6e:	00000797          	auipc	a5,0x0
 c72:	3c278793          	addi	a5,a5,962 # 1030 <freep>
 c76:	639c                	ld	a5,0(a5)
}
 c78:	853e                	mv	a0,a5
 c7a:	70a2                	ld	ra,40(sp)
 c7c:	7402                	ld	s0,32(sp)
 c7e:	6145                	addi	sp,sp,48
 c80:	8082                	ret

0000000000000c82 <malloc>:

void*
malloc(uint nbytes)
{
 c82:	7139                	addi	sp,sp,-64
 c84:	fc06                	sd	ra,56(sp)
 c86:	f822                	sd	s0,48(sp)
 c88:	0080                	addi	s0,sp,64
 c8a:	87aa                	mv	a5,a0
 c8c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c90:	fcc46783          	lwu	a5,-52(s0)
 c94:	07bd                	addi	a5,a5,15
 c96:	8391                	srli	a5,a5,0x4
 c98:	2781                	sext.w	a5,a5
 c9a:	2785                	addiw	a5,a5,1
 c9c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 ca0:	00000797          	auipc	a5,0x0
 ca4:	39078793          	addi	a5,a5,912 # 1030 <freep>
 ca8:	639c                	ld	a5,0(a5)
 caa:	fef43023          	sd	a5,-32(s0)
 cae:	fe043783          	ld	a5,-32(s0)
 cb2:	ef95                	bnez	a5,cee <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 cb4:	00000797          	auipc	a5,0x0
 cb8:	36c78793          	addi	a5,a5,876 # 1020 <base>
 cbc:	fef43023          	sd	a5,-32(s0)
 cc0:	00000797          	auipc	a5,0x0
 cc4:	37078793          	addi	a5,a5,880 # 1030 <freep>
 cc8:	fe043703          	ld	a4,-32(s0)
 ccc:	e398                	sd	a4,0(a5)
 cce:	00000797          	auipc	a5,0x0
 cd2:	36278793          	addi	a5,a5,866 # 1030 <freep>
 cd6:	6398                	ld	a4,0(a5)
 cd8:	00000797          	auipc	a5,0x0
 cdc:	34878793          	addi	a5,a5,840 # 1020 <base>
 ce0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 ce2:	00000797          	auipc	a5,0x0
 ce6:	33e78793          	addi	a5,a5,830 # 1020 <base>
 cea:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cee:	fe043783          	ld	a5,-32(s0)
 cf2:	639c                	ld	a5,0(a5)
 cf4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cf8:	fe843783          	ld	a5,-24(s0)
 cfc:	4798                	lw	a4,8(a5)
 cfe:	fdc42783          	lw	a5,-36(s0)
 d02:	2781                	sext.w	a5,a5
 d04:	06f76863          	bltu	a4,a5,d74 <malloc+0xf2>
      if(p->s.size == nunits)
 d08:	fe843783          	ld	a5,-24(s0)
 d0c:	4798                	lw	a4,8(a5)
 d0e:	fdc42783          	lw	a5,-36(s0)
 d12:	2781                	sext.w	a5,a5
 d14:	00e79963          	bne	a5,a4,d26 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d18:	fe843783          	ld	a5,-24(s0)
 d1c:	6398                	ld	a4,0(a5)
 d1e:	fe043783          	ld	a5,-32(s0)
 d22:	e398                	sd	a4,0(a5)
 d24:	a82d                	j	d5e <malloc+0xdc>
      else {
        p->s.size -= nunits;
 d26:	fe843783          	ld	a5,-24(s0)
 d2a:	4798                	lw	a4,8(a5)
 d2c:	fdc42783          	lw	a5,-36(s0)
 d30:	40f707bb          	subw	a5,a4,a5
 d34:	0007871b          	sext.w	a4,a5
 d38:	fe843783          	ld	a5,-24(s0)
 d3c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d3e:	fe843783          	ld	a5,-24(s0)
 d42:	479c                	lw	a5,8(a5)
 d44:	1782                	slli	a5,a5,0x20
 d46:	9381                	srli	a5,a5,0x20
 d48:	0792                	slli	a5,a5,0x4
 d4a:	fe843703          	ld	a4,-24(s0)
 d4e:	97ba                	add	a5,a5,a4
 d50:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d54:	fe843783          	ld	a5,-24(s0)
 d58:	fdc42703          	lw	a4,-36(s0)
 d5c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d5e:	00000797          	auipc	a5,0x0
 d62:	2d278793          	addi	a5,a5,722 # 1030 <freep>
 d66:	fe043703          	ld	a4,-32(s0)
 d6a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d6c:	fe843783          	ld	a5,-24(s0)
 d70:	07c1                	addi	a5,a5,16
 d72:	a091                	j	db6 <malloc+0x134>
    }
    if(p == freep)
 d74:	00000797          	auipc	a5,0x0
 d78:	2bc78793          	addi	a5,a5,700 # 1030 <freep>
 d7c:	639c                	ld	a5,0(a5)
 d7e:	fe843703          	ld	a4,-24(s0)
 d82:	02f71063          	bne	a4,a5,da2 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d86:	fdc42783          	lw	a5,-36(s0)
 d8a:	853e                	mv	a0,a5
 d8c:	00000097          	auipc	ra,0x0
 d90:	e76080e7          	jalr	-394(ra) # c02 <morecore>
 d94:	fea43423          	sd	a0,-24(s0)
 d98:	fe843783          	ld	a5,-24(s0)
 d9c:	e399                	bnez	a5,da2 <malloc+0x120>
        return 0;
 d9e:	4781                	li	a5,0
 da0:	a819                	j	db6 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 da2:	fe843783          	ld	a5,-24(s0)
 da6:	fef43023          	sd	a5,-32(s0)
 daa:	fe843783          	ld	a5,-24(s0)
 dae:	639c                	ld	a5,0(a5)
 db0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 db4:	b791                	j	cf8 <malloc+0x76>
  }
}
 db6:	853e                	mv	a0,a5
 db8:	70e2                	ld	ra,56(sp)
 dba:	7442                	ld	s0,48(sp)
 dbc:	6121                	addi	sp,sp,64
 dbe:	8082                	ret
