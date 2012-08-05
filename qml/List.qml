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

        ListView {
             id: listModel
             model: targetListModel
             anchors.fill: parent

             delegate: Component {
                 Rectangle {
                     id: wrapper
                     width: listModel.width
                     height: 80
                     color: ((index % 2 == 0)?"#222":"#111")

                     ListItem {
                         id: mainText
                         text: model.target.desc
                         color: "white"

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
                             var result = sharer.share(model.target.name);
                             notifyText.text = result;
                             notify.visible = true;
                             notifyTimer.running = true;
                         }
                         onPressAndHold: {
                             rumbleEffect.start();
                             pageStack.push(targetConfPage);

                         }
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
             flickableItem: listModel
         }
    }

