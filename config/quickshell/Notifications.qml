import QtQuick
import Quickshell
import Quickshell.Services.Notifications

PanelWindow {
  id: notifPanel

  property var current: null
  readonly property bool hasImage: notifPanel.current && notifPanel.current.image !== ""

  anchors {
    top: true
    right: true
  }
  margins {
    top: 15
    right: 15
  }
  implicitWidth: 320
  implicitHeight: Math.max(notifImage.height, textColumn.implicitHeight) + 16
  color: "#1e1e2e"

  NotificationServer {
    bodySupported: true
    imageSupported: true
    onNotification: (notification) => {
      notification.tracked = true
      notifPanel.current = notification
      notifPanel.visible = true
      hideTimer.restart()
    }
  }

  Timer {
    id: hideTimer
    interval: 5000
    onTriggered: notifPanel.visible = false
  }

  Item {
    anchors.fill: parent
    anchors.margins: 8

    Image {
      id: notifImage
      visible: notifPanel.hasImage
      source: notifPanel.hasImage ? notifPanel.current.image : ""
      width: notifPanel.hasImage ? 40 : 0
      height: 40
      fillMode: Image.PreserveAspectCrop
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }
    }

    Column {
      id: textColumn
      anchors {
        left: notifPanel.hasImage ? notifImage.right : parent.left
        leftMargin: notifPanel.hasImage ? 8 : 0
        right: parent.right
        verticalCenter: parent.verticalCenter
      }
      spacing: 4

      Text {
        width: parent.width
        text: notifPanel.current ? notifPanel.current.summary : ""
        color: "#cdd6f4"
        font.family: "monospace"
        font.pixelSize: 12
        font.bold: true
        wrapMode: Text.WordWrap
      }

      Text {
        width: parent.width
        text: notifPanel.current ? notifPanel.current.body : ""
        color: "#cdd6f4"
        font.family: "monospace"
        font.pixelSize: 12
        wrapMode: Text.WordWrap
      }
    }
  }
}
