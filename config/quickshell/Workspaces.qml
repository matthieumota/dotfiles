import QtQuick
import Quickshell.Hyprland
import Quickshell.Io

Row {
  spacing: 4

  Repeater {
    model: [...new Set(Hyprland.workspaces.values.map(w => w.id).concat([1, 2, 3, 4, 5]))].filter(id => id > 0 && id <= 10).sort((a, b) => a - b)

    Item {
      id: wsItem
      required property int modelData
      readonly property var ws: Hyprland.workspaces.values.find(w => w.id === wsItem.modelData)
      readonly property bool focused: wsItem.ws ? wsItem.ws.focused : false
      width: 18
      height: 18

      Rectangle {
        anchors.fill: parent
        radius: 4
        color: "#cdd6f4"
        visible: wsItem.focused
      }

      Text {
        anchors.centerIn: parent
        text: wsItem.modelData
        color: wsItem.focused ? "#1e1e2e" : "#cdd6f4"
        opacity: wsItem.focused || (wsItem.ws && wsItem.ws.toplevels.values.length > 0) ? 1 : 0.5
        font.family: "monospace"
        font.pixelSize: 14
        font.bold: wsItem.focused
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: wsItem.ws ? wsItem.ws.activate() : focusProc.running = true
      }

      Process {
        id: focusProc
        command: ["hyprctl", "dispatch", "hl.dsp.focus({ workspace = \"" + wsItem.modelData + "\" })"]
      }
    }
  }
}
