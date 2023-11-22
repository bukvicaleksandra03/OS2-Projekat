
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
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
    fprintf(2, "Usage: rm files...\n");
  20:	00001597          	auipc	a1,0x1
  24:	da058593          	addi	a1,a1,-608 # dc0 <malloc+0x14c>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	a00080e7          	jalr	-1536(ra) # a2a <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	520080e7          	jalr	1312(ra) # 554 <exit>
  }

  for(i = 1; i < argc; i++){
  3c:	4785                	li	a5,1
  3e:	fef42623          	sw	a5,-20(s0)
  42:	a0b9                	j	90 <main+0x90>
    if(unlink(argv[i]) < 0){
  44:	fec42783          	lw	a5,-20(s0)
  48:	078e                	slli	a5,a5,0x3
  4a:	fd043703          	ld	a4,-48(s0)
  4e:	97ba                	add	a5,a5,a4
  50:	639c                	ld	a5,0(a5)
  52:	853e                	mv	a0,a5
  54:	00000097          	auipc	ra,0x0
  58:	550080e7          	jalr	1360(ra) # 5a4 <unlink>
  5c:	87aa                	mv	a5,a0
  5e:	0207d463          	bgez	a5,86 <main+0x86>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  62:	fec42783          	lw	a5,-20(s0)
  66:	078e                	slli	a5,a5,0x3
  68:	fd043703          	ld	a4,-48(s0)
  6c:	97ba                	add	a5,a5,a4
  6e:	639c                	ld	a5,0(a5)
  70:	863e                	mv	a2,a5
  72:	00001597          	auipc	a1,0x1
  76:	d6658593          	addi	a1,a1,-666 # dd8 <malloc+0x164>
  7a:	4509                	li	a0,2
  7c:	00001097          	auipc	ra,0x1
  80:	9ae080e7          	jalr	-1618(ra) # a2a <fprintf>
      break;
  84:	a831                	j	a0 <main+0xa0>
  for(i = 1; i < argc; i++){
  86:	fec42783          	lw	a5,-20(s0)
  8a:	2785                	addiw	a5,a5,1
  8c:	fef42623          	sw	a5,-20(s0)
  90:	fec42703          	lw	a4,-20(s0)
  94:	fdc42783          	lw	a5,-36(s0)
  98:	2701                	sext.w	a4,a4
  9a:	2781                	sext.w	a5,a5
  9c:	faf744e3          	blt	a4,a5,44 <main+0x44>
    }
  }

  exit(0);
  a0:	4501                	li	a0,0
  a2:	00000097          	auipc	ra,0x0
  a6:	4b2080e7          	jalr	1202(ra) # 554 <exit>

00000000000000aa <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  aa:	1141                	addi	sp,sp,-16
  ac:	e406                	sd	ra,8(sp)
  ae:	e022                	sd	s0,0(sp)
  b0:	0800                	addi	s0,sp,16
  extern int main();
  main();
  b2:	00000097          	auipc	ra,0x0
  b6:	f4e080e7          	jalr	-178(ra) # 0 <main>
  exit(0);
  ba:	4501                	li	a0,0
  bc:	00000097          	auipc	ra,0x0
  c0:	498080e7          	jalr	1176(ra) # 554 <exit>

00000000000000c4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  c4:	7179                	addi	sp,sp,-48
  c6:	f422                	sd	s0,40(sp)
  c8:	1800                	addi	s0,sp,48
  ca:	fca43c23          	sd	a0,-40(s0)
  ce:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  d2:	fd843783          	ld	a5,-40(s0)
  d6:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  da:	0001                	nop
  dc:	fd043703          	ld	a4,-48(s0)
  e0:	00170793          	addi	a5,a4,1
  e4:	fcf43823          	sd	a5,-48(s0)
  e8:	fd843783          	ld	a5,-40(s0)
  ec:	00178693          	addi	a3,a5,1
  f0:	fcd43c23          	sd	a3,-40(s0)
  f4:	00074703          	lbu	a4,0(a4)
  f8:	00e78023          	sb	a4,0(a5)
  fc:	0007c783          	lbu	a5,0(a5)
 100:	fff1                	bnez	a5,dc <strcpy+0x18>
    ;
  return os;
 102:	fe843783          	ld	a5,-24(s0)
}
 106:	853e                	mv	a0,a5
 108:	7422                	ld	s0,40(sp)
 10a:	6145                	addi	sp,sp,48
 10c:	8082                	ret

000000000000010e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10e:	1101                	addi	sp,sp,-32
 110:	ec22                	sd	s0,24(sp)
 112:	1000                	addi	s0,sp,32
 114:	fea43423          	sd	a0,-24(s0)
 118:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 11c:	a819                	j	132 <strcmp+0x24>
    p++, q++;
 11e:	fe843783          	ld	a5,-24(s0)
 122:	0785                	addi	a5,a5,1
 124:	fef43423          	sd	a5,-24(s0)
 128:	fe043783          	ld	a5,-32(s0)
 12c:	0785                	addi	a5,a5,1
 12e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 132:	fe843783          	ld	a5,-24(s0)
 136:	0007c783          	lbu	a5,0(a5)
 13a:	cb99                	beqz	a5,150 <strcmp+0x42>
 13c:	fe843783          	ld	a5,-24(s0)
 140:	0007c703          	lbu	a4,0(a5)
 144:	fe043783          	ld	a5,-32(s0)
 148:	0007c783          	lbu	a5,0(a5)
 14c:	fcf709e3          	beq	a4,a5,11e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 150:	fe843783          	ld	a5,-24(s0)
 154:	0007c783          	lbu	a5,0(a5)
 158:	0007871b          	sext.w	a4,a5
 15c:	fe043783          	ld	a5,-32(s0)
 160:	0007c783          	lbu	a5,0(a5)
 164:	2781                	sext.w	a5,a5
 166:	40f707bb          	subw	a5,a4,a5
 16a:	2781                	sext.w	a5,a5
}
 16c:	853e                	mv	a0,a5
 16e:	6462                	ld	s0,24(sp)
 170:	6105                	addi	sp,sp,32
 172:	8082                	ret

0000000000000174 <strlen>:

uint
strlen(const char *s)
{
 174:	7179                	addi	sp,sp,-48
 176:	f422                	sd	s0,40(sp)
 178:	1800                	addi	s0,sp,48
 17a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 17e:	fe042623          	sw	zero,-20(s0)
 182:	a031                	j	18e <strlen+0x1a>
 184:	fec42783          	lw	a5,-20(s0)
 188:	2785                	addiw	a5,a5,1
 18a:	fef42623          	sw	a5,-20(s0)
 18e:	fec42783          	lw	a5,-20(s0)
 192:	fd843703          	ld	a4,-40(s0)
 196:	97ba                	add	a5,a5,a4
 198:	0007c783          	lbu	a5,0(a5)
 19c:	f7e5                	bnez	a5,184 <strlen+0x10>
    ;
  return n;
 19e:	fec42783          	lw	a5,-20(s0)
}
 1a2:	853e                	mv	a0,a5
 1a4:	7422                	ld	s0,40(sp)
 1a6:	6145                	addi	sp,sp,48
 1a8:	8082                	ret

00000000000001aa <memset>:

