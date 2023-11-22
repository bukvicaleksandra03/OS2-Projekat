
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	0080                	addi	s0,sp,64
       a:	fca43423          	sd	a0,-56(s0)
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       e:	fc843503          	ld	a0,-56(s0)
      12:	00000097          	auipc	ra,0x0
      16:	454080e7          	jalr	1108(ra) # 466 <strlen>
      1a:	87aa                	mv	a5,a0
      1c:	2781                	sext.w	a5,a5
      1e:	1782                	slli	a5,a5,0x20
      20:	9381                	srli	a5,a5,0x20
      22:	fc843703          	ld	a4,-56(s0)
      26:	97ba                	add	a5,a5,a4
      28:	fcf43c23          	sd	a5,-40(s0)
      2c:	a031                	j	38 <fmtname+0x38>
      2e:	fd843783          	ld	a5,-40(s0)
      32:	17fd                	addi	a5,a5,-1
      34:	fcf43c23          	sd	a5,-40(s0)
      38:	fd843703          	ld	a4,-40(s0)
      3c:	fc843783          	ld	a5,-56(s0)
      40:	00f76b63          	bltu	a4,a5,56 <fmtname+0x56>
      44:	fd843783          	ld	a5,-40(s0)
      48:	0007c783          	lbu	a5,0(a5)
      4c:	873e                	mv	a4,a5
      4e:	02f00793          	li	a5,47
      52:	fcf71ee3          	bne	a4,a5,2e <fmtname+0x2e>
    ;
  p++;
      56:	fd843783          	ld	a5,-40(s0)
      5a:	0785                	addi	a5,a5,1
      5c:	fcf43c23          	sd	a5,-40(s0)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      60:	fd843503          	ld	a0,-40(s0)
      64:	00000097          	auipc	ra,0x0
      68:	402080e7          	jalr	1026(ra) # 466 <strlen>
      6c:	87aa                	mv	a5,a0
      6e:	2781                	sext.w	a5,a5
      70:	873e                	mv	a4,a5
      72:	47b5                	li	a5,13
      74:	00e7f563          	bgeu	a5,a4,7e <fmtname+0x7e>
    return p;
      78:	fd843783          	ld	a5,-40(s0)
      7c:	a8b5                	j	f8 <fmtname+0xf8>
  memmove(buf, p, strlen(p));
      7e:	fd843503          	ld	a0,-40(s0)
      82:	00000097          	auipc	ra,0x0
      86:	3e4080e7          	jalr	996(ra) # 466 <strlen>
      8a:	87aa                	mv	a5,a0
      8c:	2781                	sext.w	a5,a5
      8e:	2781                	sext.w	a5,a5
      90:	863e                	mv	a2,a5
      92:	fd843583          	ld	a1,-40(s0)
      96:	00002517          	auipc	a0,0x2
      9a:	f8a50513          	addi	a0,a0,-118 # 2020 <buf.1106>
      9e:	00000097          	auipc	ra,0x0
      a2:	622080e7          	jalr	1570(ra) # 6c0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      a6:	fd843503          	ld	a0,-40(s0)
      aa:	00000097          	auipc	ra,0x0
      ae:	3bc080e7          	jalr	956(ra) # 466 <strlen>
      b2:	87aa                	mv	a5,a0
      b4:	2781                	sext.w	a5,a5
      b6:	02079713          	slli	a4,a5,0x20
      ba:	9301                	srli	a4,a4,0x20
      bc:	00002797          	auipc	a5,0x2
      c0:	f6478793          	addi	a5,a5,-156 # 2020 <buf.1106>
      c4:	00f704b3          	add	s1,a4,a5
      c8:	fd843503          	ld	a0,-40(s0)
      cc:	00000097          	auipc	ra,0x0
      d0:	39a080e7          	jalr	922(ra) # 466 <strlen>
      d4:	87aa                	mv	a5,a0
      d6:	2781                	sext.w	a5,a5
      d8:	4739                	li	a4,14
      da:	40f707bb          	subw	a5,a4,a5
      de:	2781                	sext.w	a5,a5
      e0:	863e                	mv	a2,a5
      e2:	02000593          	li	a1,32
      e6:	8526                	mv	a0,s1
      e8:	00000097          	auipc	ra,0x0
      ec:	3b4080e7          	jalr	948(ra) # 49c <memset>
  return buf;
      f0:	00002797          	auipc	a5,0x2
      f4:	f3078793          	addi	a5,a5,-208 # 2020 <buf.1106>
}
      f8:	853e                	mv	a0,a5
      fa:	70e2                	ld	ra,56(sp)
      fc:	7442                	ld	s0,48(sp)
      fe:	74a2                	ld	s1,40(sp)
     100:	6121                	addi	sp,sp,64
     102:	8082                	ret

0000000000000104 <ls>:

