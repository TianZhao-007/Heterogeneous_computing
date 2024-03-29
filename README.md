# Docker and linux(runtime)  
## Docker  
### docker --version
Docker version 20.10.2, build 20.10.2-0ubuntu1~20.04.2  
### when docker hasn't run  
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?  
Solution: sudo service docker start  
### docker run  
运行容器
### docker attach  
主要是查看信息，不推荐进入内部交互  
### docker build  
构建镜像的命令  
### docker commit  
把当前容器打包为镜像（更推荐Dockerfile）  
### docker cp  
复制docker内部文件到宿主机  
```
docker cp <containerId>:/file/path/within/container /host/path/target
```
### docker diff  
列出容器内发生变化的文件和目录  
### docker events  
实时输出docker服务器端的事件（如容器创建 启动 关闭）  
### docekr exec  
进入容器的命令  
```
docker exec -it docker_name bash  
```
### docker  history  
查看镜像历史变化  
### docker images  
查看docker的本地镜像  
### docker import  
导入镜像  
### docker info  
查看Docker的信息  
### docker inspect  
查看更详细的信息（了解一个image/container的完整构建）  
### docker kill  
杀死容器的进程  
### docker ps  
查看本地容器信息  
### docker pull  
拉取镜像（和git类似）
### docker push  
推送镜像  
### docker rename  
重命名容器  
### docker rm  
删除容器的命令  
### docker rmi  
删除镜像  
### docker search  
搜索镜像[Click here](https://hub.docker.com/)  
### docker save/ docker load  
镜像导入/导出到本地文件系统  







# OpenCl  
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
```
A book

P461: The best way to learn OpenCL is actually to learn CUDA first and then map the Open CL features to their CUDA equivalents.

-	What is OpenCL?
OpenCL is a standardized, cross-platform parallel computing API based on the C language.

-	The aim of OpenCL?
OpenCL is designed to enable the development of portable parallel applications for systems with heterogenous computing devices.

-	OpenCL consists of two parts:
  Kernels that execute on one or more OpenCL devices
	Kernels are typically simple functions that transform input memory objects into output memory objects.
 	OpenCL defines two types of kernels: OpenCL kernels + Native kernels

 	A host program that manages the execution of kernels
-	OpenCL specification: 
See: www.khronos.org/opencl 
```

## 线程 thread   
[简单线程学习](https://www.ruanyifeng.com/blog/2013/04/processes_and_threads.html)  


## OCLgrind  
[Intro](http://imgtec.eetrend.com/d6-imgtec/article/2015-12/6765.html)
作为其核心，Oclgrind模拟了OpenCL设备如何执行内核。  
Oclgrind工具有助于调试，该调试在运行时显示不正确的OpenCL API调用和内存访问问题。  
这在某种程度上独立于任何特定的体系结构，也使其能够发现许多在OpenCL开发期间出现的可移植性问题。  
通过曝光简单的插件接口，Oclgrind便可以创建各种各样的工具以分析或调试OpenCL内核。  


oclgrind.icd  
ICD means interface control document (ICD),a document that describes the interface(s) to a system or subsystem.  

liboclgrind-rt-icd.so  
不同操作系统的动态链接库文件格式稍有不同，Linux称之为共享目标文件（Shared Object），文件后缀为.so  
[.so编译的相关知识](https://zhuanlan.zhihu.com/p/235551437)  


## Work item & work group  



## OpenCL debug  

[Error-code in OpenCL](https://streamhpc.com/blog/2013-04-28/opencl-error-codes/)

Example:

**CL Error -5: Failed to read output array!**  
Error code is **-5(CL_OUT_OF_RESOURCES)** and then debug!


## Hardware  
SSD(solid state drive):  
[Click here to see haow SSD works](https://www.youtube.com/watch?v=5Mh3o886qpg)

