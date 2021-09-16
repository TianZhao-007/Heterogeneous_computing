// num_rows – number of rows in matrix
// ptr – the array that stores the offset to the i-th row in ptr[i]
// indices – the array that stores the column indices for non-zero
// values in the matrix
// x - the dense vector
// y - the output
void spmv_csr_cpu(const int num_rows,
        const int * ptr;
        const int * indices;
        const float * data,
        const float * vec, float * out) {
  
for( int row = 0; row < num_rows, row++) {
  float temp = 0;
  int start_row = ptr[row];
  int end_row = ptr[row+1];
  for(int jj = start_row; jj < end_row; jj++)
  temp += data[jj] * vec [indices[jj]];
  out[row] += temp;
}
}



/****************************************************/
for (int row =0; row < num_rows; row++)
{
  float dot = 0;
  int row_start = Ptr[row];
  int row_end = Ptr[row+1];
  for(int elem = row_start; elem < row_end; elem++)
  {
    dot+= data[elem] * Data[Indices[elem]];
  }
  y[row]+=dot;
}
