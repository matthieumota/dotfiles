import QtQuick
import Quickshell.Hyprland

Row {
  spacing: 8

  Repeater {
    model: Hyprland.workspaces.values

    Text {
      id: wsItem
      required property var modelData
      text: wsItem.modelData.id
      color: wsItem.modelData.focused ? "#89b4fa" : "#cdd6f4"
      font.family: "monospace"
      font.pixelSize: 14
      font.bold: wsItem.modelData.focused

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: wsItem.modelData.activate()
      }
    }
  }
}
