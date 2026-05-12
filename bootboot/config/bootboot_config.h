#pragma once

/* ----------------- Slot addresses -------------------
Must match linker/stm32f466.ld MEMORY{} regions exactly.
Change in one place only.
-------------------------------------------------------*/
#define BOOT_SLOT_A_ADDR 0x08010000UL
#define BOOT_SLOT_B_ADDR 0x08040000UL
#define BOOT_RECOVERY_ADDR 0x08070000UL
#define BOOT_META_ADDR 0x0807C000UL

/* ----------------- Slot sizes -----------------------*/
#define BOOT_SLOT_SIZE (192 * 1024UL)   /*192 KB*/
#define BOOT_RECOVERY_SIZE (48 * 1024UL) /*48 KB*/
#define BOOT_META_SIZE (16 * 1024UL)    /*16 KB*/

/* -----------------Boot attempt policy----------------*/
#define BOOT_MAX_ATTEMPTS 3U

/* ----------------------Watchdog----------------------*/
#define BOOT_WDT_TIMEOUT_MS 5000U       /*Must boot in 5s or WDT fires*/

/* ------------------------UART------------------------*/
#define BOOT_UART_BAUD 115200U
#define BOOT_UART_INSTANCE USART2       /*Adjust to your board's debug UART*/

/* ------------------------Feature flags------------------------*/
#define BOOT_ENABLE_UART_OTA 0         
#define BOOT_ENABLE_TELEMETRY 0        
#define BOOT_ENABLE_CRYPTO 0         

/* ------------------------Stack Size------------------------*/
#define BOOT_STACK_SIZE (2 * 1024UL)    /*2 KB - no dynamic alloc ever*/
