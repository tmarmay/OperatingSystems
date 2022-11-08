
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include <stddef.h>

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int rc,rally;

  //En caso de no tener los argumentos correctos
  if(argc != 2){
   c:	4789                	li	a5,2
   e:	02f50063          	beq	a0,a5,2e <main+0x2e>
    fprintf(2, "usage: pingpong rallies...\n");
  12:	00001597          	auipc	a1,0x1
  16:	91e58593          	addi	a1,a1,-1762 # 930 <malloc+0xec>
  1a:	4509                	li	a0,2
  1c:	00000097          	auipc	ra,0x0
  20:	73c080e7          	jalr	1852(ra) # 758 <fprintf>
    exit(1);
  24:	4505                	li	a0,1
  26:	00000097          	auipc	ra,0x0
  2a:	3c8080e7          	jalr	968(ra) # 3ee <exit>
  }

  // Tomamos el argumento del numero de rallies pedidos
  rally = atoi(argv[1]);
  2e:	6588                	ld	a0,8(a1)
  30:	00000097          	auipc	ra,0x0
  34:	2be080e7          	jalr	702(ra) # 2ee <atoi>
  38:	84aa                	mv	s1,a0
  if (rally < 1)
  3a:	00a05e63          	blez	a0,56 <main+0x56>
  }


  // Abriendo los semaforos
  //Semaforo hijo(0)
  if ( sem_open(0,0) == 0 )
  3e:	4581                	li	a1,0
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	44c080e7          	jalr	1100(ra) # 48e <sem_open>
  4a:	e11d                	bnez	a0,70 <main+0x70>
    exit(1);
  4c:	4505                	li	a0,1
  4e:	00000097          	auipc	ra,0x0
  52:	3a0080e7          	jalr	928(ra) # 3ee <exit>
    printf("rallie value must be greater than 0...\n");
  56:	00001517          	auipc	a0,0x1
  5a:	8fa50513          	addi	a0,a0,-1798 # 950 <malloc+0x10c>
  5e:	00000097          	auipc	ra,0x0
  62:	728080e7          	jalr	1832(ra) # 786 <printf>
    exit(0);
  66:	4501                	li	a0,0
  68:	00000097          	auipc	ra,0x0
  6c:	386080e7          	jalr	902(ra) # 3ee <exit>
  //Semaforo semaforo padre(1)
  if ( sem_open(1,1) == 0) 
  70:	4585                	li	a1,1
  72:	4505                	li	a0,1
  74:	00000097          	auipc	ra,0x0
  78:	41a080e7          	jalr	1050(ra) # 48e <sem_open>
  7c:	e511                	bnez	a0,88 <main+0x88>
    exit(1);
  7e:	4505                	li	a0,1
  80:	00000097          	auipc	ra,0x0
  84:	36e080e7          	jalr	878(ra) # 3ee <exit>
  
  rc = fork();
  88:	00000097          	auipc	ra,0x0
  8c:	35e080e7          	jalr	862(ra) # 3e6 <fork>

  //El caso del Hijo
  if (rc == 0) {
  90:	e539                	bnez	a0,de <main+0xde>
    while (rally > 0){
      if ( sem_down(0) == 0 )
        exit(1); 
      printf("\tPong!\n");
  92:	00001917          	auipc	s2,0x1
  96:	8e690913          	addi	s2,s2,-1818 # 978 <malloc+0x134>
      if ( sem_down(0) == 0 )
  9a:	4501                	li	a0,0
  9c:	00000097          	auipc	ra,0x0
  a0:	402080e7          	jalr	1026(ra) # 49e <sem_down>
  a4:	c11d                	beqz	a0,ca <main+0xca>
      printf("\tPong!\n");
  a6:	854a                	mv	a0,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	6de080e7          	jalr	1758(ra) # 786 <printf>
      rally--;
  b0:	34fd                	addiw	s1,s1,-1
      if ( sem_up(1) == 0 )
  b2:	4505                	li	a0,1
  b4:	00000097          	auipc	ra,0x0
  b8:	3e2080e7          	jalr	994(ra) # 496 <sem_up>
  bc:	cd01                	beqz	a0,d4 <main+0xd4>
    while (rally > 0){
  be:	fcf1                	bnez	s1,9a <main+0x9a>
        exit(1);
    }
    
    exit(0);
  c0:	4501                	li	a0,0
  c2:	00000097          	auipc	ra,0x0
  c6:	32c080e7          	jalr	812(ra) # 3ee <exit>
        exit(1); 
  ca:	4505                	li	a0,1
  cc:	00000097          	auipc	ra,0x0
  d0:	322080e7          	jalr	802(ra) # 3ee <exit>
        exit(1);
  d4:	4505                	li	a0,1
  d6:	00000097          	auipc	ra,0x0
  da:	318080e7          	jalr	792(ra) # 3ee <exit>
  }
  else if (rc == -1){
  de:	57fd                	li	a5,-1
  }
  
  // El caso del Padre
  else {
    while (rally > 0){
      printf("Ping!\n");
  e0:	00001917          	auipc	s2,0x1
  e4:	8b090913          	addi	s2,s2,-1872 # 990 <malloc+0x14c>
  else if (rc == -1){
  e8:	04f50463          	beq	a0,a5,130 <main+0x130>
      printf("Ping!\n");
  ec:	854a                	mv	a0,s2
  ee:	00000097          	auipc	ra,0x0
  f2:	698080e7          	jalr	1688(ra) # 786 <printf>
      rally--;
  f6:	34fd                	addiw	s1,s1,-1
      if ( sem_up(0) == 0 ) 
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	39c080e7          	jalr	924(ra) # 496 <sem_up>
 102:	c521                	beqz	a0,14a <main+0x14a>
        exit(1);
      if ( sem_down(1) == 0 ) 
 104:	4505                	li	a0,1
 106:	00000097          	auipc	ra,0x0
 10a:	398080e7          	jalr	920(ra) # 49e <sem_down>
 10e:	c139                	beqz	a0,154 <main+0x154>
    while (rally > 0){
 110:	fcf1                	bnez	s1,ec <main+0xec>
    }
  }

  
  // Cerrando los semaforos
  sem_close(0);
 112:	4501                	li	a0,0
 114:	00000097          	auipc	ra,0x0
 118:	392080e7          	jalr	914(ra) # 4a6 <sem_close>
  sem_close(1);
 11c:	4505                	li	a0,1
 11e:	00000097          	auipc	ra,0x0
 122:	388080e7          	jalr	904(ra) # 4a6 <sem_close>

  exit(0);
 126:	4501                	li	a0,0
 128:	00000097          	auipc	ra,0x0
 12c:	2c6080e7          	jalr	710(ra) # 3ee <exit>
    printf("Error in fork\n");
 130:	00001517          	auipc	a0,0x1
 134:	85050513          	addi	a0,a0,-1968 # 980 <malloc+0x13c>
 138:	00000097          	auipc	ra,0x0
 13c:	64e080e7          	jalr	1614(ra) # 786 <printf>
    exit(1);
 140:	4505                	li	a0,1
 142:	00000097          	auipc	ra,0x0
 146:	2ac080e7          	jalr	684(ra) # 3ee <exit>
        exit(1);
 14a:	4505                	li	a0,1
 14c:	00000097          	auipc	ra,0x0
 150:	2a2080e7          	jalr	674(ra) # 3ee <exit>
        exit(1);
 154:	4505                	li	a0,1
 156:	00000097          	auipc	ra,0x0
 15a:	298080e7          	jalr	664(ra) # 3ee <exit>

000000000000015e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 15e:	1141                	addi	sp,sp,-16
 160:	e406                	sd	ra,8(sp)
 162:	e022                	sd	s0,0(sp)
 164:	0800                	addi	s0,sp,16
  extern int main();
  main();
 166:	00000097          	auipc	ra,0x0
 16a:	e9a080e7          	jalr	-358(ra) # 0 <main>
  exit(0);
 16e:	4501                	li	a0,0
 170:	00000097          	auipc	ra,0x0
 174:	27e080e7          	jalr	638(ra) # 3ee <exit>

0000000000000178 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 178:	1141                	addi	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17e:	87aa                	mv	a5,a0
 180:	0585                	addi	a1,a1,1
 182:	0785                	addi	a5,a5,1
 184:	fff5c703          	lbu	a4,-1(a1)
 188:	fee78fa3          	sb	a4,-1(a5)
 18c:	fb75                	bnez	a4,180 <strcpy+0x8>
    ;
  return os;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret

0000000000000194 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 194:	1141                	addi	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 19a:	00054783          	lbu	a5,0(a0)
 19e:	cb91                	beqz	a5,1b2 <strcmp+0x1e>
 1a0:	0005c703          	lbu	a4,0(a1)
 1a4:	00f71763          	bne	a4,a5,1b2 <strcmp+0x1e>
    p++, q++;
 1a8:	0505                	addi	a0,a0,1
 1aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ac:	00054783          	lbu	a5,0(a0)
 1b0:	fbe5                	bnez	a5,1a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1b2:	0005c503          	lbu	a0,0(a1)
}
 1b6:	40a7853b          	subw	a0,a5,a0
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf91                	beqz	a5,1e6 <strlen+0x26>
 1cc:	0505                	addi	a0,a0,1
 1ce:	87aa                	mv	a5,a0
 1d0:	4685                	li	a3,1
 1d2:	9e89                	subw	a3,a3,a0
 1d4:	00f6853b          	addw	a0,a3,a5
 1d8:	0785                	addi	a5,a5,1
 1da:	fff7c703          	lbu	a4,-1(a5)
 1de:	fb7d                	bnez	a4,1d4 <strlen+0x14>
    ;
  return n;
}
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret
  for(n = 0; s[n]; n++)
 1e6:	4501                	li	a0,0
 1e8:	bfe5                	j	1e0 <strlen+0x20>

00000000000001ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f0:	ce09                	beqz	a2,20a <memset+0x20>
 1f2:	87aa                	mv	a5,a0
 1f4:	fff6071b          	addiw	a4,a2,-1
 1f8:	1702                	slli	a4,a4,0x20
 1fa:	9301                	srli	a4,a4,0x20
 1fc:	0705                	addi	a4,a4,1
 1fe:	972a                	add	a4,a4,a0
    cdst[i] = c;
 200:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 204:	0785                	addi	a5,a5,1
 206:	fee79de3          	bne	a5,a4,200 <memset+0x16>
  }
  return dst;
}
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret

0000000000000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  for(; *s; s++)
 216:	00054783          	lbu	a5,0(a0)
 21a:	cb99                	beqz	a5,230 <strchr+0x20>
    if(*s == c)
 21c:	00f58763          	beq	a1,a5,22a <strchr+0x1a>
  for(; *s; s++)
 220:	0505                	addi	a0,a0,1
 222:	00054783          	lbu	a5,0(a0)
 226:	fbfd                	bnez	a5,21c <strchr+0xc>
      return (char*)s;
  return 0;
 228:	4501                	li	a0,0
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
  return 0;
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <strchr+0x1a>

0000000000000234 <gets>:

char*
gets(char *buf, int max)
{
 234:	711d                	addi	sp,sp,-96
 236:	ec86                	sd	ra,88(sp)
 238:	e8a2                	sd	s0,80(sp)
 23a:	e4a6                	sd	s1,72(sp)
 23c:	e0ca                	sd	s2,64(sp)
 23e:	fc4e                	sd	s3,56(sp)
 240:	f852                	sd	s4,48(sp)
 242:	f456                	sd	s5,40(sp)
 244:	f05a                	sd	s6,32(sp)
 246:	ec5e                	sd	s7,24(sp)
 248:	1080                	addi	s0,sp,96
 24a:	8baa                	mv	s7,a0
 24c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24e:	892a                	mv	s2,a0
 250:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 252:	4aa9                	li	s5,10
 254:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 256:	89a6                	mv	s3,s1
 258:	2485                	addiw	s1,s1,1
 25a:	0344d863          	bge	s1,s4,28a <gets+0x56>
    cc = read(0, &c, 1);
 25e:	4605                	li	a2,1
 260:	faf40593          	addi	a1,s0,-81
 264:	4501                	li	a0,0
 266:	00000097          	auipc	ra,0x0
 26a:	1a0080e7          	jalr	416(ra) # 406 <read>
    if(cc < 1)
 26e:	00a05e63          	blez	a0,28a <gets+0x56>
    buf[i++] = c;
 272:	faf44783          	lbu	a5,-81(s0)
 276:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 27a:	01578763          	beq	a5,s5,288 <gets+0x54>
 27e:	0905                	addi	s2,s2,1
 280:	fd679be3          	bne	a5,s6,256 <gets+0x22>
  for(i=0; i+1 < max; ){
 284:	89a6                	mv	s3,s1
 286:	a011                	j	28a <gets+0x56>
 288:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 28a:	99de                	add	s3,s3,s7
 28c:	00098023          	sb	zero,0(s3)
  return buf;
}
 290:	855e                	mv	a0,s7
 292:	60e6                	ld	ra,88(sp)
 294:	6446                	ld	s0,80(sp)
 296:	64a6                	ld	s1,72(sp)
 298:	6906                	ld	s2,64(sp)
 29a:	79e2                	ld	s3,56(sp)
 29c:	7a42                	ld	s4,48(sp)
 29e:	7aa2                	ld	s5,40(sp)
 2a0:	7b02                	ld	s6,32(sp)
 2a2:	6be2                	ld	s7,24(sp)
 2a4:	6125                	addi	sp,sp,96
 2a6:	8082                	ret

00000000000002a8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a8:	1101                	addi	sp,sp,-32
 2aa:	ec06                	sd	ra,24(sp)
 2ac:	e822                	sd	s0,16(sp)
 2ae:	e426                	sd	s1,8(sp)
 2b0:	e04a                	sd	s2,0(sp)
 2b2:	1000                	addi	s0,sp,32
 2b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	4581                	li	a1,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	176080e7          	jalr	374(ra) # 42e <open>
  if(fd < 0)
 2c0:	02054563          	bltz	a0,2ea <stat+0x42>
 2c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2c6:	85ca                	mv	a1,s2
 2c8:	00000097          	auipc	ra,0x0
 2cc:	17e080e7          	jalr	382(ra) # 446 <fstat>
 2d0:	892a                	mv	s2,a0
  close(fd);
 2d2:	8526                	mv	a0,s1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	142080e7          	jalr	322(ra) # 416 <close>
  return r;
}
 2dc:	854a                	mv	a0,s2
 2de:	60e2                	ld	ra,24(sp)
 2e0:	6442                	ld	s0,16(sp)
 2e2:	64a2                	ld	s1,8(sp)
 2e4:	6902                	ld	s2,0(sp)
 2e6:	6105                	addi	sp,sp,32
 2e8:	8082                	ret
    return -1;
 2ea:	597d                	li	s2,-1
 2ec:	bfc5                	j	2dc <stat+0x34>

