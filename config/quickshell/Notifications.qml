pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

PanelWindow {
  id: notifPanel

  property var notifications: []
  readonly property int maxVisible: 5

  function dismiss(notification) {
    notification.tracked = false
    notifPanel.notifications = notifPanel.notifications.filter(n => n !== notification)
  }

  anchors {
    top: true
    right: true
  }
  margins {
    top: 15
    right: 15
  }
  implicitWidth: 320
  implicitHeight: list.implicitHeight
  color: "transparent"
  visible: notifPanel.notifications.length > 0

  NotificationServer {
    bodySupported: true
    imageSupported: true
    onNotification: (notification) => {
      notification.tracked = true
      notifPanel.notifications = [notification, ...notifPanel.notifications]
    }
  }

  ColumnLayout {
    id: list
    width: parent.width
    spacing: 8

    Repeater {
      model: notifPanel.notifications.slice(0, notifPanel.maxVisible)

      delegate: Rectangle {
        id: card
        required property var modelData
        readonly property bool hasImage: card.modelData.image !== ""
        Layout.fillWidth: true
        implicitHeight: Math.max(cardImage.height, cardText.implicitHeight) + 16
        color: "#1e1e2e"
        radius: 4

        Timer {
          interval: card.modelData.expireTimeout > 0 ? card.modelData.expireTimeout : 5000
          running: card.modelData.expireTimeout !== 0 && !cardMouse.containsMouse
          onTriggered: notifPanel.dismiss(card.modelData)
        }

        MouseArea {
          id: cardMouse
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onClicked: notifPanel.dismiss(card.modelData)
        }

        Image {
          id: cardImage
          visible: card.hasImage
          source: card.hasImage ? card.modelData.image : ""
          width: card.hasImage ? 40 : 0
          height: 40
          fillMode: Image.PreserveAspectCrop
          anchors {
            left: parent.left
            leftMargin: 8
            verticalCenter: parent.verticalCenter
          }
        }

        Column {
          id: cardText
          anchors {
            left: card.hasImage ? cardImage.right : parent.left
            leftMargin: 8
            right: parent.right
            rightMargin: 8
            verticalCenter: parent.verticalCenter
          }
          spacing: 4

          Text {
            width: parent.width
            text: card.modelData.summary
            color: "#cdd6f4"
            font.family: "monospace"
            font.bold: true
            font.pixelSize: 12
            wrapMode: Text.WordWrap
          }

          Text {
            width: parent.width
            text: card.modelData.body
            color: "#cdd6f4"
            font.family: "monospace"
            font.pixelSize: 12
            wrapMode: Text.WordWrap
          }
        }
      }
    }

    Rectangle {
      Layout.fillWidth: true
      visible: notifPanel.notifications.length > notifPanel.maxVisible
      implicitHeight: overflowText.implicitHeight + 12
      color: "#1e1e2e"
      radius: 4

      Text {
        id: overflowText
        anchors.centerIn: parent
        text: (notifPanel.notifications.length - notifPanel.maxVisible) + " de plus"
        color: "#cdd6f4"
        font.family: "monospace"
        font.pixelSize: 12
      }
    }
  }
}
