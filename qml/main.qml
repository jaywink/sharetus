import QtQuick 1.1
import com.nokia.meego 1.0



PageStackWindow {
 id: rootWindow
 showStatusBar: true

 // ListPage is what we see when the app starts, it links to
 // the component specific pages
 initialPage: MainPage { }

}
