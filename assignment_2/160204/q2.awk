#!/usr/bin/awk
BEGIN{
  connectionlist=1
}
function extract_second(timeSTR)
{
    split($1,bigsec, ":");
    split(bigsec[3],secval,".")
    if(milsecond1[trans]=="")
    {
      milsecond1[trans]=secval[2]
    }
    milsecond2[trans]=secval[2]
    return secval[1]

}
function extract_byte(byte)
{
    split($9,se, "[:,]");
    for (j=se[1];j<se[2] ;j++ )
    {
      if(data[trans][j]=="")
      {
        data[trans][j]=1;
        total[trans]+=1;
        unique[trans]++
      }
      else
      {
        total[trans]+=1;
        retrans[trans]+=1;
      }
    }
}
{
  A=$3

  B=split($5, array,":")
  trans=$3"r"array[1]
  packets[trans]++;
  nowsec=extract_second($1)
  if (currsecond[trans]=="")
  {
    currsecond[trans]=nowsec;
  }
  if (currsecond[trans]<nowsec||(currsecond[trans]==59&&nowsec==0))
  {
    seconds[trans]++
    currsecond[trans]=nowsec
  }
  if ($8 ~ /seq/ && $9 ~ /:/)
  {
    datapacket[trans]++;
    extract_byte($9)
  }
  else
  {
    if(datapacket[trans]=="")
      {
        datapacket[trans]=0
      }
  }


}
END{
  for (i in packets)
  {
    if (printed[i]!=1)
    {
      split(i,arr,"r")
      j=arr[2]"r"arr[1]
      if (total[i]=="")
      {
        total[i]=0
      }
      if (retrans[i]=="")
      {
        retrans[i]=0
      }
      if (total[j]=="")
      {
        total[j]=0
      }
      if (retrans[j]=="")
      {
        retrans[j]=0
      }
      printed[i]=1
      printed[j]=1
      milsecond1[i]="."milsecond1[i]
      milsecond2[i]="."milsecond2[i]
      # print milsecond1[i]
      # print milsecond2[i]
      mseconds[i]=milsecond2[i]-milsecond1[i]
      # print mseconds[i]
      if(mseconds[i]<0)
      {
        mseconds[i]=milsecond1[i]-milsecond2[i]
        mseconds[i]=1-mseconds[i]
        seconds[i]=seconds[i]-1
      }
      # print mseconds[i]
      milsecond1[j]="."milsecond1[j]
      milsecond2[j]="."milsecond2[j]
      mseconds[j]=milsecond2[j]-milsecond1[j]
      if(mseconds[j]<0)
      {
        mseconds[j]=milsecond1[j]-milsecond2[j]
        mseconds[j]=1-mseconds[j]
        seconds[j]=seconds[j]-1
      }
      # print seconds[i]
      # print seconds[j]
      seconds[i]=seconds[i]+mseconds[i]
      seconds[j]=seconds[j]+mseconds[j]
      # print seconds[i]
      # print seconds[j]
      print "Connection(A=",arr[1] ," B=" ,arr[2], ")"
      print "A-->B #packets=",packets[i], "#datapackets=",datapacket[i], "#bytes="total[i], "#retrans=",retrans[i], "xput=",(unique[i])/seconds[i]
      print "B-->A #packets=",packets[j], "#datapackets=",datapacket[j], "#bytes="total[j], "#retrans=",retrans[j], "xput=",(unique[j])/seconds[j]
    }

  }

}