void
ls(char *path)
{
     104:	da010113          	addi	sp,sp,-608
     108:	24113c23          	sd	ra,600(sp)
     10c:	24813823          	sd	s0,592(sp)
     110:	1480                	addi	s0,sp,608
     112:	daa43423          	sd	a0,-600(s0)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
     116:	4581                	li	a1,0
     118:	da843503          	ld	a0,-600(s0)
     11c:	00000097          	auipc	ra,0x0
     120:	76a080e7          	jalr	1898(ra) # 886 <open>
     124:	87aa                	mv	a5,a0
     126:	fef42623          	sw	a5,-20(s0)
     12a:	fec42783          	lw	a5,-20(s0)
     12e:	2781                	sext.w	a5,a5
     130:	0007de63          	bgez	a5,14c <ls+0x48>
    fprintf(2, "ls: cannot open %s\n", path);
     134:	da843603          	ld	a2,-600(s0)
     138:	00001597          	auipc	a1,0x1
     13c:	f7858593          	addi	a1,a1,-136 # 10b0 <malloc+0x14a>
     140:	4509                	li	a0,2
     142:	00001097          	auipc	ra,0x1
     146:	bda080e7          	jalr	-1062(ra) # d1c <fprintf>
    return;
     14a:	a2d9                	j	310 <ls+0x20c>
  }

  if(fstat(fd, &st) < 0){
     14c:	db840713          	addi	a4,s0,-584
     150:	fec42783          	lw	a5,-20(s0)
     154:	85ba                	mv	a1,a4
     156:	853e                	mv	a0,a5
     158:	00000097          	auipc	ra,0x0
     15c:	746080e7          	jalr	1862(ra) # 89e <fstat>
     160:	87aa                	mv	a5,a0
     162:	0207d563          	bgez	a5,18c <ls+0x88>
    fprintf(2, "ls: cannot stat %s\n", path);
     166:	da843603          	ld	a2,-600(s0)
     16a:	00001597          	auipc	a1,0x1
     16e:	f5e58593          	addi	a1,a1,-162 # 10c8 <malloc+0x162>
     172:	4509                	li	a0,2
     174:	00001097          	auipc	ra,0x1
     178:	ba8080e7          	jalr	-1112(ra) # d1c <fprintf>
    close(fd);
     17c:	fec42783          	lw	a5,-20(s0)
     180:	853e                	mv	a0,a5
     182:	00000097          	auipc	ra,0x0
     186:	6ec080e7          	jalr	1772(ra) # 86e <close>
    return;
     18a:	a259                	j	310 <ls+0x20c>
  }

  switch(st.type){
     18c:	dc041783          	lh	a5,-576(s0)
     190:	2781                	sext.w	a5,a5
     192:	86be                	mv	a3,a5
     194:	4705                	li	a4,1
     196:	04e68463          	beq	a3,a4,1de <ls+0xda>
     19a:	873e                	mv	a4,a5
     19c:	16e05363          	blez	a4,302 <ls+0x1fe>
     1a0:	2781                	sext.w	a5,a5
     1a2:	37f9                	addiw	a5,a5,-2
     1a4:	2781                	sext.w	a5,a5
     1a6:	873e                	mv	a4,a5
     1a8:	4785                	li	a5,1
     1aa:	14e7ec63          	bltu	a5,a4,302 <ls+0x1fe>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
     1ae:	da843503          	ld	a0,-600(s0)
     1b2:	00000097          	auipc	ra,0x0
     1b6:	e4e080e7          	jalr	-434(ra) # 0 <fmtname>
     1ba:	85aa                	mv	a1,a0
     1bc:	dc041783          	lh	a5,-576(s0)
     1c0:	2781                	sext.w	a5,a5
     1c2:	dbc42683          	lw	a3,-580(s0)
     1c6:	dc843703          	ld	a4,-568(s0)
     1ca:	863e                	mv	a2,a5
     1cc:	00001517          	auipc	a0,0x1
     1d0:	f1450513          	addi	a0,a0,-236 # 10e0 <malloc+0x17a>
     1d4:	00001097          	auipc	ra,0x1
     1d8:	ba0080e7          	jalr	-1120(ra) # d74 <printf>
    break;
     1dc:	a21d                	j	302 <ls+0x1fe>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1de:	da843503          	ld	a0,-600(s0)
     1e2:	00000097          	auipc	ra,0x0
     1e6:	284080e7          	jalr	644(ra) # 466 <strlen>
     1ea:	87aa                	mv	a5,a0
     1ec:	2781                	sext.w	a5,a5
     1ee:	27c1                	addiw	a5,a5,16
     1f0:	2781                	sext.w	a5,a5
     1f2:	873e                	mv	a4,a5
     1f4:	20000793          	li	a5,512
     1f8:	00e7fb63          	bgeu	a5,a4,20e <ls+0x10a>
      printf("ls: path too long\n");
     1fc:	00001517          	auipc	a0,0x1
     200:	ef450513          	addi	a0,a0,-268 # 10f0 <malloc+0x18a>
     204:	00001097          	auipc	ra,0x1
     208:	b70080e7          	jalr	-1168(ra) # d74 <printf>
      break;
     20c:	a8dd                	j	302 <ls+0x1fe>
    }
    strcpy(buf, path);
     20e:	de040793          	addi	a5,s0,-544
     212:	da843583          	ld	a1,-600(s0)
     216:	853e                	mv	a0,a5
     218:	00000097          	auipc	ra,0x0
     21c:	19e080e7          	jalr	414(ra) # 3b6 <strcpy>
    p = buf+strlen(buf);
     220:	de040793          	addi	a5,s0,-544
     224:	853e                	mv	a0,a5
     226:	00000097          	auipc	ra,0x0
     22a:	240080e7          	jalr	576(ra) # 466 <strlen>
     22e:	87aa                	mv	a5,a0
     230:	2781                	sext.w	a5,a5
     232:	1782                	slli	a5,a5,0x20
     234:	9381                	srli	a5,a5,0x20
     236:	de040713          	addi	a4,s0,-544
     23a:	97ba                	add	a5,a5,a4
     23c:	fef43023          	sd	a5,-32(s0)
    *p++ = '/';
     240:	fe043783          	ld	a5,-32(s0)
     244:	00178713          	addi	a4,a5,1
     248:	fee43023          	sd	a4,-32(s0)
     24c:	02f00713          	li	a4,47
     250:	00e78023          	sb	a4,0(a5)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     254:	a071                	j	2e0 <ls+0x1dc>
      if(de.inum == 0)
     256:	dd045783          	lhu	a5,-560(s0)
     25a:	e391                	bnez	a5,25e <ls+0x15a>
        continue;
     25c:	a051                	j	2e0 <ls+0x1dc>
      memmove(p, de.name, DIRSIZ);
     25e:	dd040793          	addi	a5,s0,-560
     262:	0789                	addi	a5,a5,2
     264:	4639                	li	a2,14
     266:	85be                	mv	a1,a5
     268:	fe043503          	ld	a0,-32(s0)
     26c:	00000097          	auipc	ra,0x0
     270:	454080e7          	jalr	1108(ra) # 6c0 <memmove>
      p[DIRSIZ] = 0;
     274:	fe043783          	ld	a5,-32(s0)
     278:	07b9                	addi	a5,a5,14
     27a:	00078023          	sb	zero,0(a5)
      if(stat(buf, &st) < 0){
     27e:	db840713          	addi	a4,s0,-584
     282:	de040793          	addi	a5,s0,-544
     286:	85ba                	mv	a1,a4
     288:	853e                	mv	a0,a5
     28a:	00000097          	auipc	ra,0x0
     28e:	35e080e7          	jalr	862(ra) # 5e8 <stat>
     292:	87aa                	mv	a5,a0
     294:	0007de63          	bgez	a5,2b0 <ls+0x1ac>
        printf("ls: cannot stat %s\n", buf);
     298:	de040793          	addi	a5,s0,-544
     29c:	85be                	mv	a1,a5
     29e:	00001517          	auipc	a0,0x1
     2a2:	e2a50513          	addi	a0,a0,-470 # 10c8 <malloc+0x162>
     2a6:	00001097          	auipc	ra,0x1
     2aa:	ace080e7          	jalr	-1330(ra) # d74 <printf>
        continue;
     2ae:	a80d                	j	2e0 <ls+0x1dc>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     2b0:	de040793          	addi	a5,s0,-544
     2b4:	853e                	mv	a0,a5
     2b6:	00000097          	auipc	ra,0x0
     2ba:	d4a080e7          	jalr	-694(ra) # 0 <fmtname>
     2be:	85aa                	mv	a1,a0
     2c0:	dc041783          	lh	a5,-576(s0)
     2c4:	2781                	sext.w	a5,a5
     2c6:	dbc42683          	lw	a3,-580(s0)
     2ca:	dc843703          	ld	a4,-568(s0)
     2ce:	863e                	mv	a2,a5
     2d0:	00001517          	auipc	a0,0x1
     2d4:	e3850513          	addi	a0,a0,-456 # 1108 <malloc+0x1a2>
     2d8:	00001097          	auipc	ra,0x1
     2dc:	a9c080e7          	jalr	-1380(ra) # d74 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2e0:	dd040713          	addi	a4,s0,-560
     2e4:	fec42783          	lw	a5,-20(s0)
     2e8:	4641                	li	a2,16
     2ea:	85ba                	mv	a1,a4
     2ec:	853e                	mv	a0,a5
     2ee:	00000097          	auipc	ra,0x0
     2f2:	570080e7          	jalr	1392(ra) # 85e <read>
     2f6:	87aa                	mv	a5,a0
     2f8:	873e                	mv	a4,a5
     2fa:	47c1                	li	a5,16
     2fc:	f4f70de3          	beq	a4,a5,256 <ls+0x152>
    }
    break;
     300:	0001                	nop
  }
  close(fd);
     302:	fec42783          	lw	a5,-20(s0)
     306:	853e                	mv	a0,a5
     308:	00000097          	auipc	ra,0x0
     30c:	566080e7          	jalr	1382(ra) # 86e <close>
}
     310:	25813083          	ld	ra,600(sp)
     314:	25013403          	ld	s0,592(sp)
     318:	26010113          	addi	sp,sp,608
     31c:	8082                	ret

000000000000031e <main>:

int
main(int argc, char *argv[])
{
     31e:	7179                	addi	sp,sp,-48
     320:	f406                	sd	ra,40(sp)
     322:	f022                	sd	s0,32(sp)
     324:	1800                	addi	s0,sp,48
     326:	87aa                	mv	a5,a0
     328:	fcb43823          	sd	a1,-48(s0)
     32c:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
     330:	fdc42783          	lw	a5,-36(s0)
     334:	0007871b          	sext.w	a4,a5
     338:	4785                	li	a5,1
     33a:	00e7cf63          	blt	a5,a4,358 <main+0x3a>
    ls(".");
     33e:	00001517          	auipc	a0,0x1
     342:	dda50513          	addi	a0,a0,-550 # 1118 <malloc+0x1b2>
     346:	00000097          	auipc	ra,0x0
     34a:	dbe080e7          	jalr	-578(ra) # 104 <ls>
    exit(0);
     34e:	4501                	li	a0,0
     350:	00000097          	auipc	ra,0x0
     354:	4f6080e7          	jalr	1270(ra) # 846 <exit>
  }
  for(i=1; i<argc; i++)
     358:	4785                	li	a5,1
     35a:	fef42623          	sw	a5,-20(s0)
     35e:	a015                	j	382 <main+0x64>
    ls(argv[i]);
     360:	fec42783          	lw	a5,-20(s0)
     364:	078e                	slli	a5,a5,0x3
     366:	fd043703          	ld	a4,-48(s0)
     36a:	97ba                	add	a5,a5,a4
     36c:	639c                	ld	a5,0(a5)
     36e:	853e                	mv	a0,a5
     370:	00000097          	auipc	ra,0x0
     374:	d94080e7          	jalr	-620(ra) # 104 <ls>
  for(i=1; i<argc; i++)
     378:	fec42783          	lw	a5,-20(s0)
     37c:	2785                	addiw	a5,a5,1
     37e:	fef42623          	sw	a5,-20(s0)
     382:	fec42703          	lw	a4,-20(s0)
     386:	fdc42783          	lw	a5,-36(s0)
     38a:	2701                	sext.w	a4,a4
     38c:	2781                	sext.w	a5,a5
     38e:	fcf749e3          	blt	a4,a5,360 <main+0x42>
  exit(0);
     392:	4501                	li	a0,0
     394:	00000097          	auipc	ra,0x0
     398:	4b2080e7          	jalr	1202(ra) # 846 <exit>

000000000000039c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     39c:	1141                	addi	sp,sp,-16
     39e:	e406                	sd	ra,8(sp)
     3a0:	e022                	sd	s0,0(sp)
     3a2:	0800                	addi	s0,sp,16
  extern int main();
  main();
     3a4:	00000097          	auipc	ra,0x0
     3a8:	f7a080e7          	jalr	-134(ra) # 31e <main>
  exit(0);
     3ac:	4501                	li	a0,0
     3ae:	00000097          	auipc	ra,0x0
     3b2:	498080e7          	jalr	1176(ra) # 846 <exit>

00000000000003b6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     3b6:	7179                	addi	sp,sp,-48
     3b8:	f422                	sd	s0,40(sp)
     3ba:	1800                	addi	s0,sp,48
     3bc:	fca43c23          	sd	a0,-40(s0)
     3c0:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     3c4:	fd843783          	ld	a5,-40(s0)
     3c8:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     3cc:	0001                	nop
     3ce:	fd043703          	ld	a4,-48(s0)
     3d2:	00170793          	addi	a5,a4,1
     3d6:	fcf43823          	sd	a5,-48(s0)
     3da:	fd843783          	ld	a5,-40(s0)
     3de:	00178693          	addi	a3,a5,1
     3e2:	fcd43c23          	sd	a3,-40(s0)
     3e6:	00074703          	lbu	a4,0(a4)
     3ea:	00e78023          	sb	a4,0(a5)
     3ee:	0007c783          	lbu	a5,0(a5)
     3f2:	fff1                	bnez	a5,3ce <strcpy+0x18>
    ;
  return os;
     3f4:	fe843783          	ld	a5,-24(s0)
}
     3f8:	853e                	mv	a0,a5
     3fa:	7422                	ld	s0,40(sp)
     3fc:	6145                	addi	sp,sp,48
     3fe:	8082                	ret