void*
memset(void *dst, int c, uint n)
{
 1aa:	7179                	addi	sp,sp,-48
 1ac:	f422                	sd	s0,40(sp)
 1ae:	1800                	addi	s0,sp,48
 1b0:	fca43c23          	sd	a0,-40(s0)
 1b4:	87ae                	mv	a5,a1
 1b6:	8732                	mv	a4,a2
 1b8:	fcf42a23          	sw	a5,-44(s0)
 1bc:	87ba                	mv	a5,a4
 1be:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1c2:	fd843783          	ld	a5,-40(s0)
 1c6:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1ca:	fe042623          	sw	zero,-20(s0)
 1ce:	a00d                	j	1f0 <memset+0x46>
    cdst[i] = c;
 1d0:	fec42783          	lw	a5,-20(s0)
 1d4:	fe043703          	ld	a4,-32(s0)
 1d8:	97ba                	add	a5,a5,a4
 1da:	fd442703          	lw	a4,-44(s0)
 1de:	0ff77713          	andi	a4,a4,255
 1e2:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1e6:	fec42783          	lw	a5,-20(s0)
 1ea:	2785                	addiw	a5,a5,1
 1ec:	fef42623          	sw	a5,-20(s0)
 1f0:	fec42703          	lw	a4,-20(s0)
 1f4:	fd042783          	lw	a5,-48(s0)
 1f8:	2781                	sext.w	a5,a5
 1fa:	fcf76be3          	bltu	a4,a5,1d0 <memset+0x26>
  }
  return dst;
 1fe:	fd843783          	ld	a5,-40(s0)
}
 202:	853e                	mv	a0,a5
 204:	7422                	ld	s0,40(sp)
 206:	6145                	addi	sp,sp,48
 208:	8082                	ret

000000000000020a <strchr>:

char*
strchr(const char *s, char c)
{
 20a:	1101                	addi	sp,sp,-32
 20c:	ec22                	sd	s0,24(sp)
 20e:	1000                	addi	s0,sp,32
 210:	fea43423          	sd	a0,-24(s0)
 214:	87ae                	mv	a5,a1
 216:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 21a:	a01d                	j	240 <strchr+0x36>
    if(*s == c)
 21c:	fe843783          	ld	a5,-24(s0)
 220:	0007c703          	lbu	a4,0(a5)
 224:	fe744783          	lbu	a5,-25(s0)
 228:	0ff7f793          	andi	a5,a5,255
 22c:	00e79563          	bne	a5,a4,236 <strchr+0x2c>
      return (char*)s;
 230:	fe843783          	ld	a5,-24(s0)
 234:	a821                	j	24c <strchr+0x42>
  for(; *s; s++)
 236:	fe843783          	ld	a5,-24(s0)
 23a:	0785                	addi	a5,a5,1
 23c:	fef43423          	sd	a5,-24(s0)
 240:	fe843783          	ld	a5,-24(s0)
 244:	0007c783          	lbu	a5,0(a5)
 248:	fbf1                	bnez	a5,21c <strchr+0x12>
  return 0;
 24a:	4781                	li	a5,0
}
 24c:	853e                	mv	a0,a5
 24e:	6462                	ld	s0,24(sp)
 250:	6105                	addi	sp,sp,32
 252:	8082                	ret

0000000000000254 <gets>:

char*
gets(char *buf, int max)
{
 254:	7179                	addi	sp,sp,-48
 256:	f406                	sd	ra,40(sp)
 258:	f022                	sd	s0,32(sp)
 25a:	1800                	addi	s0,sp,48
 25c:	fca43c23          	sd	a0,-40(s0)
 260:	87ae                	mv	a5,a1
 262:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 266:	fe042623          	sw	zero,-20(s0)
 26a:	a8a1                	j	2c2 <gets+0x6e>
    cc = read(0, &c, 1);
 26c:	fe740793          	addi	a5,s0,-25
 270:	4605                	li	a2,1
 272:	85be                	mv	a1,a5
 274:	4501                	li	a0,0
 276:	00000097          	auipc	ra,0x0
 27a:	2f6080e7          	jalr	758(ra) # 56c <read>
 27e:	87aa                	mv	a5,a0
 280:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 284:	fe842783          	lw	a5,-24(s0)
 288:	2781                	sext.w	a5,a5
 28a:	04f05763          	blez	a5,2d8 <gets+0x84>
      break;
    buf[i++] = c;
 28e:	fec42783          	lw	a5,-20(s0)
 292:	0017871b          	addiw	a4,a5,1
 296:	fee42623          	sw	a4,-20(s0)
 29a:	873e                	mv	a4,a5
 29c:	fd843783          	ld	a5,-40(s0)
 2a0:	97ba                	add	a5,a5,a4
 2a2:	fe744703          	lbu	a4,-25(s0)
 2a6:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2aa:	fe744783          	lbu	a5,-25(s0)
 2ae:	873e                	mv	a4,a5
 2b0:	47a9                	li	a5,10
 2b2:	02f70463          	beq	a4,a5,2da <gets+0x86>
 2b6:	fe744783          	lbu	a5,-25(s0)
 2ba:	873e                	mv	a4,a5
 2bc:	47b5                	li	a5,13
 2be:	00f70e63          	beq	a4,a5,2da <gets+0x86>
  for(i=0; i+1 < max; ){
 2c2:	fec42783          	lw	a5,-20(s0)
 2c6:	2785                	addiw	a5,a5,1
 2c8:	0007871b          	sext.w	a4,a5
 2cc:	fd442783          	lw	a5,-44(s0)
 2d0:	2781                	sext.w	a5,a5
 2d2:	f8f74de3          	blt	a4,a5,26c <gets+0x18>
 2d6:	a011                	j	2da <gets+0x86>
      break;
 2d8:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2da:	fec42783          	lw	a5,-20(s0)
 2de:	fd843703          	ld	a4,-40(s0)
 2e2:	97ba                	add	a5,a5,a4
 2e4:	00078023          	sb	zero,0(a5)
  return buf;
 2e8:	fd843783          	ld	a5,-40(s0)
}
 2ec:	853e                	mv	a0,a5
 2ee:	70a2                	ld	ra,40(sp)
 2f0:	7402                	ld	s0,32(sp)
 2f2:	6145                	addi	sp,sp,48
 2f4:	8082                	ret

00000000000002f6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f6:	7179                	addi	sp,sp,-48
 2f8:	f406                	sd	ra,40(sp)
 2fa:	f022                	sd	s0,32(sp)
 2fc:	1800                	addi	s0,sp,48
 2fe:	fca43c23          	sd	a0,-40(s0)
 302:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 306:	4581                	li	a1,0
 308:	fd843503          	ld	a0,-40(s0)
 30c:	00000097          	auipc	ra,0x0
 310:	288080e7          	jalr	648(ra) # 594 <open>
 314:	87aa                	mv	a5,a0
 316:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 31a:	fec42783          	lw	a5,-20(s0)
 31e:	2781                	sext.w	a5,a5
 320:	0007d463          	bgez	a5,328 <stat+0x32>
    return -1;
 324:	57fd                	li	a5,-1
 326:	a035                	j	352 <stat+0x5c>
  r = fstat(fd, st);
 328:	fec42783          	lw	a5,-20(s0)
 32c:	fd043583          	ld	a1,-48(s0)
 330:	853e                	mv	a0,a5
 332:	00000097          	auipc	ra,0x0
 336:	27a080e7          	jalr	634(ra) # 5ac <fstat>
 33a:	87aa                	mv	a5,a0
 33c:	fef42423          	sw	a5,-24(s0)
  close(fd);
 340:	fec42783          	lw	a5,-20(s0)
 344:	853e                	mv	a0,a5
 346:	00000097          	auipc	ra,0x0
 34a:	236080e7          	jalr	566(ra) # 57c <close>
  return r;
 34e:	fe842783          	lw	a5,-24(s0)
}
 352:	853e                	mv	a0,a5
 354:	70a2                	ld	ra,40(sp)
 356:	7402                	ld	s0,32(sp)
 358:	6145                	addi	sp,sp,48
 35a:	8082                	ret

