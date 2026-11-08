import QtQuick

Rectangle {
  color: config.background ? config.background : "#1e1e2e"

  Column {
    anchors.centerIn: parent
    spacing: 20

    Field {
      id: username
      text: userModel.lastUser
      placeholder: "Utilisateur"
      KeyNavigation.tab: password
      onAccepted: password.forceActiveFocus()
    }

    Field {
      id: password
      placeholder: "Mot de passe"
      echoMode: TextInput.Password
      KeyNavigation.tab: username
      onAccepted: sddm.login(username.text, password.text, sessionModel.lastIndex)
    }
  }

  component Field: TextInput {
    property string placeholder

    width: 240
    height: 40
    leftPadding: 12
    rightPadding: 12
    verticalAlignment: TextInput.AlignVCenter
    clip: true
    color: "#cdd6f4"
    font.pixelSize: 14
    selectByMouse: true
    selectionColor: "#585b70"
    passwordCharacter: "\u25cf"

    HoverHandler {
      cursorShape: Qt.IBeamCursor
    }

    Rectangle {
      anchors.fill: parent
      z: -1
      radius: 10
      color: "#313244"
      border.color: parent.activeFocus ? "#89b4fa" : color
    }

    Text {
      anchors.fill: parent
      leftPadding: 12
      verticalAlignment: Text.AlignVCenter
      text: parent.placeholder
      color: "#6c7086"
      font: parent.font
      visible: !parent.text
    }
  }

  Component.onCompleted: password.forceActiveFocus()
}
