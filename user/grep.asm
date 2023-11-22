
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	fca43423          	sd	a0,-56(s0)
       c:	87ae                	mv	a5,a1
       e:	fcf42223          	sw	a5,-60(s0)
  int n, m;
  char *p, *q;

  m = 0;
      12:	fe042623          	sw	zero,-20(s0)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      16:	a8f9                	j	f4 <grep+0xf4>
    m += n;
      18:	fec42703          	lw	a4,-20(s0)
      1c:	fdc42783          	lw	a5,-36(s0)
      20:	9fb9                	addw	a5,a5,a4
      22:	fef42623          	sw	a5,-20(s0)
    buf[m] = '\0';
      26:	00002717          	auipc	a4,0x2
      2a:	ffa70713          	addi	a4,a4,-6 # 2020 <buf>
      2e:	fec42783          	lw	a5,-20(s0)
      32:	97ba                	add	a5,a5,a4
      34:	00078023          	sb	zero,0(a5)
    p = buf;
      38:	00002797          	auipc	a5,0x2
      3c:	fe878793          	addi	a5,a5,-24 # 2020 <buf>
      40:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      44:	a891                	j	98 <grep+0x98>
      *q = 0;
      46:	fd043783          	ld	a5,-48(s0)
      4a:	00078023          	sb	zero,0(a5)
      if(match(pattern, p)){
      4e:	fe043583          	ld	a1,-32(s0)
      52:	fc843503          	ld	a0,-56(s0)
      56:	00000097          	auipc	ra,0x0
      5a:	1fa080e7          	jalr	506(ra) # 250 <match>
      5e:	87aa                	mv	a5,a0
      60:	c79d                	beqz	a5,8e <grep+0x8e>
        *q = '\n';
      62:	fd043783          	ld	a5,-48(s0)
      66:	4729                	li	a4,10
      68:	00e78023          	sb	a4,0(a5)
        write(1, p, q+1 - p);
      6c:	fd043783          	ld	a5,-48(s0)
      70:	00178713          	addi	a4,a5,1
      74:	fe043783          	ld	a5,-32(s0)
      78:	40f707b3          	sub	a5,a4,a5
      7c:	2781                	sext.w	a5,a5
      7e:	863e                	mv	a2,a5
      80:	fe043583          	ld	a1,-32(s0)
      84:	4505                	li	a0,1
      86:	00001097          	auipc	ra,0x1
      8a:	85c080e7          	jalr	-1956(ra) # 8e2 <write>
      }
      p = q+1;
      8e:	fd043783          	ld	a5,-48(s0)
      92:	0785                	addi	a5,a5,1
      94:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      98:	45a9                	li	a1,10
      9a:	fe043503          	ld	a0,-32(s0)
      9e:	00000097          	auipc	ra,0x0
      a2:	4da080e7          	jalr	1242(ra) # 578 <strchr>
      a6:	fca43823          	sd	a0,-48(s0)
      aa:	fd043783          	ld	a5,-48(s0)
      ae:	ffc1                	bnez	a5,46 <grep+0x46>
    }
    if(m > 0){
      b0:	fec42783          	lw	a5,-20(s0)
      b4:	2781                	sext.w	a5,a5
      b6:	02f05f63          	blez	a5,f4 <grep+0xf4>
      m -= p - buf;
      ba:	fec42703          	lw	a4,-20(s0)
      be:	fe043683          	ld	a3,-32(s0)
      c2:	00002797          	auipc	a5,0x2
      c6:	f5e78793          	addi	a5,a5,-162 # 2020 <buf>
      ca:	40f687b3          	sub	a5,a3,a5
      ce:	2781                	sext.w	a5,a5
      d0:	40f707bb          	subw	a5,a4,a5
      d4:	2781                	sext.w	a5,a5
      d6:	fef42623          	sw	a5,-20(s0)
      memmove(buf, p, m);
      da:	fec42783          	lw	a5,-20(s0)
      de:	863e                	mv	a2,a5
      e0:	fe043583          	ld	a1,-32(s0)
      e4:	00002517          	auipc	a0,0x2
      e8:	f3c50513          	addi	a0,a0,-196 # 2020 <buf>
      ec:	00000097          	auipc	ra,0x0
      f0:	650080e7          	jalr	1616(ra) # 73c <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      f4:	fec42703          	lw	a4,-20(s0)
      f8:	00002797          	auipc	a5,0x2
      fc:	f2878793          	addi	a5,a5,-216 # 2020 <buf>
     100:	00f706b3          	add	a3,a4,a5
     104:	fec42783          	lw	a5,-20(s0)
     108:	3ff00713          	li	a4,1023
     10c:	40f707bb          	subw	a5,a4,a5
     110:	2781                	sext.w	a5,a5
     112:	0007871b          	sext.w	a4,a5
     116:	fc442783          	lw	a5,-60(s0)
     11a:	863a                	mv	a2,a4
     11c:	85b6                	mv	a1,a3
     11e:	853e                	mv	a0,a5
     120:	00000097          	auipc	ra,0x0
     124:	7ba080e7          	jalr	1978(ra) # 8da <read>
     128:	87aa                	mv	a5,a0
     12a:	fcf42e23          	sw	a5,-36(s0)
     12e:	fdc42783          	lw	a5,-36(s0)
     132:	2781                	sext.w	a5,a5
     134:	eef042e3          	bgtz	a5,18 <grep+0x18>
    }
  }
}
     138:	0001                	nop
     13a:	0001                	nop
     13c:	70e2                	ld	ra,56(sp)
     13e:	7442                	ld	s0,48(sp)
     140:	6121                	addi	sp,sp,64
     142:	8082                	ret

0000000000000144 <main>:

int
main(int argc, char *argv[])
{
     144:	7139                	addi	sp,sp,-64
     146:	fc06                	sd	ra,56(sp)
     148:	f822                	sd	s0,48(sp)
     14a:	0080                	addi	s0,sp,64
     14c:	87aa                	mv	a5,a0
     14e:	fcb43023          	sd	a1,-64(s0)
     152:	fcf42623          	sw	a5,-52(s0)
  int fd, i;
  char *pattern;

  if(argc <= 1){
     156:	fcc42783          	lw	a5,-52(s0)
     15a:	0007871b          	sext.w	a4,a5
     15e:	4785                	li	a5,1
     160:	02e7c063          	blt	a5,a4,180 <main+0x3c>
    fprintf(2, "usage: grep pattern [file ...]\n");
     164:	00001597          	auipc	a1,0x1
     168:	fbc58593          	addi	a1,a1,-68 # 1120 <malloc+0x13e>
     16c:	4509                	li	a0,2
     16e:	00001097          	auipc	ra,0x1
     172:	c2a080e7          	jalr	-982(ra) # d98 <fprintf>
    exit(1);
     176:	4505                	li	a0,1
     178:	00000097          	auipc	ra,0x0
     17c:	74a080e7          	jalr	1866(ra) # 8c2 <exit>
  }
  pattern = argv[1];
     180:	fc043783          	ld	a5,-64(s0)
     184:	679c                	ld	a5,8(a5)
     186:	fef43023          	sd	a5,-32(s0)

  if(argc <= 2){
     18a:	fcc42783          	lw	a5,-52(s0)
     18e:	0007871b          	sext.w	a4,a5
     192:	4789                	li	a5,2
     194:	00e7ce63          	blt	a5,a4,1b0 <main+0x6c>
    grep(pattern, 0);
     198:	4581                	li	a1,0
     19a:	fe043503          	ld	a0,-32(s0)
     19e:	00000097          	auipc	ra,0x0
     1a2:	e62080e7          	jalr	-414(ra) # 0 <grep>
    exit(0);
     1a6:	4501                	li	a0,0
     1a8:	00000097          	auipc	ra,0x0
     1ac:	71a080e7          	jalr	1818(ra) # 8c2 <exit>
  }

  for(i = 2; i < argc; i++){
     1b0:	4789                	li	a5,2
     1b2:	fef42623          	sw	a5,-20(s0)
     1b6:	a041                	j	236 <main+0xf2>
    if((fd = open(argv[i], 0)) < 0){
     1b8:	fec42783          	lw	a5,-20(s0)
     1bc:	078e                	slli	a5,a5,0x3
     1be:	fc043703          	ld	a4,-64(s0)
     1c2:	97ba                	add	a5,a5,a4
     1c4:	639c                	ld	a5,0(a5)
     1c6:	4581                	li	a1,0
     1c8:	853e                	mv	a0,a5
     1ca:	00000097          	auipc	ra,0x0
     1ce:	738080e7          	jalr	1848(ra) # 902 <open>
     1d2:	87aa                	mv	a5,a0
     1d4:	fcf42e23          	sw	a5,-36(s0)
     1d8:	fdc42783          	lw	a5,-36(s0)
     1dc:	2781                	sext.w	a5,a5
     1de:	0207d763          	bgez	a5,20c <main+0xc8>
      printf("grep: cannot open %s\n", argv[i]);
     1e2:	fec42783          	lw	a5,-20(s0)
     1e6:	078e                	slli	a5,a5,0x3
     1e8:	fc043703          	ld	a4,-64(s0)
     1ec:	97ba                	add	a5,a5,a4
     1ee:	639c                	ld	a5,0(a5)
     1f0:	85be                	mv	a1,a5
     1f2:	00001517          	auipc	a0,0x1
     1f6:	f4e50513          	addi	a0,a0,-178 # 1140 <malloc+0x15e>
     1fa:	00001097          	auipc	ra,0x1
     1fe:	bf6080e7          	jalr	-1034(ra) # df0 <printf>
      exit(1);
     202:	4505                	li	a0,1
     204:	00000097          	auipc	ra,0x0
     208:	6be080e7          	jalr	1726(ra) # 8c2 <exit>
    }
    grep(pattern, fd);
     20c:	fdc42783          	lw	a5,-36(s0)
     210:	85be                	mv	a1,a5
     212:	fe043503          	ld	a0,-32(s0)
     216:	00000097          	auipc	ra,0x0
     21a:	dea080e7          	jalr	-534(ra) # 0 <grep>
    close(fd);
     21e:	fdc42783          	lw	a5,-36(s0)
     222:	853e                	mv	a0,a5
     224:	00000097          	auipc	ra,0x0
     228:	6c6080e7          	jalr	1734(ra) # 8ea <close>
  for(i = 2; i < argc; i++){
     22c:	fec42783          	lw	a5,-20(s0)
     230:	2785                	addiw	a5,a5,1
     232:	fef42623          	sw	a5,-20(s0)
     236:	fec42703          	lw	a4,-20(s0)
     23a:	fcc42783          	lw	a5,-52(s0)
     23e:	2701                	sext.w	a4,a4
     240:	2781                	sext.w	a5,a5
     242:	f6f74be3          	blt	a4,a5,1b8 <main+0x74>
  }
  exit(0);
     246:	4501                	li	a0,0
     248:	00000097          	auipc	ra,0x0
     24c:	67a080e7          	jalr	1658(ra) # 8c2 <exit>

0000000000000250 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     250:	1101                	addi	sp,sp,-32
     252:	ec06                	sd	ra,24(sp)
     254:	e822                	sd	s0,16(sp)
     256:	1000                	addi	s0,sp,32
     258:	fea43423          	sd	a0,-24(s0)
     25c:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '^')
     260:	fe843783          	ld	a5,-24(s0)
     264:	0007c783          	lbu	a5,0(a5)
     268:	873e                	mv	a4,a5
     26a:	05e00793          	li	a5,94
     26e:	00f71e63          	bne	a4,a5,28a <match+0x3a>
    return matchhere(re+1, text);
     272:	fe843783          	ld	a5,-24(s0)
     276:	0785                	addi	a5,a5,1
     278:	fe043583          	ld	a1,-32(s0)
     27c:	853e                	mv	a0,a5
     27e:	00000097          	auipc	ra,0x0
     282:	042080e7          	jalr	66(ra) # 2c0 <matchhere>
     286:	87aa                	mv	a5,a0
     288:	a03d                	j	2b6 <match+0x66>
  do{  // must look at empty string
    if(matchhere(re, text))
     28a:	fe043583          	ld	a1,-32(s0)
     28e:	fe843503          	ld	a0,-24(s0)
     292:	00000097          	auipc	ra,0x0
     296:	02e080e7          	jalr	46(ra) # 2c0 <matchhere>
     29a:	87aa                	mv	a5,a0
     29c:	c399                	beqz	a5,2a2 <match+0x52>
      return 1;
     29e:	4785                	li	a5,1
     2a0:	a819                	j	2b6 <match+0x66>
  }while(*text++ != '\0');
     2a2:	fe043783          	ld	a5,-32(s0)
     2a6:	00178713          	addi	a4,a5,1
     2aa:	fee43023          	sd	a4,-32(s0)
     2ae:	0007c783          	lbu	a5,0(a5)
     2b2:	ffe1                	bnez	a5,28a <match+0x3a>
  return 0;
     2b4:	4781                	li	a5,0
}
     2b6:	853e                	mv	a0,a5
     2b8:	60e2                	ld	ra,24(sp)
     2ba:	6442                	ld	s0,16(sp)
     2bc:	6105                	addi	sp,sp,32
     2be:	8082                	ret

