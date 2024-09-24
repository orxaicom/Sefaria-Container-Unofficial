#!/bin/bash

mongod --fork --logpath /var/log/mongodb.log --dbpath /data/db
redis-server --daemonize yes
tail -f /dev/null
