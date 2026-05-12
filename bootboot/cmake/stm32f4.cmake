# MCU compiler flag for STM32F446RE (Cortex-M4F with FPU)
# Adjust -mcpu for your specific part: cortex-m4, cortex-m7, etc.
set(MCU_FLAGS
    -mcpu=cortex-m4
    -mthumb             #Thumb-2 instruction set
    -mfpu=fpv4-sp-d16   #Single-precision FPU
    -mfloat-abi=hard    #Hardware FP ABI - use FP registers
)

#Flash and RAM sizes for F446RE
set(FLASH_SIZE_KB 512)
set(RAM_SIZE_KB   128)

#Linker script
set(LINKER_SCRIPT
    ${CMAKE_SOURCE_DIR}/linker/stm32f446.ld
)

#Preprocessor defines passed to all source files
add_compile_definitions(
    STM32F446xx
    USE_HAL_DRIVER          #If using STM32 HAL - remove if going bare-register
    HSE_VALUE=8000000U      #Your board's external crystal freqyency in Hz.
)