00000000000002c0 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     2c0:	1101                	addi	sp,sp,-32
     2c2:	ec06                	sd	ra,24(sp)
     2c4:	e822                	sd	s0,16(sp)
     2c6:	1000                	addi	s0,sp,32
     2c8:	fea43423          	sd	a0,-24(s0)
     2cc:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '\0')
     2d0:	fe843783          	ld	a5,-24(s0)
     2d4:	0007c783          	lbu	a5,0(a5)
     2d8:	e399                	bnez	a5,2de <matchhere+0x1e>
    return 1;
     2da:	4785                	li	a5,1
     2dc:	a0c1                	j	39c <matchhere+0xdc>
  if(re[1] == '*')
     2de:	fe843783          	ld	a5,-24(s0)
     2e2:	0785                	addi	a5,a5,1
     2e4:	0007c783          	lbu	a5,0(a5)
     2e8:	873e                	mv	a4,a5
     2ea:	02a00793          	li	a5,42
     2ee:	02f71563          	bne	a4,a5,318 <matchhere+0x58>
    return matchstar(re[0], re+2, text);
     2f2:	fe843783          	ld	a5,-24(s0)
     2f6:	0007c783          	lbu	a5,0(a5)
     2fa:	0007871b          	sext.w	a4,a5
     2fe:	fe843783          	ld	a5,-24(s0)
     302:	0789                	addi	a5,a5,2
     304:	fe043603          	ld	a2,-32(s0)
     308:	85be                	mv	a1,a5
     30a:	853a                	mv	a0,a4
     30c:	00000097          	auipc	ra,0x0
     310:	09a080e7          	jalr	154(ra) # 3a6 <matchstar>
     314:	87aa                	mv	a5,a0
     316:	a059                	j	39c <matchhere+0xdc>
  if(re[0] == '$' && re[1] == '\0')
     318:	fe843783          	ld	a5,-24(s0)
     31c:	0007c783          	lbu	a5,0(a5)
     320:	873e                	mv	a4,a5
     322:	02400793          	li	a5,36
     326:	02f71363          	bne	a4,a5,34c <matchhere+0x8c>
     32a:	fe843783          	ld	a5,-24(s0)
     32e:	0785                	addi	a5,a5,1
     330:	0007c783          	lbu	a5,0(a5)
     334:	ef81                	bnez	a5,34c <matchhere+0x8c>
    return *text == '\0';
     336:	fe043783          	ld	a5,-32(s0)
     33a:	0007c783          	lbu	a5,0(a5)
     33e:	2781                	sext.w	a5,a5
     340:	0017b793          	seqz	a5,a5
     344:	0ff7f793          	andi	a5,a5,255
     348:	2781                	sext.w	a5,a5
     34a:	a889                	j	39c <matchhere+0xdc>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     34c:	fe043783          	ld	a5,-32(s0)
     350:	0007c783          	lbu	a5,0(a5)
     354:	c3b9                	beqz	a5,39a <matchhere+0xda>
     356:	fe843783          	ld	a5,-24(s0)
     35a:	0007c783          	lbu	a5,0(a5)
     35e:	873e                	mv	a4,a5
     360:	02e00793          	li	a5,46
     364:	00f70c63          	beq	a4,a5,37c <matchhere+0xbc>
     368:	fe843783          	ld	a5,-24(s0)
     36c:	0007c703          	lbu	a4,0(a5)
     370:	fe043783          	ld	a5,-32(s0)
     374:	0007c783          	lbu	a5,0(a5)
     378:	02f71163          	bne	a4,a5,39a <matchhere+0xda>
    return matchhere(re+1, text+1);
     37c:	fe843783          	ld	a5,-24(s0)
     380:	00178713          	addi	a4,a5,1
     384:	fe043783          	ld	a5,-32(s0)
     388:	0785                	addi	a5,a5,1
     38a:	85be                	mv	a1,a5
     38c:	853a                	mv	a0,a4
     38e:	00000097          	auipc	ra,0x0
     392:	f32080e7          	jalr	-206(ra) # 2c0 <matchhere>
     396:	87aa                	mv	a5,a0
     398:	a011                	j	39c <matchhere+0xdc>
  return 0;
     39a:	4781                	li	a5,0
}
     39c:	853e                	mv	a0,a5
     39e:	60e2                	ld	ra,24(sp)
     3a0:	6442                	ld	s0,16(sp)
     3a2:	6105                	addi	sp,sp,32
     3a4:	8082                	ret

00000000000003a6 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     3a6:	7179                	addi	sp,sp,-48
     3a8:	f406                	sd	ra,40(sp)
     3aa:	f022                	sd	s0,32(sp)
     3ac:	1800                	addi	s0,sp,48
     3ae:	87aa                	mv	a5,a0
     3b0:	feb43023          	sd	a1,-32(s0)
     3b4:	fcc43c23          	sd	a2,-40(s0)
     3b8:	fef42623          	sw	a5,-20(s0)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     3bc:	fd843583          	ld	a1,-40(s0)
     3c0:	fe043503          	ld	a0,-32(s0)
     3c4:	00000097          	auipc	ra,0x0
     3c8:	efc080e7          	jalr	-260(ra) # 2c0 <matchhere>
     3cc:	87aa                	mv	a5,a0
     3ce:	c399                	beqz	a5,3d4 <matchstar+0x2e>
      return 1;
     3d0:	4785                	li	a5,1
     3d2:	a835                	j	40e <matchstar+0x68>
  }while(*text!='\0' && (*text++==c || c=='.'));
     3d4:	fd843783          	ld	a5,-40(s0)
     3d8:	0007c783          	lbu	a5,0(a5)
     3dc:	cb85                	beqz	a5,40c <matchstar+0x66>
     3de:	fd843783          	ld	a5,-40(s0)
     3e2:	00178713          	addi	a4,a5,1
     3e6:	fce43c23          	sd	a4,-40(s0)
     3ea:	0007c783          	lbu	a5,0(a5)
     3ee:	0007871b          	sext.w	a4,a5
     3f2:	fec42783          	lw	a5,-20(s0)
     3f6:	2781                	sext.w	a5,a5
     3f8:	fce782e3          	beq	a5,a4,3bc <matchstar+0x16>
     3fc:	fec42783          	lw	a5,-20(s0)
     400:	0007871b          	sext.w	a4,a5
     404:	02e00793          	li	a5,46
     408:	faf70ae3          	beq	a4,a5,3bc <matchstar+0x16>
  return 0;
     40c:	4781                	li	a5,0
}
     40e:	853e                	mv	a0,a5
     410:	70a2                	ld	ra,40(sp)
     412:	7402                	ld	s0,32(sp)
     414:	6145                	addi	sp,sp,48
     416:	8082                	ret

