import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    width: 136
    height: 110
    radius: 22
    color: "#e8e7e3"
    border.color: hoverHandler.hovered ? "#ff6b2b" : "#dad7d2"
    border.width: hoverHandler.hovered ? 1.5 : 1

    property string labelText: "Total Energy"
    property string mainValue: "4"
    property string subValue: ".2 GWh"

    HoverHandler {
        id: hoverHandler
    }

    Behavior on border.color {
        ColorAnimation { duration: 250 }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Text {
            text: root.labelText
            font.pixelSize: 12
            font.family: "Segoe UI, sans-serif"
            color: "#4e515a"
            Layout.alignment: Qt.AlignLeft
        }

        RowLayout {
            spacing: 0
            Layout.alignment: Qt.AlignLeft

            Text {
                text: root.mainValue
                font.pixelSize: 28
                font.weight: Font.Bold
                font.family: "Segoe UI, sans-serif"
                color: "#18191d"
            }

            Text {
                text: root.subValue
                font.pixelSize: 18
                font.weight: Font.Bold
                font.family: "Segoe UI, sans-serif"
                color: "#18191d"
                Layout.alignment: Qt.AlignBaseline
            }
        }
    }
}
