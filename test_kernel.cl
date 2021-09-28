/*
void __kernel csr(const unsigned int num_rows,
                __global unsigned int * Ap,
                __global unsigned int * Aj,
                __global float * Ax,
                __global float * x,
                __global float * y)
{
        unsigned int row = get_global_id(0);

        if(row < num_rows)
        {
                float sum = y[row];

                const unsigned int row_start = Ap[row];
                const unsigned int row_end = Ap[row+1];

                unsigned int jj = 0;
                for (jj = row_start; jj < row_end; jj++)
                        sum += Ax[jj] * x[Aj[jj]];

                y[row] = sum;
        }
}

*/

#define VECTOR_SIZE  32

__kernel void csr(const unsigned int num_rows,
                __global const int * restrict Ap,
                __global const int * restrict Aj,
                __global const float * restrict Ax,
                __global const float * restrict x,
                __global float * restrict y)
{
        // thread ID in block
        size_t tid = get_local_id(0);
        printf ("\n");
        printf ("get Global Group Local ID is %zu %zu %zu\n",get_global_id(0),get_group_id(0), tid);
        printf ("get Global Local SIZE is %zu %zu \n", get_global_size(0),get_local_size(0));
        // thread ID within warp
        int id = tid & (VECTOR_SIZE - 1);

        // vector per block
        int threadsPerBlock = get_local_size(0) / VECTOR_SIZE;
  
         int local_size = get_local_size(0);
        // printf ("Get local size is %d\n", local_size);
        // printf ("Get num of groups is %d\n",get_num_groups(0));
        int row = ( get_group_id(0) * threadsPerBlock ) + (tid / VECTOR_SIZE);
        printf ("row is %d\n", row);

        __local volatile float partialSums[1024];
        partialSums[tid] = 0;

        if(row < num_rows)
        {
                int vecStart = Ap[row];
                int vecEnd = Ap[row+1];
                printf ("VecStart and VecEnd are %d %d\n",vecStart,vecEnd);

                float sum = 0;
                for(int j = vecStart+id; j<vecEnd; j += VECTOR_SIZE)
                {
                        int col = Aj[j];
                        sum += Ax[j] * x[col];
                }

        partialSums[tid] = sum;
        printf ("Sum is %f \n",sum);
        barrier(CLK_LOCAL_MEM_FENCE);

        int bar = VECTOR_SIZE / 2;
        while(bar > 0)
        {
            if (id < bar) partialSums[tid] += partialSums[tid+ bar];
            barrier(CLK_LOCAL_MEM_FENCE);
            bar = bar / 2;
        }

        // write result
        if(id ==0)
        {
                y[row] = partialSums[tid];
                printf ("ROW is %d\n", row);
                printf ("y[row] is %f\n", y[row]);
        }
        }
}

                
