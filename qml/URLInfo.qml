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

Rectangle {
    id: labelContainer
    width: page.width
    implicitHeight: titleLabel.implicitHeight + urlLabel.implicitHeight
    color: "black"

    Label {
        id: titleLabel
        width: page.width
        color: "#5ce2e6"
        font {
            family: "Nokia Pure Text"
            pixelSize: 32
            bold: true
        }
        text: page.share_title

    }

    Label {
        id: urlLabel
        width: page.width
        anchors.top: titleLabel.bottom
        color: "#5ce2e6"
        font {
            family: "Nokia Pure Text"
            pixelSize: 28
            bold: false
        }
        text: page.share_url
    }
}
