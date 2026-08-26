import QtQuick
import Quickshell.Hyprland

Row {
  spacing: 12

  Repeater {
    model: Hyprland.workspaces.values

    Text {
      id: wsItem
      required property var modelData
      text: wsItem.modelData.id
      color: "#cdd6f4"
      opacity: wsItem.modelData.focused ? 1 : 0.5
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
