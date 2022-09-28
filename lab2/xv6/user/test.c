#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  printf("%d \n",sem_open(atoi(argv[1]),atoi(argv[2])));
  exit(0);
}
