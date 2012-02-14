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
    id: tagNewPage

    tools: ToolBarLayout {
        visible: true
        ToolItem { iconId: "icon-m-toolbar-back"; onClicked: pageStack.pop(); }
    }

    Rectangle {
        width: tagNewPage.width
        height: tagNewPage.height

        color: "black"

        Label {
            id: newTagNameLabel
            text: "<b>Tag name</b><br><small>No spaces, without hash symbol, no special characters. Add multiple tags by separating them with comma (',').</small>"
            font {
                family: "Nokia Pure Text"
                pixelSize: 32
            }
            color: "white"
            width: tagNewPage.width

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    newTagNameInput.closeSoftwareInputPanel()
                    dummy.focus = true
                }
            }
        }

        Rectangle {
            id: newTagNameCont
            height: 80
            width: tagNewPage.width
            anchors.top: newTagNameLabel.bottom
            anchors.topMargin: 10
            color: "white"
            radius: 10
            smooth: true
            anchors.leftMargin: 20

            TextInput {
                id: newTagNameInput
                font {
                    family: "Nokia Pure Text"
                    pixelSize: 50
                }
                color: "black"
                maximumLength: 50
                anchors.fill: parent
                anchors.topMargin: 15
                anchors.leftMargin: 20
                focus: true
                validator: RegExpValidator{regExp: /[a-zA-Z0-9,]*/}

                Keys.onReturnPressed: {
                    newTagNameInput.closeSoftwareInputPanel()
                    dummy.focus = true
                }
            }

        }

        Label {
            id: newTagTrackerLabel
            text: "<b>Save to device tag database?</b><br><small>Tag will be available for example in device Gallery.</small>"
            anchors.top: newTagNameCont.bottom
            color: "white"
            anchors.topMargin: 20
            font {
                family: "Nokia Pure Text"
                pixelSize: 32
            }
            width: tagNewPage.width

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    newTagNameInput.closeSoftwareInputPanel()
                    dummy.focus = true
                }
            }
        }

        CheckBox {
            id: newTagTrackerCheck
            checked: false
            enabled: true
            anchors.top: newTagTrackerLabel.bottom
            anchors.topMargin: 10
            anchors.leftMargin: 50

            onClicked: {
                newTagNameInput.closeSoftwareInputPanel()
                dummy.focus = true
            }

        }

        Button {
            id: newTagSaveButton
            anchors.top: newTagTrackerCheck.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "Save"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font {
                    family: "Nokia Pure Text"
                    pixelSize: 32
                }
            }

            onClicked: {
                newTagNameInput.closeSoftwareInputPanel()
                dummy.focus = true
            }
        }

        // This is just a dummy invisible item that takes the focus when virtual keyboard is closed
        // Tnx: http://meegoharmattandev.blogspot.com/2012/01/closing-virtual-keyboard-when-pressing.html
        Item { id: dummy }

    }

}
