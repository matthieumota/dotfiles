//@ pragma UseQApplication

import Quickshell

ShellRoot {
  Variants {
    model: Quickshell.screens.slice(0, 1)

    Scope {
      id: scope
      required property ShellScreen modelData

      Wallpaper {
        screen: scope.modelData
      }

      Bar {
        screen: scope.modelData
      }

      Notifications {
        screen: scope.modelData
      }
    }
  }
}