00000000000002ee <atoi>:

int
atoi(const char *s)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f4:	00054603          	lbu	a2,0(a0)
 2f8:	fd06079b          	addiw	a5,a2,-48
 2fc:	0ff7f793          	andi	a5,a5,255
 300:	4725                	li	a4,9
 302:	02f76963          	bltu	a4,a5,334 <atoi+0x46>
 306:	86aa                	mv	a3,a0
  n = 0;
 308:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 30a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 30c:	0685                	addi	a3,a3,1
 30e:	0025179b          	slliw	a5,a0,0x2
 312:	9fa9                	addw	a5,a5,a0
 314:	0017979b          	slliw	a5,a5,0x1
 318:	9fb1                	addw	a5,a5,a2
 31a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 31e:	0006c603          	lbu	a2,0(a3)
 322:	fd06071b          	addiw	a4,a2,-48
 326:	0ff77713          	andi	a4,a4,255
 32a:	fee5f1e3          	bgeu	a1,a4,30c <atoi+0x1e>
  return n;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  n = 0;
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <atoi+0x40>

0000000000000338 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 33e:	02b57663          	bgeu	a0,a1,36a <memmove+0x32>
    while(n-- > 0)
 342:	02c05163          	blez	a2,364 <memmove+0x2c>
 346:	fff6079b          	addiw	a5,a2,-1
 34a:	1782                	slli	a5,a5,0x20
 34c:	9381                	srli	a5,a5,0x20
 34e:	0785                	addi	a5,a5,1
 350:	97aa                	add	a5,a5,a0
  dst = vdst;
 352:	872a                	mv	a4,a0
      *dst++ = *src++;
 354:	0585                	addi	a1,a1,1
 356:	0705                	addi	a4,a4,1
 358:	fff5c683          	lbu	a3,-1(a1)
 35c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 360:	fee79ae3          	bne	a5,a4,354 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
    dst += n;
 36a:	00c50733          	add	a4,a0,a2
    src += n;
 36e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 370:	fec05ae3          	blez	a2,364 <memmove+0x2c>
 374:	fff6079b          	addiw	a5,a2,-1
 378:	1782                	slli	a5,a5,0x20
 37a:	9381                	srli	a5,a5,0x20
 37c:	fff7c793          	not	a5,a5
 380:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 382:	15fd                	addi	a1,a1,-1
 384:	177d                	addi	a4,a4,-1
 386:	0005c683          	lbu	a3,0(a1)
 38a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 38e:	fee79ae3          	bne	a5,a4,382 <memmove+0x4a>
 392:	bfc9                	j	364 <memmove+0x2c>

