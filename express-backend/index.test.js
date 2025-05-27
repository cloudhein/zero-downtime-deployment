const express = require("express");
const app = express();
const cors = require("cors");
const fs = require("fs");
const port = 3000;

// 🚨 Unused variable (code smell)
const unusedVar = "This is not used";

// 🚨 Function declared but never used (code smell)
function unusedFunction() {
  console.log("I'm never called!");
}

// 🚨 Deprecated API usage (example)
fs.exists("somefile.txt", (exists) => {
  console.log("Deprecated fs.exists used");
});

// 🚨 Hardcoded secret (security hotspot)
const API_SECRET = "super-secret-api-key-123";

// 🚨 Use of eval (security hotspot)
const dynamicCode = "2 + 2";
eval(dynamicCode); // <-- 🔥

// 🚨 Duplicate string literals
app.use(cors());
app.get("/api/v1/hello", (req, res) => {
  res.json({ message: "bonjour", debug: "bonjour" });
});

// 🚨 Unhandled promise (bug)
Promise.resolve("ok").then((val) => {
  JSON.parse("{ invalid json }"); // 🔥 Will crash but not caught
});

// 🚨 Console.log in production
const server = app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

// New fail cases:

// 🚨 Throw uncaught error in route
app.get("/api/v1/error", (req, res) => {
  throw new Error("Uncaught error!"); // Server will crash here if not caught
});

// 🚨 Empty catch block (code smell)
try {
  JSON.parse("invalid again");
} catch (e) {
  // intentionally empty catch — bad practice
}

// 🚨 Magic number without explanation
const timeout = 3000;
setTimeout(() => {
  console.log("Timeout done");
}, timeout);

// 🚨 Callback without error handling
fs.readFile("somefile.txt", (err, data) => {
  // no error check on err
  console.log(data.toString());
});

// 🚨 Use var instead of let/const (code smell)
var oldStyleVar = "var is outdated";

// 🚨 Empty function (code smell)
function emptyFunc() {}

// 🚨 Blocking sync call
const data = fs.readFileSync("file.txt");
console.log(data.toString());

module.exports = { app, server };
