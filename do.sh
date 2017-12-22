#/bin/bash
# bootstrap downloader do.sh
# download the downloader and run it

download() {
  echo $file
  ts=`date +%s`
  if [ -f $file ]; then
	/bin/rm -f $file
  fi
  wget "https://github.com/hakrtech/release/blob/master/$file?raw=true" -O $file
  
}

for file in download.sh
do
  download download.sh
  chmod +x download.sh
  ./download.sh
done

exit 0
