
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcf42e23          	sw	a5,-36(s0)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   e:	a091                	j	52 <cat+0x52>
    if (write(1, buf, n) != n) {
  10:	fec42783          	lw	a5,-20(s0)
  14:	863e                	mv	a2,a5
  16:	00001597          	auipc	a1,0x1
  1a:	00a58593          	addi	a1,a1,10 # 1020 <buf>
  1e:	4505                	li	a0,1
  20:	00000097          	auipc	ra,0x0
  24:	628080e7          	jalr	1576(ra) # 648 <write>
  28:	87aa                	mv	a5,a0
  2a:	873e                	mv	a4,a5
  2c:	fec42783          	lw	a5,-20(s0)
  30:	2781                	sext.w	a5,a5
  32:	02e78063          	beq	a5,a4,52 <cat+0x52>
      fprintf(2, "cat: write error\n");
  36:	00001597          	auipc	a1,0x1
  3a:	e5a58593          	addi	a1,a1,-422 # e90 <malloc+0x148>
  3e:	4509                	li	a0,2
  40:	00001097          	auipc	ra,0x1
  44:	abe080e7          	jalr	-1346(ra) # afe <fprintf>
      exit(1);
  48:	4505                	li	a0,1
  4a:	00000097          	auipc	ra,0x0
  4e:	5de080e7          	jalr	1502(ra) # 628 <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  52:	fdc42783          	lw	a5,-36(s0)
  56:	20000613          	li	a2,512
  5a:	00001597          	auipc	a1,0x1
  5e:	fc658593          	addi	a1,a1,-58 # 1020 <buf>
  62:	853e                	mv	a0,a5
  64:	00000097          	auipc	ra,0x0
  68:	5dc080e7          	jalr	1500(ra) # 640 <read>
  6c:	87aa                	mv	a5,a0
  6e:	fef42623          	sw	a5,-20(s0)
  72:	fec42783          	lw	a5,-20(s0)
  76:	2781                	sext.w	a5,a5
  78:	f8f04ce3          	bgtz	a5,10 <cat+0x10>
    }
  }
  if(n < 0){
  7c:	fec42783          	lw	a5,-20(s0)
  80:	2781                	sext.w	a5,a5
  82:	0207d063          	bgez	a5,a2 <cat+0xa2>
    fprintf(2, "cat: read error\n");
  86:	00001597          	auipc	a1,0x1
  8a:	e2258593          	addi	a1,a1,-478 # ea8 <malloc+0x160>
  8e:	4509                	li	a0,2
  90:	00001097          	auipc	ra,0x1
  94:	a6e080e7          	jalr	-1426(ra) # afe <fprintf>
    exit(1);
  98:	4505                	li	a0,1
  9a:	00000097          	auipc	ra,0x0
  9e:	58e080e7          	jalr	1422(ra) # 628 <exit>
  }
}
  a2:	0001                	nop
  a4:	70a2                	ld	ra,40(sp)
  a6:	7402                	ld	s0,32(sp)
  a8:	6145                	addi	sp,sp,48
  aa:	8082                	ret

00000000000000ac <main>:

int
main(int argc, char *argv[])
{
  ac:	7179                	addi	sp,sp,-48
  ae:	f406                	sd	ra,40(sp)
  b0:	f022                	sd	s0,32(sp)
  b2:	1800                	addi	s0,sp,48
  b4:	87aa                	mv	a5,a0
  b6:	fcb43823          	sd	a1,-48(s0)
  ba:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
  be:	fdc42783          	lw	a5,-36(s0)
  c2:	0007871b          	sext.w	a4,a5
  c6:	4785                	li	a5,1
  c8:	00e7cc63          	blt	a5,a4,e0 <main+0x34>
    cat(0);
  cc:	4501                	li	a0,0
  ce:	00000097          	auipc	ra,0x0
  d2:	f32080e7          	jalr	-206(ra) # 0 <cat>
    exit(0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	550080e7          	jalr	1360(ra) # 628 <exit>
  }

  for(i = 1; i < argc; i++){
  e0:	4785                	li	a5,1
  e2:	fef42623          	sw	a5,-20(s0)
  e6:	a8bd                	j	164 <main+0xb8>
    if((fd = open(argv[i], 0)) < 0){
  e8:	fec42783          	lw	a5,-20(s0)
  ec:	078e                	slli	a5,a5,0x3
  ee:	fd043703          	ld	a4,-48(s0)
  f2:	97ba                	add	a5,a5,a4
  f4:	639c                	ld	a5,0(a5)
  f6:	4581                	li	a1,0
  f8:	853e                	mv	a0,a5
  fa:	00000097          	auipc	ra,0x0
  fe:	56e080e7          	jalr	1390(ra) # 668 <open>
 102:	87aa                	mv	a5,a0
 104:	fef42423          	sw	a5,-24(s0)
 108:	fe842783          	lw	a5,-24(s0)
 10c:	2781                	sext.w	a5,a5
 10e:	0207d863          	bgez	a5,13e <main+0x92>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
 112:	fec42783          	lw	a5,-20(s0)
 116:	078e                	slli	a5,a5,0x3
 118:	fd043703          	ld	a4,-48(s0)
 11c:	97ba                	add	a5,a5,a4
 11e:	639c                	ld	a5,0(a5)
 120:	863e                	mv	a2,a5
 122:	00001597          	auipc	a1,0x1
 126:	d9e58593          	addi	a1,a1,-610 # ec0 <malloc+0x178>
 12a:	4509                	li	a0,2
 12c:	00001097          	auipc	ra,0x1
 130:	9d2080e7          	jalr	-1582(ra) # afe <fprintf>
      exit(1);
 134:	4505                	li	a0,1
 136:	00000097          	auipc	ra,0x0
 13a:	4f2080e7          	jalr	1266(ra) # 628 <exit>
    }
    cat(fd);
 13e:	fe842783          	lw	a5,-24(s0)
 142:	853e                	mv	a0,a5
 144:	00000097          	auipc	ra,0x0
 148:	ebc080e7          	jalr	-324(ra) # 0 <cat>
    close(fd);
 14c:	fe842783          	lw	a5,-24(s0)
 150:	853e                	mv	a0,a5
 152:	00000097          	auipc	ra,0x0
 156:	4fe080e7          	jalr	1278(ra) # 650 <close>
  for(i = 1; i < argc; i++){
 15a:	fec42783          	lw	a5,-20(s0)
 15e:	2785                	addiw	a5,a5,1
 160:	fef42623          	sw	a5,-20(s0)
 164:	fec42703          	lw	a4,-20(s0)
 168:	fdc42783          	lw	a5,-36(s0)
 16c:	2701                	sext.w	a4,a4
 16e:	2781                	sext.w	a5,a5
 170:	f6f74ce3          	blt	a4,a5,e8 <main+0x3c>
  }
  exit(0);
 174:	4501                	li	a0,0
 176:	00000097          	auipc	ra,0x0
 17a:	4b2080e7          	jalr	1202(ra) # 628 <exit>

000000000000017e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 17e:	1141                	addi	sp,sp,-16
 180:	e406                	sd	ra,8(sp)
 182:	e022                	sd	s0,0(sp)
 184:	0800                	addi	s0,sp,16
  extern int main();
  main();
 186:	00000097          	auipc	ra,0x0
 18a:	f26080e7          	jalr	-218(ra) # ac <main>
  exit(0);
 18e:	4501                	li	a0,0
 190:	00000097          	auipc	ra,0x0
 194:	498080e7          	jalr	1176(ra) # 628 <exit>

0000000000000198 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 198:	7179                	addi	sp,sp,-48
 19a:	f422                	sd	s0,40(sp)
 19c:	1800                	addi	s0,sp,48
 19e:	fca43c23          	sd	a0,-40(s0)
 1a2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 1a6:	fd843783          	ld	a5,-40(s0)
 1aa:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 1ae:	0001                	nop
 1b0:	fd043703          	ld	a4,-48(s0)
 1b4:	00170793          	addi	a5,a4,1
 1b8:	fcf43823          	sd	a5,-48(s0)
 1bc:	fd843783          	ld	a5,-40(s0)
 1c0:	00178693          	addi	a3,a5,1
 1c4:	fcd43c23          	sd	a3,-40(s0)
 1c8:	00074703          	lbu	a4,0(a4)
 1cc:	00e78023          	sb	a4,0(a5)
 1d0:	0007c783          	lbu	a5,0(a5)
 1d4:	fff1                	bnez	a5,1b0 <strcpy+0x18>
    ;
  return os;
 1d6:	fe843783          	ld	a5,-24(s0)
}
 1da:	853e                	mv	a0,a5
 1dc:	7422                	ld	s0,40(sp)
 1de:	6145                	addi	sp,sp,48
 1e0:	8082                	ret

00000000000001e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1e2:	1101                	addi	sp,sp,-32
 1e4:	ec22                	sd	s0,24(sp)
 1e6:	1000                	addi	s0,sp,32
 1e8:	fea43423          	sd	a0,-24(s0)
 1ec:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1f0:	a819                	j	206 <strcmp+0x24>
    p++, q++;
 1f2:	fe843783          	ld	a5,-24(s0)
 1f6:	0785                	addi	a5,a5,1
 1f8:	fef43423          	sd	a5,-24(s0)
 1fc:	fe043783          	ld	a5,-32(s0)
 200:	0785                	addi	a5,a5,1
 202:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 206:	fe843783          	ld	a5,-24(s0)
 20a:	0007c783          	lbu	a5,0(a5)
 20e:	cb99                	beqz	a5,224 <strcmp+0x42>
 210:	fe843783          	ld	a5,-24(s0)
 214:	0007c703          	lbu	a4,0(a5)
 218:	fe043783          	ld	a5,-32(s0)
 21c:	0007c783          	lbu	a5,0(a5)
 220:	fcf709e3          	beq	a4,a5,1f2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 224:	fe843783          	ld	a5,-24(s0)
 228:	0007c783          	lbu	a5,0(a5)
 22c:	0007871b          	sext.w	a4,a5
 230:	fe043783          	ld	a5,-32(s0)
 234:	0007c783          	lbu	a5,0(a5)
 238:	2781                	sext.w	a5,a5
 23a:	40f707bb          	subw	a5,a4,a5
 23e:	2781                	sext.w	a5,a5
}
 240:	853e                	mv	a0,a5
 242:	6462                	ld	s0,24(sp)
 244:	6105                	addi	sp,sp,32
 246:	8082                	ret

