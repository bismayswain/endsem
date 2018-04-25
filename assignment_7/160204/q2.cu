#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);


__global__ void xorsum(int num_elements,int *a,double l)
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  if(i >= num_elements)
       return;
  int k=(int)l+1;
  int p=num_elements/2;
  int num=num_elements;
  while(p)
  {
     if(i<p)
     {
       a[i]=a[i]^a[num-i-1];
     }
     num=(num+1)/2;
     p=num/2;
  }

}
int main(int argc, char const *argv[])
{
  struct timeval start, end, t_start, t_end;
  int num_elements;
  int SEED,ctr,blocks;
  int *ptr;
  int *gpu_mem,*a;
  if(argc==3)
  {
    num_elements=atoi(argv[1]);
    SEED=atoi(argv[2]);
  }
  else
  {
      printf("Wrong command line arguments\n" );
      exit(-1);
  }

  a = (int *)malloc(num_elements * sizeof(int));
  if(!a){
          USAGE_EXIT("invalid num elements, not enough memory");
  }

  srand(SEED);
  for(ctr=0; ctr<num_elements; ++ctr)
  {
    a[ctr] = random();
  }
  for (size_t i = 0; i < num_elements; i++) 
  {
    printf("%d\n",a[i] );
    if (i==num_elements-1) 
    {
      printf("\n" );    
    }
  }
  gettimeofday(&t_start,NULL);
  cudaMalloc(&gpu_mem, num_elements*sizeof(int));
  CUDA_ERROR_EXIT("cudaMalloc");

  cudaMemcpy(gpu_mem,a, num_elements*sizeof(int) , cudaMemcpyHostToDevice);
  CUDA_ERROR_EXIT("cudaMemcpy");

  gettimeofday(&start, NULL);

  blocks = num_elements /1024;

  if(num_elements % 1024)
  {
    ++blocks;
  }
  double l=log(num_elements)/log(2);
  xorsum<<<blocks, 1024>>>(num_elements,gpu_mem,l);
  CUDA_ERROR_EXIT("kernel invocation");
  gettimeofday(&end, NULL);

    /* Copy back result*/

  cudaMemcpy(a, gpu_mem,num_elements*sizeof(int),cudaMemcpyDeviceToHost);
  CUDA_ERROR_EXIT("memcpy");
  gettimeofday(&t_end, NULL);

  printf("Xor based checksum is %d\n",a[0]);
  printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
  cudaFree(gpu_mem);
  return 0;
}


