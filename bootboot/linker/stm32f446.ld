/*
 * stm32f446.ld
 * Full linker script for STM32F446RE — bootloader only.
 * Application firmware has its own linker script starting at FLASH_A.
 */
 INCLUDE common_regions.ld

 ENTRY(Reset_Handler)

 MEMORY {
    FLASH_BL    (rx)    :   ORIGIN = 0x08000000, LENGTH = 64K
    FLASH_A     (rx)    :   ORIGIN = 0x08010000, LENGTH = 192K
    FLASH_B     (rx)    :   ORIGIN = 0x08040000, LENGTH = 192K
    FLASH_REC   (rx)    :   ORIGIN = 0x08070000, LENGTH = 48K
    FLASH_META  (rw)    :   ORIGIN = 0x0807C000, LENGTH = 16K
    SRAM        (rwx)   :   ORIGIN = 0x20000000, LENGTH = 128K
 }

 SECTIONS {
    .text : {
        KEEP(*(.isr_vector))
        *(.text) *(.text)
        *(.glue_7) *(.glue_7t) *(.eh_frame)
        KEEP(*(.init)) KEEP(*(.fini))
    } > FLASH_BL

    .rodata : {*(.rodata) *(.rodata*) } > FLASH_BL

    .ARM.extab : { *(.ARM.extab*) } > FLASH_BL
    .ARM : {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } > FLASH_BL

    .preinit_array : {
        PROVIDE_HIDDEN(__preinit_array_start = .);
        KEEP(*(.preinit_array*))
        PROVIDE_HIDDEN(__preinit_array_end = .);
    } > FLASH_BL

    .init_array : {
        PROVIDE_HIDDEN(__init_array_start = .);
        KEEP(*(SORT(.init_array*)))
        PROVIDE_HIDDEN(__init_array_end = .);
    } > FLASH_BL

    .fini_array : {
        PROVIDE_HIDDEN(__fini_array_start = .);
        KEEP(*(SORT(.fini_array*)))
        PROVIDE_HIDDEN(__fini_array_end = .);
    } > FLASH_BL

    _sidata = LOADADDR(.data);

    .data : {
        _sdata = .;
        *(.data) *(.data)
        . = ALIGN(4);
        _edata = .;
    } > SRAM AT > FLASH_BL

    .bss (NOLOAD) : {
        . = ALIGN(4);
        _sbss = .;
        *(.bss) *(.bss) *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > SRAM

    .stack (NOLOAD) : {
        . = ALIGN(8);
        _sstack = .;
        . += __stack_size;
        . = ALIGN(8);
        _estack = .;
    } > SRAM

    ASSERT(SIZEOF(.text) + SIZEOF(.rodata) + SIZEOF(.data) <= 64K,
            "Bootloader exceeds 64K FLASH_BL region");
 }