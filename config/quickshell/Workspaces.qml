import QtQuick
import Quickshell.Hyprland
import Quickshell.Io

Row {
  spacing: 12

  Repeater {
    model: [...new Set(Hyprland.workspaces.values.map(w => w.id).concat([1, 2, 3, 4, 5]))].filter(id => id > 0 && id <= 10).sort((a, b) => a - b)

    Text {
      id: wsItem
      required property int modelData
      readonly property var ws: Hyprland.workspaces.values.find(w => w.id === wsItem.modelData)
      text: wsItem.modelData
      color: "#cdd6f4"
      opacity: wsItem.ws && (wsItem.ws.focused || wsItem.ws.toplevels.values.length > 0) ? 1 : 0.5
      font.family: "monospace"
      font.pixelSize: 14
      font.bold: wsItem.ws ? wsItem.ws.focused : false

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
