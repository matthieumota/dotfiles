import QtQuick
import Quickshell.Io

Text {
  id: cpu
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12

  Process {
    id: proc
    command: ["sh", "-c", "vmstat 1 2 | tail -1 | awk '{print 100-$15-$16}'"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: cpu.text = "  " + text.trim() + "%"
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: if (!proc.running) proc.running = true
  }
}
