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

    Rectangle {
        width: aboutPage.width
        height: aboutPage.height

        color: "black"

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
            text: '<center><b>S H A R E T U S</b><br><br>Version: 0.4.0<br><br>Author: Jason Robinson (http://basshero.org)<br><br>Please contact author regarding bugs, sharing target and feature requests.</center>'
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
            color: "white"


            Label {
                id: diasporaPodLabel
                text: "<center>Diaspora* Pod Url</center>"
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
                        pixelSize: 36
                    }
                    color: "black"
                    maximumLength: 50
                    anchors.fill: parent
                    anchors.topMargin: 15
                    anchors.leftMargin: 20
                    focus: true
                    validator: RegExpValidator{regExp: /[a-zA-Z0-9\-\.\:\/]*/}

                    Keys.onReturnPressed: {
                        diasporaPodUrlInput.closeSoftwareInputPanel()
                        dummy.focus = true
                    }
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
                    // save tag
//                    if (newTagTrackerCheck.checked) {
//                        controller.save_tags(newTagNameInput.text, 'true');
//                    } else {
//                        controller.save_tags(newTagNameInput.text, 'false');
//                    }
//                    pageStack.pop();
                }
            }




        }


    // This is just a dummy invisible item that takes the focus when virtual keyboard is closed
    // Tnx: http://meegoharmattandev.blogspot.com/2012/01/closing-virtual-keyboard-when-pressing.html
    Item { id: dummy }

   }

}
