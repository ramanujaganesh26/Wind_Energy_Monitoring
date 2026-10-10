import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Rectangle {
    id: root
    width: 384
    height: 190
    radius: 22
    color: "#161820"
    opacity: 0.94

    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(0.12, 0.14, 0.20, 0.96) }
        GradientStop { position: 1.0; color: Qt.rgba(0.07, 0.08, 0.12, 0.96) }
    }

    border.color: hoverHandler.hovered ? "#00f2fe" : Qt.rgba(255, 255, 255, 0.16)
    border.width: 1

    HoverHandler { id: hoverHandler }

    Behavior on border.color {
        ColorAnimation { duration: 250 }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 6

        Text {
            text: "Temperatures"
            font.pixelSize: 15
            font.bold: true
            font.family: "Segoe UI, sans-serif"
            color: "#ffffff"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            TemperatureIndicator {
                tempValue: "69.0 °C"
                tempLabel: "Bearing"
                fillRatio: 0.68
                fillColor: "#00f2fe"
                Layout.alignment: Qt.AlignHCenter
            }

            TemperatureIndicator {
                tempValue: "9.8 °C"
                tempLabel: "Ambient"
                fillRatio: 0.16
                fillColor: "#ff6b2b"
                Layout.alignment: Qt.AlignHCenter
            }

            TemperatureIndicator {
                tempValue: "15.0 °C"
                tempLabel: "Rotor"
                fillRatio: 0.38
                fillColor: "#00f2fe"
                Layout.alignment: Qt.AlignHCenter
            }

            TemperatureIndicator {
                tempValue: "37.0 °C"
                tempLabel: "Stator"
                fillRatio: 0.54
                fillColor: "#ff6b2b"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
