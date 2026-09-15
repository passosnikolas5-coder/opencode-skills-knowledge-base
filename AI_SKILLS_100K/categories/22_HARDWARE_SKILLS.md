# 🔧 Hardware Engineering Skills - 2.000 Skills

> **Todas as habilidades de engenharia de hardware documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| Digital Design | 400 | Intermediário → Expert |
| Analog Design | 300 | Intermediário → Expert |
| PCB Design | 400 | Intermediário → Expert |
| FPGA Development | 300 | Intermediário → Expert |
| Hardware Security | 200 | Avançado → Expert |
| Hardware Testing | 200 | Intermediário → Expert |
| Power Electronics | 200 | Intermediário → Expert |

---

## 📐 Digital Design (400)

### Verilog/SystemVerilog (200)

#### HW001: Verilog/SystemVerilog
```lua
-- SKILL: Verilog/SystemVerilog
-- Nível: Intermediário → Expert
-- Contexto: Design digital HDL

-- CONCEITOS:
-- 1. Modules: structural design
-- 2. Always Blocks: sequential logic
-- 3. Assign Statements: combinational
-- 4. FSM: Finite State Machines
-- 5. Parameters: generic design

-- MELHORIA:
-- ERRADO: Behavioral only
-- CERTO: Structural + behavioral mix
```

### VHDL (100)

#### HW002: VHDL Design
```lua
-- SKILL: VHDL Design
-- Nível: Intermediário → Expert
-- Contexto: Design VHDL

-- CONCEITOS:
-- 1. Entity/Architecture: separation
-- 2. Processes: sequential logic
-- 3. Signals: interconnection
-- 4. Types: enumerated, record
-- 5. Generics: parameterization

-- MELHORIA:
-- ERRADO: No type safety
-- CERTO: Strong typing + assertions
```

### Digital Signal Processing (100)

#### HW003: DSP Hardware
```lua
-- SKILL: DSP Hardware Design
-- Nível: Intermediário → Expert
-- Contexto: Hardware de DSP

-- COMPONENTES:
-- 1. FIR Filters: finite impulse response
-- 2. IIR Filters: infinite impulse response
-- 3. FFT: Fast Fourier Transform
-- 4. ADC/DAC: conversion
-- 5. Multipliers: MAC units

-- MELHORIA:
-- ERRADO: Software DSP only
-- CERTO: FPGA/ASIC for performance
```

---

## ⚡ Analog Design (300)

### Circuit Design (150)

#### HW004: Analog Circuit Design
```lua
-- SKILL: Analog Circuit Design
-- Nível: Intermediário → Expert
-- Contexto: Design de circuitos analógicos

-- COMPONENTES:
-- 1. Amplifiers: op-amp, instrumentation
-- 2. Filters: active, passive
-- 3. Oscillators: crystal, PLL
-- 4. Regulators: LDO, switching
-- 5. Converters: ADC, DAC

-- MELHORIA:
-- ERRADO: Ignore noise/temperature
-- CERTO: Robust design with margins
```

### RF Design (100)

#### HW005: RF Design
```lua
-- SKILL: RF Design
-- Nível: Intermediário → Expert
-- Contexto: Design RF

-- CONCEITOS:
-- 1. Impedance Matching: S-parameters
-- 2. Filters: bandpass, lowpass
-- 3. Amplifiers: LNA, PA
-- 4. Mixers: frequency conversion
-- 5. Antennas: design, matching

-- MELHORIA:
-- ERRADO: No RF simulation
-- CERTO: Full RF simulation + measurement
```

### Power Supply Design (50)

#### HW006: Power Supply Design
```lua
-- SKILL: Power Supply Design
-- Nível: Intermediário → Expert
-- Contexto: Design de fontes de alimentação

-- TIPOS:
-- 1. Linear: low noise, low efficiency
-- 2. Switching: high efficiency, noise
-- 3. Battery: charging, management
-- 4. PoE: power over ethernet

-- MELHORIA:
-- ERRADO: Linear for high current
-- CERTO: Switching for efficiency + filtering
```

