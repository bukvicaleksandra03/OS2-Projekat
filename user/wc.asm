
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	0080                	addi	s0,sp,64
   8:	87aa                	mv	a5,a0
   a:	fcb43023          	sd	a1,-64(s0)
   e:	fcf42623          	sw	a5,-52(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  12:	fe042023          	sw	zero,-32(s0)
  16:	fe042783          	lw	a5,-32(s0)
  1a:	fef42223          	sw	a5,-28(s0)
  1e:	fe442783          	lw	a5,-28(s0)
  22:	fef42423          	sw	a5,-24(s0)
  inword = 0;
  26:	fc042e23          	sw	zero,-36(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2a:	a859                	j	c0 <wc+0xc0>
    for(i=0; i<n; i++){
  2c:	fe042623          	sw	zero,-20(s0)
  30:	a041                	j	b0 <wc+0xb0>
      c++;
  32:	fe042783          	lw	a5,-32(s0)
  36:	2785                	addiw	a5,a5,1
  38:	fef42023          	sw	a5,-32(s0)
      if(buf[i] == '\n')
  3c:	00001717          	auipc	a4,0x1
  40:	fe470713          	addi	a4,a4,-28 # 1020 <buf>
  44:	fec42783          	lw	a5,-20(s0)
  48:	97ba                	add	a5,a5,a4
  4a:	0007c783          	lbu	a5,0(a5)
  4e:	873e                	mv	a4,a5
  50:	47a9                	li	a5,10
  52:	00f71763          	bne	a4,a5,60 <wc+0x60>
        l++;
  56:	fe842783          	lw	a5,-24(s0)
  5a:	2785                	addiw	a5,a5,1
  5c:	fef42423          	sw	a5,-24(s0)
      if(strchr(" \r\t\n\v", buf[i]))
  60:	00001717          	auipc	a4,0x1
  64:	fc070713          	addi	a4,a4,-64 # 1020 <buf>
  68:	fec42783          	lw	a5,-20(s0)
  6c:	97ba                	add	a5,a5,a4
  6e:	0007c783          	lbu	a5,0(a5)
  72:	85be                	mv	a1,a5
  74:	00001517          	auipc	a0,0x1
  78:	ebc50513          	addi	a0,a0,-324 # f30 <malloc+0x144>
  7c:	00000097          	auipc	ra,0x0
  80:	306080e7          	jalr	774(ra) # 382 <strchr>
  84:	87aa                	mv	a5,a0
  86:	c781                	beqz	a5,8e <wc+0x8e>
        inword = 0;
  88:	fc042e23          	sw	zero,-36(s0)
  8c:	a829                	j	a6 <wc+0xa6>
      else if(!inword){
  8e:	fdc42783          	lw	a5,-36(s0)
  92:	2781                	sext.w	a5,a5
  94:	eb89                	bnez	a5,a6 <wc+0xa6>
        w++;
  96:	fe442783          	lw	a5,-28(s0)
  9a:	2785                	addiw	a5,a5,1
  9c:	fef42223          	sw	a5,-28(s0)
        inword = 1;
  a0:	4785                	li	a5,1
  a2:	fcf42e23          	sw	a5,-36(s0)
    for(i=0; i<n; i++){
  a6:	fec42783          	lw	a5,-20(s0)
  aa:	2785                	addiw	a5,a5,1
  ac:	fef42623          	sw	a5,-20(s0)
  b0:	fec42703          	lw	a4,-20(s0)
  b4:	fd842783          	lw	a5,-40(s0)
  b8:	2701                	sext.w	a4,a4
  ba:	2781                	sext.w	a5,a5
  bc:	f6f74be3          	blt	a4,a5,32 <wc+0x32>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	fcc42783          	lw	a5,-52(s0)
  c4:	20000613          	li	a2,512
  c8:	00001597          	auipc	a1,0x1
  cc:	f5858593          	addi	a1,a1,-168 # 1020 <buf>
  d0:	853e                	mv	a0,a5
  d2:	00000097          	auipc	ra,0x0
  d6:	612080e7          	jalr	1554(ra) # 6e4 <read>
  da:	87aa                	mv	a5,a0
  dc:	fcf42c23          	sw	a5,-40(s0)
  e0:	fd842783          	lw	a5,-40(s0)
  e4:	2781                	sext.w	a5,a5
  e6:	f4f043e3          	bgtz	a5,2c <wc+0x2c>
      }
    }
  }
  if(n < 0){
  ea:	fd842783          	lw	a5,-40(s0)
  ee:	2781                	sext.w	a5,a5
  f0:	0007df63          	bgez	a5,10e <wc+0x10e>
    printf("wc: read error\n");
  f4:	00001517          	auipc	a0,0x1
  f8:	e4450513          	addi	a0,a0,-444 # f38 <malloc+0x14c>
  fc:	00001097          	auipc	ra,0x1
 100:	afe080e7          	jalr	-1282(ra) # bfa <printf>
    exit(1);
 104:	4505                	li	a0,1
 106:	00000097          	auipc	ra,0x0
 10a:	5c6080e7          	jalr	1478(ra) # 6cc <exit>
  }
  printf("%d %d %d %s\n", l, w, c, name);
 10e:	fe042683          	lw	a3,-32(s0)
 112:	fe442603          	lw	a2,-28(s0)
 116:	fe842783          	lw	a5,-24(s0)
 11a:	fc043703          	ld	a4,-64(s0)
 11e:	85be                	mv	a1,a5
 120:	00001517          	auipc	a0,0x1
 124:	e2850513          	addi	a0,a0,-472 # f48 <malloc+0x15c>
 128:	00001097          	auipc	ra,0x1
 12c:	ad2080e7          	jalr	-1326(ra) # bfa <printf>
}
 130:	0001                	nop
 132:	70e2                	ld	ra,56(sp)
 134:	7442                	ld	s0,48(sp)
 136:	6121                	addi	sp,sp,64
 138:	8082                	ret

000000000000013a <main>:

int
main(int argc, char *argv[])
{
 13a:	7179                	addi	sp,sp,-48
 13c:	f406                	sd	ra,40(sp)
 13e:	f022                	sd	s0,32(sp)
 140:	1800                	addi	s0,sp,48
 142:	87aa                	mv	a5,a0
 144:	fcb43823          	sd	a1,-48(s0)
 148:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
 14c:	fdc42783          	lw	a5,-36(s0)
 150:	0007871b          	sext.w	a4,a5
 154:	4785                	li	a5,1
 156:	02e7c063          	blt	a5,a4,176 <main+0x3c>
    wc(0, "");
 15a:	00001597          	auipc	a1,0x1
 15e:	dfe58593          	addi	a1,a1,-514 # f58 <malloc+0x16c>
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	e9c080e7          	jalr	-356(ra) # 0 <wc>
    exit(0);
 16c:	4501                	li	a0,0
 16e:	00000097          	auipc	ra,0x0
 172:	55e080e7          	jalr	1374(ra) # 6cc <exit>
  }

  for(i = 1; i < argc; i++){
 176:	4785                	li	a5,1
 178:	fef42623          	sw	a5,-20(s0)
 17c:	a071                	j	208 <main+0xce>
    if((fd = open(argv[i], 0)) < 0){
 17e:	fec42783          	lw	a5,-20(s0)
 182:	078e                	slli	a5,a5,0x3
 184:	fd043703          	ld	a4,-48(s0)
 188:	97ba                	add	a5,a5,a4
 18a:	639c                	ld	a5,0(a5)
 18c:	4581                	li	a1,0
 18e:	853e                	mv	a0,a5
 190:	00000097          	auipc	ra,0x0
 194:	57c080e7          	jalr	1404(ra) # 70c <open>
 198:	87aa                	mv	a5,a0
 19a:	fef42423          	sw	a5,-24(s0)
 19e:	fe842783          	lw	a5,-24(s0)
 1a2:	2781                	sext.w	a5,a5
 1a4:	0207d763          	bgez	a5,1d2 <main+0x98>
      printf("wc: cannot open %s\n", argv[i]);
 1a8:	fec42783          	lw	a5,-20(s0)
 1ac:	078e                	slli	a5,a5,0x3
 1ae:	fd043703          	ld	a4,-48(s0)
 1b2:	97ba                	add	a5,a5,a4
 1b4:	639c                	ld	a5,0(a5)
 1b6:	85be                	mv	a1,a5
 1b8:	00001517          	auipc	a0,0x1
 1bc:	da850513          	addi	a0,a0,-600 # f60 <malloc+0x174>
 1c0:	00001097          	auipc	ra,0x1
 1c4:	a3a080e7          	jalr	-1478(ra) # bfa <printf>
      exit(1);
 1c8:	4505                	li	a0,1
 1ca:	00000097          	auipc	ra,0x0
 1ce:	502080e7          	jalr	1282(ra) # 6cc <exit>
    }
    wc(fd, argv[i]);
 1d2:	fec42783          	lw	a5,-20(s0)
 1d6:	078e                	slli	a5,a5,0x3
 1d8:	fd043703          	ld	a4,-48(s0)
 1dc:	97ba                	add	a5,a5,a4
 1de:	6398                	ld	a4,0(a5)
 1e0:	fe842783          	lw	a5,-24(s0)
 1e4:	85ba                	mv	a1,a4
 1e6:	853e                	mv	a0,a5
 1e8:	00000097          	auipc	ra,0x0
 1ec:	e18080e7          	jalr	-488(ra) # 0 <wc>
    close(fd);
 1f0:	fe842783          	lw	a5,-24(s0)
 1f4:	853e                	mv	a0,a5
 1f6:	00000097          	auipc	ra,0x0
 1fa:	4fe080e7          	jalr	1278(ra) # 6f4 <close>
  for(i = 1; i < argc; i++){
 1fe:	fec42783          	lw	a5,-20(s0)
 202:	2785                	addiw	a5,a5,1
 204:	fef42623          	sw	a5,-20(s0)
 208:	fec42703          	lw	a4,-20(s0)
 20c:	fdc42783          	lw	a5,-36(s0)
 210:	2701                	sext.w	a4,a4
 212:	2781                	sext.w	a5,a5
 214:	f6f745e3          	blt	a4,a5,17e <main+0x44>
  }
  exit(0);
 218:	4501                	li	a0,0
 21a:	00000097          	auipc	ra,0x0
 21e:	4b2080e7          	jalr	1202(ra) # 6cc <exit>

0000000000000222 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 222:	1141                	addi	sp,sp,-16
 224:	e406                	sd	ra,8(sp)
 226:	e022                	sd	s0,0(sp)
 228:	0800                	addi	s0,sp,16
  extern int main();
  main();
 22a:	00000097          	auipc	ra,0x0
 22e:	f10080e7          	jalr	-240(ra) # 13a <main>
  exit(0);
 232:	4501                	li	a0,0
 234:	00000097          	auipc	ra,0x0
 238:	498080e7          	jalr	1176(ra) # 6cc <exit>

000000000000023c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 23c:	7179                	addi	sp,sp,-48
 23e:	f422                	sd	s0,40(sp)
 240:	1800                	addi	s0,sp,48
 242:	fca43c23          	sd	a0,-40(s0)
 246:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 24a:	fd843783          	ld	a5,-40(s0)
 24e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 252:	0001                	nop
 254:	fd043703          	ld	a4,-48(s0)
 258:	00170793          	addi	a5,a4,1
 25c:	fcf43823          	sd	a5,-48(s0)
 260:	fd843783          	ld	a5,-40(s0)
 264:	00178693          	addi	a3,a5,1
 268:	fcd43c23          	sd	a3,-40(s0)
 26c:	00074703          	lbu	a4,0(a4)
 270:	00e78023          	sb	a4,0(a5)
 274:	0007c783          	lbu	a5,0(a5)
 278:	fff1                	bnez	a5,254 <strcpy+0x18>
    ;
  return os;
 27a:	fe843783          	ld	a5,-24(s0)
}
 27e:	853e                	mv	a0,a5
 280:	7422                	ld	s0,40(sp)
 282:	6145                	addi	sp,sp,48
 284:	8082                	ret

0000000000000286 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 286:	1101                	addi	sp,sp,-32
 288:	ec22                	sd	s0,24(sp)
 28a:	1000                	addi	s0,sp,32
 28c:	fea43423          	sd	a0,-24(s0)
 290:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 294:	a819                	j	2aa <strcmp+0x24>
    p++, q++;
 296:	fe843783          	ld	a5,-24(s0)
 29a:	0785                	addi	a5,a5,1
 29c:	fef43423          	sd	a5,-24(s0)
 2a0:	fe043783          	ld	a5,-32(s0)
 2a4:	0785                	addi	a5,a5,1
 2a6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 2aa:	fe843783          	ld	a5,-24(s0)
 2ae:	0007c783          	lbu	a5,0(a5)
 2b2:	cb99                	beqz	a5,2c8 <strcmp+0x42>
 2b4:	fe843783          	ld	a5,-24(s0)
 2b8:	0007c703          	lbu	a4,0(a5)
 2bc:	fe043783          	ld	a5,-32(s0)
 2c0:	0007c783          	lbu	a5,0(a5)
 2c4:	fcf709e3          	beq	a4,a5,296 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 2c8:	fe843783          	ld	a5,-24(s0)
 2cc:	0007c783          	lbu	a5,0(a5)
 2d0:	0007871b          	sext.w	a4,a5
 2d4:	fe043783          	ld	a5,-32(s0)
 2d8:	0007c783          	lbu	a5,0(a5)
 2dc:	2781                	sext.w	a5,a5
 2de:	40f707bb          	subw	a5,a4,a5
 2e2:	2781                	sext.w	a5,a5
}
 2e4:	853e                	mv	a0,a5
 2e6:	6462                	ld	s0,24(sp)
 2e8:	6105                	addi	sp,sp,32
 2ea:	8082                	ret