0000000000000400 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     400:	1101                	addi	sp,sp,-32
     402:	ec22                	sd	s0,24(sp)
     404:	1000                	addi	s0,sp,32
     406:	fea43423          	sd	a0,-24(s0)
     40a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     40e:	a819                	j	424 <strcmp+0x24>
    p++, q++;
     410:	fe843783          	ld	a5,-24(s0)
     414:	0785                	addi	a5,a5,1
     416:	fef43423          	sd	a5,-24(s0)
     41a:	fe043783          	ld	a5,-32(s0)
     41e:	0785                	addi	a5,a5,1
     420:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     424:	fe843783          	ld	a5,-24(s0)
     428:	0007c783          	lbu	a5,0(a5)
     42c:	cb99                	beqz	a5,442 <strcmp+0x42>
     42e:	fe843783          	ld	a5,-24(s0)
     432:	0007c703          	lbu	a4,0(a5)
     436:	fe043783          	ld	a5,-32(s0)
     43a:	0007c783          	lbu	a5,0(a5)
     43e:	fcf709e3          	beq	a4,a5,410 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     442:	fe843783          	ld	a5,-24(s0)
     446:	0007c783          	lbu	a5,0(a5)
     44a:	0007871b          	sext.w	a4,a5
     44e:	fe043783          	ld	a5,-32(s0)
     452:	0007c783          	lbu	a5,0(a5)
     456:	2781                	sext.w	a5,a5
     458:	40f707bb          	subw	a5,a4,a5
     45c:	2781                	sext.w	a5,a5
}
     45e:	853e                	mv	a0,a5
     460:	6462                	ld	s0,24(sp)
     462:	6105                	addi	sp,sp,32
     464:	8082                	ret

0000000000000466 <strlen>:

uint
strlen(const char *s)
{
     466:	7179                	addi	sp,sp,-48
     468:	f422                	sd	s0,40(sp)
     46a:	1800                	addi	s0,sp,48
     46c:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     470:	fe042623          	sw	zero,-20(s0)
     474:	a031                	j	480 <strlen+0x1a>
     476:	fec42783          	lw	a5,-20(s0)
     47a:	2785                	addiw	a5,a5,1
     47c:	fef42623          	sw	a5,-20(s0)
     480:	fec42783          	lw	a5,-20(s0)
     484:	fd843703          	ld	a4,-40(s0)
     488:	97ba                	add	a5,a5,a4
     48a:	0007c783          	lbu	a5,0(a5)
     48e:	f7e5                	bnez	a5,476 <strlen+0x10>
    ;
  return n;
     490:	fec42783          	lw	a5,-20(s0)
}
     494:	853e                	mv	a0,a5
     496:	7422                	ld	s0,40(sp)
     498:	6145                	addi	sp,sp,48
     49a:	8082                	ret

000000000000049c <memset>:

void*
memset(void *dst, int c, uint n)
{
     49c:	7179                	addi	sp,sp,-48
     49e:	f422                	sd	s0,40(sp)
     4a0:	1800                	addi	s0,sp,48
     4a2:	fca43c23          	sd	a0,-40(s0)
     4a6:	87ae                	mv	a5,a1
     4a8:	8732                	mv	a4,a2
     4aa:	fcf42a23          	sw	a5,-44(s0)
     4ae:	87ba                	mv	a5,a4
     4b0:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     4b4:	fd843783          	ld	a5,-40(s0)
     4b8:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     4bc:	fe042623          	sw	zero,-20(s0)
     4c0:	a00d                	j	4e2 <memset+0x46>
    cdst[i] = c;
     4c2:	fec42783          	lw	a5,-20(s0)
     4c6:	fe043703          	ld	a4,-32(s0)
     4ca:	97ba                	add	a5,a5,a4
     4cc:	fd442703          	lw	a4,-44(s0)
     4d0:	0ff77713          	andi	a4,a4,255
     4d4:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     4d8:	fec42783          	lw	a5,-20(s0)
     4dc:	2785                	addiw	a5,a5,1
     4de:	fef42623          	sw	a5,-20(s0)
     4e2:	fec42703          	lw	a4,-20(s0)
     4e6:	fd042783          	lw	a5,-48(s0)
     4ea:	2781                	sext.w	a5,a5
     4ec:	fcf76be3          	bltu	a4,a5,4c2 <memset+0x26>
  }
  return dst;
     4f0:	fd843783          	ld	a5,-40(s0)
}
     4f4:	853e                	mv	a0,a5
     4f6:	7422                	ld	s0,40(sp)
     4f8:	6145                	addi	sp,sp,48
     4fa:	8082                	ret

00000000000004fc <strchr>:

char*
strchr(const char *s, char c)
{
     4fc:	1101                	addi	sp,sp,-32
     4fe:	ec22                	sd	s0,24(sp)
     500:	1000                	addi	s0,sp,32
     502:	fea43423          	sd	a0,-24(s0)
     506:	87ae                	mv	a5,a1
     508:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     50c:	a01d                	j	532 <strchr+0x36>
    if(*s == c)
     50e:	fe843783          	ld	a5,-24(s0)
     512:	0007c703          	lbu	a4,0(a5)
     516:	fe744783          	lbu	a5,-25(s0)
     51a:	0ff7f793          	andi	a5,a5,255
     51e:	00e79563          	bne	a5,a4,528 <strchr+0x2c>
      return (char*)s;
     522:	fe843783          	ld	a5,-24(s0)
     526:	a821                	j	53e <strchr+0x42>
  for(; *s; s++)
     528:	fe843783          	ld	a5,-24(s0)
     52c:	0785                	addi	a5,a5,1
     52e:	fef43423          	sd	a5,-24(s0)
     532:	fe843783          	ld	a5,-24(s0)
     536:	0007c783          	lbu	a5,0(a5)
     53a:	fbf1                	bnez	a5,50e <strchr+0x12>
  return 0;
     53c:	4781                	li	a5,0
}
     53e:	853e                	mv	a0,a5
     540:	6462                	ld	s0,24(sp)
     542:	6105                	addi	sp,sp,32
     544:	8082                	ret

0000000000000546 <gets>:

char*
gets(char *buf, int max)
{
     546:	7179                	addi	sp,sp,-48
     548:	f406                	sd	ra,40(sp)
     54a:	f022                	sd	s0,32(sp)
     54c:	1800                	addi	s0,sp,48
     54e:	fca43c23          	sd	a0,-40(s0)
     552:	87ae                	mv	a5,a1
     554:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     558:	fe042623          	sw	zero,-20(s0)
     55c:	a8a1                	j	5b4 <gets+0x6e>
    cc = read(0, &c, 1);
     55e:	fe740793          	addi	a5,s0,-25
     562:	4605                	li	a2,1
     564:	85be                	mv	a1,a5
     566:	4501                	li	a0,0
     568:	00000097          	auipc	ra,0x0
     56c:	2f6080e7          	jalr	758(ra) # 85e <read>
     570:	87aa                	mv	a5,a0
     572:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     576:	fe842783          	lw	a5,-24(s0)
     57a:	2781                	sext.w	a5,a5
     57c:	04f05763          	blez	a5,5ca <gets+0x84>
      break;
    buf[i++] = c;
     580:	fec42783          	lw	a5,-20(s0)
     584:	0017871b          	addiw	a4,a5,1
     588:	fee42623          	sw	a4,-20(s0)
     58c:	873e                	mv	a4,a5
     58e:	fd843783          	ld	a5,-40(s0)
     592:	97ba                	add	a5,a5,a4
     594:	fe744703          	lbu	a4,-25(s0)
     598:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     59c:	fe744783          	lbu	a5,-25(s0)
     5a0:	873e                	mv	a4,a5
     5a2:	47a9                	li	a5,10
     5a4:	02f70463          	beq	a4,a5,5cc <gets+0x86>
     5a8:	fe744783          	lbu	a5,-25(s0)
     5ac:	873e                	mv	a4,a5
     5ae:	47b5                	li	a5,13
     5b0:	00f70e63          	beq	a4,a5,5cc <gets+0x86>
  for(i=0; i+1 < max; ){
     5b4:	fec42783          	lw	a5,-20(s0)
     5b8:	2785                	addiw	a5,a5,1
     5ba:	0007871b          	sext.w	a4,a5
     5be:	fd442783          	lw	a5,-44(s0)
     5c2:	2781                	sext.w	a5,a5
     5c4:	f8f74de3          	blt	a4,a5,55e <gets+0x18>
     5c8:	a011                	j	5cc <gets+0x86>
      break;
     5ca:	0001                	nop
      break;
  }
  buf[i] = '\0';
     5cc:	fec42783          	lw	a5,-20(s0)
     5d0:	fd843703          	ld	a4,-40(s0)
     5d4:	97ba                	add	a5,a5,a4
     5d6:	00078023          	sb	zero,0(a5)
  return buf;
     5da:	fd843783          	ld	a5,-40(s0)
}
     5de:	853e                	mv	a0,a5
     5e0:	70a2                	ld	ra,40(sp)
     5e2:	7402                	ld	s0,32(sp)
     5e4:	6145                	addi	sp,sp,48
     5e6:	8082                	ret

00000000000005e8 <stat>:

int
stat(const char *n, struct stat *st)
{
     5e8:	7179                	addi	sp,sp,-48
     5ea:	f406                	sd	ra,40(sp)
     5ec:	f022                	sd	s0,32(sp)
     5ee:	1800                	addi	s0,sp,48
     5f0:	fca43c23          	sd	a0,-40(s0)
     5f4:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     5f8:	4581                	li	a1,0
     5fa:	fd843503          	ld	a0,-40(s0)
     5fe:	00000097          	auipc	ra,0x0
     602:	288080e7          	jalr	648(ra) # 886 <open>
     606:	87aa                	mv	a5,a0
     608:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     60c:	fec42783          	lw	a5,-20(s0)
     610:	2781                	sext.w	a5,a5
     612:	0007d463          	bgez	a5,61a <stat+0x32>
    return -1;
     616:	57fd                	li	a5,-1
     618:	a035                	j	644 <stat+0x5c>
  r = fstat(fd, st);
     61a:	fec42783          	lw	a5,-20(s0)
     61e:	fd043583          	ld	a1,-48(s0)
     622:	853e                	mv	a0,a5
     624:	00000097          	auipc	ra,0x0
     628:	27a080e7          	jalr	634(ra) # 89e <fstat>
     62c:	87aa                	mv	a5,a0
     62e:	fef42423          	sw	a5,-24(s0)
  close(fd);
     632:	fec42783          	lw	a5,-20(s0)
     636:	853e                	mv	a0,a5
     638:	00000097          	auipc	ra,0x0
     63c:	236080e7          	jalr	566(ra) # 86e <close>
  return r;
     640:	fe842783          	lw	a5,-24(s0)
}
     644:	853e                	mv	a0,a5
     646:	70a2                	ld	ra,40(sp)
     648:	7402                	ld	s0,32(sp)
     64a:	6145                	addi	sp,sp,48
     64c:	8082                	ret

000000000000064e <atoi>:

int
atoi(const char *s)
{
     64e:	7179                	addi	sp,sp,-48
     650:	f422                	sd	s0,40(sp)
     652:	1800                	addi	s0,sp,48
     654:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     658:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     65c:	a815                	j	690 <atoi+0x42>
    n = n*10 + *s++ - '0';
     65e:	fec42703          	lw	a4,-20(s0)
     662:	87ba                	mv	a5,a4
     664:	0027979b          	slliw	a5,a5,0x2
     668:	9fb9                	addw	a5,a5,a4
     66a:	0017979b          	slliw	a5,a5,0x1
     66e:	0007871b          	sext.w	a4,a5
     672:	fd843783          	ld	a5,-40(s0)
     676:	00178693          	addi	a3,a5,1
     67a:	fcd43c23          	sd	a3,-40(s0)
     67e:	0007c783          	lbu	a5,0(a5)
     682:	2781                	sext.w	a5,a5
     684:	9fb9                	addw	a5,a5,a4
     686:	2781                	sext.w	a5,a5
     688:	fd07879b          	addiw	a5,a5,-48
     68c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     690:	fd843783          	ld	a5,-40(s0)
     694:	0007c783          	lbu	a5,0(a5)
     698:	873e                	mv	a4,a5
     69a:	02f00793          	li	a5,47
     69e:	00e7fb63          	bgeu	a5,a4,6b4 <atoi+0x66>
     6a2:	fd843783          	ld	a5,-40(s0)
     6a6:	0007c783          	lbu	a5,0(a5)
     6aa:	873e                	mv	a4,a5
     6ac:	03900793          	li	a5,57
     6b0:	fae7f7e3          	bgeu	a5,a4,65e <atoi+0x10>
  return n;
     6b4:	fec42783          	lw	a5,-20(s0)
}
     6b8:	853e                	mv	a0,a5
     6ba:	7422                	ld	s0,40(sp)
     6bc:	6145                	addi	sp,sp,48
     6be:	8082                	ret

00000000000006c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     6c0:	7139                	addi	sp,sp,-64
     6c2:	fc22                	sd	s0,56(sp)
     6c4:	0080                	addi	s0,sp,64
     6c6:	fca43c23          	sd	a0,-40(s0)
     6ca:	fcb43823          	sd	a1,-48(s0)
     6ce:	87b2                	mv	a5,a2
     6d0:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     6d4:	fd843783          	ld	a5,-40(s0)
     6d8:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     6dc:	fd043783          	ld	a5,-48(s0)
     6e0:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     6e4:	fe043703          	ld	a4,-32(s0)
     6e8:	fe843783          	ld	a5,-24(s0)
     6ec:	02e7fc63          	bgeu	a5,a4,724 <memmove+0x64>
    while(n-- > 0)
     6f0:	a00d                	j	712 <memmove+0x52>
      *dst++ = *src++;
     6f2:	fe043703          	ld	a4,-32(s0)
     6f6:	00170793          	addi	a5,a4,1
     6fa:	fef43023          	sd	a5,-32(s0)
     6fe:	fe843783          	ld	a5,-24(s0)
     702:	00178693          	addi	a3,a5,1
     706:	fed43423          	sd	a3,-24(s0)
     70a:	00074703          	lbu	a4,0(a4)
     70e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     712:	fcc42783          	lw	a5,-52(s0)
     716:	fff7871b          	addiw	a4,a5,-1
     71a:	fce42623          	sw	a4,-52(s0)
     71e:	fcf04ae3          	bgtz	a5,6f2 <memmove+0x32>
     722:	a891                	j	776 <memmove+0xb6>
  } else {
    dst += n;
     724:	fcc42783          	lw	a5,-52(s0)
     728:	fe843703          	ld	a4,-24(s0)
     72c:	97ba                	add	a5,a5,a4
     72e:	fef43423          	sd	a5,-24(s0)
    src += n;
     732:	fcc42783          	lw	a5,-52(s0)
     736:	fe043703          	ld	a4,-32(s0)
     73a:	97ba                	add	a5,a5,a4
     73c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     740:	a01d                	j	766 <memmove+0xa6>
      *--dst = *--src;
     742:	fe043783          	ld	a5,-32(s0)
     746:	17fd                	addi	a5,a5,-1
     748:	fef43023          	sd	a5,-32(s0)
     74c:	fe843783          	ld	a5,-24(s0)
     750:	17fd                	addi	a5,a5,-1
     752:	fef43423          	sd	a5,-24(s0)
     756:	fe043783          	ld	a5,-32(s0)
     75a:	0007c703          	lbu	a4,0(a5)
     75e:	fe843783          	ld	a5,-24(s0)
     762:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     766:	fcc42783          	lw	a5,-52(s0)
     76a:	fff7871b          	addiw	a4,a5,-1
     76e:	fce42623          	sw	a4,-52(s0)
     772:	fcf048e3          	bgtz	a5,742 <memmove+0x82>
  }
  return vdst;
     776:	fd843783          	ld	a5,-40(s0)
}
     77a:	853e                	mv	a0,a5
     77c:	7462                	ld	s0,56(sp)
     77e:	6121                	addi	sp,sp,64
     780:	8082                	ret

0000000000000782 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     782:	7139                	addi	sp,sp,-64
     784:	fc22                	sd	s0,56(sp)
     786:	0080                	addi	s0,sp,64
     788:	fca43c23          	sd	a0,-40(s0)
     78c:	fcb43823          	sd	a1,-48(s0)
     790:	87b2                	mv	a5,a2
     792:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     796:	fd843783          	ld	a5,-40(s0)
     79a:	fef43423          	sd	a5,-24(s0)
     79e:	fd043783          	ld	a5,-48(s0)
     7a2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7a6:	a0a1                	j	7ee <memcmp+0x6c>
    if (*p1 != *p2) {
     7a8:	fe843783          	ld	a5,-24(s0)
     7ac:	0007c703          	lbu	a4,0(a5)
     7b0:	fe043783          	ld	a5,-32(s0)
     7b4:	0007c783          	lbu	a5,0(a5)
     7b8:	02f70163          	beq	a4,a5,7da <memcmp+0x58>
      return *p1 - *p2;
     7bc:	fe843783          	ld	a5,-24(s0)
     7c0:	0007c783          	lbu	a5,0(a5)
     7c4:	0007871b          	sext.w	a4,a5
     7c8:	fe043783          	ld	a5,-32(s0)
     7cc:	0007c783          	lbu	a5,0(a5)
     7d0:	2781                	sext.w	a5,a5
     7d2:	40f707bb          	subw	a5,a4,a5
     7d6:	2781                	sext.w	a5,a5
     7d8:	a01d                	j	7fe <memcmp+0x7c>
    }
    p1++;
     7da:	fe843783          	ld	a5,-24(s0)
     7de:	0785                	addi	a5,a5,1
     7e0:	fef43423          	sd	a5,-24(s0)
    p2++;
     7e4:	fe043783          	ld	a5,-32(s0)
     7e8:	0785                	addi	a5,a5,1
     7ea:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7ee:	fcc42783          	lw	a5,-52(s0)
     7f2:	fff7871b          	addiw	a4,a5,-1
     7f6:	fce42623          	sw	a4,-52(s0)
     7fa:	f7dd                	bnez	a5,7a8 <memcmp+0x26>
  }
  return 0;
     7fc:	4781                	li	a5,0
}
     7fe:	853e                	mv	a0,a5
     800:	7462                	ld	s0,56(sp)
     802:	6121                	addi	sp,sp,64
     804:	8082                	ret

0000000000000806 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     806:	7179                	addi	sp,sp,-48
     808:	f406                	sd	ra,40(sp)
     80a:	f022                	sd	s0,32(sp)
     80c:	1800                	addi	s0,sp,48
     80e:	fea43423          	sd	a0,-24(s0)
     812:	feb43023          	sd	a1,-32(s0)
     816:	87b2                	mv	a5,a2
     818:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     81c:	fdc42783          	lw	a5,-36(s0)
     820:	863e                	mv	a2,a5
     822:	fe043583          	ld	a1,-32(s0)
     826:	fe843503          	ld	a0,-24(s0)
     82a:	00000097          	auipc	ra,0x0
     82e:	e96080e7          	jalr	-362(ra) # 6c0 <memmove>
     832:	87aa                	mv	a5,a0
}
     834:	853e                	mv	a0,a5
     836:	70a2                	ld	ra,40(sp)
     838:	7402                	ld	s0,32(sp)
     83a:	6145                	addi	sp,sp,48
     83c:	8082                	ret

000000000000083e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     83e:	4885                	li	a7,1
 ecall
     840:	00000073          	ecall
 ret
     844:	8082                	ret