0000000000000394 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 394:	1141                	addi	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 39a:	ca05                	beqz	a2,3ca <memcmp+0x36>
 39c:	fff6069b          	addiw	a3,a2,-1
 3a0:	1682                	slli	a3,a3,0x20
 3a2:	9281                	srli	a3,a3,0x20
 3a4:	0685                	addi	a3,a3,1
 3a6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3a8:	00054783          	lbu	a5,0(a0)
 3ac:	0005c703          	lbu	a4,0(a1)
 3b0:	00e79863          	bne	a5,a4,3c0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3b4:	0505                	addi	a0,a0,1
    p2++;
 3b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3b8:	fed518e3          	bne	a0,a3,3a8 <memcmp+0x14>
  }
  return 0;
 3bc:	4501                	li	a0,0
 3be:	a019                	j	3c4 <memcmp+0x30>
      return *p1 - *p2;
 3c0:	40e7853b          	subw	a0,a5,a4
}
 3c4:	6422                	ld	s0,8(sp)
 3c6:	0141                	addi	sp,sp,16
 3c8:	8082                	ret
  return 0;
 3ca:	4501                	li	a0,0
 3cc:	bfe5                	j	3c4 <memcmp+0x30>

00000000000003ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ce:	1141                	addi	sp,sp,-16
 3d0:	e406                	sd	ra,8(sp)
 3d2:	e022                	sd	s0,0(sp)
 3d4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3d6:	00000097          	auipc	ra,0x0
 3da:	f62080e7          	jalr	-158(ra) # 338 <memmove>
}
 3de:	60a2                	ld	ra,8(sp)
 3e0:	6402                	ld	s0,0(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e6:	4885                	li	a7,1
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ee:	4889                	li	a7,2
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f6:	488d                	li	a7,3
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3fe:	4891                	li	a7,4
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <read>:
.global read
read:
 li a7, SYS_read
 406:	4895                	li	a7,5
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <write>:
.global write
write:
 li a7, SYS_write
 40e:	48c1                	li	a7,16
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <close>:
.global close
close:
 li a7, SYS_close
 416:	48d5                	li	a7,21
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <kill>:
.global kill
kill:
 li a7, SYS_kill
 41e:	4899                	li	a7,6
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <exec>:
.global exec
exec:
 li a7, SYS_exec
 426:	489d                	li	a7,7
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <open>:
.global open
open:
 li a7, SYS_open
 42e:	48bd                	li	a7,15
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 436:	48c5                	li	a7,17
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 43e:	48c9                	li	a7,18
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 446:	48a1                	li	a7,8
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <link>:
.global link
link:
 li a7, SYS_link
 44e:	48cd                	li	a7,19
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 456:	48d1                	li	a7,20
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 45e:	48a5                	li	a7,9
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <dup>:
.global dup
dup:
 li a7, SYS_dup
 466:	48a9                	li	a7,10
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 46e:	48ad                	li	a7,11
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 476:	48b1                	li	a7,12
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 47e:	48b5                	li	a7,13
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 486:	48b9                	li	a7,14
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 48e:	48d9                	li	a7,22
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <sem_up>:
.global sem_up
sem_up:
 li a7, SYS_sem_up
 496:	48dd                	li	a7,23
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <sem_down>:
.global sem_down
sem_down:
 li a7, SYS_sem_down
 49e:	48e1                	li	a7,24
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 4a6:	48e5                	li	a7,25
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ae:	1101                	addi	sp,sp,-32
 4b0:	ec06                	sd	ra,24(sp)
 4b2:	e822                	sd	s0,16(sp)
 4b4:	1000                	addi	s0,sp,32
 4b6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4ba:	4605                	li	a2,1
 4bc:	fef40593          	addi	a1,s0,-17
 4c0:	00000097          	auipc	ra,0x0
 4c4:	f4e080e7          	jalr	-178(ra) # 40e <write>
}
 4c8:	60e2                	ld	ra,24(sp)
 4ca:	6442                	ld	s0,16(sp)
 4cc:	6105                	addi	sp,sp,32
 4ce:	8082                	ret

