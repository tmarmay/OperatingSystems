#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "riscv.h"
#include "proc.h"
#include "defs.h"
#include "mlfq_implementation.h"


void init_queue(queue_s *q){
    q->size = 0;
	q->first_elem = 0;

	q->size = 0;
	q->first_elem = 0;

	q->size = 0;
	q->first_elem = 0;
}


void enqueue(queue_s * q, struct proc *p)
{
	int pos = -1;

	if (q->size < NPROC)
	{
		pos = (q->size + q->first_elem) % NPROC;
		q->size++;
	}
	else
	{
		panic("Full queue");
	}
	q->elems[pos] = p;
}

struct proc *dequeue(queue_s * q)
{
	struct proc *p = NULL;

	if (q->size <= 0)
	{
		panic("Already empty queue");
	}

	else
	{
		p = q->elems[q->first_elem];
		q->first_elem = (q->first_elem + 1) % NPROC;
		q->size--;
	}

	return p;
}

