import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire

Text {
  id: volume

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property var audio: volume.sink ? volume.sink.audio : null

  PwObjectTracker {
    objects: volume.sink ? [volume.sink] : []
  }

  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12
  text: {
    if (!volume.audio) return ""
    if (volume.audio.muted) return "󰖁"
    var pct = Math.round(volume.audio.volume * 100)
    var icon = pct < 33 ? "" : (pct < 67 ? "" : "")
    return icon + "  " + pct + "%"
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: proc.running = true
    onWheel: (wheel) => {
      if (!volume.audio) return
      var step = wheel.angleDelta.y > 0 ? 0.01 : -0.01
      volume.audio.volume = Math.max(0, Math.min(1, volume.audio.volume + step))
    }
  }

  Process {
    id: proc
    command: ["pavucontrol"]
  }
}
