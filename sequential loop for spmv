for (int row =0; row < num_rows; row++)
{
  float dot = 0;
  int row_start = row_ptr[row];
  int row_end = row_ptr[row+1];
  for(int elem = row_start; elem < row_end; elem++)
  {
    dot+= data[elem] * x[col_index[elem]];
  }
  y[row]+=dot;
}
