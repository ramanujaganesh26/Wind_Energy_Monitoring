import QtQuick
import QtQuick.Layouts

Item {
    id: root
    width: 74
    height: 140

    property string tempValue: "69 °C"
    property string tempLabel: "Bearing"
    property real fillRatio: 0.68
    property color fillColor: "#00f2fe"

    // Dynamic temperature fluctuation timer
    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            var base = parseFloat(root.tempValue);
            if (!isNaN(base)) {
                var delta = (Math.random() * 0.4 - 0.2);
                var newVal = (base + delta).toFixed(1);
                root.tempValue = newVal + " °C";
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 6

        // Value Text
        Text {
            text: root.tempValue
            font.pixelSize: 11
            font.weight: Font.Bold
            font.family: "Segoe UI, sans-serif"
            color: "#ffffff"
            Layout.alignment: Qt.AlignHCenter
        }

        // Temperature Container
        Rectangle {
            id: barContainer
            Layout.fillWidth: true
            Layout.preferredHeight: 96
            radius: 10
            color: "#242834"
            clip: true
            border.color: hoverHandler.hovered ? Qt.lighter(root.fillColor, 1.25) : Qt.rgba(255, 255, 255, 0.12)
            border.width: 1

            HoverHandler { id: hoverHandler }

            Behavior on border.color {
                ColorAnimation { duration: 250 }
            }

            // Diagonal hatch texture
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.strokeStyle = "rgba(255, 255, 255, 0.08)";
                    ctx.lineWidth = 1;
                    var step = 7;
                    for (var x = -height; x < width + height; x += step) {
                        ctx.beginPath();
                        ctx.moveTo(x, 0);
                        ctx.lineTo(x + height, height);
                        ctx.stroke();
                    }
                }
            }

            // Lower Filled Region
            Rectangle {
                id: fillRect
                width: parent.width
                height: parent.height * root.fillRatio
                anchors.bottom: parent.bottom
                radius: 10
                color: root.fillColor

                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.lighter(root.fillColor, 1.2) }
                    GradientStop { position: 1.0; color: root.fillColor }
                }

                Behavior on height {
                    NumberAnimation { duration: 600; easing.type: Easing.OutCubic }
                }
            }
        }

        // Name Label
        Text {
            text: root.tempLabel
            font.pixelSize: 10
            font.family: "Segoe UI, sans-serif"
            color: "#a0a4b4"
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
