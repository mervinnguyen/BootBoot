/*
 * common_regions.ld
 *
 * Shared slot address definitions included by all target linker scripts.
 * Every slot address and size is defined exactly once, here.
 * C code accesses these via include/memory_map.h.
 *
 * Do NOT define MEMORY{} or SECTIONS{} here — those are target-specific.
 */


/* ------------------ Slot base addresses ------------------ 
These MUST match bootboot_config.h #defines exactly.
If they diverge, the bootloader will jump to the wrong address.
Run the validation script after any change.
-----------------------------------------------------------*/
PROVIDE(__bootloader_start = 0x08000000);
PROVIDE(__bootloader_size = 64K);
PROVIDE(__bootloader_end = __bootloader_start + __bootloader_size);

PROVIDE(__slot_a_start = 0x08010000);
PROVIDE(__slot_a_size = 192K);
PROVIDE(__slot_a_end = __slot_a_start + __slot_a_size);

PROVIDE(__slot_b_start = 0x08040000);
PROVIDE(__slot_b_size = 192K);
PROVIDE(__slot_b_end = __slot_b_start + __slot_b_size);

PROVIDE(__recovery_start = 0x08070000);
PROVIDE(__recovery_size = 48K);
PROVIDE(__recovery_end = __recovery_start + __recovery_size);

PROVIDE(__meta_start = 0x0807C000);
PROVIDE(__meta_size = 16K);
PROVIDE(__meta_end = __meta_start + __meta_size);

/* ----------------------- Stack ---------------------------
Stack size must match BOOT_STACK_SIZE in bootboot.config.h.
Stack grows DOWN from __stack_top.
The value placed at address 0x20000000 in the vector table IS 
__stack_top. Cortex-M loads it into SP on reset before Rest_
Handler runs.
-----------------------------------------------------------*/

PROVIDE(__stack_size = 2K);

/* ------------Guard: assert no region overlaps -------------
The linker evaluates these as expressions. If any assertion
fails, the build errors with "ASSERT failed". Catches math 
mistakes.
-----------------------------------------------------------*/
ASSERT(__bootloader_end <= __slot_a_start, "BL overflows into Slot A");
ASSERT(__slot_a_end <= __slot_b_start, "Slot A overlaps Slot B");
ASSERT(__slot_b_end <= __recovery_start, "Slot B overlaps Recovery");
ASSERT(__recovery_end <= __meta_start, "Recovery overlaps Meta");
ASSERT(__meta_end <= 0x08080000, "Meta overflows 512K flash");

