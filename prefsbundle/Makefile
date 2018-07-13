include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = DimXIPrefs
DimXIPrefs_FILES = DimXIRootListController.m
DimXIPrefs_INSTALL_PATH = /Library/PreferenceBundles
DimXIPrefs_FRAMEWORKS = UIKit
DimXIPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/DimXIPrefs.plist$(ECHO_END)
