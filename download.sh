#/bin/bash
last="xmw"

download_fresh() {
  echo $file
  ts=`date +%s`
  if [ -f $file ]; then
	/bin/rm -f $file
  fi
  wget "https://github.com/hakrtech/release/blob/master/$file?raw=true" -O $file
}

download_resume() {
  echo $file
  ts=`date +%s`
  wget -c "https://github.com/hakrtech/release/blob/master/$file?raw=true" -O $file
}

for file in download.sh upload.sh gensum.sh iso.sh MD5SUM
do
  download_fresh $file
done

for i in x
do
  for j in a b c d e f g h i j k l m n o p q r s t u v w x y z
  do
    for k in a b c d e f g h i j k l m n o p q r s t u v w x y z
    do
      file="$i$j$k"
      download_resume $file
      if [[ "$file" == "$last" ]]; then
        exit 0
      fi
    done
  done
done	
exit 0
