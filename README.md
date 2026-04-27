# BootBoot

**A high-assurance, production-grade secure bootloader for embedded systems, engineered for deterministic startup, cryptographic integrity, and autonomous recovery in safety-critical environments.**

---

## Overview

BootBoot is a system-level bootloader designed for **real-world deployment in constrained, safety-critical, and networked embedded platforms**. It establishes a hardened root-of-trust, enforces firmware authenticity, and guarantees reliable system bring-up under both nominal and failure conditions.

Unlike conventional bootloaders such as MCUboot, BootBoot is built as a **deterministic control layer** between hardware and application firmware, combining secure boot, fault-tolerant firmware orchestration, and boot-time observability into a unified architecture.

---

## Key Capabilities

### 🔐 Secure Boot & Root of Trust
- ECDSA-based firmware authentication (configurable curves)
- Strict image validation prior to execution
- Immutable bootloader region (read-only protection)
- Support for encrypted firmware images (roadmap)
- Measured boot (hash chaining) and attestation (roadmap)

---

### ⚡ Deterministic Boot Execution
- Constant-time critical verification paths (where applicable)
- Zero dynamic allocation in boot-critical code
- Predictable, bounded boot latency
- Minimal branching and tightly controlled execution flow
- Explicit memory mapping for full system transparency

---

### 🔁 Fault-Tolerant Firmware Lifecycle
- Multi-slot firmware architecture:
  - **Primary (Slot A)** – active image
  - **Secondary (Slot B)** – update candidate
  - **Recovery (Golden Image)** – immutable fallback
- Automatic rollback on failed boot attempts
- Power-loss safe image swap (atomic upgrade)
- Watchdog-assisted failure detection and recovery
- Boot attempt counters with configurable thresholds

---

### 📡 Integrated Firmware Update System
- Native update transports:
  - UART (initial implementation)
  - CAN (automotive-ready, planned)
  - Ethernet / Wi-Fi (planned)
- Resume support for interrupted updates
- Image integrity verification before commit
- Delta update support (planned)
- Transport-agnostic update abstraction

---

### 📊 Boot Telemetry & Diagnostics
- Reset cause analysis (POR, watchdog, software reset, etc.)
- Boot stage timing metrics (cycle or ms resolution)
- Firmware metadata inspection (version, hash, flags)
- Debug output via:
  - UART logging
  - Structured binary trace buffers (planned)
- Designed for integration with external observability systems

---

### 🧩 Modular & Portable Architecture
- Platform Abstraction Layer (PAL) for MCU portability
- Pluggable:
  - Security backends
  - Transport interfaces
  - Boot policies
- Clean separation of:
  - Core boot logic
  - Hardware drivers
  - Update mechanisms

---

## System Architecture

```
[ Boot ROM / Stage 0 ]
        ↓
[ IronRoot Bootloader ]
   ├── Image Manager        (slot management, validation)
   ├── Security Engine      (crypto, signature verification)
   ├── Recovery Manager     (rollback, failover)
   ├── Transport Layer      (OTA/update interfaces)
   └── Telemetry Engine     (metrics, diagnostics)
        ↓
[ Application Firmware ]
```

---

## Flash Memory Layout (Conceptual)

```
| Bootloader (RO, Protected) |
|----------------------------|
| Primary Image (Slot A)     |
|----------------------------|
| Secondary Image (Slot B)   |
|----------------------------|
| Recovery Image (Immutable) |
|----------------------------|
| Persistent Metadata        |
```

---

## Repository Structure

```
ironroot/
├── boot/              # Core bootloader logic
├── include/           # Public headers and configuration
├── platform/          # MCU-specific implementations
├── transport/         # OTA/update interfaces
├── telemetry/         # Boot metrics and logging
├── security/          # Cryptographic primitives and verification
├── tools/             # Image signing and packaging utilities
├── tests/             # Unit and hardware-in-loop tests
├── docs/              # Architecture and design documentation
└── examples/          # Reference implementations
```

---

## Supported Platforms

Initial targets:
- STM32 (Cortex-M4/M7)
- ESP32
- RISC-V microcontrollers

---

## Build & Toolchain

- ARM GCC / Clang toolchains
- CMake-based build system (planned)
- Python tooling for:
  - Image signing
  - Key generation
  - Firmware packaging
- Flash/debug tools:
  - OpenOCD
  - Vendor-specific utilities

---

## Development Status

🚧 Active Development

Current focus:
- Boot flow and control transfer
- Flash partitioning and memory mapping
- Cryptographic verification pipeline
- Minimal bootable prototype (single-slot)

---

## Roadmap

- [ ] Minimal bootable image (single-slot)
- [ ] Dual-slot firmware upgrade support
- [ ] ECDSA signature verification pipeline
- [ ] UART-based firmware update
- [ ] Boot telemetry instrumentation
- [ ] Recovery image + rollback system
- [ ] CAN-based update transport
- [ ] Network-based OTA (Ethernet/Wi-Fi)
- [ ] Hardware root-of-trust integration
- [ ] Remote attestation support

---

## Design Principles

- **Fail-safe over fail-fast** — systems must recover autonomously  
- **Determinism over abstraction** — predictable execution is critical  
- **Security-first design** — minimal attack surface, verified execution  
- **Observability by default** — debugging and validation built-in  
- **Portability without compromise** — hardware abstraction with performance awareness  

---

## Contributing

Contributions are encouraged in:
- Embedded security and cryptography
- OTA/update protocols (CAN, Ethernet, wireless)
- Platform bring-up (new MCUs)
- Testing frameworks and fault injection

---

## License

TBD

---

## Author

**Mervin Nguyen**  
Embedded Systems Engineer  
Focus: RTOS, low-level firmware, performance-critical systems  

---

## Summary

BootBoot functions as a **trusted execution gatekeeper**, ensuring that every system boot is:

- Cryptographically verified  
- Resilient to failure  
- Fully observable  
- Deterministic in execution  

---

> In production systems, reliability begins at boot.
