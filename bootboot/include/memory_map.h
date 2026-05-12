#pragma once
#include <stdint.h>

/*
 * memory_map.h
 *
 * C-visible interface to linker script symbols and flash layout.
 *
 * IMPORTANT: Linker symbols are ADDRESSES, not values.
 * Declaration:  extern uint32_t _sdata;
 * Correct use:  uint32_t *ptr = &_sdata;   // address of the symbol
 * WRONG use:    uint32_t val  = _sdata;    // reads 4 bytes AT _sdata — garbage
 *
 * The SLOT_* macros are plain addresses cast to uint32_t.
 * Use these in boot_policy.c, image_manager.c, and flash_meta.c.
 */

 /*------ Startup symbols (used by Reset_Handler in assembly) -------------*/
 extern uint32_t _sidata;   /*Flash LMA of .data section (copy source)*/
 extern uint32_t _sdata;    /*SRAM VMA start of .data (copy destination)*/
 extern uint32_t _edata;    /*SRAM VMA end of .data   (copy until here)*/
 extern uint32_t _sbss;     /*Start of .bss (zero from here)*/
 extern uint32_t _ebss;     /*End of .bss (zero until here)*/
 extern uint32_t _estack;   /*Initial stack pointer (top of SRAM stack)*/

 /*--------------Slot base addresses-------------*/
 extern uint32_t __slot_a_start;
 extern uint32_t __slot_b_start;
 extern uint32_t __recovery_start;
 extern uint32_t __meta_start;

 /*--------------Convenience macros (address as uint32_t)-------------*/
 #define SLOT_A_ADDR        ((uint32_t)__slot_a_start)
 #define SLOT_B_ADDR        ((uint32_t)__slot_b_start)
 #define RECOVERY_ADDR      ((uint32_t)__recovery_start)
 #define META_ADDR          ((uint32_t)__meta_start)

 /*--------------Cross-check: these must equal bootboot_config.h values-------------*/
 #if SLOT_A_ADDR != BOOT_SLOT_A_ADDR
 #error "SLOT_A_ADDR from linker does not match BOOT_SLOT_A_ADDR in config"
 #endif
 #if SLOT_B_ADDR != BOOT_SLOT_B_ADDR
 #error "SLOT_B_ADDR from linker does not match BOOT_SLOT_B_ADDR in config"
 #endif

 /*
 * ── How to use these in C ─────────────────────────────────────────────
 *
 * Reading a slot's image header:
 *   const image_header_t *hdr = (const image_header_t *)SLOT_A_ADDR;
 *
 * Startup copy in C (though you should do this in assembly):
 *   uint32_t *src = &_sidata;
 *   uint32_t *dst = &_sdata;
 *   while (dst < &_edata) *dst++ = *src++;
 *
 * Zeroing .bss in C:
 *   uint32_t *bss = &_sbss;
 *   while (bss < &_ebss) *bss++ = 0;
 */
