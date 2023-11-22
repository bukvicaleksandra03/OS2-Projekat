
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	87aa                	mv	a5,a0
   a:	feb43023          	sd	a1,-32(s0)
   e:	fef42623          	sw	a5,-20(s0)
  if(argc != 3){
  12:	fec42783          	lw	a5,-20(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	478d                	li	a5,3
  1c:	02f70063          	beq	a4,a5,3c <main+0x3c>
    fprintf(2, "Usage: ln old new\n");
  20:	00001597          	auipc	a1,0x1
  24:	d8058593          	addi	a1,a1,-640 # da0 <malloc+0x148>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9e4080e7          	jalr	-1564(ra) # a0e <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	504080e7          	jalr	1284(ra) # 538 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  3c:	fe043783          	ld	a5,-32(s0)
  40:	07a1                	addi	a5,a5,8
  42:	6398                	ld	a4,0(a5)
  44:	fe043783          	ld	a5,-32(s0)
  48:	07c1                	addi	a5,a5,16
  4a:	639c                	ld	a5,0(a5)
  4c:	85be                	mv	a1,a5
  4e:	853a                	mv	a0,a4
  50:	00000097          	auipc	ra,0x0
  54:	548080e7          	jalr	1352(ra) # 598 <link>
  58:	87aa                	mv	a5,a0
  5a:	0207d563          	bgez	a5,84 <main+0x84>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  5e:	fe043783          	ld	a5,-32(s0)
  62:	07a1                	addi	a5,a5,8
  64:	6398                	ld	a4,0(a5)
  66:	fe043783          	ld	a5,-32(s0)
  6a:	07c1                	addi	a5,a5,16
  6c:	639c                	ld	a5,0(a5)
  6e:	86be                	mv	a3,a5
  70:	863a                	mv	a2,a4
  72:	00001597          	auipc	a1,0x1
  76:	d4658593          	addi	a1,a1,-698 # db8 <malloc+0x160>
  7a:	4509                	li	a0,2
  7c:	00001097          	auipc	ra,0x1
  80:	992080e7          	jalr	-1646(ra) # a0e <fprintf>
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	4b2080e7          	jalr	1202(ra) # 538 <exit>

000000000000008e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  8e:	1141                	addi	sp,sp,-16
  90:	e406                	sd	ra,8(sp)
  92:	e022                	sd	s0,0(sp)
  94:	0800                	addi	s0,sp,16
  extern int main();
  main();
  96:	00000097          	auipc	ra,0x0
  9a:	f6a080e7          	jalr	-150(ra) # 0 <main>
  exit(0);
  9e:	4501                	li	a0,0
  a0:	00000097          	auipc	ra,0x0
  a4:	498080e7          	jalr	1176(ra) # 538 <exit>

00000000000000a8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  a8:	7179                	addi	sp,sp,-48
  aa:	f422                	sd	s0,40(sp)
  ac:	1800                	addi	s0,sp,48
  ae:	fca43c23          	sd	a0,-40(s0)
  b2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  b6:	fd843783          	ld	a5,-40(s0)
  ba:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  be:	0001                	nop
  c0:	fd043703          	ld	a4,-48(s0)
  c4:	00170793          	addi	a5,a4,1
  c8:	fcf43823          	sd	a5,-48(s0)
  cc:	fd843783          	ld	a5,-40(s0)
  d0:	00178693          	addi	a3,a5,1
  d4:	fcd43c23          	sd	a3,-40(s0)
  d8:	00074703          	lbu	a4,0(a4)
  dc:	00e78023          	sb	a4,0(a5)
  e0:	0007c783          	lbu	a5,0(a5)
  e4:	fff1                	bnez	a5,c0 <strcpy+0x18>
    ;
  return os;
  e6:	fe843783          	ld	a5,-24(s0)
}
  ea:	853e                	mv	a0,a5
  ec:	7422                	ld	s0,40(sp)
  ee:	6145                	addi	sp,sp,48
  f0:	8082                	ret

00000000000000f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f2:	1101                	addi	sp,sp,-32
  f4:	ec22                	sd	s0,24(sp)
  f6:	1000                	addi	s0,sp,32
  f8:	fea43423          	sd	a0,-24(s0)
  fc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 100:	a819                	j	116 <strcmp+0x24>
    p++, q++;
 102:	fe843783          	ld	a5,-24(s0)
 106:	0785                	addi	a5,a5,1
 108:	fef43423          	sd	a5,-24(s0)
 10c:	fe043783          	ld	a5,-32(s0)
 110:	0785                	addi	a5,a5,1
 112:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 116:	fe843783          	ld	a5,-24(s0)
 11a:	0007c783          	lbu	a5,0(a5)
 11e:	cb99                	beqz	a5,134 <strcmp+0x42>
 120:	fe843783          	ld	a5,-24(s0)
 124:	0007c703          	lbu	a4,0(a5)
 128:	fe043783          	ld	a5,-32(s0)
 12c:	0007c783          	lbu	a5,0(a5)
 130:	fcf709e3          	beq	a4,a5,102 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 134:	fe843783          	ld	a5,-24(s0)
 138:	0007c783          	lbu	a5,0(a5)
 13c:	0007871b          	sext.w	a4,a5
 140:	fe043783          	ld	a5,-32(s0)
 144:	0007c783          	lbu	a5,0(a5)
 148:	2781                	sext.w	a5,a5
 14a:	40f707bb          	subw	a5,a4,a5
 14e:	2781                	sext.w	a5,a5
}
 150:	853e                	mv	a0,a5
 152:	6462                	ld	s0,24(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret

0000000000000158 <strlen>:

uint
strlen(const char *s)
{
 158:	7179                	addi	sp,sp,-48
 15a:	f422                	sd	s0,40(sp)
 15c:	1800                	addi	s0,sp,48
 15e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 162:	fe042623          	sw	zero,-20(s0)
 166:	a031                	j	172 <strlen+0x1a>
 168:	fec42783          	lw	a5,-20(s0)
 16c:	2785                	addiw	a5,a5,1
 16e:	fef42623          	sw	a5,-20(s0)
 172:	fec42783          	lw	a5,-20(s0)
 176:	fd843703          	ld	a4,-40(s0)
 17a:	97ba                	add	a5,a5,a4
 17c:	0007c783          	lbu	a5,0(a5)
 180:	f7e5                	bnez	a5,168 <strlen+0x10>
    ;
  return n;
 182:	fec42783          	lw	a5,-20(s0)
}
 186:	853e                	mv	a0,a5
 188:	7422                	ld	s0,40(sp)
 18a:	6145                	addi	sp,sp,48
 18c:	8082                	ret

000000000000018e <memset>:

void*
memset(void *dst, int c, uint n)
{
 18e:	7179                	addi	sp,sp,-48
 190:	f422                	sd	s0,40(sp)
 192:	1800                	addi	s0,sp,48
 194:	fca43c23          	sd	a0,-40(s0)
 198:	87ae                	mv	a5,a1
 19a:	8732                	mv	a4,a2
 19c:	fcf42a23          	sw	a5,-44(s0)
 1a0:	87ba                	mv	a5,a4
 1a2:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1a6:	fd843783          	ld	a5,-40(s0)
 1aa:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1ae:	fe042623          	sw	zero,-20(s0)
 1b2:	a00d                	j	1d4 <memset+0x46>
    cdst[i] = c;
 1b4:	fec42783          	lw	a5,-20(s0)
 1b8:	fe043703          	ld	a4,-32(s0)
 1bc:	97ba                	add	a5,a5,a4
 1be:	fd442703          	lw	a4,-44(s0)
 1c2:	0ff77713          	andi	a4,a4,255
 1c6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1ca:	fec42783          	lw	a5,-20(s0)
 1ce:	2785                	addiw	a5,a5,1
 1d0:	fef42623          	sw	a5,-20(s0)
 1d4:	fec42703          	lw	a4,-20(s0)
 1d8:	fd042783          	lw	a5,-48(s0)
 1dc:	2781                	sext.w	a5,a5
 1de:	fcf76be3          	bltu	a4,a5,1b4 <memset+0x26>
  }
  return dst;
 1e2:	fd843783          	ld	a5,-40(s0)
}
 1e6:	853e                	mv	a0,a5
 1e8:	7422                	ld	s0,40(sp)
 1ea:	6145                	addi	sp,sp,48
 1ec:	8082                	ret

