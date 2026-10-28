# libtrace - static library build
#
# Usage:
#   make ARCH=cortex-m            (default)
#   make ARCH=riscv
#   make ARCH=x86
#   make ARCH=msp430
#   make ARCH=riscv CROSS_COMPILE=riscv64-unknown-elf-
#   make clean
#
# Toolchain / architecture setup lives in make/toolchain.mk.

LIB_NAME  := trace
ARCH      ?= cortex-m

SRC_DIR   := src
INC_DIR   := include
BUILD_DIR := build/$(ARCH)
OBJ_DIR   := $(BUILD_DIR)/obj
LIB       := $(BUILD_DIR)/lib$(LIB_NAME).a

include make/toolchain.mk

# Files
SRCS     := $(wildcard $(SRC_DIR)/*.c)
OBJS     := $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
DEPS     := $(OBJS:.o=.d)
INC_DIRS := $(INC_DIR) $(sort $(patsubst %/,%,$(dir $(shell find $(INC_DIR) -name '*.h' 2>/dev/null))))

# Flags
OPT      ?= -Os
CSTD     ?= -std=c11
WARNINGS := -Wall -Wextra -Wpedantic -Wshadow -Wconversion

CPPFLAGS += $(addprefix -I,$(INC_DIRS))
CFLAGS   += $(ARCH_FLAGS) $(CSTD) $(OPT) -g $(WARNINGS) \
            -ffreestanding -fno-common \
            -ffunction-sections -fdata-sections \
            -MMD -MP
ARFLAGS  := rcs


.PHONY: all clean

all: $(LIB)

$(LIB): $(OBJS)
	@mkdir -p $(@D)
	$(AR) $(ARFLAGS) $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

clean:
	rm -rf build

-include $(DEPS)
