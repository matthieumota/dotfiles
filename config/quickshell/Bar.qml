import QtQuick
import Quickshell
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

  Music {
    anchors {
      left: workspaces.right
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }

  Clock {
    anchors.centerIn: parent
  }

  Row {
    id: tray
    anchors {
      right: powerButton.left
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }
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
          onClicked: trayItem.modelData.activate()
        }
      }
    }
  }

  PowerButton {
    id: powerButton
    anchors {
      right: parent.right
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }
}
