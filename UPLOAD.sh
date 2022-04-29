#!/bin/bash

avg=0
item=0
start_timet=$(date +%s)

search_dir="O:\OneDrive\Projects\MFVN\AWS_DB_upload_CSV_JSON\output"
index=0
for entry in "$search_dir"/*
do
#Upload
((item++))
printf "Item: %s\n" "$item"
start_time=$(date +%s)
#AWS	
    aws dynamodb batch-write-item --request-items file://$entry 
    ((index++))
#AWS
end_time=$(date +%s)
elapsed=$(( end_time - start_time ))
elapsedx=$(( end_time - start_timet ))
elapsedt=$(( elapsed/60 ))
printf "upload time: %s sec   time elapsed: %s min\n" "$elapsed" "$elapsedt"
done
#Finish
end_timet=$(date +%s)
total=$(( end_timet - start_timet ))
avg=$((total/item))
totalm=$((total/60))
printf "Upload complete!\n"
printf "Average item upload time: %s seconds.\n" "$avg"
printf "Total time: %s minutes.\n" "$totalm"
printf "Total time: %s seconds.\n" "$total"
sleep 15m