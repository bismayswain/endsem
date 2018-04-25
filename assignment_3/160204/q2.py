import os
import sys
import math
import numpy as np
import matplotlib.pyplot as plt

#------------------1

X=np.genfromtxt ('train.csv', delimiter=",")
x=X[:,0]
y=X[:,1]
x = np.delete(x,0)
y = np.delete(y,0)
n_train=x.shape[0]
o=np.ones(n_train)



#-------------------2

w_t=np.random.rand(2,1)



#-------------------3
plt.plot(x, y, 'ro')
x1=np.c_[ o,x ]
x_t=np.matrix(x1)
y_t=np.matrix(y)
y_t=y_t.transpose()
plt.plot(x,np.dot(x_t,w_t))
plt.show()

#-------------------4

w_direct =(np.linalg.inv(np.dot(x_t.transpose(),x_t))).dot((x_t.transpose()).dot(y_t))
#print (w_direct)
plt.plot(x,y,'ro')
plt.plot(x,np.dot(x_t,w_direct))
plt.show()


#-------------------5

for i in range(10):
    idx=1
    while idx<n_train:
        x_dash=x_t[0];
        tmp= x_dash.dot(w_t)
        tmp=tmp-y_t[idx]
        tmp2=0.0000000001*(x_dash.T)*tmp
        w_t=w_t-tmp2
        idx=idx+1
        if idx%2000==0:
            plt.plot(x,y,'ro')
            plt.plot(x,x_t.dot(w_t))
plt.show()

#------------------6

plt.plot(x,y,'ro')
plt.plot(x,x_t.dot(w_t))
plt.show()



#------------------7


X_TEST=np.genfromtxt ('test.csv', delimiter=",")
x_test=X_TEST[:,0]
y_test=X_TEST[:,1]
n_test=x_test.shape[0]
x_test=np.delete(x_test,0)
y_test=np.delete(y_test,0)
o_test=np.ones(n_test-1)
X_test=np.c_[o_test,x_test]
y_pred1 = X_test.dot(w_t)
y_pred2 = X_test.dot(w_direct)
err1=0
err2=0
for i in range(0,n_test-1):
    err1=err1+(y_pred1[i] - y_test[i])*(y_pred1[i] - y_test[i])
    err2=err2+(y_pred2[i] - y_test[i])*(y_pred2[i] - y_test[i])
rootmean1=err1/(n_test-1)
rootmean2=err2/(n_test-1)
rootmean1=math.sqrt(rootmean1)
rootmean2=math.sqrt(rootmean2)
print("rootmean1= ",rootmean1)
print("rootmean2= ",rootmean2)
