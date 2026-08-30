# Hybrid Memristor-CMOS Multiplier with Adaptive Clock Gating

<p align="center">

## A Low-Power Hybrid Memristor-CMOS Multiplier Using Adaptive Clock Gating

[![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)]()
[![VLSI](https://img.shields.io/badge/Domain-VLSI%20Design-orange)]()
[![Low Power](https://img.shields.io/badge/Focus-Low%20Power-green)]()
[![Memristor](https://img.shields.io/badge/Technology-Memristor%2BCMOS-purple)]()
[![Simulation](https://img.shields.io/badge/Simulation-Digital%20Behavioral-yellow)]()

</p>

---

## 📌 Project Overview

This project presents a **low-power hybrid Memristor-CMOS multiplier architecture enhanced with Adaptive Clock Gating (ACG)**.

The work builds upon an existing **2×2 hybrid Memristor-CMOS multiplier architecture** based on memristive universal logic gates. An input-aware adaptive clock gating mechanism is introduced to reduce unnecessary switching activity when the multiplier inputs remain unchanged.

The proposed architecture combines:

* **Memristive logic** for compact arithmetic computation
* **CMOS logic** for control and sequential operations
* **Adaptive Clock Gating** for dynamic power reduction
* **Verilog behavioral modeling** for digital verification
* **Comparative analysis** against conventional CMOS and baseline hybrid designs

According to the simulation results reported in the associated paper, the proposed architecture achieves:

| Parameter                              |    Result |
| -------------------------------------- | --------: |
| Power reduction vs. base hybrid design | **72.2%** |
| Power reduction vs. conventional CMOS  | **80.5%** |
| Clock gating efficiency                | **76.3%** |
| PDP improvement vs. base hybrid        | **72.2%** |
| Memristors                             |    **16** |
| Transistors                            |    **22** |
| Multiplier size                        | **2 × 2** |

> **Note:** The reported power values are based on the relative digital simulation model described in the paper rather than measured silicon power.

---

# 🧠 Motivation

Modern edge-AI, IoT, and mobile computing systems require arithmetic circuits that provide high computational efficiency while minimizing energy consumption.

Conventional CMOS multipliers provide reliable digital operation, but their switching activity can result in significant dynamic power consumption.

Memristors provide attractive characteristics such as:

* Non-volatility
* Nanoscale dimensions
* Potentially high density
* Reduced device count for certain logic functions

However, completely memristor-based architectures introduce challenges related to control, sequential operation, and integration with conventional digital systems.

A **hybrid Memristor-CMOS architecture** therefore provides a practical approach by combining the advantages of both technologies.

This project further addresses dynamic power consumption by introducing **input-aware Adaptive Clock Gating**.

---

# 🎯 Project Objectives

The main objectives of this project are:

1. Design a hybrid Memristor-CMOS multiplier.
2. Implement an adaptive clock gating mechanism.
3. Detect whether multiplier inputs have changed between clock cycles.
4. Disable the clock when no new computation is required.
5. Reduce unnecessary switching activity.
6. Verify the multiplier functionality using Verilog.
7. Compare the proposed architecture with conventional CMOS and baseline hybrid implementations.
8. Evaluate power, delay, PDP, and clock-gating efficiency.

---

# 🏗️ Architecture

The project evaluates three multiplier architectures.

### 1. Conventional CMOS Multiplier

A conventional transistor-based multiplier is used as the baseline.

**Configuration:**

* 28 transistors
* No memristors
* Relative power = 100%

---

### 2. Base Hybrid Memristor-CMOS Multiplier

The baseline hybrid architecture is based on a memristive universal logic gate.

Each universal gate consists of:

* 4 memristors
* 2 transistors

The universal gate provides multiple logic functions, including:

* AND
* OR
* XOR

The 2×2 multiplier uses these gates to generate the required partial products and perform addition.

**Configuration:**

* 8 transistors
* 16 memristors
* Relative power = 70%

---

### 3. Proposed Adaptive Clock Gating Multiplier

The proposed design extends the base hybrid architecture by adding an **input-aware clock control mechanism**.

The system monitors the current inputs against their previous values.

If the inputs change:

```text
Input Changed
      ↓
Enable Clock
      ↓
Multiplier Computation
```

If the inputs remain unchanged:

```text
Input Unchanged
      ↓
Disable Clock
      ↓
Avoid Unnecessary Switching
```

The proposed implementation contains:

* 16 memristors
* 22 transistors
* Input storage
* Change detection logic
* Clock controller

---

# 🔲 System Block Diagram

```text
                    ┌─────────────────────┐
                    │      Input A[1:0]   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    Input Monitor    │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Change Detector   │
                    │                     │
                    │ A ≠ A_prev OR       │
                    │ B ≠ B_prev          │
                    └──────────┬──────────┘
                               │
                         Input Changed?
                         ┌─────┴─────┐
                         │           │
                        YES          NO
                         │           │
                         ▼           ▼
                  ┌────────────┐  ┌───────────┐
                  │   Clock    │  │   Clock   │
                  │  Enabled   │  │   Gated   │
                  └─────┬──────┘  └───────────┘
                        │
                        ▼
             ┌────────────────────────┐
             │ Hybrid Memristor-CMOS  │
             │       Multiplier       │
             └───────────┬────────────┘
                         │
                         ▼
                    ┌───────────┐
                    │ Product   │
                    │   P[3:0]  │
                    └───────────┘

                    Input B[1:0]
                         │
                         └──────► Input Monitor
```

---

# 🔬 Hybrid Memristor-CMOS Logic

The base architecture uses a **Memristor Ratioed Logic (MRL)** based universal gate.

Conceptually:

```text
              ┌─────────────────────────┐
      A ─────►│                         │────► AND
              │  Memristive Universal  │────► OR
      B ─────►│        Logic Gate       │────► XOR
              │                         │
              └─────────────────────────┘

                  4 Memristors
                        +
                  2 Transistors
```

This allows multiple logic functions to be obtained from a compact hybrid structure.

---

# ✖️ 2×2 Multiplier Operation

For two 2-bit operands:

```text
A = A1 A0
B = B1 B0
```

The partial products are:

```text
pp0 = A0 · B0
pp1 = A0 · B1
pp2 = A1 · B0
pp3 = A1 · B1
```

These partial products are then combined using the hybrid logic structure to generate the final 4-bit product.

```text
             A1 A0
           × B1 B0
           ─────────
             pp0
            pp1
            pp2
           pp3
           ─────────
           P3 P2 P1 P0
```

The architecture therefore performs complete **2×2 binary multiplication** while using the hybrid Memristor-CMOS logic structure.

---

# ⚡ Adaptive Clock Gating

## Why Clock Gating?

Dynamic power consumption is strongly associated with switching activity.

A simplified dynamic power relationship is:

$$
P_{dynamic} = \alpha C_L V_{DD}^{2} f
$$

where:

* $\alpha$ = switching activity
* $C_L$ = effective load capacitance
* $V_{DD}$ = supply voltage
* $f$ = operating frequency

The adaptive clock gating mechanism primarily reduces unnecessary switching by reducing the effective clock activity when computation is not required.

---

# 🔄 Adaptive Clock Gating Algorithm

The algorithm continuously compares the current inputs with the inputs from the previous clock cycle.

### Algorithm

```text
Initialize:

A_prev = 0
B_prev = 0

For every clock cycle:

    If A != A_prev OR B != B_prev:

        clock_gated = clock

    Else:

        clock_gated = 0

    A_prev = A
    B_prev = B
```

### Pseudocode

```text
Input:
    A[1:0]
    B[1:0]
    clk

Output:
    clk_gated

Initialize:
    A_prev = 0
    B_prev = 0

For every clock cycle:

    if (A != A_prev) OR (B != B_prev)
        clock_gated = clk
    else
        clock_gated = 0

    A_prev = A
    B_prev = B
```

---

# 🧩 Clock Gating Hardware

The adaptive control mechanism requires:

* Input storage using D flip-flops
* Change detection logic
* Clock control logic

The paper reports:

```text
6 D Flip-Flops
5 Logic Gates
Additional control transistors
```

The resulting proposed architecture contains:

```text
16 Memristors
22 Transistors
```

---

# 💻 Verilog Memristor Behavioral Model

A simplified behavioral model of the memristor was implemented in Verilog for digital simulation.

The model represents the memristor using a discrete internal state.

The state transitions between:

```text
HIGH_RE
   ↕
LOW_RE
```

based on the input condition.

Conceptually:

```text
                 Input
                   │
                   ▼
           ┌───────────────┐
           │ State Update  │
           └───────┬───────┘
                   │
                   ▼
             Internal State
                   │
          ┌────────┴────────┐
          ▼                 ▼
       HIGH_RE            LOW_RE
        Logic 1            Logic 0
```

The model is intended for **digital behavioral simulation**, rather than detailed physical memristor device modeling.

---

# 🧪 Verification Strategy

A structured Verilog testbench was used to evaluate the multiplier architectures.

The verification strategy includes:

### Functional Verification

All possible combinations of the two 2-bit inputs were tested.

For a 2×2 multiplier:

$$
2^2 \times 2^2 = 16
$$

input combinations are possible.

Therefore:

```text
Total input combinations = 16
```

---

### Performance Evaluation

The architectures were compared using:

* Relative power
* Delay
* Power-Delay Product
* Clock gating efficiency
* Device count

---

### Comparative Evaluation

All three architectures were evaluated under comparable simulation conditions:

```text
Conventional CMOS
       │
       ├──────────────┐
       │              │
       ▼              ▼
 Base Hybrid     Proposed ACG
Memristor-CMOS   Hybrid Design
       │              │
       └──────┬───────┘
              ▼
       Performance
        Comparison
```

---

# 📊 Results

## Overall Performance Comparison

| Metric                  | Conventional CMOS | Base Hybrid | Proposed ACG |
| ----------------------- | ----------------: | ----------: | -----------: |
| Transistor Count        |                28 |           8 |           22 |
| Memristor Count         |                 0 |          16 |           16 |
| Relative Power          |              100% |       70.0% |    **19.5%** |
| Average Delay           |        1.00 cycle | 2.00 cycles |  2.00 cycles |
| PDP                     |             93.00 |      130.20 |    **36.20** |
| Clock Gating Efficiency |                 — |           — |    **76.3%** |

---

# ⚡ Power Improvement

The reported relative power values are:

```text
Conventional CMOS = 100%
Base Hybrid       = 70%
Proposed ACG      = 19.5%
```

Therefore, compared with the conventional CMOS reference:

$$
Power\ Reduction =
\frac{100-19.5}{100}\times100
$$

$$
\boxed{80.5\%}
$$

The proposed architecture therefore operates at **19.5% of the conventional baseline power** in the reported relative simulation model.

Compared with the base hybrid design:

$$
Power\ Reduction =
\frac{70-19.5}{70}\times100
$$

$$
\boxed{72.2\%}
$$

---

# 🕒 Clock Gating Efficiency

The simulation reported:

```text
Total Clock Cycles = 93
Active Cycles      = 22
Gated Cycles       = 71
```

Clock gating efficiency is:

$$
Efficiency =
\frac{Gated\ Cycles}{Total\ Cycles}\times100
$$

$$
=
\frac{71}{93}\times100
$$

$$
\boxed{76.3\%}
$$

This means that the clock was gated for approximately **76.3% of the simulated cycles**.

---

# 📐 Power-Delay Product

Power-Delay Product is used as an energy-efficiency metric:

$$
PDP = Power \times Delay
$$

Reported values:

```text
Conventional CMOS = 93.00
Base Hybrid       = 130.20
Proposed ACG      = 36.20
```

The proposed design therefore provides a substantial PDP improvement over the baseline hybrid architecture.

Reported improvement:

$$
\boxed{72.2\%}
$$

A lower PDP indicates better energy efficiency.

---

# 📈 Key Results at a Glance

```text
                     Conventional   Hybrid       Proposed
                     CMOS           M-CMOS       ACG

Power                100%           70%          19.5%
                         │             │             │
                         │             │             ▼
                         │             │        ┌──────────┐
                         │             │        │  -80.5%  │
                         │             │        │ vs CMOS  │
                         │             │        └──────────┘
                         │             ▼
                         │        ┌──────────┐
                         │        │  -72.2%  │
                         │        │ vs Hybrid│
                         │        └──────────┘

Clock Gating Efficiency:
                         76.3%

PDP:
93.00 → 130.20 → 36.20
                    │
                    ▼
                 Lowest PDP
```

---

# 🛠️ Tools & Technologies

## Hardware Description Language

* Verilog HDL

## Simulation

* Digital behavioral simulation
* Verilog testbench
* Functional verification

## Design Concepts

* VLSI Design
* Low-Power CMOS
* Memristor-CMOS Hybrid Circuits
* Memristor Ratioed Logic (MRL)
* Adaptive Clock Gating
* Digital Multipliers
* Dynamic Power Reduction
* Power-Delay Product Analysis

---

# 🔬 Design Flow

The complete project workflow can be summarized as:

```text
                    START
                      │
                      ▼
             Literature Review
                      │
                      ▼
       Existing Hybrid M-CMOS Multiplier
                      │
                      ▼
             Analyze Switching
                      │
                      ▼
        Design Adaptive Clock Gating
                      │
                      ▼
             Input Monitoring
                      │
                      ▼
            Change Detection
                      │
                      ▼
             Clock Controller
                      │
                      ▼
          Integrate with Multiplier
                      │
                      ▼
           Develop Verilog Model
                      │
                      ▼
             Develop Testbench
                      │
                      ▼
          Functional Verification
                      │
                      ▼
       Power / Delay / PDP Analysis
                      │
                      ▼
          Compare Three Architectures
                      │
                      ▼
                    RESULTS
```

---

# 🌱 Advantages

The proposed architecture provides several potential advantages:

### Low Dynamic Power

Adaptive clock gating prevents unnecessary clock activity when the multiplier inputs remain unchanged.

### Hybrid Architecture

The design combines memristive logic with CMOS circuitry rather than relying entirely on one technology.

### Compact Arithmetic Logic

The underlying universal Memristor-CMOS logic structure provides multiple logic functions within a compact architecture.

### Input-Aware Power Management

Unlike fixed clock gating, the proposed mechanism dynamically determines whether computation is necessary based on input changes.

### Improved PDP

The reported PDP of the proposed design is substantially lower than both comparison architectures.

---

# ⚠️ Limitations

The current implementation is a **2×2 multiplier** and uses a simplified digital behavioral model of the memristor.

Important limitations include:

* Small multiplier size
* Behavioral rather than detailed physical memristor modeling
* Relative power estimation
* Digital simulation-based evaluation
* No reported fabricated silicon measurements
* Clock gating overhead increases transistor count compared with the base hybrid architecture

Therefore, the reported improvements should be interpreted within the simulation methodology described in the associated work.

---

# 🚀 Future Work

The paper identifies scaling the architecture toward larger multipliers as future work.

Potential extensions include:

### 16×16 Multiplier

Scale the architecture from:

```text
2 × 2
```

to:

```text
16 × 16
```

or larger arithmetic units.

### Hierarchical Clock Gating

Introduce multiple clock-gating domains:

```text
                  Multiplier
                      │
             ┌────────┼────────┐
             ▼        ▼        ▼
          Block 1  Block 2  Block 3
             │        │        │
           Gate     Gate     Gate
```

Only the required computational blocks would receive an active clock.

### Larger Arithmetic Units

The same concept can potentially be investigated for:

* Multipliers
* ALUs
* MAC units
* Neural-network accelerators
* Edge-AI arithmetic units

### FPGA Prototyping

The digital control architecture can be further evaluated through FPGA implementation to study:

* Resource utilization
* Timing
* Power estimation
* Functional behavior

### Physical-Level Investigation

Future work can also investigate detailed memristor device models and transistor-level simulations to provide more realistic power and delay estimates.

---
