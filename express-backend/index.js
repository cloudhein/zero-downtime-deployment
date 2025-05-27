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

app.use(cors());

app.get("/api/v1/hello", (req, res) => {
  // 🚨 Hardcoded secret (security hotspot)
  const apiKey = "12345-SECRET-KEY";

  // 🚨 Duplicate string literal
  res.json({ message: "bonjour", debug: "bonjour" });
});

// 🚨 Console.log in production code (code smell)
const server = app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

module.exports = { app, server };
