
user/_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include <stddef.h>

int
main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  //sem_open(atoi(argv[1]),atoi(argv[2]));
  if (sem_open(0,0) == 0) { exit(0); }
   8:	4581                	li	a1,0
   a:	4501                	li	a0,0
   c:	00000097          	auipc	ra,0x0
  10:	378080e7          	jalr	888(ra) # 384 <sem_open>
  14:	e509                	bnez	a0,1e <main+0x1e>
  16:	00000097          	auipc	ra,0x0
  1a:	2ce080e7          	jalr	718(ra) # 2e4 <exit>
  if (sem_open(1,0) == 0) { exit(0); }
  1e:	4581                	li	a1,0
  20:	4505                	li	a0,1
  22:	00000097          	auipc	ra,0x0
  26:	362080e7          	jalr	866(ra) # 384 <sem_open>
  2a:	e509                	bnez	a0,34 <main+0x34>
  2c:	00000097          	auipc	ra,0x0
  30:	2b8080e7          	jalr	696(ra) # 2e4 <exit>
  sem_up(1);
  34:	4505                	li	a0,1
  36:	00000097          	auipc	ra,0x0
  3a:	356080e7          	jalr	854(ra) # 38c <sem_up>
  sem_open(1,0);
  3e:	4581                	li	a1,0
  40:	4505                	li	a0,1
  42:	00000097          	auipc	ra,0x0
  46:	342080e7          	jalr	834(ra) # 384 <sem_open>
  //   wait(NULL);
  //   //sem_close(0);
  //   //sem_close(1);
  // }
  
  exit(1);
  4a:	4505                	li	a0,1
  4c:	00000097          	auipc	ra,0x0
  50:	298080e7          	jalr	664(ra) # 2e4 <exit>

0000000000000054 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  5c:	00000097          	auipc	ra,0x0
  60:	fa4080e7          	jalr	-92(ra) # 0 <main>
  exit(0);
  64:	4501                	li	a0,0
  66:	00000097          	auipc	ra,0x0
  6a:	27e080e7          	jalr	638(ra) # 2e4 <exit>

000000000000006e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  6e:	1141                	addi	sp,sp,-16
  70:	e422                	sd	s0,8(sp)
  72:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  74:	87aa                	mv	a5,a0
  76:	0585                	addi	a1,a1,1
  78:	0785                	addi	a5,a5,1
  7a:	fff5c703          	lbu	a4,-1(a1)
  7e:	fee78fa3          	sb	a4,-1(a5)
  82:	fb75                	bnez	a4,76 <strcpy+0x8>
    ;
  return os;
}
  84:	6422                	ld	s0,8(sp)
  86:	0141                	addi	sp,sp,16
  88:	8082                	ret

000000000000008a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e422                	sd	s0,8(sp)
  8e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  90:	00054783          	lbu	a5,0(a0)
  94:	cb91                	beqz	a5,a8 <strcmp+0x1e>
  96:	0005c703          	lbu	a4,0(a1)
  9a:	00f71763          	bne	a4,a5,a8 <strcmp+0x1e>
    p++, q++;
  9e:	0505                	addi	a0,a0,1
  a0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	fbe5                	bnez	a5,96 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  a8:	0005c503          	lbu	a0,0(a1)
}
  ac:	40a7853b          	subw	a0,a5,a0
  b0:	6422                	ld	s0,8(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strlen>:

uint
strlen(const char *s)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  bc:	00054783          	lbu	a5,0(a0)
  c0:	cf91                	beqz	a5,dc <strlen+0x26>
  c2:	0505                	addi	a0,a0,1
  c4:	87aa                	mv	a5,a0
  c6:	4685                	li	a3,1
  c8:	9e89                	subw	a3,a3,a0
  ca:	00f6853b          	addw	a0,a3,a5
  ce:	0785                	addi	a5,a5,1
  d0:	fff7c703          	lbu	a4,-1(a5)
  d4:	fb7d                	bnez	a4,ca <strlen+0x14>
    ;
  return n;
}
  d6:	6422                	ld	s0,8(sp)
  d8:	0141                	addi	sp,sp,16
  da:	8082                	ret
  for(n = 0; s[n]; n++)
  dc:	4501                	li	a0,0
  de:	bfe5                	j	d6 <strlen+0x20>

