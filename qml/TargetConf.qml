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
    id: targetConfPage

    tools: ToolBarLayout {
        visible: true
        ToolItem { iconId: "icon-m-toolbar-back"; onClicked: pageStack.pop(); }
    }

    property variant target

    onTargetChanged: confTitle.text = target.desc

    Rectangle {
        height: targetConfPage.height
        width: targetConfPage.width
        color: "black"


        Flickable {
            anchors.fill: parent

            Rectangle {
                id: confCont
                width: parent.width

                Label {
                    id: confTitle
                    width: parent.width
                    text: "placeholder"
                    color: "white"
                    font {
                        family: "Nokia Pure Text"
                        pixelSize: 50
                        bold: true
                    }
                    elide: Text.ElideRight
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // This is just a dummy invisible item that takes the focus when virtual keyboard is closed
                // Tnx: http://meegoharmattandev.blogspot.com/2012/01/closing-virtual-keyboard-when-pressing.html
                Item { id: dummy }

            }

        contentWidth: parent.width
        contentHeight: confCont.childrenRect.height + 200

        }
    }
}