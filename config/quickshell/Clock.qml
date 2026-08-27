import QtQuick
import Quickshell.Io

Text {
  id: clock
  property bool alt: false
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12

  Process {
    id: proc
    command: ["date", clock.alt ? "+%A %d %B %Hh%Mm%S" : "+%A %Hh%M"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        var raw = text.trim()
        clock.text = raw.charAt(0).toUpperCase() + raw.slice(1)
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: if (!proc.running) proc.running = true
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      clock.alt = !clock.alt
      proc.running = true
    }
  }
}