000000000000035c <atoi>:

int
atoi(const char *s)
{
 35c:	7179                	addi	sp,sp,-48
 35e:	f422                	sd	s0,40(sp)
 360:	1800                	addi	s0,sp,48
 362:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 366:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 36a:	a815                	j	39e <atoi+0x42>
    n = n*10 + *s++ - '0';
 36c:	fec42703          	lw	a4,-20(s0)
 370:	87ba                	mv	a5,a4
 372:	0027979b          	slliw	a5,a5,0x2
 376:	9fb9                	addw	a5,a5,a4
 378:	0017979b          	slliw	a5,a5,0x1
 37c:	0007871b          	sext.w	a4,a5
 380:	fd843783          	ld	a5,-40(s0)
 384:	00178693          	addi	a3,a5,1
 388:	fcd43c23          	sd	a3,-40(s0)
 38c:	0007c783          	lbu	a5,0(a5)
 390:	2781                	sext.w	a5,a5
 392:	9fb9                	addw	a5,a5,a4
 394:	2781                	sext.w	a5,a5
 396:	fd07879b          	addiw	a5,a5,-48
 39a:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 39e:	fd843783          	ld	a5,-40(s0)
 3a2:	0007c783          	lbu	a5,0(a5)
 3a6:	873e                	mv	a4,a5
 3a8:	02f00793          	li	a5,47
 3ac:	00e7fb63          	bgeu	a5,a4,3c2 <atoi+0x66>
 3b0:	fd843783          	ld	a5,-40(s0)
 3b4:	0007c783          	lbu	a5,0(a5)
 3b8:	873e                	mv	a4,a5
 3ba:	03900793          	li	a5,57
 3be:	fae7f7e3          	bgeu	a5,a4,36c <atoi+0x10>
  return n;
 3c2:	fec42783          	lw	a5,-20(s0)
}
 3c6:	853e                	mv	a0,a5
 3c8:	7422                	ld	s0,40(sp)
 3ca:	6145                	addi	sp,sp,48
 3cc:	8082                	ret

00000000000003ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ce:	7139                	addi	sp,sp,-64
 3d0:	fc22                	sd	s0,56(sp)
 3d2:	0080                	addi	s0,sp,64
 3d4:	fca43c23          	sd	a0,-40(s0)
 3d8:	fcb43823          	sd	a1,-48(s0)
 3dc:	87b2                	mv	a5,a2
 3de:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3e2:	fd843783          	ld	a5,-40(s0)
 3e6:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3ea:	fd043783          	ld	a5,-48(s0)
 3ee:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3f2:	fe043703          	ld	a4,-32(s0)
 3f6:	fe843783          	ld	a5,-24(s0)
 3fa:	02e7fc63          	bgeu	a5,a4,432 <memmove+0x64>
    while(n-- > 0)
 3fe:	a00d                	j	420 <memmove+0x52>
      *dst++ = *src++;
 400:	fe043703          	ld	a4,-32(s0)
 404:	00170793          	addi	a5,a4,1
 408:	fef43023          	sd	a5,-32(s0)
 40c:	fe843783          	ld	a5,-24(s0)
 410:	00178693          	addi	a3,a5,1
 414:	fed43423          	sd	a3,-24(s0)
 418:	00074703          	lbu	a4,0(a4)
 41c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 420:	fcc42783          	lw	a5,-52(s0)
 424:	fff7871b          	addiw	a4,a5,-1
 428:	fce42623          	sw	a4,-52(s0)
 42c:	fcf04ae3          	bgtz	a5,400 <memmove+0x32>
 430:	a891                	j	484 <memmove+0xb6>
  } else {
    dst += n;
 432:	fcc42783          	lw	a5,-52(s0)
 436:	fe843703          	ld	a4,-24(s0)
 43a:	97ba                	add	a5,a5,a4
 43c:	fef43423          	sd	a5,-24(s0)
    src += n;
 440:	fcc42783          	lw	a5,-52(s0)
 444:	fe043703          	ld	a4,-32(s0)
 448:	97ba                	add	a5,a5,a4
 44a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 44e:	a01d                	j	474 <memmove+0xa6>
      *--dst = *--src;
 450:	fe043783          	ld	a5,-32(s0)
 454:	17fd                	addi	a5,a5,-1
 456:	fef43023          	sd	a5,-32(s0)
 45a:	fe843783          	ld	a5,-24(s0)
 45e:	17fd                	addi	a5,a5,-1
 460:	fef43423          	sd	a5,-24(s0)
 464:	fe043783          	ld	a5,-32(s0)
 468:	0007c703          	lbu	a4,0(a5)
 46c:	fe843783          	ld	a5,-24(s0)
 470:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 474:	fcc42783          	lw	a5,-52(s0)
 478:	fff7871b          	addiw	a4,a5,-1
 47c:	fce42623          	sw	a4,-52(s0)
 480:	fcf048e3          	bgtz	a5,450 <memmove+0x82>
  }
  return vdst;
 484:	fd843783          	ld	a5,-40(s0)
}
 488:	853e                	mv	a0,a5
 48a:	7462                	ld	s0,56(sp)
 48c:	6121                	addi	sp,sp,64
 48e:	8082                	ret

0000000000000490 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 490:	7139                	addi	sp,sp,-64
 492:	fc22                	sd	s0,56(sp)
 494:	0080                	addi	s0,sp,64
 496:	fca43c23          	sd	a0,-40(s0)
 49a:	fcb43823          	sd	a1,-48(s0)
 49e:	87b2                	mv	a5,a2
 4a0:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4a4:	fd843783          	ld	a5,-40(s0)
 4a8:	fef43423          	sd	a5,-24(s0)
 4ac:	fd043783          	ld	a5,-48(s0)
 4b0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4b4:	a0a1                	j	4fc <memcmp+0x6c>
    if (*p1 != *p2) {
 4b6:	fe843783          	ld	a5,-24(s0)
 4ba:	0007c703          	lbu	a4,0(a5)
 4be:	fe043783          	ld	a5,-32(s0)
 4c2:	0007c783          	lbu	a5,0(a5)
 4c6:	02f70163          	beq	a4,a5,4e8 <memcmp+0x58>
      return *p1 - *p2;
 4ca:	fe843783          	ld	a5,-24(s0)
 4ce:	0007c783          	lbu	a5,0(a5)
 4d2:	0007871b          	sext.w	a4,a5
 4d6:	fe043783          	ld	a5,-32(s0)
 4da:	0007c783          	lbu	a5,0(a5)
 4de:	2781                	sext.w	a5,a5
 4e0:	40f707bb          	subw	a5,a4,a5
 4e4:	2781                	sext.w	a5,a5
 4e6:	a01d                	j	50c <memcmp+0x7c>
    }
    p1++;
 4e8:	fe843783          	ld	a5,-24(s0)
 4ec:	0785                	addi	a5,a5,1
 4ee:	fef43423          	sd	a5,-24(s0)
    p2++;
 4f2:	fe043783          	ld	a5,-32(s0)
 4f6:	0785                	addi	a5,a5,1
 4f8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4fc:	fcc42783          	lw	a5,-52(s0)
 500:	fff7871b          	addiw	a4,a5,-1
 504:	fce42623          	sw	a4,-52(s0)
 508:	f7dd                	bnez	a5,4b6 <memcmp+0x26>
  }
  return 0;
 50a:	4781                	li	a5,0
}
 50c:	853e                	mv	a0,a5
 50e:	7462                	ld	s0,56(sp)
 510:	6121                	addi	sp,sp,64
 512:	8082                	ret

