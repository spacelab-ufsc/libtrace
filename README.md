# libtrace
A tiny modular library for error tracking and recording

## Dependencies

- GNU Make
- A cross compiler (GCC + binutils) for each target architecture you build:

| Architecture | `ARCH=`    |
|--------------|------------|
| ARM Cortex-M | `cortex-m` |
| RISC-V       | `riscv`    |
| x86          | `x86`      |
| TI MSP430    | `msp430`   |

The toolchain is detected from `PATH` automatically; set `CROSS_COMPILE=<prefix>`
to choose one explicitly.

## Building

Builds a static library at `build/<arch>/libtrace.a`.

```sh
make                       # ARM Cortex-M4 (default)
make ARCH=riscv
make ARCH=x86
make ARCH=msp430
make ARCH=msp430 MCU=msp430f5529
make clean
```

Tunable variables:

| Variable        | Default                         | Applies to |
|-----------------|---------------------------------|------------|
| `CPU`           | `cortex-m4`                     | cortex-m   |
| `FLOAT_ABI`     | `soft`                          | cortex-m   |
| `CPU`           | `msp430x`                       | msp430     |
| `MCU`           | (unset)                         | msp430     |
| `MARCH`         | `rv32imac_zicsr`                | riscv      |
| `MABI`          | `ilp32`                         | riscv      |
| `OPT`           | `-Os`                           | all        |
| `CSTD`          | `-std=c11`                      | all        |
| `CROSS_COMPILE` | auto-detected                   | all        |

## Layout

```
make/       Makefile fragments (toolchain.mk: per-arch flags and toolchain detection)
src/        all .c sources
include/    public headers, organized in subfolders
build/      build output (per architecture)
```
