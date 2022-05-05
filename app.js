const importCsv = require("csvtojson");
const { tableName, uuid_key, field_name } = require("./config");
const fs = require("fs");
const { v4: uuidv4 } = require("uuid");
const _ = require("lodash");

let items;
(async () => {
  items = await importCsv().fromFile(`./input.csv`);
  let finalItems = [];
  for (let k = 0; k < items.length; k++) {
    const keys = Object.keys(items[k]);
    for (let i = 0; i < keys.length; i++) {
      let type;
      if (typeof keys[i] == "string") {
        type = "S";
      }
      if (typeof keys[i] == "number") {
        type = "N";
      }
      items[k][uuid_key] = { S: uuidv4() };
      if (field_name) {
        items[k][`field_name`] = { S: field_name };
      }
      items[k][`${keys[i]}`] = { [`${type}`]: items[k][`${keys[i]}`] };
    }
    finalItems.push({
      PutRequest: {
        Item: items[k],
      },
    });
    console.log(`Item ${k} created.`);
  }

  const chunksize = 25;
  const chunks = _.chunk(finalItems, chunksize);
  for (let n = 0; n < chunks.length; n++) {
    const data = {
      [`${tableName}`]: chunks[n],
    };
    fs.writeFileSync(`./output/${tableName}_${n}.json`, JSON.stringify(data));
    console.log(`Exported ${(n + 1) * chunksize} items.`);
  }
  if (finalItems.length % chunksize != 0) {
    console.log(`Exported ${finalItems.length} items.`);
  }
  const sleep = (ms = 15000) => new Promise((r) => setTimeout(r, ms));
  sleep();
  console.log(`
---------------------------
Conversion completed!
Run UPLOAD.SH to upload file to DynamoDB. Check output folder to make sure the table name is correct.
  `);
})();
