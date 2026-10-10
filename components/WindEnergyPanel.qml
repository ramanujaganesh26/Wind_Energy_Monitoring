import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Rectangle {
    id: root
    width: 384
    height: 156
    radius: 22
    opacity: 0.95

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#ff7030" }
        GradientStop { position: 1.0; color: "#e64810" }
    }

    border.color: hoverHandler.hovered ? "#ffffff" : Qt.rgba(255, 255, 255, 0.35)
    border.width: 1

    HoverHandler { id: hoverHandler }

    Behavior on border.color {
        ColorAnimation { duration: 250 }
    }

    // Header Row
    RowLayout {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 14
        spacing: 8

        Text {
            text: "Wind Energy"
            font.pixelSize: 15
            font.bold: true
            font.family: "Segoe UI, sans-serif"
            color: "#ffffff"
        }

        Item { Layout.fillWidth: true }

        // Legend: Power
        Row {
            spacing: 5
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                width: 8
                height: 8
                radius: 4
                color: "transparent"
                border.color: "#ffffff"
                border.width: 1.5
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: "Power"
                font.pixelSize: 10
                font.family: "Segoe UI, sans-serif"
                color: Qt.rgba(1, 1, 1, 0.95)
            }
        }

        Item { width: 6 }

        // Legend: Wind Speed
        Row {
            spacing: 5
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                width: 8
                height: 8
                radius: 4
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: "Wind Speed"
                font.pixelSize: 10
                font.family: "Segoe UI, sans-serif"
                color: Qt.rgba(1, 1, 1, 0.95)
            }
        }
    }

    // Left Axis
    Text {
        text: "17.4"
        font.pixelSize: 11
        font.bold: true
        font.family: "Segoe UI, sans-serif"
        color: Qt.rgba(1, 1, 1, 0.95)
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.top: header.bottom
        anchors.topMargin: 4
    }
    Text {
        text: "m/s"
        font.pixelSize: 10
        font.family: "Segoe UI, sans-serif"
        color: Qt.rgba(1, 1, 1, 0.95)
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.verticalCenter: chartCanvas.verticalCenter
    }
    Text {
        text: "0"
        font.pixelSize: 10
        font.family: "Segoe UI, sans-serif"
        color: Qt.rgba(1, 1, 1, 0.95)
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14
    }

    // Right Axis
    Text {
        text: "423.8"
        font.pixelSize: 11
        font.bold: true
        font.family: "Segoe UI, sans-serif"
        color: Qt.rgba(1, 1, 1, 0.95)
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.top: header.bottom
        anchors.topMargin: 4
    }
    Text {
        text: "kw"
        font.pixelSize: 10
        font.family: "Segoe UI, sans-serif"
        color: Qt.rgba(1, 1, 1, 0.95)
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.verticalCenter: chartCanvas.verticalCenter
    }
    Text {
        text: "0"
        font.pixelSize: 10
        font.family: "Segoe UI, sans-serif"
        color: Qt.rgba(1, 1, 1, 0.95)
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14
    }

    // Dynamic Spectrum Canvas
    Canvas {
        id: chartCanvas
        anchors.left: parent.left
        anchors.leftMargin: 52
        anchors.right: parent.right
        anchors.rightMargin: 52
        anchors.top: header.bottom
        anchors.topMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14

        property real animPhase: 0.0

        Timer {
            interval: 40
            running: true
            repeat: true
            onTriggered: {
                chartCanvas.animPhase += 0.06;
                chartCanvas.requestPaint();
            }
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var baseHeights = [
                0.20, 0.35, 0.55, 0.70, 0.40, 0.80, 0.90, 0.60,
                0.65, 0.95, 1.00, 0.70, 0.85, 0.75, 0.90, 0.55,
                0.85, 0.70, 0.55, 0.25, 0.40, 0.20, 0.15
            ];

            var ticks = { 3: 0.5, 6: 0.7, 10: 0.8, 14: 0.6, 17: 0.4 };
            var count = baseHeights.length;
            var spacing = width / (count + 1);

            for (var i = 0; i < count; i++) {
                var wave = Math.sin(animPhase + i * 0.45) * 0.05;
                var hFactor = Math.min(Math.max(baseHeights[i] + wave, 0.1), 1.0);
                var x = spacing * (i + 1);
                var barH = hFactor * (height - 10);
                var y1 = (height - barH) / 2;
                var y2 = y1 + barH;

                ctx.beginPath();
                ctx.moveTo(x, y1);
                ctx.lineTo(x, y2);
                ctx.strokeStyle = "rgba(255, 255, 255, 0.95)";
                ctx.lineWidth = 2.6;
                ctx.lineCap = "round";
                ctx.stroke();

                if (ticks[i] !== undefined) {
                    var tickY = y1 + barH * ticks[i];
                    ctx.beginPath();
                    ctx.moveTo(x - 3.5, tickY);
                    ctx.lineTo(x + 3.5, tickY);
                    ctx.strokeStyle = "#ffffff";
                    ctx.lineWidth = 1.5;
                    ctx.stroke();
                }
            }
        }
    }
}
