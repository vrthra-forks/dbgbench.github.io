#!/bin/bash
if [ $# -lt 2 ]; then
  echo "Usage: $0 <subject> <name>"
  exit 1
fi
subject=$1
name=$2

if [ -z "$(which docker)" ]; then
  echo "Install docker from http://docs.docker.com/engine/installation/"
  exit 1
fi
if [ $(docker images | grep -c "CREATED") -eq 0 ]; then
  echo "Run boot2docker to set up docker environment."
  exit 1
fi
if [ $(docker images | grep -c "debugstudy$subject ") -eq 0 ]; then
  echo "Installing image.. This will be done only once and may take up to one hour."
  docker build -t debugstudy$subject -f scripts/docker.$subject . || exit 1
fi

exit_code=0

if [ $(docker ps | grep -c "$name") -ne 0 ]; then
  echo "A container named $name is already running. Try reusing it."
  exit 0
fi

#if [ $(docker ps | grep -c "debugstudy$subject ") -ne 0 ]; then
#  echo "An instance of 'debugstudy' is already running ($(docker ps | grep "debugstudy$subject " | cut -c-12))"
#  echo "You can use VNCViewer from your Desktop or a different terminal window to access: "
#  echo "$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${name}):5900 (password: corebench)"
#  echo ""
#  echo "Connecting .."
#  if [ -z "$2" ]; then
#    docker exec -it $(docker ps | grep "debugstudy$subject " | cut -c-12) bash
#  else
#    echo "$2" | docker exec -i $(docker ps | grep "debugstudy$subject " | cut -c-12) bash
#    exit_code=$?
#  fi
#
#  exit $exit_code
#fi

printf "Running container: "
docker run -dt --name ${name} -v $(pwd):/shared --dns 8.8.8.8 --dns 8.8.4.4 debugstudy${subject} | cut -c-12
echo "Now use VNCViewer from your Desktop or a different terminal window to access: "
echo "$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${name}):5900 (password: corebench)"
echo
echo Note: Once the container is removed or broken, any temporary data will be lost!
echo Use the '/shared'-folder for scripts and data which you would like to keep.  
echo
echo Connecting..
if [ -z "$3" ]; then
  docker exec -it $name bash
else 
  echo "$3" | docker exec -i $name bash
  exit_code=$?
fi
exit $exit_code
