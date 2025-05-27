const express = require("express");
const app = express();
const cors = require("cors");
const port = 3000;

// 🚨 Unused variable (code smell)
const unusedVar = "This is not used";

// 🚨 Function declared but never used (code smell)
function unusedFunction() {
  console.log("I'm never called!");
}

// 🚨 Deprecated API usage (example)
const fs = require("fs");
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

// Additional fail cases

// Uncaught throw in route
app.get("/api/v1/error", (req, res) => {
  throw new Error("Uncaught error!");
});

// Empty catch block
try {
  JSON.parse("invalid json again");
} catch (e) {
  // empty catch block 🚨
}

// Magic number usage
const timeout = 3000;
setTimeout(() => {
  console.log("Timeout expired");
}, timeout);

// Callback without error handling
fs.readFile("somefile.txt", (err, data) => {
  // no error check 🚨
  console.log(data.toString());
});

// Function with too many parameters
function tooManyParams(a, b, c, d, e, f) {
  return a + b + c + d + e + f;
}

// Using var instead of let/const
var oldStyle = "var is outdated";

// Empty function
function emptyFunc() {}

// Blocking sync API call
const data = fs.readFileSync("file.txt");
console.log(data.toString());

module.exports = { app, server };
