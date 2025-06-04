import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root
    property alias iconSource: icon.source
    property string pageName: ""

    width: 150
    height: 50

    contentItem: Row {
        spacing: 10
        anchors.centerIn: parent

        Image {
            id: icon
            source: ""
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.text
            color: "#34495E"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    background: Rectangle {
        color: root.down ? "#1ABC9C" : (root.hovered ? "#3498DB" : "#2C3E50")
        radius: 5
    }
}
