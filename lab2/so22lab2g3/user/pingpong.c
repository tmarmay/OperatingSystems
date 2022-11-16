#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include <stddef.h>

int
main(int argc, char *argv[])
{
  int rc,rally;

  //En caso de no tener los argumentos correctos
  if(argc != 2){
    fprintf(2, "usage: pingpong rallies...\n");
    exit(1);
  }

  // Tomamos el argumento del numero de rallies pedidos
  rally = atoi(argv[1]);
  if (rally < 1)
  {
    printf("rallie value must be greater than 0...\n");
    exit(0);
  }


  // Abriendo los semaforos
  //Semaforo hijo(0)
  if ( sem_open(0,0) == 0 )
    exit(1);
  //Semaforo semaforo padre(1)
  if ( sem_open(1,0) == 0) 
    exit(1);
  
  rc = fork();

  //El caso del Hijo
  if (rc == 0) {
    while (rally > 0){
      if ( sem_down(0) == 0 )
        exit(1); 
      printf("\tPong!\n");
      rally--;
      if ( sem_up(1) == 0 )
        exit(1);
    }
    
    exit(0);
  }
  else if (rc == -1){
    printf("Error in fork\n");
    exit(1);
  }
  
  // El caso del Padre
  else {
    while (rally > 0){
      printf("Ping!\n");
      rally--;
      if ( sem_up(0) == 0 ) 
        exit(1);
      if ( sem_down(1) == 0 ) 
        exit(1);
    }
  }

  
  // Cerrando los semaforos
  sem_close(0);
  sem_close(1);

  exit(0);
}