/*
    Outside comment
*/

function quine() {
    const s = x => `/*
    Outside comment
*/

function quine() {
    const s = ${x}
    console.log(s(s));
}

function main() {
    /*
        Inside comment
    */
   quine()
}

main()`
    console.log(s(s));
}

function main() {
    /*
        Inside comment
    */
   quine()
}

main()
