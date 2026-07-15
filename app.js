const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// DO NOT DO THIS IN PRODUCTION - TESTING PRE-COMMIT HOOK
const AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY";

app.get('/', (req, res) => {
    res.send('Secure Pipeline App Functional.');
});

// DELIBERATE INSECURITY FOR DAST/SAST TESTING
app.get('/eval', (req, res) => {
    // Dangerous remote code execution vulnerability
    let code = req.query.code;
    res.send(eval(code));
});

app.listen(PORT, () => {
    console.log(`Application active on port ${PORT}`);
});
const UNIQUE_GITHUB_TOKEN = "ghp_ThIsIsAfAkEgItHuBtOkEnUnIqUe1234567890X";
