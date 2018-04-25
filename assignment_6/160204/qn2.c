//check command line arguments properly


#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<pthread.h>
#include<sys/time.h>



#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))


pthread_mutex_t lock,lock2;
pthread_mutex_t acc_lock[11001];
int count;
int ct;
double* account_change;
double* account;
int xy=0;



void* transactions(void *arg)
{
  double **a=(double **)arg;
  while (1)
  {
    //printf("%d\n",ct );
    pthread_mutex_lock(&lock);
    int idx=ct;
    ct++;
    if(idx>=count)
    {
      pthread_mutex_unlock(&lock);
      break;
    }
    // printf("idx is %d ct is %d\n",idx,ct);
    int ac1,ac2;

    ac1=(int)a[idx][3];
    ac2=(int)a[idx][4];
    int z=(int)a[idx][1];
    //printf("z is %d idx is %d\n",z,idx);
    // pthread_mutex_lock(&lock2);
    pthread_mutex_lock(&acc_lock[ac1]);
    if(z==4)
    {
      pthread_mutex_lock(&acc_lock[ac2]);
    }
    pthread_mutex_unlock(&lock);
    // pthread_mutex_unlock(&lock2);
    // for (size_t i = 0; i < 10000; i++)
    // {
    //   int al;
    //     if (i%2==0)
    //     {
    //       al=10001*1001;
    //     } else {
    //       al=1222*23123;
    //     }
    // }



    if (z==1)
    {
      account[ac1]+=0.99*a[idx][2];
    }
    else if (z==2)
    {
      account[ac1]-=1.01*a[idx][2];
    }
    else if (z==3)
    {
      account[ac1]=1.071*account[ac1];
    }
    else
    {
      account[ac1]-=1.01*a[idx][2];
      account[ac2]+=0.99*a[idx][2];
      pthread_mutex_unlock(&acc_lock[ac2]);
    }
    pthread_mutex_unlock(&acc_lock[ac1]);
  }

  pthread_exit(NULL);
}

int main(int argc, char const *argv[])
{
  int fd, ctr,THREADS;
  unsigned long size, bytes_read = 0;
  char *buff, *cbuff,*duff;
  struct timeval start, end;
  //pthread_t threads[THREADS];
  if(argc != 5){
    printf("Usage: %s <fileneme>\n", argv[0]);
    exit(-1);
  }
  count=atoi(argv[3]);
  THREADS=atoi(argv[4]);
  fd = open(argv[2], O_RDONLY);
  if(fd < 0){
    printf("Can not open file\n");
    exit(-1);
  }

  size = lseek(fd, 0, SEEK_END);
  if(size <= 0){
    perror("lseek");
    exit(-1);
  }

  if(lseek(fd, 0, SEEK_SET) != 0){
    perror("lseek");
    exit(-1);
  }


  buff = malloc(size);
  if(!buff){
         perror("mem");
         exit(-1);
  }

  do{
       unsigned long bytes;
       cbuff = buff + bytes_read;
       bytes = read(fd, cbuff, size - bytes_read);
       if(bytes < 0)
       {
           perror("read");
           exit(-1);

       }
       //printf("%s\n%d\n",cbuff,bytes_read);
      bytes_read += bytes;
   }while(size != bytes_read);

   //printf("%s\n",buff );
   close(fd);

   FILE *fp;
   char c;
   double **a;
   a=(double **)malloc(count*sizeof(double *));
   cbuff=buff;
   for (size_t i = 0; i < count; i++)
   {
      a[i]=(double *)malloc(5*sizeof(double));
      //in order txn_type,amount,acc 1,acc 2
      for (size_t j = 0; j < 5; j++) {
        sscanf(cbuff, "%lf", &a[i][j]);
        //printf("%lf\n",a[i][j] );
        char d='0';
        while(d!=' '&& d!='\n')
        {
          cbuff=cbuff+1;
          if(cbuff-buff>=size)break;
          d=(char)cbuff[0];
        }
        cbuff=cbuff+1;
      }
   }
   free(buff);


   // for (size_t i = 0; i < count; i++)
   // {
   //   printf("%lf %lf %lf %lf %lf\n",a[i][0],a[i][1],a[i][2],a[i][3],a[i][4] );
   // }

  account=(double *)malloc(11001*sizeof(double));
  account_change=(double *)malloc(11001*sizeof(double));
  for (size_t i = 0; i < 11001; i++) {
    account[i]=0;
    account_change[i]=0;
  }



  fd = open(argv[1], O_RDONLY);
  if(fd < 0){
    printf("Can not open file\n");
    exit(-1);
  }

  size = lseek(fd, 0, SEEK_END);
  if(size <= 0){
    perror("lseek");
    exit(-1);
  }

  if(lseek(fd, 0, SEEK_SET) != 0){
    perror("lseek");
    exit(-1);
  }


  duff = malloc(size);
  if(!duff){
         perror("mem");
         exit(-1);
  }
  bytes_read=0;
  do{
       unsigned long bytes;
       cbuff = duff + bytes_read;
       bytes = read(fd, cbuff, size - bytes_read);
       if(bytes < 0)
       {
           perror("read");
           exit(-1);

       }
      bytes_read += bytes;
   }while(size != bytes_read);

   close(fd);
   cbuff=duff;
   for (size_t i = 0; i < 10000; i++)
   {
     for (size_t j = 0; j < 2; j++)
     {
       if(j==1)
          sscanf(cbuff, "%lf", &account[i+1001]);
       char d='0';
       while(d!=' '&& d!='\n')
       {
         cbuff=cbuff+1;
         if(cbuff-duff>=size)break;
         d=(char)cbuff[0];
       }
       cbuff++;
     }
   }

   // for (size_t i = 0; i < 1100; i++)
   // {
   //   printf("%d %lf\n",i,account[i]);
   // }

   ct=0;
   gettimeofday(&start, NULL);
   pthread_t threads[THREADS];
   pthread_mutex_init(&lock, NULL);
   pthread_mutex_init(&lock2, NULL);
   //printf("aaa\n");
   for (size_t i = 0; i < 11001; i++)
   {
     pthread_mutex_init(&acc_lock[i],NULL);
   }
   //printf("bbbb\n" );
   for(ctr=0; ctr < THREADS; ++ctr)
   {
      if(pthread_create(&threads[ctr], NULL,transactions,a) != 0)
      {
            perror("pthread_create");
            exit(-1);
      }
   }
   for(ctr=0; ctr < THREADS; ++ctr)
   {
     pthread_join(threads[ctr], NULL);
   }
   gettimeofday(&end,NULL);

   for (size_t i = 1001; i < 11001; i++)
   {
     printf("%d %.2lf\n",i,account[i]);
   }
   printf("Time taken = %ld microsecs\n", TDIFF(start, end));
   free(duff);
  return 0;
}
