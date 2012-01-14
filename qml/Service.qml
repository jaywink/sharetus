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