00000000000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	1141                	addi	sp,sp,-16
  e2:	e422                	sd	s0,8(sp)
  e4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e6:	ce09                	beqz	a2,100 <memset+0x20>
  e8:	87aa                	mv	a5,a0
  ea:	fff6071b          	addiw	a4,a2,-1
  ee:	1702                	slli	a4,a4,0x20
  f0:	9301                	srli	a4,a4,0x20
  f2:	0705                	addi	a4,a4,1
  f4:	972a                	add	a4,a4,a0
    cdst[i] = c;
  f6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fa:	0785                	addi	a5,a5,1
  fc:	fee79de3          	bne	a5,a4,f6 <memset+0x16>
  }
  return dst;
}
 100:	6422                	ld	s0,8(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strchr>:

char*
strchr(const char *s, char c)
{
 106:	1141                	addi	sp,sp,-16
 108:	e422                	sd	s0,8(sp)
 10a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10c:	00054783          	lbu	a5,0(a0)
 110:	cb99                	beqz	a5,126 <strchr+0x20>
    if(*s == c)
 112:	00f58763          	beq	a1,a5,120 <strchr+0x1a>
  for(; *s; s++)
 116:	0505                	addi	a0,a0,1
 118:	00054783          	lbu	a5,0(a0)
 11c:	fbfd                	bnez	a5,112 <strchr+0xc>
      return (char*)s;
  return 0;
 11e:	4501                	li	a0,0
}
 120:	6422                	ld	s0,8(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret
  return 0;
 126:	4501                	li	a0,0
 128:	bfe5                	j	120 <strchr+0x1a>

000000000000012a <gets>:

char*
gets(char *buf, int max)
{
 12a:	711d                	addi	sp,sp,-96
 12c:	ec86                	sd	ra,88(sp)
 12e:	e8a2                	sd	s0,80(sp)
 130:	e4a6                	sd	s1,72(sp)
 132:	e0ca                	sd	s2,64(sp)
 134:	fc4e                	sd	s3,56(sp)
 136:	f852                	sd	s4,48(sp)
 138:	f456                	sd	s5,40(sp)
 13a:	f05a                	sd	s6,32(sp)
 13c:	ec5e                	sd	s7,24(sp)
 13e:	1080                	addi	s0,sp,96
 140:	8baa                	mv	s7,a0
 142:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 144:	892a                	mv	s2,a0
 146:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 148:	4aa9                	li	s5,10
 14a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 14c:	89a6                	mv	s3,s1
 14e:	2485                	addiw	s1,s1,1
 150:	0344d863          	bge	s1,s4,180 <gets+0x56>
    cc = read(0, &c, 1);
 154:	4605                	li	a2,1
 156:	faf40593          	addi	a1,s0,-81
 15a:	4501                	li	a0,0
 15c:	00000097          	auipc	ra,0x0
 160:	1a0080e7          	jalr	416(ra) # 2fc <read>
    if(cc < 1)
 164:	00a05e63          	blez	a0,180 <gets+0x56>
    buf[i++] = c;
 168:	faf44783          	lbu	a5,-81(s0)
 16c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 170:	01578763          	beq	a5,s5,17e <gets+0x54>
 174:	0905                	addi	s2,s2,1
 176:	fd679be3          	bne	a5,s6,14c <gets+0x22>
  for(i=0; i+1 < max; ){
 17a:	89a6                	mv	s3,s1
 17c:	a011                	j	180 <gets+0x56>
 17e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 180:	99de                	add	s3,s3,s7
 182:	00098023          	sb	zero,0(s3)
  return buf;
}
 186:	855e                	mv	a0,s7
 188:	60e6                	ld	ra,88(sp)
 18a:	6446                	ld	s0,80(sp)
 18c:	64a6                	ld	s1,72(sp)
 18e:	6906                	ld	s2,64(sp)
 190:	79e2                	ld	s3,56(sp)
 192:	7a42                	ld	s4,48(sp)
 194:	7aa2                	ld	s5,40(sp)
 196:	7b02                	ld	s6,32(sp)
 198:	6be2                	ld	s7,24(sp)
 19a:	6125                	addi	sp,sp,96
 19c:	8082                	ret

000000000000019e <stat>:

int
stat(const char *n, struct stat *st)
{
 19e:	1101                	addi	sp,sp,-32
 1a0:	ec06                	sd	ra,24(sp)
 1a2:	e822                	sd	s0,16(sp)
 1a4:	e426                	sd	s1,8(sp)
 1a6:	e04a                	sd	s2,0(sp)
 1a8:	1000                	addi	s0,sp,32
 1aa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ac:	4581                	li	a1,0
 1ae:	00000097          	auipc	ra,0x0
 1b2:	176080e7          	jalr	374(ra) # 324 <open>
  if(fd < 0)
 1b6:	02054563          	bltz	a0,1e0 <stat+0x42>
 1ba:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1bc:	85ca                	mv	a1,s2
 1be:	00000097          	auipc	ra,0x0
 1c2:	17e080e7          	jalr	382(ra) # 33c <fstat>
 1c6:	892a                	mv	s2,a0
  close(fd);
 1c8:	8526                	mv	a0,s1
 1ca:	00000097          	auipc	ra,0x0
 1ce:	142080e7          	jalr	322(ra) # 30c <close>
  return r;
}
 1d2:	854a                	mv	a0,s2
 1d4:	60e2                	ld	ra,24(sp)
 1d6:	6442                	ld	s0,16(sp)
 1d8:	64a2                	ld	s1,8(sp)
 1da:	6902                	ld	s2,0(sp)
 1dc:	6105                	addi	sp,sp,32
 1de:	8082                	ret
    return -1;
 1e0:	597d                	li	s2,-1
 1e2:	bfc5                	j	1d2 <stat+0x34>

00000000000001e4 <atoi>:

int
atoi(const char *s)
{
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ea:	00054603          	lbu	a2,0(a0)
 1ee:	fd06079b          	addiw	a5,a2,-48
 1f2:	0ff7f793          	andi	a5,a5,255
 1f6:	4725                	li	a4,9
 1f8:	02f76963          	bltu	a4,a5,22a <atoi+0x46>
 1fc:	86aa                	mv	a3,a0
  n = 0;
 1fe:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 200:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 202:	0685                	addi	a3,a3,1
 204:	0025179b          	slliw	a5,a0,0x2
 208:	9fa9                	addw	a5,a5,a0
 20a:	0017979b          	slliw	a5,a5,0x1
 20e:	9fb1                	addw	a5,a5,a2
 210:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 214:	0006c603          	lbu	a2,0(a3)
 218:	fd06071b          	addiw	a4,a2,-48
 21c:	0ff77713          	andi	a4,a4,255
 220:	fee5f1e3          	bgeu	a1,a4,202 <atoi+0x1e>
  return n;
}
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  n = 0;
 22a:	4501                	li	a0,0
 22c:	bfe5                	j	224 <atoi+0x40>

000000000000022e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 234:	02b57663          	bgeu	a0,a1,260 <memmove+0x32>
    while(n-- > 0)
 238:	02c05163          	blez	a2,25a <memmove+0x2c>
 23c:	fff6079b          	addiw	a5,a2,-1
 240:	1782                	slli	a5,a5,0x20
 242:	9381                	srli	a5,a5,0x20
 244:	0785                	addi	a5,a5,1
 246:	97aa                	add	a5,a5,a0
  dst = vdst;
 248:	872a                	mv	a4,a0
      *dst++ = *src++;
 24a:	0585                	addi	a1,a1,1
 24c:	0705                	addi	a4,a4,1
 24e:	fff5c683          	lbu	a3,-1(a1)
 252:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 256:	fee79ae3          	bne	a5,a4,24a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25a:	6422                	ld	s0,8(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret
    dst += n;
 260:	00c50733          	add	a4,a0,a2
    src += n;
 264:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 266:	fec05ae3          	blez	a2,25a <memmove+0x2c>
 26a:	fff6079b          	addiw	a5,a2,-1
 26e:	1782                	slli	a5,a5,0x20
 270:	9381                	srli	a5,a5,0x20
 272:	fff7c793          	not	a5,a5
 276:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 278:	15fd                	addi	a1,a1,-1
 27a:	177d                	addi	a4,a4,-1
 27c:	0005c683          	lbu	a3,0(a1)
 280:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 284:	fee79ae3          	bne	a5,a4,278 <memmove+0x4a>
 288:	bfc9                	j	25a <memmove+0x2c>

000000000000028a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e422                	sd	s0,8(sp)
 28e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 290:	ca05                	beqz	a2,2c0 <memcmp+0x36>
 292:	fff6069b          	addiw	a3,a2,-1
 296:	1682                	slli	a3,a3,0x20
 298:	9281                	srli	a3,a3,0x20
 29a:	0685                	addi	a3,a3,1
 29c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 29e:	00054783          	lbu	a5,0(a0)
 2a2:	0005c703          	lbu	a4,0(a1)
 2a6:	00e79863          	bne	a5,a4,2b6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2aa:	0505                	addi	a0,a0,1
    p2++;
 2ac:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ae:	fed518e3          	bne	a0,a3,29e <memcmp+0x14>
  }
  return 0;
 2b2:	4501                	li	a0,0
 2b4:	a019                	j	2ba <memcmp+0x30>
      return *p1 - *p2;
 2b6:	40e7853b          	subw	a0,a5,a4
}
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
  return 0;
 2c0:	4501                	li	a0,0
 2c2:	bfe5                	j	2ba <memcmp+0x30>

00000000000002c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2cc:	00000097          	auipc	ra,0x0
 2d0:	f62080e7          	jalr	-158(ra) # 22e <memmove>
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2dc:	4885                	li	a7,1
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e4:	4889                	li	a7,2
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ec:	488d                	li	a7,3
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f4:	4891                	li	a7,4
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <read>:
.global read
read:
 li a7, SYS_read
 2fc:	4895                	li	a7,5
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <write>:
.global write
write:
 li a7, SYS_write
 304:	48c1                	li	a7,16
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <close>:
.global close
close:
 li a7, SYS_close
 30c:	48d5                	li	a7,21
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <kill>:
.global kill
kill:
 li a7, SYS_kill
 314:	4899                	li	a7,6
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <exec>:
.global exec
exec:
 li a7, SYS_exec
 31c:	489d                	li	a7,7
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <open>:
.global open
open:
 li a7, SYS_open
 324:	48bd                	li	a7,15
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 32c:	48c5                	li	a7,17
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 334:	48c9                	li	a7,18
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 33c:	48a1                	li	a7,8
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <link>:
.global link
link:
 li a7, SYS_link
 344:	48cd                	li	a7,19
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 34c:	48d1                	li	a7,20
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 354:	48a5                	li	a7,9
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <dup>:
.global dup
dup:
 li a7, SYS_dup
 35c:	48a9                	li	a7,10
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 364:	48ad                	li	a7,11
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 36c:	48b1                	li	a7,12
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 374:	48b5                	li	a7,13
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 37c:	48b9                	li	a7,14
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 384:	48d9                	li	a7,22
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <sem_up>:
.global sem_up
sem_up:
 li a7, SYS_sem_up
 38c:	48dd                	li	a7,23
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <sem_down>:
.global sem_down
sem_down:
 li a7, SYS_sem_down
 394:	48e1                	li	a7,24
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 39c:	48e5                	li	a7,25
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3a4:	1101                	addi	sp,sp,-32
 3a6:	ec06                	sd	ra,24(sp)
 3a8:	e822                	sd	s0,16(sp)
 3aa:	1000                	addi	s0,sp,32
 3ac:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3b0:	4605                	li	a2,1
 3b2:	fef40593          	addi	a1,s0,-17
 3b6:	00000097          	auipc	ra,0x0
 3ba:	f4e080e7          	jalr	-178(ra) # 304 <write>
}
 3be:	60e2                	ld	ra,24(sp)
 3c0:	6442                	ld	s0,16(sp)
 3c2:	6105                	addi	sp,sp,32
 3c4:	8082                	ret

00000000000003c6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c6:	7139                	addi	sp,sp,-64
 3c8:	fc06                	sd	ra,56(sp)
 3ca:	f822                	sd	s0,48(sp)
 3cc:	f426                	sd	s1,40(sp)
 3ce:	f04a                	sd	s2,32(sp)
 3d0:	ec4e                	sd	s3,24(sp)
 3d2:	0080                	addi	s0,sp,64
 3d4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3d6:	c299                	beqz	a3,3dc <printint+0x16>
 3d8:	0805c863          	bltz	a1,468 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3dc:	2581                	sext.w	a1,a1
  neg = 0;
 3de:	4881                	li	a7,0
 3e0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3e4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3e6:	2601                	sext.w	a2,a2
 3e8:	00000517          	auipc	a0,0x0
 3ec:	44050513          	addi	a0,a0,1088 # 828 <digits>
 3f0:	883a                	mv	a6,a4
 3f2:	2705                	addiw	a4,a4,1
 3f4:	02c5f7bb          	remuw	a5,a1,a2
 3f8:	1782                	slli	a5,a5,0x20
 3fa:	9381                	srli	a5,a5,0x20
 3fc:	97aa                	add	a5,a5,a0
 3fe:	0007c783          	lbu	a5,0(a5)
 402:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 406:	0005879b          	sext.w	a5,a1
 40a:	02c5d5bb          	divuw	a1,a1,a2
 40e:	0685                	addi	a3,a3,1
 410:	fec7f0e3          	bgeu	a5,a2,3f0 <printint+0x2a>
  if(neg)
 414:	00088b63          	beqz	a7,42a <printint+0x64>
    buf[i++] = '-';
 418:	fd040793          	addi	a5,s0,-48
 41c:	973e                	add	a4,a4,a5
 41e:	02d00793          	li	a5,45
 422:	fef70823          	sb	a5,-16(a4)
 426:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 42a:	02e05863          	blez	a4,45a <printint+0x94>
 42e:	fc040793          	addi	a5,s0,-64
 432:	00e78933          	add	s2,a5,a4
 436:	fff78993          	addi	s3,a5,-1
 43a:	99ba                	add	s3,s3,a4
 43c:	377d                	addiw	a4,a4,-1
 43e:	1702                	slli	a4,a4,0x20
 440:	9301                	srli	a4,a4,0x20
 442:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 446:	fff94583          	lbu	a1,-1(s2)
 44a:	8526                	mv	a0,s1
 44c:	00000097          	auipc	ra,0x0
 450:	f58080e7          	jalr	-168(ra) # 3a4 <putc>
  while(--i >= 0)
 454:	197d                	addi	s2,s2,-1
 456:	ff3918e3          	bne	s2,s3,446 <printint+0x80>
}
 45a:	70e2                	ld	ra,56(sp)
 45c:	7442                	ld	s0,48(sp)
 45e:	74a2                	ld	s1,40(sp)
 460:	7902                	ld	s2,32(sp)
 462:	69e2                	ld	s3,24(sp)
 464:	6121                	addi	sp,sp,64
 466:	8082                	ret
    x = -xx;
 468:	40b005bb          	negw	a1,a1
    neg = 1;
 46c:	4885                	li	a7,1
    x = -xx;
 46e:	bf8d                	j	3e0 <printint+0x1a>

