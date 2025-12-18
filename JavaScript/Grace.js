(function quine() {
    /*
        comment
    */
    const fs = require('fs');
    const file = "Grace_kid.js";
    const code = `(${quine.toString()})()
`;

    fs.writeFile(file, code, function(e) {
        if (e) return console.error(e);
    })
})()
