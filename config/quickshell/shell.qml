import QtQuick
import Quickshell
import Quickshell.Io

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  color: "#1e1e2e"

  Text {
    id: clock
    anchors.centerIn: parent
    color: "#cdd6f4"
    font.family: "monospace"
    font.pixelSize: 12
  }

  Process {
    id: dateProc
    command: ["date", "+%A %Hh%M"]
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
    onTriggered: {
      if (!dateProc.running) dateProc.running = true
    }
  }
}
