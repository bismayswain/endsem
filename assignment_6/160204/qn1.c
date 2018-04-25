#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>
#include<string.h>
#include<math.h>
#include<sys/time.h>

#define SEED 0x7457

#define MAX_THREADS 64

#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct thread_param{
                       pthread_t tid;
                       int *array;
                       int size;
                       int skip;
                       double max;
                       int max_index;
};

int checkprime(int n)
//returns 1 if prime
{
    double k=sqrt(n);
    int z=(int)k;
    int flag=0;
    for (size_t i = 2; i <= z; i++)
    {
      if(n%i==0)
      {
        flag=1;
        break;
      }
    }
    if(flag==0)return 1;
    return 0;
}

void* maxprime(void *arg)
{
     struct thread_param *param = (struct thread_param *) arg;
     int ctr;//counter
     param->max = -1;
     param->max_index = -1;

     ctr = param->skip;
     while(ctr < param->size)
     {
       int x=param->array[ctr];
       if (checkprime(x) && x>param->max)
       {
         param->max=x;
         param->max_index=ctr;
       }
       ctr += param->skip;
     }
     return NULL;
}

int main(int argc, char const *argv[])
{
  struct thread_param *params;
  struct timeval start,end;
  int *a, num_elements,num_threads,ctr;
  int max_prime,max_prime_index;

  if(argc !=3)
           USAGE_EXIT("not enough parameters");

  num_elements = atoi(argv[1]);
  if(num_elements <=0)
          USAGE_EXIT("invalid num elements");

  num_threads = atoi(argv[2]);
  if(num_threads <=0 || num_threads > MAX_THREADS){
          USAGE_EXIT("invalid num of threads");
  }



  a = malloc(num_elements * sizeof(int));
  if(!a){
          USAGE_EXIT("invalid num elements, not enough memory");
  }


  srand(time(NULL));
  for(ctr=0; ctr<num_elements; ++ctr)
        a[ctr] = random();


  params = malloc(num_threads * sizeof(struct thread_param));
  bzero(params, num_threads * sizeof(struct thread_param));

  gettimeofday(&start, NULL);

  for(ctr=0; ctr < num_threads; ++ctr)
  {
        struct thread_param *param = params + ctr;
        param->size = num_elements - ctr;
        param->skip = num_threads;
        param->array = a + ctr;

        if(pthread_create(&param->tid, NULL,maxprime, param) != 0){
              perror("pthread_create");
              exit(-1);
        }
  }

  for(ctr=0; ctr < num_threads; ++ctr)
  {
        struct thread_param *param = params + ctr;
        pthread_join(param->tid, NULL);
        if(ctr == 0 || (ctr > 0 && param->max > max_prime))
        {
             max_prime = param->max;
             max_prime_index = param->max_index;
        }
  }
  if (max_prime!=-1)
  {
    printf("Max prime number is %d\n",max_prime);
  }
  else
  {
    printf("NO prime number\n");
  }
  gettimeofday(&end, NULL);
  printf("Time taken = %ld microsecs\n", TDIFF(start, end));
  free(a);
  free(params);
  return 0;
}