00000000000004d0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4d0:	7139                	addi	sp,sp,-64
 4d2:	fc06                	sd	ra,56(sp)
 4d4:	f822                	sd	s0,48(sp)
 4d6:	f426                	sd	s1,40(sp)
 4d8:	f04a                	sd	s2,32(sp)
 4da:	ec4e                	sd	s3,24(sp)
 4dc:	0080                	addi	s0,sp,64
 4de:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e0:	c299                	beqz	a3,4e6 <printint+0x16>
 4e2:	0805c863          	bltz	a1,572 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e6:	2581                	sext.w	a1,a1
  neg = 0;
 4e8:	4881                	li	a7,0
 4ea:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4ee:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4f0:	2601                	sext.w	a2,a2
 4f2:	00000517          	auipc	a0,0x0
 4f6:	4ae50513          	addi	a0,a0,1198 # 9a0 <digits>
 4fa:	883a                	mv	a6,a4
 4fc:	2705                	addiw	a4,a4,1
 4fe:	02c5f7bb          	remuw	a5,a1,a2
 502:	1782                	slli	a5,a5,0x20
 504:	9381                	srli	a5,a5,0x20
 506:	97aa                	add	a5,a5,a0
 508:	0007c783          	lbu	a5,0(a5)
 50c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 510:	0005879b          	sext.w	a5,a1
 514:	02c5d5bb          	divuw	a1,a1,a2
 518:	0685                	addi	a3,a3,1
 51a:	fec7f0e3          	bgeu	a5,a2,4fa <printint+0x2a>
  if(neg)
 51e:	00088b63          	beqz	a7,534 <printint+0x64>
    buf[i++] = '-';
 522:	fd040793          	addi	a5,s0,-48
 526:	973e                	add	a4,a4,a5
 528:	02d00793          	li	a5,45
 52c:	fef70823          	sb	a5,-16(a4)
 530:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 534:	02e05863          	blez	a4,564 <printint+0x94>
 538:	fc040793          	addi	a5,s0,-64
 53c:	00e78933          	add	s2,a5,a4
 540:	fff78993          	addi	s3,a5,-1
 544:	99ba                	add	s3,s3,a4
 546:	377d                	addiw	a4,a4,-1
 548:	1702                	slli	a4,a4,0x20
 54a:	9301                	srli	a4,a4,0x20
 54c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 550:	fff94583          	lbu	a1,-1(s2)
 554:	8526                	mv	a0,s1
 556:	00000097          	auipc	ra,0x0
 55a:	f58080e7          	jalr	-168(ra) # 4ae <putc>
  while(--i >= 0)
 55e:	197d                	addi	s2,s2,-1
 560:	ff3918e3          	bne	s2,s3,550 <printint+0x80>
}
 564:	70e2                	ld	ra,56(sp)
 566:	7442                	ld	s0,48(sp)
 568:	74a2                	ld	s1,40(sp)
 56a:	7902                	ld	s2,32(sp)
 56c:	69e2                	ld	s3,24(sp)
 56e:	6121                	addi	sp,sp,64
 570:	8082                	ret
    x = -xx;
 572:	40b005bb          	negw	a1,a1
    neg = 1;
 576:	4885                	li	a7,1
    x = -xx;
 578:	bf8d                	j	4ea <printint+0x1a>