0000000000000248 <strlen>:

uint
strlen(const char *s)
{
 248:	7179                	addi	sp,sp,-48
 24a:	f422                	sd	s0,40(sp)
 24c:	1800                	addi	s0,sp,48
 24e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 252:	fe042623          	sw	zero,-20(s0)
 256:	a031                	j	262 <strlen+0x1a>
 258:	fec42783          	lw	a5,-20(s0)
 25c:	2785                	addiw	a5,a5,1
 25e:	fef42623          	sw	a5,-20(s0)
 262:	fec42783          	lw	a5,-20(s0)
 266:	fd843703          	ld	a4,-40(s0)
 26a:	97ba                	add	a5,a5,a4
 26c:	0007c783          	lbu	a5,0(a5)
 270:	f7e5                	bnez	a5,258 <strlen+0x10>
    ;
  return n;
 272:	fec42783          	lw	a5,-20(s0)
}
 276:	853e                	mv	a0,a5
 278:	7422                	ld	s0,40(sp)
 27a:	6145                	addi	sp,sp,48
 27c:	8082                	ret

000000000000027e <memset>:

void*
memset(void *dst, int c, uint n)
{
 27e:	7179                	addi	sp,sp,-48
 280:	f422                	sd	s0,40(sp)
 282:	1800                	addi	s0,sp,48
 284:	fca43c23          	sd	a0,-40(s0)
 288:	87ae                	mv	a5,a1
 28a:	8732                	mv	a4,a2
 28c:	fcf42a23          	sw	a5,-44(s0)
 290:	87ba                	mv	a5,a4
 292:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 296:	fd843783          	ld	a5,-40(s0)
 29a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 29e:	fe042623          	sw	zero,-20(s0)
 2a2:	a00d                	j	2c4 <memset+0x46>
    cdst[i] = c;
 2a4:	fec42783          	lw	a5,-20(s0)
 2a8:	fe043703          	ld	a4,-32(s0)
 2ac:	97ba                	add	a5,a5,a4
 2ae:	fd442703          	lw	a4,-44(s0)
 2b2:	0ff77713          	andi	a4,a4,255
 2b6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 2ba:	fec42783          	lw	a5,-20(s0)
 2be:	2785                	addiw	a5,a5,1
 2c0:	fef42623          	sw	a5,-20(s0)
 2c4:	fec42703          	lw	a4,-20(s0)
 2c8:	fd042783          	lw	a5,-48(s0)
 2cc:	2781                	sext.w	a5,a5
 2ce:	fcf76be3          	bltu	a4,a5,2a4 <memset+0x26>
  }
  return dst;
 2d2:	fd843783          	ld	a5,-40(s0)
}
 2d6:	853e                	mv	a0,a5
 2d8:	7422                	ld	s0,40(sp)
 2da:	6145                	addi	sp,sp,48
 2dc:	8082                	ret

00000000000002de <strchr>:

char*
strchr(const char *s, char c)
{
 2de:	1101                	addi	sp,sp,-32
 2e0:	ec22                	sd	s0,24(sp)
 2e2:	1000                	addi	s0,sp,32
 2e4:	fea43423          	sd	a0,-24(s0)
 2e8:	87ae                	mv	a5,a1
 2ea:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2ee:	a01d                	j	314 <strchr+0x36>
    if(*s == c)
 2f0:	fe843783          	ld	a5,-24(s0)
 2f4:	0007c703          	lbu	a4,0(a5)
 2f8:	fe744783          	lbu	a5,-25(s0)
 2fc:	0ff7f793          	andi	a5,a5,255
 300:	00e79563          	bne	a5,a4,30a <strchr+0x2c>
      return (char*)s;
 304:	fe843783          	ld	a5,-24(s0)
 308:	a821                	j	320 <strchr+0x42>
  for(; *s; s++)
 30a:	fe843783          	ld	a5,-24(s0)
 30e:	0785                	addi	a5,a5,1
 310:	fef43423          	sd	a5,-24(s0)
 314:	fe843783          	ld	a5,-24(s0)
 318:	0007c783          	lbu	a5,0(a5)
 31c:	fbf1                	bnez	a5,2f0 <strchr+0x12>
  return 0;
 31e:	4781                	li	a5,0
}
 320:	853e                	mv	a0,a5
 322:	6462                	ld	s0,24(sp)
 324:	6105                	addi	sp,sp,32
 326:	8082                	ret

0000000000000328 <gets>:

char*
gets(char *buf, int max)
{
 328:	7179                	addi	sp,sp,-48
 32a:	f406                	sd	ra,40(sp)
 32c:	f022                	sd	s0,32(sp)
 32e:	1800                	addi	s0,sp,48
 330:	fca43c23          	sd	a0,-40(s0)
 334:	87ae                	mv	a5,a1
 336:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 33a:	fe042623          	sw	zero,-20(s0)
 33e:	a8a1                	j	396 <gets+0x6e>
    cc = read(0, &c, 1);
 340:	fe740793          	addi	a5,s0,-25
 344:	4605                	li	a2,1
 346:	85be                	mv	a1,a5
 348:	4501                	li	a0,0
 34a:	00000097          	auipc	ra,0x0
 34e:	2f6080e7          	jalr	758(ra) # 640 <read>
 352:	87aa                	mv	a5,a0
 354:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 358:	fe842783          	lw	a5,-24(s0)
 35c:	2781                	sext.w	a5,a5
 35e:	04f05763          	blez	a5,3ac <gets+0x84>
      break;
    buf[i++] = c;
 362:	fec42783          	lw	a5,-20(s0)
 366:	0017871b          	addiw	a4,a5,1
 36a:	fee42623          	sw	a4,-20(s0)
 36e:	873e                	mv	a4,a5
 370:	fd843783          	ld	a5,-40(s0)
 374:	97ba                	add	a5,a5,a4
 376:	fe744703          	lbu	a4,-25(s0)
 37a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 37e:	fe744783          	lbu	a5,-25(s0)
 382:	873e                	mv	a4,a5
 384:	47a9                	li	a5,10
 386:	02f70463          	beq	a4,a5,3ae <gets+0x86>
 38a:	fe744783          	lbu	a5,-25(s0)
 38e:	873e                	mv	a4,a5
 390:	47b5                	li	a5,13
 392:	00f70e63          	beq	a4,a5,3ae <gets+0x86>
  for(i=0; i+1 < max; ){
 396:	fec42783          	lw	a5,-20(s0)
 39a:	2785                	addiw	a5,a5,1
 39c:	0007871b          	sext.w	a4,a5
 3a0:	fd442783          	lw	a5,-44(s0)
 3a4:	2781                	sext.w	a5,a5
 3a6:	f8f74de3          	blt	a4,a5,340 <gets+0x18>
 3aa:	a011                	j	3ae <gets+0x86>
      break;
 3ac:	0001                	nop
      break;
  }
  buf[i] = '\0';
 3ae:	fec42783          	lw	a5,-20(s0)
 3b2:	fd843703          	ld	a4,-40(s0)
 3b6:	97ba                	add	a5,a5,a4
 3b8:	00078023          	sb	zero,0(a5)
  return buf;
 3bc:	fd843783          	ld	a5,-40(s0)
}
 3c0:	853e                	mv	a0,a5
 3c2:	70a2                	ld	ra,40(sp)
 3c4:	7402                	ld	s0,32(sp)
 3c6:	6145                	addi	sp,sp,48
 3c8:	8082                	ret

00000000000003ca <stat>:

int
stat(const char *n, struct stat *st)
{
 3ca:	7179                	addi	sp,sp,-48
 3cc:	f406                	sd	ra,40(sp)
 3ce:	f022                	sd	s0,32(sp)
 3d0:	1800                	addi	s0,sp,48
 3d2:	fca43c23          	sd	a0,-40(s0)
 3d6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3da:	4581                	li	a1,0
 3dc:	fd843503          	ld	a0,-40(s0)
 3e0:	00000097          	auipc	ra,0x0
 3e4:	288080e7          	jalr	648(ra) # 668 <open>
 3e8:	87aa                	mv	a5,a0
 3ea:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3ee:	fec42783          	lw	a5,-20(s0)
 3f2:	2781                	sext.w	a5,a5
 3f4:	0007d463          	bgez	a5,3fc <stat+0x32>
    return -1;
 3f8:	57fd                	li	a5,-1
 3fa:	a035                	j	426 <stat+0x5c>
  r = fstat(fd, st);
 3fc:	fec42783          	lw	a5,-20(s0)
 400:	fd043583          	ld	a1,-48(s0)
 404:	853e                	mv	a0,a5
 406:	00000097          	auipc	ra,0x0
 40a:	27a080e7          	jalr	634(ra) # 680 <fstat>
 40e:	87aa                	mv	a5,a0
 410:	fef42423          	sw	a5,-24(s0)
  close(fd);
 414:	fec42783          	lw	a5,-20(s0)
 418:	853e                	mv	a0,a5
 41a:	00000097          	auipc	ra,0x0
 41e:	236080e7          	jalr	566(ra) # 650 <close>
  return r;
 422:	fe842783          	lw	a5,-24(s0)
}
 426:	853e                	mv	a0,a5
 428:	70a2                	ld	ra,40(sp)
 42a:	7402                	ld	s0,32(sp)
 42c:	6145                	addi	sp,sp,48
 42e:	8082                	ret

0000000000000430 <atoi>:

int
atoi(const char *s)
{
 430:	7179                	addi	sp,sp,-48
 432:	f422                	sd	s0,40(sp)
 434:	1800                	addi	s0,sp,48
 436:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 43a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 43e:	a815                	j	472 <atoi+0x42>
    n = n*10 + *s++ - '0';
 440:	fec42703          	lw	a4,-20(s0)
 444:	87ba                	mv	a5,a4
 446:	0027979b          	slliw	a5,a5,0x2
 44a:	9fb9                	addw	a5,a5,a4
 44c:	0017979b          	slliw	a5,a5,0x1
 450:	0007871b          	sext.w	a4,a5
 454:	fd843783          	ld	a5,-40(s0)
 458:	00178693          	addi	a3,a5,1
 45c:	fcd43c23          	sd	a3,-40(s0)
 460:	0007c783          	lbu	a5,0(a5)
 464:	2781                	sext.w	a5,a5
 466:	9fb9                	addw	a5,a5,a4
 468:	2781                	sext.w	a5,a5
 46a:	fd07879b          	addiw	a5,a5,-48
 46e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 472:	fd843783          	ld	a5,-40(s0)
 476:	0007c783          	lbu	a5,0(a5)
 47a:	873e                	mv	a4,a5
 47c:	02f00793          	li	a5,47
 480:	00e7fb63          	bgeu	a5,a4,496 <atoi+0x66>
 484:	fd843783          	ld	a5,-40(s0)
 488:	0007c783          	lbu	a5,0(a5)
 48c:	873e                	mv	a4,a5
 48e:	03900793          	li	a5,57
 492:	fae7f7e3          	bgeu	a5,a4,440 <atoi+0x10>
  return n;
 496:	fec42783          	lw	a5,-20(s0)
}
 49a:	853e                	mv	a0,a5
 49c:	7422                	ld	s0,40(sp)
 49e:	6145                	addi	sp,sp,48
 4a0:	8082                	ret

00000000000004a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4a2:	7139                	addi	sp,sp,-64
 4a4:	fc22                	sd	s0,56(sp)
 4a6:	0080                	addi	s0,sp,64
 4a8:	fca43c23          	sd	a0,-40(s0)
 4ac:	fcb43823          	sd	a1,-48(s0)
 4b0:	87b2                	mv	a5,a2
 4b2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 4b6:	fd843783          	ld	a5,-40(s0)
 4ba:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 4be:	fd043783          	ld	a5,-48(s0)
 4c2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 4c6:	fe043703          	ld	a4,-32(s0)
 4ca:	fe843783          	ld	a5,-24(s0)
 4ce:	02e7fc63          	bgeu	a5,a4,506 <memmove+0x64>
    while(n-- > 0)
 4d2:	a00d                	j	4f4 <memmove+0x52>
      *dst++ = *src++;
 4d4:	fe043703          	ld	a4,-32(s0)
 4d8:	00170793          	addi	a5,a4,1
 4dc:	fef43023          	sd	a5,-32(s0)
 4e0:	fe843783          	ld	a5,-24(s0)
 4e4:	00178693          	addi	a3,a5,1
 4e8:	fed43423          	sd	a3,-24(s0)
 4ec:	00074703          	lbu	a4,0(a4)
 4f0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4f4:	fcc42783          	lw	a5,-52(s0)
 4f8:	fff7871b          	addiw	a4,a5,-1
 4fc:	fce42623          	sw	a4,-52(s0)
 500:	fcf04ae3          	bgtz	a5,4d4 <memmove+0x32>
 504:	a891                	j	558 <memmove+0xb6>
  } else {
    dst += n;
 506:	fcc42783          	lw	a5,-52(s0)
 50a:	fe843703          	ld	a4,-24(s0)
 50e:	97ba                	add	a5,a5,a4
 510:	fef43423          	sd	a5,-24(s0)
    src += n;
 514:	fcc42783          	lw	a5,-52(s0)
 518:	fe043703          	ld	a4,-32(s0)
 51c:	97ba                	add	a5,a5,a4
 51e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 522:	a01d                	j	548 <memmove+0xa6>
      *--dst = *--src;
 524:	fe043783          	ld	a5,-32(s0)
 528:	17fd                	addi	a5,a5,-1
 52a:	fef43023          	sd	a5,-32(s0)
 52e:	fe843783          	ld	a5,-24(s0)
 532:	17fd                	addi	a5,a5,-1
 534:	fef43423          	sd	a5,-24(s0)
 538:	fe043783          	ld	a5,-32(s0)
 53c:	0007c703          	lbu	a4,0(a5)
 540:	fe843783          	ld	a5,-24(s0)
 544:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 548:	fcc42783          	lw	a5,-52(s0)
 54c:	fff7871b          	addiw	a4,a5,-1
 550:	fce42623          	sw	a4,-52(s0)
 554:	fcf048e3          	bgtz	a5,524 <memmove+0x82>
  }
  return vdst;
 558:	fd843783          	ld	a5,-40(s0)
}
 55c:	853e                	mv	a0,a5
 55e:	7462                	ld	s0,56(sp)
 560:	6121                	addi	sp,sp,64
 562:	8082                	ret