0000000000000514 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 514:	7179                	addi	sp,sp,-48
 516:	f406                	sd	ra,40(sp)
 518:	f022                	sd	s0,32(sp)
 51a:	1800                	addi	s0,sp,48
 51c:	fea43423          	sd	a0,-24(s0)
 520:	feb43023          	sd	a1,-32(s0)
 524:	87b2                	mv	a5,a2
 526:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 52a:	fdc42783          	lw	a5,-36(s0)
 52e:	863e                	mv	a2,a5
 530:	fe043583          	ld	a1,-32(s0)
 534:	fe843503          	ld	a0,-24(s0)
 538:	00000097          	auipc	ra,0x0
 53c:	e96080e7          	jalr	-362(ra) # 3ce <memmove>
 540:	87aa                	mv	a5,a0
}
 542:	853e                	mv	a0,a5
 544:	70a2                	ld	ra,40(sp)
 546:	7402                	ld	s0,32(sp)
 548:	6145                	addi	sp,sp,48
 54a:	8082                	ret

000000000000054c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 54c:	4885                	li	a7,1
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <exit>:
.global exit
exit:
 li a7, SYS_exit
 554:	4889                	li	a7,2
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <wait>:
.global wait
wait:
 li a7, SYS_wait
 55c:	488d                	li	a7,3
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 564:	4891                	li	a7,4
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <read>:
.global read
read:
 li a7, SYS_read
 56c:	4895                	li	a7,5
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <write>:
.global write
write:
 li a7, SYS_write
 574:	48c1                	li	a7,16
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <close>:
.global close
close:
 li a7, SYS_close
 57c:	48d5                	li	a7,21
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <kill>:
.global kill
kill:
 li a7, SYS_kill
 584:	4899                	li	a7,6
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <exec>:
.global exec
exec:
 li a7, SYS_exec
 58c:	489d                	li	a7,7
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <open>:
.global open
open:
 li a7, SYS_open
 594:	48bd                	li	a7,15
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 59c:	48c5                	li	a7,17
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5a4:	48c9                	li	a7,18
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5ac:	48a1                	li	a7,8
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <link>:
.global link
link:
 li a7, SYS_link
 5b4:	48cd                	li	a7,19
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5bc:	48d1                	li	a7,20
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5c4:	48a5                	li	a7,9
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <dup>:
.global dup
dup:
 li a7, SYS_dup
 5cc:	48a9                	li	a7,10
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5d4:	48ad                	li	a7,11
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5dc:	48b1                	li	a7,12
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5e4:	48b5                	li	a7,13
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ec:	48b9                	li	a7,14
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f4:	1101                	addi	sp,sp,-32
 5f6:	ec06                	sd	ra,24(sp)
 5f8:	e822                	sd	s0,16(sp)
 5fa:	1000                	addi	s0,sp,32
 5fc:	87aa                	mv	a5,a0
 5fe:	872e                	mv	a4,a1
 600:	fef42623          	sw	a5,-20(s0)
 604:	87ba                	mv	a5,a4
 606:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 60a:	feb40713          	addi	a4,s0,-21
 60e:	fec42783          	lw	a5,-20(s0)
 612:	4605                	li	a2,1
 614:	85ba                	mv	a1,a4
 616:	853e                	mv	a0,a5
 618:	00000097          	auipc	ra,0x0
 61c:	f5c080e7          	jalr	-164(ra) # 574 <write>
}
 620:	0001                	nop
 622:	60e2                	ld	ra,24(sp)
 624:	6442                	ld	s0,16(sp)
 626:	6105                	addi	sp,sp,32
 628:	8082                	ret

000000000000062a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 62a:	7139                	addi	sp,sp,-64
 62c:	fc06                	sd	ra,56(sp)
 62e:	f822                	sd	s0,48(sp)
 630:	0080                	addi	s0,sp,64
 632:	87aa                	mv	a5,a0
 634:	8736                	mv	a4,a3
 636:	fcf42623          	sw	a5,-52(s0)
 63a:	87ae                	mv	a5,a1
 63c:	fcf42423          	sw	a5,-56(s0)
 640:	87b2                	mv	a5,a2
 642:	fcf42223          	sw	a5,-60(s0)
 646:	87ba                	mv	a5,a4
 648:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 64c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 650:	fc042783          	lw	a5,-64(s0)
 654:	2781                	sext.w	a5,a5
 656:	c38d                	beqz	a5,678 <printint+0x4e>
 658:	fc842783          	lw	a5,-56(s0)
 65c:	2781                	sext.w	a5,a5
 65e:	0007dd63          	bgez	a5,678 <printint+0x4e>
    neg = 1;
 662:	4785                	li	a5,1
 664:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 668:	fc842783          	lw	a5,-56(s0)
 66c:	40f007bb          	negw	a5,a5
 670:	2781                	sext.w	a5,a5
 672:	fef42223          	sw	a5,-28(s0)
 676:	a029                	j	680 <printint+0x56>
  } else {
    x = xx;
 678:	fc842783          	lw	a5,-56(s0)
 67c:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 680:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 684:	fc442783          	lw	a5,-60(s0)
 688:	fe442703          	lw	a4,-28(s0)
 68c:	02f777bb          	remuw	a5,a4,a5
 690:	0007861b          	sext.w	a2,a5
 694:	fec42783          	lw	a5,-20(s0)
 698:	0017871b          	addiw	a4,a5,1
 69c:	fee42623          	sw	a4,-20(s0)
 6a0:	00001697          	auipc	a3,0x1
 6a4:	96068693          	addi	a3,a3,-1696 # 1000 <digits>
 6a8:	02061713          	slli	a4,a2,0x20
 6ac:	9301                	srli	a4,a4,0x20
 6ae:	9736                	add	a4,a4,a3
 6b0:	00074703          	lbu	a4,0(a4)
 6b4:	ff040693          	addi	a3,s0,-16
 6b8:	97b6                	add	a5,a5,a3
 6ba:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6be:	fc442783          	lw	a5,-60(s0)
 6c2:	fe442703          	lw	a4,-28(s0)
 6c6:	02f757bb          	divuw	a5,a4,a5
 6ca:	fef42223          	sw	a5,-28(s0)
 6ce:	fe442783          	lw	a5,-28(s0)
 6d2:	2781                	sext.w	a5,a5
 6d4:	fbc5                	bnez	a5,684 <printint+0x5a>
  if(neg)
 6d6:	fe842783          	lw	a5,-24(s0)
 6da:	2781                	sext.w	a5,a5
 6dc:	cf95                	beqz	a5,718 <printint+0xee>
    buf[i++] = '-';
 6de:	fec42783          	lw	a5,-20(s0)
 6e2:	0017871b          	addiw	a4,a5,1
 6e6:	fee42623          	sw	a4,-20(s0)
 6ea:	ff040713          	addi	a4,s0,-16
 6ee:	97ba                	add	a5,a5,a4
 6f0:	02d00713          	li	a4,45
 6f4:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6f8:	a005                	j	718 <printint+0xee>
    putc(fd, buf[i]);
 6fa:	fec42783          	lw	a5,-20(s0)
 6fe:	ff040713          	addi	a4,s0,-16
 702:	97ba                	add	a5,a5,a4
 704:	fe07c703          	lbu	a4,-32(a5)
 708:	fcc42783          	lw	a5,-52(s0)
 70c:	85ba                	mv	a1,a4
 70e:	853e                	mv	a0,a5
 710:	00000097          	auipc	ra,0x0
 714:	ee4080e7          	jalr	-284(ra) # 5f4 <putc>
  while(--i >= 0)
 718:	fec42783          	lw	a5,-20(s0)
 71c:	37fd                	addiw	a5,a5,-1
 71e:	fef42623          	sw	a5,-20(s0)
 722:	fec42783          	lw	a5,-20(s0)
 726:	2781                	sext.w	a5,a5
 728:	fc07d9e3          	bgez	a5,6fa <printint+0xd0>
}
 72c:	0001                	nop
 72e:	0001                	nop
 730:	70e2                	ld	ra,56(sp)
 732:	7442                	ld	s0,48(sp)
 734:	6121                	addi	sp,sp,64
 736:	8082                	ret

