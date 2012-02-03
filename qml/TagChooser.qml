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

        Text {
            text: "This is the tag list"
            anchors.centerIn: parent
            color: "white"
        }

    }
}