0000000000000564 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 564:	7139                	addi	sp,sp,-64
 566:	fc22                	sd	s0,56(sp)
 568:	0080                	addi	s0,sp,64
 56a:	fca43c23          	sd	a0,-40(s0)
 56e:	fcb43823          	sd	a1,-48(s0)
 572:	87b2                	mv	a5,a2
 574:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 578:	fd843783          	ld	a5,-40(s0)
 57c:	fef43423          	sd	a5,-24(s0)
 580:	fd043783          	ld	a5,-48(s0)
 584:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 588:	a0a1                	j	5d0 <memcmp+0x6c>
    if (*p1 != *p2) {
 58a:	fe843783          	ld	a5,-24(s0)
 58e:	0007c703          	lbu	a4,0(a5)
 592:	fe043783          	ld	a5,-32(s0)
 596:	0007c783          	lbu	a5,0(a5)
 59a:	02f70163          	beq	a4,a5,5bc <memcmp+0x58>
      return *p1 - *p2;
 59e:	fe843783          	ld	a5,-24(s0)
 5a2:	0007c783          	lbu	a5,0(a5)
 5a6:	0007871b          	sext.w	a4,a5
 5aa:	fe043783          	ld	a5,-32(s0)
 5ae:	0007c783          	lbu	a5,0(a5)
 5b2:	2781                	sext.w	a5,a5
 5b4:	40f707bb          	subw	a5,a4,a5
 5b8:	2781                	sext.w	a5,a5
 5ba:	a01d                	j	5e0 <memcmp+0x7c>
    }
    p1++;
 5bc:	fe843783          	ld	a5,-24(s0)
 5c0:	0785                	addi	a5,a5,1
 5c2:	fef43423          	sd	a5,-24(s0)
    p2++;
 5c6:	fe043783          	ld	a5,-32(s0)
 5ca:	0785                	addi	a5,a5,1
 5cc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5d0:	fcc42783          	lw	a5,-52(s0)
 5d4:	fff7871b          	addiw	a4,a5,-1
 5d8:	fce42623          	sw	a4,-52(s0)
 5dc:	f7dd                	bnez	a5,58a <memcmp+0x26>
  }
  return 0;
 5de:	4781                	li	a5,0
}
 5e0:	853e                	mv	a0,a5
 5e2:	7462                	ld	s0,56(sp)
 5e4:	6121                	addi	sp,sp,64
 5e6:	8082                	ret

00000000000005e8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5e8:	7179                	addi	sp,sp,-48
 5ea:	f406                	sd	ra,40(sp)
 5ec:	f022                	sd	s0,32(sp)
 5ee:	1800                	addi	s0,sp,48
 5f0:	fea43423          	sd	a0,-24(s0)
 5f4:	feb43023          	sd	a1,-32(s0)
 5f8:	87b2                	mv	a5,a2
 5fa:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5fe:	fdc42783          	lw	a5,-36(s0)
 602:	863e                	mv	a2,a5
 604:	fe043583          	ld	a1,-32(s0)
 608:	fe843503          	ld	a0,-24(s0)
 60c:	00000097          	auipc	ra,0x0
 610:	e96080e7          	jalr	-362(ra) # 4a2 <memmove>
 614:	87aa                	mv	a5,a0
}
 616:	853e                	mv	a0,a5
 618:	70a2                	ld	ra,40(sp)
 61a:	7402                	ld	s0,32(sp)
 61c:	6145                	addi	sp,sp,48
 61e:	8082                	ret

0000000000000620 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 620:	4885                	li	a7,1
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <exit>:
.global exit
exit:
 li a7, SYS_exit
 628:	4889                	li	a7,2
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <wait>:
.global wait
wait:
 li a7, SYS_wait
 630:	488d                	li	a7,3
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 638:	4891                	li	a7,4
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <read>:
.global read
read:
 li a7, SYS_read
 640:	4895                	li	a7,5
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <write>:
.global write
write:
 li a7, SYS_write
 648:	48c1                	li	a7,16
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <close>:
.global close
close:
 li a7, SYS_close
 650:	48d5                	li	a7,21
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <kill>:
.global kill
kill:
 li a7, SYS_kill
 658:	4899                	li	a7,6
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <exec>:
.global exec
exec:
 li a7, SYS_exec
 660:	489d                	li	a7,7
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <open>:
.global open
open:
 li a7, SYS_open
 668:	48bd                	li	a7,15
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 670:	48c5                	li	a7,17
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 678:	48c9                	li	a7,18
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 680:	48a1                	li	a7,8
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <link>:
.global link
link:
 li a7, SYS_link
 688:	48cd                	li	a7,19
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 690:	48d1                	li	a7,20
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 698:	48a5                	li	a7,9
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6a0:	48a9                	li	a7,10
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6a8:	48ad                	li	a7,11
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6b0:	48b1                	li	a7,12
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6b8:	48b5                	li	a7,13
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6c0:	48b9                	li	a7,14
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6c8:	1101                	addi	sp,sp,-32
 6ca:	ec06                	sd	ra,24(sp)
 6cc:	e822                	sd	s0,16(sp)
 6ce:	1000                	addi	s0,sp,32
 6d0:	87aa                	mv	a5,a0
 6d2:	872e                	mv	a4,a1
 6d4:	fef42623          	sw	a5,-20(s0)
 6d8:	87ba                	mv	a5,a4
 6da:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 6de:	feb40713          	addi	a4,s0,-21
 6e2:	fec42783          	lw	a5,-20(s0)
 6e6:	4605                	li	a2,1
 6e8:	85ba                	mv	a1,a4
 6ea:	853e                	mv	a0,a5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	f5c080e7          	jalr	-164(ra) # 648 <write>
}
 6f4:	0001                	nop
 6f6:	60e2                	ld	ra,24(sp)
 6f8:	6442                	ld	s0,16(sp)
 6fa:	6105                	addi	sp,sp,32
 6fc:	8082                	ret