0000000000000418 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     418:	1141                	addi	sp,sp,-16
     41a:	e406                	sd	ra,8(sp)
     41c:	e022                	sd	s0,0(sp)
     41e:	0800                	addi	s0,sp,16
  extern int main();
  main();
     420:	00000097          	auipc	ra,0x0
     424:	d24080e7          	jalr	-732(ra) # 144 <main>
  exit(0);
     428:	4501                	li	a0,0
     42a:	00000097          	auipc	ra,0x0
     42e:	498080e7          	jalr	1176(ra) # 8c2 <exit>

0000000000000432 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     432:	7179                	addi	sp,sp,-48
     434:	f422                	sd	s0,40(sp)
     436:	1800                	addi	s0,sp,48
     438:	fca43c23          	sd	a0,-40(s0)
     43c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     440:	fd843783          	ld	a5,-40(s0)
     444:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     448:	0001                	nop
     44a:	fd043703          	ld	a4,-48(s0)
     44e:	00170793          	addi	a5,a4,1
     452:	fcf43823          	sd	a5,-48(s0)
     456:	fd843783          	ld	a5,-40(s0)
     45a:	00178693          	addi	a3,a5,1
     45e:	fcd43c23          	sd	a3,-40(s0)
     462:	00074703          	lbu	a4,0(a4)
     466:	00e78023          	sb	a4,0(a5)
     46a:	0007c783          	lbu	a5,0(a5)
     46e:	fff1                	bnez	a5,44a <strcpy+0x18>
    ;
  return os;
     470:	fe843783          	ld	a5,-24(s0)
}
     474:	853e                	mv	a0,a5
     476:	7422                	ld	s0,40(sp)
     478:	6145                	addi	sp,sp,48
     47a:	8082                	ret

000000000000047c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     47c:	1101                	addi	sp,sp,-32
     47e:	ec22                	sd	s0,24(sp)
     480:	1000                	addi	s0,sp,32
     482:	fea43423          	sd	a0,-24(s0)
     486:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     48a:	a819                	j	4a0 <strcmp+0x24>
    p++, q++;
     48c:	fe843783          	ld	a5,-24(s0)
     490:	0785                	addi	a5,a5,1
     492:	fef43423          	sd	a5,-24(s0)
     496:	fe043783          	ld	a5,-32(s0)
     49a:	0785                	addi	a5,a5,1
     49c:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     4a0:	fe843783          	ld	a5,-24(s0)
     4a4:	0007c783          	lbu	a5,0(a5)
     4a8:	cb99                	beqz	a5,4be <strcmp+0x42>
     4aa:	fe843783          	ld	a5,-24(s0)
     4ae:	0007c703          	lbu	a4,0(a5)
     4b2:	fe043783          	ld	a5,-32(s0)
     4b6:	0007c783          	lbu	a5,0(a5)
     4ba:	fcf709e3          	beq	a4,a5,48c <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     4be:	fe843783          	ld	a5,-24(s0)
     4c2:	0007c783          	lbu	a5,0(a5)
     4c6:	0007871b          	sext.w	a4,a5
     4ca:	fe043783          	ld	a5,-32(s0)
     4ce:	0007c783          	lbu	a5,0(a5)
     4d2:	2781                	sext.w	a5,a5
     4d4:	40f707bb          	subw	a5,a4,a5
     4d8:	2781                	sext.w	a5,a5
}
     4da:	853e                	mv	a0,a5
     4dc:	6462                	ld	s0,24(sp)
     4de:	6105                	addi	sp,sp,32
     4e0:	8082                	ret

00000000000004e2 <strlen>:

uint
strlen(const char *s)
{
     4e2:	7179                	addi	sp,sp,-48
     4e4:	f422                	sd	s0,40(sp)
     4e6:	1800                	addi	s0,sp,48
     4e8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     4ec:	fe042623          	sw	zero,-20(s0)
     4f0:	a031                	j	4fc <strlen+0x1a>
     4f2:	fec42783          	lw	a5,-20(s0)
     4f6:	2785                	addiw	a5,a5,1
     4f8:	fef42623          	sw	a5,-20(s0)
     4fc:	fec42783          	lw	a5,-20(s0)
     500:	fd843703          	ld	a4,-40(s0)
     504:	97ba                	add	a5,a5,a4
     506:	0007c783          	lbu	a5,0(a5)
     50a:	f7e5                	bnez	a5,4f2 <strlen+0x10>
    ;
  return n;
     50c:	fec42783          	lw	a5,-20(s0)
}
     510:	853e                	mv	a0,a5
     512:	7422                	ld	s0,40(sp)
     514:	6145                	addi	sp,sp,48
     516:	8082                	ret

0000000000000518 <memset>:

void*
memset(void *dst, int c, uint n)
{
     518:	7179                	addi	sp,sp,-48
     51a:	f422                	sd	s0,40(sp)
     51c:	1800                	addi	s0,sp,48
     51e:	fca43c23          	sd	a0,-40(s0)
     522:	87ae                	mv	a5,a1
     524:	8732                	mv	a4,a2
     526:	fcf42a23          	sw	a5,-44(s0)
     52a:	87ba                	mv	a5,a4
     52c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     530:	fd843783          	ld	a5,-40(s0)
     534:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     538:	fe042623          	sw	zero,-20(s0)
     53c:	a00d                	j	55e <memset+0x46>
    cdst[i] = c;
     53e:	fec42783          	lw	a5,-20(s0)
     542:	fe043703          	ld	a4,-32(s0)
     546:	97ba                	add	a5,a5,a4
     548:	fd442703          	lw	a4,-44(s0)
     54c:	0ff77713          	andi	a4,a4,255
     550:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     554:	fec42783          	lw	a5,-20(s0)
     558:	2785                	addiw	a5,a5,1
     55a:	fef42623          	sw	a5,-20(s0)
     55e:	fec42703          	lw	a4,-20(s0)
     562:	fd042783          	lw	a5,-48(s0)
     566:	2781                	sext.w	a5,a5
     568:	fcf76be3          	bltu	a4,a5,53e <memset+0x26>
  }
  return dst;
     56c:	fd843783          	ld	a5,-40(s0)
}
     570:	853e                	mv	a0,a5
     572:	7422                	ld	s0,40(sp)
     574:	6145                	addi	sp,sp,48
     576:	8082                	ret

0000000000000578 <strchr>:

char*
strchr(const char *s, char c)
{
     578:	1101                	addi	sp,sp,-32
     57a:	ec22                	sd	s0,24(sp)
     57c:	1000                	addi	s0,sp,32
     57e:	fea43423          	sd	a0,-24(s0)
     582:	87ae                	mv	a5,a1
     584:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     588:	a01d                	j	5ae <strchr+0x36>
    if(*s == c)
     58a:	fe843783          	ld	a5,-24(s0)
     58e:	0007c703          	lbu	a4,0(a5)
     592:	fe744783          	lbu	a5,-25(s0)
     596:	0ff7f793          	andi	a5,a5,255
     59a:	00e79563          	bne	a5,a4,5a4 <strchr+0x2c>
      return (char*)s;
     59e:	fe843783          	ld	a5,-24(s0)
     5a2:	a821                	j	5ba <strchr+0x42>
  for(; *s; s++)
     5a4:	fe843783          	ld	a5,-24(s0)
     5a8:	0785                	addi	a5,a5,1
     5aa:	fef43423          	sd	a5,-24(s0)
     5ae:	fe843783          	ld	a5,-24(s0)
     5b2:	0007c783          	lbu	a5,0(a5)
     5b6:	fbf1                	bnez	a5,58a <strchr+0x12>
  return 0;
     5b8:	4781                	li	a5,0
}
     5ba:	853e                	mv	a0,a5
     5bc:	6462                	ld	s0,24(sp)
     5be:	6105                	addi	sp,sp,32
     5c0:	8082                	ret

00000000000005c2 <gets>:

char*
gets(char *buf, int max)
{
     5c2:	7179                	addi	sp,sp,-48
     5c4:	f406                	sd	ra,40(sp)
     5c6:	f022                	sd	s0,32(sp)
     5c8:	1800                	addi	s0,sp,48
     5ca:	fca43c23          	sd	a0,-40(s0)
     5ce:	87ae                	mv	a5,a1
     5d0:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     5d4:	fe042623          	sw	zero,-20(s0)
     5d8:	a8a1                	j	630 <gets+0x6e>
    cc = read(0, &c, 1);
     5da:	fe740793          	addi	a5,s0,-25
     5de:	4605                	li	a2,1
     5e0:	85be                	mv	a1,a5
     5e2:	4501                	li	a0,0
     5e4:	00000097          	auipc	ra,0x0
     5e8:	2f6080e7          	jalr	758(ra) # 8da <read>
     5ec:	87aa                	mv	a5,a0
     5ee:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     5f2:	fe842783          	lw	a5,-24(s0)
     5f6:	2781                	sext.w	a5,a5
     5f8:	04f05763          	blez	a5,646 <gets+0x84>
      break;
    buf[i++] = c;
     5fc:	fec42783          	lw	a5,-20(s0)
     600:	0017871b          	addiw	a4,a5,1
     604:	fee42623          	sw	a4,-20(s0)
     608:	873e                	mv	a4,a5
     60a:	fd843783          	ld	a5,-40(s0)
     60e:	97ba                	add	a5,a5,a4
     610:	fe744703          	lbu	a4,-25(s0)
     614:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     618:	fe744783          	lbu	a5,-25(s0)
     61c:	873e                	mv	a4,a5
     61e:	47a9                	li	a5,10
     620:	02f70463          	beq	a4,a5,648 <gets+0x86>
     624:	fe744783          	lbu	a5,-25(s0)
     628:	873e                	mv	a4,a5
     62a:	47b5                	li	a5,13
     62c:	00f70e63          	beq	a4,a5,648 <gets+0x86>
  for(i=0; i+1 < max; ){
     630:	fec42783          	lw	a5,-20(s0)
     634:	2785                	addiw	a5,a5,1
     636:	0007871b          	sext.w	a4,a5
     63a:	fd442783          	lw	a5,-44(s0)
     63e:	2781                	sext.w	a5,a5
     640:	f8f74de3          	blt	a4,a5,5da <gets+0x18>
     644:	a011                	j	648 <gets+0x86>
      break;
     646:	0001                	nop
      break;
  }
  buf[i] = '\0';
     648:	fec42783          	lw	a5,-20(s0)
     64c:	fd843703          	ld	a4,-40(s0)
     650:	97ba                	add	a5,a5,a4
     652:	00078023          	sb	zero,0(a5)
  return buf;
     656:	fd843783          	ld	a5,-40(s0)
}
     65a:	853e                	mv	a0,a5
     65c:	70a2                	ld	ra,40(sp)
     65e:	7402                	ld	s0,32(sp)
     660:	6145                	addi	sp,sp,48
     662:	8082                	ret

