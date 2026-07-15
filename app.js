const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send("Secure DevSecOps Pipeline Application Running!");
});

// Safe endpoint: No eval()
app.get('/eval', (req, res) => {
    res.send("Dynamic execution is disabled for security compliance.");
});

app.listen(PORT, () => {
    console.log(`Application active on port ${PORT}`);
});
