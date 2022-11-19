#ifndef MLFQ_IMPLEMENTATION_H
#define MLFQ_IMPLEMENTATION_H
#include "param.h"
#include <stddef.h>

#define HIGH_PRIO 0
#define MID_PRIO 1
#define LOW_PRIO 2
#define PROC_CHOSEEN 0
#define STARVATION_TICKS 100
//typedef proc_list_t  *proc_list;

struct proc_list{ 
  int used_size;                   
  struct proc *used_list[NPROC/NPRIO]; // 21 lugares, pierdo uno
  int begin;              
};

void init_queue(struct proc_list *l);

void enqueue(struct proc_list *l,struct proc *p);

struct proc *dequeue(struct proc_list *l);

#endif