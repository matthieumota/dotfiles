pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
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
  color: "transparent"

  function launch(entry) {
    if (entry.runInTerminal) {
      proc.command = ["ghostty", "-e"].concat(entry.command)
      proc.running = true
    } else {
      entry.execute()
    }
    launcher.visible = false
  }

  Process {
    id: proc
  }

  IpcHandler {
    target: "launcher"
    function toggle() {
      launcher.visible = !launcher.visible
    }
  }

  function fuzzyScore(text, query) {
    text = text.toLowerCase()
    var textIndex = 0
    var score = 0
    var streak = 0

    for (var i = 0; i < query.length; i++) {
      var foundAt = text.indexOf(query[i], textIndex)
      if (foundAt === -1) return -Infinity

      if (foundAt === textIndex) {
        streak += 5
      } else {
        streak = 0
      }
      score += 10 + streak - (foundAt - textIndex)
      textIndex = foundAt + 1
    }

    return score - text.indexOf(query[0])
  }

  onVisibleChanged: if (launcher.visible) {
    search.text = ""
    search.forceActiveFocus()
    results.currentIndex = 0
    results.positionViewAtBeginning()
  }

  Rectangle {
    anchors.fill: parent
    color: "#d91e1e2e"
    border.color: "#585b70"
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
      Keys.onPressed: (event) => {
        if (event.key !== Qt.Key_Return && event.key !== Qt.Key_Enter) return
        if (results.count > 0) launcher.launch(results.model[results.currentIndex])
      }
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
        if (!query) return DesktopEntries.applications.values.filter(e => !e.noDisplay).sort((a, b) => a.name.localeCompare(b.name))

        return DesktopEntries.applications.values
          .filter(e => !e.noDisplay)
          .map(e => {
            var best = Math.max(launcher.fuzzyScore(e.name, query), launcher.fuzzyScore(e.genericName, query))
            var idScore = launcher.fuzzyScore(e.id, query)
            return { entry: e, matched: isFinite(best) || isFinite(idScore), score: isFinite(best) ? best : idScore - 1000 }
          })
          .filter(r => r.matched)
          .sort((a, b) => b.score - a.score || a.entry.name.localeCompare(b.entry.name))
          .map(r => r.entry)
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
