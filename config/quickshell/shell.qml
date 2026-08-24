import QtQuick
import Quickshell

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  color: "#1e1e2e"

  Text {
    anchors.centerIn: parent
    color: "#cdd6f4"
    font.family: "monospace"
    font.pixelSize: 12
    text: "Quickshell"
  }
}