0000000000000846 <exit>:
.global exit
exit:
 li a7, SYS_exit
     846:	4889                	li	a7,2
 ecall
     848:	00000073          	ecall
 ret
     84c:	8082                	ret

000000000000084e <wait>:
.global wait
wait:
 li a7, SYS_wait
     84e:	488d                	li	a7,3
 ecall
     850:	00000073          	ecall
 ret
     854:	8082                	ret

0000000000000856 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     856:	4891                	li	a7,4
 ecall
     858:	00000073          	ecall
 ret
     85c:	8082                	ret

000000000000085e <read>:
.global read
read:
 li a7, SYS_read
     85e:	4895                	li	a7,5
 ecall
     860:	00000073          	ecall
 ret
     864:	8082                	ret

0000000000000866 <write>:
.global write
write:
 li a7, SYS_write
     866:	48c1                	li	a7,16
 ecall
     868:	00000073          	ecall
 ret
     86c:	8082                	ret

000000000000086e <close>:
.global close
close:
 li a7, SYS_close
     86e:	48d5                	li	a7,21
 ecall
     870:	00000073          	ecall
 ret
     874:	8082                	ret

0000000000000876 <kill>:
.global kill
kill:
 li a7, SYS_kill
     876:	4899                	li	a7,6
 ecall
     878:	00000073          	ecall
 ret
     87c:	8082                	ret

000000000000087e <exec>:
.global exec
exec:
 li a7, SYS_exec
     87e:	489d                	li	a7,7
 ecall
     880:	00000073          	ecall
 ret
     884:	8082                	ret

0000000000000886 <open>:
.global open
open:
 li a7, SYS_open
     886:	48bd                	li	a7,15
 ecall
     888:	00000073          	ecall
 ret
     88c:	8082                	ret

000000000000088e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     88e:	48c5                	li	a7,17
 ecall
     890:	00000073          	ecall
 ret
     894:	8082                	ret

0000000000000896 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     896:	48c9                	li	a7,18
 ecall
     898:	00000073          	ecall
 ret
     89c:	8082                	ret

000000000000089e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     89e:	48a1                	li	a7,8
 ecall
     8a0:	00000073          	ecall
 ret
     8a4:	8082                	ret

00000000000008a6 <link>:
.global link
link:
 li a7, SYS_link
     8a6:	48cd                	li	a7,19
 ecall
     8a8:	00000073          	ecall
 ret
     8ac:	8082                	ret

00000000000008ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     8ae:	48d1                	li	a7,20
 ecall
     8b0:	00000073          	ecall
 ret
     8b4:	8082                	ret

00000000000008b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     8b6:	48a5                	li	a7,9
 ecall
     8b8:	00000073          	ecall
 ret
     8bc:	8082                	ret

00000000000008be <dup>:
.global dup
dup:
 li a7, SYS_dup
     8be:	48a9                	li	a7,10
 ecall
     8c0:	00000073          	ecall
 ret
     8c4:	8082                	ret

00000000000008c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     8c6:	48ad                	li	a7,11
 ecall
     8c8:	00000073          	ecall
 ret
     8cc:	8082                	ret

00000000000008ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     8ce:	48b1                	li	a7,12
 ecall
     8d0:	00000073          	ecall
 ret
     8d4:	8082                	ret

00000000000008d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     8d6:	48b5                	li	a7,13
 ecall
     8d8:	00000073          	ecall
 ret
     8dc:	8082                	ret

00000000000008de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     8de:	48b9                	li	a7,14
 ecall
     8e0:	00000073          	ecall
 ret
     8e4:	8082                	ret

00000000000008e6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     8e6:	1101                	addi	sp,sp,-32
     8e8:	ec06                	sd	ra,24(sp)
     8ea:	e822                	sd	s0,16(sp)
     8ec:	1000                	addi	s0,sp,32
     8ee:	87aa                	mv	a5,a0
     8f0:	872e                	mv	a4,a1
     8f2:	fef42623          	sw	a5,-20(s0)
     8f6:	87ba                	mv	a5,a4
     8f8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     8fc:	feb40713          	addi	a4,s0,-21
     900:	fec42783          	lw	a5,-20(s0)
     904:	4605                	li	a2,1
     906:	85ba                	mv	a1,a4
     908:	853e                	mv	a0,a5
     90a:	00000097          	auipc	ra,0x0
     90e:	f5c080e7          	jalr	-164(ra) # 866 <write>
}
     912:	0001                	nop
     914:	60e2                	ld	ra,24(sp)
     916:	6442                	ld	s0,16(sp)
     918:	6105                	addi	sp,sp,32
     91a:	8082                	ret

000000000000091c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     91c:	7139                	addi	sp,sp,-64
     91e:	fc06                	sd	ra,56(sp)
     920:	f822                	sd	s0,48(sp)
     922:	0080                	addi	s0,sp,64
     924:	87aa                	mv	a5,a0
     926:	8736                	mv	a4,a3
     928:	fcf42623          	sw	a5,-52(s0)
     92c:	87ae                	mv	a5,a1
     92e:	fcf42423          	sw	a5,-56(s0)
     932:	87b2                	mv	a5,a2
     934:	fcf42223          	sw	a5,-60(s0)
     938:	87ba                	mv	a5,a4
     93a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     93e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     942:	fc042783          	lw	a5,-64(s0)
     946:	2781                	sext.w	a5,a5
     948:	c38d                	beqz	a5,96a <printint+0x4e>
     94a:	fc842783          	lw	a5,-56(s0)
     94e:	2781                	sext.w	a5,a5
     950:	0007dd63          	bgez	a5,96a <printint+0x4e>
    neg = 1;
     954:	4785                	li	a5,1
     956:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     95a:	fc842783          	lw	a5,-56(s0)
     95e:	40f007bb          	negw	a5,a5
     962:	2781                	sext.w	a5,a5
     964:	fef42223          	sw	a5,-28(s0)
     968:	a029                	j	972 <printint+0x56>
  } else {
    x = xx;
     96a:	fc842783          	lw	a5,-56(s0)
     96e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     972:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     976:	fc442783          	lw	a5,-60(s0)
     97a:	fe442703          	lw	a4,-28(s0)
     97e:	02f777bb          	remuw	a5,a4,a5
     982:	0007861b          	sext.w	a2,a5
     986:	fec42783          	lw	a5,-20(s0)
     98a:	0017871b          	addiw	a4,a5,1
     98e:	fee42623          	sw	a4,-20(s0)
     992:	00001697          	auipc	a3,0x1
     996:	66e68693          	addi	a3,a3,1646 # 2000 <digits>
     99a:	02061713          	slli	a4,a2,0x20
     99e:	9301                	srli	a4,a4,0x20
     9a0:	9736                	add	a4,a4,a3
     9a2:	00074703          	lbu	a4,0(a4)
     9a6:	ff040693          	addi	a3,s0,-16
     9aa:	97b6                	add	a5,a5,a3
     9ac:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     9b0:	fc442783          	lw	a5,-60(s0)
     9b4:	fe442703          	lw	a4,-28(s0)
     9b8:	02f757bb          	divuw	a5,a4,a5
     9bc:	fef42223          	sw	a5,-28(s0)
     9c0:	fe442783          	lw	a5,-28(s0)
     9c4:	2781                	sext.w	a5,a5
     9c6:	fbc5                	bnez	a5,976 <printint+0x5a>
  if(neg)
     9c8:	fe842783          	lw	a5,-24(s0)
     9cc:	2781                	sext.w	a5,a5
     9ce:	cf95                	beqz	a5,a0a <printint+0xee>
    buf[i++] = '-';
     9d0:	fec42783          	lw	a5,-20(s0)
     9d4:	0017871b          	addiw	a4,a5,1
     9d8:	fee42623          	sw	a4,-20(s0)
     9dc:	ff040713          	addi	a4,s0,-16
     9e0:	97ba                	add	a5,a5,a4
     9e2:	02d00713          	li	a4,45
     9e6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     9ea:	a005                	j	a0a <printint+0xee>
    putc(fd, buf[i]);
     9ec:	fec42783          	lw	a5,-20(s0)
     9f0:	ff040713          	addi	a4,s0,-16
     9f4:	97ba                	add	a5,a5,a4
     9f6:	fe07c703          	lbu	a4,-32(a5)
     9fa:	fcc42783          	lw	a5,-52(s0)
     9fe:	85ba                	mv	a1,a4
     a00:	853e                	mv	a0,a5
     a02:	00000097          	auipc	ra,0x0
     a06:	ee4080e7          	jalr	-284(ra) # 8e6 <putc>
  while(--i >= 0)
     a0a:	fec42783          	lw	a5,-20(s0)
     a0e:	37fd                	addiw	a5,a5,-1
     a10:	fef42623          	sw	a5,-20(s0)
     a14:	fec42783          	lw	a5,-20(s0)
     a18:	2781                	sext.w	a5,a5
     a1a:	fc07d9e3          	bgez	a5,9ec <printint+0xd0>
}
     a1e:	0001                	nop
     a20:	0001                	nop
     a22:	70e2                	ld	ra,56(sp)
     a24:	7442                	ld	s0,48(sp)
     a26:	6121                	addi	sp,sp,64
     a28:	8082                	ret

0000000000000a2a <printptr>:

