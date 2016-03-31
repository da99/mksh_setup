

const FS         = require("fs");
const PATH       = require("path");
const Dir        = process.argv[2];

var data = {};

const files = FS.readdirSync(Dir);

for (var i = 0; i < files.length; i++) {
  var file = files[i];
  data[file] = FS.readFileSync(PATH.join(Dir, file)).toString().trim();
}

console.log(JSON.stringify(data));