00000000000006fe <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6fe:	7139                	addi	sp,sp,-64
 700:	fc06                	sd	ra,56(sp)
 702:	f822                	sd	s0,48(sp)
 704:	0080                	addi	s0,sp,64
 706:	87aa                	mv	a5,a0
 708:	8736                	mv	a4,a3
 70a:	fcf42623          	sw	a5,-52(s0)
 70e:	87ae                	mv	a5,a1
 710:	fcf42423          	sw	a5,-56(s0)
 714:	87b2                	mv	a5,a2
 716:	fcf42223          	sw	a5,-60(s0)
 71a:	87ba                	mv	a5,a4
 71c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 720:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 724:	fc042783          	lw	a5,-64(s0)
 728:	2781                	sext.w	a5,a5
 72a:	c38d                	beqz	a5,74c <printint+0x4e>
 72c:	fc842783          	lw	a5,-56(s0)
 730:	2781                	sext.w	a5,a5
 732:	0007dd63          	bgez	a5,74c <printint+0x4e>
    neg = 1;
 736:	4785                	li	a5,1
 738:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 73c:	fc842783          	lw	a5,-56(s0)
 740:	40f007bb          	negw	a5,a5
 744:	2781                	sext.w	a5,a5
 746:	fef42223          	sw	a5,-28(s0)
 74a:	a029                	j	754 <printint+0x56>
  } else {
    x = xx;
 74c:	fc842783          	lw	a5,-56(s0)
 750:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 754:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 758:	fc442783          	lw	a5,-60(s0)
 75c:	fe442703          	lw	a4,-28(s0)
 760:	02f777bb          	remuw	a5,a4,a5
 764:	0007861b          	sext.w	a2,a5
 768:	fec42783          	lw	a5,-20(s0)
 76c:	0017871b          	addiw	a4,a5,1
 770:	fee42623          	sw	a4,-20(s0)
 774:	00001697          	auipc	a3,0x1
 778:	88c68693          	addi	a3,a3,-1908 # 1000 <digits>
 77c:	02061713          	slli	a4,a2,0x20
 780:	9301                	srli	a4,a4,0x20
 782:	9736                	add	a4,a4,a3
 784:	00074703          	lbu	a4,0(a4)
 788:	ff040693          	addi	a3,s0,-16
 78c:	97b6                	add	a5,a5,a3
 78e:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 792:	fc442783          	lw	a5,-60(s0)
 796:	fe442703          	lw	a4,-28(s0)
 79a:	02f757bb          	divuw	a5,a4,a5
 79e:	fef42223          	sw	a5,-28(s0)
 7a2:	fe442783          	lw	a5,-28(s0)
 7a6:	2781                	sext.w	a5,a5
 7a8:	fbc5                	bnez	a5,758 <printint+0x5a>
  if(neg)
 7aa:	fe842783          	lw	a5,-24(s0)
 7ae:	2781                	sext.w	a5,a5
 7b0:	cf95                	beqz	a5,7ec <printint+0xee>
    buf[i++] = '-';
 7b2:	fec42783          	lw	a5,-20(s0)
 7b6:	0017871b          	addiw	a4,a5,1
 7ba:	fee42623          	sw	a4,-20(s0)
 7be:	ff040713          	addi	a4,s0,-16
 7c2:	97ba                	add	a5,a5,a4
 7c4:	02d00713          	li	a4,45
 7c8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 7cc:	a005                	j	7ec <printint+0xee>
    putc(fd, buf[i]);
 7ce:	fec42783          	lw	a5,-20(s0)
 7d2:	ff040713          	addi	a4,s0,-16
 7d6:	97ba                	add	a5,a5,a4
 7d8:	fe07c703          	lbu	a4,-32(a5)
 7dc:	fcc42783          	lw	a5,-52(s0)
 7e0:	85ba                	mv	a1,a4
 7e2:	853e                	mv	a0,a5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	ee4080e7          	jalr	-284(ra) # 6c8 <putc>
  while(--i >= 0)
 7ec:	fec42783          	lw	a5,-20(s0)
 7f0:	37fd                	addiw	a5,a5,-1
 7f2:	fef42623          	sw	a5,-20(s0)
 7f6:	fec42783          	lw	a5,-20(s0)
 7fa:	2781                	sext.w	a5,a5
 7fc:	fc07d9e3          	bgez	a5,7ce <printint+0xd0>
}
 800:	0001                	nop
 802:	0001                	nop
 804:	70e2                	ld	ra,56(sp)
 806:	7442                	ld	s0,48(sp)
 808:	6121                	addi	sp,sp,64
 80a:	8082                	ret

000000000000080c <printptr>:

static void
printptr(int fd, uint64 x) {
 80c:	7179                	addi	sp,sp,-48
 80e:	f406                	sd	ra,40(sp)
 810:	f022                	sd	s0,32(sp)
 812:	1800                	addi	s0,sp,48
 814:	87aa                	mv	a5,a0
 816:	fcb43823          	sd	a1,-48(s0)
 81a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 81e:	fdc42783          	lw	a5,-36(s0)
 822:	03000593          	li	a1,48
 826:	853e                	mv	a0,a5
 828:	00000097          	auipc	ra,0x0
 82c:	ea0080e7          	jalr	-352(ra) # 6c8 <putc>
  putc(fd, 'x');
 830:	fdc42783          	lw	a5,-36(s0)
 834:	07800593          	li	a1,120
 838:	853e                	mv	a0,a5
 83a:	00000097          	auipc	ra,0x0
 83e:	e8e080e7          	jalr	-370(ra) # 6c8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 842:	fe042623          	sw	zero,-20(s0)
 846:	a82d                	j	880 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 848:	fd043783          	ld	a5,-48(s0)
 84c:	93f1                	srli	a5,a5,0x3c
 84e:	00000717          	auipc	a4,0x0
 852:	7b270713          	addi	a4,a4,1970 # 1000 <digits>
 856:	97ba                	add	a5,a5,a4
 858:	0007c703          	lbu	a4,0(a5)
 85c:	fdc42783          	lw	a5,-36(s0)
 860:	85ba                	mv	a1,a4
 862:	853e                	mv	a0,a5
 864:	00000097          	auipc	ra,0x0
 868:	e64080e7          	jalr	-412(ra) # 6c8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 86c:	fec42783          	lw	a5,-20(s0)
 870:	2785                	addiw	a5,a5,1
 872:	fef42623          	sw	a5,-20(s0)
 876:	fd043783          	ld	a5,-48(s0)
 87a:	0792                	slli	a5,a5,0x4
 87c:	fcf43823          	sd	a5,-48(s0)
 880:	fec42783          	lw	a5,-20(s0)
 884:	873e                	mv	a4,a5
 886:	47bd                	li	a5,15
 888:	fce7f0e3          	bgeu	a5,a4,848 <printptr+0x3c>
}
 88c:	0001                	nop
 88e:	0001                	nop
 890:	70a2                	ld	ra,40(sp)
 892:	7402                	ld	s0,32(sp)
 894:	6145                	addi	sp,sp,48
 896:	8082                	ret

