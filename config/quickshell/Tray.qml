import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
  spacing: 10

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
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => {
          if (mouse.button === Qt.RightButton && trayItem.modelData.hasMenu) {
            menuAnchor.open()
          } else {
            trayItem.modelData.activate()
          }
        }
      }

      QsMenuAnchor {
        id: menuAnchor
        menu: trayItem.modelData.menu
        anchor.item: trayItem
        anchor.edges: Edges.Bottom | Edges.Right
        anchor.gravity: Edges.Bottom | Edges.Left
      }
    }
  }
}
