# Toolchain setup: selects ARCH_FLAGS and CROSS_COMPILE for $(ARCH),
# and defines CC / AR.
#
# CROSS_COMPILE is auto-detected from the known prefixes of each ARCH;
# setting it explicitly skips detection.

# Little search engine for looking for toolchain

find_prefix = $(firstword $(foreach p,$(1),$(if $(shell command -v $(p)gcc 2>/dev/null),$(p))))

ifeq ($(ARCH),cortex-m)
  PREFIXES      := arm-none-eabi-
  CPU           ?= cortex-m4
  FLOAT_ABI     ?= soft
  ARCH_FLAGS    := -mcpu=$(CPU) -mthumb -mfloat-abi=$(FLOAT_ABI)
else ifeq ($(ARCH),riscv)
  PREFIXES      := riscv64-elf- riscv64-unknown-elf- riscv32-unknown-elf- riscv-none-elf-
  MARCH         ?= rv32imac_zicsr
  MABI          ?= ilp32
  ARCH_FLAGS    := -march=$(MARCH) -mabi=$(MABI) -mcmodel=medlow
else ifeq ($(ARCH),x86)
  PREFIXES      := i686-elf- x86_64-elf-
  ARCH_FLAGS    := -march=i686 -m32
else ifeq ($(ARCH),msp430)
  PREFIXES      := msp430-elf-
  CPU           ?= msp430x
  ARCH_FLAGS    := -mcpu=$(CPU) $(if $(MCU),-mmcu=$(MCU))
else
  $(error Unsupported ARCH '$(ARCH)'. Use: cortex-m, riscv, x86, msp430)
endif

CROSS_COMPILE ?= $(call find_prefix,$(PREFIXES))
ifeq ($(CROSS_COMPILE),)
  ifneq ($(filter-out clean,$(or $(MAKECMDGOALS),all)),)
    $(error No $(ARCH) toolchain found in PATH (tried: $(PREFIXES)). Set CROSS_COMPILE=...)
  endif
endif

# Toolchain
CC := $(CROSS_COMPILE)gcc
AR := $(CROSS_COMPILE)ar
