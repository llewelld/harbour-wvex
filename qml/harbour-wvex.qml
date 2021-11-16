import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.WebView 1.0

ApplicationWindow {
   initialPage: Page {
       Row {
           id: buttons
           x: Theme.horizontalPageMargin
           y: Theme.paddingLarge
           width: parent.width - 2 * x
           spacing: Theme.paddingMedium
           Button {
               text: "One"
               width: (parent.width - 2 * buttons.spacing) / 3
               onClicked: webview.runJavaScript("return action('one')")
           }
           Button {
               text: "Two"
               width: (parent.width - 2 * buttons.spacing) / 3
               onClicked: webview.runJavaScript("return action('two')")
           }
           Button {
               text: "Three"
               width: (parent.width - 2 * buttons.spacing) / 3
               onClicked: webview.runJavaScript("return action('three')")
           }
       }

       Label {
           id: label
           anchors.top: buttons.bottom
           width: parent.width
           height: parent.height / 2.0 - buttons.height
           font.pixelSize: 400
           horizontalAlignment: Text.AlignHCenter
       }

       WebView {
           id: webview
           anchors.top: label.bottom
           anchors.bottom: parent.bottom
           width: parent.width
           url: Qt.resolvedUrl("site.html")

           onViewInitialized: {
               webview.loadFrameScript(Qt.resolvedUrl("framescript.js"));
               webview.addMessageListener("webview:action")
           }

           onRecvAsyncMessage: {
               switch (message) {
               case "webview:action":
                   label.text = {"four": "4", "five": "5", "six": "6"}[data.topic]
                   break
               }
           }
       }
   }
}
