import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
  id: wallpaper

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  WlrLayershell.layer: WlrLayer.Background
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  color: "transparent"

  readonly property string dir: "file:///home/matthieu/Images/Wallpapers/"
  property var images: [
    "0-winding-road.webp",
    "3-sunset-lake.webp"
  ]
  property int index: 0

  IpcHandler {
    target: "wallpaper"
    function next() {
      wallpaper.index = (wallpaper.index + 1) % wallpaper.images.length
    }
  }

  Image {
    anchors.fill: parent
    source: wallpaper.dir + wallpaper.images[wallpaper.index]
    fillMode: Image.PreserveAspectCrop
  }
}
