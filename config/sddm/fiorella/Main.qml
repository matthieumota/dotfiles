import QtQuick
import SddmComponents

Rectangle {
  color: config.background ? config.background : "#1e1e2e"

  Column {
    anchors.centerIn: parent
    spacing: 20

    TextBox {
      id: username
      width: 240
      color: "#313244"
      font.pixelSize: 14
      textColor: "#cdd6f4"
      text: userModel.lastUser

      KeyNavigation.tab: password
    }

    PasswordBox {
      id: password
      width: 240
      color: "#313244"
      font.pixelSize: 14
      textColor: "#cdd6f4"

      Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
          sddm.login(username.text, password.text, sessionModel.lastIndex)
          event.accepted = true
        }
      }
    }
  }

  Component.onCompleted: password.forceActiveFocus()
}
