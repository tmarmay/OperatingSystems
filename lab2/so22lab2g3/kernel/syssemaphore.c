#include <stddef.h>
#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include <stdbool.h>
#define MAX_SEMAPHORE 25

typedef struct semaphore_t *semaphore;

struct semaphore_t
{
	int value;
	struct spinlock sl;
	bool kill;
};

/*Arreglo de punteros a la estructura semaphore_t*/
semaphore array_sem[MAX_SEMAPHORE];

uint64 sys_sem_open(void)
{
	int sem;

	//Parsera con que semaforo a abrir
	argint(0, &sem);
	int value;

	//Parsea el valor inicial
	argint(1, &value);

	/* Rango posibles de semaforos */
	if (!((sem >= 0) && (sem < MAX_SEMAPHORE)))
		return 0;

	/*Pido memoria para un semaforo */
	if ((array_sem[sem] = (struct semaphore_t *)kalloc()) == 0)
	{
		return 0;
	}

	/* Nombre como "identificador" y un spinlock */
	initlock(&array_sem[sem]->sl, "sem");

	array_sem[sem]->value = value;
	array_sem[sem]->kill = false;

	return 1;
}

uint64 sys_sem_close(void)
{
	int sem;
	//Parsera con que semaforo a cerrar
	argint(0, &sem);

	/* Semaforo valido */
	acquire(&array_sem[sem]->sl);
	if (array_sem[sem] != NULL)
	{
		release(&array_sem[sem]->sl);
		kfree((struct semaphore_t *)array_sem[sem]);
		array_sem[sem] = NULL;
		return 1;
	}
	else
	{
		array_sem[sem]->kill = true;
		release(&array_sem[sem]->sl);
		return 0;
	}
}

uint64 sys_sem_up(void)
{
	int sem;

	argint(0, &sem);
	acquire(&array_sem[sem]->sl);

	if (array_sem[sem]->value == 0)
	{
		wakeup(&array_sem[sem]);
	}
	array_sem[sem]->value++;

	release(&array_sem[sem]->sl);
	return 1;
}

uint64 sys_sem_down(void)
{

	int sem;

	argint(0, &sem);
	acquire(&array_sem[sem]->sl);

	if (array_sem[sem]->value >= 1)
	{
		array_sem[sem]->value--;
	}
	if (array_sem[sem]->value == 0)
	{
		if (array_sem[sem]->kill)
		{
			
			kfree((struct semaphore_t *)array_sem[sem]);
			array_sem[sem] = NULL;
			release(&array_sem[sem]->sl);
			return 1;
		}
		sleep(&array_sem[sem], &array_sem[sem]->sl);
	}

	release(&array_sem[sem]->sl);
	return 1;

}
