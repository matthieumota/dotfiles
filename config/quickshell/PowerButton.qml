import QtQuick

Text {
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 14
  text: "⏻"

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
  }

  PopupWindow {
  }
}