00000000000001ee <strchr>:

char*
strchr(const char *s, char c)
{
 1ee:	1101                	addi	sp,sp,-32
 1f0:	ec22                	sd	s0,24(sp)
 1f2:	1000                	addi	s0,sp,32
 1f4:	fea43423          	sd	a0,-24(s0)
 1f8:	87ae                	mv	a5,a1
 1fa:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1fe:	a01d                	j	224 <strchr+0x36>
    if(*s == c)
 200:	fe843783          	ld	a5,-24(s0)
 204:	0007c703          	lbu	a4,0(a5)
 208:	fe744783          	lbu	a5,-25(s0)
 20c:	0ff7f793          	andi	a5,a5,255
 210:	00e79563          	bne	a5,a4,21a <strchr+0x2c>
      return (char*)s;
 214:	fe843783          	ld	a5,-24(s0)
 218:	a821                	j	230 <strchr+0x42>
  for(; *s; s++)
 21a:	fe843783          	ld	a5,-24(s0)
 21e:	0785                	addi	a5,a5,1
 220:	fef43423          	sd	a5,-24(s0)
 224:	fe843783          	ld	a5,-24(s0)
 228:	0007c783          	lbu	a5,0(a5)
 22c:	fbf1                	bnez	a5,200 <strchr+0x12>
  return 0;
 22e:	4781                	li	a5,0
}
 230:	853e                	mv	a0,a5
 232:	6462                	ld	s0,24(sp)
 234:	6105                	addi	sp,sp,32
 236:	8082                	ret

0000000000000238 <gets>:

char*
gets(char *buf, int max)
{
 238:	7179                	addi	sp,sp,-48
 23a:	f406                	sd	ra,40(sp)
 23c:	f022                	sd	s0,32(sp)
 23e:	1800                	addi	s0,sp,48
 240:	fca43c23          	sd	a0,-40(s0)
 244:	87ae                	mv	a5,a1
 246:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24a:	fe042623          	sw	zero,-20(s0)
 24e:	a8a1                	j	2a6 <gets+0x6e>
    cc = read(0, &c, 1);
 250:	fe740793          	addi	a5,s0,-25
 254:	4605                	li	a2,1
 256:	85be                	mv	a1,a5
 258:	4501                	li	a0,0
 25a:	00000097          	auipc	ra,0x0
 25e:	2f6080e7          	jalr	758(ra) # 550 <read>
 262:	87aa                	mv	a5,a0
 264:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 268:	fe842783          	lw	a5,-24(s0)
 26c:	2781                	sext.w	a5,a5
 26e:	04f05763          	blez	a5,2bc <gets+0x84>
      break;
    buf[i++] = c;
 272:	fec42783          	lw	a5,-20(s0)
 276:	0017871b          	addiw	a4,a5,1
 27a:	fee42623          	sw	a4,-20(s0)
 27e:	873e                	mv	a4,a5
 280:	fd843783          	ld	a5,-40(s0)
 284:	97ba                	add	a5,a5,a4
 286:	fe744703          	lbu	a4,-25(s0)
 28a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 28e:	fe744783          	lbu	a5,-25(s0)
 292:	873e                	mv	a4,a5
 294:	47a9                	li	a5,10
 296:	02f70463          	beq	a4,a5,2be <gets+0x86>
 29a:	fe744783          	lbu	a5,-25(s0)
 29e:	873e                	mv	a4,a5
 2a0:	47b5                	li	a5,13
 2a2:	00f70e63          	beq	a4,a5,2be <gets+0x86>
  for(i=0; i+1 < max; ){
 2a6:	fec42783          	lw	a5,-20(s0)
 2aa:	2785                	addiw	a5,a5,1
 2ac:	0007871b          	sext.w	a4,a5
 2b0:	fd442783          	lw	a5,-44(s0)
 2b4:	2781                	sext.w	a5,a5
 2b6:	f8f74de3          	blt	a4,a5,250 <gets+0x18>
 2ba:	a011                	j	2be <gets+0x86>
      break;
 2bc:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2be:	fec42783          	lw	a5,-20(s0)
 2c2:	fd843703          	ld	a4,-40(s0)
 2c6:	97ba                	add	a5,a5,a4
 2c8:	00078023          	sb	zero,0(a5)
  return buf;
 2cc:	fd843783          	ld	a5,-40(s0)
}
 2d0:	853e                	mv	a0,a5
 2d2:	70a2                	ld	ra,40(sp)
 2d4:	7402                	ld	s0,32(sp)
 2d6:	6145                	addi	sp,sp,48
 2d8:	8082                	ret

00000000000002da <stat>:

int
stat(const char *n, struct stat *st)
{
 2da:	7179                	addi	sp,sp,-48
 2dc:	f406                	sd	ra,40(sp)
 2de:	f022                	sd	s0,32(sp)
 2e0:	1800                	addi	s0,sp,48
 2e2:	fca43c23          	sd	a0,-40(s0)
 2e6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ea:	4581                	li	a1,0
 2ec:	fd843503          	ld	a0,-40(s0)
 2f0:	00000097          	auipc	ra,0x0
 2f4:	288080e7          	jalr	648(ra) # 578 <open>
 2f8:	87aa                	mv	a5,a0
 2fa:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2fe:	fec42783          	lw	a5,-20(s0)
 302:	2781                	sext.w	a5,a5
 304:	0007d463          	bgez	a5,30c <stat+0x32>
    return -1;
 308:	57fd                	li	a5,-1
 30a:	a035                	j	336 <stat+0x5c>
  r = fstat(fd, st);
 30c:	fec42783          	lw	a5,-20(s0)
 310:	fd043583          	ld	a1,-48(s0)
 314:	853e                	mv	a0,a5
 316:	00000097          	auipc	ra,0x0
 31a:	27a080e7          	jalr	634(ra) # 590 <fstat>
 31e:	87aa                	mv	a5,a0
 320:	fef42423          	sw	a5,-24(s0)
  close(fd);
 324:	fec42783          	lw	a5,-20(s0)
 328:	853e                	mv	a0,a5
 32a:	00000097          	auipc	ra,0x0
 32e:	236080e7          	jalr	566(ra) # 560 <close>
  return r;
 332:	fe842783          	lw	a5,-24(s0)
}
 336:	853e                	mv	a0,a5
 338:	70a2                	ld	ra,40(sp)
 33a:	7402                	ld	s0,32(sp)
 33c:	6145                	addi	sp,sp,48
 33e:	8082                	ret

0000000000000340 <atoi>:

int
atoi(const char *s)
{
 340:	7179                	addi	sp,sp,-48
 342:	f422                	sd	s0,40(sp)
 344:	1800                	addi	s0,sp,48
 346:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 34a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 34e:	a815                	j	382 <atoi+0x42>
    n = n*10 + *s++ - '0';
 350:	fec42703          	lw	a4,-20(s0)
 354:	87ba                	mv	a5,a4
 356:	0027979b          	slliw	a5,a5,0x2
 35a:	9fb9                	addw	a5,a5,a4
 35c:	0017979b          	slliw	a5,a5,0x1
 360:	0007871b          	sext.w	a4,a5
 364:	fd843783          	ld	a5,-40(s0)
 368:	00178693          	addi	a3,a5,1
 36c:	fcd43c23          	sd	a3,-40(s0)
 370:	0007c783          	lbu	a5,0(a5)
 374:	2781                	sext.w	a5,a5
 376:	9fb9                	addw	a5,a5,a4
 378:	2781                	sext.w	a5,a5
 37a:	fd07879b          	addiw	a5,a5,-48
 37e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 382:	fd843783          	ld	a5,-40(s0)
 386:	0007c783          	lbu	a5,0(a5)
 38a:	873e                	mv	a4,a5
 38c:	02f00793          	li	a5,47
 390:	00e7fb63          	bgeu	a5,a4,3a6 <atoi+0x66>
 394:	fd843783          	ld	a5,-40(s0)
 398:	0007c783          	lbu	a5,0(a5)
 39c:	873e                	mv	a4,a5
 39e:	03900793          	li	a5,57
 3a2:	fae7f7e3          	bgeu	a5,a4,350 <atoi+0x10>
  return n;
 3a6:	fec42783          	lw	a5,-20(s0)
}
 3aa:	853e                	mv	a0,a5
 3ac:	7422                	ld	s0,40(sp)
 3ae:	6145                	addi	sp,sp,48
 3b0:	8082                	ret

00000000000003b2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b2:	7139                	addi	sp,sp,-64
 3b4:	fc22                	sd	s0,56(sp)
 3b6:	0080                	addi	s0,sp,64
 3b8:	fca43c23          	sd	a0,-40(s0)
 3bc:	fcb43823          	sd	a1,-48(s0)
 3c0:	87b2                	mv	a5,a2
 3c2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3c6:	fd843783          	ld	a5,-40(s0)
 3ca:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3ce:	fd043783          	ld	a5,-48(s0)
 3d2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3d6:	fe043703          	ld	a4,-32(s0)
 3da:	fe843783          	ld	a5,-24(s0)
 3de:	02e7fc63          	bgeu	a5,a4,416 <memmove+0x64>
    while(n-- > 0)
 3e2:	a00d                	j	404 <memmove+0x52>
      *dst++ = *src++;
 3e4:	fe043703          	ld	a4,-32(s0)
 3e8:	00170793          	addi	a5,a4,1
 3ec:	fef43023          	sd	a5,-32(s0)
 3f0:	fe843783          	ld	a5,-24(s0)
 3f4:	00178693          	addi	a3,a5,1
 3f8:	fed43423          	sd	a3,-24(s0)
 3fc:	00074703          	lbu	a4,0(a4)
 400:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 404:	fcc42783          	lw	a5,-52(s0)
 408:	fff7871b          	addiw	a4,a5,-1
 40c:	fce42623          	sw	a4,-52(s0)
 410:	fcf04ae3          	bgtz	a5,3e4 <memmove+0x32>
 414:	a891                	j	468 <memmove+0xb6>
  } else {
    dst += n;
 416:	fcc42783          	lw	a5,-52(s0)
 41a:	fe843703          	ld	a4,-24(s0)
 41e:	97ba                	add	a5,a5,a4
 420:	fef43423          	sd	a5,-24(s0)
    src += n;
 424:	fcc42783          	lw	a5,-52(s0)
 428:	fe043703          	ld	a4,-32(s0)
 42c:	97ba                	add	a5,a5,a4
 42e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 432:	a01d                	j	458 <memmove+0xa6>
      *--dst = *--src;
 434:	fe043783          	ld	a5,-32(s0)
 438:	17fd                	addi	a5,a5,-1
 43a:	fef43023          	sd	a5,-32(s0)
 43e:	fe843783          	ld	a5,-24(s0)
 442:	17fd                	addi	a5,a5,-1
 444:	fef43423          	sd	a5,-24(s0)
 448:	fe043783          	ld	a5,-32(s0)
 44c:	0007c703          	lbu	a4,0(a5)
 450:	fe843783          	ld	a5,-24(s0)
 454:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 458:	fcc42783          	lw	a5,-52(s0)
 45c:	fff7871b          	addiw	a4,a5,-1
 460:	fce42623          	sw	a4,-52(s0)
 464:	fcf048e3          	bgtz	a5,434 <memmove+0x82>
  }
  return vdst;
 468:	fd843783          	ld	a5,-40(s0)
}
 46c:	853e                	mv	a0,a5
 46e:	7462                	ld	s0,56(sp)
 470:	6121                	addi	sp,sp,64
 472:	8082                	ret