0000000000000664 <stat>:

int
stat(const char *n, struct stat *st)
{
     664:	7179                	addi	sp,sp,-48
     666:	f406                	sd	ra,40(sp)
     668:	f022                	sd	s0,32(sp)
     66a:	1800                	addi	s0,sp,48
     66c:	fca43c23          	sd	a0,-40(s0)
     670:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     674:	4581                	li	a1,0
     676:	fd843503          	ld	a0,-40(s0)
     67a:	00000097          	auipc	ra,0x0
     67e:	288080e7          	jalr	648(ra) # 902 <open>
     682:	87aa                	mv	a5,a0
     684:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     688:	fec42783          	lw	a5,-20(s0)
     68c:	2781                	sext.w	a5,a5
     68e:	0007d463          	bgez	a5,696 <stat+0x32>
    return -1;
     692:	57fd                	li	a5,-1
     694:	a035                	j	6c0 <stat+0x5c>
  r = fstat(fd, st);
     696:	fec42783          	lw	a5,-20(s0)
     69a:	fd043583          	ld	a1,-48(s0)
     69e:	853e                	mv	a0,a5
     6a0:	00000097          	auipc	ra,0x0
     6a4:	27a080e7          	jalr	634(ra) # 91a <fstat>
     6a8:	87aa                	mv	a5,a0
     6aa:	fef42423          	sw	a5,-24(s0)
  close(fd);
     6ae:	fec42783          	lw	a5,-20(s0)
     6b2:	853e                	mv	a0,a5
     6b4:	00000097          	auipc	ra,0x0
     6b8:	236080e7          	jalr	566(ra) # 8ea <close>
  return r;
     6bc:	fe842783          	lw	a5,-24(s0)
}
     6c0:	853e                	mv	a0,a5
     6c2:	70a2                	ld	ra,40(sp)
     6c4:	7402                	ld	s0,32(sp)
     6c6:	6145                	addi	sp,sp,48
     6c8:	8082                	ret

00000000000006ca <atoi>:

int
atoi(const char *s)
{
     6ca:	7179                	addi	sp,sp,-48
     6cc:	f422                	sd	s0,40(sp)
     6ce:	1800                	addi	s0,sp,48
     6d0:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     6d4:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     6d8:	a815                	j	70c <atoi+0x42>
    n = n*10 + *s++ - '0';
     6da:	fec42703          	lw	a4,-20(s0)
     6de:	87ba                	mv	a5,a4
     6e0:	0027979b          	slliw	a5,a5,0x2
     6e4:	9fb9                	addw	a5,a5,a4
     6e6:	0017979b          	slliw	a5,a5,0x1
     6ea:	0007871b          	sext.w	a4,a5
     6ee:	fd843783          	ld	a5,-40(s0)
     6f2:	00178693          	addi	a3,a5,1
     6f6:	fcd43c23          	sd	a3,-40(s0)
     6fa:	0007c783          	lbu	a5,0(a5)
     6fe:	2781                	sext.w	a5,a5
     700:	9fb9                	addw	a5,a5,a4
     702:	2781                	sext.w	a5,a5
     704:	fd07879b          	addiw	a5,a5,-48
     708:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     70c:	fd843783          	ld	a5,-40(s0)
     710:	0007c783          	lbu	a5,0(a5)
     714:	873e                	mv	a4,a5
     716:	02f00793          	li	a5,47
     71a:	00e7fb63          	bgeu	a5,a4,730 <atoi+0x66>
     71e:	fd843783          	ld	a5,-40(s0)
     722:	0007c783          	lbu	a5,0(a5)
     726:	873e                	mv	a4,a5
     728:	03900793          	li	a5,57
     72c:	fae7f7e3          	bgeu	a5,a4,6da <atoi+0x10>
  return n;
     730:	fec42783          	lw	a5,-20(s0)
}
     734:	853e                	mv	a0,a5
     736:	7422                	ld	s0,40(sp)
     738:	6145                	addi	sp,sp,48
     73a:	8082                	ret

000000000000073c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     73c:	7139                	addi	sp,sp,-64
     73e:	fc22                	sd	s0,56(sp)
     740:	0080                	addi	s0,sp,64
     742:	fca43c23          	sd	a0,-40(s0)
     746:	fcb43823          	sd	a1,-48(s0)
     74a:	87b2                	mv	a5,a2
     74c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     750:	fd843783          	ld	a5,-40(s0)
     754:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     758:	fd043783          	ld	a5,-48(s0)
     75c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     760:	fe043703          	ld	a4,-32(s0)
     764:	fe843783          	ld	a5,-24(s0)
     768:	02e7fc63          	bgeu	a5,a4,7a0 <memmove+0x64>
    while(n-- > 0)
     76c:	a00d                	j	78e <memmove+0x52>
      *dst++ = *src++;
     76e:	fe043703          	ld	a4,-32(s0)
     772:	00170793          	addi	a5,a4,1
     776:	fef43023          	sd	a5,-32(s0)
     77a:	fe843783          	ld	a5,-24(s0)
     77e:	00178693          	addi	a3,a5,1
     782:	fed43423          	sd	a3,-24(s0)
     786:	00074703          	lbu	a4,0(a4)
     78a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     78e:	fcc42783          	lw	a5,-52(s0)
     792:	fff7871b          	addiw	a4,a5,-1
     796:	fce42623          	sw	a4,-52(s0)
     79a:	fcf04ae3          	bgtz	a5,76e <memmove+0x32>
     79e:	a891                	j	7f2 <memmove+0xb6>
  } else {
    dst += n;
     7a0:	fcc42783          	lw	a5,-52(s0)
     7a4:	fe843703          	ld	a4,-24(s0)
     7a8:	97ba                	add	a5,a5,a4
     7aa:	fef43423          	sd	a5,-24(s0)
    src += n;
     7ae:	fcc42783          	lw	a5,-52(s0)
     7b2:	fe043703          	ld	a4,-32(s0)
     7b6:	97ba                	add	a5,a5,a4
     7b8:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     7bc:	a01d                	j	7e2 <memmove+0xa6>
      *--dst = *--src;
     7be:	fe043783          	ld	a5,-32(s0)
     7c2:	17fd                	addi	a5,a5,-1
     7c4:	fef43023          	sd	a5,-32(s0)
     7c8:	fe843783          	ld	a5,-24(s0)
     7cc:	17fd                	addi	a5,a5,-1
     7ce:	fef43423          	sd	a5,-24(s0)
     7d2:	fe043783          	ld	a5,-32(s0)
     7d6:	0007c703          	lbu	a4,0(a5)
     7da:	fe843783          	ld	a5,-24(s0)
     7de:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     7e2:	fcc42783          	lw	a5,-52(s0)
     7e6:	fff7871b          	addiw	a4,a5,-1
     7ea:	fce42623          	sw	a4,-52(s0)
     7ee:	fcf048e3          	bgtz	a5,7be <memmove+0x82>
  }
  return vdst;
     7f2:	fd843783          	ld	a5,-40(s0)
}
     7f6:	853e                	mv	a0,a5
     7f8:	7462                	ld	s0,56(sp)
     7fa:	6121                	addi	sp,sp,64
     7fc:	8082                	ret

00000000000007fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     7fe:	7139                	addi	sp,sp,-64
     800:	fc22                	sd	s0,56(sp)
     802:	0080                	addi	s0,sp,64
     804:	fca43c23          	sd	a0,-40(s0)
     808:	fcb43823          	sd	a1,-48(s0)
     80c:	87b2                	mv	a5,a2
     80e:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     812:	fd843783          	ld	a5,-40(s0)
     816:	fef43423          	sd	a5,-24(s0)
     81a:	fd043783          	ld	a5,-48(s0)
     81e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     822:	a0a1                	j	86a <memcmp+0x6c>
    if (*p1 != *p2) {
     824:	fe843783          	ld	a5,-24(s0)
     828:	0007c703          	lbu	a4,0(a5)
     82c:	fe043783          	ld	a5,-32(s0)
     830:	0007c783          	lbu	a5,0(a5)
     834:	02f70163          	beq	a4,a5,856 <memcmp+0x58>
      return *p1 - *p2;
     838:	fe843783          	ld	a5,-24(s0)
     83c:	0007c783          	lbu	a5,0(a5)
     840:	0007871b          	sext.w	a4,a5
     844:	fe043783          	ld	a5,-32(s0)
     848:	0007c783          	lbu	a5,0(a5)
     84c:	2781                	sext.w	a5,a5
     84e:	40f707bb          	subw	a5,a4,a5
     852:	2781                	sext.w	a5,a5
     854:	a01d                	j	87a <memcmp+0x7c>
    }
    p1++;
     856:	fe843783          	ld	a5,-24(s0)
     85a:	0785                	addi	a5,a5,1
     85c:	fef43423          	sd	a5,-24(s0)
    p2++;
     860:	fe043783          	ld	a5,-32(s0)
     864:	0785                	addi	a5,a5,1
     866:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     86a:	fcc42783          	lw	a5,-52(s0)
     86e:	fff7871b          	addiw	a4,a5,-1
     872:	fce42623          	sw	a4,-52(s0)
     876:	f7dd                	bnez	a5,824 <memcmp+0x26>
  }
  return 0;
     878:	4781                	li	a5,0
}
     87a:	853e                	mv	a0,a5
     87c:	7462                	ld	s0,56(sp)
     87e:	6121                	addi	sp,sp,64
     880:	8082                	ret

