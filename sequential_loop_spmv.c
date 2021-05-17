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
