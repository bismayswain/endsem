#!/usr/bin/awk
BEGIN{
    commentflag=0
    stringflag=0
    commentcount=0
    stringcount=0
}
{
    for (i=1;i<=NF;i++)
    {
      if($i ~ /\/\*/)
      {
        #if it is neither inside a comment nor inside a string
        if (stringflag==0 && commentflag==0)
        {
          #multiline comment starts
          commentflag=1
          commentcount++
        }
      }
      if($i ~ /\*\//)
      {
        commentflag=0
      }
      if($i ~ /\"/ && commentflag==0)
      {
        if(stringflag==1) stringcount++;
        stringflag?stringflag=0:stringflag=1
      }
      if($i ~/\/\// && commentflag==0 && stringflag==0)
      {
        commentcount++;
        next;
      }
    }
    if(commentflag==1)
    {
      commentcount++
    }
}
END{
  print commentcount " " stringcount
}
