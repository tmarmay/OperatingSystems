#include "param.h"
#include <stddef.h>

#ifndef MLFQ_IMPLEMENTATION_H
#define MLFQ_IMPLEMENTATION_H


typedef struct queue_t{
  struct proc* elems[NPROC];   
  int size;                   
  int first_elem;              
}queue_s;

void init_queue(queue_s *q);

void enqueue(queue_s * q, struct proc *p);

struct proc *dequeue(queue_s * q);

#endif