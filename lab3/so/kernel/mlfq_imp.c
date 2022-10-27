#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "riscv.h"
#include "proc.h"
#include "defs.h"
#include "mlfq_imp.h"

/*
struct proc_list{
  int *free_list[22];   
  int free_size;
  int used_size;                   
  int *used_list[22];              
};

void init_queue(proc_list l);

void enqueue(proc_list l, int index);


*/


void init_queue(struct proc_list *l){
	for(int i=0; i < (NPROC/NPRIO); i++){
		l->used_list[i] = -1;
	}
	l->used_size = 0;
	l->begin = 0;
}

void enqueue(struct proc_list *l, int index){
	if (l->used_size < (NPROC/NPRIO)){
		int pos = (l->used_size + l->begin) % (NPROC/NPRIO);
		l->used_list[pos] = index;
		l->used_size++;
	}
	else{
		panic("Full proc table");
	}
}


int dequeue(struct proc_list *l){
	if (l->used_size > 0){
		int pos = l->used_list[l->begin];
		l->used_list[l->begin] = -1;
		l->begin = (l->begin + 1) & (NPROC/NPRIO);
		l->used_size--;
		return pos;
	}
	else{
		panic("Empty proc table");
		return 0;
	}
}





/*
#endif

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

*/