0000000000000470 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 470:	7119                	addi	sp,sp,-128
 472:	fc86                	sd	ra,120(sp)
 474:	f8a2                	sd	s0,112(sp)
 476:	f4a6                	sd	s1,104(sp)
 478:	f0ca                	sd	s2,96(sp)
 47a:	ecce                	sd	s3,88(sp)
 47c:	e8d2                	sd	s4,80(sp)
 47e:	e4d6                	sd	s5,72(sp)
 480:	e0da                	sd	s6,64(sp)
 482:	fc5e                	sd	s7,56(sp)
 484:	f862                	sd	s8,48(sp)
 486:	f466                	sd	s9,40(sp)
 488:	f06a                	sd	s10,32(sp)
 48a:	ec6e                	sd	s11,24(sp)
 48c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 48e:	0005c903          	lbu	s2,0(a1)
 492:	18090f63          	beqz	s2,630 <vprintf+0x1c0>
 496:	8aaa                	mv	s5,a0
 498:	8b32                	mv	s6,a2
 49a:	00158493          	addi	s1,a1,1
  state = 0;
 49e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4a0:	02500a13          	li	s4,37
      if(c == 'd'){
 4a4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4a8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4ac:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4b0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4b4:	00000b97          	auipc	s7,0x0
 4b8:	374b8b93          	addi	s7,s7,884 # 828 <digits>
 4bc:	a839                	j	4da <vprintf+0x6a>
        putc(fd, c);
 4be:	85ca                	mv	a1,s2
 4c0:	8556                	mv	a0,s5
 4c2:	00000097          	auipc	ra,0x0
 4c6:	ee2080e7          	jalr	-286(ra) # 3a4 <putc>
 4ca:	a019                	j	4d0 <vprintf+0x60>
    } else if(state == '%'){
 4cc:	01498f63          	beq	s3,s4,4ea <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4d0:	0485                	addi	s1,s1,1
 4d2:	fff4c903          	lbu	s2,-1(s1)
 4d6:	14090d63          	beqz	s2,630 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4da:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4de:	fe0997e3          	bnez	s3,4cc <vprintf+0x5c>
      if(c == '%'){
 4e2:	fd479ee3          	bne	a5,s4,4be <vprintf+0x4e>
        state = '%';
 4e6:	89be                	mv	s3,a5
 4e8:	b7e5                	j	4d0 <vprintf+0x60>
      if(c == 'd'){
 4ea:	05878063          	beq	a5,s8,52a <vprintf+0xba>
      } else if(c == 'l') {
 4ee:	05978c63          	beq	a5,s9,546 <vprintf+0xd6>
      } else if(c == 'x') {
 4f2:	07a78863          	beq	a5,s10,562 <vprintf+0xf2>
      } else if(c == 'p') {
 4f6:	09b78463          	beq	a5,s11,57e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4fa:	07300713          	li	a4,115
 4fe:	0ce78663          	beq	a5,a4,5ca <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 502:	06300713          	li	a4,99
 506:	0ee78e63          	beq	a5,a4,602 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 50a:	11478863          	beq	a5,s4,61a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 50e:	85d2                	mv	a1,s4
 510:	8556                	mv	a0,s5
 512:	00000097          	auipc	ra,0x0
 516:	e92080e7          	jalr	-366(ra) # 3a4 <putc>
        putc(fd, c);
 51a:	85ca                	mv	a1,s2
 51c:	8556                	mv	a0,s5
 51e:	00000097          	auipc	ra,0x0
 522:	e86080e7          	jalr	-378(ra) # 3a4 <putc>
      }
      state = 0;
 526:	4981                	li	s3,0
 528:	b765                	j	4d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 52a:	008b0913          	addi	s2,s6,8
 52e:	4685                	li	a3,1
 530:	4629                	li	a2,10
 532:	000b2583          	lw	a1,0(s6)
 536:	8556                	mv	a0,s5
 538:	00000097          	auipc	ra,0x0
 53c:	e8e080e7          	jalr	-370(ra) # 3c6 <printint>
 540:	8b4a                	mv	s6,s2
      state = 0;
 542:	4981                	li	s3,0
 544:	b771                	j	4d0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 546:	008b0913          	addi	s2,s6,8
 54a:	4681                	li	a3,0
 54c:	4629                	li	a2,10
 54e:	000b2583          	lw	a1,0(s6)
 552:	8556                	mv	a0,s5
 554:	00000097          	auipc	ra,0x0
 558:	e72080e7          	jalr	-398(ra) # 3c6 <printint>
 55c:	8b4a                	mv	s6,s2
      state = 0;
 55e:	4981                	li	s3,0
 560:	bf85                	j	4d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 562:	008b0913          	addi	s2,s6,8
 566:	4681                	li	a3,0
 568:	4641                	li	a2,16
 56a:	000b2583          	lw	a1,0(s6)
 56e:	8556                	mv	a0,s5
 570:	00000097          	auipc	ra,0x0
 574:	e56080e7          	jalr	-426(ra) # 3c6 <printint>
 578:	8b4a                	mv	s6,s2
      state = 0;
 57a:	4981                	li	s3,0
 57c:	bf91                	j	4d0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 57e:	008b0793          	addi	a5,s6,8
 582:	f8f43423          	sd	a5,-120(s0)
 586:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 58a:	03000593          	li	a1,48
 58e:	8556                	mv	a0,s5
 590:	00000097          	auipc	ra,0x0
 594:	e14080e7          	jalr	-492(ra) # 3a4 <putc>
  putc(fd, 'x');
 598:	85ea                	mv	a1,s10
 59a:	8556                	mv	a0,s5
 59c:	00000097          	auipc	ra,0x0
 5a0:	e08080e7          	jalr	-504(ra) # 3a4 <putc>
 5a4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5a6:	03c9d793          	srli	a5,s3,0x3c
 5aa:	97de                	add	a5,a5,s7
 5ac:	0007c583          	lbu	a1,0(a5)
 5b0:	8556                	mv	a0,s5
 5b2:	00000097          	auipc	ra,0x0
 5b6:	df2080e7          	jalr	-526(ra) # 3a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5ba:	0992                	slli	s3,s3,0x4
 5bc:	397d                	addiw	s2,s2,-1
 5be:	fe0914e3          	bnez	s2,5a6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5c2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5c6:	4981                	li	s3,0
 5c8:	b721                	j	4d0 <vprintf+0x60>
        s = va_arg(ap, char*);
 5ca:	008b0993          	addi	s3,s6,8
 5ce:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5d2:	02090163          	beqz	s2,5f4 <vprintf+0x184>
        while(*s != 0){
 5d6:	00094583          	lbu	a1,0(s2)
 5da:	c9a1                	beqz	a1,62a <vprintf+0x1ba>
          putc(fd, *s);
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	dc6080e7          	jalr	-570(ra) # 3a4 <putc>
          s++;
 5e6:	0905                	addi	s2,s2,1
        while(*s != 0){
 5e8:	00094583          	lbu	a1,0(s2)
 5ec:	f9e5                	bnez	a1,5dc <vprintf+0x16c>
        s = va_arg(ap, char*);
 5ee:	8b4e                	mv	s6,s3
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	bdf9                	j	4d0 <vprintf+0x60>
          s = "(null)";
 5f4:	00000917          	auipc	s2,0x0
 5f8:	22c90913          	addi	s2,s2,556 # 820 <malloc+0xe6>
        while(*s != 0){
 5fc:	02800593          	li	a1,40
 600:	bff1                	j	5dc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 602:	008b0913          	addi	s2,s6,8
 606:	000b4583          	lbu	a1,0(s6)
 60a:	8556                	mv	a0,s5
 60c:	00000097          	auipc	ra,0x0
 610:	d98080e7          	jalr	-616(ra) # 3a4 <putc>
 614:	8b4a                	mv	s6,s2
      state = 0;
 616:	4981                	li	s3,0
 618:	bd65                	j	4d0 <vprintf+0x60>
        putc(fd, c);
 61a:	85d2                	mv	a1,s4
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	d86080e7          	jalr	-634(ra) # 3a4 <putc>
      state = 0;
 626:	4981                	li	s3,0
 628:	b565                	j	4d0 <vprintf+0x60>
        s = va_arg(ap, char*);
 62a:	8b4e                	mv	s6,s3
      state = 0;
 62c:	4981                	li	s3,0
 62e:	b54d                	j	4d0 <vprintf+0x60>
    }
  }
}
 630:	70e6                	ld	ra,120(sp)
 632:	7446                	ld	s0,112(sp)
 634:	74a6                	ld	s1,104(sp)
 636:	7906                	ld	s2,96(sp)
 638:	69e6                	ld	s3,88(sp)
 63a:	6a46                	ld	s4,80(sp)
 63c:	6aa6                	ld	s5,72(sp)
 63e:	6b06                	ld	s6,64(sp)
 640:	7be2                	ld	s7,56(sp)
 642:	7c42                	ld	s8,48(sp)
 644:	7ca2                	ld	s9,40(sp)
 646:	7d02                	ld	s10,32(sp)
 648:	6de2                	ld	s11,24(sp)
 64a:	6109                	addi	sp,sp,128
 64c:	8082                	ret

000000000000064e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 64e:	715d                	addi	sp,sp,-80
 650:	ec06                	sd	ra,24(sp)
 652:	e822                	sd	s0,16(sp)
 654:	1000                	addi	s0,sp,32
 656:	e010                	sd	a2,0(s0)
 658:	e414                	sd	a3,8(s0)
 65a:	e818                	sd	a4,16(s0)
 65c:	ec1c                	sd	a5,24(s0)
 65e:	03043023          	sd	a6,32(s0)
 662:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 666:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 66a:	8622                	mv	a2,s0
 66c:	00000097          	auipc	ra,0x0
 670:	e04080e7          	jalr	-508(ra) # 470 <vprintf>
}
 674:	60e2                	ld	ra,24(sp)
 676:	6442                	ld	s0,16(sp)
 678:	6161                	addi	sp,sp,80
 67a:	8082                	ret

000000000000067c <printf>:

void
printf(const char *fmt, ...)
{
 67c:	711d                	addi	sp,sp,-96
 67e:	ec06                	sd	ra,24(sp)
 680:	e822                	sd	s0,16(sp)
 682:	1000                	addi	s0,sp,32
 684:	e40c                	sd	a1,8(s0)
 686:	e810                	sd	a2,16(s0)
 688:	ec14                	sd	a3,24(s0)
 68a:	f018                	sd	a4,32(s0)
 68c:	f41c                	sd	a5,40(s0)
 68e:	03043823          	sd	a6,48(s0)
 692:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 696:	00840613          	addi	a2,s0,8
 69a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 69e:	85aa                	mv	a1,a0
 6a0:	4505                	li	a0,1
 6a2:	00000097          	auipc	ra,0x0
 6a6:	dce080e7          	jalr	-562(ra) # 470 <vprintf>
}
 6aa:	60e2                	ld	ra,24(sp)
 6ac:	6442                	ld	s0,16(sp)
 6ae:	6125                	addi	sp,sp,96
 6b0:	8082                	ret

00000000000006b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b2:	1141                	addi	sp,sp,-16
 6b4:	e422                	sd	s0,8(sp)
 6b6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6b8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6bc:	00001797          	auipc	a5,0x1
 6c0:	9447b783          	ld	a5,-1724(a5) # 1000 <freep>
 6c4:	a805                	j	6f4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6c6:	4618                	lw	a4,8(a2)
 6c8:	9db9                	addw	a1,a1,a4
 6ca:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ce:	6398                	ld	a4,0(a5)
 6d0:	6318                	ld	a4,0(a4)
 6d2:	fee53823          	sd	a4,-16(a0)
 6d6:	a091                	j	71a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6d8:	ff852703          	lw	a4,-8(a0)
 6dc:	9e39                	addw	a2,a2,a4
 6de:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6e0:	ff053703          	ld	a4,-16(a0)
 6e4:	e398                	sd	a4,0(a5)
 6e6:	a099                	j	72c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e8:	6398                	ld	a4,0(a5)
 6ea:	00e7e463          	bltu	a5,a4,6f2 <free+0x40>
 6ee:	00e6ea63          	bltu	a3,a4,702 <free+0x50>
{
 6f2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f4:	fed7fae3          	bgeu	a5,a3,6e8 <free+0x36>
 6f8:	6398                	ld	a4,0(a5)
 6fa:	00e6e463          	bltu	a3,a4,702 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fe:	fee7eae3          	bltu	a5,a4,6f2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 702:	ff852583          	lw	a1,-8(a0)
 706:	6390                	ld	a2,0(a5)
 708:	02059713          	slli	a4,a1,0x20
 70c:	9301                	srli	a4,a4,0x20
 70e:	0712                	slli	a4,a4,0x4
 710:	9736                	add	a4,a4,a3
 712:	fae60ae3          	beq	a2,a4,6c6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 716:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 71a:	4790                	lw	a2,8(a5)
 71c:	02061713          	slli	a4,a2,0x20
 720:	9301                	srli	a4,a4,0x20
 722:	0712                	slli	a4,a4,0x4
 724:	973e                	add	a4,a4,a5
 726:	fae689e3          	beq	a3,a4,6d8 <free+0x26>
  } else
    p->s.ptr = bp;
 72a:	e394                	sd	a3,0(a5)
  freep = p;
 72c:	00001717          	auipc	a4,0x1
 730:	8cf73a23          	sd	a5,-1836(a4) # 1000 <freep>
}
 734:	6422                	ld	s0,8(sp)
 736:	0141                	addi	sp,sp,16
 738:	8082                	ret

