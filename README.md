# x86-arc-and-code-injection-demo

▶️ **Demo Video:** https://www.youtube.com/watch?v=ovP3hvB6aew

🏆 **First Place – CyberHacks @ San José State University**

This repository contains the project my team presented at **CyberHacks**, a cybersecurity and low-level computing hackathon hosted at San José State University. The demo focused on showing how unsafe memory practices in **32-bit x86 assembly** can lead to control-flow hijacking — and how simple defensive techniques can stop it.

The goal of this repository is to provide context around the files, payloads, and techniques used during the live demonstration.


## Overview

The project is built around a vulnerable **32-bit x86 assembly program** designed to resemble a simple grocery list application. It uses unsafe input handling to demonstrate how memory corruption vulnerabilities arise at the assembly level.

During the demo, we showed:
- Normal program behavior
- Exploitation of unchecked input boundaries
- Control-flow redirection via arc injection
- Execution of injected machine code
- A hardened version that detects and blocks the attack

The emphasis was on **understanding the mechanics**, not just producing an exploit.



## From Vulnerability to Defense

At the core of the demo is a simple assembly program that reads user input without enforcing length constraints. This allows input data to overflow allocated memory and overwrite critical stack values, including return addresses.

Using this behavior, the demo illustrates how execution flow can be redirected through arc injection and how injected machine code can be executed at runtime. These attacks were demonstrated using raw hex payloads provided via input redirection.

The project then shifts to defense by introducing a stack canary mechanism. By validating stack integrity before returning from a function, the protected version detects corruption and safely aborts execution, preventing the exploit from succeeding.

## Technical Report

A major component of this project is the accompanying technical report:

📄 **Code Injection on 32 bit x86 Assembly Programs.pdf**

This 8-page document was developed alongside the demo and served as both a design reference and explanatory companion during the event. It provides a deeper look into the reasoning, analysis, and methodology behind the attacks and defenses shown live.

The report covers:
- Arc injection attacks on stack and global memory
- Code injection using raw machine opcodes
- Position-independent payload design
- ELF file layout, headers, sections, and segments
- Reverse engineering workflows and tooling
- Practical considerations when working with raw hex payloads

For anyone interested in the *why* and *how* behind the demo beyond the surface-level behavior, this document is the best place to start.


## Repository Structure

This repository is organized to reflect what was used during the live demo:

- `grocerylist.s`  
  Vulnerable 32-bit x86 assembly program used for exploitation

- `grocerylistprotected.s`  
  Hardened version with stack integrity checks enabled

- `library.s`  
  Shared helper routines used by both programs

- `InfiniteLoopPayload.bin`, `HeaderPayload.bin`  
  Raw hex payloads used during the live demonstrations, supplied via input redirection

- `Code Injection on 32 bit x86 Assembly Programs.pdf`  
  Accompanying technical report (see **Technical Report** section above)


## Why This Matters

Many memory-safety vulnerabilities are abstracted away in higher-level languages. Working directly in assembly makes these issues explicit and easier to reason about.

This project was designed to:
- Illustrate how small mistakes in input handling lead to serious security flaws
- Show how exploitation and defense are tightly coupled
- Reinforce why low-level protections still matter today