00000000000002ec <strlen>:

uint
strlen(const char *s)
{
 2ec:	7179                	addi	sp,sp,-48
 2ee:	f422                	sd	s0,40(sp)
 2f0:	1800                	addi	s0,sp,48
 2f2:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 2f6:	fe042623          	sw	zero,-20(s0)
 2fa:	a031                	j	306 <strlen+0x1a>
 2fc:	fec42783          	lw	a5,-20(s0)
 300:	2785                	addiw	a5,a5,1
 302:	fef42623          	sw	a5,-20(s0)
 306:	fec42783          	lw	a5,-20(s0)
 30a:	fd843703          	ld	a4,-40(s0)
 30e:	97ba                	add	a5,a5,a4
 310:	0007c783          	lbu	a5,0(a5)
 314:	f7e5                	bnez	a5,2fc <strlen+0x10>
    ;
  return n;
 316:	fec42783          	lw	a5,-20(s0)
}
 31a:	853e                	mv	a0,a5
 31c:	7422                	ld	s0,40(sp)
 31e:	6145                	addi	sp,sp,48
 320:	8082                	ret

0000000000000322 <memset>:

void*
memset(void *dst, int c, uint n)
{
 322:	7179                	addi	sp,sp,-48
 324:	f422                	sd	s0,40(sp)
 326:	1800                	addi	s0,sp,48
 328:	fca43c23          	sd	a0,-40(s0)
 32c:	87ae                	mv	a5,a1
 32e:	8732                	mv	a4,a2
 330:	fcf42a23          	sw	a5,-44(s0)
 334:	87ba                	mv	a5,a4
 336:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 33a:	fd843783          	ld	a5,-40(s0)
 33e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 342:	fe042623          	sw	zero,-20(s0)
 346:	a00d                	j	368 <memset+0x46>
    cdst[i] = c;
 348:	fec42783          	lw	a5,-20(s0)
 34c:	fe043703          	ld	a4,-32(s0)
 350:	97ba                	add	a5,a5,a4
 352:	fd442703          	lw	a4,-44(s0)
 356:	0ff77713          	andi	a4,a4,255
 35a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 35e:	fec42783          	lw	a5,-20(s0)
 362:	2785                	addiw	a5,a5,1
 364:	fef42623          	sw	a5,-20(s0)
 368:	fec42703          	lw	a4,-20(s0)
 36c:	fd042783          	lw	a5,-48(s0)
 370:	2781                	sext.w	a5,a5
 372:	fcf76be3          	bltu	a4,a5,348 <memset+0x26>
  }
  return dst;
 376:	fd843783          	ld	a5,-40(s0)
}
 37a:	853e                	mv	a0,a5
 37c:	7422                	ld	s0,40(sp)
 37e:	6145                	addi	sp,sp,48
 380:	8082                	ret

0000000000000382 <strchr>:

char*
strchr(const char *s, char c)
{
 382:	1101                	addi	sp,sp,-32
 384:	ec22                	sd	s0,24(sp)
 386:	1000                	addi	s0,sp,32
 388:	fea43423          	sd	a0,-24(s0)
 38c:	87ae                	mv	a5,a1
 38e:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 392:	a01d                	j	3b8 <strchr+0x36>
    if(*s == c)
 394:	fe843783          	ld	a5,-24(s0)
 398:	0007c703          	lbu	a4,0(a5)
 39c:	fe744783          	lbu	a5,-25(s0)
 3a0:	0ff7f793          	andi	a5,a5,255
 3a4:	00e79563          	bne	a5,a4,3ae <strchr+0x2c>
      return (char*)s;
 3a8:	fe843783          	ld	a5,-24(s0)
 3ac:	a821                	j	3c4 <strchr+0x42>
  for(; *s; s++)
 3ae:	fe843783          	ld	a5,-24(s0)
 3b2:	0785                	addi	a5,a5,1
 3b4:	fef43423          	sd	a5,-24(s0)
 3b8:	fe843783          	ld	a5,-24(s0)
 3bc:	0007c783          	lbu	a5,0(a5)
 3c0:	fbf1                	bnez	a5,394 <strchr+0x12>
  return 0;
 3c2:	4781                	li	a5,0
}
 3c4:	853e                	mv	a0,a5
 3c6:	6462                	ld	s0,24(sp)
 3c8:	6105                	addi	sp,sp,32
 3ca:	8082                	ret

00000000000003cc <gets>:

char*
gets(char *buf, int max)
{
 3cc:	7179                	addi	sp,sp,-48
 3ce:	f406                	sd	ra,40(sp)
 3d0:	f022                	sd	s0,32(sp)
 3d2:	1800                	addi	s0,sp,48
 3d4:	fca43c23          	sd	a0,-40(s0)
 3d8:	87ae                	mv	a5,a1
 3da:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3de:	fe042623          	sw	zero,-20(s0)
 3e2:	a8a1                	j	43a <gets+0x6e>
    cc = read(0, &c, 1);
 3e4:	fe740793          	addi	a5,s0,-25
 3e8:	4605                	li	a2,1
 3ea:	85be                	mv	a1,a5
 3ec:	4501                	li	a0,0
 3ee:	00000097          	auipc	ra,0x0
 3f2:	2f6080e7          	jalr	758(ra) # 6e4 <read>
 3f6:	87aa                	mv	a5,a0
 3f8:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 3fc:	fe842783          	lw	a5,-24(s0)
 400:	2781                	sext.w	a5,a5
 402:	04f05763          	blez	a5,450 <gets+0x84>
      break;
    buf[i++] = c;
 406:	fec42783          	lw	a5,-20(s0)
 40a:	0017871b          	addiw	a4,a5,1
 40e:	fee42623          	sw	a4,-20(s0)
 412:	873e                	mv	a4,a5
 414:	fd843783          	ld	a5,-40(s0)
 418:	97ba                	add	a5,a5,a4
 41a:	fe744703          	lbu	a4,-25(s0)
 41e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 422:	fe744783          	lbu	a5,-25(s0)
 426:	873e                	mv	a4,a5
 428:	47a9                	li	a5,10
 42a:	02f70463          	beq	a4,a5,452 <gets+0x86>
 42e:	fe744783          	lbu	a5,-25(s0)
 432:	873e                	mv	a4,a5
 434:	47b5                	li	a5,13
 436:	00f70e63          	beq	a4,a5,452 <gets+0x86>
  for(i=0; i+1 < max; ){
 43a:	fec42783          	lw	a5,-20(s0)
 43e:	2785                	addiw	a5,a5,1
 440:	0007871b          	sext.w	a4,a5
 444:	fd442783          	lw	a5,-44(s0)
 448:	2781                	sext.w	a5,a5
 44a:	f8f74de3          	blt	a4,a5,3e4 <gets+0x18>
 44e:	a011                	j	452 <gets+0x86>
      break;
 450:	0001                	nop
      break;
  }
  buf[i] = '\0';
 452:	fec42783          	lw	a5,-20(s0)
 456:	fd843703          	ld	a4,-40(s0)
 45a:	97ba                	add	a5,a5,a4
 45c:	00078023          	sb	zero,0(a5)
  return buf;
 460:	fd843783          	ld	a5,-40(s0)
}
 464:	853e                	mv	a0,a5
 466:	70a2                	ld	ra,40(sp)
 468:	7402                	ld	s0,32(sp)
 46a:	6145                	addi	sp,sp,48
 46c:	8082                	ret

000000000000046e <stat>:

int
stat(const char *n, struct stat *st)
{
 46e:	7179                	addi	sp,sp,-48
 470:	f406                	sd	ra,40(sp)
 472:	f022                	sd	s0,32(sp)
 474:	1800                	addi	s0,sp,48
 476:	fca43c23          	sd	a0,-40(s0)
 47a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 47e:	4581                	li	a1,0
 480:	fd843503          	ld	a0,-40(s0)
 484:	00000097          	auipc	ra,0x0
 488:	288080e7          	jalr	648(ra) # 70c <open>
 48c:	87aa                	mv	a5,a0
 48e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 492:	fec42783          	lw	a5,-20(s0)
 496:	2781                	sext.w	a5,a5
 498:	0007d463          	bgez	a5,4a0 <stat+0x32>
    return -1;
 49c:	57fd                	li	a5,-1
 49e:	a035                	j	4ca <stat+0x5c>
  r = fstat(fd, st);
 4a0:	fec42783          	lw	a5,-20(s0)
 4a4:	fd043583          	ld	a1,-48(s0)
 4a8:	853e                	mv	a0,a5
 4aa:	00000097          	auipc	ra,0x0
 4ae:	27a080e7          	jalr	634(ra) # 724 <fstat>
 4b2:	87aa                	mv	a5,a0
 4b4:	fef42423          	sw	a5,-24(s0)
  close(fd);
 4b8:	fec42783          	lw	a5,-20(s0)
 4bc:	853e                	mv	a0,a5
 4be:	00000097          	auipc	ra,0x0
 4c2:	236080e7          	jalr	566(ra) # 6f4 <close>
  return r;
 4c6:	fe842783          	lw	a5,-24(s0)
}
 4ca:	853e                	mv	a0,a5
 4cc:	70a2                	ld	ra,40(sp)
 4ce:	7402                	ld	s0,32(sp)
 4d0:	6145                	addi	sp,sp,48
 4d2:	8082                	ret

00000000000004d4 <atoi>:

int
atoi(const char *s)
{
 4d4:	7179                	addi	sp,sp,-48
 4d6:	f422                	sd	s0,40(sp)
 4d8:	1800                	addi	s0,sp,48
 4da:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 4de:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 4e2:	a815                	j	516 <atoi+0x42>
    n = n*10 + *s++ - '0';
 4e4:	fec42703          	lw	a4,-20(s0)
 4e8:	87ba                	mv	a5,a4
 4ea:	0027979b          	slliw	a5,a5,0x2
 4ee:	9fb9                	addw	a5,a5,a4
 4f0:	0017979b          	slliw	a5,a5,0x1
 4f4:	0007871b          	sext.w	a4,a5
 4f8:	fd843783          	ld	a5,-40(s0)
 4fc:	00178693          	addi	a3,a5,1
 500:	fcd43c23          	sd	a3,-40(s0)
 504:	0007c783          	lbu	a5,0(a5)
 508:	2781                	sext.w	a5,a5
 50a:	9fb9                	addw	a5,a5,a4
 50c:	2781                	sext.w	a5,a5
 50e:	fd07879b          	addiw	a5,a5,-48
 512:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 516:	fd843783          	ld	a5,-40(s0)
 51a:	0007c783          	lbu	a5,0(a5)
 51e:	873e                	mv	a4,a5
 520:	02f00793          	li	a5,47
 524:	00e7fb63          	bgeu	a5,a4,53a <atoi+0x66>
 528:	fd843783          	ld	a5,-40(s0)
 52c:	0007c783          	lbu	a5,0(a5)
 530:	873e                	mv	a4,a5
 532:	03900793          	li	a5,57
 536:	fae7f7e3          	bgeu	a5,a4,4e4 <atoi+0x10>
  return n;
 53a:	fec42783          	lw	a5,-20(s0)
}
 53e:	853e                	mv	a0,a5
 540:	7422                	ld	s0,40(sp)
 542:	6145                	addi	sp,sp,48
 544:	8082                	ret

