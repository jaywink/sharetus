import QtQuick 1.1
import com.nokia.meego 1.0

    Rectangle {
        id: listPage

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
                 title: "Google Bookmarks"
                 identifier: "gbookmarks"
             }
             ListElement {
                 title: "Delicious"
                 identifier: "delicious"
             }
             ListElement {
                 title: "LinkedIn"
                 identifier: "linkedin"
             }
             ListElement {
                 title: "Google Translate"
                 identifier: "gtranslate"
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

         }

        ListView {
             id: listView
             anchors.fill: parent
             model: listModel
             delegate:  Item {
                 id: listItem
                 height: 52
                 width: parent.width

                 Row {
                     anchors.fill: parent

                     Column {
                         anchors.verticalCenter: parent.verticalCenter

                         Rectangle {
                             id: textContainer


                             Label {
                                 id: mainText
                                 text: model.title
                                 font.weight: Font.Bold
                                 font.pixelSize: 26                             }
                         }
                     }
                 }

                 MouseArea {
                     anchors.fill: parent
                     onClicked: { sharer.share(model.identifier) }
                 }
             }
         }

         ScrollDecorator {
             flickableItem: listView
         }
}