0000000000000474 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 474:	7139                	addi	sp,sp,-64
 476:	fc22                	sd	s0,56(sp)
 478:	0080                	addi	s0,sp,64
 47a:	fca43c23          	sd	a0,-40(s0)
 47e:	fcb43823          	sd	a1,-48(s0)
 482:	87b2                	mv	a5,a2
 484:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 488:	fd843783          	ld	a5,-40(s0)
 48c:	fef43423          	sd	a5,-24(s0)
 490:	fd043783          	ld	a5,-48(s0)
 494:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 498:	a0a1                	j	4e0 <memcmp+0x6c>
    if (*p1 != *p2) {
 49a:	fe843783          	ld	a5,-24(s0)
 49e:	0007c703          	lbu	a4,0(a5)
 4a2:	fe043783          	ld	a5,-32(s0)
 4a6:	0007c783          	lbu	a5,0(a5)
 4aa:	02f70163          	beq	a4,a5,4cc <memcmp+0x58>
      return *p1 - *p2;
 4ae:	fe843783          	ld	a5,-24(s0)
 4b2:	0007c783          	lbu	a5,0(a5)
 4b6:	0007871b          	sext.w	a4,a5
 4ba:	fe043783          	ld	a5,-32(s0)
 4be:	0007c783          	lbu	a5,0(a5)
 4c2:	2781                	sext.w	a5,a5
 4c4:	40f707bb          	subw	a5,a4,a5
 4c8:	2781                	sext.w	a5,a5
 4ca:	a01d                	j	4f0 <memcmp+0x7c>
    }
    p1++;
 4cc:	fe843783          	ld	a5,-24(s0)
 4d0:	0785                	addi	a5,a5,1
 4d2:	fef43423          	sd	a5,-24(s0)
    p2++;
 4d6:	fe043783          	ld	a5,-32(s0)
 4da:	0785                	addi	a5,a5,1
 4dc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4e0:	fcc42783          	lw	a5,-52(s0)
 4e4:	fff7871b          	addiw	a4,a5,-1
 4e8:	fce42623          	sw	a4,-52(s0)
 4ec:	f7dd                	bnez	a5,49a <memcmp+0x26>
  }
  return 0;
 4ee:	4781                	li	a5,0
}
 4f0:	853e                	mv	a0,a5
 4f2:	7462                	ld	s0,56(sp)
 4f4:	6121                	addi	sp,sp,64
 4f6:	8082                	ret

