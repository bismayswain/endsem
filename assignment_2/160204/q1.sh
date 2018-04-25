#!/bin/bash
function fun
{
  strings=0
  comments=0
  for curr in $1/*
  do
    if [ -d $curr ];
    then
      fun $curr
    else
      if [[  "${curr: -2}" == ".c"  ]]; then
        a=$(awk -f q1.awk $curr)
        #echo "$a"
        passcomment=$(cut -d' ' -f1 <<< $a)
        passstring=$(cut -d' ' -f2 <<< $a)
        let strings+=passstring
        let comments+=passcomment
      fi
    fi
  done
}
fun $1
echo "$comments line of comments"
echo  "$strings quoted strings"
#~/Documents/practice
