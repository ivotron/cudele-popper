#!/bin/bash

#echo "-- untar the journal"
#DIR="experiments/kernel/journal/results-done"
#SUBDIRS=`ls $DIR`
#MDS="issdm-12"
#for i in $SUBDIRS; do
#  cd $DIR/$i
#  echo "DIR=" `pwd`
#  for j in `ls *.tar.gz`; do
#    tar xzf $j
#    if [ $j == $MDS.tar.gz ]; then
#      echo "... parsing MDS=$j"    
#      for m in \
#         "tmp/graphite/whisper/$MDS/mds_mem/ino.wsp" \
#         "tmp/graphite/whisper/$MDS/mds_mem/ino+.wsp" \
#         "tmp/graphite/whisper/$MDS/mds_mem/ino-.wsp" \
#         "tmp/graphite/whisper/$MDS/mds/inodes.wsp" \
#         "tmp/graphite/whisper/$MDS/mds/inodes_bottom.wsp" \
#         "tmp/graphite/whisper/$MDS/mds/inodes_with_caps.wsp" \
#         "tmp/graphite/whisper/$MDS/mds/inodes_pin_tail.wsp" \
#         "tmp/graphite/whisper/$MDS/mds/inodes_pinned.wsp" \
#         "tmp/graphite/whisper/$MDS/mds/inodes_top.wsp" \
#         "tmp/graphite/whisper/$MDS/mds_server/handle_client_request_tput.wsp" \
#         "tmp/graphite/whisper/$MDS/cputotals/user.wsp" \
#         "tmp/graphite/whisper/$MDS/cputotals/sys.wsp" \
#        ; do
#        docker run -v `pwd`/tmp:/tmp --entrypoint=whisper-dump.py --rm \
#          michaelsevilla/graphite ${m} > `basename ${m}`.out
#        docker run -v `pwd`/:/tmp --entrypoint=/bin/bash --rm \
#          michaelsevilla/graphite -c "sed -i \"s/:/,/g\" tmp/`basename $m`.out"
#        echo "... ... `basename $m`"
#      done
#    fi
#  done
#  cd - >> /dev/null
#done
#
#DIR="experiments/kernel/journal/results/journal180-cache"
#SUBDIRS=`ls $DIR`
#MDS="issdm-12"
#cd $DIR
#echo "DIR=" `pwd`
#for j in `ls *.tar.gz`; do
#  tar xzf $j
#  if [ $j == $MDS.tar.gz ]; then
#    echo "... parsing MDS=$j"    
#    for m in \
#       "tmp/graphite/whisper/$MDS/mds_server/handle_client_request_tput.wsp" \
#      ; do
#      docker run -v `pwd`/tmp:/tmp --entrypoint=whisper-dump.py --rm \
#        michaelsevilla/graphite ${m} > `basename ${m}`.out
#      docker run -v `pwd`/:/tmp --entrypoint=/bin/bash --rm \
#        michaelsevilla/graphite -c "sed -i \"s/:/,/g\" tmp/`basename $m`.out"
#      echo "... ... `basename $m`"
#    done
#  fi
#done
#cd - >> /dev/null

echo "-- untar consistency experiments"
DIR="experiments/fuse/consistency/results-old/nojournal-cache/"
MDS="issdm-18"
cd $DIR
for j in `ls *.tar.gz`; do
  tar xzf $j
  if [ $j == $MDS.tar.gz ]; then
    echo "... parsing MDS=$j"    
    for m in \
       "tmp/graphite/whisper/$MDS/mds_server/handle_client_request_tput.wsp" \
       "tmp/graphite/whisper/$MDS/mds_server/req_create.wsp" \
       "tmp/graphite/whisper/$MDS/mds_server/req_lookup.wsp" \
      ; do
      docker run -v `pwd`/tmp:/tmp --entrypoint=whisper-dump.py --rm \
        michaelsevilla/graphite ${m} > `basename ${m}`.out
      docker run -v `pwd`/:/tmp --entrypoint=/bin/bash --rm \
        michaelsevilla/graphite -c "sed -i \"s/:/,/g\" tmp/`basename $m`.out"
      echo "... ... `basename $m`"
    done
  fi
  echo "... done with $j"
done
