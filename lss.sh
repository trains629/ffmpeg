#!/bin/bash

excs=("mp4" "avi" "wav" "md")
outExc=.m4v

function run() {
  echo $1 $2
  ffmpeg -i $1 -s 480*270 $2
  rm $1
}
function cmd() {
  local filename=$1
  local outDir=$2
  local name=${filename##*/}
  local basename=${name%.*}
  local exc=${name##*.}
  if [[ ${excs[@]/$exc/} == ${excs[@]} ]]; then
    #echo $exc $basename $name $filename
    return
  fi

  local outFile=$outDir$basename$outExc
  if [[ -f $outFile ]]; then
    local dd=`date +%s`
    outFile=$outDir$basename.$dd$outExc
  fi
  run $filename $outFile
}

function ck() {
  #statements
  local dir=$1
  local file=$2
  local outDir=$3
  local filename=$dir$file
  #echo $filename $file
  if [[ -f $filename ]]; then
    cmd $filename $outDir
  fi
  if [[ -d $filename ]]; then
    list $filename/ $outDir $file
  fi
}

function list() {
  for file in `ls $1`; do
    ck $1 $file $2
  done
}

#list /Movies/ /m4v/
pp=`pwd`/
echo $pp
ls
list /Movies/ /m4v/
