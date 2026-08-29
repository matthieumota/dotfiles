import QtQuick
import Quickshell.Io

Text {
  id: clock
  property bool alt: false
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12

  function update() {
    var now = new Date()
    var raw = clock.alt
      ? now.toLocaleString(Qt.locale(), "dddd dd MMMM hh'h'mm'm'ss")
      : now.toLocaleString(Qt.locale(), "dddd hh'h'mm")
        clock.text = raw.charAt(0).toUpperCase() + raw.slice(1)
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: clock.update()
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      clock.alt = !clock.alt
      clock.update()
    }
  }
}
