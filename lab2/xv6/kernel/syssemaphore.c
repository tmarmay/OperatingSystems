#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

typedef struct semaphore_t *semaphore;

struct semaphore_t {
    int value;
    struct spinlock sl;
};

/*Arreglo de punteros a la estructura semaphore_t*/
#define MAX_SEMAPHORE 2
semaphore t[MAX_SEMAPHORE];

uint64
sys_sem_open(void)
{    
    int sem;
    argint(0,&sem);
    int value;
    argint(1,&value);

    /*Rango posibles de semaforos*/
    if (!((sem >= 0) && (sem < MAX_SEMAPHORE))) { return 0;}
    
    /*Pido memoria para un semaforo*/
    if((t[sem] = (struct semaphore_t*)kalloc()) == 0) { return 0;}

    /*Nombre como "identificador" y un spinlock*/
    initlock(&t[sem]->sl, "sem");

    t[sem]->value = value;
    //printf("value de %d es %d\n", sem,t[sem]->value);
    
    return 1;
}


 uint64 
 sys_sem_up(void)
{    
    
    int sem;
    argint(0,&sem);
    acquire(&t[sem]->sl);
    //printf("primer valor de value anres del up %d \n",t[sem]->value);
    if (t[sem]->value == 0){
        wakeup(&t[sem]);
    }
    t[sem]->value = t[sem]->value + 1;
        
    //printf("segundo valor de value desp del up %d \n",t[sem]->value);
    release(&t[sem]->sl);
    return 1;
}

uint64
sys_sem_down(void)
{
    
    int sem;
    argint(0,&sem);
    acquire(&t[sem]->sl);
    //printf("primer valor de value anres del down %d \n",t[sem]->value);
    
    if (t[sem]->value == 0){
        sleep(&t[sem],&t[sem]->sl);
    }
    else{
        t[sem]->value = t[sem]->value -1;
    }
    //printf("segundo valor de value desp del down %d \n",t[sem]->value);
    release(&t[sem]->sl);
    return 1;

}