0000000000000898 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 898:	715d                	addi	sp,sp,-80
 89a:	e486                	sd	ra,72(sp)
 89c:	e0a2                	sd	s0,64(sp)
 89e:	0880                	addi	s0,sp,80
 8a0:	87aa                	mv	a5,a0
 8a2:	fcb43023          	sd	a1,-64(s0)
 8a6:	fac43c23          	sd	a2,-72(s0)
 8aa:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 8ae:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 8b2:	fe042223          	sw	zero,-28(s0)
 8b6:	a42d                	j	ae0 <vprintf+0x248>
    c = fmt[i] & 0xff;
 8b8:	fe442783          	lw	a5,-28(s0)
 8bc:	fc043703          	ld	a4,-64(s0)
 8c0:	97ba                	add	a5,a5,a4
 8c2:	0007c783          	lbu	a5,0(a5)
 8c6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 8ca:	fe042783          	lw	a5,-32(s0)
 8ce:	2781                	sext.w	a5,a5
 8d0:	eb9d                	bnez	a5,906 <vprintf+0x6e>
      if(c == '%'){
 8d2:	fdc42783          	lw	a5,-36(s0)
 8d6:	0007871b          	sext.w	a4,a5
 8da:	02500793          	li	a5,37
 8de:	00f71763          	bne	a4,a5,8ec <vprintf+0x54>
        state = '%';
 8e2:	02500793          	li	a5,37
 8e6:	fef42023          	sw	a5,-32(s0)
 8ea:	a2f5                	j	ad6 <vprintf+0x23e>
      } else {
        putc(fd, c);
 8ec:	fdc42783          	lw	a5,-36(s0)
 8f0:	0ff7f713          	andi	a4,a5,255
 8f4:	fcc42783          	lw	a5,-52(s0)
 8f8:	85ba                	mv	a1,a4
 8fa:	853e                	mv	a0,a5
 8fc:	00000097          	auipc	ra,0x0
 900:	dcc080e7          	jalr	-564(ra) # 6c8 <putc>
 904:	aac9                	j	ad6 <vprintf+0x23e>
      }
    } else if(state == '%'){
 906:	fe042783          	lw	a5,-32(s0)
 90a:	0007871b          	sext.w	a4,a5
 90e:	02500793          	li	a5,37
 912:	1cf71263          	bne	a4,a5,ad6 <vprintf+0x23e>
      if(c == 'd'){
 916:	fdc42783          	lw	a5,-36(s0)
 91a:	0007871b          	sext.w	a4,a5
 91e:	06400793          	li	a5,100
 922:	02f71463          	bne	a4,a5,94a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 926:	fb843783          	ld	a5,-72(s0)
 92a:	00878713          	addi	a4,a5,8
 92e:	fae43c23          	sd	a4,-72(s0)
 932:	4398                	lw	a4,0(a5)
 934:	fcc42783          	lw	a5,-52(s0)
 938:	4685                	li	a3,1
 93a:	4629                	li	a2,10
 93c:	85ba                	mv	a1,a4
 93e:	853e                	mv	a0,a5
 940:	00000097          	auipc	ra,0x0
 944:	dbe080e7          	jalr	-578(ra) # 6fe <printint>
 948:	a269                	j	ad2 <vprintf+0x23a>
      } else if(c == 'l') {
 94a:	fdc42783          	lw	a5,-36(s0)
 94e:	0007871b          	sext.w	a4,a5
 952:	06c00793          	li	a5,108
 956:	02f71663          	bne	a4,a5,982 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 95a:	fb843783          	ld	a5,-72(s0)
 95e:	00878713          	addi	a4,a5,8
 962:	fae43c23          	sd	a4,-72(s0)
 966:	639c                	ld	a5,0(a5)
 968:	0007871b          	sext.w	a4,a5
 96c:	fcc42783          	lw	a5,-52(s0)
 970:	4681                	li	a3,0
 972:	4629                	li	a2,10
 974:	85ba                	mv	a1,a4
 976:	853e                	mv	a0,a5
 978:	00000097          	auipc	ra,0x0
 97c:	d86080e7          	jalr	-634(ra) # 6fe <printint>
 980:	aa89                	j	ad2 <vprintf+0x23a>
      } else if(c == 'x') {
 982:	fdc42783          	lw	a5,-36(s0)
 986:	0007871b          	sext.w	a4,a5
 98a:	07800793          	li	a5,120
 98e:	02f71463          	bne	a4,a5,9b6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 992:	fb843783          	ld	a5,-72(s0)
 996:	00878713          	addi	a4,a5,8
 99a:	fae43c23          	sd	a4,-72(s0)
 99e:	4398                	lw	a4,0(a5)
 9a0:	fcc42783          	lw	a5,-52(s0)
 9a4:	4681                	li	a3,0
 9a6:	4641                	li	a2,16
 9a8:	85ba                	mv	a1,a4
 9aa:	853e                	mv	a0,a5
 9ac:	00000097          	auipc	ra,0x0
 9b0:	d52080e7          	jalr	-686(ra) # 6fe <printint>
 9b4:	aa39                	j	ad2 <vprintf+0x23a>
      } else if(c == 'p') {
 9b6:	fdc42783          	lw	a5,-36(s0)
 9ba:	0007871b          	sext.w	a4,a5
 9be:	07000793          	li	a5,112
 9c2:	02f71263          	bne	a4,a5,9e6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 9c6:	fb843783          	ld	a5,-72(s0)
 9ca:	00878713          	addi	a4,a5,8
 9ce:	fae43c23          	sd	a4,-72(s0)
 9d2:	6398                	ld	a4,0(a5)
 9d4:	fcc42783          	lw	a5,-52(s0)
 9d8:	85ba                	mv	a1,a4
 9da:	853e                	mv	a0,a5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	e30080e7          	jalr	-464(ra) # 80c <printptr>
 9e4:	a0fd                	j	ad2 <vprintf+0x23a>
      } else if(c == 's'){
 9e6:	fdc42783          	lw	a5,-36(s0)
 9ea:	0007871b          	sext.w	a4,a5
 9ee:	07300793          	li	a5,115
 9f2:	04f71c63          	bne	a4,a5,a4a <vprintf+0x1b2>
        s = va_arg(ap, char*);
 9f6:	fb843783          	ld	a5,-72(s0)
 9fa:	00878713          	addi	a4,a5,8
 9fe:	fae43c23          	sd	a4,-72(s0)
 a02:	639c                	ld	a5,0(a5)
 a04:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 a08:	fe843783          	ld	a5,-24(s0)
 a0c:	eb8d                	bnez	a5,a3e <vprintf+0x1a6>
          s = "(null)";
 a0e:	00000797          	auipc	a5,0x0
 a12:	4ca78793          	addi	a5,a5,1226 # ed8 <malloc+0x190>
 a16:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a1a:	a015                	j	a3e <vprintf+0x1a6>
          putc(fd, *s);
 a1c:	fe843783          	ld	a5,-24(s0)
 a20:	0007c703          	lbu	a4,0(a5)
 a24:	fcc42783          	lw	a5,-52(s0)
 a28:	85ba                	mv	a1,a4
 a2a:	853e                	mv	a0,a5
 a2c:	00000097          	auipc	ra,0x0
 a30:	c9c080e7          	jalr	-868(ra) # 6c8 <putc>
          s++;
 a34:	fe843783          	ld	a5,-24(s0)
 a38:	0785                	addi	a5,a5,1
 a3a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 a3e:	fe843783          	ld	a5,-24(s0)
 a42:	0007c783          	lbu	a5,0(a5)
 a46:	fbf9                	bnez	a5,a1c <vprintf+0x184>
 a48:	a069                	j	ad2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a4a:	fdc42783          	lw	a5,-36(s0)
 a4e:	0007871b          	sext.w	a4,a5
 a52:	06300793          	li	a5,99
 a56:	02f71463          	bne	a4,a5,a7e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a5a:	fb843783          	ld	a5,-72(s0)
 a5e:	00878713          	addi	a4,a5,8
 a62:	fae43c23          	sd	a4,-72(s0)
 a66:	439c                	lw	a5,0(a5)
 a68:	0ff7f713          	andi	a4,a5,255
 a6c:	fcc42783          	lw	a5,-52(s0)
 a70:	85ba                	mv	a1,a4
 a72:	853e                	mv	a0,a5
 a74:	00000097          	auipc	ra,0x0
 a78:	c54080e7          	jalr	-940(ra) # 6c8 <putc>
 a7c:	a899                	j	ad2 <vprintf+0x23a>
      } else if(c == '%'){
 a7e:	fdc42783          	lw	a5,-36(s0)
 a82:	0007871b          	sext.w	a4,a5
 a86:	02500793          	li	a5,37
 a8a:	00f71f63          	bne	a4,a5,aa8 <vprintf+0x210>
        putc(fd, c);
 a8e:	fdc42783          	lw	a5,-36(s0)
 a92:	0ff7f713          	andi	a4,a5,255
 a96:	fcc42783          	lw	a5,-52(s0)
 a9a:	85ba                	mv	a1,a4
 a9c:	853e                	mv	a0,a5
 a9e:	00000097          	auipc	ra,0x0
 aa2:	c2a080e7          	jalr	-982(ra) # 6c8 <putc>
 aa6:	a035                	j	ad2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 aa8:	fcc42783          	lw	a5,-52(s0)
 aac:	02500593          	li	a1,37
 ab0:	853e                	mv	a0,a5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	c16080e7          	jalr	-1002(ra) # 6c8 <putc>
        putc(fd, c);
 aba:	fdc42783          	lw	a5,-36(s0)
 abe:	0ff7f713          	andi	a4,a5,255
 ac2:	fcc42783          	lw	a5,-52(s0)
 ac6:	85ba                	mv	a1,a4
 ac8:	853e                	mv	a0,a5
 aca:	00000097          	auipc	ra,0x0
 ace:	bfe080e7          	jalr	-1026(ra) # 6c8 <putc>
      }
      state = 0;
 ad2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 ad6:	fe442783          	lw	a5,-28(s0)
 ada:	2785                	addiw	a5,a5,1
 adc:	fef42223          	sw	a5,-28(s0)
 ae0:	fe442783          	lw	a5,-28(s0)
 ae4:	fc043703          	ld	a4,-64(s0)
 ae8:	97ba                	add	a5,a5,a4
 aea:	0007c783          	lbu	a5,0(a5)
 aee:	dc0795e3          	bnez	a5,8b8 <vprintf+0x20>
    }
  }
}
 af2:	0001                	nop
 af4:	0001                	nop
 af6:	60a6                	ld	ra,72(sp)
 af8:	6406                	ld	s0,64(sp)
 afa:	6161                	addi	sp,sp,80
 afc:	8082                	ret

