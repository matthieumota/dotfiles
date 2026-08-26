import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris

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
    id: music

    readonly property var current: {
      var players = Mpris.players.values
      for (var i = 0; i < players.length; i++) {
        if (players[i].identity && players[i].identity.toLowerCase().indexOf("spotify") !== -1) return players[i]
      }
      return players.length > 0 ? players[0] : null
    }

    anchors {
      left: workspaces.right
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
    visible: music.current !== null
    color: "#1db954"
    font.family: "monospace"
    font.pixelSize: 12
    text: {
      if (!music.current) return ""
      var isSpotify = music.current.identity && music.current.identity.toLowerCase().indexOf("spotify") !== -1
      var icon = isSpotify ? "" : ""
      return icon + "  " + music.current.trackArtist + " - " + music.current.trackTitle
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        if (music.current) music.current.togglePlaying()
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
