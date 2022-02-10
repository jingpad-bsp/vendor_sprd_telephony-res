TELE_RES_DIR := vendor/sprd/telephony-res

################# apn
APN_VERSION := $(shell cat frameworks/base/core/res/res/xml/apns.xml|grep "<apns version"|cut -d \" -f 2)
apn_src_file := $(TELE_RES_DIR)/apn/apns-conf_$(APN_VERSION).xml
apn_src_file_v2 := $(TELE_RES_DIR)/apn/apns-conf_$(APN_VERSION)_v2.xml
ifneq (,$(wildcard $(apn_src_file)))

ifneq ($(filter $(strip $(PLATFORM_VERSION)),Q 10 R 11 S 12),)
PRODUCT_COPY_FILES += \
    $(apn_src_file_v2):product/etc/apns-conf.xml
else
PRODUCT_COPY_FILES += \
    $(apn_src_file):system/etc/apns-conf.xml
endif

PRODUCT_COPY_FILES += \
    $(apn_src_file):system/etc/old-apns-conf.xml
else
$(warning "APN config file: $(apn_src_file) not found, apn version: $(APN_VERSION)")
endif

################# spn
spn_src_file := $(TELE_RES_DIR)/spn/spn-conf.xml

ifneq (,$(wildcard $(spn_src_file)))
PRODUCT_COPY_FILES += \
    $(spn_src_file):system/etc/spn-conf.xml
else
$(warning "SPN config file: $(spn_src_file) not found")
endif

################# ims user agent
ims_user_agent_file := $(TELE_RES_DIR)/ims_user_agent/imsUserAgent.xml

ifneq (,$(wildcard $(ims_user_agent_file)))
  ifneq ($(filter $(strip $(PLATFORM_VERSION)),Q 10 R 11 S 12),)
    PRODUCT_COPY_FILES += \
    $(ims_user_agent_file):vendor/etc/imsUserAgent.xml
  else
    $(warning "ims user agent file: $(ims_user_agent_file) is not needed")
  endif
else
  $(warning "ims user agent file: $(ims_user_agent_file) not found")
endif

################# numeric_operator
numeric_operator_src_file := $(TELE_RES_DIR)/operatorname_overlay/frameworks/base/core/res/res/values/numeric_operator.xml

ifneq (,$(wildcard $(numeric_operator_src_file)))
PRODUCT_COPY_FILES += \
    $(numeric_operator_src_file):vendor/etc/numeric_operator.xml
else
$(warning "Numeric operator file: $(numeric_operator_src_file) not found")
endif

################# operator name
operator_name_overlay_res := $(TELE_RES_DIR)/operatorname_overlay

ifneq (,$(wildcard $(operator_name_overlay_res)))
PRODUCT_PACKAGE_OVERLAYS += $(operator_name_overlay_res)
else
$(warning "Operator name overlay: $(operator_name_overlay_res) not found")
endif


################# volte-conf
volte_conf_src_file := $(TELE_RES_DIR)/volte/volte-conf.xml

ifneq (,$(wildcard $(volte_conf_src_file)))
  ifneq ($(filter $(strip $(PLATFORM_VERSION)),Q 10),)
    $(warning Volte config file: $(volte_conf_src_file) is not needed)
  else
    PRODUCT_COPY_FILES += \
        $(volte_conf_src_file):system/etc/volte-conf.xml
  endif
else
$(warning "Volte config file: $(volte_conf_src_file) not found")
endif

################# eccList
eccList_src_file := $(TELE_RES_DIR)/eccList/eccList-conf.xml

ifneq (,$(wildcard $(eccList_src_file)))
PRODUCT_COPY_FILES += \
    $(eccList_src_file):system/etc/eccList-conf.xml
else
$(warning "eccList config file: $(eccList_src_file) not found")
endif

################# countryIso
countryIso_src_file := $(TELE_RES_DIR)/iso/countryIso-conf.xml

ifneq (,$(wildcard $(countryIso_src_file)))
  ifneq ($(filter $(strip $(PLATFORM_VERSION)),R 11),)
    PRODUCT_COPY_FILES += \
        $(countryIso_src_file):product/etc/countryIso-conf.xml
  else
    $(warning "country iso config file: $(countryIso_src_file) not need")
  endif
else
  $(warning "country iso config file: $(countryIso_src_file) not found")
endif

################# power_fallback
radioPowerFallback_src_file := $(TELE_RES_DIR)/radioPowerFallback/radioPowerFallback-conf.xml

ifneq (,$(wildcard $(radioPowerFallback_src_file)))
PRODUCT_COPY_FILES += \
    $(radioPowerFallback_src_file):system/etc/radioPowerFallback-conf.xml
else
$(warning "radioPowerFallback config file: $(radioPowerFallback_src_file) not found")
endif

################# locale-conf
locale_src_file := $(TELE_RES_DIR)/locale/locale-conf.xml

ifneq (,$(wildcard $(locale_src_file)))
PRODUCT_COPY_FILES += \
    $(locale_src_file):system_ext/etc/locale-conf.xml
else
$(warning "locale-conf: $(locale_src_file) not found")
endif
