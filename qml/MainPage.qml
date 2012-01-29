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

Page {
    id: page

    property variant share_url: sharer.share_url_str
    property variant share_title: sharer.share_title_str

    Rectangle {
        id: canvas
        color: "black"
        width: parent.width
        height: parent.height

        HeaderLabel {
            id: headerLabel
        }

        URLInfo {
            id: labelContainer
            anchors.top: headerLabel.bottom
            anchors.topMargin: 10
        }

        List {
            id: listPage
            width: page.width
            height: page.height - labelContainer.implicitHeight - headerLabel.implicitHeight
            anchors.top: labelContainer.bottom
            anchors.topMargin: 30
        }
    }
}