0000000000000882 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     882:	7179                	addi	sp,sp,-48
     884:	f406                	sd	ra,40(sp)
     886:	f022                	sd	s0,32(sp)
     888:	1800                	addi	s0,sp,48
     88a:	fea43423          	sd	a0,-24(s0)
     88e:	feb43023          	sd	a1,-32(s0)
     892:	87b2                	mv	a5,a2
     894:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     898:	fdc42783          	lw	a5,-36(s0)
     89c:	863e                	mv	a2,a5
     89e:	fe043583          	ld	a1,-32(s0)
     8a2:	fe843503          	ld	a0,-24(s0)
     8a6:	00000097          	auipc	ra,0x0
     8aa:	e96080e7          	jalr	-362(ra) # 73c <memmove>
     8ae:	87aa                	mv	a5,a0
}
     8b0:	853e                	mv	a0,a5
     8b2:	70a2                	ld	ra,40(sp)
     8b4:	7402                	ld	s0,32(sp)
     8b6:	6145                	addi	sp,sp,48
     8b8:	8082                	ret

00000000000008ba <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     8ba:	4885                	li	a7,1
 ecall
     8bc:	00000073          	ecall
 ret
     8c0:	8082                	ret

00000000000008c2 <exit>:
.global exit
exit:
 li a7, SYS_exit
     8c2:	4889                	li	a7,2
 ecall
     8c4:	00000073          	ecall
 ret
     8c8:	8082                	ret

00000000000008ca <wait>:
.global wait
wait:
 li a7, SYS_wait
     8ca:	488d                	li	a7,3
 ecall
     8cc:	00000073          	ecall
 ret
     8d0:	8082                	ret

00000000000008d2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     8d2:	4891                	li	a7,4
 ecall
     8d4:	00000073          	ecall
 ret
     8d8:	8082                	ret

00000000000008da <read>:
.global read
read:
 li a7, SYS_read
     8da:	4895                	li	a7,5
 ecall
     8dc:	00000073          	ecall
 ret
     8e0:	8082                	ret

00000000000008e2 <write>:
.global write
write:
 li a7, SYS_write
     8e2:	48c1                	li	a7,16
 ecall
     8e4:	00000073          	ecall
 ret
     8e8:	8082                	ret

00000000000008ea <close>:
.global close
close:
 li a7, SYS_close
     8ea:	48d5                	li	a7,21
 ecall
     8ec:	00000073          	ecall
 ret
     8f0:	8082                	ret

00000000000008f2 <kill>:
.global kill
kill:
 li a7, SYS_kill
     8f2:	4899                	li	a7,6
 ecall
     8f4:	00000073          	ecall
 ret
     8f8:	8082                	ret

00000000000008fa <exec>:
.global exec
exec:
 li a7, SYS_exec
     8fa:	489d                	li	a7,7
 ecall
     8fc:	00000073          	ecall
 ret
     900:	8082                	ret

0000000000000902 <open>:
.global open
open:
 li a7, SYS_open
     902:	48bd                	li	a7,15
 ecall
     904:	00000073          	ecall
 ret
     908:	8082                	ret

000000000000090a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     90a:	48c5                	li	a7,17
 ecall
     90c:	00000073          	ecall
 ret
     910:	8082                	ret

0000000000000912 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     912:	48c9                	li	a7,18
 ecall
     914:	00000073          	ecall
 ret
     918:	8082                	ret

000000000000091a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     91a:	48a1                	li	a7,8
 ecall
     91c:	00000073          	ecall
 ret
     920:	8082                	ret

0000000000000922 <link>:
.global link
link:
 li a7, SYS_link
     922:	48cd                	li	a7,19
 ecall
     924:	00000073          	ecall
 ret
     928:	8082                	ret

000000000000092a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     92a:	48d1                	li	a7,20
 ecall
     92c:	00000073          	ecall
 ret
     930:	8082                	ret

0000000000000932 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     932:	48a5                	li	a7,9
 ecall
     934:	00000073          	ecall
 ret
     938:	8082                	ret

000000000000093a <dup>:
.global dup
dup:
 li a7, SYS_dup
     93a:	48a9                	li	a7,10
 ecall
     93c:	00000073          	ecall
 ret
     940:	8082                	ret

0000000000000942 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     942:	48ad                	li	a7,11
 ecall
     944:	00000073          	ecall
 ret
     948:	8082                	ret

000000000000094a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     94a:	48b1                	li	a7,12
 ecall
     94c:	00000073          	ecall
 ret
     950:	8082                	ret

0000000000000952 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     952:	48b5                	li	a7,13
 ecall
     954:	00000073          	ecall
 ret
     958:	8082                	ret

000000000000095a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     95a:	48b9                	li	a7,14
 ecall
     95c:	00000073          	ecall
 ret
     960:	8082                	ret

0000000000000962 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     962:	1101                	addi	sp,sp,-32
     964:	ec06                	sd	ra,24(sp)
     966:	e822                	sd	s0,16(sp)
     968:	1000                	addi	s0,sp,32
     96a:	87aa                	mv	a5,a0
     96c:	872e                	mv	a4,a1
     96e:	fef42623          	sw	a5,-20(s0)
     972:	87ba                	mv	a5,a4
     974:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     978:	feb40713          	addi	a4,s0,-21
     97c:	fec42783          	lw	a5,-20(s0)
     980:	4605                	li	a2,1
     982:	85ba                	mv	a1,a4
     984:	853e                	mv	a0,a5
     986:	00000097          	auipc	ra,0x0
     98a:	f5c080e7          	jalr	-164(ra) # 8e2 <write>
}
     98e:	0001                	nop
     990:	60e2                	ld	ra,24(sp)
     992:	6442                	ld	s0,16(sp)
     994:	6105                	addi	sp,sp,32
     996:	8082                	ret

0000000000000998 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     998:	7139                	addi	sp,sp,-64
     99a:	fc06                	sd	ra,56(sp)
     99c:	f822                	sd	s0,48(sp)
     99e:	0080                	addi	s0,sp,64
     9a0:	87aa                	mv	a5,a0
     9a2:	8736                	mv	a4,a3
     9a4:	fcf42623          	sw	a5,-52(s0)
     9a8:	87ae                	mv	a5,a1
     9aa:	fcf42423          	sw	a5,-56(s0)
     9ae:	87b2                	mv	a5,a2
     9b0:	fcf42223          	sw	a5,-60(s0)
     9b4:	87ba                	mv	a5,a4
     9b6:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     9ba:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     9be:	fc042783          	lw	a5,-64(s0)
     9c2:	2781                	sext.w	a5,a5
     9c4:	c38d                	beqz	a5,9e6 <printint+0x4e>
     9c6:	fc842783          	lw	a5,-56(s0)
     9ca:	2781                	sext.w	a5,a5
     9cc:	0007dd63          	bgez	a5,9e6 <printint+0x4e>
    neg = 1;
     9d0:	4785                	li	a5,1
     9d2:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     9d6:	fc842783          	lw	a5,-56(s0)
     9da:	40f007bb          	negw	a5,a5
     9de:	2781                	sext.w	a5,a5
     9e0:	fef42223          	sw	a5,-28(s0)
     9e4:	a029                	j	9ee <printint+0x56>
  } else {
    x = xx;
     9e6:	fc842783          	lw	a5,-56(s0)
     9ea:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     9ee:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     9f2:	fc442783          	lw	a5,-60(s0)
     9f6:	fe442703          	lw	a4,-28(s0)
     9fa:	02f777bb          	remuw	a5,a4,a5
     9fe:	0007861b          	sext.w	a2,a5
     a02:	fec42783          	lw	a5,-20(s0)
     a06:	0017871b          	addiw	a4,a5,1
     a0a:	fee42623          	sw	a4,-20(s0)
     a0e:	00001697          	auipc	a3,0x1
     a12:	5f268693          	addi	a3,a3,1522 # 2000 <digits>
     a16:	02061713          	slli	a4,a2,0x20
     a1a:	9301                	srli	a4,a4,0x20
     a1c:	9736                	add	a4,a4,a3
     a1e:	00074703          	lbu	a4,0(a4)
     a22:	ff040693          	addi	a3,s0,-16
     a26:	97b6                	add	a5,a5,a3
     a28:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     a2c:	fc442783          	lw	a5,-60(s0)
     a30:	fe442703          	lw	a4,-28(s0)
     a34:	02f757bb          	divuw	a5,a4,a5
     a38:	fef42223          	sw	a5,-28(s0)
     a3c:	fe442783          	lw	a5,-28(s0)
     a40:	2781                	sext.w	a5,a5
     a42:	fbc5                	bnez	a5,9f2 <printint+0x5a>
  if(neg)
     a44:	fe842783          	lw	a5,-24(s0)
     a48:	2781                	sext.w	a5,a5
     a4a:	cf95                	beqz	a5,a86 <printint+0xee>
    buf[i++] = '-';
     a4c:	fec42783          	lw	a5,-20(s0)
     a50:	0017871b          	addiw	a4,a5,1
     a54:	fee42623          	sw	a4,-20(s0)
     a58:	ff040713          	addi	a4,s0,-16
     a5c:	97ba                	add	a5,a5,a4
     a5e:	02d00713          	li	a4,45
     a62:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     a66:	a005                	j	a86 <printint+0xee>
    putc(fd, buf[i]);
     a68:	fec42783          	lw	a5,-20(s0)
     a6c:	ff040713          	addi	a4,s0,-16
     a70:	97ba                	add	a5,a5,a4
     a72:	fe07c703          	lbu	a4,-32(a5)
     a76:	fcc42783          	lw	a5,-52(s0)
     a7a:	85ba                	mv	a1,a4
     a7c:	853e                	mv	a0,a5
     a7e:	00000097          	auipc	ra,0x0
     a82:	ee4080e7          	jalr	-284(ra) # 962 <putc>
  while(--i >= 0)
     a86:	fec42783          	lw	a5,-20(s0)
     a8a:	37fd                	addiw	a5,a5,-1
     a8c:	fef42623          	sw	a5,-20(s0)
     a90:	fec42783          	lw	a5,-20(s0)
     a94:	2781                	sext.w	a5,a5
     a96:	fc07d9e3          	bgez	a5,a68 <printint+0xd0>
}
     a9a:	0001                	nop
     a9c:	0001                	nop
     a9e:	70e2                	ld	ra,56(sp)
     aa0:	7442                	ld	s0,48(sp)
     aa2:	6121                	addi	sp,sp,64
     aa4:	8082                	ret

