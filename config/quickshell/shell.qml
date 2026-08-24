import QtQuick
import Quickshell
import Quickshell.Hyprland
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
    id: logo
    anchors {
      left: parent.left
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
    color: "#cdd6f4"
    font.family: "monospace"
    font.pixelSize: 16
    text: ""

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: logoProc.running = true
    }
  }

  Process {
    id: logoProc
    command: ["sh", "-c", "pgrep -x fuzzel > /dev/null || fuzzel"]
  }

  Row {
    id: workspaces
    anchors {
      left: logo.right
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
    spacing: 8

    Repeater {
      model: Hyprland.workspaces.values

      Text {
        id: wsItem
        required property var modelData
        text: wsItem.modelData.id
        color: wsItem.modelData.focused ? "#89b4fa" : "#cdd6f4"
        font.family: "monospace"
        font.pixelSize: 14
        font.bold: wsItem.modelData.focused

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: wsItem.modelData.activate()
        }
      }
    }
  }

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