00000000000004f8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4f8:	7179                	addi	sp,sp,-48
 4fa:	f406                	sd	ra,40(sp)
 4fc:	f022                	sd	s0,32(sp)
 4fe:	1800                	addi	s0,sp,48
 500:	fea43423          	sd	a0,-24(s0)
 504:	feb43023          	sd	a1,-32(s0)
 508:	87b2                	mv	a5,a2
 50a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 50e:	fdc42783          	lw	a5,-36(s0)
 512:	863e                	mv	a2,a5
 514:	fe043583          	ld	a1,-32(s0)
 518:	fe843503          	ld	a0,-24(s0)
 51c:	00000097          	auipc	ra,0x0
 520:	e96080e7          	jalr	-362(ra) # 3b2 <memmove>
 524:	87aa                	mv	a5,a0
}
 526:	853e                	mv	a0,a5
 528:	70a2                	ld	ra,40(sp)
 52a:	7402                	ld	s0,32(sp)
 52c:	6145                	addi	sp,sp,48
 52e:	8082                	ret

0000000000000530 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 530:	4885                	li	a7,1
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <exit>:
.global exit
exit:
 li a7, SYS_exit
 538:	4889                	li	a7,2
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <wait>:
.global wait
wait:
 li a7, SYS_wait
 540:	488d                	li	a7,3
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 548:	4891                	li	a7,4
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <read>:
.global read
read:
 li a7, SYS_read
 550:	4895                	li	a7,5
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <write>:
.global write
write:
 li a7, SYS_write
 558:	48c1                	li	a7,16
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <close>:
.global close
close:
 li a7, SYS_close
 560:	48d5                	li	a7,21
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <kill>:
.global kill
kill:
 li a7, SYS_kill
 568:	4899                	li	a7,6
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <exec>:
.global exec
exec:
 li a7, SYS_exec
 570:	489d                	li	a7,7
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <open>:
.global open
open:
 li a7, SYS_open
 578:	48bd                	li	a7,15
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 580:	48c5                	li	a7,17
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 588:	48c9                	li	a7,18
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 590:	48a1                	li	a7,8
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <link>:
.global link
link:
 li a7, SYS_link
 598:	48cd                	li	a7,19
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a0:	48d1                	li	a7,20
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a8:	48a5                	li	a7,9
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b0:	48a9                	li	a7,10
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b8:	48ad                	li	a7,11
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c0:	48b1                	li	a7,12
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c8:	48b5                	li	a7,13
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d0:	48b9                	li	a7,14
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d8:	1101                	addi	sp,sp,-32
 5da:	ec06                	sd	ra,24(sp)
 5dc:	e822                	sd	s0,16(sp)
 5de:	1000                	addi	s0,sp,32
 5e0:	87aa                	mv	a5,a0
 5e2:	872e                	mv	a4,a1
 5e4:	fef42623          	sw	a5,-20(s0)
 5e8:	87ba                	mv	a5,a4
 5ea:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5ee:	feb40713          	addi	a4,s0,-21
 5f2:	fec42783          	lw	a5,-20(s0)
 5f6:	4605                	li	a2,1
 5f8:	85ba                	mv	a1,a4
 5fa:	853e                	mv	a0,a5
 5fc:	00000097          	auipc	ra,0x0
 600:	f5c080e7          	jalr	-164(ra) # 558 <write>
}
 604:	0001                	nop
 606:	60e2                	ld	ra,24(sp)
 608:	6442                	ld	s0,16(sp)
 60a:	6105                	addi	sp,sp,32
 60c:	8082                	ret

000000000000060e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 60e:	7139                	addi	sp,sp,-64
 610:	fc06                	sd	ra,56(sp)
 612:	f822                	sd	s0,48(sp)
 614:	0080                	addi	s0,sp,64
 616:	87aa                	mv	a5,a0
 618:	8736                	mv	a4,a3
 61a:	fcf42623          	sw	a5,-52(s0)
 61e:	87ae                	mv	a5,a1
 620:	fcf42423          	sw	a5,-56(s0)
 624:	87b2                	mv	a5,a2
 626:	fcf42223          	sw	a5,-60(s0)
 62a:	87ba                	mv	a5,a4
 62c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 630:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 634:	fc042783          	lw	a5,-64(s0)
 638:	2781                	sext.w	a5,a5
 63a:	c38d                	beqz	a5,65c <printint+0x4e>
 63c:	fc842783          	lw	a5,-56(s0)
 640:	2781                	sext.w	a5,a5
 642:	0007dd63          	bgez	a5,65c <printint+0x4e>
    neg = 1;
 646:	4785                	li	a5,1
 648:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 64c:	fc842783          	lw	a5,-56(s0)
 650:	40f007bb          	negw	a5,a5
 654:	2781                	sext.w	a5,a5
 656:	fef42223          	sw	a5,-28(s0)
 65a:	a029                	j	664 <printint+0x56>
  } else {
    x = xx;
 65c:	fc842783          	lw	a5,-56(s0)
 660:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 664:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 668:	fc442783          	lw	a5,-60(s0)
 66c:	fe442703          	lw	a4,-28(s0)
 670:	02f777bb          	remuw	a5,a4,a5
 674:	0007861b          	sext.w	a2,a5
 678:	fec42783          	lw	a5,-20(s0)
 67c:	0017871b          	addiw	a4,a5,1
 680:	fee42623          	sw	a4,-20(s0)
 684:	00001697          	auipc	a3,0x1
 688:	97c68693          	addi	a3,a3,-1668 # 1000 <digits>
 68c:	02061713          	slli	a4,a2,0x20
 690:	9301                	srli	a4,a4,0x20
 692:	9736                	add	a4,a4,a3
 694:	00074703          	lbu	a4,0(a4)
 698:	ff040693          	addi	a3,s0,-16
 69c:	97b6                	add	a5,a5,a3
 69e:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 6a2:	fc442783          	lw	a5,-60(s0)
 6a6:	fe442703          	lw	a4,-28(s0)
 6aa:	02f757bb          	divuw	a5,a4,a5
 6ae:	fef42223          	sw	a5,-28(s0)
 6b2:	fe442783          	lw	a5,-28(s0)
 6b6:	2781                	sext.w	a5,a5
 6b8:	fbc5                	bnez	a5,668 <printint+0x5a>
  if(neg)
 6ba:	fe842783          	lw	a5,-24(s0)
 6be:	2781                	sext.w	a5,a5
 6c0:	cf95                	beqz	a5,6fc <printint+0xee>
    buf[i++] = '-';
 6c2:	fec42783          	lw	a5,-20(s0)
 6c6:	0017871b          	addiw	a4,a5,1
 6ca:	fee42623          	sw	a4,-20(s0)
 6ce:	ff040713          	addi	a4,s0,-16
 6d2:	97ba                	add	a5,a5,a4
 6d4:	02d00713          	li	a4,45
 6d8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6dc:	a005                	j	6fc <printint+0xee>
    putc(fd, buf[i]);
 6de:	fec42783          	lw	a5,-20(s0)
 6e2:	ff040713          	addi	a4,s0,-16
 6e6:	97ba                	add	a5,a5,a4
 6e8:	fe07c703          	lbu	a4,-32(a5)
 6ec:	fcc42783          	lw	a5,-52(s0)
 6f0:	85ba                	mv	a1,a4
 6f2:	853e                	mv	a0,a5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	ee4080e7          	jalr	-284(ra) # 5d8 <putc>
  while(--i >= 0)
 6fc:	fec42783          	lw	a5,-20(s0)
 700:	37fd                	addiw	a5,a5,-1
 702:	fef42623          	sw	a5,-20(s0)
 706:	fec42783          	lw	a5,-20(s0)
 70a:	2781                	sext.w	a5,a5
 70c:	fc07d9e3          	bgez	a5,6de <printint+0xd0>
}
 710:	0001                	nop
 712:	0001                	nop
 714:	70e2                	ld	ra,56(sp)
 716:	7442                	ld	s0,48(sp)
 718:	6121                	addi	sp,sp,64
 71a:	8082                	ret