0000000000000546 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 546:	7139                	addi	sp,sp,-64
 548:	fc22                	sd	s0,56(sp)
 54a:	0080                	addi	s0,sp,64
 54c:	fca43c23          	sd	a0,-40(s0)
 550:	fcb43823          	sd	a1,-48(s0)
 554:	87b2                	mv	a5,a2
 556:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 55a:	fd843783          	ld	a5,-40(s0)
 55e:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 562:	fd043783          	ld	a5,-48(s0)
 566:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 56a:	fe043703          	ld	a4,-32(s0)
 56e:	fe843783          	ld	a5,-24(s0)
 572:	02e7fc63          	bgeu	a5,a4,5aa <memmove+0x64>
    while(n-- > 0)
 576:	a00d                	j	598 <memmove+0x52>
      *dst++ = *src++;
 578:	fe043703          	ld	a4,-32(s0)
 57c:	00170793          	addi	a5,a4,1
 580:	fef43023          	sd	a5,-32(s0)
 584:	fe843783          	ld	a5,-24(s0)
 588:	00178693          	addi	a3,a5,1
 58c:	fed43423          	sd	a3,-24(s0)
 590:	00074703          	lbu	a4,0(a4)
 594:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 598:	fcc42783          	lw	a5,-52(s0)
 59c:	fff7871b          	addiw	a4,a5,-1
 5a0:	fce42623          	sw	a4,-52(s0)
 5a4:	fcf04ae3          	bgtz	a5,578 <memmove+0x32>
 5a8:	a891                	j	5fc <memmove+0xb6>
  } else {
    dst += n;
 5aa:	fcc42783          	lw	a5,-52(s0)
 5ae:	fe843703          	ld	a4,-24(s0)
 5b2:	97ba                	add	a5,a5,a4
 5b4:	fef43423          	sd	a5,-24(s0)
    src += n;
 5b8:	fcc42783          	lw	a5,-52(s0)
 5bc:	fe043703          	ld	a4,-32(s0)
 5c0:	97ba                	add	a5,a5,a4
 5c2:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 5c6:	a01d                	j	5ec <memmove+0xa6>
      *--dst = *--src;
 5c8:	fe043783          	ld	a5,-32(s0)
 5cc:	17fd                	addi	a5,a5,-1
 5ce:	fef43023          	sd	a5,-32(s0)
 5d2:	fe843783          	ld	a5,-24(s0)
 5d6:	17fd                	addi	a5,a5,-1
 5d8:	fef43423          	sd	a5,-24(s0)
 5dc:	fe043783          	ld	a5,-32(s0)
 5e0:	0007c703          	lbu	a4,0(a5)
 5e4:	fe843783          	ld	a5,-24(s0)
 5e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 5ec:	fcc42783          	lw	a5,-52(s0)
 5f0:	fff7871b          	addiw	a4,a5,-1
 5f4:	fce42623          	sw	a4,-52(s0)
 5f8:	fcf048e3          	bgtz	a5,5c8 <memmove+0x82>
  }
  return vdst;
 5fc:	fd843783          	ld	a5,-40(s0)
}
 600:	853e                	mv	a0,a5
 602:	7462                	ld	s0,56(sp)
 604:	6121                	addi	sp,sp,64
 606:	8082                	ret

0000000000000608 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 608:	7139                	addi	sp,sp,-64
 60a:	fc22                	sd	s0,56(sp)
 60c:	0080                	addi	s0,sp,64
 60e:	fca43c23          	sd	a0,-40(s0)
 612:	fcb43823          	sd	a1,-48(s0)
 616:	87b2                	mv	a5,a2
 618:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 61c:	fd843783          	ld	a5,-40(s0)
 620:	fef43423          	sd	a5,-24(s0)
 624:	fd043783          	ld	a5,-48(s0)
 628:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 62c:	a0a1                	j	674 <memcmp+0x6c>
    if (*p1 != *p2) {
 62e:	fe843783          	ld	a5,-24(s0)
 632:	0007c703          	lbu	a4,0(a5)
 636:	fe043783          	ld	a5,-32(s0)
 63a:	0007c783          	lbu	a5,0(a5)
 63e:	02f70163          	beq	a4,a5,660 <memcmp+0x58>
      return *p1 - *p2;
 642:	fe843783          	ld	a5,-24(s0)
 646:	0007c783          	lbu	a5,0(a5)
 64a:	0007871b          	sext.w	a4,a5
 64e:	fe043783          	ld	a5,-32(s0)
 652:	0007c783          	lbu	a5,0(a5)
 656:	2781                	sext.w	a5,a5
 658:	40f707bb          	subw	a5,a4,a5
 65c:	2781                	sext.w	a5,a5
 65e:	a01d                	j	684 <memcmp+0x7c>
    }
    p1++;
 660:	fe843783          	ld	a5,-24(s0)
 664:	0785                	addi	a5,a5,1
 666:	fef43423          	sd	a5,-24(s0)
    p2++;
 66a:	fe043783          	ld	a5,-32(s0)
 66e:	0785                	addi	a5,a5,1
 670:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 674:	fcc42783          	lw	a5,-52(s0)
 678:	fff7871b          	addiw	a4,a5,-1
 67c:	fce42623          	sw	a4,-52(s0)
 680:	f7dd                	bnez	a5,62e <memcmp+0x26>
  }
  return 0;
 682:	4781                	li	a5,0
}
 684:	853e                	mv	a0,a5
 686:	7462                	ld	s0,56(sp)
 688:	6121                	addi	sp,sp,64
 68a:	8082                	ret

000000000000068c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 68c:	7179                	addi	sp,sp,-48
 68e:	f406                	sd	ra,40(sp)
 690:	f022                	sd	s0,32(sp)
 692:	1800                	addi	s0,sp,48
 694:	fea43423          	sd	a0,-24(s0)
 698:	feb43023          	sd	a1,-32(s0)
 69c:	87b2                	mv	a5,a2
 69e:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 6a2:	fdc42783          	lw	a5,-36(s0)
 6a6:	863e                	mv	a2,a5
 6a8:	fe043583          	ld	a1,-32(s0)
 6ac:	fe843503          	ld	a0,-24(s0)
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e96080e7          	jalr	-362(ra) # 546 <memmove>
 6b8:	87aa                	mv	a5,a0
}
 6ba:	853e                	mv	a0,a5
 6bc:	70a2                	ld	ra,40(sp)
 6be:	7402                	ld	s0,32(sp)
 6c0:	6145                	addi	sp,sp,48
 6c2:	8082                	ret

00000000000006c4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6c4:	4885                	li	a7,1
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 6cc:	4889                	li	a7,2
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6d4:	488d                	li	a7,3
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6dc:	4891                	li	a7,4
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <read>:
.global read
read:
 li a7, SYS_read
 6e4:	4895                	li	a7,5
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <write>:
.global write
write:
 li a7, SYS_write
 6ec:	48c1                	li	a7,16
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <close>:
.global close
close:
 li a7, SYS_close
 6f4:	48d5                	li	a7,21
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <kill>:
.global kill
kill:
 li a7, SYS_kill
 6fc:	4899                	li	a7,6
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <exec>:
.global exec
exec:
 li a7, SYS_exec
 704:	489d                	li	a7,7
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <open>:
.global open
open:
 li a7, SYS_open
 70c:	48bd                	li	a7,15
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 714:	48c5                	li	a7,17
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 71c:	48c9                	li	a7,18
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 724:	48a1                	li	a7,8
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <link>:
.global link
link:
 li a7, SYS_link
 72c:	48cd                	li	a7,19
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 734:	48d1                	li	a7,20
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 73c:	48a5                	li	a7,9
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <dup>:
.global dup
dup:
 li a7, SYS_dup
 744:	48a9                	li	a7,10
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 74c:	48ad                	li	a7,11
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 754:	48b1                	li	a7,12
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 75c:	48b5                	li	a7,13
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 764:	48b9                	li	a7,14
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 76c:	1101                	addi	sp,sp,-32
 76e:	ec06                	sd	ra,24(sp)
 770:	e822                	sd	s0,16(sp)
 772:	1000                	addi	s0,sp,32
 774:	87aa                	mv	a5,a0
 776:	872e                	mv	a4,a1
 778:	fef42623          	sw	a5,-20(s0)
 77c:	87ba                	mv	a5,a4
 77e:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 782:	feb40713          	addi	a4,s0,-21
 786:	fec42783          	lw	a5,-20(s0)
 78a:	4605                	li	a2,1
 78c:	85ba                	mv	a1,a4
 78e:	853e                	mv	a0,a5
 790:	00000097          	auipc	ra,0x0
 794:	f5c080e7          	jalr	-164(ra) # 6ec <write>
}
 798:	0001                	nop
 79a:	60e2                	ld	ra,24(sp)
 79c:	6442                	ld	s0,16(sp)
 79e:	6105                	addi	sp,sp,32
 7a0:	8082                	ret

