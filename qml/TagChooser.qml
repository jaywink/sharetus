import QtQuick 1.1
import com.nokia.meego 1.0


Page {
    id: tagPage

    tools: ToolBarLayout {
        visible: true
        ToolItem { iconId: "icon-m-toolbar-back"; onClicked: pageStack.pop(); }
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
                    width: tagList.width
                    height: 40
                    color: ((index % 2 == 0)?"#222":"#111")
                    Text {
                        id: title
                        elide: Text.ElideRight
                        text: model.tag.name
                        color: "white"
                        font.bold: true
                        anchors.leftMargin: 10
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: { controller.tagSelected(model.tag) }
                    }
               }
           }

       }
   }

}
