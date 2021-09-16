// one work-item process a row of matrix
__kernel void
spmv_csr_scalar_kernel( __global const float * restrict val,
	__global const float * restrict vec,
	__global const int * restrict cols,
	__global const int * restrict ptr,
	const int dim, __global float * restrict out){
	
	int row = get_global_id(0);
	if (row < dim) {
		float temp=0;
	int start = ptr[row];
	int end = ptr[row+1];
	for (int j = start; j < end; j++) {
		int col = cols[j];
		temp += val[j] * vec[col];
		}
	out[row] = temp;
}
}


#define VECTOR_SIZE  32
// NAVIDIA is 32 threads per warp

__kernel void csr(const unsigned int num_rows,		
		__global const int * restrict Ap,
		__global const int * restrict Aj,
		__global const float * restrict Ax,
		__global const float * restrict x,
		__global float * restrict y)
{
	// get local work-item ID
	// get_local_id(0) -> size_t get_local_id(uint dim) -> given dim, return the local id of work-item
	int tid = get_local_id(0);

	// VECTOR_SIZE-1 = 31  
	// biniay of 31 is 0001 1111
	// 31 & id 
	// aim to clear to 0 for high places
	int id = tid & (VECTOR_SIZE - 1);

	// one row per warp
	// get_local_size(0) ->  size_t get_local_size(uint dim)  -> given dim, return the # of work-items in work group
	// get_gobal_id(0) -> size_t get_gobal_id(uint dim) -> given dim, return the gobal ID of work-item
	int threadsPerBlock = get_local_size(0) / VECTOR_SIZE;
	int row = ( get_group_id(0) * threadsPerBlock ) + (tid / VECTOR_SIZE);

	__local volatile float partialSums[128];
	partialSums[tid] = 0;

	if(row < num_rows)
	{
		int vecStart = Ap[row];
		int vecEnd = Ap[row+1];

		float sum = 0.0f;
		for(int j = vecStart+id; j<vecEnd; j += VECTOR_SIZE)
		{
			int col = Aj[j];
			sum += Ax[j] * x[col];
		}

	partialSums[tid] = sum;
	barrier(CLK_LOCAL_MEM_FENCE);
	
	// Reduction
	// If vector length changes, please edit it
	if(id < 16) partialSums[tid]+=partialSums[tid+16];
	barrier(CLK_LOCAL_MEM_FENCE);
	if(id < 8) partialSums[tid]+=partialSums[tid+8];
	barrier(CLK_LOCAL_MEM_FENCE);
	if(id < 4) partialSums[tid]+=partialSums[tid+4];
	barrier(CLK_LOCAL_MEM_FENCE);
	if(id < 2) partialSums[tid]+=partialSums[tid+2];
	barrier(CLK_LOCAL_MEM_FENCE);
	if(id < 1) partialSums[tid]+=partialSums[tid+1];
	barrier(CLK_LOCAL_MEM_FENCE);

	// write result 
	if(id ==0)
	{
		y[row] = partialSums[tid];
	}
	}
}