00000000000007a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7a2:	7139                	addi	sp,sp,-64
 7a4:	fc06                	sd	ra,56(sp)
 7a6:	f822                	sd	s0,48(sp)
 7a8:	0080                	addi	s0,sp,64
 7aa:	87aa                	mv	a5,a0
 7ac:	8736                	mv	a4,a3
 7ae:	fcf42623          	sw	a5,-52(s0)
 7b2:	87ae                	mv	a5,a1
 7b4:	fcf42423          	sw	a5,-56(s0)
 7b8:	87b2                	mv	a5,a2
 7ba:	fcf42223          	sw	a5,-60(s0)
 7be:	87ba                	mv	a5,a4
 7c0:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7c4:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 7c8:	fc042783          	lw	a5,-64(s0)
 7cc:	2781                	sext.w	a5,a5
 7ce:	c38d                	beqz	a5,7f0 <printint+0x4e>
 7d0:	fc842783          	lw	a5,-56(s0)
 7d4:	2781                	sext.w	a5,a5
 7d6:	0007dd63          	bgez	a5,7f0 <printint+0x4e>
    neg = 1;
 7da:	4785                	li	a5,1
 7dc:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 7e0:	fc842783          	lw	a5,-56(s0)
 7e4:	40f007bb          	negw	a5,a5
 7e8:	2781                	sext.w	a5,a5
 7ea:	fef42223          	sw	a5,-28(s0)
 7ee:	a029                	j	7f8 <printint+0x56>
  } else {
    x = xx;
 7f0:	fc842783          	lw	a5,-56(s0)
 7f4:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 7f8:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 7fc:	fc442783          	lw	a5,-60(s0)
 800:	fe442703          	lw	a4,-28(s0)
 804:	02f777bb          	remuw	a5,a4,a5
 808:	0007861b          	sext.w	a2,a5
 80c:	fec42783          	lw	a5,-20(s0)
 810:	0017871b          	addiw	a4,a5,1
 814:	fee42623          	sw	a4,-20(s0)
 818:	00000697          	auipc	a3,0x0
 81c:	7e868693          	addi	a3,a3,2024 # 1000 <digits>
 820:	02061713          	slli	a4,a2,0x20
 824:	9301                	srli	a4,a4,0x20
 826:	9736                	add	a4,a4,a3
 828:	00074703          	lbu	a4,0(a4)
 82c:	ff040693          	addi	a3,s0,-16
 830:	97b6                	add	a5,a5,a3
 832:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 836:	fc442783          	lw	a5,-60(s0)
 83a:	fe442703          	lw	a4,-28(s0)
 83e:	02f757bb          	divuw	a5,a4,a5
 842:	fef42223          	sw	a5,-28(s0)
 846:	fe442783          	lw	a5,-28(s0)
 84a:	2781                	sext.w	a5,a5
 84c:	fbc5                	bnez	a5,7fc <printint+0x5a>
  if(neg)
 84e:	fe842783          	lw	a5,-24(s0)
 852:	2781                	sext.w	a5,a5
 854:	cf95                	beqz	a5,890 <printint+0xee>
    buf[i++] = '-';
 856:	fec42783          	lw	a5,-20(s0)
 85a:	0017871b          	addiw	a4,a5,1
 85e:	fee42623          	sw	a4,-20(s0)
 862:	ff040713          	addi	a4,s0,-16
 866:	97ba                	add	a5,a5,a4
 868:	02d00713          	li	a4,45
 86c:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 870:	a005                	j	890 <printint+0xee>
    putc(fd, buf[i]);
 872:	fec42783          	lw	a5,-20(s0)
 876:	ff040713          	addi	a4,s0,-16
 87a:	97ba                	add	a5,a5,a4
 87c:	fe07c703          	lbu	a4,-32(a5)
 880:	fcc42783          	lw	a5,-52(s0)
 884:	85ba                	mv	a1,a4
 886:	853e                	mv	a0,a5
 888:	00000097          	auipc	ra,0x0
 88c:	ee4080e7          	jalr	-284(ra) # 76c <putc>
  while(--i >= 0)
 890:	fec42783          	lw	a5,-20(s0)
 894:	37fd                	addiw	a5,a5,-1
 896:	fef42623          	sw	a5,-20(s0)
 89a:	fec42783          	lw	a5,-20(s0)
 89e:	2781                	sext.w	a5,a5
 8a0:	fc07d9e3          	bgez	a5,872 <printint+0xd0>
}
 8a4:	0001                	nop
 8a6:	0001                	nop
 8a8:	70e2                	ld	ra,56(sp)
 8aa:	7442                	ld	s0,48(sp)
 8ac:	6121                	addi	sp,sp,64
 8ae:	8082                	ret

00000000000008b0 <printptr>:

static void
printptr(int fd, uint64 x) {
 8b0:	7179                	addi	sp,sp,-48
 8b2:	f406                	sd	ra,40(sp)
 8b4:	f022                	sd	s0,32(sp)
 8b6:	1800                	addi	s0,sp,48
 8b8:	87aa                	mv	a5,a0
 8ba:	fcb43823          	sd	a1,-48(s0)
 8be:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 8c2:	fdc42783          	lw	a5,-36(s0)
 8c6:	03000593          	li	a1,48
 8ca:	853e                	mv	a0,a5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	ea0080e7          	jalr	-352(ra) # 76c <putc>
  putc(fd, 'x');
 8d4:	fdc42783          	lw	a5,-36(s0)
 8d8:	07800593          	li	a1,120
 8dc:	853e                	mv	a0,a5
 8de:	00000097          	auipc	ra,0x0
 8e2:	e8e080e7          	jalr	-370(ra) # 76c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8e6:	fe042623          	sw	zero,-20(s0)
 8ea:	a82d                	j	924 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8ec:	fd043783          	ld	a5,-48(s0)
 8f0:	93f1                	srli	a5,a5,0x3c
 8f2:	00000717          	auipc	a4,0x0
 8f6:	70e70713          	addi	a4,a4,1806 # 1000 <digits>
 8fa:	97ba                	add	a5,a5,a4
 8fc:	0007c703          	lbu	a4,0(a5)
 900:	fdc42783          	lw	a5,-36(s0)
 904:	85ba                	mv	a1,a4
 906:	853e                	mv	a0,a5
 908:	00000097          	auipc	ra,0x0
 90c:	e64080e7          	jalr	-412(ra) # 76c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 910:	fec42783          	lw	a5,-20(s0)
 914:	2785                	addiw	a5,a5,1
 916:	fef42623          	sw	a5,-20(s0)
 91a:	fd043783          	ld	a5,-48(s0)
 91e:	0792                	slli	a5,a5,0x4
 920:	fcf43823          	sd	a5,-48(s0)
 924:	fec42783          	lw	a5,-20(s0)
 928:	873e                	mv	a4,a5
 92a:	47bd                	li	a5,15
 92c:	fce7f0e3          	bgeu	a5,a4,8ec <printptr+0x3c>
}
 930:	0001                	nop
 932:	0001                	nop
 934:	70a2                	ld	ra,40(sp)
 936:	7402                	ld	s0,32(sp)
 938:	6145                	addi	sp,sp,48
 93a:	8082                	ret

