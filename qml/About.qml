/**
 * Part of Sharetus, Share UI plugin for Harmattan
 *
 * See: https://github.com/jaywink/sharetus
 *
 * Copyright (c) 2012 Jason Robinson (jaywink@basshero.org).
 * Except for exceptions mentioned in README, All rights reserved.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that the above copyright notice and this paragraph are
 * duplicated in all such forms and that any documentation,
 * advertising materials, and other materials related to such
 * distribution and use acknowledge that the software was developed
 * by Jason Robinson.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

import QtQuick 1.1
import com.nokia.meego 1.0


Page {
    id: aboutPage

    tools: ToolBarLayout {
        visible: true
        ToolItem { iconId: "icon-m-toolbar-back"; onClicked: pageStack.pop(); }
        ToolButton { text: "Contact"; onClicked: sharer.contact();  }
        ToolButton { text: "Homepage"; onClicked: sharer.homepage();  }
    }

    property variant version: sharer.version_str

    Rectangle {
        height: aboutPage.height
        width: aboutPage.width
        color: "black"


        Flickable {
            anchors.fill: parent

            Rectangle {
                id: aboutCont
                width: parent.width

                Label {
                    id: aboutTitle
                    width: parent.width
                    text: 'About'
                    color: "green"
                    font {
                        family: "Nokia Pure Text"
                        pixelSize: 36
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            diasporaPodUrlInput.closeSoftwareInputPanel()
                            dummy.focus = true
                        }
                    }
                }

                Label {
                    id: aboutLabel
                    width: parent.width
                    text: '<b>S H A R E T U S</b><br><br>Version: '+version+'<br><br>Author: Jason Robinson (http://basshero.org)<br><br>Please contact author regarding bugs, sharing target and feature requests.'
                    color: "white"
                    anchors.top: aboutTitle.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    font {
                        family: "Nokia Pure Text"
                        pixelSize: 24
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            diasporaPodUrlInput.closeSoftwareInputPanel()
                            dummy.focus = true
                        }
                    }
                }

                Label {
                    id: settingsTitle
                    width: parent.width
                    text: 'Settings'
                    color: "green"
                    anchors.top: aboutLabel.bottom
                    anchors.topMargin: 20
                    font {
                        family: "Nokia Pure Text"
                        pixelSize: 36
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            diasporaPodUrlInput.closeSoftwareInputPanel()
                            dummy.focus = true
                        }
                    }
                }

                Rectangle {
                    id: settingsRect
                    width: parent.width
                    anchors.top: settingsTitle.bottom
                    anchors.topMargin: 20
                    color: "black"

                    Label {
                        id: diasporaPodLabel
                        text: "Diaspora* pod URL<br><small>Without http(s), just pod domain name, for example: joindiaspora.com</small>"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font {
                            family: "Nokia Pure Text"
                            pixelSize: 24
                        }
                        color: "white"
                        width: parent.width

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                diasporaPodUrlInput.closeSoftwareInputPanel()
                                dummy.focus = true
                            }
                        }
                    }

                    Rectangle {
                        id: diasporaPodUrlCont
                        height: 60
                        width: parent.width
                        anchors.top: diasporaPodLabel.bottom
                        anchors.topMargin: 10
                        color: "white"
                        radius: 10
                        smooth: true
                        anchors.leftMargin: 20

                        TextInput {
                            id: diasporaPodUrlInput
                            font {
                                family: "Nokia Pure Text"
                                pixelSize: 24
                            }
                            color: "black"
                            maximumLength: 100
                            anchors.fill: parent
                            anchors.topMargin: 12
                            anchors.leftMargin: 20
                            focus: true
                            inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
                            validator: RegExpValidator{regExp: /[a-z0-9\-\.\/]*/}

                            Keys.onReturnPressed: {
                                diasporaPodUrlInput.closeSoftwareInputPanel()
                                dummy.focus = true
                            }

                            function getDiasporaPod() {
                                var diasporaPod = sharer.get_diaspora_pod();
                                diasporaPodUrlInput.text = diasporaPod;
                            }

                            Component.onCompleted: getDiasporaPod();
                        }

                    }

                    Button {
                        id: saveSettingsButton
                        anchors.top: diasporaPodUrlCont.bottom
                        anchors.topMargin: 40
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            text: "Save settings"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            font {
                                family: "Nokia Pure Text"
                                pixelSize: 24
                            }
                        }

                        onClicked: {
                            diasporaPodUrlInput.closeSoftwareInputPanel();
                            dummy.focus = true;
                            // save pod url
                            var result = sharer.save_diaspora_pod(diasporaPodUrlInput.text);
                            if (result == 0) {
                                savedNotifyText.text = "Saved";
                            } else {
                                savedNotifyText.text = "Failed to save pod url!";
                            }
                            savedNotify.visible = true;
                            savedNotifyTimer.running = true;
                        }
                    }
                }

                Rectangle {
                    id: savedNotify
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * 0.8;
                    height: 36;
                    color: "white"
                    visible: false
                    border.color: "green"; border.width: 4
                    radius: 3

                    Text {
                        id: savedNotifyText
                        font {
                            family: "Nokia Pure Text"
                            pixelSize: 24
                        }
                        anchors.fill: parent
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Timer {
                        id: savedNotifyTimer
                        interval: 1000; running: false; repeat: false
                        onTriggered: savedNotify.visible = false;
                     }

                }

                // This is just a dummy invisible item that takes the focus when virtual keyboard is closed
                // Tnx: http://meegoharmattandev.blogspot.com/2012/01/closing-virtual-keyboard-when-pressing.html
                Item { id: dummy }

            }

        contentWidth: parent.width
        contentHeight: aboutCont.childrenRect.height + 200

        }
    }
}
