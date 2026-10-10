import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    width: 234
    height: 226
    radius: 26
    color: "#e8e7e3"
    border.color: hoverHandler.hovered ? "#ff6b2b" : "#dad7d2"
    border.width: hoverHandler.hovered ? 1.5 : 1

    property real currentValue: 64
    property real maxValue: 100

    HoverHandler {
        id: hoverHandler
    }

    Behavior on border.color {
        ColorAnimation { duration: 250 }
    }

    // Simulated live power readout oscillation
    Timer {
        interval: 1500
        running: true
        repeat: true
        onTriggered: {
            root.currentValue = Math.round((64 + (Math.random() * 4 - 2)) * 10) / 10;
            gaugeCanvas.requestPaint();
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 4

        // Semicircular Gauge Canvas Area
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 142

            Canvas {
                id: gaugeCanvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);

                    var cx = width / 2;
                    var cy = height / 2 + 10;
                    var radius = 62;
                    var lineWidth = 13;

                    var startAngle = 0.75 * Math.PI;
                    var totalSpan = 1.5 * Math.PI;

                    // 1. Draw outer tick marks
                    ctx.strokeStyle = "#b0ae8";
                    ctx.lineWidth = 1;
                    var totalTicks = 45;
                    for (var t = 0; t <= totalTicks; t++) {
                        var tickAngle = startAngle + (t / totalTicks) * totalSpan;
                        var rInner = radius + 10;
                        var rOuter = (t % 5 === 0) ? radius + 16 : radius + 13;

                        var x1 = cx + rInner * Math.cos(tickAngle);
                        var y1 = cy + rInner * Math.sin(tickAngle);
                        var x2 = cx + rOuter * Math.cos(tickAngle);
                        var y2 = cy + rOuter * Math.sin(tickAngle);

                        ctx.beginPath();
                        ctx.moveTo(x1, y1);
                        ctx.lineTo(x2, y2);
                        ctx.stroke();
                    }

                    // 2. Draw background track arc
                    ctx.beginPath();
                    ctx.arc(cx, cy, radius, startAngle, startAngle + totalSpan, false);
                    ctx.strokeStyle = "#d4d2cb";
                    ctx.lineWidth = lineWidth;
                    ctx.lineCap = "round";
                    ctx.stroke();

                    // 3. Draw active progress arc with gradient
                    var valueRatio = Math.min(Math.max(root.currentValue / root.maxValue, 0), 1);
                    var activeSpan = totalSpan * valueRatio;

                    var grad = ctx.createLinearGradient(cx - radius, cy, cx + radius, cy);
                    grad.addColorStop(0.0, "#f7b131");
                    grad.addColorStop(1.0, "#ff5500");

                    ctx.beginPath();
                    ctx.arc(cx, cy, radius, startAngle, startAngle + activeSpan, false);
                    ctx.strokeStyle = grad;
                    ctx.lineWidth = lineWidth;
                    ctx.lineCap = "round";
                    ctx.stroke();

                    // 4. Draw pointer needle line
                    var needleAngle = startAngle + activeSpan;
                    var needleLen = radius + 8;
                    var nx = cx + needleLen * Math.cos(needleAngle);
                    var ny = cy + needleLen * Math.sin(needleAngle);

                    ctx.beginPath();
                    ctx.moveTo(cx, cy);
                    ctx.lineTo(nx, ny);
                    ctx.strokeStyle = "#1c1d22";
                    ctx.lineWidth = 2.5;
                    ctx.stroke();
                }
            }

            // Central Reading Text
            Column {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 12
                spacing: -2

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: root.currentValue.toString()
                    font.pixelSize: 36
                    font.weight: Font.Bold
                    font.family: "Segoe UI, sans-serif"
                    color: "#18191d"

                    Behavior on text {
                        // Smooth visual feedback
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "kw"
                    font.pixelSize: 11
                    font.family: "Segoe UI, sans-serif"
                    color: "#6e717a"
                }
            }
        }

        // Bottom Environmental Metrics
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            // Metric 1: Sulfur dioxide
            ColumnLayout {
                spacing: 2
                Layout.fillWidth: true

                Row {
                    spacing: 3
                    Text {
                        text: "0.29 mt"
                        font.pixelSize: 15
                        font.weight: Font.Bold
                        font.family: "Segoe UI, sans-serif"
                        color: "#18191d"
                    }
                    Canvas {
                        width: 8
                        height: 8
                        anchors.verticalCenter: parent.verticalCenter
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.clearRect(0, 0, width, height);
                            ctx.fillStyle = "#00b4b4";
                            ctx.beginPath();
                            ctx.moveTo(4, 0);
                            ctx.lineTo(8, 8);
                            ctx.lineTo(0, 8);
                            ctx.closePath();
                            ctx.fill();
                        }
                    }
                }

                Text {
                    text: "Sulfur dioxide"
                    font.pixelSize: 10
                    font.family: "Segoe UI, sans-serif"
                    color: "#6e717a"
                }
            }

            // Metric 2: Carbon dioxide
            ColumnLayout {
                spacing: 2
                Layout.fillWidth: true

                Row {
                    spacing: 3
                    Text {
                        text: "6.24 mt"
                        font.pixelSize: 15
                        font.weight: Font.Bold
                        font.family: "Segoe UI, sans-serif"
                        color: "#18191d"
                    }
                    Canvas {
                        width: 8
                        height: 8
                        anchors.verticalCenter: parent.verticalCenter
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.clearRect(0, 0, width, height);
                            ctx.fillStyle = "#00b4b4";
                            ctx.beginPath();
                            ctx.moveTo(4, 0);
                            ctx.lineTo(8, 8);
                            ctx.lineTo(0, 8);
                            ctx.closePath();
                            ctx.fill();
                        }
                    }
                }

                Text {
                    text: "Carbon dioxide"
                    font.pixelSize: 10
                    font.family: "Segoe UI, sans-serif"
                    color: "#6e717a"
                }
            }
        }
    }
}
