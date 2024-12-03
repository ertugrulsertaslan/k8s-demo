import express from "express";
const app = express();

const PORT = 8080;

app.get("/api", (req, res) => {
  res.json({ message: "Hello from backend !" });
});

app.listen(PORT, () => {
  console.log(`Backend server running on ${PORT}`);
});