0000000000000aa6 <printptr>:

static void
printptr(int fd, uint64 x) {
     aa6:	7179                	addi	sp,sp,-48
     aa8:	f406                	sd	ra,40(sp)
     aaa:	f022                	sd	s0,32(sp)
     aac:	1800                	addi	s0,sp,48
     aae:	87aa                	mv	a5,a0
     ab0:	fcb43823          	sd	a1,-48(s0)
     ab4:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     ab8:	fdc42783          	lw	a5,-36(s0)
     abc:	03000593          	li	a1,48
     ac0:	853e                	mv	a0,a5
     ac2:	00000097          	auipc	ra,0x0
     ac6:	ea0080e7          	jalr	-352(ra) # 962 <putc>
  putc(fd, 'x');
     aca:	fdc42783          	lw	a5,-36(s0)
     ace:	07800593          	li	a1,120
     ad2:	853e                	mv	a0,a5
     ad4:	00000097          	auipc	ra,0x0
     ad8:	e8e080e7          	jalr	-370(ra) # 962 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     adc:	fe042623          	sw	zero,-20(s0)
     ae0:	a82d                	j	b1a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ae2:	fd043783          	ld	a5,-48(s0)
     ae6:	93f1                	srli	a5,a5,0x3c
     ae8:	00001717          	auipc	a4,0x1
     aec:	51870713          	addi	a4,a4,1304 # 2000 <digits>
     af0:	97ba                	add	a5,a5,a4
     af2:	0007c703          	lbu	a4,0(a5)
     af6:	fdc42783          	lw	a5,-36(s0)
     afa:	85ba                	mv	a1,a4
     afc:	853e                	mv	a0,a5
     afe:	00000097          	auipc	ra,0x0
     b02:	e64080e7          	jalr	-412(ra) # 962 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b06:	fec42783          	lw	a5,-20(s0)
     b0a:	2785                	addiw	a5,a5,1
     b0c:	fef42623          	sw	a5,-20(s0)
     b10:	fd043783          	ld	a5,-48(s0)
     b14:	0792                	slli	a5,a5,0x4
     b16:	fcf43823          	sd	a5,-48(s0)
     b1a:	fec42783          	lw	a5,-20(s0)
     b1e:	873e                	mv	a4,a5
     b20:	47bd                	li	a5,15
     b22:	fce7f0e3          	bgeu	a5,a4,ae2 <printptr+0x3c>
}
     b26:	0001                	nop
     b28:	0001                	nop
     b2a:	70a2                	ld	ra,40(sp)
     b2c:	7402                	ld	s0,32(sp)
     b2e:	6145                	addi	sp,sp,48
     b30:	8082                	ret

0000000000000b32 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b32:	715d                	addi	sp,sp,-80
     b34:	e486                	sd	ra,72(sp)
     b36:	e0a2                	sd	s0,64(sp)
     b38:	0880                	addi	s0,sp,80
     b3a:	87aa                	mv	a5,a0
     b3c:	fcb43023          	sd	a1,-64(s0)
     b40:	fac43c23          	sd	a2,-72(s0)
     b44:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     b48:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b4c:	fe042223          	sw	zero,-28(s0)
     b50:	a42d                	j	d7a <vprintf+0x248>
    c = fmt[i] & 0xff;
     b52:	fe442783          	lw	a5,-28(s0)
     b56:	fc043703          	ld	a4,-64(s0)
     b5a:	97ba                	add	a5,a5,a4
     b5c:	0007c783          	lbu	a5,0(a5)
     b60:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     b64:	fe042783          	lw	a5,-32(s0)
     b68:	2781                	sext.w	a5,a5
     b6a:	eb9d                	bnez	a5,ba0 <vprintf+0x6e>
      if(c == '%'){
     b6c:	fdc42783          	lw	a5,-36(s0)
     b70:	0007871b          	sext.w	a4,a5
     b74:	02500793          	li	a5,37
     b78:	00f71763          	bne	a4,a5,b86 <vprintf+0x54>
        state = '%';
     b7c:	02500793          	li	a5,37
     b80:	fef42023          	sw	a5,-32(s0)
     b84:	a2f5                	j	d70 <vprintf+0x23e>
      } else {
        putc(fd, c);
     b86:	fdc42783          	lw	a5,-36(s0)
     b8a:	0ff7f713          	andi	a4,a5,255
     b8e:	fcc42783          	lw	a5,-52(s0)
     b92:	85ba                	mv	a1,a4
     b94:	853e                	mv	a0,a5
     b96:	00000097          	auipc	ra,0x0
     b9a:	dcc080e7          	jalr	-564(ra) # 962 <putc>
     b9e:	aac9                	j	d70 <vprintf+0x23e>
      }
    } else if(state == '%'){
     ba0:	fe042783          	lw	a5,-32(s0)
     ba4:	0007871b          	sext.w	a4,a5
     ba8:	02500793          	li	a5,37
     bac:	1cf71263          	bne	a4,a5,d70 <vprintf+0x23e>
      if(c == 'd'){
     bb0:	fdc42783          	lw	a5,-36(s0)
     bb4:	0007871b          	sext.w	a4,a5
     bb8:	06400793          	li	a5,100
     bbc:	02f71463          	bne	a4,a5,be4 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     bc0:	fb843783          	ld	a5,-72(s0)
     bc4:	00878713          	addi	a4,a5,8
     bc8:	fae43c23          	sd	a4,-72(s0)
     bcc:	4398                	lw	a4,0(a5)
     bce:	fcc42783          	lw	a5,-52(s0)
     bd2:	4685                	li	a3,1
     bd4:	4629                	li	a2,10
     bd6:	85ba                	mv	a1,a4
     bd8:	853e                	mv	a0,a5
     bda:	00000097          	auipc	ra,0x0
     bde:	dbe080e7          	jalr	-578(ra) # 998 <printint>
     be2:	a269                	j	d6c <vprintf+0x23a>
      } else if(c == 'l') {
     be4:	fdc42783          	lw	a5,-36(s0)
     be8:	0007871b          	sext.w	a4,a5
     bec:	06c00793          	li	a5,108
     bf0:	02f71663          	bne	a4,a5,c1c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     bf4:	fb843783          	ld	a5,-72(s0)
     bf8:	00878713          	addi	a4,a5,8
     bfc:	fae43c23          	sd	a4,-72(s0)
     c00:	639c                	ld	a5,0(a5)
     c02:	0007871b          	sext.w	a4,a5
     c06:	fcc42783          	lw	a5,-52(s0)
     c0a:	4681                	li	a3,0
     c0c:	4629                	li	a2,10
     c0e:	85ba                	mv	a1,a4
     c10:	853e                	mv	a0,a5
     c12:	00000097          	auipc	ra,0x0
     c16:	d86080e7          	jalr	-634(ra) # 998 <printint>
     c1a:	aa89                	j	d6c <vprintf+0x23a>
      } else if(c == 'x') {
     c1c:	fdc42783          	lw	a5,-36(s0)
     c20:	0007871b          	sext.w	a4,a5
     c24:	07800793          	li	a5,120
     c28:	02f71463          	bne	a4,a5,c50 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     c2c:	fb843783          	ld	a5,-72(s0)
     c30:	00878713          	addi	a4,a5,8
     c34:	fae43c23          	sd	a4,-72(s0)
     c38:	4398                	lw	a4,0(a5)
     c3a:	fcc42783          	lw	a5,-52(s0)
     c3e:	4681                	li	a3,0
     c40:	4641                	li	a2,16
     c42:	85ba                	mv	a1,a4
     c44:	853e                	mv	a0,a5
     c46:	00000097          	auipc	ra,0x0
     c4a:	d52080e7          	jalr	-686(ra) # 998 <printint>
     c4e:	aa39                	j	d6c <vprintf+0x23a>
      } else if(c == 'p') {
     c50:	fdc42783          	lw	a5,-36(s0)
     c54:	0007871b          	sext.w	a4,a5
     c58:	07000793          	li	a5,112
     c5c:	02f71263          	bne	a4,a5,c80 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     c60:	fb843783          	ld	a5,-72(s0)
     c64:	00878713          	addi	a4,a5,8
     c68:	fae43c23          	sd	a4,-72(s0)
     c6c:	6398                	ld	a4,0(a5)
     c6e:	fcc42783          	lw	a5,-52(s0)
     c72:	85ba                	mv	a1,a4
     c74:	853e                	mv	a0,a5
     c76:	00000097          	auipc	ra,0x0
     c7a:	e30080e7          	jalr	-464(ra) # aa6 <printptr>
     c7e:	a0fd                	j	d6c <vprintf+0x23a>
      } else if(c == 's'){
     c80:	fdc42783          	lw	a5,-36(s0)
     c84:	0007871b          	sext.w	a4,a5
     c88:	07300793          	li	a5,115
     c8c:	04f71c63          	bne	a4,a5,ce4 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c90:	fb843783          	ld	a5,-72(s0)
     c94:	00878713          	addi	a4,a5,8
     c98:	fae43c23          	sd	a4,-72(s0)
     c9c:	639c                	ld	a5,0(a5)
     c9e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     ca2:	fe843783          	ld	a5,-24(s0)
     ca6:	eb8d                	bnez	a5,cd8 <vprintf+0x1a6>
          s = "(null)";
     ca8:	00000797          	auipc	a5,0x0
     cac:	4b078793          	addi	a5,a5,1200 # 1158 <malloc+0x176>
     cb0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     cb4:	a015                	j	cd8 <vprintf+0x1a6>
          putc(fd, *s);
     cb6:	fe843783          	ld	a5,-24(s0)
     cba:	0007c703          	lbu	a4,0(a5)
     cbe:	fcc42783          	lw	a5,-52(s0)
     cc2:	85ba                	mv	a1,a4
     cc4:	853e                	mv	a0,a5
     cc6:	00000097          	auipc	ra,0x0
     cca:	c9c080e7          	jalr	-868(ra) # 962 <putc>
          s++;
     cce:	fe843783          	ld	a5,-24(s0)
     cd2:	0785                	addi	a5,a5,1
     cd4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     cd8:	fe843783          	ld	a5,-24(s0)
     cdc:	0007c783          	lbu	a5,0(a5)
     ce0:	fbf9                	bnez	a5,cb6 <vprintf+0x184>
     ce2:	a069                	j	d6c <vprintf+0x23a>
        }
      } else if(c == 'c'){
     ce4:	fdc42783          	lw	a5,-36(s0)
     ce8:	0007871b          	sext.w	a4,a5
     cec:	06300793          	li	a5,99
     cf0:	02f71463          	bne	a4,a5,d18 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     cf4:	fb843783          	ld	a5,-72(s0)
     cf8:	00878713          	addi	a4,a5,8
     cfc:	fae43c23          	sd	a4,-72(s0)
     d00:	439c                	lw	a5,0(a5)
     d02:	0ff7f713          	andi	a4,a5,255
     d06:	fcc42783          	lw	a5,-52(s0)
     d0a:	85ba                	mv	a1,a4
     d0c:	853e                	mv	a0,a5
     d0e:	00000097          	auipc	ra,0x0
     d12:	c54080e7          	jalr	-940(ra) # 962 <putc>
     d16:	a899                	j	d6c <vprintf+0x23a>
      } else if(c == '%'){
     d18:	fdc42783          	lw	a5,-36(s0)
     d1c:	0007871b          	sext.w	a4,a5
     d20:	02500793          	li	a5,37
     d24:	00f71f63          	bne	a4,a5,d42 <vprintf+0x210>
        putc(fd, c);
     d28:	fdc42783          	lw	a5,-36(s0)
     d2c:	0ff7f713          	andi	a4,a5,255
     d30:	fcc42783          	lw	a5,-52(s0)
     d34:	85ba                	mv	a1,a4
     d36:	853e                	mv	a0,a5
     d38:	00000097          	auipc	ra,0x0
     d3c:	c2a080e7          	jalr	-982(ra) # 962 <putc>
     d40:	a035                	j	d6c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d42:	fcc42783          	lw	a5,-52(s0)
     d46:	02500593          	li	a1,37
     d4a:	853e                	mv	a0,a5
     d4c:	00000097          	auipc	ra,0x0
     d50:	c16080e7          	jalr	-1002(ra) # 962 <putc>
        putc(fd, c);
     d54:	fdc42783          	lw	a5,-36(s0)
     d58:	0ff7f713          	andi	a4,a5,255
     d5c:	fcc42783          	lw	a5,-52(s0)
     d60:	85ba                	mv	a1,a4
     d62:	853e                	mv	a0,a5
     d64:	00000097          	auipc	ra,0x0
     d68:	bfe080e7          	jalr	-1026(ra) # 962 <putc>
      }
      state = 0;
     d6c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     d70:	fe442783          	lw	a5,-28(s0)
     d74:	2785                	addiw	a5,a5,1
     d76:	fef42223          	sw	a5,-28(s0)
     d7a:	fe442783          	lw	a5,-28(s0)
     d7e:	fc043703          	ld	a4,-64(s0)
     d82:	97ba                	add	a5,a5,a4
     d84:	0007c783          	lbu	a5,0(a5)
     d88:	dc0795e3          	bnez	a5,b52 <vprintf+0x20>
    }
  }
}
     d8c:	0001                	nop
     d8e:	0001                	nop
     d90:	60a6                	ld	ra,72(sp)
     d92:	6406                	ld	s0,64(sp)
     d94:	6161                	addi	sp,sp,80
     d96:	8082                	ret