000000000000071c <printptr>:

static void
printptr(int fd, uint64 x) {
 71c:	7179                	addi	sp,sp,-48
 71e:	f406                	sd	ra,40(sp)
 720:	f022                	sd	s0,32(sp)
 722:	1800                	addi	s0,sp,48
 724:	87aa                	mv	a5,a0
 726:	fcb43823          	sd	a1,-48(s0)
 72a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 72e:	fdc42783          	lw	a5,-36(s0)
 732:	03000593          	li	a1,48
 736:	853e                	mv	a0,a5
 738:	00000097          	auipc	ra,0x0
 73c:	ea0080e7          	jalr	-352(ra) # 5d8 <putc>
  putc(fd, 'x');
 740:	fdc42783          	lw	a5,-36(s0)
 744:	07800593          	li	a1,120
 748:	853e                	mv	a0,a5
 74a:	00000097          	auipc	ra,0x0
 74e:	e8e080e7          	jalr	-370(ra) # 5d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 752:	fe042623          	sw	zero,-20(s0)
 756:	a82d                	j	790 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 758:	fd043783          	ld	a5,-48(s0)
 75c:	93f1                	srli	a5,a5,0x3c
 75e:	00001717          	auipc	a4,0x1
 762:	8a270713          	addi	a4,a4,-1886 # 1000 <digits>
 766:	97ba                	add	a5,a5,a4
 768:	0007c703          	lbu	a4,0(a5)
 76c:	fdc42783          	lw	a5,-36(s0)
 770:	85ba                	mv	a1,a4
 772:	853e                	mv	a0,a5
 774:	00000097          	auipc	ra,0x0
 778:	e64080e7          	jalr	-412(ra) # 5d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 77c:	fec42783          	lw	a5,-20(s0)
 780:	2785                	addiw	a5,a5,1
 782:	fef42623          	sw	a5,-20(s0)
 786:	fd043783          	ld	a5,-48(s0)
 78a:	0792                	slli	a5,a5,0x4
 78c:	fcf43823          	sd	a5,-48(s0)
 790:	fec42783          	lw	a5,-20(s0)
 794:	873e                	mv	a4,a5
 796:	47bd                	li	a5,15
 798:	fce7f0e3          	bgeu	a5,a4,758 <printptr+0x3c>
}
 79c:	0001                	nop
 79e:	0001                	nop
 7a0:	70a2                	ld	ra,40(sp)
 7a2:	7402                	ld	s0,32(sp)
 7a4:	6145                	addi	sp,sp,48
 7a6:	8082                	ret