000000000000057a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 57a:	7119                	addi	sp,sp,-128
 57c:	fc86                	sd	ra,120(sp)
 57e:	f8a2                	sd	s0,112(sp)
 580:	f4a6                	sd	s1,104(sp)
 582:	f0ca                	sd	s2,96(sp)
 584:	ecce                	sd	s3,88(sp)
 586:	e8d2                	sd	s4,80(sp)
 588:	e4d6                	sd	s5,72(sp)
 58a:	e0da                	sd	s6,64(sp)
 58c:	fc5e                	sd	s7,56(sp)
 58e:	f862                	sd	s8,48(sp)
 590:	f466                	sd	s9,40(sp)
 592:	f06a                	sd	s10,32(sp)
 594:	ec6e                	sd	s11,24(sp)
 596:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 598:	0005c903          	lbu	s2,0(a1)
 59c:	18090f63          	beqz	s2,73a <vprintf+0x1c0>
 5a0:	8aaa                	mv	s5,a0
 5a2:	8b32                	mv	s6,a2
 5a4:	00158493          	addi	s1,a1,1
  state = 0;
 5a8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5aa:	02500a13          	li	s4,37
      if(c == 'd'){
 5ae:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5b2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5b6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5ba:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5be:	00000b97          	auipc	s7,0x0
 5c2:	3e2b8b93          	addi	s7,s7,994 # 9a0 <digits>
 5c6:	a839                	j	5e4 <vprintf+0x6a>
        putc(fd, c);
 5c8:	85ca                	mv	a1,s2
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	ee2080e7          	jalr	-286(ra) # 4ae <putc>
 5d4:	a019                	j	5da <vprintf+0x60>
    } else if(state == '%'){
 5d6:	01498f63          	beq	s3,s4,5f4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5da:	0485                	addi	s1,s1,1
 5dc:	fff4c903          	lbu	s2,-1(s1)
 5e0:	14090d63          	beqz	s2,73a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5e4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5e8:	fe0997e3          	bnez	s3,5d6 <vprintf+0x5c>
      if(c == '%'){
 5ec:	fd479ee3          	bne	a5,s4,5c8 <vprintf+0x4e>
        state = '%';
 5f0:	89be                	mv	s3,a5
 5f2:	b7e5                	j	5da <vprintf+0x60>
      if(c == 'd'){
 5f4:	05878063          	beq	a5,s8,634 <vprintf+0xba>
      } else if(c == 'l') {
 5f8:	05978c63          	beq	a5,s9,650 <vprintf+0xd6>
      } else if(c == 'x') {
 5fc:	07a78863          	beq	a5,s10,66c <vprintf+0xf2>
      } else if(c == 'p') {
 600:	09b78463          	beq	a5,s11,688 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 604:	07300713          	li	a4,115
 608:	0ce78663          	beq	a5,a4,6d4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60c:	06300713          	li	a4,99
 610:	0ee78e63          	beq	a5,a4,70c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 614:	11478863          	beq	a5,s4,724 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 618:	85d2                	mv	a1,s4
 61a:	8556                	mv	a0,s5
 61c:	00000097          	auipc	ra,0x0
 620:	e92080e7          	jalr	-366(ra) # 4ae <putc>
        putc(fd, c);
 624:	85ca                	mv	a1,s2
 626:	8556                	mv	a0,s5
 628:	00000097          	auipc	ra,0x0
 62c:	e86080e7          	jalr	-378(ra) # 4ae <putc>
      }
      state = 0;
 630:	4981                	li	s3,0
 632:	b765                	j	5da <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 634:	008b0913          	addi	s2,s6,8
 638:	4685                	li	a3,1
 63a:	4629                	li	a2,10
 63c:	000b2583          	lw	a1,0(s6)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	e8e080e7          	jalr	-370(ra) # 4d0 <printint>
 64a:	8b4a                	mv	s6,s2
      state = 0;
 64c:	4981                	li	s3,0
 64e:	b771                	j	5da <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 650:	008b0913          	addi	s2,s6,8
 654:	4681                	li	a3,0
 656:	4629                	li	a2,10
 658:	000b2583          	lw	a1,0(s6)
 65c:	8556                	mv	a0,s5
 65e:	00000097          	auipc	ra,0x0
 662:	e72080e7          	jalr	-398(ra) # 4d0 <printint>
 666:	8b4a                	mv	s6,s2
      state = 0;
 668:	4981                	li	s3,0
 66a:	bf85                	j	5da <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 66c:	008b0913          	addi	s2,s6,8
 670:	4681                	li	a3,0
 672:	4641                	li	a2,16
 674:	000b2583          	lw	a1,0(s6)
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	e56080e7          	jalr	-426(ra) # 4d0 <printint>
 682:	8b4a                	mv	s6,s2
      state = 0;
 684:	4981                	li	s3,0
 686:	bf91                	j	5da <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 688:	008b0793          	addi	a5,s6,8
 68c:	f8f43423          	sd	a5,-120(s0)
 690:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 694:	03000593          	li	a1,48
 698:	8556                	mv	a0,s5
 69a:	00000097          	auipc	ra,0x0
 69e:	e14080e7          	jalr	-492(ra) # 4ae <putc>
  putc(fd, 'x');
 6a2:	85ea                	mv	a1,s10
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e08080e7          	jalr	-504(ra) # 4ae <putc>
 6ae:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6b0:	03c9d793          	srli	a5,s3,0x3c
 6b4:	97de                	add	a5,a5,s7
 6b6:	0007c583          	lbu	a1,0(a5)
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	df2080e7          	jalr	-526(ra) # 4ae <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6c4:	0992                	slli	s3,s3,0x4
 6c6:	397d                	addiw	s2,s2,-1
 6c8:	fe0914e3          	bnez	s2,6b0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6cc:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	b721                	j	5da <vprintf+0x60>
        s = va_arg(ap, char*);
 6d4:	008b0993          	addi	s3,s6,8
 6d8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6dc:	02090163          	beqz	s2,6fe <vprintf+0x184>
        while(*s != 0){
 6e0:	00094583          	lbu	a1,0(s2)
 6e4:	c9a1                	beqz	a1,734 <vprintf+0x1ba>
          putc(fd, *s);
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	dc6080e7          	jalr	-570(ra) # 4ae <putc>
          s++;
 6f0:	0905                	addi	s2,s2,1
        while(*s != 0){
 6f2:	00094583          	lbu	a1,0(s2)
 6f6:	f9e5                	bnez	a1,6e6 <vprintf+0x16c>
        s = va_arg(ap, char*);
 6f8:	8b4e                	mv	s6,s3
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	bdf9                	j	5da <vprintf+0x60>
          s = "(null)";
 6fe:	00000917          	auipc	s2,0x0
 702:	29a90913          	addi	s2,s2,666 # 998 <malloc+0x154>
        while(*s != 0){
 706:	02800593          	li	a1,40
 70a:	bff1                	j	6e6 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 70c:	008b0913          	addi	s2,s6,8
 710:	000b4583          	lbu	a1,0(s6)
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	d98080e7          	jalr	-616(ra) # 4ae <putc>
 71e:	8b4a                	mv	s6,s2
      state = 0;
 720:	4981                	li	s3,0
 722:	bd65                	j	5da <vprintf+0x60>
        putc(fd, c);
 724:	85d2                	mv	a1,s4
 726:	8556                	mv	a0,s5
 728:	00000097          	auipc	ra,0x0
 72c:	d86080e7          	jalr	-634(ra) # 4ae <putc>
      state = 0;
 730:	4981                	li	s3,0
 732:	b565                	j	5da <vprintf+0x60>
        s = va_arg(ap, char*);
 734:	8b4e                	mv	s6,s3
      state = 0;
 736:	4981                	li	s3,0
 738:	b54d                	j	5da <vprintf+0x60>
    }
  }
}
 73a:	70e6                	ld	ra,120(sp)
 73c:	7446                	ld	s0,112(sp)
 73e:	74a6                	ld	s1,104(sp)
 740:	7906                	ld	s2,96(sp)
 742:	69e6                	ld	s3,88(sp)
 744:	6a46                	ld	s4,80(sp)
 746:	6aa6                	ld	s5,72(sp)
 748:	6b06                	ld	s6,64(sp)
 74a:	7be2                	ld	s7,56(sp)
 74c:	7c42                	ld	s8,48(sp)
 74e:	7ca2                	ld	s9,40(sp)
 750:	7d02                	ld	s10,32(sp)
 752:	6de2                	ld	s11,24(sp)
 754:	6109                	addi	sp,sp,128
 756:	8082                	ret

0000000000000758 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 758:	715d                	addi	sp,sp,-80
 75a:	ec06                	sd	ra,24(sp)
 75c:	e822                	sd	s0,16(sp)
 75e:	1000                	addi	s0,sp,32
 760:	e010                	sd	a2,0(s0)
 762:	e414                	sd	a3,8(s0)
 764:	e818                	sd	a4,16(s0)
 766:	ec1c                	sd	a5,24(s0)
 768:	03043023          	sd	a6,32(s0)
 76c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 770:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 774:	8622                	mv	a2,s0
 776:	00000097          	auipc	ra,0x0
 77a:	e04080e7          	jalr	-508(ra) # 57a <vprintf>
}
 77e:	60e2                	ld	ra,24(sp)
 780:	6442                	ld	s0,16(sp)
 782:	6161                	addi	sp,sp,80
 784:	8082                	ret

0000000000000786 <printf>:

void
printf(const char *fmt, ...)
{
 786:	711d                	addi	sp,sp,-96
 788:	ec06                	sd	ra,24(sp)
 78a:	e822                	sd	s0,16(sp)
 78c:	1000                	addi	s0,sp,32
 78e:	e40c                	sd	a1,8(s0)
 790:	e810                	sd	a2,16(s0)
 792:	ec14                	sd	a3,24(s0)
 794:	f018                	sd	a4,32(s0)
 796:	f41c                	sd	a5,40(s0)
 798:	03043823          	sd	a6,48(s0)
 79c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a0:	00840613          	addi	a2,s0,8
 7a4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a8:	85aa                	mv	a1,a0
 7aa:	4505                	li	a0,1
 7ac:	00000097          	auipc	ra,0x0
 7b0:	dce080e7          	jalr	-562(ra) # 57a <vprintf>
}
 7b4:	60e2                	ld	ra,24(sp)
 7b6:	6442                	ld	s0,16(sp)
 7b8:	6125                	addi	sp,sp,96
 7ba:	8082                	ret

00000000000007bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7bc:	1141                	addi	sp,sp,-16
 7be:	e422                	sd	s0,8(sp)
 7c0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c6:	00001797          	auipc	a5,0x1
 7ca:	83a7b783          	ld	a5,-1990(a5) # 1000 <freep>
 7ce:	a805                	j	7fe <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7d0:	4618                	lw	a4,8(a2)
 7d2:	9db9                	addw	a1,a1,a4
 7d4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	6398                	ld	a4,0(a5)
 7da:	6318                	ld	a4,0(a4)
 7dc:	fee53823          	sd	a4,-16(a0)
 7e0:	a091                	j	824 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7e2:	ff852703          	lw	a4,-8(a0)
 7e6:	9e39                	addw	a2,a2,a4
 7e8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7ea:	ff053703          	ld	a4,-16(a0)
 7ee:	e398                	sd	a4,0(a5)
 7f0:	a099                	j	836 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f2:	6398                	ld	a4,0(a5)
 7f4:	00e7e463          	bltu	a5,a4,7fc <free+0x40>
 7f8:	00e6ea63          	bltu	a3,a4,80c <free+0x50>
{
 7fc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fe:	fed7fae3          	bgeu	a5,a3,7f2 <free+0x36>
 802:	6398                	ld	a4,0(a5)
 804:	00e6e463          	bltu	a3,a4,80c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 808:	fee7eae3          	bltu	a5,a4,7fc <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 80c:	ff852583          	lw	a1,-8(a0)
 810:	6390                	ld	a2,0(a5)
 812:	02059713          	slli	a4,a1,0x20
 816:	9301                	srli	a4,a4,0x20
 818:	0712                	slli	a4,a4,0x4
 81a:	9736                	add	a4,a4,a3
 81c:	fae60ae3          	beq	a2,a4,7d0 <free+0x14>
    bp->s.ptr = p->s.ptr;
 820:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 824:	4790                	lw	a2,8(a5)
 826:	02061713          	slli	a4,a2,0x20
 82a:	9301                	srli	a4,a4,0x20
 82c:	0712                	slli	a4,a4,0x4
 82e:	973e                	add	a4,a4,a5
 830:	fae689e3          	beq	a3,a4,7e2 <free+0x26>
  } else
    p->s.ptr = bp;
 834:	e394                	sd	a3,0(a5)
  freep = p;
 836:	00000717          	auipc	a4,0x0
 83a:	7cf73523          	sd	a5,1994(a4) # 1000 <freep>
}
 83e:	6422                	ld	s0,8(sp)
 840:	0141                	addi	sp,sp,16
 842:	8082                	ret