0000000000000d98 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d98:	7159                	addi	sp,sp,-112
     d9a:	fc06                	sd	ra,56(sp)
     d9c:	f822                	sd	s0,48(sp)
     d9e:	0080                	addi	s0,sp,64
     da0:	fcb43823          	sd	a1,-48(s0)
     da4:	e010                	sd	a2,0(s0)
     da6:	e414                	sd	a3,8(s0)
     da8:	e818                	sd	a4,16(s0)
     daa:	ec1c                	sd	a5,24(s0)
     dac:	03043023          	sd	a6,32(s0)
     db0:	03143423          	sd	a7,40(s0)
     db4:	87aa                	mv	a5,a0
     db6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     dba:	03040793          	addi	a5,s0,48
     dbe:	fcf43423          	sd	a5,-56(s0)
     dc2:	fc843783          	ld	a5,-56(s0)
     dc6:	fd078793          	addi	a5,a5,-48
     dca:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     dce:	fe843703          	ld	a4,-24(s0)
     dd2:	fdc42783          	lw	a5,-36(s0)
     dd6:	863a                	mv	a2,a4
     dd8:	fd043583          	ld	a1,-48(s0)
     ddc:	853e                	mv	a0,a5
     dde:	00000097          	auipc	ra,0x0
     de2:	d54080e7          	jalr	-684(ra) # b32 <vprintf>
}
     de6:	0001                	nop
     de8:	70e2                	ld	ra,56(sp)
     dea:	7442                	ld	s0,48(sp)
     dec:	6165                	addi	sp,sp,112
     dee:	8082                	ret

0000000000000df0 <printf>:

void
printf(const char *fmt, ...)
{
     df0:	7159                	addi	sp,sp,-112
     df2:	f406                	sd	ra,40(sp)
     df4:	f022                	sd	s0,32(sp)
     df6:	1800                	addi	s0,sp,48
     df8:	fca43c23          	sd	a0,-40(s0)
     dfc:	e40c                	sd	a1,8(s0)
     dfe:	e810                	sd	a2,16(s0)
     e00:	ec14                	sd	a3,24(s0)
     e02:	f018                	sd	a4,32(s0)
     e04:	f41c                	sd	a5,40(s0)
     e06:	03043823          	sd	a6,48(s0)
     e0a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e0e:	04040793          	addi	a5,s0,64
     e12:	fcf43823          	sd	a5,-48(s0)
     e16:	fd043783          	ld	a5,-48(s0)
     e1a:	fc878793          	addi	a5,a5,-56
     e1e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e22:	fe843783          	ld	a5,-24(s0)
     e26:	863e                	mv	a2,a5
     e28:	fd843583          	ld	a1,-40(s0)
     e2c:	4505                	li	a0,1
     e2e:	00000097          	auipc	ra,0x0
     e32:	d04080e7          	jalr	-764(ra) # b32 <vprintf>
}
     e36:	0001                	nop
     e38:	70a2                	ld	ra,40(sp)
     e3a:	7402                	ld	s0,32(sp)
     e3c:	6165                	addi	sp,sp,112
     e3e:	8082                	ret

0000000000000e40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e40:	7179                	addi	sp,sp,-48
     e42:	f422                	sd	s0,40(sp)
     e44:	1800                	addi	s0,sp,48
     e46:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e4a:	fd843783          	ld	a5,-40(s0)
     e4e:	17c1                	addi	a5,a5,-16
     e50:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e54:	00001797          	auipc	a5,0x1
     e58:	5dc78793          	addi	a5,a5,1500 # 2430 <freep>
     e5c:	639c                	ld	a5,0(a5)
     e5e:	fef43423          	sd	a5,-24(s0)
     e62:	a815                	j	e96 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e64:	fe843783          	ld	a5,-24(s0)
     e68:	639c                	ld	a5,0(a5)
     e6a:	fe843703          	ld	a4,-24(s0)
     e6e:	00f76f63          	bltu	a4,a5,e8c <free+0x4c>
     e72:	fe043703          	ld	a4,-32(s0)
     e76:	fe843783          	ld	a5,-24(s0)
     e7a:	02e7eb63          	bltu	a5,a4,eb0 <free+0x70>
     e7e:	fe843783          	ld	a5,-24(s0)
     e82:	639c                	ld	a5,0(a5)
     e84:	fe043703          	ld	a4,-32(s0)
     e88:	02f76463          	bltu	a4,a5,eb0 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e8c:	fe843783          	ld	a5,-24(s0)
     e90:	639c                	ld	a5,0(a5)
     e92:	fef43423          	sd	a5,-24(s0)
     e96:	fe043703          	ld	a4,-32(s0)
     e9a:	fe843783          	ld	a5,-24(s0)
     e9e:	fce7f3e3          	bgeu	a5,a4,e64 <free+0x24>
     ea2:	fe843783          	ld	a5,-24(s0)
     ea6:	639c                	ld	a5,0(a5)
     ea8:	fe043703          	ld	a4,-32(s0)
     eac:	faf77ce3          	bgeu	a4,a5,e64 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     eb0:	fe043783          	ld	a5,-32(s0)
     eb4:	479c                	lw	a5,8(a5)
     eb6:	1782                	slli	a5,a5,0x20
     eb8:	9381                	srli	a5,a5,0x20
     eba:	0792                	slli	a5,a5,0x4
     ebc:	fe043703          	ld	a4,-32(s0)
     ec0:	973e                	add	a4,a4,a5
     ec2:	fe843783          	ld	a5,-24(s0)
     ec6:	639c                	ld	a5,0(a5)
     ec8:	02f71763          	bne	a4,a5,ef6 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     ecc:	fe043783          	ld	a5,-32(s0)
     ed0:	4798                	lw	a4,8(a5)
     ed2:	fe843783          	ld	a5,-24(s0)
     ed6:	639c                	ld	a5,0(a5)
     ed8:	479c                	lw	a5,8(a5)
     eda:	9fb9                	addw	a5,a5,a4
     edc:	0007871b          	sext.w	a4,a5
     ee0:	fe043783          	ld	a5,-32(s0)
     ee4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     ee6:	fe843783          	ld	a5,-24(s0)
     eea:	639c                	ld	a5,0(a5)
     eec:	6398                	ld	a4,0(a5)
     eee:	fe043783          	ld	a5,-32(s0)
     ef2:	e398                	sd	a4,0(a5)
     ef4:	a039                	j	f02 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     ef6:	fe843783          	ld	a5,-24(s0)
     efa:	6398                	ld	a4,0(a5)
     efc:	fe043783          	ld	a5,-32(s0)
     f00:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     f02:	fe843783          	ld	a5,-24(s0)
     f06:	479c                	lw	a5,8(a5)
     f08:	1782                	slli	a5,a5,0x20
     f0a:	9381                	srli	a5,a5,0x20
     f0c:	0792                	slli	a5,a5,0x4
     f0e:	fe843703          	ld	a4,-24(s0)
     f12:	97ba                	add	a5,a5,a4
     f14:	fe043703          	ld	a4,-32(s0)
     f18:	02f71563          	bne	a4,a5,f42 <free+0x102>
    p->s.size += bp->s.size;
     f1c:	fe843783          	ld	a5,-24(s0)
     f20:	4798                	lw	a4,8(a5)
     f22:	fe043783          	ld	a5,-32(s0)
     f26:	479c                	lw	a5,8(a5)
     f28:	9fb9                	addw	a5,a5,a4
     f2a:	0007871b          	sext.w	a4,a5
     f2e:	fe843783          	ld	a5,-24(s0)
     f32:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f34:	fe043783          	ld	a5,-32(s0)
     f38:	6398                	ld	a4,0(a5)
     f3a:	fe843783          	ld	a5,-24(s0)
     f3e:	e398                	sd	a4,0(a5)
     f40:	a031                	j	f4c <free+0x10c>
  } else
    p->s.ptr = bp;
     f42:	fe843783          	ld	a5,-24(s0)
     f46:	fe043703          	ld	a4,-32(s0)
     f4a:	e398                	sd	a4,0(a5)
  freep = p;
     f4c:	00001797          	auipc	a5,0x1
     f50:	4e478793          	addi	a5,a5,1252 # 2430 <freep>
     f54:	fe843703          	ld	a4,-24(s0)
     f58:	e398                	sd	a4,0(a5)
}
     f5a:	0001                	nop
     f5c:	7422                	ld	s0,40(sp)
     f5e:	6145                	addi	sp,sp,48
     f60:	8082                	ret