000000000000093c <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 93c:	715d                	addi	sp,sp,-80
 93e:	e486                	sd	ra,72(sp)
 940:	e0a2                	sd	s0,64(sp)
 942:	0880                	addi	s0,sp,80
 944:	87aa                	mv	a5,a0
 946:	fcb43023          	sd	a1,-64(s0)
 94a:	fac43c23          	sd	a2,-72(s0)
 94e:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 952:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 956:	fe042223          	sw	zero,-28(s0)
 95a:	a42d                	j	b84 <vprintf+0x248>
    c = fmt[i] & 0xff;
 95c:	fe442783          	lw	a5,-28(s0)
 960:	fc043703          	ld	a4,-64(s0)
 964:	97ba                	add	a5,a5,a4
 966:	0007c783          	lbu	a5,0(a5)
 96a:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 96e:	fe042783          	lw	a5,-32(s0)
 972:	2781                	sext.w	a5,a5
 974:	eb9d                	bnez	a5,9aa <vprintf+0x6e>
      if(c == '%'){
 976:	fdc42783          	lw	a5,-36(s0)
 97a:	0007871b          	sext.w	a4,a5
 97e:	02500793          	li	a5,37
 982:	00f71763          	bne	a4,a5,990 <vprintf+0x54>
        state = '%';
 986:	02500793          	li	a5,37
 98a:	fef42023          	sw	a5,-32(s0)
 98e:	a2f5                	j	b7a <vprintf+0x23e>
      } else {
        putc(fd, c);
 990:	fdc42783          	lw	a5,-36(s0)
 994:	0ff7f713          	andi	a4,a5,255
 998:	fcc42783          	lw	a5,-52(s0)
 99c:	85ba                	mv	a1,a4
 99e:	853e                	mv	a0,a5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	dcc080e7          	jalr	-564(ra) # 76c <putc>
 9a8:	aac9                	j	b7a <vprintf+0x23e>
      }
    } else if(state == '%'){
 9aa:	fe042783          	lw	a5,-32(s0)
 9ae:	0007871b          	sext.w	a4,a5
 9b2:	02500793          	li	a5,37
 9b6:	1cf71263          	bne	a4,a5,b7a <vprintf+0x23e>
      if(c == 'd'){
 9ba:	fdc42783          	lw	a5,-36(s0)
 9be:	0007871b          	sext.w	a4,a5
 9c2:	06400793          	li	a5,100
 9c6:	02f71463          	bne	a4,a5,9ee <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 9ca:	fb843783          	ld	a5,-72(s0)
 9ce:	00878713          	addi	a4,a5,8
 9d2:	fae43c23          	sd	a4,-72(s0)
 9d6:	4398                	lw	a4,0(a5)
 9d8:	fcc42783          	lw	a5,-52(s0)
 9dc:	4685                	li	a3,1
 9de:	4629                	li	a2,10
 9e0:	85ba                	mv	a1,a4
 9e2:	853e                	mv	a0,a5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	dbe080e7          	jalr	-578(ra) # 7a2 <printint>
 9ec:	a269                	j	b76 <vprintf+0x23a>
      } else if(c == 'l') {
 9ee:	fdc42783          	lw	a5,-36(s0)
 9f2:	0007871b          	sext.w	a4,a5
 9f6:	06c00793          	li	a5,108
 9fa:	02f71663          	bne	a4,a5,a26 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9fe:	fb843783          	ld	a5,-72(s0)
 a02:	00878713          	addi	a4,a5,8
 a06:	fae43c23          	sd	a4,-72(s0)
 a0a:	639c                	ld	a5,0(a5)
 a0c:	0007871b          	sext.w	a4,a5
 a10:	fcc42783          	lw	a5,-52(s0)
 a14:	4681                	li	a3,0
 a16:	4629                	li	a2,10
 a18:	85ba                	mv	a1,a4
 a1a:	853e                	mv	a0,a5
 a1c:	00000097          	auipc	ra,0x0
 a20:	d86080e7          	jalr	-634(ra) # 7a2 <printint>
 a24:	aa89                	j	b76 <vprintf+0x23a>
      } else if(c == 'x') {
 a26:	fdc42783          	lw	a5,-36(s0)
 a2a:	0007871b          	sext.w	a4,a5
 a2e:	07800793          	li	a5,120
 a32:	02f71463          	bne	a4,a5,a5a <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 a36:	fb843783          	ld	a5,-72(s0)
 a3a:	00878713          	addi	a4,a5,8
 a3e:	fae43c23          	sd	a4,-72(s0)
 a42:	4398                	lw	a4,0(a5)
 a44:	fcc42783          	lw	a5,-52(s0)
 a48:	4681                	li	a3,0
 a4a:	4641                	li	a2,16
 a4c:	85ba                	mv	a1,a4
 a4e:	853e                	mv	a0,a5
 a50:	00000097          	auipc	ra,0x0
 a54:	d52080e7          	jalr	-686(ra) # 7a2 <printint>
 a58:	aa39                	j	b76 <vprintf+0x23a>
      } else if(c == 'p') {
 a5a:	fdc42783          	lw	a5,-36(s0)
 a5e:	0007871b          	sext.w	a4,a5
 a62:	07000793          	li	a5,112
 a66:	02f71263          	bne	a4,a5,a8a <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 a6a:	fb843783          	ld	a5,-72(s0)
 a6e:	00878713          	addi	a4,a5,8
 a72:	fae43c23          	sd	a4,-72(s0)
 a76:	6398                	ld	a4,0(a5)
 a78:	fcc42783          	lw	a5,-52(s0)
 a7c:	85ba                	mv	a1,a4
 a7e:	853e                	mv	a0,a5
 a80:	00000097          	auipc	ra,0x0
 a84:	e30080e7          	jalr	-464(ra) # 8b0 <printptr>
 a88:	a0fd                	j	b76 <vprintf+0x23a>
      } else if(c == 's'){
 a8a:	fdc42783          	lw	a5,-36(s0)
 a8e:	0007871b          	sext.w	a4,a5
 a92:	07300793          	li	a5,115
 a96:	04f71c63          	bne	a4,a5,aee <vprintf+0x1b2>
        s = va_arg(ap, char*);
 a9a:	fb843783          	ld	a5,-72(s0)
 a9e:	00878713          	addi	a4,a5,8
 aa2:	fae43c23          	sd	a4,-72(s0)
 aa6:	639c                	ld	a5,0(a5)
 aa8:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 aac:	fe843783          	ld	a5,-24(s0)
 ab0:	eb8d                	bnez	a5,ae2 <vprintf+0x1a6>
          s = "(null)";
 ab2:	00000797          	auipc	a5,0x0
 ab6:	4c678793          	addi	a5,a5,1222 # f78 <malloc+0x18c>
 aba:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 abe:	a015                	j	ae2 <vprintf+0x1a6>
          putc(fd, *s);
 ac0:	fe843783          	ld	a5,-24(s0)
 ac4:	0007c703          	lbu	a4,0(a5)
 ac8:	fcc42783          	lw	a5,-52(s0)
 acc:	85ba                	mv	a1,a4
 ace:	853e                	mv	a0,a5
 ad0:	00000097          	auipc	ra,0x0
 ad4:	c9c080e7          	jalr	-868(ra) # 76c <putc>
          s++;
 ad8:	fe843783          	ld	a5,-24(s0)
 adc:	0785                	addi	a5,a5,1
 ade:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 ae2:	fe843783          	ld	a5,-24(s0)
 ae6:	0007c783          	lbu	a5,0(a5)
 aea:	fbf9                	bnez	a5,ac0 <vprintf+0x184>
 aec:	a069                	j	b76 <vprintf+0x23a>
        }
      } else if(c == 'c'){
 aee:	fdc42783          	lw	a5,-36(s0)
 af2:	0007871b          	sext.w	a4,a5
 af6:	06300793          	li	a5,99
 afa:	02f71463          	bne	a4,a5,b22 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 afe:	fb843783          	ld	a5,-72(s0)
 b02:	00878713          	addi	a4,a5,8
 b06:	fae43c23          	sd	a4,-72(s0)
 b0a:	439c                	lw	a5,0(a5)
 b0c:	0ff7f713          	andi	a4,a5,255
 b10:	fcc42783          	lw	a5,-52(s0)
 b14:	85ba                	mv	a1,a4
 b16:	853e                	mv	a0,a5
 b18:	00000097          	auipc	ra,0x0
 b1c:	c54080e7          	jalr	-940(ra) # 76c <putc>
 b20:	a899                	j	b76 <vprintf+0x23a>
      } else if(c == '%'){
 b22:	fdc42783          	lw	a5,-36(s0)
 b26:	0007871b          	sext.w	a4,a5
 b2a:	02500793          	li	a5,37
 b2e:	00f71f63          	bne	a4,a5,b4c <vprintf+0x210>
        putc(fd, c);
 b32:	fdc42783          	lw	a5,-36(s0)
 b36:	0ff7f713          	andi	a4,a5,255
 b3a:	fcc42783          	lw	a5,-52(s0)
 b3e:	85ba                	mv	a1,a4
 b40:	853e                	mv	a0,a5
 b42:	00000097          	auipc	ra,0x0
 b46:	c2a080e7          	jalr	-982(ra) # 76c <putc>
 b4a:	a035                	j	b76 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b4c:	fcc42783          	lw	a5,-52(s0)
 b50:	02500593          	li	a1,37
 b54:	853e                	mv	a0,a5
 b56:	00000097          	auipc	ra,0x0
 b5a:	c16080e7          	jalr	-1002(ra) # 76c <putc>
        putc(fd, c);
 b5e:	fdc42783          	lw	a5,-36(s0)
 b62:	0ff7f713          	andi	a4,a5,255
 b66:	fcc42783          	lw	a5,-52(s0)
 b6a:	85ba                	mv	a1,a4
 b6c:	853e                	mv	a0,a5
 b6e:	00000097          	auipc	ra,0x0
 b72:	bfe080e7          	jalr	-1026(ra) # 76c <putc>
      }
      state = 0;
 b76:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 b7a:	fe442783          	lw	a5,-28(s0)
 b7e:	2785                	addiw	a5,a5,1
 b80:	fef42223          	sw	a5,-28(s0)
 b84:	fe442783          	lw	a5,-28(s0)
 b88:	fc043703          	ld	a4,-64(s0)
 b8c:	97ba                	add	a5,a5,a4
 b8e:	0007c783          	lbu	a5,0(a5)
 b92:	dc0795e3          	bnez	a5,95c <vprintf+0x20>
    }
  }
}
 b96:	0001                	nop
 b98:	0001                	nop
 b9a:	60a6                	ld	ra,72(sp)
 b9c:	6406                	ld	s0,64(sp)
 b9e:	6161                	addi	sp,sp,80
 ba0:	8082                	ret

