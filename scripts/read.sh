#!/bin/bash
REDIS_HOST=redis-server
#REDIS_HOST=localhost

restaurant_ids=$(redis-cli -h $REDIS_HOST -p 6379 SMEMBERS restaurants)
#echo "${restaurant_ids}"

for id in $restaurant_ids; do
    echo "Restaurant ID: $id"
    restaurant_data=$(redis-cli -h $REDIS_HOST -p 6379 HGETALL "restaurant:$id")
    
    # Parse and display restaurant data
    while read -r key; do
        read -r value
        case "$key" in
            "name") echo "Name: $value" ;;
            "address") echo "Address: $value" ;;
            "website") echo "Website: $value" ;;
            "phone") echo "Phone: $value" ;;
            "tags") echo "Tags: $value" ;;
        esac
    done <<< "$restaurant_data"
    
    echo "-------------------"
done