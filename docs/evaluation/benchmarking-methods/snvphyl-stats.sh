#!/bin/sh

if [ $# -ne 4 ]
then
	echo "Usage: $0 [fastq_dir] [reference] [output_dir] [snvphyl_log]"
	exit 1
fi

fastq_dir=$1
reference=$2
output_dir=$3
snvphyl_log=$4

echo "Disk before docker - `date`"
du -sh /var/lib/docker/

echo "Start docker"
docker_id=`docker run -d -p 48888:80 -v $fastq_dir:$fastq_dir phacnml/snvphyl-galaxy-1.0.1:1.0.1b | tr -d '\n'`
echo -n "Waiting 90s for docker to start..."
sleep 90
echo "started"

echo "Disk before SNVPhyl - `date`"
du -sh /var/lib/docker/

echo "Memory before SNVPhyl - `date`"
cat /sys/fs/cgroup/memory/docker/$docker_id/memory.stat

snvphyl.py --galaxy-url http://localhost:48888 --galaxy-api-key admin --fastq-dir $fastq_dir --reference-file $reference --fastq-files-as-links --output-dir $output_dir > $snvphyl_log &

while [ "`pgrep -f snvphyl.py`" != "" ]
do
	echo "Memory during SNVPhyl - `date`"
        cat /sys/fs/cgroup/memory/docker/$docker_id/memory.stat
        sleep 5
done

echo "Peak memory usage after SNVPhyl - `date`"
cat /sys/fs/cgroup/memory/docker/$docker_id/memory.max_usage_in_bytes

echo "Disk usage after SNVPhyl - `date`"
du -sh /var/lib/docker/

docker rm -f -v $docker_id
