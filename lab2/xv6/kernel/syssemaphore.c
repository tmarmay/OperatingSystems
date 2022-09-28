#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

#define MAX_QTY_SEM 5

/* Inicializacion de semaforo*/
int semaphore[MAX_QTY_SEM]; // Setea al array en 0

uint64
sys_sem_open(void)
{    
    int sem;
    argint(0,&sem);
    int value;
    argint(1,&value);

    if (sem < MAX_QTY_SEM){
        semaphore[sem] = value;
        printf("%d, %d\n",sem,value);
        return semaphore[sem];
    }
    else{
        printf("Error: Maximo de semaforos superado \n");
        return 0;
    }
}


uint64 
sys_sem_up(void)
{
    int sem;
    argint(0,&sem);
    semaphore[sem] = semaphore[sem] + 1;
    if (semaphore[sem] == 0)
    {
        /*Falta desbloquear pocesos*/
        //release();
    }
    
    return sem;
}

uint64
sys_sem_down(void)
{
    int sem;
    argint(0,&sem);
    semaphore[sem] = semaphore[sem] - 1;
    if (semaphore[sem] == 0)
    {
        /*Falta bloquear pocesos*/
        //adquire();
    }
    return sem;
}