00000000000007a8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7a8:	715d                	addi	sp,sp,-80
 7aa:	e486                	sd	ra,72(sp)
 7ac:	e0a2                	sd	s0,64(sp)
 7ae:	0880                	addi	s0,sp,80
 7b0:	87aa                	mv	a5,a0
 7b2:	fcb43023          	sd	a1,-64(s0)
 7b6:	fac43c23          	sd	a2,-72(s0)
 7ba:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7be:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7c2:	fe042223          	sw	zero,-28(s0)
 7c6:	a42d                	j	9f0 <vprintf+0x248>
    c = fmt[i] & 0xff;
 7c8:	fe442783          	lw	a5,-28(s0)
 7cc:	fc043703          	ld	a4,-64(s0)
 7d0:	97ba                	add	a5,a5,a4
 7d2:	0007c783          	lbu	a5,0(a5)
 7d6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7da:	fe042783          	lw	a5,-32(s0)
 7de:	2781                	sext.w	a5,a5
 7e0:	eb9d                	bnez	a5,816 <vprintf+0x6e>
      if(c == '%'){
 7e2:	fdc42783          	lw	a5,-36(s0)
 7e6:	0007871b          	sext.w	a4,a5
 7ea:	02500793          	li	a5,37
 7ee:	00f71763          	bne	a4,a5,7fc <vprintf+0x54>
        state = '%';
 7f2:	02500793          	li	a5,37
 7f6:	fef42023          	sw	a5,-32(s0)
 7fa:	a2f5                	j	9e6 <vprintf+0x23e>
      } else {
        putc(fd, c);
 7fc:	fdc42783          	lw	a5,-36(s0)
 800:	0ff7f713          	andi	a4,a5,255
 804:	fcc42783          	lw	a5,-52(s0)
 808:	85ba                	mv	a1,a4
 80a:	853e                	mv	a0,a5
 80c:	00000097          	auipc	ra,0x0
 810:	dcc080e7          	jalr	-564(ra) # 5d8 <putc>
 814:	aac9                	j	9e6 <vprintf+0x23e>
      }
    } else if(state == '%'){
 816:	fe042783          	lw	a5,-32(s0)
 81a:	0007871b          	sext.w	a4,a5
 81e:	02500793          	li	a5,37
 822:	1cf71263          	bne	a4,a5,9e6 <vprintf+0x23e>
      if(c == 'd'){
 826:	fdc42783          	lw	a5,-36(s0)
 82a:	0007871b          	sext.w	a4,a5
 82e:	06400793          	li	a5,100
 832:	02f71463          	bne	a4,a5,85a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 836:	fb843783          	ld	a5,-72(s0)
 83a:	00878713          	addi	a4,a5,8
 83e:	fae43c23          	sd	a4,-72(s0)
 842:	4398                	lw	a4,0(a5)
 844:	fcc42783          	lw	a5,-52(s0)
 848:	4685                	li	a3,1
 84a:	4629                	li	a2,10
 84c:	85ba                	mv	a1,a4
 84e:	853e                	mv	a0,a5
 850:	00000097          	auipc	ra,0x0
 854:	dbe080e7          	jalr	-578(ra) # 60e <printint>
 858:	a269                	j	9e2 <vprintf+0x23a>
      } else if(c == 'l') {
 85a:	fdc42783          	lw	a5,-36(s0)
 85e:	0007871b          	sext.w	a4,a5
 862:	06c00793          	li	a5,108
 866:	02f71663          	bne	a4,a5,892 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 86a:	fb843783          	ld	a5,-72(s0)
 86e:	00878713          	addi	a4,a5,8
 872:	fae43c23          	sd	a4,-72(s0)
 876:	639c                	ld	a5,0(a5)
 878:	0007871b          	sext.w	a4,a5
 87c:	fcc42783          	lw	a5,-52(s0)
 880:	4681                	li	a3,0
 882:	4629                	li	a2,10
 884:	85ba                	mv	a1,a4
 886:	853e                	mv	a0,a5
 888:	00000097          	auipc	ra,0x0
 88c:	d86080e7          	jalr	-634(ra) # 60e <printint>
 890:	aa89                	j	9e2 <vprintf+0x23a>
      } else if(c == 'x') {
 892:	fdc42783          	lw	a5,-36(s0)
 896:	0007871b          	sext.w	a4,a5
 89a:	07800793          	li	a5,120
 89e:	02f71463          	bne	a4,a5,8c6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 8a2:	fb843783          	ld	a5,-72(s0)
 8a6:	00878713          	addi	a4,a5,8
 8aa:	fae43c23          	sd	a4,-72(s0)
 8ae:	4398                	lw	a4,0(a5)
 8b0:	fcc42783          	lw	a5,-52(s0)
 8b4:	4681                	li	a3,0
 8b6:	4641                	li	a2,16
 8b8:	85ba                	mv	a1,a4
 8ba:	853e                	mv	a0,a5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	d52080e7          	jalr	-686(ra) # 60e <printint>
 8c4:	aa39                	j	9e2 <vprintf+0x23a>
      } else if(c == 'p') {
 8c6:	fdc42783          	lw	a5,-36(s0)
 8ca:	0007871b          	sext.w	a4,a5
 8ce:	07000793          	li	a5,112
 8d2:	02f71263          	bne	a4,a5,8f6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8d6:	fb843783          	ld	a5,-72(s0)
 8da:	00878713          	addi	a4,a5,8
 8de:	fae43c23          	sd	a4,-72(s0)
 8e2:	6398                	ld	a4,0(a5)
 8e4:	fcc42783          	lw	a5,-52(s0)
 8e8:	85ba                	mv	a1,a4
 8ea:	853e                	mv	a0,a5
 8ec:	00000097          	auipc	ra,0x0
 8f0:	e30080e7          	jalr	-464(ra) # 71c <printptr>
 8f4:	a0fd                	j	9e2 <vprintf+0x23a>
      } else if(c == 's'){
 8f6:	fdc42783          	lw	a5,-36(s0)
 8fa:	0007871b          	sext.w	a4,a5
 8fe:	07300793          	li	a5,115
 902:	04f71c63          	bne	a4,a5,95a <vprintf+0x1b2>
        s = va_arg(ap, char*);
 906:	fb843783          	ld	a5,-72(s0)
 90a:	00878713          	addi	a4,a5,8
 90e:	fae43c23          	sd	a4,-72(s0)
 912:	639c                	ld	a5,0(a5)
 914:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 918:	fe843783          	ld	a5,-24(s0)
 91c:	eb8d                	bnez	a5,94e <vprintf+0x1a6>
          s = "(null)";
 91e:	00000797          	auipc	a5,0x0
 922:	4b278793          	addi	a5,a5,1202 # dd0 <malloc+0x178>
 926:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 92a:	a015                	j	94e <vprintf+0x1a6>
          putc(fd, *s);
 92c:	fe843783          	ld	a5,-24(s0)
 930:	0007c703          	lbu	a4,0(a5)
 934:	fcc42783          	lw	a5,-52(s0)
 938:	85ba                	mv	a1,a4
 93a:	853e                	mv	a0,a5
 93c:	00000097          	auipc	ra,0x0
 940:	c9c080e7          	jalr	-868(ra) # 5d8 <putc>
          s++;
 944:	fe843783          	ld	a5,-24(s0)
 948:	0785                	addi	a5,a5,1
 94a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 94e:	fe843783          	ld	a5,-24(s0)
 952:	0007c783          	lbu	a5,0(a5)
 956:	fbf9                	bnez	a5,92c <vprintf+0x184>
 958:	a069                	j	9e2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 95a:	fdc42783          	lw	a5,-36(s0)
 95e:	0007871b          	sext.w	a4,a5
 962:	06300793          	li	a5,99
 966:	02f71463          	bne	a4,a5,98e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 96a:	fb843783          	ld	a5,-72(s0)
 96e:	00878713          	addi	a4,a5,8
 972:	fae43c23          	sd	a4,-72(s0)
 976:	439c                	lw	a5,0(a5)
 978:	0ff7f713          	andi	a4,a5,255
 97c:	fcc42783          	lw	a5,-52(s0)
 980:	85ba                	mv	a1,a4
 982:	853e                	mv	a0,a5
 984:	00000097          	auipc	ra,0x0
 988:	c54080e7          	jalr	-940(ra) # 5d8 <putc>
 98c:	a899                	j	9e2 <vprintf+0x23a>
      } else if(c == '%'){
 98e:	fdc42783          	lw	a5,-36(s0)
 992:	0007871b          	sext.w	a4,a5
 996:	02500793          	li	a5,37
 99a:	00f71f63          	bne	a4,a5,9b8 <vprintf+0x210>
        putc(fd, c);
 99e:	fdc42783          	lw	a5,-36(s0)
 9a2:	0ff7f713          	andi	a4,a5,255
 9a6:	fcc42783          	lw	a5,-52(s0)
 9aa:	85ba                	mv	a1,a4
 9ac:	853e                	mv	a0,a5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	c2a080e7          	jalr	-982(ra) # 5d8 <putc>
 9b6:	a035                	j	9e2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9b8:	fcc42783          	lw	a5,-52(s0)
 9bc:	02500593          	li	a1,37
 9c0:	853e                	mv	a0,a5
 9c2:	00000097          	auipc	ra,0x0
 9c6:	c16080e7          	jalr	-1002(ra) # 5d8 <putc>
        putc(fd, c);
 9ca:	fdc42783          	lw	a5,-36(s0)
 9ce:	0ff7f713          	andi	a4,a5,255
 9d2:	fcc42783          	lw	a5,-52(s0)
 9d6:	85ba                	mv	a1,a4
 9d8:	853e                	mv	a0,a5
 9da:	00000097          	auipc	ra,0x0
 9de:	bfe080e7          	jalr	-1026(ra) # 5d8 <putc>
      }
      state = 0;
 9e2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9e6:	fe442783          	lw	a5,-28(s0)
 9ea:	2785                	addiw	a5,a5,1
 9ec:	fef42223          	sw	a5,-28(s0)
 9f0:	fe442783          	lw	a5,-28(s0)
 9f4:	fc043703          	ld	a4,-64(s0)
 9f8:	97ba                	add	a5,a5,a4
 9fa:	0007c783          	lbu	a5,0(a5)
 9fe:	dc0795e3          	bnez	a5,7c8 <vprintf+0x20>
    }
  }
}
 a02:	0001                	nop
 a04:	0001                	nop
 a06:	60a6                	ld	ra,72(sp)
 a08:	6406                	ld	s0,64(sp)
 a0a:	6161                	addi	sp,sp,80
 a0c:	8082                	ret

0000000000000a0e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a0e:	7159                	addi	sp,sp,-112
 a10:	fc06                	sd	ra,56(sp)
 a12:	f822                	sd	s0,48(sp)
 a14:	0080                	addi	s0,sp,64
 a16:	fcb43823          	sd	a1,-48(s0)
 a1a:	e010                	sd	a2,0(s0)
 a1c:	e414                	sd	a3,8(s0)
 a1e:	e818                	sd	a4,16(s0)
 a20:	ec1c                	sd	a5,24(s0)
 a22:	03043023          	sd	a6,32(s0)
 a26:	03143423          	sd	a7,40(s0)
 a2a:	87aa                	mv	a5,a0
 a2c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a30:	03040793          	addi	a5,s0,48
 a34:	fcf43423          	sd	a5,-56(s0)
 a38:	fc843783          	ld	a5,-56(s0)
 a3c:	fd078793          	addi	a5,a5,-48
 a40:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a44:	fe843703          	ld	a4,-24(s0)
 a48:	fdc42783          	lw	a5,-36(s0)
 a4c:	863a                	mv	a2,a4
 a4e:	fd043583          	ld	a1,-48(s0)
 a52:	853e                	mv	a0,a5
 a54:	00000097          	auipc	ra,0x0
 a58:	d54080e7          	jalr	-684(ra) # 7a8 <vprintf>
}
 a5c:	0001                	nop
 a5e:	70e2                	ld	ra,56(sp)
 a60:	7442                	ld	s0,48(sp)
 a62:	6165                	addi	sp,sp,112
 a64:	8082                	ret

