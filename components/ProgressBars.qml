import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    width: 450
    spacing: 16

    property real activeRatio: 0.61

    // Horizontal Segmented Progress Bar
    Row {
        id: barRow
        spacing: 3.5
        Layout.fillWidth: true
        Layout.preferredHeight: 24

        Repeater {
            model: 64

            Rectangle {
                width: 3.2
                height: 22
                radius: 1.6
                color: (index / 64.0 < root.activeRatio) ? "#ff6b2b" : Qt.rgba(1, 1, 1, 0.3)

                // Glow accent on active bars
                Behavior on color {
                    ColorAnimation { duration: 300 }
                }
            }
        }
    }

    // 3 Metrics Columns
    RowLayout {
        Layout.fillWidth: true
        spacing: 24

        // Metric 1: Target
        ColumnLayout {
            spacing: 3
            Layout.alignment: Qt.AlignLeft

            Row {
                spacing: 3
                Text {
                    text: "150,000"
                    font.pixelSize: 20
                    font.weight: Font.Bold
                    font.family: "Segoe UI, sans-serif"
                    color: "#ffffff"
                }
                Text {
                    text: "kW"
                    font.pixelSize: 11
                    font.family: "Segoe UI, sans-serif"
                    color: Qt.rgba(1, 1, 1, 0.85)
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                }
            }

            Text {
                text: "Target"
                font.pixelSize: 11
                font.family: "Segoe UI, sans-serif"
                color: "#a0a4b0"
            }
        }

        // Metric 2: Power Generation
        ColumnLayout {
            spacing: 3
            Layout.alignment: Qt.AlignLeft

            Row {
                spacing: 3
                Text {
                    text: "123,547"
                    font.pixelSize: 20
                    font.weight: Font.Bold
                    font.family: "Segoe UI, sans-serif"
                    color: "#ffffff"
                }
                Text {
                    text: "kW"
                    font.pixelSize: 11
                    font.family: "Segoe UI, sans-serif"
                    color: Qt.rgba(1, 1, 1, 0.85)
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                }
            }

            Text {
                text: "Power Generation"
                font.pixelSize: 11
                font.family: "Segoe UI, sans-serif"
                color: "#a0a4b0"
            }
        }

        // Metric 3: Degree of Completion
        ColumnLayout {
            spacing: 3
            Layout.alignment: Qt.AlignLeft

            Text {
                text: "87.59 %"
                font.pixelSize: 20
                font.weight: Font.Bold
                font.family: "Segoe UI, sans-serif"
                color: "#ffffff"
            }

            Text {
                text: "Degree of Completion"
                font.pixelSize: 11
                font.family: "Segoe UI, sans-serif"
                color: "#a0a4b0"
            }
        }
    }
}
