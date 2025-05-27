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

app.use(cors());

// 🚨 Hardcoded secret (security hotspot)
const API_SECRET = "super-secret-api-key-123";

// 🚨 Use of eval (security hotspot)
const dynamicCode = "2 + 2";
eval(dynamicCode); // <-- 🔥

app.get("/api/v1/hello", (req, res) => {
  // 🚨 Duplicate string literals
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

module.exports = { app, server };
