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
import QtMobility.feedback 1.1

    Rectangle {
        id: listPage
        width: page.width
        color: "black"
        clip: true

        ListModel {
             id: listModel
             ListElement {
                 title: "Diaspora*"
                 identifier: "diaspora"
             }
             ListElement {
                 title: "Facebook"
                 identifier: "facebook"
             }
             ListElement {
                 title: "Twitter"
                 identifier: "twitter"
             }
             ListElement {
                 title: "LinkedIn"
                 identifier: "linkedin"
             }
             ListElement {
                 title: "Tumblr"
                 identifier: "tumblr"
             }
             ListElement {
                 title: "DZone"
                 identifier: "dzone"
             }
             ListElement {
                 title: "Ping FM"
                 identifier: "pingfm"
             }
             ListElement {
                 title: "Delicious"
                 identifier: "delicious"
             }
             ListElement {
                 title: "Google Bookmarks"
                 identifier: "gbookmarks"
             }
             ListElement {
                 title: "Google Translate"
                 identifier: "gtranslate"
             }

         }

        ListView {
             id: listView
             anchors.fill: parent
             model: listModel
             boundsBehavior: Flickable.DragAndOvershootBounds

             delegate:  Item {
                 id: listItem
                 height: 52
                 width: parent.width

                 Item {
                     anchors.centerIn: parent.Center
                     anchors.fill: parent

                     Label {
                         id: mainText
                         text: model.title
                         color: "#d3cfc0"
                         font {
                             family: "Nokia Pure Text"
                             pixelSize: 48
                             bold: true
                         }
                         anchors.horizontalCenter: parent.horizontalCenter

                         // Border
                         Rectangle {
                             width: parent.width
                             height: 1
                             anchors.bottom: parent.bottom
                             color: "white"
                         }
                     }
                 }

                 HapticsEffect {
                      id: rumbleEffect
                      attackIntensity: 0.0
                      attackTime: 250
                      intensity: 1.0
                      duration: 100
                      fadeTime: 250
                      fadeIntensity: 0.0
                  }

                 MouseArea {
                     anchors.fill: parent
                     onClicked: { rumbleEffect.start(); sharer.share(model.identifier); }
                 }
             }
         }

         ScrollDecorator {
             flickableItem: listView
         }
}
