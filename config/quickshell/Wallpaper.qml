import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  WlrLayershell.layer: WlrLayer.Background
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  color: "transparent"

  Image {
    anchors.fill: parent
    source: "file:///home/matthieu/Images/arch-linux.jpeg"
    fillMode: Image.PreserveAspectCrop
  }
}
