#!/bin/bash

avg=0
pack=0
start_timet=$(date +%s)
echo "--------------------" >> upload_log.txt
echo $(date +'%Y/%m/%d') >> upload_log.txt
search_dir="O:\OneDrive\Projects\MFVN\AWS_DB_upload_CSV_JSON\output"
index=0
for entry in "$search_dir"/*
do
#Upload
((pack++))
printf "Package: %s\n" "$pack"
start_time=$(date +%s)
#AWS	
    aws dynamodb batch-write-item --request-items file://$entry 
    ((index++))
#AWS
end_time=$(date +%s)
elapsed=$(( end_time - start_time ))
elapsedx=$(( end_time - start_timet ))
elapsedt=$(( elapsedx/60 ))
printf "upload time: %s sec   time elapsed: %s min\n" "$elapsed" "$elapsedt"
done
#Finish
end_timet=$(date +%s)
total=$(( end_timet - start_timet ))
avg=$((total/pack))
totalm=$((total/60))
items=$((pack*25))
line="------------------------"
printf "%s\n" "$line"
printf "Upload completed!\n"
printf "%s packages ~%s items uploaded\n" "$pack" "$items"
printf "%s packages ~%s items uploaded\n" "$pack" "$items" >> upload_log.txt
printf "Average package upload time: %s seconds.\n" "$avg"
printf "Total time: %s minutes (%s seconds).\n" "$totalm" "$total"
printf "Total time: %s minutes (%s seconds).\n" "$totalm" "$total" >> upload_log.txt
sleep 30m