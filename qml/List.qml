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
                 index: 0
             }
             ListElement {
                 title: "Facebook"
                 identifier: "facebook"
                 index: 1
             }
             ListElement {
                 title: "Twitter"
                 identifier: "twitter"
                 index: 2
             }
             ListElement {
                 title: "Google+"
                 identifier: "gplus"
                 index: 3
             }
             ListElement {
                 title: "LinkedIn"
                 identifier: "linkedin"
                 index: 4
             }
             ListElement {
                 title: "Tumblr"
                 identifier: "tumblr"
                 index: 5
             }
             ListElement {
                 title: "DZone"
                 identifier: "dzone"
                 index: 6
             }
             ListElement {
                 title: "Digg"
                 identifier: "digg"
                 index: 7
             }
             ListElement {
                 title: "StumbleUpon"
                 identifier: "stumble"
                 index: 8
             }
             ListElement {
                 title: "Ping FM"
                 identifier: "pingfm"
                 index: 9
             }
             ListElement {
                 title: "Delicious"
                 identifier: "delicious"
                 index: 10
             }
             ListElement {
                 title: "Google Bookmarks"
                 identifier: "gbookmarks"
                 index: 11
             }
             ListElement {
                 title: "Google Translate"
                 identifier: "gtranslate"
                 index: 12
             }
         }

        ListView {
             id: listView
             anchors.fill: parent
             model: listModel

             delegate:  Item {
                 id: listItem
                 height: 80
                 width: parent.width

                 Rectangle {
                     anchors.centerIn: parent.Center
                     anchors.fill: parent
                     color: ((model.index % 2 == 0)?"#222":"#111")

                     ListItem {
                         id: mainText
                         text: model.title
                         color: "white"
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
                     onClicked: {
                         rumbleEffect.start();
                         var result = sharer.share(model.identifier);
                         notifyText.text = result;
                         notify.visible = true;
                         notifyTimer.running = true;
                     }
                 }
             }

             Rectangle {
                 id: notify
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.verticalCenter: parent.verticalCenter
                 width: parent.width * 0.8;
                 height: 36;
                 color: "white"
                 visible: false
                 border.color: "green"; border.width: 4
                 radius: 3

                 Text {
                     id: notifyText
                     font {
                         family: "Nokia Pure Text"
                         pixelSize: 24
                     }
                     anchors.fill: parent
                     color: "black"
                     horizontalAlignment: Text.AlignHCenter
                     verticalAlignment: Text.AlignVCenter
                 }

                 Timer {
                     id: notifyTimer
                     interval: 1000; running: false; repeat: false
                     onTriggered: notify.visible = false;
                  }

             }
         }

         ScrollDecorator {
             flickableItem: listView
         }
}
