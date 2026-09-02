import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  color: "#d91e1e2e"

  WlrLayershell.namespace: "quickshell-bar"

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
      right: cpu.left
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }

  Cpu {
    id: cpu
    anchors {
      right: memory.left
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }

  Memory {
    id: memory
    anchors {
      right: temperature.left
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }
  }

  Temperature {
    id: temperature
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