static void
printptr(int fd, uint64 x) {
     a2a:	7179                	addi	sp,sp,-48
     a2c:	f406                	sd	ra,40(sp)
     a2e:	f022                	sd	s0,32(sp)
     a30:	1800                	addi	s0,sp,48
     a32:	87aa                	mv	a5,a0
     a34:	fcb43823          	sd	a1,-48(s0)
     a38:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a3c:	fdc42783          	lw	a5,-36(s0)
     a40:	03000593          	li	a1,48
     a44:	853e                	mv	a0,a5
     a46:	00000097          	auipc	ra,0x0
     a4a:	ea0080e7          	jalr	-352(ra) # 8e6 <putc>
  putc(fd, 'x');
     a4e:	fdc42783          	lw	a5,-36(s0)
     a52:	07800593          	li	a1,120
     a56:	853e                	mv	a0,a5
     a58:	00000097          	auipc	ra,0x0
     a5c:	e8e080e7          	jalr	-370(ra) # 8e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a60:	fe042623          	sw	zero,-20(s0)
     a64:	a82d                	j	a9e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     a66:	fd043783          	ld	a5,-48(s0)
     a6a:	93f1                	srli	a5,a5,0x3c
     a6c:	00001717          	auipc	a4,0x1
     a70:	59470713          	addi	a4,a4,1428 # 2000 <digits>
     a74:	97ba                	add	a5,a5,a4
     a76:	0007c703          	lbu	a4,0(a5)
     a7a:	fdc42783          	lw	a5,-36(s0)
     a7e:	85ba                	mv	a1,a4
     a80:	853e                	mv	a0,a5
     a82:	00000097          	auipc	ra,0x0
     a86:	e64080e7          	jalr	-412(ra) # 8e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a8a:	fec42783          	lw	a5,-20(s0)
     a8e:	2785                	addiw	a5,a5,1
     a90:	fef42623          	sw	a5,-20(s0)
     a94:	fd043783          	ld	a5,-48(s0)
     a98:	0792                	slli	a5,a5,0x4
     a9a:	fcf43823          	sd	a5,-48(s0)
     a9e:	fec42783          	lw	a5,-20(s0)
     aa2:	873e                	mv	a4,a5
     aa4:	47bd                	li	a5,15
     aa6:	fce7f0e3          	bgeu	a5,a4,a66 <printptr+0x3c>
}
     aaa:	0001                	nop
     aac:	0001                	nop
     aae:	70a2                	ld	ra,40(sp)
     ab0:	7402                	ld	s0,32(sp)
     ab2:	6145                	addi	sp,sp,48
     ab4:	8082                	ret

0000000000000ab6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     ab6:	715d                	addi	sp,sp,-80
     ab8:	e486                	sd	ra,72(sp)
     aba:	e0a2                	sd	s0,64(sp)
     abc:	0880                	addi	s0,sp,80
     abe:	87aa                	mv	a5,a0
     ac0:	fcb43023          	sd	a1,-64(s0)
     ac4:	fac43c23          	sd	a2,-72(s0)
     ac8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     acc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ad0:	fe042223          	sw	zero,-28(s0)
     ad4:	a42d                	j	cfe <vprintf+0x248>
    c = fmt[i] & 0xff;
     ad6:	fe442783          	lw	a5,-28(s0)
     ada:	fc043703          	ld	a4,-64(s0)
     ade:	97ba                	add	a5,a5,a4
     ae0:	0007c783          	lbu	a5,0(a5)
     ae4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     ae8:	fe042783          	lw	a5,-32(s0)
     aec:	2781                	sext.w	a5,a5
     aee:	eb9d                	bnez	a5,b24 <vprintf+0x6e>
      if(c == '%'){
     af0:	fdc42783          	lw	a5,-36(s0)
     af4:	0007871b          	sext.w	a4,a5
     af8:	02500793          	li	a5,37
     afc:	00f71763          	bne	a4,a5,b0a <vprintf+0x54>
        state = '%';
     b00:	02500793          	li	a5,37
     b04:	fef42023          	sw	a5,-32(s0)
     b08:	a2f5                	j	cf4 <vprintf+0x23e>
      } else {
        putc(fd, c);
     b0a:	fdc42783          	lw	a5,-36(s0)
     b0e:	0ff7f713          	andi	a4,a5,255
     b12:	fcc42783          	lw	a5,-52(s0)
     b16:	85ba                	mv	a1,a4
     b18:	853e                	mv	a0,a5
     b1a:	00000097          	auipc	ra,0x0
     b1e:	dcc080e7          	jalr	-564(ra) # 8e6 <putc>
     b22:	aac9                	j	cf4 <vprintf+0x23e>
      }
    } else if(state == '%'){
     b24:	fe042783          	lw	a5,-32(s0)
     b28:	0007871b          	sext.w	a4,a5
     b2c:	02500793          	li	a5,37
     b30:	1cf71263          	bne	a4,a5,cf4 <vprintf+0x23e>
      if(c == 'd'){
     b34:	fdc42783          	lw	a5,-36(s0)
     b38:	0007871b          	sext.w	a4,a5
     b3c:	06400793          	li	a5,100
     b40:	02f71463          	bne	a4,a5,b68 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     b44:	fb843783          	ld	a5,-72(s0)
     b48:	00878713          	addi	a4,a5,8
     b4c:	fae43c23          	sd	a4,-72(s0)
     b50:	4398                	lw	a4,0(a5)
     b52:	fcc42783          	lw	a5,-52(s0)
     b56:	4685                	li	a3,1
     b58:	4629                	li	a2,10
     b5a:	85ba                	mv	a1,a4
     b5c:	853e                	mv	a0,a5
     b5e:	00000097          	auipc	ra,0x0
     b62:	dbe080e7          	jalr	-578(ra) # 91c <printint>
     b66:	a269                	j	cf0 <vprintf+0x23a>
      } else if(c == 'l') {
     b68:	fdc42783          	lw	a5,-36(s0)
     b6c:	0007871b          	sext.w	a4,a5
     b70:	06c00793          	li	a5,108
     b74:	02f71663          	bne	a4,a5,ba0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b78:	fb843783          	ld	a5,-72(s0)
     b7c:	00878713          	addi	a4,a5,8
     b80:	fae43c23          	sd	a4,-72(s0)
     b84:	639c                	ld	a5,0(a5)
     b86:	0007871b          	sext.w	a4,a5
     b8a:	fcc42783          	lw	a5,-52(s0)
     b8e:	4681                	li	a3,0
     b90:	4629                	li	a2,10
     b92:	85ba                	mv	a1,a4
     b94:	853e                	mv	a0,a5
     b96:	00000097          	auipc	ra,0x0
     b9a:	d86080e7          	jalr	-634(ra) # 91c <printint>
     b9e:	aa89                	j	cf0 <vprintf+0x23a>
      } else if(c == 'x') {
     ba0:	fdc42783          	lw	a5,-36(s0)
     ba4:	0007871b          	sext.w	a4,a5
     ba8:	07800793          	li	a5,120
     bac:	02f71463          	bne	a4,a5,bd4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     bb0:	fb843783          	ld	a5,-72(s0)
     bb4:	00878713          	addi	a4,a5,8
     bb8:	fae43c23          	sd	a4,-72(s0)
     bbc:	4398                	lw	a4,0(a5)
     bbe:	fcc42783          	lw	a5,-52(s0)
     bc2:	4681                	li	a3,0
     bc4:	4641                	li	a2,16
     bc6:	85ba                	mv	a1,a4
     bc8:	853e                	mv	a0,a5
     bca:	00000097          	auipc	ra,0x0
     bce:	d52080e7          	jalr	-686(ra) # 91c <printint>
     bd2:	aa39                	j	cf0 <vprintf+0x23a>
      } else if(c == 'p') {
     bd4:	fdc42783          	lw	a5,-36(s0)
     bd8:	0007871b          	sext.w	a4,a5
     bdc:	07000793          	li	a5,112
     be0:	02f71263          	bne	a4,a5,c04 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     be4:	fb843783          	ld	a5,-72(s0)
     be8:	00878713          	addi	a4,a5,8
     bec:	fae43c23          	sd	a4,-72(s0)
     bf0:	6398                	ld	a4,0(a5)
     bf2:	fcc42783          	lw	a5,-52(s0)
     bf6:	85ba                	mv	a1,a4
     bf8:	853e                	mv	a0,a5
     bfa:	00000097          	auipc	ra,0x0
     bfe:	e30080e7          	jalr	-464(ra) # a2a <printptr>
     c02:	a0fd                	j	cf0 <vprintf+0x23a>
      } else if(c == 's'){
     c04:	fdc42783          	lw	a5,-36(s0)
     c08:	0007871b          	sext.w	a4,a5
     c0c:	07300793          	li	a5,115
     c10:	04f71c63          	bne	a4,a5,c68 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c14:	fb843783          	ld	a5,-72(s0)
     c18:	00878713          	addi	a4,a5,8
     c1c:	fae43c23          	sd	a4,-72(s0)
     c20:	639c                	ld	a5,0(a5)
     c22:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c26:	fe843783          	ld	a5,-24(s0)
     c2a:	eb8d                	bnez	a5,c5c <vprintf+0x1a6>
          s = "(null)";
     c2c:	00000797          	auipc	a5,0x0
     c30:	4f478793          	addi	a5,a5,1268 # 1120 <malloc+0x1ba>
     c34:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c38:	a015                	j	c5c <vprintf+0x1a6>
          putc(fd, *s);
     c3a:	fe843783          	ld	a5,-24(s0)
     c3e:	0007c703          	lbu	a4,0(a5)
     c42:	fcc42783          	lw	a5,-52(s0)
     c46:	85ba                	mv	a1,a4
     c48:	853e                	mv	a0,a5
     c4a:	00000097          	auipc	ra,0x0
     c4e:	c9c080e7          	jalr	-868(ra) # 8e6 <putc>
          s++;
     c52:	fe843783          	ld	a5,-24(s0)
     c56:	0785                	addi	a5,a5,1
     c58:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c5c:	fe843783          	ld	a5,-24(s0)
     c60:	0007c783          	lbu	a5,0(a5)
     c64:	fbf9                	bnez	a5,c3a <vprintf+0x184>
     c66:	a069                	j	cf0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     c68:	fdc42783          	lw	a5,-36(s0)
     c6c:	0007871b          	sext.w	a4,a5
     c70:	06300793          	li	a5,99
     c74:	02f71463          	bne	a4,a5,c9c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     c78:	fb843783          	ld	a5,-72(s0)
     c7c:	00878713          	addi	a4,a5,8
     c80:	fae43c23          	sd	a4,-72(s0)
     c84:	439c                	lw	a5,0(a5)
     c86:	0ff7f713          	andi	a4,a5,255
     c8a:	fcc42783          	lw	a5,-52(s0)
     c8e:	85ba                	mv	a1,a4
     c90:	853e                	mv	a0,a5
     c92:	00000097          	auipc	ra,0x0
     c96:	c54080e7          	jalr	-940(ra) # 8e6 <putc>
     c9a:	a899                	j	cf0 <vprintf+0x23a>
      } else if(c == '%'){
     c9c:	fdc42783          	lw	a5,-36(s0)
     ca0:	0007871b          	sext.w	a4,a5
     ca4:	02500793          	li	a5,37
     ca8:	00f71f63          	bne	a4,a5,cc6 <vprintf+0x210>
        putc(fd, c);
     cac:	fdc42783          	lw	a5,-36(s0)
     cb0:	0ff7f713          	andi	a4,a5,255
     cb4:	fcc42783          	lw	a5,-52(s0)
     cb8:	85ba                	mv	a1,a4
     cba:	853e                	mv	a0,a5
     cbc:	00000097          	auipc	ra,0x0
     cc0:	c2a080e7          	jalr	-982(ra) # 8e6 <putc>
     cc4:	a035                	j	cf0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cc6:	fcc42783          	lw	a5,-52(s0)
     cca:	02500593          	li	a1,37
     cce:	853e                	mv	a0,a5
     cd0:	00000097          	auipc	ra,0x0
     cd4:	c16080e7          	jalr	-1002(ra) # 8e6 <putc>
        putc(fd, c);
     cd8:	fdc42783          	lw	a5,-36(s0)
     cdc:	0ff7f713          	andi	a4,a5,255
     ce0:	fcc42783          	lw	a5,-52(s0)
     ce4:	85ba                	mv	a1,a4
     ce6:	853e                	mv	a0,a5
     ce8:	00000097          	auipc	ra,0x0
     cec:	bfe080e7          	jalr	-1026(ra) # 8e6 <putc>
      }
      state = 0;
     cf0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     cf4:	fe442783          	lw	a5,-28(s0)
     cf8:	2785                	addiw	a5,a5,1
     cfa:	fef42223          	sw	a5,-28(s0)
     cfe:	fe442783          	lw	a5,-28(s0)
     d02:	fc043703          	ld	a4,-64(s0)
     d06:	97ba                	add	a5,a5,a4
     d08:	0007c783          	lbu	a5,0(a5)
     d0c:	dc0795e3          	bnez	a5,ad6 <vprintf+0x20>
    }
  }
}
     d10:	0001                	nop
     d12:	0001                	nop
     d14:	60a6                	ld	ra,72(sp)
     d16:	6406                	ld	s0,64(sp)
     d18:	6161                	addi	sp,sp,80
     d1a:	8082                	ret