---

## 🖥️ PCB Design (400)

### Schematic Design (100)

#### HW007: Schematic Design
```lua
-- SKILL: Schematic Design
-- Nível: Intermediário → Expert
-- Contexto: Design esquemático

-- PROCESSO:
-- 1. Component Selection: datasheets
-- 2. Symbol Creation: custom parts
-- 3. Schematic Capture: connections
-- 4. ERC: Electrical Rule Check
-- 5. Documentation: netlist, BOM

-- MELHORIA:
-- ERRADO: No ERC
-- CERTO: Full ERC + peer review
```

### PCB Layout (200)

#### HW008: PCB Layout
```lua
-- SKILL: PCB Layout
-- Nível: Intermediário → Expert
-- Contexto: Layout de PCB

-- CONCEITOS:
-- 1. Stackup: layer arrangement
-- 2. Routing: traces, vias
-- 3. Placement: component positioning
-- 4. Ground Planes: return paths
-- 5. Power Distribution: decoupling

-- MELHORIA:
-- ERRADO: Auto-route everything
-- CERTO: Manual critical + auto-route rest
```

### High-Speed Design (100)

#### HW009: High-Speed PCB Design
```lua
-- SKILL: High-Speed PCB Design
-- Nível: Avançado → Expert
-- Contexto: PCB de alta velocidade

-- CONCEITOS:
-- 1. Impedance Control: microstrip, stripline
-- 2. Length Matching: differential pairs
-- 3. Crosstalk: coupling, shielding
-- 4. Signal Integrity: eye diagrams
-- 5. Power Integrity: PDN analysis

-- MELHORIA:
-- ERRADO: Ignore signal integrity
-- CERTO: SI/PI analysis + proper design rules
```

---

## 🎛️ FPGA Development (300)

### FPGA Architecture (100)

#### HW010: FPGA Architecture
```lua
-- SKILL: FPGA Architecture
-- Nível: Intermediário → Expert
-- Contexto: Arquitetura FPGA

-- COMPONENTES:
-- 1. LUT: Look-Up Tables
-- 2. Flip-Flops: storage
-- 3. DSP Blocks: arithmetic
-- 4. BRAM: block RAM
-- 5. Routing: interconnect

-- PLATAFORMAS:
-- Xilinx (AMD), Intel (Altera)
-- Lattice, Microchip

-- MELHORIA:
-- ERRADO: Ignore FPGA architecture
-- CERTO: Architecture-aware optimization
```

### HLS (100)

#### HW011: High-Level Synthesis
```lua
-- SKILL: High-Level Synthesis
-- Nível: Intermediário → Expert
-- Contexto: Síntese de alto nível

-- FERRAMENTAS:
-- 1. Vitis HLS: Xilinx
-- 2. Intel HLS: Intel FPGA
-- 3. Catapult: Siemens
-- 4. Bambu: open source

-- CONCEITOS:
-- Pragmas/Directives
-- Pipeline optimization
-- Interface synthesis
-- Dataflow optimization

-- MELHORIA:
-- ERRADO: RTL only for complex designs
-- CERTO: HLS for productivity + RTL for critical
```

### FPGA Applications (100)

#### HW012: FPGA Applications
```lua
-- SKILL: FPGA Applications
-- Nível: Intermediário → Expert
-- Contexto: Aplicações FPGA

-- APLICAÇÕES:
-- 1. Acceleration: AI, video, crypto
-- 2. Networking: packet processing
-- 3. Signal Processing: DSP, radar
-- 4. Emulation: prototype testing
-- 5. Automotive: ADAS, control

-- MELHORIA:
-- ERRADO: FPGA for everything
-- CERTO: FPGA where parallelism + latency matters
```

---

## 🔒 Hardware Security (200)

### Physical Security (100)

