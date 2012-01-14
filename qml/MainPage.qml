import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: page

    property variant share_url: sharer.share_url_str
    property variant share_title: sharer.share_title_str
    
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
                
                Rectangle {
                    id: input_container
                    anchors.topMargin: 20
                    anchors.horizontalCenter: main.horizontalCenter
                    width: main.width*0.8
                    height: 50
                    color: "white"
                    
                    TextInput {
                        id: input_url
                        readOnly: false
                        text: page.share_url
                        anchors.leftMargin: 10
                        anchors.topMargin: 5
                        font.family: "Nokia Pure Text"
                        anchors.fill: parent
                        autoScroll: true
                        selectByMouse: false
                        font.pixelSize: 24
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
