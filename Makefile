export ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DimXI
DimXI_FILES = src/Tweak.xm src/DimController.m src/DimWindow.m

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += prefsbundle
SUBPROJECTS += controlcenter
include $(THEOS_MAKE_PATH)/aggregate.mk
