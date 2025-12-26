<h1 align="center">Dr Quine</h1>

<p align="center">
    <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square&logo=opensourceinitiative&logoColor=white" alt="License"/>
    <img src="https://img.shields.io/badge/status-finished-brightgreen?style=flat-square&logo=git&logoColor=white" alt="Status">
    <!-- <img src="https://img.shields.io/badge/score-125%2F100-3CB371?style=flat-square&logo=42&logoColor=white" alt="Score"/> -->
    <!-- <img src="https://img.shields.io/badge/date-May%2026,%202023-ff6984?style=flat-square&logo=Cachet&logoColor=white" alt="Date"/> -->
</p>

> A self-replicating program in C, assembly, and javaScript.

---

## 🚀 Overview

Dr-Quine is a multi-language exploration of self-reproducing programs (quines). The project implements three variants — Colleen, Grace, and Sully — in C, x86-64 Assembly, and JavaScript.

## 🧰 Tech Stack: ![C](https://img.shields.io/badge/-C-A8B9CC?style=flat-square&logo=C&logoColor=black) ![JavaScript](https://img.shields.io/badge/-JavaScript-f7df1e?style=flat-square&logo=JavaScript&logoColor=black) ![Assembly](https://img.shields.io/badge/-Assembly-000000?style=flat-square&logo=assemblyscript&logoColor=white) ![Make](https://img.shields.io/badge/-Make-000000?style=flat-square&logo=gnu&logoColor=white)

## 📦 Features

- Multi-language quine: Implements the same quine concepts consistently across C, Assembly (NASM), and JavaScript.
- Different variants: Includes Colleen (prints itself), Grace (writes a copy to disk), and Sully (self-replicating countdown).
- Automated verification: Makefiles test each program using byte-for-byte comparisons to guarantee exact reproduction.

---

## 🛠️ Configuration

### Prerequisites

- Compiler for C (e.g. `gcc` or `clang`), `make`, `node`, `nasm`

### Installation & Usage

```bash

```

### Examples & Demo

```bash

```

### Development

```bash

```

---

## 📝 Notes & Lessons

- The general idea: Colleen will print the quine on stdout, Grace will print the quine in a file, Sully will print the quine in a file and execute it.
- Marco in assembly is similar to a `#define F(X)` in C.
- `awk '{gsub(/%/, "%%"); gsub(/"/, "%2$c"); printf "%s%%1$c", $0 }' x.s`
- Different types of printf.
- equ vs define in ASM: equ evaluates expression immediately, stores numeric result; define is pure text substitution, re-evaluated each use.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 📫 Contact

Darren Kuro – [darren0xa@gmail.com](mailto:darren0xa@gmail.com)

GitHub: [@darrenkuro](https://github.com/darrenkuro)
