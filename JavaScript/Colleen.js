/*
    Outside comment
*/

function colleen() {
    const s = x => `/*
    Outside comment
*/

function colleen() {
    const s = ${x}
    console.log(s(s));
}

function main() {
    /*
        Inside comment
    */
   colleen()
}

main()`
    console.log(s(s));
}

function main() {
    /*
        Inside comment
    */
   colleen()
}

main()
