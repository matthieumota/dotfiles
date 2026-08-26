import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.SystemTray

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  color: "#1e1e2e"

  Logo {
    id: logo
    anchors {
      left: parent.left
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }

  Workspaces {
    id: workspaces
    anchors {
      left: logo.right
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }

  Text {
    id: music

    readonly property var current: {
      var players = Mpris.players.values.filter(function(p) { return p.trackTitle })
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
    color: "#cdd6f4"
    font.family: "monospace"
    font.pixelSize: 12
    text: {
      if (!music.current) return ""
      var isSpotify = music.current.identity && music.current.identity.toLowerCase().indexOf("spotify") !== -1
      var icon = isSpotify ? "" : ""
      return "<font color=\"#1db954\">" + icon + "</font>&nbsp;&nbsp;" + music.current.trackArtist + " - " + music.current.trackTitle
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

  Row {
    id: tray
    anchors {
      right: parent.right
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }
    spacing: 8

    Repeater {
      model: SystemTray.items.values

      Image {
        id: trayItem
        required property var modelData
        width: 16
        height: 16
        source: trayItem.modelData.icon

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: trayItem.modelData.activate()
        }
      }
    }
  }
}
