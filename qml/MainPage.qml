import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: page

    property variant share_url: sharer.share_url_str
    property variant share_title: sharer.share_title_str

    HeaderLabel {
        id: headerLabel
    }
    Rectangle {
        id: labelContainer
        anchors.top: headerLabel.bottom
        width: page.width
        implicitHeight: titleLabel.implicitHeight + urlLabel.implicitHeight

        Label {
            id: titleLabel
            width: page.width
            color: "steelblue"
            font {
                family: "Nokia Pure Text"
                pixelSize: 32
                bold: true
            }
            text: page.share_title
        }

        Label {
            id: urlLabel
            width: page.width
            anchors.top: titleLabel.bottom
            color: "steelblue"
            font {
                family: "Nokia Pure Text"
                pixelSize: 32
                bold: true
            }
            text: page.share_url
        }
    }

    List {
        id: listPage
        width: page.width
        height: page.height*0.9
        anchors.top: labelContainer.bottom
    }

//    Rectangle {
//        id: canvas
//        color: "black"
////        anchors.horizontalCenter: parent.horizontalCenter

////        width: page.width

//          anchors.top: headerLabel.bottom


//        Text {
//            id: share_url
//            text: "URL: " + page.share_url
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.topMargin: 20
//            width: page.width
//            color: "steelblue"
//            font.family: "Nokia Pure Text"
//            font.bold: false
//            font.pixelSize: 24
//        }

//        Text {
//            id: share_title
//            text: "Title: " + page.share_title
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.top: share_url.bottom
//            anchors.topMargin: 20
//            width: page.width
//            color: "steelblue"
//            font.family: "Nokia Pure Text"
//            font.bold: false
//            font.pixelSize: 24
//        }



        /*Flickable {
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
                y: 200
                width: parent.width
                height: parent.height
                
                Grid {
                    id: services
                    anchors.horizontalCenter: parent.horizontalCenter
                    rows: 2; columns: 3; spacing: 30
                    Service { text: "Diaspora*"; onClicked: { sharer.share("diaspora") } }
                    Service { text: "Twitter"; onClicked: { sharer.share("twitter") } }
                    Service { text: "Facebook"; onClicked: { sharer.share("facebook") } }

                }
                
            }    
        }*/
//    }
}
