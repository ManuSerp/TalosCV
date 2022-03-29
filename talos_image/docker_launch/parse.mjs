import { readFileSync, writeFileSync } from "fs";
var array = readFileSync("cmd").toString().split("\n");

let data = array[1].split(" ")[0];

writeFileSync("id", data);
