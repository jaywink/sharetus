

TARGET = sharetus

TEMPLATE     = lib

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qtc_packaging/debian_harmattan/postrm \
    qml/main.qml \
    qml/MainPage.qml \
    sharetus.py \
    sharetus.json \
    sharetus.png \
    qml/List.qml \
    qml/URLInfo.qml \
    qml/TagChooser.qml \
    qml/ListItem.qml \
    qml/NewTag.qml \
    qml/About.qml

SOURCES += \
    sharetusmethod.cpp sharetusplugin.cpp

HEADERS += \
    sharetusmethod.h sharetusplugin.h

CONFIG += mdatauri shareui share-ui-plugin share-ui-common qt debug plugin link_pkgconfig

target.path = /usr/lib/share-ui/plugins

qml.files = qml/main.qml qml/MainPage.qml qml/Service.qml qml/List.qml qml/URLInfo.qml qml/TagChooser.qml qml/ListItem.qml qml/NewTag.qml qml/About.qml
qml.path = /opt/sharetus/qml

python.files = sharetus.py sharetus.json
python.path = /opt/sharetus

img.files = sharetus.png
img.path = /usr/share/icons/hicolor/64x64/apps

INSTALLS += target qml python img