0000000000000ba2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ba2:	7159                	addi	sp,sp,-112
 ba4:	fc06                	sd	ra,56(sp)
 ba6:	f822                	sd	s0,48(sp)
 ba8:	0080                	addi	s0,sp,64
 baa:	fcb43823          	sd	a1,-48(s0)
 bae:	e010                	sd	a2,0(s0)
 bb0:	e414                	sd	a3,8(s0)
 bb2:	e818                	sd	a4,16(s0)
 bb4:	ec1c                	sd	a5,24(s0)
 bb6:	03043023          	sd	a6,32(s0)
 bba:	03143423          	sd	a7,40(s0)
 bbe:	87aa                	mv	a5,a0
 bc0:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 bc4:	03040793          	addi	a5,s0,48
 bc8:	fcf43423          	sd	a5,-56(s0)
 bcc:	fc843783          	ld	a5,-56(s0)
 bd0:	fd078793          	addi	a5,a5,-48
 bd4:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 bd8:	fe843703          	ld	a4,-24(s0)
 bdc:	fdc42783          	lw	a5,-36(s0)
 be0:	863a                	mv	a2,a4
 be2:	fd043583          	ld	a1,-48(s0)
 be6:	853e                	mv	a0,a5
 be8:	00000097          	auipc	ra,0x0
 bec:	d54080e7          	jalr	-684(ra) # 93c <vprintf>
}
 bf0:	0001                	nop
 bf2:	70e2                	ld	ra,56(sp)
 bf4:	7442                	ld	s0,48(sp)
 bf6:	6165                	addi	sp,sp,112
 bf8:	8082                	ret

0000000000000bfa <printf>:

void
printf(const char *fmt, ...)
{
 bfa:	7159                	addi	sp,sp,-112
 bfc:	f406                	sd	ra,40(sp)
 bfe:	f022                	sd	s0,32(sp)
 c00:	1800                	addi	s0,sp,48
 c02:	fca43c23          	sd	a0,-40(s0)
 c06:	e40c                	sd	a1,8(s0)
 c08:	e810                	sd	a2,16(s0)
 c0a:	ec14                	sd	a3,24(s0)
 c0c:	f018                	sd	a4,32(s0)
 c0e:	f41c                	sd	a5,40(s0)
 c10:	03043823          	sd	a6,48(s0)
 c14:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c18:	04040793          	addi	a5,s0,64
 c1c:	fcf43823          	sd	a5,-48(s0)
 c20:	fd043783          	ld	a5,-48(s0)
 c24:	fc878793          	addi	a5,a5,-56
 c28:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 c2c:	fe843783          	ld	a5,-24(s0)
 c30:	863e                	mv	a2,a5
 c32:	fd843583          	ld	a1,-40(s0)
 c36:	4505                	li	a0,1
 c38:	00000097          	auipc	ra,0x0
 c3c:	d04080e7          	jalr	-764(ra) # 93c <vprintf>
}
 c40:	0001                	nop
 c42:	70a2                	ld	ra,40(sp)
 c44:	7402                	ld	s0,32(sp)
 c46:	6165                	addi	sp,sp,112
 c48:	8082                	ret

0000000000000c4a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c4a:	7179                	addi	sp,sp,-48
 c4c:	f422                	sd	s0,40(sp)
 c4e:	1800                	addi	s0,sp,48
 c50:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c54:	fd843783          	ld	a5,-40(s0)
 c58:	17c1                	addi	a5,a5,-16
 c5a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c5e:	00000797          	auipc	a5,0x0
 c62:	5d278793          	addi	a5,a5,1490 # 1230 <freep>
 c66:	639c                	ld	a5,0(a5)
 c68:	fef43423          	sd	a5,-24(s0)
 c6c:	a815                	j	ca0 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c6e:	fe843783          	ld	a5,-24(s0)
 c72:	639c                	ld	a5,0(a5)
 c74:	fe843703          	ld	a4,-24(s0)
 c78:	00f76f63          	bltu	a4,a5,c96 <free+0x4c>
 c7c:	fe043703          	ld	a4,-32(s0)
 c80:	fe843783          	ld	a5,-24(s0)
 c84:	02e7eb63          	bltu	a5,a4,cba <free+0x70>
 c88:	fe843783          	ld	a5,-24(s0)
 c8c:	639c                	ld	a5,0(a5)
 c8e:	fe043703          	ld	a4,-32(s0)
 c92:	02f76463          	bltu	a4,a5,cba <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c96:	fe843783          	ld	a5,-24(s0)
 c9a:	639c                	ld	a5,0(a5)
 c9c:	fef43423          	sd	a5,-24(s0)
 ca0:	fe043703          	ld	a4,-32(s0)
 ca4:	fe843783          	ld	a5,-24(s0)
 ca8:	fce7f3e3          	bgeu	a5,a4,c6e <free+0x24>
 cac:	fe843783          	ld	a5,-24(s0)
 cb0:	639c                	ld	a5,0(a5)
 cb2:	fe043703          	ld	a4,-32(s0)
 cb6:	faf77ce3          	bgeu	a4,a5,c6e <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 cba:	fe043783          	ld	a5,-32(s0)
 cbe:	479c                	lw	a5,8(a5)
 cc0:	1782                	slli	a5,a5,0x20
 cc2:	9381                	srli	a5,a5,0x20
 cc4:	0792                	slli	a5,a5,0x4
 cc6:	fe043703          	ld	a4,-32(s0)
 cca:	973e                	add	a4,a4,a5
 ccc:	fe843783          	ld	a5,-24(s0)
 cd0:	639c                	ld	a5,0(a5)
 cd2:	02f71763          	bne	a4,a5,d00 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 cd6:	fe043783          	ld	a5,-32(s0)
 cda:	4798                	lw	a4,8(a5)
 cdc:	fe843783          	ld	a5,-24(s0)
 ce0:	639c                	ld	a5,0(a5)
 ce2:	479c                	lw	a5,8(a5)
 ce4:	9fb9                	addw	a5,a5,a4
 ce6:	0007871b          	sext.w	a4,a5
 cea:	fe043783          	ld	a5,-32(s0)
 cee:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 cf0:	fe843783          	ld	a5,-24(s0)
 cf4:	639c                	ld	a5,0(a5)
 cf6:	6398                	ld	a4,0(a5)
 cf8:	fe043783          	ld	a5,-32(s0)
 cfc:	e398                	sd	a4,0(a5)
 cfe:	a039                	j	d0c <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 d00:	fe843783          	ld	a5,-24(s0)
 d04:	6398                	ld	a4,0(a5)
 d06:	fe043783          	ld	a5,-32(s0)
 d0a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 d0c:	fe843783          	ld	a5,-24(s0)
 d10:	479c                	lw	a5,8(a5)
 d12:	1782                	slli	a5,a5,0x20
 d14:	9381                	srli	a5,a5,0x20
 d16:	0792                	slli	a5,a5,0x4
 d18:	fe843703          	ld	a4,-24(s0)
 d1c:	97ba                	add	a5,a5,a4
 d1e:	fe043703          	ld	a4,-32(s0)
 d22:	02f71563          	bne	a4,a5,d4c <free+0x102>
    p->s.size += bp->s.size;
 d26:	fe843783          	ld	a5,-24(s0)
 d2a:	4798                	lw	a4,8(a5)
 d2c:	fe043783          	ld	a5,-32(s0)
 d30:	479c                	lw	a5,8(a5)
 d32:	9fb9                	addw	a5,a5,a4
 d34:	0007871b          	sext.w	a4,a5
 d38:	fe843783          	ld	a5,-24(s0)
 d3c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 d3e:	fe043783          	ld	a5,-32(s0)
 d42:	6398                	ld	a4,0(a5)
 d44:	fe843783          	ld	a5,-24(s0)
 d48:	e398                	sd	a4,0(a5)
 d4a:	a031                	j	d56 <free+0x10c>
  } else
    p->s.ptr = bp;
 d4c:	fe843783          	ld	a5,-24(s0)
 d50:	fe043703          	ld	a4,-32(s0)
 d54:	e398                	sd	a4,0(a5)
  freep = p;
 d56:	00000797          	auipc	a5,0x0
 d5a:	4da78793          	addi	a5,a5,1242 # 1230 <freep>
 d5e:	fe843703          	ld	a4,-24(s0)
 d62:	e398                	sd	a4,0(a5)
}
 d64:	0001                	nop
 d66:	7422                	ld	s0,40(sp)
 d68:	6145                	addi	sp,sp,48
 d6a:	8082                	ret

