include $(THEOS)/makefiles/common.mk

FINALPACKAGE = 1

TWEAK_NAME = Darknepic
Darknepic_FILES = Tweak.xm
Darknepic_PRIVATE_FRAMEWORKS = WiFiKitUI

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "rm -rf /Theos/darknepic/.theos && killall -9 Preferences"

SUBPROJECTS += darknepic
include $(THEOS_MAKE_PATH)/aggregate.mk
