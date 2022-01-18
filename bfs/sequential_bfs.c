/** A sequential bfs function
    Asumme CSR format is used     **/

void BFS_sequential(int source, int *edges, int *dest, int *label)
{
    int frontier[2][MAX_FRONTIER_SIZE];
    int *c_frontier = &frontier[0];
    int c_frontier_tail = 0;
    int *p_frontier = &frontier[1];
    int p_frontier_tail = 0;
  
    insert_frontier(source, p_frontier, &p_frontier_tail);
    label[source] = 0;
    
    while(p_frontier_tail > 0)
    {
        for(int f = 0; f < p_frontier_tail; f++)
        {
            c_vertex = p_frontier[f];
            for(int i = edges[c_vertex]; i < edges[c_vertex + 1]; i++ )
            {
                if(label[dest[i]] == -1)
                {
                    insert_frontier(dest[i], c_frontier, &c_frontier_tail);
                    label[dest[i]] = label[c_vertex] + 1;
                }
            }
        }
        int temp = c_frontier;   c_frontier = p_frontier;  p_frontier = temp;
        p_frontier_tail = c_frontier_tail;   c_frontier_tail = 0;
    }
}
