TARGET=main
EXECUTABLE=main.elf

CC=arm-none-eabi-gcc
LD=arm-none-eabi-gcc
AR=arm-none-eabi-ar
AS=arm-none-eabi-as
CP=arm-none-eabi-objcopy
OD=arm-none-eabi-objdump

BIN=$(CP) -O ihex 

# Select the appropriate option for your device, the available options are listed below
# with a description copied from stm32f10x.h
# Make sure to set the startup code file to the right device family, too!
#
# STM32F10X_LD 		STM32F10X_LD: STM32 Low density devices
# STM32F10X_LD_VL	STM32F10X_LD_VL: STM32 Low density Value Line devices
# STM32F10X_MD		STM32F10X_MD: STM32 Medium density devices
# STM32F10X_MD_VL	STM32F10X_MD_VL: STM32 Medium density Value Line devices 
# STM32F10X_HD		STM32F10X_HD: STM32 High density devices
# STM32F10X_HD_VL	STM32F10X_HD_VL: STM32 High density value line devices
# STM32F10X_XL		STM32F10X_XL: STM32 XL-density devices
# STM32F10X_CL		STM32F10X_CL: STM32 Connectivity line devices 
#
# - Low-density devices are STM32F101xx, STM32F102xx and STM32F103xx microcontrollers
#   where the Flash memory density ranges between 16 and 32 Kbytes.
# 
# - Low-density value line devices are STM32F100xx microcontrollers where the Flash
#   memory density ranges between 16 and 32 Kbytes.
# 
# - Medium-density devices are STM32F101xx, STM32F102xx and STM32F103xx microcontrollers
#   where the Flash memory density ranges between 64 and 128 Kbytes.
# 
# - Medium-density value line devices are STM32F100xx microcontrollers where the 
#   Flash memory density ranges between 64 and 128 Kbytes.   
# 
# - High-density devices are STM32F101xx and STM32F103xx microcontrollers where
#   the Flash memory density ranges between 256 and 512 Kbytes.
# 
# - High-density value line devices are STM32F100xx microcontrollers where the 
#   Flash memory density ranges between 256 and 512 Kbytes.   
# 
# - XL-density devices are STM32F101xx and STM32F103xx microcontrollers where
#   the Flash memory density ranges between 512 and 1024 Kbytes.
# 
# - Connectivity line devices are STM32F105xx and STM32F107xx microcontrollers.
#
# HSE_VALUE sets the value of the HSE clock, 8MHz in this case 

LIB_PATH=../../STM32F0xx_StdPeriph_Lib_V1.5.0

DEFS = -DUSE_STDPERIPH_DRIVER
STARTUP = $(LIB_PATH)/Libraries/CMSIS/Device/ST/STM32F0xx/Source/Templates/gcc_ride7/startup_stm32f051.s

MCU = cortex-m0
MCFLAGS = -mcpu=$(MCU) -mthumb -mlittle-endian -mthumb-interwork

STM32_INCLUDES = -I$(LIB_PATH)/Libraries/CMSIS/Device/ST/STM32F0xx/Include \
	-I$(LIB_PATH)/Libraries/CMSIS/Include \
	-I$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/inc/

OPTIMIZE = -Os

CFLAGS	= $(MCFLAGS)  $(OPTIMIZE)  $(DEFS) -I. -I./ $(STM32_INCLUDES)  -Wl,-T,stm32f051_flash.ld
AFLAGS	= $(MCFLAGS) 

SRC = main.c \
	stm32f0xx_it.c \
	system_stm32f0xx.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_adc.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_i2c.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_spi.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_can.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dbgmcu.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_iwdg.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_syscfg.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_cec.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dma.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_misc.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_tim.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_comp.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_exti.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_pwr.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_crc.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_flash.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_rcc.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_wwdg.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_crs.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_gpio.c \
	$(LIB_PATH)/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_rtc.c


OBJDIR = .
OBJ = $(SRC:%.c=$(OBJDIR)/%.o) 
OBJ += Startup.o

all: $(TARGET).hex

$(TARGET).hex: $(EXECUTABLE)
	$(CP) -O ihex $^ $@

$(EXECUTABLE): $(SRC) $(STARTUP)
	$(CC) $(CFLAGS) $^ -lm -lc -lnosys  -o $@

clean:
	rm -f Startup.lst $(TARGET).lst $(OBJ) $(AUTOGEN)  $(TARGET).out $(TARGET).hex  $(TARGET).map \
	 $(TARGET).dmp  $(EXECUTABLE)
