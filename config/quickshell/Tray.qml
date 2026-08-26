import QtQuick
import Quickshell.Services.SystemTray

Row {
  spacing: 10

  Repeater {
    model: SystemTray.items.values

    Image {
      id: trayItem
      required property var modelData
      width: 16
      height: 16
      source: trayItem.modelData.icon

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: trayItem.modelData.activate()
      }
    }
  }
}
