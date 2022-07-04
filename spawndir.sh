#!/bin/bash
# Edgar Punzalan - 06292002
# Generates directories and empty files based on parameters passed

# FILESPERDIR  MIN 0
# DEPTH        MIN 1
# SPATH        DEFAULT PWD

usage(){
echo "spawndir.sh -p <start path> -t <depth> -f <files per directory>"
}

if [[ $# < 1 ]]; then
  echo "This tool creates directories and empty files. Parameters are expected."
  usage
  exit 1
fi 

while [ -n "$1" ]; do
   case "$1" in
     -p) 
        SPATH="$2"
        if [[ ! -d ${SPATH} ]]; then
          echo "Invalid directory path ${SPATH}."
          exit 1
        fi 
        if [[ ! -w ${SPATH} ]]; then
          echo "Current user has no write permission on path ${SPATH}."
          exit 1
        fi
        cd ${SPATH}
        shift
        ;;
     -t) 
        DEPTH="$2"
        if [[ ${DEPTH} < 1 ]]; then
          echo "Invalid option ${DEPTH} for -t (Min value is 1)."
          exit 1
        fi 
        shift
        ;;
     -f)
        FILESPERDIR="$2"
        if [[ ${FILESPERDIR} < 0 ]]; then
          echo "Invalid option for ${FILESPERDIR} -f (Min value is 0)."
          exit 1
        fi 
        shift
        ;;
     -?) usage
        exit 0
        ;;        
     *) usage
        exit 1
        ;;        
   esac
   shift
done

for (( DEPTHCTR=1; DEPTHCTR<=${DEPTH}; DEPTHCTR++ )); do
  mkdir tftmp-d${DEPTHCTR}
  cd tftmp-d${DEPTHCTR}  
  if [[ ${FILESPERDIR} > 0 ]]; then
    for (( FILECTR=1; FILECTR<=${FILESPERDIR}; FILECTR++ )); do
      touch tftmp-f${FILECTR}
    done
  fi
done