0000000000000afe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 afe:	7159                	addi	sp,sp,-112
 b00:	fc06                	sd	ra,56(sp)
 b02:	f822                	sd	s0,48(sp)
 b04:	0080                	addi	s0,sp,64
 b06:	fcb43823          	sd	a1,-48(s0)
 b0a:	e010                	sd	a2,0(s0)
 b0c:	e414                	sd	a3,8(s0)
 b0e:	e818                	sd	a4,16(s0)
 b10:	ec1c                	sd	a5,24(s0)
 b12:	03043023          	sd	a6,32(s0)
 b16:	03143423          	sd	a7,40(s0)
 b1a:	87aa                	mv	a5,a0
 b1c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 b20:	03040793          	addi	a5,s0,48
 b24:	fcf43423          	sd	a5,-56(s0)
 b28:	fc843783          	ld	a5,-56(s0)
 b2c:	fd078793          	addi	a5,a5,-48
 b30:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 b34:	fe843703          	ld	a4,-24(s0)
 b38:	fdc42783          	lw	a5,-36(s0)
 b3c:	863a                	mv	a2,a4
 b3e:	fd043583          	ld	a1,-48(s0)
 b42:	853e                	mv	a0,a5
 b44:	00000097          	auipc	ra,0x0
 b48:	d54080e7          	jalr	-684(ra) # 898 <vprintf>
}
 b4c:	0001                	nop
 b4e:	70e2                	ld	ra,56(sp)
 b50:	7442                	ld	s0,48(sp)
 b52:	6165                	addi	sp,sp,112
 b54:	8082                	ret

0000000000000b56 <printf>:

void
printf(const char *fmt, ...)
{
 b56:	7159                	addi	sp,sp,-112
 b58:	f406                	sd	ra,40(sp)
 b5a:	f022                	sd	s0,32(sp)
 b5c:	1800                	addi	s0,sp,48
 b5e:	fca43c23          	sd	a0,-40(s0)
 b62:	e40c                	sd	a1,8(s0)
 b64:	e810                	sd	a2,16(s0)
 b66:	ec14                	sd	a3,24(s0)
 b68:	f018                	sd	a4,32(s0)
 b6a:	f41c                	sd	a5,40(s0)
 b6c:	03043823          	sd	a6,48(s0)
 b70:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b74:	04040793          	addi	a5,s0,64
 b78:	fcf43823          	sd	a5,-48(s0)
 b7c:	fd043783          	ld	a5,-48(s0)
 b80:	fc878793          	addi	a5,a5,-56
 b84:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b88:	fe843783          	ld	a5,-24(s0)
 b8c:	863e                	mv	a2,a5
 b8e:	fd843583          	ld	a1,-40(s0)
 b92:	4505                	li	a0,1
 b94:	00000097          	auipc	ra,0x0
 b98:	d04080e7          	jalr	-764(ra) # 898 <vprintf>
}
 b9c:	0001                	nop
 b9e:	70a2                	ld	ra,40(sp)
 ba0:	7402                	ld	s0,32(sp)
 ba2:	6165                	addi	sp,sp,112
 ba4:	8082                	ret

0000000000000ba6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ba6:	7179                	addi	sp,sp,-48
 ba8:	f422                	sd	s0,40(sp)
 baa:	1800                	addi	s0,sp,48
 bac:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bb0:	fd843783          	ld	a5,-40(s0)
 bb4:	17c1                	addi	a5,a5,-16
 bb6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bba:	00000797          	auipc	a5,0x0
 bbe:	67678793          	addi	a5,a5,1654 # 1230 <freep>
 bc2:	639c                	ld	a5,0(a5)
 bc4:	fef43423          	sd	a5,-24(s0)
 bc8:	a815                	j	bfc <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bca:	fe843783          	ld	a5,-24(s0)
 bce:	639c                	ld	a5,0(a5)
 bd0:	fe843703          	ld	a4,-24(s0)
 bd4:	00f76f63          	bltu	a4,a5,bf2 <free+0x4c>
 bd8:	fe043703          	ld	a4,-32(s0)
 bdc:	fe843783          	ld	a5,-24(s0)
 be0:	02e7eb63          	bltu	a5,a4,c16 <free+0x70>
 be4:	fe843783          	ld	a5,-24(s0)
 be8:	639c                	ld	a5,0(a5)
 bea:	fe043703          	ld	a4,-32(s0)
 bee:	02f76463          	bltu	a4,a5,c16 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf2:	fe843783          	ld	a5,-24(s0)
 bf6:	639c                	ld	a5,0(a5)
 bf8:	fef43423          	sd	a5,-24(s0)
 bfc:	fe043703          	ld	a4,-32(s0)
 c00:	fe843783          	ld	a5,-24(s0)
 c04:	fce7f3e3          	bgeu	a5,a4,bca <free+0x24>
 c08:	fe843783          	ld	a5,-24(s0)
 c0c:	639c                	ld	a5,0(a5)
 c0e:	fe043703          	ld	a4,-32(s0)
 c12:	faf77ce3          	bgeu	a4,a5,bca <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c16:	fe043783          	ld	a5,-32(s0)
 c1a:	479c                	lw	a5,8(a5)
 c1c:	1782                	slli	a5,a5,0x20
 c1e:	9381                	srli	a5,a5,0x20
 c20:	0792                	slli	a5,a5,0x4
 c22:	fe043703          	ld	a4,-32(s0)
 c26:	973e                	add	a4,a4,a5
 c28:	fe843783          	ld	a5,-24(s0)
 c2c:	639c                	ld	a5,0(a5)
 c2e:	02f71763          	bne	a4,a5,c5c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 c32:	fe043783          	ld	a5,-32(s0)
 c36:	4798                	lw	a4,8(a5)
 c38:	fe843783          	ld	a5,-24(s0)
 c3c:	639c                	ld	a5,0(a5)
 c3e:	479c                	lw	a5,8(a5)
 c40:	9fb9                	addw	a5,a5,a4
 c42:	0007871b          	sext.w	a4,a5
 c46:	fe043783          	ld	a5,-32(s0)
 c4a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c4c:	fe843783          	ld	a5,-24(s0)
 c50:	639c                	ld	a5,0(a5)
 c52:	6398                	ld	a4,0(a5)
 c54:	fe043783          	ld	a5,-32(s0)
 c58:	e398                	sd	a4,0(a5)
 c5a:	a039                	j	c68 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c5c:	fe843783          	ld	a5,-24(s0)
 c60:	6398                	ld	a4,0(a5)
 c62:	fe043783          	ld	a5,-32(s0)
 c66:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c68:	fe843783          	ld	a5,-24(s0)
 c6c:	479c                	lw	a5,8(a5)
 c6e:	1782                	slli	a5,a5,0x20
 c70:	9381                	srli	a5,a5,0x20
 c72:	0792                	slli	a5,a5,0x4
 c74:	fe843703          	ld	a4,-24(s0)
 c78:	97ba                	add	a5,a5,a4
 c7a:	fe043703          	ld	a4,-32(s0)
 c7e:	02f71563          	bne	a4,a5,ca8 <free+0x102>
    p->s.size += bp->s.size;
 c82:	fe843783          	ld	a5,-24(s0)
 c86:	4798                	lw	a4,8(a5)
 c88:	fe043783          	ld	a5,-32(s0)
 c8c:	479c                	lw	a5,8(a5)
 c8e:	9fb9                	addw	a5,a5,a4
 c90:	0007871b          	sext.w	a4,a5
 c94:	fe843783          	ld	a5,-24(s0)
 c98:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c9a:	fe043783          	ld	a5,-32(s0)
 c9e:	6398                	ld	a4,0(a5)
 ca0:	fe843783          	ld	a5,-24(s0)
 ca4:	e398                	sd	a4,0(a5)
 ca6:	a031                	j	cb2 <free+0x10c>
  } else
    p->s.ptr = bp;
 ca8:	fe843783          	ld	a5,-24(s0)
 cac:	fe043703          	ld	a4,-32(s0)
 cb0:	e398                	sd	a4,0(a5)
  freep = p;
 cb2:	00000797          	auipc	a5,0x0
 cb6:	57e78793          	addi	a5,a5,1406 # 1230 <freep>
 cba:	fe843703          	ld	a4,-24(s0)
 cbe:	e398                	sd	a4,0(a5)
}
 cc0:	0001                	nop
 cc2:	7422                	ld	s0,40(sp)
 cc4:	6145                	addi	sp,sp,48
 cc6:	8082                	ret

