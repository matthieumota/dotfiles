pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

PopupWindow {
  id: launcher
  required property Item anchorItem
  anchor.window: launcher.anchorItem.QsWindow.window
  anchor.edges: Edges.Top | Edges.Left
  anchor.gravity: Edges.Bottom | Edges.Right
  anchor.rect.x: anchor.window ? Math.round((anchor.window.screen.width - launcher.implicitWidth) / 2) : 0
  anchor.rect.y: anchor.window ? Math.round((anchor.window.screen.height - launcher.implicitHeight) / 2) : 0

  grabFocus: true
  implicitWidth: 320
  implicitHeight: 360
  color: "#1e1e2e"

  function launch(entry) {
    entry.execute()
    launcher.visible = false
  }

  onVisibleChanged: if (launcher.visible) {
    search.text = ""
    search.forceActiveFocus()
    results.currentIndex = 0
    results.positionViewAtBeginning()
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 8
    spacing: 8

    TextInput {
      id: search
      Layout.fillWidth: true
      color: "#cdd6f4"
      font.family: "monospace"
      font.pixelSize: 12

      Keys.onEscapePressed: launcher.visible = false
      Keys.onReturnPressed: if (results.count > 0) launcher.launch(results.model[results.currentIndex])
      Keys.onDownPressed: results.currentIndex = Math.min(results.currentIndex + 1, results.count - 1)
      Keys.onUpPressed: results.currentIndex = Math.max(results.currentIndex - 1, 0)
      onTextChanged: results.currentIndex = 0
    }

    Rectangle {
      Layout.fillWidth: true
      height: 1
      color: "#45475a"
    }

    ListView {
      id: results
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      model: {
        var query = search.text.toLowerCase()
        return DesktopEntries.applications.values
          .filter(e => !e.noDisplay && e.name.toLowerCase().includes(query))
          .sort((a, b) => a.name.localeCompare(b.name))
      }

      delegate: Item {
        id: entryItem
        required property var modelData
        readonly property bool hasIcon: entryItem.modelData.icon !== "" && Quickshell.hasThemeIcon(entryItem.modelData.icon)
        width: results.width
        height: entryText.implicitHeight + 6

        Rectangle {
          anchors.fill: parent
          radius: 4
          color: (entryMouse.containsMouse || entryItem.ListView.isCurrentItem) ? "#313244" : "transparent"
        }

        IconImage {
          id: entryIcon
          anchors {
            left: parent.left
            leftMargin: 6
            verticalCenter: parent.verticalCenter
          }
          implicitSize: 16
          source: entryItem.hasIcon ? Quickshell.iconPath(entryItem.modelData.icon) : ""
        }

        Text {
          id: entryText
          anchors {
            left: entryItem.hasIcon ? entryIcon.right : parent.left
            leftMargin: 6
            verticalCenter: parent.verticalCenter
          }
          text: entryItem.modelData.name
          color: "#cdd6f4"
          font.family: "monospace"
          font.pixelSize: 12
        }

        MouseArea {
          id: entryMouse
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: launcher.launch(entryItem.modelData)
        }
      }
    }
  }
}
