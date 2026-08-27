import QtQuick

Text {
  id: logo
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 20
  text: ""

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: launcher.visible = true
  }

  Launcher {
    id: launcher
    anchorItem: logo
  }
}
