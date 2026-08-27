import QtQuick
import Quickshell.Io

Text {
  id: memory
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12

  Process {
    id: proc
    command: ["free", "-m"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        var match = text.match(/Mem:\s+\d+\s+(\d+)/)
        if (match) memory.text = "  " + (parseInt(match[1]) / 1024).toFixed(2) + "G"
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: if (!proc.running) proc.running = true
  }
}
