################################################################################
#
# aiy_voicebonnet
#
################################################################################

AIY_VOICEBONNET_VERSION = 13a3420a484bd7b35d31a6368dde057d0e428d53
AIY_VOICEBONNET_SITE = $(call github,builderjer,aiy_voicebonnet,$(AIY_VOICEBONNET_VERSION))
AIY_VOICEBONNET_LICENSE = Apache-2.0 License
AIY_VOICEBONNET_DEPENDENCIES = rpi-firmware

$(eval $(kernel-module))


CONFIG_AIY_IO_I2C = m
CONFIG_GPIO_AIY_IO = m
CONFIG_PWM_AIY_IO = m
CONFIG_AIY_ADC = m
#CONFIG_AIY_VISION = m

# define AIY_VOICEBONNET_BUILD_CMDS
MDIR := aiy
#
KVER = $(shell uname -r)
KDIR = /lib/modules/$(KVER)/build



ifneq ($(KERNELRELEASE),)
endif
ifeq ($(CONFIG_AIY_IO_I2C), m)
AIY_VOICEBONNET_MAKE_ENV += \
	KBUILD_CFLAGS += -DCONFIG_AIY_IO_I2C
endif

ifeq ($(CONFIG_GPIO_AIY_IO), m)
AIY_VOICEBONNET_MAKE_ENV += \
	KBUILD_CFLAGS += -DCONFIG_GPIO_AIY_IO
endif

ifeq ($(CONFIG_PWN_AIY_IO), m)
AIY_VOICEBONNET_MAKE_ENV += \
	KBUILD_CFLAGS += -DCONFIG_PWM_AIY_IO
endif

ifeq ($(CONFIG_AIY_ADC), m)
AIY_VOICEBONNET_MAKE_ENV += \
	KBUILD_CFLAGS += -DCONFIG_AIY_ADC
endif

ifeq ($(CONFIG_AIY_VISION), m)
AIY_VOICEBONNET_MAKE_ENV += \
	KBUILD_CFLAGS += -DCONFIG_AIY_VISION
endif


define AIY_VOICEBONNET_BUILD_CMDS

	$(MAKE) -C $(KDIR) M="$(CURDIR)"

endef

define AIY_VOICEBONNET_INSTALL_TARGET_CMDS
 	$(MAKE) INSTALL_MOD_PATH=$(DESTDIR) INSTALL_MOD_DIR=$(MDIR) \
 	-C $(KDIR) M="$(CURDIR)"

endef

$(eval $(generic-package))