0000000000000d1c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d1c:	7159                	addi	sp,sp,-112
     d1e:	fc06                	sd	ra,56(sp)
     d20:	f822                	sd	s0,48(sp)
     d22:	0080                	addi	s0,sp,64
     d24:	fcb43823          	sd	a1,-48(s0)
     d28:	e010                	sd	a2,0(s0)
     d2a:	e414                	sd	a3,8(s0)
     d2c:	e818                	sd	a4,16(s0)
     d2e:	ec1c                	sd	a5,24(s0)
     d30:	03043023          	sd	a6,32(s0)
     d34:	03143423          	sd	a7,40(s0)
     d38:	87aa                	mv	a5,a0
     d3a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d3e:	03040793          	addi	a5,s0,48
     d42:	fcf43423          	sd	a5,-56(s0)
     d46:	fc843783          	ld	a5,-56(s0)
     d4a:	fd078793          	addi	a5,a5,-48
     d4e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d52:	fe843703          	ld	a4,-24(s0)
     d56:	fdc42783          	lw	a5,-36(s0)
     d5a:	863a                	mv	a2,a4
     d5c:	fd043583          	ld	a1,-48(s0)
     d60:	853e                	mv	a0,a5
     d62:	00000097          	auipc	ra,0x0
     d66:	d54080e7          	jalr	-684(ra) # ab6 <vprintf>
}
     d6a:	0001                	nop
     d6c:	70e2                	ld	ra,56(sp)
     d6e:	7442                	ld	s0,48(sp)
     d70:	6165                	addi	sp,sp,112
     d72:	8082                	ret

0000000000000d74 <printf>:

void
printf(const char *fmt, ...)
{
     d74:	7159                	addi	sp,sp,-112
     d76:	f406                	sd	ra,40(sp)
     d78:	f022                	sd	s0,32(sp)
     d7a:	1800                	addi	s0,sp,48
     d7c:	fca43c23          	sd	a0,-40(s0)
     d80:	e40c                	sd	a1,8(s0)
     d82:	e810                	sd	a2,16(s0)
     d84:	ec14                	sd	a3,24(s0)
     d86:	f018                	sd	a4,32(s0)
     d88:	f41c                	sd	a5,40(s0)
     d8a:	03043823          	sd	a6,48(s0)
     d8e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d92:	04040793          	addi	a5,s0,64
     d96:	fcf43823          	sd	a5,-48(s0)
     d9a:	fd043783          	ld	a5,-48(s0)
     d9e:	fc878793          	addi	a5,a5,-56
     da2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     da6:	fe843783          	ld	a5,-24(s0)
     daa:	863e                	mv	a2,a5
     dac:	fd843583          	ld	a1,-40(s0)
     db0:	4505                	li	a0,1
     db2:	00000097          	auipc	ra,0x0
     db6:	d04080e7          	jalr	-764(ra) # ab6 <vprintf>
}
     dba:	0001                	nop
     dbc:	70a2                	ld	ra,40(sp)
     dbe:	7402                	ld	s0,32(sp)
     dc0:	6165                	addi	sp,sp,112
     dc2:	8082                	ret

0000000000000dc4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dc4:	7179                	addi	sp,sp,-48
     dc6:	f422                	sd	s0,40(sp)
     dc8:	1800                	addi	s0,sp,48
     dca:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     dce:	fd843783          	ld	a5,-40(s0)
     dd2:	17c1                	addi	a5,a5,-16
     dd4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dd8:	00001797          	auipc	a5,0x1
     ddc:	26878793          	addi	a5,a5,616 # 2040 <freep>
     de0:	639c                	ld	a5,0(a5)
     de2:	fef43423          	sd	a5,-24(s0)
     de6:	a815                	j	e1a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     de8:	fe843783          	ld	a5,-24(s0)
     dec:	639c                	ld	a5,0(a5)
     dee:	fe843703          	ld	a4,-24(s0)
     df2:	00f76f63          	bltu	a4,a5,e10 <free+0x4c>
     df6:	fe043703          	ld	a4,-32(s0)
     dfa:	fe843783          	ld	a5,-24(s0)
     dfe:	02e7eb63          	bltu	a5,a4,e34 <free+0x70>
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	639c                	ld	a5,0(a5)
     e08:	fe043703          	ld	a4,-32(s0)
     e0c:	02f76463          	bltu	a4,a5,e34 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e10:	fe843783          	ld	a5,-24(s0)
     e14:	639c                	ld	a5,0(a5)
     e16:	fef43423          	sd	a5,-24(s0)
     e1a:	fe043703          	ld	a4,-32(s0)
     e1e:	fe843783          	ld	a5,-24(s0)
     e22:	fce7f3e3          	bgeu	a5,a4,de8 <free+0x24>
     e26:	fe843783          	ld	a5,-24(s0)
     e2a:	639c                	ld	a5,0(a5)
     e2c:	fe043703          	ld	a4,-32(s0)
     e30:	faf77ce3          	bgeu	a4,a5,de8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e34:	fe043783          	ld	a5,-32(s0)
     e38:	479c                	lw	a5,8(a5)
     e3a:	1782                	slli	a5,a5,0x20
     e3c:	9381                	srli	a5,a5,0x20
     e3e:	0792                	slli	a5,a5,0x4
     e40:	fe043703          	ld	a4,-32(s0)
     e44:	973e                	add	a4,a4,a5
     e46:	fe843783          	ld	a5,-24(s0)
     e4a:	639c                	ld	a5,0(a5)
     e4c:	02f71763          	bne	a4,a5,e7a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     e50:	fe043783          	ld	a5,-32(s0)
     e54:	4798                	lw	a4,8(a5)
     e56:	fe843783          	ld	a5,-24(s0)
     e5a:	639c                	ld	a5,0(a5)
     e5c:	479c                	lw	a5,8(a5)
     e5e:	9fb9                	addw	a5,a5,a4
     e60:	0007871b          	sext.w	a4,a5
     e64:	fe043783          	ld	a5,-32(s0)
     e68:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e6a:	fe843783          	ld	a5,-24(s0)
     e6e:	639c                	ld	a5,0(a5)
     e70:	6398                	ld	a4,0(a5)
     e72:	fe043783          	ld	a5,-32(s0)
     e76:	e398                	sd	a4,0(a5)
     e78:	a039                	j	e86 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     e7a:	fe843783          	ld	a5,-24(s0)
     e7e:	6398                	ld	a4,0(a5)
     e80:	fe043783          	ld	a5,-32(s0)
     e84:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e86:	fe843783          	ld	a5,-24(s0)
     e8a:	479c                	lw	a5,8(a5)
     e8c:	1782                	slli	a5,a5,0x20
     e8e:	9381                	srli	a5,a5,0x20
     e90:	0792                	slli	a5,a5,0x4
     e92:	fe843703          	ld	a4,-24(s0)
     e96:	97ba                	add	a5,a5,a4
     e98:	fe043703          	ld	a4,-32(s0)
     e9c:	02f71563          	bne	a4,a5,ec6 <free+0x102>
    p->s.size += bp->s.size;
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	4798                	lw	a4,8(a5)
     ea6:	fe043783          	ld	a5,-32(s0)
     eaa:	479c                	lw	a5,8(a5)
     eac:	9fb9                	addw	a5,a5,a4
     eae:	0007871b          	sext.w	a4,a5
     eb2:	fe843783          	ld	a5,-24(s0)
     eb6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     eb8:	fe043783          	ld	a5,-32(s0)
     ebc:	6398                	ld	a4,0(a5)
     ebe:	fe843783          	ld	a5,-24(s0)
     ec2:	e398                	sd	a4,0(a5)
     ec4:	a031                	j	ed0 <free+0x10c>
  } else
    p->s.ptr = bp;
     ec6:	fe843783          	ld	a5,-24(s0)
     eca:	fe043703          	ld	a4,-32(s0)
     ece:	e398                	sd	a4,0(a5)
  freep = p;
     ed0:	00001797          	auipc	a5,0x1
     ed4:	17078793          	addi	a5,a5,368 # 2040 <freep>
     ed8:	fe843703          	ld	a4,-24(s0)
     edc:	e398                	sd	a4,0(a5)
}
     ede:	0001                	nop
     ee0:	7422                	ld	s0,40(sp)
     ee2:	6145                	addi	sp,sp,48
     ee4:	8082                	ret