0000000000000844 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 844:	7139                	addi	sp,sp,-64
 846:	fc06                	sd	ra,56(sp)
 848:	f822                	sd	s0,48(sp)
 84a:	f426                	sd	s1,40(sp)
 84c:	f04a                	sd	s2,32(sp)
 84e:	ec4e                	sd	s3,24(sp)
 850:	e852                	sd	s4,16(sp)
 852:	e456                	sd	s5,8(sp)
 854:	e05a                	sd	s6,0(sp)
 856:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 858:	02051493          	slli	s1,a0,0x20
 85c:	9081                	srli	s1,s1,0x20
 85e:	04bd                	addi	s1,s1,15
 860:	8091                	srli	s1,s1,0x4
 862:	0014899b          	addiw	s3,s1,1
 866:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 868:	00000517          	auipc	a0,0x0
 86c:	79853503          	ld	a0,1944(a0) # 1000 <freep>
 870:	c515                	beqz	a0,89c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 872:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 874:	4798                	lw	a4,8(a5)
 876:	02977f63          	bgeu	a4,s1,8b4 <malloc+0x70>
 87a:	8a4e                	mv	s4,s3
 87c:	0009871b          	sext.w	a4,s3
 880:	6685                	lui	a3,0x1
 882:	00d77363          	bgeu	a4,a3,888 <malloc+0x44>
 886:	6a05                	lui	s4,0x1
 888:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 88c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 890:	00000917          	auipc	s2,0x0
 894:	77090913          	addi	s2,s2,1904 # 1000 <freep>
  if(p == (char*)-1)
 898:	5afd                	li	s5,-1
 89a:	a88d                	j	90c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 89c:	00000797          	auipc	a5,0x0
 8a0:	77478793          	addi	a5,a5,1908 # 1010 <base>
 8a4:	00000717          	auipc	a4,0x0
 8a8:	74f73e23          	sd	a5,1884(a4) # 1000 <freep>
 8ac:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ae:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8b2:	b7e1                	j	87a <malloc+0x36>
      if(p->s.size == nunits)
 8b4:	02e48b63          	beq	s1,a4,8ea <malloc+0xa6>
        p->s.size -= nunits;
 8b8:	4137073b          	subw	a4,a4,s3
 8bc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8be:	1702                	slli	a4,a4,0x20
 8c0:	9301                	srli	a4,a4,0x20
 8c2:	0712                	slli	a4,a4,0x4
 8c4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8c6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ca:	00000717          	auipc	a4,0x0
 8ce:	72a73b23          	sd	a0,1846(a4) # 1000 <freep>
      return (void*)(p + 1);
 8d2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8d6:	70e2                	ld	ra,56(sp)
 8d8:	7442                	ld	s0,48(sp)
 8da:	74a2                	ld	s1,40(sp)
 8dc:	7902                	ld	s2,32(sp)
 8de:	69e2                	ld	s3,24(sp)
 8e0:	6a42                	ld	s4,16(sp)
 8e2:	6aa2                	ld	s5,8(sp)
 8e4:	6b02                	ld	s6,0(sp)
 8e6:	6121                	addi	sp,sp,64
 8e8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8ea:	6398                	ld	a4,0(a5)
 8ec:	e118                	sd	a4,0(a0)
 8ee:	bff1                	j	8ca <malloc+0x86>
  hp->s.size = nu;
 8f0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8f4:	0541                	addi	a0,a0,16
 8f6:	00000097          	auipc	ra,0x0
 8fa:	ec6080e7          	jalr	-314(ra) # 7bc <free>
  return freep;
 8fe:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 902:	d971                	beqz	a0,8d6 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 904:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 906:	4798                	lw	a4,8(a5)
 908:	fa9776e3          	bgeu	a4,s1,8b4 <malloc+0x70>
    if(p == freep)
 90c:	00093703          	ld	a4,0(s2)
 910:	853e                	mv	a0,a5
 912:	fef719e3          	bne	a4,a5,904 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 916:	8552                	mv	a0,s4
 918:	00000097          	auipc	ra,0x0
 91c:	b5e080e7          	jalr	-1186(ra) # 476 <sbrk>
  if(p == (char*)-1)
 920:	fd5518e3          	bne	a0,s5,8f0 <malloc+0xac>
        return 0;
 924:	4501                	li	a0,0
 926:	bf45                	j	8d6 <malloc+0x92>
