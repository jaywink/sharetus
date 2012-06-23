

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
    src/sharetus.py \
    src/tags.py \
    src/targets.py \
    sharetus.json \
    preferences_template.json \
    icon-m-sharetus.png \
    qml/List.qml \
    qml/URLInfo.qml \
    qml/TagChooser.qml \
    qml/ListItem.qml \
    qml/NewTag.qml \
    qml/About.qml

SOURCES += \
    src/sharetusmethod.cpp src/sharetusplugin.cpp

HEADERS += \
    src/sharetusmethod.h src/sharetusplugin.h

CONFIG += mdatauri shareui share-ui-plugin share-ui-common qt debug plugin link_pkgconfig

target.path = /usr/lib/share-ui/plugins

qml.files = qml/main.qml qml/MainPage.qml qml/Service.qml qml/List.qml qml/URLInfo.qml qml/TagChooser.qml qml/ListItem.qml qml/NewTag.qml qml/About.qml
qml.path = /opt/sharetus/qml

python.files = src/sharetus.py src/tags.py src/targets.py
python.path = /opt/sharetus/src

icon.files = icon-m-sharetus.png
icon.path = /usr/share/themes/blanco/meegotouch/images/sharetus/

data.files = sharetus.json
data.path = /opt/sharetus

template.files = preferences_template.json
template.path = /opt/sharetus/templates

INSTALLS += target qml python data template icon

