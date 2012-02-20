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
    id: tagPage

    tools: ToolBarLayout {
        visible: true
        ToolItem { iconId: "icon-m-toolbar-back"; onClicked: pageStack.pop(); }
        ToolButton { text: "New"; anchors.centerIn: parent; onClicked: pageStack.push(tagNewPage)  }
    }

    Rectangle {
        width: tagPage.width
        height: tagPage.height

        color: "black"

        ListView {
            id: tagList
            model: tagListModel
            anchors.horizontalCenter: parent
            anchors.fill: parent

            delegate: Component {

                Rectangle {
                    id: wrapper
                    width: tagList.width
                    height: 70
                    color: ((index % 2 == 0)?"#222":"#111")

                    ListItem {
                        id: title
                        text: model.tag.name



                        // thanks to this post for help on toggling items
                        // http://jryannel.wordpress.com/2010/02/07/a-toggle-button-with-states/
                        function toggle() {
                            if (state=="on") {state = "off"} else { state ="on"};
                            controller.tagSelected(model.tag);
                        }

                        property bool on: false
                        state: "off"

                        states: [
                            State {
                             name: "on"
                             PropertyChanges { target: title; color: "green" }
                             PropertyChanges { target: title; on: true }
                            },
                            State {
                             name: "off"
                             PropertyChanges { target: title; color: "white" }
                             PropertyChanges { target: title; on: false }
                            }
                        ]

                        Component.onCompleted: { title.state = controller.tagStatus(model.tag.name) }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: title.toggle()
                    }

               }
           }

       }
   }

}