0000000000000738 <printptr>:

static void
printptr(int fd, uint64 x) {
 738:	7179                	addi	sp,sp,-48
 73a:	f406                	sd	ra,40(sp)
 73c:	f022                	sd	s0,32(sp)
 73e:	1800                	addi	s0,sp,48
 740:	87aa                	mv	a5,a0
 742:	fcb43823          	sd	a1,-48(s0)
 746:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 74a:	fdc42783          	lw	a5,-36(s0)
 74e:	03000593          	li	a1,48
 752:	853e                	mv	a0,a5
 754:	00000097          	auipc	ra,0x0
 758:	ea0080e7          	jalr	-352(ra) # 5f4 <putc>
  putc(fd, 'x');
 75c:	fdc42783          	lw	a5,-36(s0)
 760:	07800593          	li	a1,120
 764:	853e                	mv	a0,a5
 766:	00000097          	auipc	ra,0x0
 76a:	e8e080e7          	jalr	-370(ra) # 5f4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 76e:	fe042623          	sw	zero,-20(s0)
 772:	a82d                	j	7ac <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 774:	fd043783          	ld	a5,-48(s0)
 778:	93f1                	srli	a5,a5,0x3c
 77a:	00001717          	auipc	a4,0x1
 77e:	88670713          	addi	a4,a4,-1914 # 1000 <digits>
 782:	97ba                	add	a5,a5,a4
 784:	0007c703          	lbu	a4,0(a5)
 788:	fdc42783          	lw	a5,-36(s0)
 78c:	85ba                	mv	a1,a4
 78e:	853e                	mv	a0,a5
 790:	00000097          	auipc	ra,0x0
 794:	e64080e7          	jalr	-412(ra) # 5f4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 798:	fec42783          	lw	a5,-20(s0)
 79c:	2785                	addiw	a5,a5,1
 79e:	fef42623          	sw	a5,-20(s0)
 7a2:	fd043783          	ld	a5,-48(s0)
 7a6:	0792                	slli	a5,a5,0x4
 7a8:	fcf43823          	sd	a5,-48(s0)
 7ac:	fec42783          	lw	a5,-20(s0)
 7b0:	873e                	mv	a4,a5
 7b2:	47bd                	li	a5,15
 7b4:	fce7f0e3          	bgeu	a5,a4,774 <printptr+0x3c>
}
 7b8:	0001                	nop
 7ba:	0001                	nop
 7bc:	70a2                	ld	ra,40(sp)
 7be:	7402                	ld	s0,32(sp)
 7c0:	6145                	addi	sp,sp,48
 7c2:	8082                	ret

