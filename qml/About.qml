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
            id: aboutLabel
            width: parent.width
            text: '<center><b>S H A R E T U S</b><br><br>Version: 0.4.0<br><br>Author: Jason Robinson (http://basshero.org)<br><br>Please contact author regarding bugs, sharing target and feature requests.</center>'
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            font {
                family: "Nokia Pure Text"
                pixelSize: 24
            }

        }

   }

}
