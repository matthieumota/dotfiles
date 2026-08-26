import QtQuick
import Quickshell.Services.Mpris

Text {
  id: music

  readonly property var current: {
    var players = Mpris.players.values.filter(function(p) { return p.trackTitle })
    for (var i = 0; i < players.length; i++) {
      if (players[i].identity && players[i].identity.toLowerCase().indexOf("spotify") !== -1) return players[i]
    }
    return players.length > 0 ? players[0] : null
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