00000000000007c4 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7c4:	715d                	addi	sp,sp,-80
 7c6:	e486                	sd	ra,72(sp)
 7c8:	e0a2                	sd	s0,64(sp)
 7ca:	0880                	addi	s0,sp,80
 7cc:	87aa                	mv	a5,a0
 7ce:	fcb43023          	sd	a1,-64(s0)
 7d2:	fac43c23          	sd	a2,-72(s0)
 7d6:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7da:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7de:	fe042223          	sw	zero,-28(s0)
 7e2:	a42d                	j	a0c <vprintf+0x248>
    c = fmt[i] & 0xff;
 7e4:	fe442783          	lw	a5,-28(s0)
 7e8:	fc043703          	ld	a4,-64(s0)
 7ec:	97ba                	add	a5,a5,a4
 7ee:	0007c783          	lbu	a5,0(a5)
 7f2:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7f6:	fe042783          	lw	a5,-32(s0)
 7fa:	2781                	sext.w	a5,a5
 7fc:	eb9d                	bnez	a5,832 <vprintf+0x6e>
      if(c == '%'){
 7fe:	fdc42783          	lw	a5,-36(s0)
 802:	0007871b          	sext.w	a4,a5
 806:	02500793          	li	a5,37
 80a:	00f71763          	bne	a4,a5,818 <vprintf+0x54>
        state = '%';
 80e:	02500793          	li	a5,37
 812:	fef42023          	sw	a5,-32(s0)
 816:	a2f5                	j	a02 <vprintf+0x23e>
      } else {
        putc(fd, c);
 818:	fdc42783          	lw	a5,-36(s0)
 81c:	0ff7f713          	andi	a4,a5,255
 820:	fcc42783          	lw	a5,-52(s0)
 824:	85ba                	mv	a1,a4
 826:	853e                	mv	a0,a5
 828:	00000097          	auipc	ra,0x0
 82c:	dcc080e7          	jalr	-564(ra) # 5f4 <putc>
 830:	aac9                	j	a02 <vprintf+0x23e>
      }
    } else if(state == '%'){
 832:	fe042783          	lw	a5,-32(s0)
 836:	0007871b          	sext.w	a4,a5
 83a:	02500793          	li	a5,37
 83e:	1cf71263          	bne	a4,a5,a02 <vprintf+0x23e>
      if(c == 'd'){
 842:	fdc42783          	lw	a5,-36(s0)
 846:	0007871b          	sext.w	a4,a5
 84a:	06400793          	li	a5,100
 84e:	02f71463          	bne	a4,a5,876 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 852:	fb843783          	ld	a5,-72(s0)
 856:	00878713          	addi	a4,a5,8
 85a:	fae43c23          	sd	a4,-72(s0)
 85e:	4398                	lw	a4,0(a5)
 860:	fcc42783          	lw	a5,-52(s0)
 864:	4685                	li	a3,1
 866:	4629                	li	a2,10
 868:	85ba                	mv	a1,a4
 86a:	853e                	mv	a0,a5
 86c:	00000097          	auipc	ra,0x0
 870:	dbe080e7          	jalr	-578(ra) # 62a <printint>
 874:	a269                	j	9fe <vprintf+0x23a>
      } else if(c == 'l') {
 876:	fdc42783          	lw	a5,-36(s0)
 87a:	0007871b          	sext.w	a4,a5
 87e:	06c00793          	li	a5,108
 882:	02f71663          	bne	a4,a5,8ae <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 886:	fb843783          	ld	a5,-72(s0)
 88a:	00878713          	addi	a4,a5,8
 88e:	fae43c23          	sd	a4,-72(s0)
 892:	639c                	ld	a5,0(a5)
 894:	0007871b          	sext.w	a4,a5
 898:	fcc42783          	lw	a5,-52(s0)
 89c:	4681                	li	a3,0
 89e:	4629                	li	a2,10
 8a0:	85ba                	mv	a1,a4
 8a2:	853e                	mv	a0,a5
 8a4:	00000097          	auipc	ra,0x0
 8a8:	d86080e7          	jalr	-634(ra) # 62a <printint>
 8ac:	aa89                	j	9fe <vprintf+0x23a>
      } else if(c == 'x') {
 8ae:	fdc42783          	lw	a5,-36(s0)
 8b2:	0007871b          	sext.w	a4,a5
 8b6:	07800793          	li	a5,120
 8ba:	02f71463          	bne	a4,a5,8e2 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8be:	fb843783          	ld	a5,-72(s0)
 8c2:	00878713          	addi	a4,a5,8
 8c6:	fae43c23          	sd	a4,-72(s0)
 8ca:	4398                	lw	a4,0(a5)
 8cc:	fcc42783          	lw	a5,-52(s0)
 8d0:	4681                	li	a3,0
 8d2:	4641                	li	a2,16
 8d4:	85ba                	mv	a1,a4
 8d6:	853e                	mv	a0,a5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	d52080e7          	jalr	-686(ra) # 62a <printint>
 8e0:	aa39                	j	9fe <vprintf+0x23a>
      } else if(c == 'p') {
 8e2:	fdc42783          	lw	a5,-36(s0)
 8e6:	0007871b          	sext.w	a4,a5
 8ea:	07000793          	li	a5,112
 8ee:	02f71263          	bne	a4,a5,912 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8f2:	fb843783          	ld	a5,-72(s0)
 8f6:	00878713          	addi	a4,a5,8
 8fa:	fae43c23          	sd	a4,-72(s0)
 8fe:	6398                	ld	a4,0(a5)
 900:	fcc42783          	lw	a5,-52(s0)
 904:	85ba                	mv	a1,a4
 906:	853e                	mv	a0,a5
 908:	00000097          	auipc	ra,0x0
 90c:	e30080e7          	jalr	-464(ra) # 738 <printptr>
 910:	a0fd                	j	9fe <vprintf+0x23a>
      } else if(c == 's'){
 912:	fdc42783          	lw	a5,-36(s0)
 916:	0007871b          	sext.w	a4,a5
 91a:	07300793          	li	a5,115
 91e:	04f71c63          	bne	a4,a5,976 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 922:	fb843783          	ld	a5,-72(s0)
 926:	00878713          	addi	a4,a5,8
 92a:	fae43c23          	sd	a4,-72(s0)
 92e:	639c                	ld	a5,0(a5)
 930:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 934:	fe843783          	ld	a5,-24(s0)
 938:	eb8d                	bnez	a5,96a <vprintf+0x1a6>
          s = "(null)";
 93a:	00000797          	auipc	a5,0x0
 93e:	4be78793          	addi	a5,a5,1214 # df8 <malloc+0x184>
 942:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 946:	a015                	j	96a <vprintf+0x1a6>
          putc(fd, *s);
 948:	fe843783          	ld	a5,-24(s0)
 94c:	0007c703          	lbu	a4,0(a5)
 950:	fcc42783          	lw	a5,-52(s0)
 954:	85ba                	mv	a1,a4
 956:	853e                	mv	a0,a5
 958:	00000097          	auipc	ra,0x0
 95c:	c9c080e7          	jalr	-868(ra) # 5f4 <putc>
          s++;
 960:	fe843783          	ld	a5,-24(s0)
 964:	0785                	addi	a5,a5,1
 966:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 96a:	fe843783          	ld	a5,-24(s0)
 96e:	0007c783          	lbu	a5,0(a5)
 972:	fbf9                	bnez	a5,948 <vprintf+0x184>
 974:	a069                	j	9fe <vprintf+0x23a>
        }
      } else if(c == 'c'){
 976:	fdc42783          	lw	a5,-36(s0)
 97a:	0007871b          	sext.w	a4,a5
 97e:	06300793          	li	a5,99
 982:	02f71463          	bne	a4,a5,9aa <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 986:	fb843783          	ld	a5,-72(s0)
 98a:	00878713          	addi	a4,a5,8
 98e:	fae43c23          	sd	a4,-72(s0)
 992:	439c                	lw	a5,0(a5)
 994:	0ff7f713          	andi	a4,a5,255
 998:	fcc42783          	lw	a5,-52(s0)
 99c:	85ba                	mv	a1,a4
 99e:	853e                	mv	a0,a5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	c54080e7          	jalr	-940(ra) # 5f4 <putc>
 9a8:	a899                	j	9fe <vprintf+0x23a>
      } else if(c == '%'){
 9aa:	fdc42783          	lw	a5,-36(s0)
 9ae:	0007871b          	sext.w	a4,a5
 9b2:	02500793          	li	a5,37
 9b6:	00f71f63          	bne	a4,a5,9d4 <vprintf+0x210>
        putc(fd, c);
 9ba:	fdc42783          	lw	a5,-36(s0)
 9be:	0ff7f713          	andi	a4,a5,255
 9c2:	fcc42783          	lw	a5,-52(s0)
 9c6:	85ba                	mv	a1,a4
 9c8:	853e                	mv	a0,a5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	c2a080e7          	jalr	-982(ra) # 5f4 <putc>
 9d2:	a035                	j	9fe <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9d4:	fcc42783          	lw	a5,-52(s0)
 9d8:	02500593          	li	a1,37
 9dc:	853e                	mv	a0,a5
 9de:	00000097          	auipc	ra,0x0
 9e2:	c16080e7          	jalr	-1002(ra) # 5f4 <putc>
        putc(fd, c);
 9e6:	fdc42783          	lw	a5,-36(s0)
 9ea:	0ff7f713          	andi	a4,a5,255
 9ee:	fcc42783          	lw	a5,-52(s0)
 9f2:	85ba                	mv	a1,a4
 9f4:	853e                	mv	a0,a5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	bfe080e7          	jalr	-1026(ra) # 5f4 <putc>
      }
      state = 0;
 9fe:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a02:	fe442783          	lw	a5,-28(s0)
 a06:	2785                	addiw	a5,a5,1
 a08:	fef42223          	sw	a5,-28(s0)
 a0c:	fe442783          	lw	a5,-28(s0)
 a10:	fc043703          	ld	a4,-64(s0)
 a14:	97ba                	add	a5,a5,a4
 a16:	0007c783          	lbu	a5,0(a5)
 a1a:	dc0795e3          	bnez	a5,7e4 <vprintf+0x20>
    }
  }
}
 a1e:	0001                	nop
 a20:	0001                	nop
 a22:	60a6                	ld	ra,72(sp)
 a24:	6406                	ld	s0,64(sp)
 a26:	6161                	addi	sp,sp,80
 a28:	8082                	ret

0000000000000a2a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a2a:	7159                	addi	sp,sp,-112
 a2c:	fc06                	sd	ra,56(sp)
 a2e:	f822                	sd	s0,48(sp)
 a30:	0080                	addi	s0,sp,64
 a32:	fcb43823          	sd	a1,-48(s0)
 a36:	e010                	sd	a2,0(s0)
 a38:	e414                	sd	a3,8(s0)
 a3a:	e818                	sd	a4,16(s0)
 a3c:	ec1c                	sd	a5,24(s0)
 a3e:	03043023          	sd	a6,32(s0)
 a42:	03143423          	sd	a7,40(s0)
 a46:	87aa                	mv	a5,a0
 a48:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a4c:	03040793          	addi	a5,s0,48
 a50:	fcf43423          	sd	a5,-56(s0)
 a54:	fc843783          	ld	a5,-56(s0)
 a58:	fd078793          	addi	a5,a5,-48
 a5c:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a60:	fe843703          	ld	a4,-24(s0)
 a64:	fdc42783          	lw	a5,-36(s0)
 a68:	863a                	mv	a2,a4
 a6a:	fd043583          	ld	a1,-48(s0)
 a6e:	853e                	mv	a0,a5
 a70:	00000097          	auipc	ra,0x0
 a74:	d54080e7          	jalr	-684(ra) # 7c4 <vprintf>
}
 a78:	0001                	nop
 a7a:	70e2                	ld	ra,56(sp)
 a7c:	7442                	ld	s0,48(sp)
 a7e:	6165                	addi	sp,sp,112
 a80:	8082                	ret

