import QtQuick 1.1

Item {
    id: container
    property alias icon: icon.source
    signal clicked()

    width: 60; height: 60

    Rectangle {
        id: rectangle
        border.color: "steelblue"
        anchors.fill: parent
        smooth: true
        radius: 10
        color: "darkgray"
        
        Image {
            id: icon
            anchors.centerIn: parent
            
        }
    }

    Text {
        id: service_name
        anchors.horizontalCenter: container.horizontalCenter
        anchors.verticalCenter: container.verticalCenter
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked()
    }

}