0000000000000f62 <morecore>:

static Header*
morecore(uint nu)
{
     f62:	7179                	addi	sp,sp,-48
     f64:	f406                	sd	ra,40(sp)
     f66:	f022                	sd	s0,32(sp)
     f68:	1800                	addi	s0,sp,48
     f6a:	87aa                	mv	a5,a0
     f6c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f70:	fdc42783          	lw	a5,-36(s0)
     f74:	0007871b          	sext.w	a4,a5
     f78:	6785                	lui	a5,0x1
     f7a:	00f77563          	bgeu	a4,a5,f84 <morecore+0x22>
    nu = 4096;
     f7e:	6785                	lui	a5,0x1
     f80:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f84:	fdc42783          	lw	a5,-36(s0)
     f88:	0047979b          	slliw	a5,a5,0x4
     f8c:	2781                	sext.w	a5,a5
     f8e:	2781                	sext.w	a5,a5
     f90:	853e                	mv	a0,a5
     f92:	00000097          	auipc	ra,0x0
     f96:	9b8080e7          	jalr	-1608(ra) # 94a <sbrk>
     f9a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f9e:	fe843703          	ld	a4,-24(s0)
     fa2:	57fd                	li	a5,-1
     fa4:	00f71463          	bne	a4,a5,fac <morecore+0x4a>
    return 0;
     fa8:	4781                	li	a5,0
     faa:	a03d                	j	fd8 <morecore+0x76>
  hp = (Header*)p;
     fac:	fe843783          	ld	a5,-24(s0)
     fb0:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     fb4:	fe043783          	ld	a5,-32(s0)
     fb8:	fdc42703          	lw	a4,-36(s0)
     fbc:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     fbe:	fe043783          	ld	a5,-32(s0)
     fc2:	07c1                	addi	a5,a5,16
     fc4:	853e                	mv	a0,a5
     fc6:	00000097          	auipc	ra,0x0
     fca:	e7a080e7          	jalr	-390(ra) # e40 <free>
  return freep;
     fce:	00001797          	auipc	a5,0x1
     fd2:	46278793          	addi	a5,a5,1122 # 2430 <freep>
     fd6:	639c                	ld	a5,0(a5)
}
     fd8:	853e                	mv	a0,a5
     fda:	70a2                	ld	ra,40(sp)
     fdc:	7402                	ld	s0,32(sp)
     fde:	6145                	addi	sp,sp,48
     fe0:	8082                	ret

0000000000000fe2 <malloc>:

void*
malloc(uint nbytes)
{
     fe2:	7139                	addi	sp,sp,-64
     fe4:	fc06                	sd	ra,56(sp)
     fe6:	f822                	sd	s0,48(sp)
     fe8:	0080                	addi	s0,sp,64
     fea:	87aa                	mv	a5,a0
     fec:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     ff0:	fcc46783          	lwu	a5,-52(s0)
     ff4:	07bd                	addi	a5,a5,15
     ff6:	8391                	srli	a5,a5,0x4
     ff8:	2781                	sext.w	a5,a5
     ffa:	2785                	addiw	a5,a5,1
     ffc:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1000:	00001797          	auipc	a5,0x1
    1004:	43078793          	addi	a5,a5,1072 # 2430 <freep>
    1008:	639c                	ld	a5,0(a5)
    100a:	fef43023          	sd	a5,-32(s0)
    100e:	fe043783          	ld	a5,-32(s0)
    1012:	ef95                	bnez	a5,104e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1014:	00001797          	auipc	a5,0x1
    1018:	40c78793          	addi	a5,a5,1036 # 2420 <base>
    101c:	fef43023          	sd	a5,-32(s0)
    1020:	00001797          	auipc	a5,0x1
    1024:	41078793          	addi	a5,a5,1040 # 2430 <freep>
    1028:	fe043703          	ld	a4,-32(s0)
    102c:	e398                	sd	a4,0(a5)
    102e:	00001797          	auipc	a5,0x1
    1032:	40278793          	addi	a5,a5,1026 # 2430 <freep>
    1036:	6398                	ld	a4,0(a5)
    1038:	00001797          	auipc	a5,0x1
    103c:	3e878793          	addi	a5,a5,1000 # 2420 <base>
    1040:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1042:	00001797          	auipc	a5,0x1
    1046:	3de78793          	addi	a5,a5,990 # 2420 <base>
    104a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    104e:	fe043783          	ld	a5,-32(s0)
    1052:	639c                	ld	a5,0(a5)
    1054:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1058:	fe843783          	ld	a5,-24(s0)
    105c:	4798                	lw	a4,8(a5)
    105e:	fdc42783          	lw	a5,-36(s0)
    1062:	2781                	sext.w	a5,a5
    1064:	06f76863          	bltu	a4,a5,10d4 <malloc+0xf2>
      if(p->s.size == nunits)
    1068:	fe843783          	ld	a5,-24(s0)
    106c:	4798                	lw	a4,8(a5)
    106e:	fdc42783          	lw	a5,-36(s0)
    1072:	2781                	sext.w	a5,a5
    1074:	00e79963          	bne	a5,a4,1086 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1078:	fe843783          	ld	a5,-24(s0)
    107c:	6398                	ld	a4,0(a5)
    107e:	fe043783          	ld	a5,-32(s0)
    1082:	e398                	sd	a4,0(a5)
    1084:	a82d                	j	10be <malloc+0xdc>
      else {
        p->s.size -= nunits;
    1086:	fe843783          	ld	a5,-24(s0)
    108a:	4798                	lw	a4,8(a5)
    108c:	fdc42783          	lw	a5,-36(s0)
    1090:	40f707bb          	subw	a5,a4,a5
    1094:	0007871b          	sext.w	a4,a5
    1098:	fe843783          	ld	a5,-24(s0)
    109c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    109e:	fe843783          	ld	a5,-24(s0)
    10a2:	479c                	lw	a5,8(a5)
    10a4:	1782                	slli	a5,a5,0x20
    10a6:	9381                	srli	a5,a5,0x20
    10a8:	0792                	slli	a5,a5,0x4
    10aa:	fe843703          	ld	a4,-24(s0)
    10ae:	97ba                	add	a5,a5,a4
    10b0:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    10b4:	fe843783          	ld	a5,-24(s0)
    10b8:	fdc42703          	lw	a4,-36(s0)
    10bc:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    10be:	00001797          	auipc	a5,0x1
    10c2:	37278793          	addi	a5,a5,882 # 2430 <freep>
    10c6:	fe043703          	ld	a4,-32(s0)
    10ca:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    10cc:	fe843783          	ld	a5,-24(s0)
    10d0:	07c1                	addi	a5,a5,16
    10d2:	a091                	j	1116 <malloc+0x134>
    }
    if(p == freep)
    10d4:	00001797          	auipc	a5,0x1
    10d8:	35c78793          	addi	a5,a5,860 # 2430 <freep>
    10dc:	639c                	ld	a5,0(a5)
    10de:	fe843703          	ld	a4,-24(s0)
    10e2:	02f71063          	bne	a4,a5,1102 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    10e6:	fdc42783          	lw	a5,-36(s0)
    10ea:	853e                	mv	a0,a5
    10ec:	00000097          	auipc	ra,0x0
    10f0:	e76080e7          	jalr	-394(ra) # f62 <morecore>
    10f4:	fea43423          	sd	a0,-24(s0)
    10f8:	fe843783          	ld	a5,-24(s0)
    10fc:	e399                	bnez	a5,1102 <malloc+0x120>
        return 0;
    10fe:	4781                	li	a5,0
    1100:	a819                	j	1116 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1102:	fe843783          	ld	a5,-24(s0)
    1106:	fef43023          	sd	a5,-32(s0)
    110a:	fe843783          	ld	a5,-24(s0)
    110e:	639c                	ld	a5,0(a5)
    1110:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1114:	b791                	j	1058 <malloc+0x76>
  }
}
    1116:	853e                	mv	a0,a5
    1118:	70e2                	ld	ra,56(sp)
    111a:	7442                	ld	s0,48(sp)
    111c:	6121                	addi	sp,sp,64
    111e:	8082                	ret