000000000000073a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 73a:	7139                	addi	sp,sp,-64
 73c:	fc06                	sd	ra,56(sp)
 73e:	f822                	sd	s0,48(sp)
 740:	f426                	sd	s1,40(sp)
 742:	f04a                	sd	s2,32(sp)
 744:	ec4e                	sd	s3,24(sp)
 746:	e852                	sd	s4,16(sp)
 748:	e456                	sd	s5,8(sp)
 74a:	e05a                	sd	s6,0(sp)
 74c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 74e:	02051493          	slli	s1,a0,0x20
 752:	9081                	srli	s1,s1,0x20
 754:	04bd                	addi	s1,s1,15
 756:	8091                	srli	s1,s1,0x4
 758:	0014899b          	addiw	s3,s1,1
 75c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 75e:	00001517          	auipc	a0,0x1
 762:	8a253503          	ld	a0,-1886(a0) # 1000 <freep>
 766:	c515                	beqz	a0,792 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 76a:	4798                	lw	a4,8(a5)
 76c:	02977f63          	bgeu	a4,s1,7aa <malloc+0x70>
 770:	8a4e                	mv	s4,s3
 772:	0009871b          	sext.w	a4,s3
 776:	6685                	lui	a3,0x1
 778:	00d77363          	bgeu	a4,a3,77e <malloc+0x44>
 77c:	6a05                	lui	s4,0x1
 77e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 782:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 786:	00001917          	auipc	s2,0x1
 78a:	87a90913          	addi	s2,s2,-1926 # 1000 <freep>
  if(p == (char*)-1)
 78e:	5afd                	li	s5,-1
 790:	a88d                	j	802 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 792:	00001797          	auipc	a5,0x1
 796:	87e78793          	addi	a5,a5,-1922 # 1010 <base>
 79a:	00001717          	auipc	a4,0x1
 79e:	86f73323          	sd	a5,-1946(a4) # 1000 <freep>
 7a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7a8:	b7e1                	j	770 <malloc+0x36>
      if(p->s.size == nunits)
 7aa:	02e48b63          	beq	s1,a4,7e0 <malloc+0xa6>
        p->s.size -= nunits;
 7ae:	4137073b          	subw	a4,a4,s3
 7b2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7b4:	1702                	slli	a4,a4,0x20
 7b6:	9301                	srli	a4,a4,0x20
 7b8:	0712                	slli	a4,a4,0x4
 7ba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7bc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7c0:	00001717          	auipc	a4,0x1
 7c4:	84a73023          	sd	a0,-1984(a4) # 1000 <freep>
      return (void*)(p + 1);
 7c8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7cc:	70e2                	ld	ra,56(sp)
 7ce:	7442                	ld	s0,48(sp)
 7d0:	74a2                	ld	s1,40(sp)
 7d2:	7902                	ld	s2,32(sp)
 7d4:	69e2                	ld	s3,24(sp)
 7d6:	6a42                	ld	s4,16(sp)
 7d8:	6aa2                	ld	s5,8(sp)
 7da:	6b02                	ld	s6,0(sp)
 7dc:	6121                	addi	sp,sp,64
 7de:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7e0:	6398                	ld	a4,0(a5)
 7e2:	e118                	sd	a4,0(a0)
 7e4:	bff1                	j	7c0 <malloc+0x86>
  hp->s.size = nu;
 7e6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7ea:	0541                	addi	a0,a0,16
 7ec:	00000097          	auipc	ra,0x0
 7f0:	ec6080e7          	jalr	-314(ra) # 6b2 <free>
  return freep;
 7f4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7f8:	d971                	beqz	a0,7cc <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fc:	4798                	lw	a4,8(a5)
 7fe:	fa9776e3          	bgeu	a4,s1,7aa <malloc+0x70>
    if(p == freep)
 802:	00093703          	ld	a4,0(s2)
 806:	853e                	mv	a0,a5
 808:	fef719e3          	bne	a4,a5,7fa <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 80c:	8552                	mv	a0,s4
 80e:	00000097          	auipc	ra,0x0
 812:	b5e080e7          	jalr	-1186(ra) # 36c <sbrk>
  if(p == (char*)-1)
 816:	fd5518e3          	bne	a0,s5,7e6 <malloc+0xac>
        return 0;
 81a:	4501                	li	a0,0
 81c:	bf45                	j	7cc <malloc+0x92>
