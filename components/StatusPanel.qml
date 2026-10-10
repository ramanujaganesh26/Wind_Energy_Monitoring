import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Rectangle {
    id: root
    width: 256
    height: 144
    radius: 20
    color: "#161820"
    opacity: 0.94

    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(0.12, 0.14, 0.20, 0.96) }
        GradientStop { position: 1.0; color: Qt.rgba(0.07, 0.08, 0.12, 0.96) }
    }

    border.color: hoverHandler.hovered ? "#ff6b2b" : Qt.rgba(255, 255, 255, 0.16)
    border.width: 1

    HoverHandler { id: hoverHandler }

    Behavior on border.color {
        ColorAnimation { duration: 250 }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 8

        // Header Row
        RowLayout {
            Layout.fillWidth: true

            Row {
                spacing: 6
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    width: 6
                    height: 6
                    radius: 3
                    color: "#00e676"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Status"
                    font.pixelSize: 15
                    font.weight: Font.Bold
                    font.family: "Segoe UI, sans-serif"
                    color: "#ffffff"
                }
            }

            Item { Layout.fillWidth: true }

            // Glowing Active Pill Badge
            Rectangle {
                id: activeBadge
                width: 58
                height: 22
                radius: 11
                color: "#ff6b2b"

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#ff7b3d" }
                    GradientStop { position: 1.0; color: "#e65014" }
                }

                Row {
                    anchors.centerIn: parent
                    spacing: 4

                    Rectangle {
                        width: 5
                        height: 5
                        radius: 2.5
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: "Active"
                        font.pixelSize: 10
                        font.weight: Font.Bold
                        font.family: "Segoe UI, sans-serif"
                        color: "#ffffff"
                    }
                }

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    PropertyAnimation { to: 0.8; duration: 1200; easing.type: Easing.InOutQuad }
                    PropertyAnimation { to: 1.0; duration: 1200; easing.type: Easing.InOutQuad }
                }
            }
        }

        // Horizontal Line
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Qt.rgba(255, 255, 255, 0.08)
        }

        // Row 1: Rotor -> Pitch Control
        RowLayout {
            Layout.fillWidth: true

            Text {
                text: "Rotor"
                font.pixelSize: 11
                font.family: "Segoe UI, sans-serif"
                color: "#a0a4b4"
            }
            Item { Layout.fillWidth: true }
            Text {
                text: "Pitch Control"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                font.family: "Segoe UI, sans-serif"
                color: "#ffffff"
            }
        }

        // Row 2: Nacelle -> On Wind
        RowLayout {
            Layout.fillWidth: true

            Text {
                text: "Nacelle"
                font.pixelSize: 11
                font.family: "Segoe UI, sans-serif"
                color: "#a0a4b4"
            }
            Item { Layout.fillWidth: true }
            Text {
                text: "On Wind"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                font.family: "Segoe UI, sans-serif"
                color: "#ffffff"
            }
        }

        // Row 3: Converter -> Running
        RowLayout {
            Layout.fillWidth: true

            Text {
                text: "Converter"
                font.pixelSize: 11
                font.family: "Segoe UI, sans-serif"
                color: "#a0a4b4"
            }
            Item { Layout.fillWidth: true }
            Text {
                text: "Running"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                font.family: "Segoe UI, sans-serif"
                color: "#00e676"
            }
        }
    }
}
