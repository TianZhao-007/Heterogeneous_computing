#define VECTOR_SIZE  32


void __kernel csr(const unsigned int num_rows,
                __global unsigned int * restrict  Ap,
                __global unsigned int * restrict Aj,
                __global float * restrict  Ax,
                __global float * restrict x,
                __global float * restrict y)

{
        int tid = get_local_id(0);

        int id = tid & (VECTOR_SIZE - 1);

        int row = get_group_id(0) ;

        __local volatile float partialSums[64];
        partialSums[id] = 0;

        if(row < num_rows)
        {
                int vecStart = Ap[row];
                int vecEnd = Ap[row+1];

                float sum = 0;
                for(int j = vecStart+id; j<vecEnd; j += VECTOR_SIZE)
                {
                        int col = Aj[j];
                        sum += Ax[j] * x[col];
                }

        partialSums[id] = sum;
        barrier(CLK_LOCAL_MEM_FENCE);

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
        }
}
