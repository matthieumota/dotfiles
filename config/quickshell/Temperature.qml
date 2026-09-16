import QtQuick
import Quickshell.Io

Text {
  id: temperature
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12

  Process {
    id: proc
    command: ["sh", "-c", "f=$(grep -l k10temp /sys/class/hwmon/hwmon*/name); cat \"${f%/*}/temp1_input\""]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        var celsius = Math.round(parseInt(text.trim()) / 1000)
        var idx = Math.min(2, Math.floor(celsius / 26))
        var icon = ["", "", ""][idx]
        temperature.text = icon + " " + celsius + "°C"
      }
    }
  }

  Timer {
    interval: 10000
    running: true
    repeat: true
    onTriggered: if (!proc.running) proc.running = true
  }
}
