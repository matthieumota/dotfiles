import QtQuick

Text {
  id: clock
  readonly property bool alt: hoverArea.containsMouse
  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 12

  function update() {
    var now = new Date()
    var raw = clock.alt
      ? now.toLocaleString(Qt.locale(), "dddd dd MMMM hh'h'mm'm'ss")
      : now.toLocaleString(Qt.locale(), "dddd hh'h'mm")
        clock.text = raw.charAt(0).toUpperCase() + raw.slice(1)
  }

  Component.onCompleted: clock.update()
  onAltChanged: clock.update()

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: clock.update()
  }

  MouseArea {
    id: hoverArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
  }
}
