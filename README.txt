- Please change directory in CONVERT.bat and UPLOAD.sh to your directory 
- Create "output" folder (case sensitive) in the main folder 
- Before each run, please change the table name in config.js to your DynamoDB table name

Test example:
- Copy input.csv into the main folder
- Make sure the "output" folder was created in the main folder
- Run CONVERT.bat to convert input file to multiple json files, each json file contains 25 items, the result files are in output folder
- Run UPLOAD.sh to upload all items to DynamoDB