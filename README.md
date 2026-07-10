# Parameterized Synchronous FIFO in Verilog

## Overview
This repository contains a **Synchronous FIFO (First-In, First-Out)** memory buffer implemented in Verilog. It uses a single clock domain for both read and write operations.

## Key Features
* **Fully Parameterized:** Easily adjust `DATA_WIDTH` and `FIFO_DEPTH`.
* **Status Flags:** Generates `FULL` and `EMPTY` signals to handle overflow and underflow conditions.
* **Verification Environment:** Includes a comprehensive testbench simulating multiple read/write operational scenarios.

## File Structure
* `sources_1/new/SYNC_FIFO.v` - Main RTL Design Module
* `sim_1/new/Synchronous_FIFO_tb.v` - Simulation Testbench
*
