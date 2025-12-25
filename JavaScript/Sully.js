(function sully(i) {
    const fs = require('fs');
    const { basename } = require('path');
    const { exec } = require('child_process');
    if (basename(__filename).includes("_"))
        --i;
    if (i < 0) return (1);
    const file = `Sully_${i}.js`;
    const code = `(${sully.toString()})(${i})
`;

    fs.writeFile(file, code, function(e) {
        if (e) return console.error(e);
        exec(`node ${file}`);
    });
})(5)