0000000000000a66 <printf>:

void
printf(const char *fmt, ...)
{
 a66:	7159                	addi	sp,sp,-112
 a68:	f406                	sd	ra,40(sp)
 a6a:	f022                	sd	s0,32(sp)
 a6c:	1800                	addi	s0,sp,48
 a6e:	fca43c23          	sd	a0,-40(s0)
 a72:	e40c                	sd	a1,8(s0)
 a74:	e810                	sd	a2,16(s0)
 a76:	ec14                	sd	a3,24(s0)
 a78:	f018                	sd	a4,32(s0)
 a7a:	f41c                	sd	a5,40(s0)
 a7c:	03043823          	sd	a6,48(s0)
 a80:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a84:	04040793          	addi	a5,s0,64
 a88:	fcf43823          	sd	a5,-48(s0)
 a8c:	fd043783          	ld	a5,-48(s0)
 a90:	fc878793          	addi	a5,a5,-56
 a94:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a98:	fe843783          	ld	a5,-24(s0)
 a9c:	863e                	mv	a2,a5
 a9e:	fd843583          	ld	a1,-40(s0)
 aa2:	4505                	li	a0,1
 aa4:	00000097          	auipc	ra,0x0
 aa8:	d04080e7          	jalr	-764(ra) # 7a8 <vprintf>
}
 aac:	0001                	nop
 aae:	70a2                	ld	ra,40(sp)
 ab0:	7402                	ld	s0,32(sp)
 ab2:	6165                	addi	sp,sp,112
 ab4:	8082                	ret

0000000000000ab6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ab6:	7179                	addi	sp,sp,-48
 ab8:	f422                	sd	s0,40(sp)
 aba:	1800                	addi	s0,sp,48
 abc:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ac0:	fd843783          	ld	a5,-40(s0)
 ac4:	17c1                	addi	a5,a5,-16
 ac6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aca:	00000797          	auipc	a5,0x0
 ace:	56678793          	addi	a5,a5,1382 # 1030 <freep>
 ad2:	639c                	ld	a5,0(a5)
 ad4:	fef43423          	sd	a5,-24(s0)
 ad8:	a815                	j	b0c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ada:	fe843783          	ld	a5,-24(s0)
 ade:	639c                	ld	a5,0(a5)
 ae0:	fe843703          	ld	a4,-24(s0)
 ae4:	00f76f63          	bltu	a4,a5,b02 <free+0x4c>
 ae8:	fe043703          	ld	a4,-32(s0)
 aec:	fe843783          	ld	a5,-24(s0)
 af0:	02e7eb63          	bltu	a5,a4,b26 <free+0x70>
 af4:	fe843783          	ld	a5,-24(s0)
 af8:	639c                	ld	a5,0(a5)
 afa:	fe043703          	ld	a4,-32(s0)
 afe:	02f76463          	bltu	a4,a5,b26 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b02:	fe843783          	ld	a5,-24(s0)
 b06:	639c                	ld	a5,0(a5)
 b08:	fef43423          	sd	a5,-24(s0)
 b0c:	fe043703          	ld	a4,-32(s0)
 b10:	fe843783          	ld	a5,-24(s0)
 b14:	fce7f3e3          	bgeu	a5,a4,ada <free+0x24>
 b18:	fe843783          	ld	a5,-24(s0)
 b1c:	639c                	ld	a5,0(a5)
 b1e:	fe043703          	ld	a4,-32(s0)
 b22:	faf77ce3          	bgeu	a4,a5,ada <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b26:	fe043783          	ld	a5,-32(s0)
 b2a:	479c                	lw	a5,8(a5)
 b2c:	1782                	slli	a5,a5,0x20
 b2e:	9381                	srli	a5,a5,0x20
 b30:	0792                	slli	a5,a5,0x4
 b32:	fe043703          	ld	a4,-32(s0)
 b36:	973e                	add	a4,a4,a5
 b38:	fe843783          	ld	a5,-24(s0)
 b3c:	639c                	ld	a5,0(a5)
 b3e:	02f71763          	bne	a4,a5,b6c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b42:	fe043783          	ld	a5,-32(s0)
 b46:	4798                	lw	a4,8(a5)
 b48:	fe843783          	ld	a5,-24(s0)
 b4c:	639c                	ld	a5,0(a5)
 b4e:	479c                	lw	a5,8(a5)
 b50:	9fb9                	addw	a5,a5,a4
 b52:	0007871b          	sext.w	a4,a5
 b56:	fe043783          	ld	a5,-32(s0)
 b5a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b5c:	fe843783          	ld	a5,-24(s0)
 b60:	639c                	ld	a5,0(a5)
 b62:	6398                	ld	a4,0(a5)
 b64:	fe043783          	ld	a5,-32(s0)
 b68:	e398                	sd	a4,0(a5)
 b6a:	a039                	j	b78 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b6c:	fe843783          	ld	a5,-24(s0)
 b70:	6398                	ld	a4,0(a5)
 b72:	fe043783          	ld	a5,-32(s0)
 b76:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b78:	fe843783          	ld	a5,-24(s0)
 b7c:	479c                	lw	a5,8(a5)
 b7e:	1782                	slli	a5,a5,0x20
 b80:	9381                	srli	a5,a5,0x20
 b82:	0792                	slli	a5,a5,0x4
 b84:	fe843703          	ld	a4,-24(s0)
 b88:	97ba                	add	a5,a5,a4
 b8a:	fe043703          	ld	a4,-32(s0)
 b8e:	02f71563          	bne	a4,a5,bb8 <free+0x102>
    p->s.size += bp->s.size;
 b92:	fe843783          	ld	a5,-24(s0)
 b96:	4798                	lw	a4,8(a5)
 b98:	fe043783          	ld	a5,-32(s0)
 b9c:	479c                	lw	a5,8(a5)
 b9e:	9fb9                	addw	a5,a5,a4
 ba0:	0007871b          	sext.w	a4,a5
 ba4:	fe843783          	ld	a5,-24(s0)
 ba8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 baa:	fe043783          	ld	a5,-32(s0)
 bae:	6398                	ld	a4,0(a5)
 bb0:	fe843783          	ld	a5,-24(s0)
 bb4:	e398                	sd	a4,0(a5)
 bb6:	a031                	j	bc2 <free+0x10c>
  } else
    p->s.ptr = bp;
 bb8:	fe843783          	ld	a5,-24(s0)
 bbc:	fe043703          	ld	a4,-32(s0)
 bc0:	e398                	sd	a4,0(a5)
  freep = p;
 bc2:	00000797          	auipc	a5,0x0
 bc6:	46e78793          	addi	a5,a5,1134 # 1030 <freep>
 bca:	fe843703          	ld	a4,-24(s0)
 bce:	e398                	sd	a4,0(a5)
}
 bd0:	0001                	nop
 bd2:	7422                	ld	s0,40(sp)
 bd4:	6145                	addi	sp,sp,48
 bd6:	8082                	ret

0000000000000bd8 <morecore>:

