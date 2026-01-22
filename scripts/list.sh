#!/bin/bash
REDIS_HOST=redis-server
#REDIS_HOST=localhost

restaurant_ids=$(redis-cli -h $REDIS_HOST -p 6379 SMEMBERS restaurants)
#echo "${restaurant_ids}"

for id in $restaurant_ids; do
    restaurant_name=$(redis-cli -h $REDIS_HOST -p 6379 HGET "restaurant:$id" name)
    restaurant_tags=$(redis-cli -h $REDIS_HOST -p 6379 HGET "restaurant:$id" tags)

    echo "${id}. ${restaurant_name} ${restaurant_tags}"
done