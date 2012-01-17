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

Item {
    id: container
    property alias text: icon.text
    signal clicked()

    width: 60; height: 60

    Rectangle {
        id: rectangle
        border.color: "steelblue"
        anchors.fill: parent
        smooth: true
        radius: 10
        color: "darkgray"
        
        Text {
            id: icon
            anchors.centerIn: parent
            
        }
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked()
    }

}