static Header*
morecore(uint nu)
{
 bd8:	7179                	addi	sp,sp,-48
 bda:	f406                	sd	ra,40(sp)
 bdc:	f022                	sd	s0,32(sp)
 bde:	1800                	addi	s0,sp,48
 be0:	87aa                	mv	a5,a0
 be2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 be6:	fdc42783          	lw	a5,-36(s0)
 bea:	0007871b          	sext.w	a4,a5
 bee:	6785                	lui	a5,0x1
 bf0:	00f77563          	bgeu	a4,a5,bfa <morecore+0x22>
    nu = 4096;
 bf4:	6785                	lui	a5,0x1
 bf6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 bfa:	fdc42783          	lw	a5,-36(s0)
 bfe:	0047979b          	slliw	a5,a5,0x4
 c02:	2781                	sext.w	a5,a5
 c04:	2781                	sext.w	a5,a5
 c06:	853e                	mv	a0,a5
 c08:	00000097          	auipc	ra,0x0
 c0c:	9b8080e7          	jalr	-1608(ra) # 5c0 <sbrk>
 c10:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 c14:	fe843703          	ld	a4,-24(s0)
 c18:	57fd                	li	a5,-1
 c1a:	00f71463          	bne	a4,a5,c22 <morecore+0x4a>
    return 0;
 c1e:	4781                	li	a5,0
 c20:	a03d                	j	c4e <morecore+0x76>
  hp = (Header*)p;
 c22:	fe843783          	ld	a5,-24(s0)
 c26:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c2a:	fe043783          	ld	a5,-32(s0)
 c2e:	fdc42703          	lw	a4,-36(s0)
 c32:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c34:	fe043783          	ld	a5,-32(s0)
 c38:	07c1                	addi	a5,a5,16
 c3a:	853e                	mv	a0,a5
 c3c:	00000097          	auipc	ra,0x0
 c40:	e7a080e7          	jalr	-390(ra) # ab6 <free>
  return freep;
 c44:	00000797          	auipc	a5,0x0
 c48:	3ec78793          	addi	a5,a5,1004 # 1030 <freep>
 c4c:	639c                	ld	a5,0(a5)
}
 c4e:	853e                	mv	a0,a5
 c50:	70a2                	ld	ra,40(sp)
 c52:	7402                	ld	s0,32(sp)
 c54:	6145                	addi	sp,sp,48
 c56:	8082                	ret

0000000000000c58 <malloc>:

void*
malloc(uint nbytes)
{
 c58:	7139                	addi	sp,sp,-64
 c5a:	fc06                	sd	ra,56(sp)
 c5c:	f822                	sd	s0,48(sp)
 c5e:	0080                	addi	s0,sp,64
 c60:	87aa                	mv	a5,a0
 c62:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c66:	fcc46783          	lwu	a5,-52(s0)
 c6a:	07bd                	addi	a5,a5,15
 c6c:	8391                	srli	a5,a5,0x4
 c6e:	2781                	sext.w	a5,a5
 c70:	2785                	addiw	a5,a5,1
 c72:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c76:	00000797          	auipc	a5,0x0
 c7a:	3ba78793          	addi	a5,a5,954 # 1030 <freep>
 c7e:	639c                	ld	a5,0(a5)
 c80:	fef43023          	sd	a5,-32(s0)
 c84:	fe043783          	ld	a5,-32(s0)
 c88:	ef95                	bnez	a5,cc4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c8a:	00000797          	auipc	a5,0x0
 c8e:	39678793          	addi	a5,a5,918 # 1020 <base>
 c92:	fef43023          	sd	a5,-32(s0)
 c96:	00000797          	auipc	a5,0x0
 c9a:	39a78793          	addi	a5,a5,922 # 1030 <freep>
 c9e:	fe043703          	ld	a4,-32(s0)
 ca2:	e398                	sd	a4,0(a5)
 ca4:	00000797          	auipc	a5,0x0
 ca8:	38c78793          	addi	a5,a5,908 # 1030 <freep>
 cac:	6398                	ld	a4,0(a5)
 cae:	00000797          	auipc	a5,0x0
 cb2:	37278793          	addi	a5,a5,882 # 1020 <base>
 cb6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 cb8:	00000797          	auipc	a5,0x0
 cbc:	36878793          	addi	a5,a5,872 # 1020 <base>
 cc0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc4:	fe043783          	ld	a5,-32(s0)
 cc8:	639c                	ld	a5,0(a5)
 cca:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cce:	fe843783          	ld	a5,-24(s0)
 cd2:	4798                	lw	a4,8(a5)
 cd4:	fdc42783          	lw	a5,-36(s0)
 cd8:	2781                	sext.w	a5,a5
 cda:	06f76863          	bltu	a4,a5,d4a <malloc+0xf2>
      if(p->s.size == nunits)
 cde:	fe843783          	ld	a5,-24(s0)
 ce2:	4798                	lw	a4,8(a5)
 ce4:	fdc42783          	lw	a5,-36(s0)
 ce8:	2781                	sext.w	a5,a5
 cea:	00e79963          	bne	a5,a4,cfc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 cee:	fe843783          	ld	a5,-24(s0)
 cf2:	6398                	ld	a4,0(a5)
 cf4:	fe043783          	ld	a5,-32(s0)
 cf8:	e398                	sd	a4,0(a5)
 cfa:	a82d                	j	d34 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 cfc:	fe843783          	ld	a5,-24(s0)
 d00:	4798                	lw	a4,8(a5)
 d02:	fdc42783          	lw	a5,-36(s0)
 d06:	40f707bb          	subw	a5,a4,a5
 d0a:	0007871b          	sext.w	a4,a5
 d0e:	fe843783          	ld	a5,-24(s0)
 d12:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d14:	fe843783          	ld	a5,-24(s0)
 d18:	479c                	lw	a5,8(a5)
 d1a:	1782                	slli	a5,a5,0x20
 d1c:	9381                	srli	a5,a5,0x20
 d1e:	0792                	slli	a5,a5,0x4
 d20:	fe843703          	ld	a4,-24(s0)
 d24:	97ba                	add	a5,a5,a4
 d26:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d2a:	fe843783          	ld	a5,-24(s0)
 d2e:	fdc42703          	lw	a4,-36(s0)
 d32:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d34:	00000797          	auipc	a5,0x0
 d38:	2fc78793          	addi	a5,a5,764 # 1030 <freep>
 d3c:	fe043703          	ld	a4,-32(s0)
 d40:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d42:	fe843783          	ld	a5,-24(s0)
 d46:	07c1                	addi	a5,a5,16
 d48:	a091                	j	d8c <malloc+0x134>
    }
    if(p == freep)
 d4a:	00000797          	auipc	a5,0x0
 d4e:	2e678793          	addi	a5,a5,742 # 1030 <freep>
 d52:	639c                	ld	a5,0(a5)
 d54:	fe843703          	ld	a4,-24(s0)
 d58:	02f71063          	bne	a4,a5,d78 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 d5c:	fdc42783          	lw	a5,-36(s0)
 d60:	853e                	mv	a0,a5
 d62:	00000097          	auipc	ra,0x0
 d66:	e76080e7          	jalr	-394(ra) # bd8 <morecore>
 d6a:	fea43423          	sd	a0,-24(s0)
 d6e:	fe843783          	ld	a5,-24(s0)
 d72:	e399                	bnez	a5,d78 <malloc+0x120>
        return 0;
 d74:	4781                	li	a5,0
 d76:	a819                	j	d8c <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d78:	fe843783          	ld	a5,-24(s0)
 d7c:	fef43023          	sd	a5,-32(s0)
 d80:	fe843783          	ld	a5,-24(s0)
 d84:	639c                	ld	a5,0(a5)
 d86:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d8a:	b791                	j	cce <malloc+0x76>
  }
}
 d8c:	853e                	mv	a0,a5
 d8e:	70e2                	ld	ra,56(sp)
 d90:	7442                	ld	s0,48(sp)
 d92:	6121                	addi	sp,sp,64
 d94:	8082                	ret
