/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
     id: headerLabel

     anchors.top:page.top; anchors.left: page.left; anchors.right: page.right
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
