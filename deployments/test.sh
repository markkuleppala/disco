#!/bin/bash
wget https://raw.githubusercontent.com/markkuleppala/disco/main/deployments/fio_jobfile.fio

RW="read  write  randread  randwrite"

for NUM_JOBS in 1 2 3
do
        for BS in 512 1024 2048 4096 8192 16384 32768 65536
        do
                for FIO_RW in $RW
                do
                        for i in {1..3..1}
                        do
                                RUNTIME=30 FILESIZE=1G SIZE=1G NUM_JOBS=$NUM_JOBS FIO_RW=$FIO_RW \
                                        fio fio_jobfile.fio \
                                        --directory=/emptydir \
                                        --output-format=json+ \
                                        --blocksize=$BS \
                                        --output=BS$BS-J$NUM_JOBS-$FIO_RW-${i}.json
                                rm -rf emptydir/*.dat
                        done
                done
        done
done

mkdir Results
mv *.json Results/