0000000000000ee6 <morecore>:

static Header*
morecore(uint nu)
{
     ee6:	7179                	addi	sp,sp,-48
     ee8:	f406                	sd	ra,40(sp)
     eea:	f022                	sd	s0,32(sp)
     eec:	1800                	addi	s0,sp,48
     eee:	87aa                	mv	a5,a0
     ef0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     ef4:	fdc42783          	lw	a5,-36(s0)
     ef8:	0007871b          	sext.w	a4,a5
     efc:	6785                	lui	a5,0x1
     efe:	00f77563          	bgeu	a4,a5,f08 <morecore+0x22>
    nu = 4096;
     f02:	6785                	lui	a5,0x1
     f04:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f08:	fdc42783          	lw	a5,-36(s0)
     f0c:	0047979b          	slliw	a5,a5,0x4
     f10:	2781                	sext.w	a5,a5
     f12:	2781                	sext.w	a5,a5
     f14:	853e                	mv	a0,a5
     f16:	00000097          	auipc	ra,0x0
     f1a:	9b8080e7          	jalr	-1608(ra) # 8ce <sbrk>
     f1e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f22:	fe843703          	ld	a4,-24(s0)
     f26:	57fd                	li	a5,-1
     f28:	00f71463          	bne	a4,a5,f30 <morecore+0x4a>
    return 0;
     f2c:	4781                	li	a5,0
     f2e:	a03d                	j	f5c <morecore+0x76>
  hp = (Header*)p;
     f30:	fe843783          	ld	a5,-24(s0)
     f34:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f38:	fe043783          	ld	a5,-32(s0)
     f3c:	fdc42703          	lw	a4,-36(s0)
     f40:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f42:	fe043783          	ld	a5,-32(s0)
     f46:	07c1                	addi	a5,a5,16
     f48:	853e                	mv	a0,a5
     f4a:	00000097          	auipc	ra,0x0
     f4e:	e7a080e7          	jalr	-390(ra) # dc4 <free>
  return freep;
     f52:	00001797          	auipc	a5,0x1
     f56:	0ee78793          	addi	a5,a5,238 # 2040 <freep>
     f5a:	639c                	ld	a5,0(a5)
}
     f5c:	853e                	mv	a0,a5
     f5e:	70a2                	ld	ra,40(sp)
     f60:	7402                	ld	s0,32(sp)
     f62:	6145                	addi	sp,sp,48
     f64:	8082                	ret

0000000000000f66 <malloc>:

void*
malloc(uint nbytes)
{
     f66:	7139                	addi	sp,sp,-64
     f68:	fc06                	sd	ra,56(sp)
     f6a:	f822                	sd	s0,48(sp)
     f6c:	0080                	addi	s0,sp,64
     f6e:	87aa                	mv	a5,a0
     f70:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f74:	fcc46783          	lwu	a5,-52(s0)
     f78:	07bd                	addi	a5,a5,15
     f7a:	8391                	srli	a5,a5,0x4
     f7c:	2781                	sext.w	a5,a5
     f7e:	2785                	addiw	a5,a5,1
     f80:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f84:	00001797          	auipc	a5,0x1
     f88:	0bc78793          	addi	a5,a5,188 # 2040 <freep>
     f8c:	639c                	ld	a5,0(a5)
     f8e:	fef43023          	sd	a5,-32(s0)
     f92:	fe043783          	ld	a5,-32(s0)
     f96:	ef95                	bnez	a5,fd2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f98:	00001797          	auipc	a5,0x1
     f9c:	09878793          	addi	a5,a5,152 # 2030 <base>
     fa0:	fef43023          	sd	a5,-32(s0)
     fa4:	00001797          	auipc	a5,0x1
     fa8:	09c78793          	addi	a5,a5,156 # 2040 <freep>
     fac:	fe043703          	ld	a4,-32(s0)
     fb0:	e398                	sd	a4,0(a5)
     fb2:	00001797          	auipc	a5,0x1
     fb6:	08e78793          	addi	a5,a5,142 # 2040 <freep>
     fba:	6398                	ld	a4,0(a5)
     fbc:	00001797          	auipc	a5,0x1
     fc0:	07478793          	addi	a5,a5,116 # 2030 <base>
     fc4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fc6:	00001797          	auipc	a5,0x1
     fca:	06a78793          	addi	a5,a5,106 # 2030 <base>
     fce:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fd2:	fe043783          	ld	a5,-32(s0)
     fd6:	639c                	ld	a5,0(a5)
     fd8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fdc:	fe843783          	ld	a5,-24(s0)
     fe0:	4798                	lw	a4,8(a5)
     fe2:	fdc42783          	lw	a5,-36(s0)
     fe6:	2781                	sext.w	a5,a5
     fe8:	06f76863          	bltu	a4,a5,1058 <malloc+0xf2>
      if(p->s.size == nunits)
     fec:	fe843783          	ld	a5,-24(s0)
     ff0:	4798                	lw	a4,8(a5)
     ff2:	fdc42783          	lw	a5,-36(s0)
     ff6:	2781                	sext.w	a5,a5
     ff8:	00e79963          	bne	a5,a4,100a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     ffc:	fe843783          	ld	a5,-24(s0)
    1000:	6398                	ld	a4,0(a5)
    1002:	fe043783          	ld	a5,-32(s0)
    1006:	e398                	sd	a4,0(a5)
    1008:	a82d                	j	1042 <malloc+0xdc>
      else {
        p->s.size -= nunits;
    100a:	fe843783          	ld	a5,-24(s0)
    100e:	4798                	lw	a4,8(a5)
    1010:	fdc42783          	lw	a5,-36(s0)
    1014:	40f707bb          	subw	a5,a4,a5
    1018:	0007871b          	sext.w	a4,a5
    101c:	fe843783          	ld	a5,-24(s0)
    1020:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1022:	fe843783          	ld	a5,-24(s0)
    1026:	479c                	lw	a5,8(a5)
    1028:	1782                	slli	a5,a5,0x20
    102a:	9381                	srli	a5,a5,0x20
    102c:	0792                	slli	a5,a5,0x4
    102e:	fe843703          	ld	a4,-24(s0)
    1032:	97ba                	add	a5,a5,a4
    1034:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1038:	fe843783          	ld	a5,-24(s0)
    103c:	fdc42703          	lw	a4,-36(s0)
    1040:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1042:	00001797          	auipc	a5,0x1
    1046:	ffe78793          	addi	a5,a5,-2 # 2040 <freep>
    104a:	fe043703          	ld	a4,-32(s0)
    104e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1050:	fe843783          	ld	a5,-24(s0)
    1054:	07c1                	addi	a5,a5,16
    1056:	a091                	j	109a <malloc+0x134>
    }
    if(p == freep)
    1058:	00001797          	auipc	a5,0x1
    105c:	fe878793          	addi	a5,a5,-24 # 2040 <freep>
    1060:	639c                	ld	a5,0(a5)
    1062:	fe843703          	ld	a4,-24(s0)
    1066:	02f71063          	bne	a4,a5,1086 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    106a:	fdc42783          	lw	a5,-36(s0)
    106e:	853e                	mv	a0,a5
    1070:	00000097          	auipc	ra,0x0
    1074:	e76080e7          	jalr	-394(ra) # ee6 <morecore>
    1078:	fea43423          	sd	a0,-24(s0)
    107c:	fe843783          	ld	a5,-24(s0)
    1080:	e399                	bnez	a5,1086 <malloc+0x120>
        return 0;
    1082:	4781                	li	a5,0
    1084:	a819                	j	109a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1086:	fe843783          	ld	a5,-24(s0)
    108a:	fef43023          	sd	a5,-32(s0)
    108e:	fe843783          	ld	a5,-24(s0)
    1092:	639c                	ld	a5,0(a5)
    1094:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1098:	b791                	j	fdc <malloc+0x76>
  }
}
    109a:	853e                	mv	a0,a5
    109c:	70e2                	ld	ra,56(sp)
    109e:	7442                	ld	s0,48(sp)
    10a0:	6121                	addi	sp,sp,64
    10a2:	8082                	ret
