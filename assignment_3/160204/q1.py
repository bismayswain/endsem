def chkvalid(thenum,base):
    #print("1")
    basedata={}
    if base<10:
        for i in range(base):
            basedata[chr(i+ord('0'))]=i
    else:
        for i in range(10):
            basedata[chr(i+ord('0'))]=i
        for i in range(10,base):
            basedata[chr(55+i)]=i
    count=0
    dotpoint=len(thenum)
    for value in thenum:
        if value=='.':
            dotpoint=count
            break
        count=count+1
    j=dotpoint-1
    flag=False
    while j>=0:
        if thenum[j] not in basedata:
            flag=True
            #print(thenum[j])
        j=j-1
    j=dotpoint+1
    numlen=len(thenum)
    while j<numlen:
        if thenum[j] not in basedata:
            flag=True
            #print (thenum[j])
        j=j+1
    #print (basedata)
    return flag
def basechange(thenum,base):
    basedata={}
    if base<10:
        for i in range(base):
            basedata[chr(i+ord('0'))]=i
    else:
        for i in range(10):
            basedata[chr(i+ord('0'))]=i
        for i in range(10,base):
            basedata[chr(55+i)]=i
    count=0
    dotpoint=len(thenum)
    for value in thenum:
        if value=='.':
            dotpoint=count
            break
        count=count+1
    j=dotpoint-1
    val=0.0
    power=1
    while j>=0:
        val=val+power*basedata[thenum[j]]
        power=power*base
        j=j-1
        #print (val)
    j=dotpoint+1
    numlen=len(thenum)
    pwr=1.0/base
    while j<numlen:
        val=val+pwr*(basedata[thenum[j]])
        pwr=pwr/base
        j=j+1
    return val









num=input("Enter The Number:\n")
base=input("Enter base:\n")
l=len(base)
k=0
intbase=0
while k<l:
    intbase=intbase*10+ord(base[k])-ord('0')
    k=k+1
anum=str(num)
negflag=False
if anum[0]=='-':
    negflag=True
    anum=anum[1:]
flag=chkvalid(anum,intbase)
if flag==True:
    print ("Invalid Input")
else:
    i=0
    while anum[i]=='0':
        i=i+1
    thenum=anum[i:]
    value=basechange(thenum,intbase)
    if negflag==True:
        othbase='-'+str(value)
    else:
        othbase=str(value)
    print (othbase)
