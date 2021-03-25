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

OpenCL host API   
```
1. Query platform

cl_int clGetPlatformIDs(cl_unit num_entries, cl_platform_id *platforms, cl_unit *num_platforms);

Return value: Error code (ideally equal to CL_SUCCESS)
num_entries: Number of pre-allocated elements of typecl_platform_id in the array platforms  
platforms: Returns information about the platforms (for each platform one element in the array platforms)  
num_platforms: Returns number of platforms  

2. Query devices  

cl_int clGetDeviceIDs(cl_platform_id platform, cl_device_type device_type, cl_unit num_entries, cl_device_id *devices, cl_unit * num_devices);

Return value: Error code (ideally equal toCL_SUCCESS)
platform: Selected platform  
device_type: Device category (e.g.CL_DEVICE_TYPE_CPU,CL_DEVICE_TYPE_GPU)  
num_entries: Number of pre-allocated elements of typecl_device_id in the array devices  
devices: Returns information about the devices (for each deviceone element in the array devices)  
num_devices: Returns number of devices

3. Create context  

cl_context clCreateContext(...)  

4. Create queue  

```
A book

P461: The best way to learn OpenCL is actually to learn CUDA first and then map the Open CL features to their CUDA equivalents.

-	What is OpenCL?
OpenCL is a standardized, cross-platform parallel computing API based on the C language.

-	The aim of OpenCL?
OpenCL is designed to enable the development of portable parallel applications for systems with heterogenous computing devices.

-	OpenCL consists of two parts:
	Kernels that execute on one or more OpenCL devices
	Kernels are typically simple functions that transform input memory objects into output memory objects.
	OpenCL defines two types of kernels: OpenCL kernels + Native kernels

	A host program that manages the execution of kernels
-	OpenCL specification: 
See: www.khronos.org/opencl 
```