0000000000000cc8 <morecore>:

static Header*
morecore(uint nu)
{
 cc8:	7179                	addi	sp,sp,-48
 cca:	f406                	sd	ra,40(sp)
 ccc:	f022                	sd	s0,32(sp)
 cce:	1800                	addi	s0,sp,48
 cd0:	87aa                	mv	a5,a0
 cd2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 cd6:	fdc42783          	lw	a5,-36(s0)
 cda:	0007871b          	sext.w	a4,a5
 cde:	6785                	lui	a5,0x1
 ce0:	00f77563          	bgeu	a4,a5,cea <morecore+0x22>
    nu = 4096;
 ce4:	6785                	lui	a5,0x1
 ce6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 cea:	fdc42783          	lw	a5,-36(s0)
 cee:	0047979b          	slliw	a5,a5,0x4
 cf2:	2781                	sext.w	a5,a5
 cf4:	2781                	sext.w	a5,a5
 cf6:	853e                	mv	a0,a5
 cf8:	00000097          	auipc	ra,0x0
 cfc:	9b8080e7          	jalr	-1608(ra) # 6b0 <sbrk>
 d00:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 d04:	fe843703          	ld	a4,-24(s0)
 d08:	57fd                	li	a5,-1
 d0a:	00f71463          	bne	a4,a5,d12 <morecore+0x4a>
    return 0;
 d0e:	4781                	li	a5,0
 d10:	a03d                	j	d3e <morecore+0x76>
  hp = (Header*)p;
 d12:	fe843783          	ld	a5,-24(s0)
 d16:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 d1a:	fe043783          	ld	a5,-32(s0)
 d1e:	fdc42703          	lw	a4,-36(s0)
 d22:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 d24:	fe043783          	ld	a5,-32(s0)
 d28:	07c1                	addi	a5,a5,16
 d2a:	853e                	mv	a0,a5
 d2c:	00000097          	auipc	ra,0x0
 d30:	e7a080e7          	jalr	-390(ra) # ba6 <free>
  return freep;
 d34:	00000797          	auipc	a5,0x0
 d38:	4fc78793          	addi	a5,a5,1276 # 1230 <freep>
 d3c:	639c                	ld	a5,0(a5)
}
 d3e:	853e                	mv	a0,a5
 d40:	70a2                	ld	ra,40(sp)
 d42:	7402                	ld	s0,32(sp)
 d44:	6145                	addi	sp,sp,48
 d46:	8082                	ret

0000000000000d48 <malloc>:

void*
malloc(uint nbytes)
{
 d48:	7139                	addi	sp,sp,-64
 d4a:	fc06                	sd	ra,56(sp)
 d4c:	f822                	sd	s0,48(sp)
 d4e:	0080                	addi	s0,sp,64
 d50:	87aa                	mv	a5,a0
 d52:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d56:	fcc46783          	lwu	a5,-52(s0)
 d5a:	07bd                	addi	a5,a5,15
 d5c:	8391                	srli	a5,a5,0x4
 d5e:	2781                	sext.w	a5,a5
 d60:	2785                	addiw	a5,a5,1
 d62:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d66:	00000797          	auipc	a5,0x0
 d6a:	4ca78793          	addi	a5,a5,1226 # 1230 <freep>
 d6e:	639c                	ld	a5,0(a5)
 d70:	fef43023          	sd	a5,-32(s0)
 d74:	fe043783          	ld	a5,-32(s0)
 d78:	ef95                	bnez	a5,db4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d7a:	00000797          	auipc	a5,0x0
 d7e:	4a678793          	addi	a5,a5,1190 # 1220 <base>
 d82:	fef43023          	sd	a5,-32(s0)
 d86:	00000797          	auipc	a5,0x0
 d8a:	4aa78793          	addi	a5,a5,1194 # 1230 <freep>
 d8e:	fe043703          	ld	a4,-32(s0)
 d92:	e398                	sd	a4,0(a5)
 d94:	00000797          	auipc	a5,0x0
 d98:	49c78793          	addi	a5,a5,1180 # 1230 <freep>
 d9c:	6398                	ld	a4,0(a5)
 d9e:	00000797          	auipc	a5,0x0
 da2:	48278793          	addi	a5,a5,1154 # 1220 <base>
 da6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 da8:	00000797          	auipc	a5,0x0
 dac:	47878793          	addi	a5,a5,1144 # 1220 <base>
 db0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 db4:	fe043783          	ld	a5,-32(s0)
 db8:	639c                	ld	a5,0(a5)
 dba:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 dbe:	fe843783          	ld	a5,-24(s0)
 dc2:	4798                	lw	a4,8(a5)
 dc4:	fdc42783          	lw	a5,-36(s0)
 dc8:	2781                	sext.w	a5,a5
 dca:	06f76863          	bltu	a4,a5,e3a <malloc+0xf2>
      if(p->s.size == nunits)
 dce:	fe843783          	ld	a5,-24(s0)
 dd2:	4798                	lw	a4,8(a5)
 dd4:	fdc42783          	lw	a5,-36(s0)
 dd8:	2781                	sext.w	a5,a5
 dda:	00e79963          	bne	a5,a4,dec <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 dde:	fe843783          	ld	a5,-24(s0)
 de2:	6398                	ld	a4,0(a5)
 de4:	fe043783          	ld	a5,-32(s0)
 de8:	e398                	sd	a4,0(a5)
 dea:	a82d                	j	e24 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 dec:	fe843783          	ld	a5,-24(s0)
 df0:	4798                	lw	a4,8(a5)
 df2:	fdc42783          	lw	a5,-36(s0)
 df6:	40f707bb          	subw	a5,a4,a5
 dfa:	0007871b          	sext.w	a4,a5
 dfe:	fe843783          	ld	a5,-24(s0)
 e02:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e04:	fe843783          	ld	a5,-24(s0)
 e08:	479c                	lw	a5,8(a5)
 e0a:	1782                	slli	a5,a5,0x20
 e0c:	9381                	srli	a5,a5,0x20
 e0e:	0792                	slli	a5,a5,0x4
 e10:	fe843703          	ld	a4,-24(s0)
 e14:	97ba                	add	a5,a5,a4
 e16:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 e1a:	fe843783          	ld	a5,-24(s0)
 e1e:	fdc42703          	lw	a4,-36(s0)
 e22:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 e24:	00000797          	auipc	a5,0x0
 e28:	40c78793          	addi	a5,a5,1036 # 1230 <freep>
 e2c:	fe043703          	ld	a4,-32(s0)
 e30:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 e32:	fe843783          	ld	a5,-24(s0)
 e36:	07c1                	addi	a5,a5,16
 e38:	a091                	j	e7c <malloc+0x134>
    }
    if(p == freep)
 e3a:	00000797          	auipc	a5,0x0
 e3e:	3f678793          	addi	a5,a5,1014 # 1230 <freep>
 e42:	639c                	ld	a5,0(a5)
 e44:	fe843703          	ld	a4,-24(s0)
 e48:	02f71063          	bne	a4,a5,e68 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 e4c:	fdc42783          	lw	a5,-36(s0)
 e50:	853e                	mv	a0,a5
 e52:	00000097          	auipc	ra,0x0
 e56:	e76080e7          	jalr	-394(ra) # cc8 <morecore>
 e5a:	fea43423          	sd	a0,-24(s0)
 e5e:	fe843783          	ld	a5,-24(s0)
 e62:	e399                	bnez	a5,e68 <malloc+0x120>
        return 0;
 e64:	4781                	li	a5,0
 e66:	a819                	j	e7c <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e68:	fe843783          	ld	a5,-24(s0)
 e6c:	fef43023          	sd	a5,-32(s0)
 e70:	fe843783          	ld	a5,-24(s0)
 e74:	639c                	ld	a5,0(a5)
 e76:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e7a:	b791                	j	dbe <malloc+0x76>
  }
}
 e7c:	853e                	mv	a0,a5
 e7e:	70e2                	ld	ra,56(sp)
 e80:	7442                	ld	s0,48(sp)
 e82:	6121                	addi	sp,sp,64
 e84:	8082                	ret
