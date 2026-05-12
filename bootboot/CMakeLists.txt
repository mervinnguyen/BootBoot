#Minimum version that supports toolchain files cleanly
cmake_minimum_required(VERSION 3.22)

#Must be set BEFORE project() - CMake reads toolchain file during project()
set(CMAKE_TOOLCHAIN_FILE
    "${CMAKE_SOURCE_DIR}/cmake/arm-non-eabi-gcc.cmake"
     CACHE STRING "" FORCE)

project(bootboot C ASM)

#Pull in the target specific flags (MCU, flash/RAM sizes)
include(cmake/stm32f4.cmake)

#Global compile options applied to every target in this build
add_compile_options(
    ${MCU_FLAGS}
    -Wall -Wextra -Werror
    -ffunction-sections         #Each function in its own section -> --gc-sections removes dead code
    -fdata-sections
    -fno-common
    -fno-exceptions
    -0s                         #Optimize for size - bootloader flash is precious
    -g3
)

add_link_options(
    ${MCU_FLAGS}
    -T${LINKER_SCRIPT}
    -Wl, --gc-sections             #Remove unused sections
    -Wl, -Map=${PROJECT_NAME}.map
    -Wl, --print-memory-usage
    --specs=nano.specs              #Newlib-nano - no heap, minimal printf
    --specs=nosys.specs             #No OS syscall stubs 
)

#Config header - visible to every module
include_directories(
    ${CMAKE_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/config
)

#Subdirectories added as they are implemented
add_subdirectory(hal)
add_subdirectory(boot)

#Final ELF target
add_executable(bootboot.elf
    ""      #Sources added via target_sources() in subdirs
)

target_link_libraries(bootboot.elf
    hal
    boot_core
)

#Post-build: produce .bin and print size
add_custom_command(TARGET bootboot.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:bootboot.elf> bootboot.bin
    COMMAND ${CMAKE_SIZE} --format=berkeley $<TARGET_FILE:bootboot.elf>
    COMMENT "Generating bootboot.bin"
)
