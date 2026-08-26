import QtQuick

Text {
  id: volume
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: proc.running = true
  }

  Process {
    id: proc
    command: ["pavucontrol"]
  }
}
