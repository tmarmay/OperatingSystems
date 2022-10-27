#include "param.h"
#include <stddef.h>

#ifndef MLFQ_IMPLEMENTATION_H
#define MLFQ_IMPLEMENTATION_H

//typedef proc_list_t  *proc_list;

struct proc_list{ 
  int used_size;                   
  int used_list[NPROC/NPRIO]; // 21 lugares, pierdo uno
  int begin;              
};

void init_queue(struct proc_list *l);

void enqueue(struct proc_list *l, int index);

int dequeue(struct proc_list *l);

#endif