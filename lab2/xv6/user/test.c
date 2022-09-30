#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include <stddef.h>
int
main(int argc, char *argv[])
{
  //sem_open(atoi(argv[1]),atoi(argv[2]));
  sem_open(0,0);
  sem_open(1,0);

  int rc = fork();
  
  if (rc == 0){
    //sem1
    printf("1  \n");
    sem_up(0);    
    sem_down(1);
    printf("3  \n");
  }
  else{
    //sem0
    sem_down(0);
    printf("2 \n");
    sem_up(1); 
  }
  exit(0);
}
