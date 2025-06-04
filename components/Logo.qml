import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    id: logo
    source: "qrc:/images/logo.png" 
    width: 200
    height: 200
    fillMode: Image.PreserveAspectFit

    Rectangle {
        anchors.fill: parent
        color: "#3498DB"
        visible: logo.status !== Image.Ready
        radius: 5

        Text {
            anchors.centerIn: parent
            text: "Логотип"
            color: "white"
            font.pixelSize: 24
        }
    }
}
