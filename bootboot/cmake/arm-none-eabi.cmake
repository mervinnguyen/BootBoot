# Tell CMake we are cross-compiling for a bare-metal ARM target
set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  arm)

#Compiler binaries - assume arm-non-eabi-gcc is on PATH
set(CMAKE_C_COMPILER       arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER     arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER     arm-none-eabi-gcc)
set(CMAKE_OBJCOPY          arm-none-eabi-objcopy)
set(CMAKE_SIZE             arm-none-eabi-size)


#CRITICAL: prevents CMake from trying to link a test executable 
# during compiler detection - there is no OS to run it on
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

#Tell CMake not to search host system paths for libraries/includes
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

