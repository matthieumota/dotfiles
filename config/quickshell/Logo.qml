import QtQuick
import Quickshell.Io

Text {
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 16
  text: ""

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: proc.running = true
  }

  Process {
    id: proc
    command: ["sh", "-c", "pgrep -x fuzzel > /dev/null || fuzzel"]
  }
}
