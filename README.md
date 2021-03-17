# 1. OpenCl  
## what's openCL?  
OpenCL(open compute language)  

## terminologies
### conceptual level:  
- platform model
(host,device,CU-compute unit,PE-processing elements,ICD-installable client driver model)    
header files(get from Khronos website; Central file: CL/cl.h)  
OpenCL library stub with ICD loader(Get form one of vendors of your OpenCL devices;centrl file: libOpenCL.so)  
ICD definition files and platform–specific OpenCL libraries(Get from all the vendors of your OpenCL devices)  

- execution model  
Host: Executes host program  
Device: Executes device kernel  
Hierarchical thread organization(grid-block-thread; NDrange-work_group-work_item)    
  
```
Host defines Context:
Devices(only from single platform!)  
Kernels (OpenCL–functions for execution on the device)  
Program objects (kernel source code and kernels in compiled form)  
Memory objects
```
```
Host manages Queues  
Kernel execution  
Operations on memory objects  
Synchronization(in-order & out-of-order)  
```

memeory model  
```
HOST + KENERLS
global+ constant+ local+ private  
```


programing model  
```
Data parallel 
Task parallel
```

### programming level:  
OpenCL platform API,OpenCL runtime API,OpenCL C(progrmming language)  

