#!/bin/bash
module load python
a=`/sbin/ip route get 8.8.8.8 | awk '{print $NF;exit}'`
jupyter-notebook --no-browser --ip="$a"