0000000000000a82 <printf>:

void
printf(const char *fmt, ...)
{
 a82:	7159                	addi	sp,sp,-112
 a84:	f406                	sd	ra,40(sp)
 a86:	f022                	sd	s0,32(sp)
 a88:	1800                	addi	s0,sp,48
 a8a:	fca43c23          	sd	a0,-40(s0)
 a8e:	e40c                	sd	a1,8(s0)
 a90:	e810                	sd	a2,16(s0)
 a92:	ec14                	sd	a3,24(s0)
 a94:	f018                	sd	a4,32(s0)
 a96:	f41c                	sd	a5,40(s0)
 a98:	03043823          	sd	a6,48(s0)
 a9c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 aa0:	04040793          	addi	a5,s0,64
 aa4:	fcf43823          	sd	a5,-48(s0)
 aa8:	fd043783          	ld	a5,-48(s0)
 aac:	fc878793          	addi	a5,a5,-56
 ab0:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ab4:	fe843783          	ld	a5,-24(s0)
 ab8:	863e                	mv	a2,a5
 aba:	fd843583          	ld	a1,-40(s0)
 abe:	4505                	li	a0,1
 ac0:	00000097          	auipc	ra,0x0
 ac4:	d04080e7          	jalr	-764(ra) # 7c4 <vprintf>
}
 ac8:	0001                	nop
 aca:	70a2                	ld	ra,40(sp)
 acc:	7402                	ld	s0,32(sp)
 ace:	6165                	addi	sp,sp,112
 ad0:	8082                	ret

0000000000000ad2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ad2:	7179                	addi	sp,sp,-48
 ad4:	f422                	sd	s0,40(sp)
 ad6:	1800                	addi	s0,sp,48
 ad8:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 adc:	fd843783          	ld	a5,-40(s0)
 ae0:	17c1                	addi	a5,a5,-16
 ae2:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae6:	00000797          	auipc	a5,0x0
 aea:	54a78793          	addi	a5,a5,1354 # 1030 <freep>
 aee:	639c                	ld	a5,0(a5)
 af0:	fef43423          	sd	a5,-24(s0)
 af4:	a815                	j	b28 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af6:	fe843783          	ld	a5,-24(s0)
 afa:	639c                	ld	a5,0(a5)
 afc:	fe843703          	ld	a4,-24(s0)
 b00:	00f76f63          	bltu	a4,a5,b1e <free+0x4c>
 b04:	fe043703          	ld	a4,-32(s0)
 b08:	fe843783          	ld	a5,-24(s0)
 b0c:	02e7eb63          	bltu	a5,a4,b42 <free+0x70>
 b10:	fe843783          	ld	a5,-24(s0)
 b14:	639c                	ld	a5,0(a5)
 b16:	fe043703          	ld	a4,-32(s0)
 b1a:	02f76463          	bltu	a4,a5,b42 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b1e:	fe843783          	ld	a5,-24(s0)
 b22:	639c                	ld	a5,0(a5)
 b24:	fef43423          	sd	a5,-24(s0)
 b28:	fe043703          	ld	a4,-32(s0)
 b2c:	fe843783          	ld	a5,-24(s0)
 b30:	fce7f3e3          	bgeu	a5,a4,af6 <free+0x24>
 b34:	fe843783          	ld	a5,-24(s0)
 b38:	639c                	ld	a5,0(a5)
 b3a:	fe043703          	ld	a4,-32(s0)
 b3e:	faf77ce3          	bgeu	a4,a5,af6 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b42:	fe043783          	ld	a5,-32(s0)
 b46:	479c                	lw	a5,8(a5)
 b48:	1782                	slli	a5,a5,0x20
 b4a:	9381                	srli	a5,a5,0x20
 b4c:	0792                	slli	a5,a5,0x4
 b4e:	fe043703          	ld	a4,-32(s0)
 b52:	973e                	add	a4,a4,a5
 b54:	fe843783          	ld	a5,-24(s0)
 b58:	639c                	ld	a5,0(a5)
 b5a:	02f71763          	bne	a4,a5,b88 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b5e:	fe043783          	ld	a5,-32(s0)
 b62:	4798                	lw	a4,8(a5)
 b64:	fe843783          	ld	a5,-24(s0)
 b68:	639c                	ld	a5,0(a5)
 b6a:	479c                	lw	a5,8(a5)
 b6c:	9fb9                	addw	a5,a5,a4
 b6e:	0007871b          	sext.w	a4,a5
 b72:	fe043783          	ld	a5,-32(s0)
 b76:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b78:	fe843783          	ld	a5,-24(s0)
 b7c:	639c                	ld	a5,0(a5)
 b7e:	6398                	ld	a4,0(a5)
 b80:	fe043783          	ld	a5,-32(s0)
 b84:	e398                	sd	a4,0(a5)
 b86:	a039                	j	b94 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	6398                	ld	a4,0(a5)
 b8e:	fe043783          	ld	a5,-32(s0)
 b92:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b94:	fe843783          	ld	a5,-24(s0)
 b98:	479c                	lw	a5,8(a5)
 b9a:	1782                	slli	a5,a5,0x20
 b9c:	9381                	srli	a5,a5,0x20
 b9e:	0792                	slli	a5,a5,0x4
 ba0:	fe843703          	ld	a4,-24(s0)
 ba4:	97ba                	add	a5,a5,a4
 ba6:	fe043703          	ld	a4,-32(s0)
 baa:	02f71563          	bne	a4,a5,bd4 <free+0x102>
    p->s.size += bp->s.size;
 bae:	fe843783          	ld	a5,-24(s0)
 bb2:	4798                	lw	a4,8(a5)
 bb4:	fe043783          	ld	a5,-32(s0)
 bb8:	479c                	lw	a5,8(a5)
 bba:	9fb9                	addw	a5,a5,a4
 bbc:	0007871b          	sext.w	a4,a5
 bc0:	fe843783          	ld	a5,-24(s0)
 bc4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bc6:	fe043783          	ld	a5,-32(s0)
 bca:	6398                	ld	a4,0(a5)
 bcc:	fe843783          	ld	a5,-24(s0)
 bd0:	e398                	sd	a4,0(a5)
 bd2:	a031                	j	bde <free+0x10c>
  } else
    p->s.ptr = bp;
 bd4:	fe843783          	ld	a5,-24(s0)
 bd8:	fe043703          	ld	a4,-32(s0)
 bdc:	e398                	sd	a4,0(a5)
  freep = p;
 bde:	00000797          	auipc	a5,0x0
 be2:	45278793          	addi	a5,a5,1106 # 1030 <freep>
 be6:	fe843703          	ld	a4,-24(s0)
 bea:	e398                	sd	a4,0(a5)
}
 bec:	0001                	nop
 bee:	7422                	ld	s0,40(sp)
 bf0:	6145                	addi	sp,sp,48
 bf2:	8082                	ret

0000000000000bf4 <morecore>:

