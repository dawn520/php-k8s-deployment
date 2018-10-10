#开一个临时容器初始化redis集群
kubectl run -i --tty ubuntu --image=ubuntu --restart=Never /bin/bash
#安装ruby及redis模块
apt-get update
apt-get install ruby
apt-get install dnsutils
gem sources --add http://gems.ruby-china.com/  --remove https://rubygems.org/
gem install redis
wget http://download.redis.io/redis-stable/src/redis-trib.rb

ruby redis-trib.rb create  --replicas 1 \
  `dig +short redis-0.redis.default.svc.cluster.local`:6379 \
  `dig +short redis-1.redis.default.svc.cluster.local`:6379 \
  `dig +short redis-2.redis.default.svc.cluster.local`:6379 \
  `dig +short redis-3.redis.default.svc.cluster.local`:6379 \
  `dig +short redis-4.redis.default.svc.cluster.local`:6379 \
  `dig +short redis-5.redis.default.svc.cluster.local`:6379 \
