#!/usr/bin/ksh

### step 1 : 创建队列管理器
crtmqm -h 1024 -lp 20 -ls 5 -u FULL_QM1.DLQ FULL_QM1
strmqm FULL_QM1
echo "DEFINE LISTENER ('LISTENER.TCP') TRPTYPE (TCP) PORT (5000) CONTROL (QMGR)" | runmqsc FULL_QM1
echo "START  LISTENER ('LISTENER.TCP')" | runmqsc FULL_QM1
echo "DEFINE CHANNEL ('SYSTEM.ADMIN.SVRCONN') CHLTYPE (SVRCONN)" | runmqsc FULL_QM1

crtmqm -h 1024 -lp 20 -ls 5 -u PART_QM1.DLQ PART_QM1
strmqm PART_QM1
echo "DEFINE LISTENER ('LISTENER.TCP') TRPTYPE (TCP) PORT (5002) CONTROL (QMGR)" | runmqsc PART_QM1
echo "START  LISTENER ('LISTENER.TCP')" | runmqsc PART_QM1
echo "DEFINE CHANNEL ('SYSTEM.ADMIN.SVRCONN') CHLTYPE (SVRCONN)" | runmqsc PART_QM1

crtmqm -h 1024 -lp 20 -ls 5 -u PART_QM2.DLQ PART_QM2
strmqm PART_QM2
echo "DEFINE LISTENER ('LISTENER.TCP') TRPTYPE (TCP) PORT (5003) CONTROL (QMGR)" | runmqsc PART_QM2
echo "START  LISTENER ('LISTENER.TCP')" | runmqsc PART_QM2
echo "DEFINE CHANNEL ('SYSTEM.ADMIN.SVRCONN') CHLTYPE (SVRCONN)" | runmqsc PART_QM2

### step 2 : 添加完整仓储库定义
echo "ALTER QMGR REPOS ('NEW_CLUSTER')" | runmqsc FULL_QM1 

### step 3 : 在队列管理器上创建接收通道
echo "DEFINE CHANNEL ('TO.FULL_QM1') CHLTYPE (CLUSRCVR) TRPTYPE (TCP) CONNAME ('192.168.2.85(5000)') CLUSTER ('NEW_CLUSTER')" | runmqsc FULL_QM1 
echo "DEFINE CHANNEL ('TO.PART_QM1') CHLTYPE (CLUSRCVR) TRPTYPE (TCP) CONNAME ('192.168.2.85(5002)') CLUSTER ('NEW_CLUSTER')" | runmqsc PART_QM1 
echo "DEFINE CHANNEL ('TO.PART_QM2') CHLTYPE (CLUSRCVR) TRPTYPE (TCP) CONNAME ('192.168.2.85(5003)') CLUSTER ('NEW_CLUSTER')" | runmqsc PART_QM2

### step 4 : 在队列管理器上创建发送通道
echo "DEFINE CHANNEL ('TO.FULL_QM1') CHLTYPE (CLUSSDR) TRPTYPE (TCP) CONNAME ('192.168.2.85(5000)') CLUSTER ('NEW_CLUSTER') " | runmqsc PART_QM1 
echo "DEFINE CHANNEL ('TO.FULL_QM1') CHLTYPE (CLUSSDR) TRPTYPE (TCP) CONNAME ('192.168.2.85(5000)') CLUSTER ('NEW_CLUSTER') " | runmqsc PART_QM2

### step 5 : 在两个部分仓储库队列管理器上定义集群队列
echo "DEFINE QLOCAL ('TEST_QUEUE') CLUSTER ('NEW_CLUSTER')" | runmqsc PART_QM1 
echo "DEFINE QLOCAL ('TEST_QUEUE') CLUSTER ('NEW_CLUSTER')" | runmqsc PART_QM2
