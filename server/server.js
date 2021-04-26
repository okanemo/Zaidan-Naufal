const express = require("express");
const apiRouter = require("./routes"); 
const app = express();

app.use(express.json());
app.use("/", apiRouter)
app.listen(process.env.Port || "3000", () => {
    console.log(`Server is running on port: ${process.env.PORT || "3000"}`);
})