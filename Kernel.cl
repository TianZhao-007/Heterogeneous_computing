// kernel 1
for(unsigned int s=1; s<VECTOR_SIZE; s * =2)
{
    if(id % (2*s) == 0)
    {
      partialSums[id] += partialSums[id + s];
    }
    barrier(CLK_LOCAL_MEM_FENCE);
}



// kernel 2
for(unsigned int s=1; s<VECTOR_SIZE; s * =2)
{   
    int index  = id % (2*s);
    if(index < VECTOR_SIZE)
    {
      partialSums[id] += partialSums[id + s];
    }
    barrier(CLK_LOCAL_MEM_FENCE);
}


// kernel 3 
for(unsigned int s = VECTOR_SIZE / 2;  s > 0;  s >>= 1)
{
    if( id < s )
    {
        partialSums[id] += partialSums[id + s];
    }
      barrier(CLK_LOCAL_MEM_FENCE);
}


// kernel 4

/*
unsigned int tid = get_local_id(0);
unsigned int i = get_group_id(0) * get_group_size(0)  + get_local_id(0);
partialSums[id] = sum;
*/

unsigned int tid = get_local_id(0);
unsigned int i = get_group_id(0) * (get_group_size(0) * 2) + get_local_id(0);

partialSums[tid] = ...
  
 
  
  // kernel 5
  
  __device__void warpReduce(volatile int* partialSums, int tid)
{
    partialSums[tid] += partialSums[tid + 32]; 
    partialSums[tid] += partialSums[tid + 16]; 
    partialSums[tid] += partialSums[tid + 8]; 
    partialSums[tid] += partialSums[tid + 4]; 
    partialSums[tid] += partialSums[tid + 2]; 
    partialSums[tid] += partialSums[tid + 1];
}
  
  for(unsigned int s = VECTOR_SIZE / 2;  s > 32;  s >>= 1)
{
    if( id < s )
    {
       partialSums[id] += partialSums[id + s];
       barrier(CLK_LOCAL_MEM_FENCE);
    }
}
if (id < 32) warpReduce(sdata, tid);
  





// Reduction
        // If vector length changes, please edit it
        if(id < 16) partialSums[id]+=partialSums[id+16];
        barrier(CLK_LOCAL_MEM_FENCE);
        if(id < 8) partialSums[id]+=partialSums[id+8];
        barrier(CLK_LOCAL_MEM_FENCE);
        if(id < 4) partialSums[id]+=partialSums[id+4];
        barrier(CLK_LOCAL_MEM_FENCE);
        if(id < 2) partialSums[id]+=partialSums[id+2];
        barrier(CLK_LOCAL_MEM_FENCE);
        if(id < 1) partialSums[id]+=partialSums[id+1];
        barrier(CLK_LOCAL_MEM_FENCE);

        // write result
        if(id ==0)
        {
                y[row] = partialSums[id] + y[row];
        }

