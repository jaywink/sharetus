
#contains(MEEGO_EDITION,harmattan) {
#    target.path = /opt/share-plugin-diaspora/bin
#    INSTALLS += target
#}

TARGET = diaspora-plugin

TEMPLATE     = lib

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

SOURCES += \
    diasporamethod.cpp

HEADERS += \
    diasporamethod.h

CONFIG += mdatauri shareui share-ui-plugin share-ui-common qt debug plugin link_pkgconfig

#QMAKE_CXXFLAGS += -Werror

target.path = /usr/lib/share-ui/plugins

INSTALLS += target
