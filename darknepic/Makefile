include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = DarkNEpic
DarkNEpic_FILES = DNERootListController.m
DarkNEpic_INSTALL_PATH = /Library/PreferenceBundles
DarkNEpic_FRAMEWORKS = UIKit
DarkNEpic_PRIVATE_FRAMEWORKS = Preferences 
DarkNEpic_LDFLAGS += -lCSColorPicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/DarkNEpic.plist$(ECHO_END)
