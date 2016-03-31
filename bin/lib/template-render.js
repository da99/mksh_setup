
const ARGS       = process.argv.slice(2);
const Handlebars = require("handlebars");
const Template   = ARGS.pop();
const Data       = ARGS.pop() || "ENV";
const FS         = require("fs");
const PATH       = require("path");

const source   = FS.readFileSync(Template).toString();
const template = Handlebars.compile(source, {strict: true});
const data     = data_to_object(Data);

// === Loop: each iteration compile '{{ }}'
// === Finish: when no more '{{ }}' can be processed.
// === Reason for loop: Nested vars. '{{ }}' that contain other '{{ }}'
var current = source;
var old     = "";
while (current !== old) {
  old = current;
  current = Handlebars.compile(current, {strict: true})(data);
}

// === Output:
console.log(current);

process.exit(0);
// ==============================================================================

function data_to_object(Data) {
  if (Data === 'ENV')
    return process.env;

  if (FS.statSync(Data).isFile())
    return JSON.parse(FS.readFileSync(Data).toString());

  // === We assume it's a directory:
  const files = FS.readdirSync(Data);
  var file;
  var data = {};
  for (var i = 0; i < files.length; i++) {
    file = files[i];
    data[file] = FS.readFileSync(PATH.join(Data, file)).toString().trim();
  }

  return data;
} // === function



