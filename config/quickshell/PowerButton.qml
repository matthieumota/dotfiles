pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Text {
  id: button

  color: "#cdd6f4"
  font.family: "monospace"
  font.pixelSize: 20
  text: "⏻"

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: menu.visible = true
  }

  PopupWindow {
    id: menu
    anchor.item: button
    anchor.edges: Edges.Bottom | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Left
    grabFocus: true
    implicitWidth: column.implicitWidth + 16
    implicitHeight: column.implicitHeight + 16
    color: "#1e1e2e"

    Column {
      id: column
      x: 8
      y: 8
      spacing: 4

      Repeater {
        model: [
          { label: "Verrouiller", command: ["hyprlock"] },
          { label: "Veille", command: ["systemctl", "suspend"] },
          { separator: true },
          { label: "Redémarrer", command: ["reboot"] },
          { label: "Éteindre", command: ["shutdown", "-h", "now"] }
        ]

        Item {
          id: entry
          required property var modelData
          width: 90
          height: entry.modelData.separator ? 9 : entryText.implicitHeight + 6

          Rectangle {
            visible: !!entry.modelData.separator
            anchors.centerIn: parent
            width: parent.width
            height: 1
            color: "#45475a"
          }

          Rectangle {
            visible: !entry.modelData.separator
            anchors.fill: parent
            radius: 4
            color: entryMouse.containsMouse ? "#313244" : "transparent"
          }

          Text {
            id: entryText
            visible: !entry.modelData.separator
            anchors {
              left: parent.left
              leftMargin: 6
              verticalCenter: parent.verticalCenter
            }
            text: entry.modelData.label ?? ""
            color: "#cdd6f4"
            font.family: "monospace"
            font.pixelSize: 12
          }

          Process {
            id: entryProc
            command: entry.modelData.command ?? []
          }

          MouseArea {
            id: entryMouse
            visible: !entry.modelData.separator
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              entryProc.running = true
              menu.visible = false
            }
          }
        }
      }
    }
  }
}
