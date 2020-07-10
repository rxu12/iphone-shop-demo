const express = require("express");
const path = require("path");
const app = express();

app.use(express.static(path.join(__dirname, "build")));

app.get("/CCP", function (req, res) {
  res.json({ CCP_Client_Secret: process.env.CCP_Client_Secret });
});

app.get("/*", function (req, res) {
  res.sendFile(path.join(__dirname, "build", "index.html"));
});

app.listen(process.env.WEBSITES_PORT || 9000);