static Header*
morecore(uint nu)
{
 bf4:	7179                	addi	sp,sp,-48
 bf6:	f406                	sd	ra,40(sp)
 bf8:	f022                	sd	s0,32(sp)
 bfa:	1800                	addi	s0,sp,48
 bfc:	87aa                	mv	a5,a0
 bfe:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c02:	fdc42783          	lw	a5,-36(s0)
 c06:	0007871b          	sext.w	a4,a5
 c0a:	6785                	lui	a5,0x1
 c0c:	00f77563          	bgeu	a4,a5,c16 <morecore+0x22>
    nu = 4096;
 c10:	6785                	lui	a5,0x1
 c12:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 c16:	fdc42783          	lw	a5,-36(s0)
 c1a:	0047979b          	slliw	a5,a5,0x4
 c1e:	2781                	sext.w	a5,a5
 c20:	2781                	sext.w	a5,a5
 c22:	853e                	mv	a0,a5
 c24:	00000097          	auipc	ra,0x0
 c28:	9b8080e7          	jalr	-1608(ra) # 5dc <sbrk>
 c2c:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c30:	fe843703          	ld	a4,-24(s0)
 c34:	57fd                	li	a5,-1
 c36:	00f71463          	bne	a4,a5,c3e <morecore+0x4a>
    return 0;
 c3a:	4781                	li	a5,0
 c3c:	a03d                	j	c6a <morecore+0x76>
  hp = (Header*)p;
 c3e:	fe843783          	ld	a5,-24(s0)
 c42:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c46:	fe043783          	ld	a5,-32(s0)
 c4a:	fdc42703          	lw	a4,-36(s0)
 c4e:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c50:	fe043783          	ld	a5,-32(s0)
 c54:	07c1                	addi	a5,a5,16
 c56:	853e                	mv	a0,a5
 c58:	00000097          	auipc	ra,0x0
 c5c:	e7a080e7          	jalr	-390(ra) # ad2 <free>
  return freep;
 c60:	00000797          	auipc	a5,0x0
 c64:	3d078793          	addi	a5,a5,976 # 1030 <freep>
 c68:	639c                	ld	a5,0(a5)
}
 c6a:	853e                	mv	a0,a5
 c6c:	70a2                	ld	ra,40(sp)
 c6e:	7402                	ld	s0,32(sp)
 c70:	6145                	addi	sp,sp,48
 c72:	8082                	ret

0000000000000c74 <malloc>:

void*
malloc(uint nbytes)
{
 c74:	7139                	addi	sp,sp,-64
 c76:	fc06                	sd	ra,56(sp)
 c78:	f822                	sd	s0,48(sp)
 c7a:	0080                	addi	s0,sp,64
 c7c:	87aa                	mv	a5,a0
 c7e:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c82:	fcc46783          	lwu	a5,-52(s0)
 c86:	07bd                	addi	a5,a5,15
 c88:	8391                	srli	a5,a5,0x4
 c8a:	2781                	sext.w	a5,a5
 c8c:	2785                	addiw	a5,a5,1
 c8e:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c92:	00000797          	auipc	a5,0x0
 c96:	39e78793          	addi	a5,a5,926 # 1030 <freep>
 c9a:	639c                	ld	a5,0(a5)
 c9c:	fef43023          	sd	a5,-32(s0)
 ca0:	fe043783          	ld	a5,-32(s0)
 ca4:	ef95                	bnez	a5,ce0 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 ca6:	00000797          	auipc	a5,0x0
 caa:	37a78793          	addi	a5,a5,890 # 1020 <base>
 cae:	fef43023          	sd	a5,-32(s0)
 cb2:	00000797          	auipc	a5,0x0
 cb6:	37e78793          	addi	a5,a5,894 # 1030 <freep>
 cba:	fe043703          	ld	a4,-32(s0)
 cbe:	e398                	sd	a4,0(a5)
 cc0:	00000797          	auipc	a5,0x0
 cc4:	37078793          	addi	a5,a5,880 # 1030 <freep>
 cc8:	6398                	ld	a4,0(a5)
 cca:	00000797          	auipc	a5,0x0
 cce:	35678793          	addi	a5,a5,854 # 1020 <base>
 cd2:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cd4:	00000797          	auipc	a5,0x0
 cd8:	34c78793          	addi	a5,a5,844 # 1020 <base>
 cdc:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ce0:	fe043783          	ld	a5,-32(s0)
 ce4:	639c                	ld	a5,0(a5)
 ce6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cea:	fe843783          	ld	a5,-24(s0)
 cee:	4798                	lw	a4,8(a5)
 cf0:	fdc42783          	lw	a5,-36(s0)
 cf4:	2781                	sext.w	a5,a5
 cf6:	06f76863          	bltu	a4,a5,d66 <malloc+0xf2>
      if(p->s.size == nunits)
 cfa:	fe843783          	ld	a5,-24(s0)
 cfe:	4798                	lw	a4,8(a5)
 d00:	fdc42783          	lw	a5,-36(s0)
 d04:	2781                	sext.w	a5,a5
 d06:	00e79963          	bne	a5,a4,d18 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d0a:	fe843783          	ld	a5,-24(s0)
 d0e:	6398                	ld	a4,0(a5)
 d10:	fe043783          	ld	a5,-32(s0)
 d14:	e398                	sd	a4,0(a5)
 d16:	a82d                	j	d50 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 d18:	fe843783          	ld	a5,-24(s0)
 d1c:	4798                	lw	a4,8(a5)
 d1e:	fdc42783          	lw	a5,-36(s0)
 d22:	40f707bb          	subw	a5,a4,a5
 d26:	0007871b          	sext.w	a4,a5
 d2a:	fe843783          	ld	a5,-24(s0)
 d2e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d30:	fe843783          	ld	a5,-24(s0)
 d34:	479c                	lw	a5,8(a5)
 d36:	1782                	slli	a5,a5,0x20
 d38:	9381                	srli	a5,a5,0x20
 d3a:	0792                	slli	a5,a5,0x4
 d3c:	fe843703          	ld	a4,-24(s0)
 d40:	97ba                	add	a5,a5,a4
 d42:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	fdc42703          	lw	a4,-36(s0)
 d4e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d50:	00000797          	auipc	a5,0x0
 d54:	2e078793          	addi	a5,a5,736 # 1030 <freep>
 d58:	fe043703          	ld	a4,-32(s0)
 d5c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	07c1                	addi	a5,a5,16
 d64:	a091                	j	da8 <malloc+0x134>
    }
    if(p == freep)
 d66:	00000797          	auipc	a5,0x0
 d6a:	2ca78793          	addi	a5,a5,714 # 1030 <freep>
 d6e:	639c                	ld	a5,0(a5)
 d70:	fe843703          	ld	a4,-24(s0)
 d74:	02f71063          	bne	a4,a5,d94 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d78:	fdc42783          	lw	a5,-36(s0)
 d7c:	853e                	mv	a0,a5
 d7e:	00000097          	auipc	ra,0x0
 d82:	e76080e7          	jalr	-394(ra) # bf4 <morecore>
 d86:	fea43423          	sd	a0,-24(s0)
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	e399                	bnez	a5,d94 <malloc+0x120>
        return 0;
 d90:	4781                	li	a5,0
 d92:	a819                	j	da8 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d94:	fe843783          	ld	a5,-24(s0)
 d98:	fef43023          	sd	a5,-32(s0)
 d9c:	fe843783          	ld	a5,-24(s0)
 da0:	639c                	ld	a5,0(a5)
 da2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 da6:	b791                	j	cea <malloc+0x76>
  }
}
 da8:	853e                	mv	a0,a5
 daa:	70e2                	ld	ra,56(sp)
 dac:	7442                	ld	s0,48(sp)
 dae:	6121                	addi	sp,sp,64
 db0:	8082                	ret
