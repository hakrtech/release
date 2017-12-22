#/bin/bash
stage1_only=0   # upload both shell scripts, checksum file and splits x*
# stage1_only=1 # upload only shell scripts, checksum file but not splits x*
simulate=0      # do a real upload, so really git commit and push
# simulate=1    # simulate upload, do not really git commit and push

if [ $simulate -eq 1 ]; then
  echo="echo"
else
  echo=""
fi

first=`ls -1 x* | sort -u | head -1`
start=$first
echo first split is $first

last=`ls -1 x* | sort -u | tail -1`
stop=$last
echo last split is $first

# check 2nd arg for stop value
if [[ "$2" == "" ]]; then
  echo "no stop argument"
  stop=$last
  echo "default stop argument is $stop"
else
  stop="$2"
  echo "stop argument is $stop"
fi

# error if stop argument does not exist
if [ ! -f $stop ]; then
  echo "error: stop $stop does not exist"
  exit 1
fi

# check 1st arg for start value
if [[ "$1" == "" ]]; then
  echo "no start argument"
  start=$first
  echo "default start argument is $start"
else
  start="$1"
  echo "start argument is $start"
fi

# error if start argument does not exist
if [ ! -f $start ]; then
  echo "error: start $start does not exist"
  exit 1
fi

upload() {
  if [ ! -f $file ]; then
     echo "warning: no file $file exists"
     return
  fi
  echo $file
  ts=`date +%s`
  git add $file
  git commit -m "rev2.iso $file $ts"
  git push origin master
}

remove() {
  if [ ! -f $file ]; then
     echo "warning: no file $file exists"
     return
  fi
  echo $file
  ts=`date +%s`
  git rm -f $file
  git commit -m "removing rev1.iso $file $ts"
  git push origin master
}

# stage1 uploads
for file in do.sh download.sh upload.sh gensum.sh iso.sh MD5SUM
do
  $echo upload $file
  if [[ "$file" == "$stop" ]]; then
    exit 0
  fi
done

if [ $stage1_only -eq 1 ]; then
  echo "only stage1 uploads"
  exit 0
fi

# stage2 uploads
start_uploading=0
for i in x
do
  for j in a b c d e f g h i j k l m n o p q r s t u v w x y z
  do
    for k in a b c d e f g h i j k l m n o p q r s t u v w x y z
    do
      file="$i$j$k"

      if [[ "$file" == "$start" ]]; then
	start_uploading=1
      fi

      if [ $start_uploading -eq 1 ]; then 
        $echo upload $file
      fi

      if [[ "$file" == "$stop" ]]; then
        start_uploading=0
        exit 0
      fi
    done
  done
done	

exit 0
