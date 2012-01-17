/**
 * S H A R E T U S
 *
 * Plugin for Harmattan Share UI for sharing to various social
 * and bookmarking sites.
 *
 * See Github for details: https://github.com/jaywink/sharetus
 *
 * Copyright (c) 2012 Jason Robinson (jaywink@basshero.org).
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that the above copyright notice and this paragraph are
 * duplicated in all such forms and that any documentation,
 * advertising materials, and other materials related to such
 * distribution and use acknowledge that the software was developed
 * by the Jason Robinson.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
     id: headerLabel

     anchors.top:parent.top; anchors.left: parent.left; anchors.right: parent.right
     width: page.width ; height: page.height/10


     gradient: Gradient {
         GradientStop { position: 0; color: "#333333" }
         GradientStop { position: 1; color: "black" }
     }

     Text {
         anchors {
             horizontalCenter: parent.horizontalCenter
             verticalCenter: parent.verticalCenter
             leftMargin: 5
         }

         color: "green"

         font {
             family: "Nokia Pure Text"
             pixelSize: 32
             bold: true
         }

         text: "Sharetus"
     }


     // Border
     Rectangle {
         width: parent.width
         height: 1
         anchors.bottom: parent.bottom
         color: "#333333"
     }
}