#### HW013: Hardware Security
```lua
-- SKILL: Hardware Security
-- Nível: Avançado → Expert
-- Contexto: Segurança de hardware

-- AMEAÇAS:
-- 1. Side-Channel: power, EM, timing
-- 2. Fault Injection: glitching
-- 3. Reverse Engineering: decapping
-- 4. Cloning: IC copying
-- 5. Tampering: physical modification

-- CONTRAMEDIDAS:
-- Secure boot, encryption
-- Tamper detection
-- Obfuscation
-- Anti-tamper packaging

-- MELHORIA:
-- ERRADO: No physical security
-- CERTO: Defense-in-depth + tamper resistance
```

### Supply Chain Security (100)

#### HW014: Supply Chain Security
```lua
-- SKILL: Supply Chain Security
-- Nível: Avançado → Expert
-- Contexto: Segurança da cadeia de suprimentos

-- AMEAÇAS:
-- 1. Counterfeit: fake components
-- 2. Tampering: modified parts
-- 3. Insertion: hardware Trojans
-- 4. Obsolescence: lifecycle issues

-- MITIGAÇÕES:
-- Authorized sources
-- Component verification
-- Hardware bill of materials
-- Tamper-evident packaging

-- MELHORIA:
-- ERRADO: Cheapest supplier
-- CERTO: Verified + authorized sources
```

---

## 🧪 Hardware Testing (200)

### Functional Testing (100)

#### HW015: Hardware Functional Testing
```lua
-- SKILL: Hardware Functional Testing
-- Nível: Intermediário → Expert
-- Contexto: Teste funcional de hardware

-- MÉTODOS:
-- 1. Boundary Scan: JTAG testing
-- 2. In-Circuit Test: PCB testing
-- 3. Functional Test: system-level
-- 4. Environmental: temperature, humidity
-- 5. Reliability: burn-in, MTBF

-- MELHORIA:
-- ERRADO: No hardware testing
-- CERTO: Comprehensive test coverage
```

### Test Equipment (100)

#### HW016: Test Equipment
```lua
-- SKILL: Test Equipment
-- Nível: Intermediário → Expert
-- Contexto: Equipamentos de teste

-- EQUIPAMENTOS:
-- 1. Oscilloscope: signal analysis
-- 2. Logic Analyzer: digital signals
-- 3. Spectrum Analyzer: RF signals
-- 4. Multimeter: basic measurements
-- 5. Network Analyzer: S-parameters
-- 6. Power Supply: controlled power

-- MELHORIA:
-- ERRADO: No proper test equipment
-- CERTO: Right equipment for measurements
```

---

## ⚡ Power Electronics (200)

### Power Converters (100)

#### HW017: Power Converters
```lua
-- SKILL: Power Converters
-- Nível: Intermediário → Expert
-- Contexto: Conversores de potência

-- TIPOS:
-- 1. Buck: step-down
-- 2. Boost: step-up
-- 3. Buck-Boost: flexible
-- 4. Flyback: isolated
-- 5. Full Bridge: high power

-- CONCEITOS:
-- Duty cycle, Frequency
-- Inductor selection
-- Capacitor selection
-- Thermal management

-- MELHORIA:
-- ERRADO: Linear regulator for high power
-- CERTO: Switching converter + proper filtering
```

### Motor Control (100)

#### HW018: Motor Control Electronics
```lua
-- SKILL: Motor Control Electronics
-- Nível: Intermediário → Expert
-- Contexto: Eletrônica de controle de motores

-- TIPOS:
-- 1. DC Motor: simple, H-bridge
-- 2. BLDC: sensorless, FOC
-- 3. Stepper: microstepping
-- 4. AC Induction: VFD
-- 5. Servo: position control

-- TÉCNICAS:
-- Field-Oriented Control (FOC)
-- Space Vector Modulation (SVM)
-- Sensorless control

-- MELHORIA:
-- ERRADO: Direct-on-line starting
-- CERTO: Controlled start + FOC for efficiency
```

---

*Hardware Engineering Skills v1.0 - Setembro 2026*