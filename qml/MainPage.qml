import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: socialshare
    
    Rectangle {
        id: canvas
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height
      
        Text {
            id: app_name
            text: "Sharetus"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "steelblue"
            font.family: "Nokia Pure Text"
            font.bold: true
            font.pixelSize: 32
        }
      
        Flickable {
            id: flicker
            boundsBehavior: Flickable.StopAtBounds
            width: parent.width
            height: parent.height
            flickableDirection: Flickable.VerticalFlick
            contentHeight: parent.height
            pressDelay: 100
      
            Rectangle {
                id: main
                color: "black"
                y: 80
                width: parent.width
                height: parent.height
                
                Button {
                    id: paste_button
                    text: "Paste"
                    signal clicked()
                    anchors.topMargin: 20
                    width: 300
                    height: 50
                    anchors.horizontalCenter: main.horizontalCenter
                    
                    onClicked: { input_url.paste() }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: paste_button.clicked()
                    }
                }
                
                Rectangle {
                    id: input_container
                    anchors.topMargin: 20
                    anchors.top: paste_button.bottom
                    anchors.horizontalCenter: main.horizontalCenter
                    width: main.width*0.8
                    height: 50
                    color: "white"
                    
                    TextInput {
                        id: input_url
                        readOnly: false
                        anchors.leftMargin: 10
                        anchors.topMargin: 5
                        font.family: "Nokia Pure Text"
                        anchors.fill: parent
                        focus: true
                        autoScroll: true
                        selectByMouse: true
                        font.pixelSize: 24
                        signal onAccepted()
                    
                        onAccepted: input_url.closeSoftwareInputPanel()
                    }
                    
                    Text {
                        id: clear_input
                        text: "[x]"
                        anchors.left: input_url.right
                        anchors.leftMargin: 5
                        color: "steelblue"
                        font.family: "Nokia Pure Text"
                        font.bold: true
                        font.pixelSize: 32
                        
                        signal clicked()
                        
                        onClicked: { input_url.text = ""; }
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: clear_input.clicked()
                        }
                    }
                }
                
                Grid {
                    id: services
                    anchors.horizontalCenter: parent.horizontalCenter
                    rows: 2; columns: 3; spacing: 30
                    anchors.top: input_container.bottom
                    anchors.topMargin: 50
                    Service { icon: "/usr/share/sharetus/img/diaspora_32x32.png"; onClicked: { sharer.share("diaspora", input_url.text) } }
                    Service { icon: "/usr/share/sharetus/img/Twitter_32x32.png"; onClicked: { sharer.share("twitter", input_url.text) } }
                    Service { icon: "/usr/share/sharetus/img/FaceBook_32x32.png"; onClicked: { sharer.share("facebook", input_url.text) } }

                }
                
            }    
        }
    }
}
