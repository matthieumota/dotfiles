import QtQuick
import Quickshell

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

  Volume {
    anchors {
      right: tray.left
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }

  Tray {
    id: tray
    anchors {
      right: powerButton.left
      rightMargin: 15
      verticalCenter: parent.verticalCenter
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