0000000000000d6c <morecore>:

static Header*
morecore(uint nu)
{
 d6c:	7179                	addi	sp,sp,-48
 d6e:	f406                	sd	ra,40(sp)
 d70:	f022                	sd	s0,32(sp)
 d72:	1800                	addi	s0,sp,48
 d74:	87aa                	mv	a5,a0
 d76:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 d7a:	fdc42783          	lw	a5,-36(s0)
 d7e:	0007871b          	sext.w	a4,a5
 d82:	6785                	lui	a5,0x1
 d84:	00f77563          	bgeu	a4,a5,d8e <morecore+0x22>
    nu = 4096;
 d88:	6785                	lui	a5,0x1
 d8a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 d8e:	fdc42783          	lw	a5,-36(s0)
 d92:	0047979b          	slliw	a5,a5,0x4
 d96:	2781                	sext.w	a5,a5
 d98:	2781                	sext.w	a5,a5
 d9a:	853e                	mv	a0,a5
 d9c:	00000097          	auipc	ra,0x0
 da0:	9b8080e7          	jalr	-1608(ra) # 754 <sbrk>
 da4:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 da8:	fe843703          	ld	a4,-24(s0)
 dac:	57fd                	li	a5,-1
 dae:	00f71463          	bne	a4,a5,db6 <morecore+0x4a>
    return 0;
 db2:	4781                	li	a5,0
 db4:	a03d                	j	de2 <morecore+0x76>
  hp = (Header*)p;
 db6:	fe843783          	ld	a5,-24(s0)
 dba:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 dbe:	fe043783          	ld	a5,-32(s0)
 dc2:	fdc42703          	lw	a4,-36(s0)
 dc6:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 dc8:	fe043783          	ld	a5,-32(s0)
 dcc:	07c1                	addi	a5,a5,16
 dce:	853e                	mv	a0,a5
 dd0:	00000097          	auipc	ra,0x0
 dd4:	e7a080e7          	jalr	-390(ra) # c4a <free>
  return freep;
 dd8:	00000797          	auipc	a5,0x0
 ddc:	45878793          	addi	a5,a5,1112 # 1230 <freep>
 de0:	639c                	ld	a5,0(a5)
}
 de2:	853e                	mv	a0,a5
 de4:	70a2                	ld	ra,40(sp)
 de6:	7402                	ld	s0,32(sp)
 de8:	6145                	addi	sp,sp,48
 dea:	8082                	ret

0000000000000dec <malloc>:

void*
malloc(uint nbytes)
{
 dec:	7139                	addi	sp,sp,-64
 dee:	fc06                	sd	ra,56(sp)
 df0:	f822                	sd	s0,48(sp)
 df2:	0080                	addi	s0,sp,64
 df4:	87aa                	mv	a5,a0
 df6:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 dfa:	fcc46783          	lwu	a5,-52(s0)
 dfe:	07bd                	addi	a5,a5,15
 e00:	8391                	srli	a5,a5,0x4
 e02:	2781                	sext.w	a5,a5
 e04:	2785                	addiw	a5,a5,1
 e06:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 e0a:	00000797          	auipc	a5,0x0
 e0e:	42678793          	addi	a5,a5,1062 # 1230 <freep>
 e12:	639c                	ld	a5,0(a5)
 e14:	fef43023          	sd	a5,-32(s0)
 e18:	fe043783          	ld	a5,-32(s0)
 e1c:	ef95                	bnez	a5,e58 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 e1e:	00000797          	auipc	a5,0x0
 e22:	40278793          	addi	a5,a5,1026 # 1220 <base>
 e26:	fef43023          	sd	a5,-32(s0)
 e2a:	00000797          	auipc	a5,0x0
 e2e:	40678793          	addi	a5,a5,1030 # 1230 <freep>
 e32:	fe043703          	ld	a4,-32(s0)
 e36:	e398                	sd	a4,0(a5)
 e38:	00000797          	auipc	a5,0x0
 e3c:	3f878793          	addi	a5,a5,1016 # 1230 <freep>
 e40:	6398                	ld	a4,0(a5)
 e42:	00000797          	auipc	a5,0x0
 e46:	3de78793          	addi	a5,a5,990 # 1220 <base>
 e4a:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 e4c:	00000797          	auipc	a5,0x0
 e50:	3d478793          	addi	a5,a5,980 # 1220 <base>
 e54:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e58:	fe043783          	ld	a5,-32(s0)
 e5c:	639c                	ld	a5,0(a5)
 e5e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e62:	fe843783          	ld	a5,-24(s0)
 e66:	4798                	lw	a4,8(a5)
 e68:	fdc42783          	lw	a5,-36(s0)
 e6c:	2781                	sext.w	a5,a5
 e6e:	06f76863          	bltu	a4,a5,ede <malloc+0xf2>
      if(p->s.size == nunits)
 e72:	fe843783          	ld	a5,-24(s0)
 e76:	4798                	lw	a4,8(a5)
 e78:	fdc42783          	lw	a5,-36(s0)
 e7c:	2781                	sext.w	a5,a5
 e7e:	00e79963          	bne	a5,a4,e90 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 e82:	fe843783          	ld	a5,-24(s0)
 e86:	6398                	ld	a4,0(a5)
 e88:	fe043783          	ld	a5,-32(s0)
 e8c:	e398                	sd	a4,0(a5)
 e8e:	a82d                	j	ec8 <malloc+0xdc>
      else {
        p->s.size -= nunits;
 e90:	fe843783          	ld	a5,-24(s0)
 e94:	4798                	lw	a4,8(a5)
 e96:	fdc42783          	lw	a5,-36(s0)
 e9a:	40f707bb          	subw	a5,a4,a5
 e9e:	0007871b          	sext.w	a4,a5
 ea2:	fe843783          	ld	a5,-24(s0)
 ea6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ea8:	fe843783          	ld	a5,-24(s0)
 eac:	479c                	lw	a5,8(a5)
 eae:	1782                	slli	a5,a5,0x20
 eb0:	9381                	srli	a5,a5,0x20
 eb2:	0792                	slli	a5,a5,0x4
 eb4:	fe843703          	ld	a4,-24(s0)
 eb8:	97ba                	add	a5,a5,a4
 eba:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 ebe:	fe843783          	ld	a5,-24(s0)
 ec2:	fdc42703          	lw	a4,-36(s0)
 ec6:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 ec8:	00000797          	auipc	a5,0x0
 ecc:	36878793          	addi	a5,a5,872 # 1230 <freep>
 ed0:	fe043703          	ld	a4,-32(s0)
 ed4:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 ed6:	fe843783          	ld	a5,-24(s0)
 eda:	07c1                	addi	a5,a5,16
 edc:	a091                	j	f20 <malloc+0x134>
    }
    if(p == freep)
 ede:	00000797          	auipc	a5,0x0
 ee2:	35278793          	addi	a5,a5,850 # 1230 <freep>
 ee6:	639c                	ld	a5,0(a5)
 ee8:	fe843703          	ld	a4,-24(s0)
 eec:	02f71063          	bne	a4,a5,f0c <malloc+0x120>
      if((p = morecore(nunits)) == 0)
 ef0:	fdc42783          	lw	a5,-36(s0)
 ef4:	853e                	mv	a0,a5
 ef6:	00000097          	auipc	ra,0x0
 efa:	e76080e7          	jalr	-394(ra) # d6c <morecore>
 efe:	fea43423          	sd	a0,-24(s0)
 f02:	fe843783          	ld	a5,-24(s0)
 f06:	e399                	bnez	a5,f0c <malloc+0x120>
        return 0;
 f08:	4781                	li	a5,0
 f0a:	a819                	j	f20 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f0c:	fe843783          	ld	a5,-24(s0)
 f10:	fef43023          	sd	a5,-32(s0)
 f14:	fe843783          	ld	a5,-24(s0)
 f18:	639c                	ld	a5,0(a5)
 f1a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f1e:	b791                	j	e62 <malloc+0x76>
  }
}
 f20:	853e                	mv	a0,a5
 f22:	70e2                	ld	ra,56(sp)
 f24:	7442                	ld	s0,48(sp)
 f26:	6121                	addi	sp,sp,64
 f28:	8082                	ret
