import QtQuick
import QtQuick.Layouts

Item {
    id: root
    anchors.fill: parent

    property real hubX: 270
    property real hubY: 257
    property int selectedTurbine: 1
    property real liveRpm: 14.8

    // Simulated RPM fluctuation
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            root.liveRpm = (14.5 + Math.random() * 0.6).toFixed(1);
        }
    }

    // Canvas overlay for guides, rotating rings, arcs
    Canvas {
        id: overlayCanvas
        anchors.fill: parent

        property real hubRotation: 0.0

        Timer {
            interval: 35
            running: true
            repeat: true
            onTriggered: {
                overlayCanvas.hubRotation += 0.8;
                overlayCanvas.requestPaint();
            }
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            // 1. Vertical Guide Line
            ctx.save();
            ctx.strokeStyle = "rgba(255, 255, 255, 0.55)";
            ctx.lineWidth = 1;
            ctx.setLineDash([2, 3]);

            ctx.beginPath();
            ctx.moveTo(43, 60);
            ctx.lineTo(43, 350);
            ctx.stroke();

            ctx.setLineDash([]);
            ctx.fillStyle = "#ffffff";
            ctx.beginPath();
            ctx.arc(43, 60, 3.5, 0, 2 * Math.PI);
            ctx.fill();

            ctx.beginPath();
            ctx.arc(43, 350, 3.5, 0, 2 * Math.PI);
            ctx.fill();
            ctx.restore();

            // 2. Horizontal Guide Line
            ctx.save();
            ctx.strokeStyle = "rgba(255, 255, 255, 0.55)";
            ctx.lineWidth = 1;
            ctx.setLineDash([2, 3]);

            ctx.beginPath();
            ctx.moveTo(43, 382);
            ctx.lineTo(490, 382);
            ctx.stroke();

            ctx.setLineDash([]);
            ctx.fillStyle = "#ffffff";
            ctx.beginPath();
            ctx.arc(43, 382, 3.5, 0, 2 * Math.PI);
            ctx.fill();

            ctx.beginPath();
            ctx.arc(490, 382, 3.5, 0, 2 * Math.PI);
            ctx.fill();
            ctx.restore();

            // 3. Rotating HUD Ring around main hub
            ctx.save();
            ctx.translate(hubX, hubY);
            ctx.rotate(hubRotation * Math.PI / 180.0);
            ctx.beginPath();
            ctx.arc(0, 0, 66, 0, 2 * Math.PI);
            ctx.strokeStyle = "rgba(255, 255, 255, 0.45)";
            ctx.lineWidth = 2;
            ctx.stroke();

            // Rotating tech notches
            for (var a = 0; a < 360; a += 60) {
                var radA = a * Math.PI / 180.0;
                ctx.beginPath();
                ctx.moveTo(61 * Math.cos(radA), 61 * Math.sin(radA));
                ctx.lineTo(66 * Math.cos(radA), 66 * Math.sin(radA));
                ctx.strokeStyle = "#ff6b2b";
                ctx.lineWidth = 2.5;
                ctx.stroke();
            }
            ctx.restore();

            // 4. Dotted Orange Scale Arc
            ctx.save();
            ctx.strokeStyle = "#ff6b2b";
            ctx.lineWidth = 2;
            ctx.setLineDash([2, 3]);

            var arcStart = -0.3 * Math.PI;
            var arcEnd = 0.7 * Math.PI;
            ctx.beginPath();
            ctx.arc(hubX, hubY, 82, arcStart, arcEnd, false);
            ctx.stroke();
            ctx.restore();
        }
    }

    // Vertical Control Button
    Rectangle {
        x: 43 - 12
        y: 200 - 18
        width: 24
        height: 36
        radius: 12
        color: "#161820"
        opacity: 0.92
        border.color: hoverVert.hovered ? "#ff6b2b" : Qt.rgba(255, 255, 255, 0.3)
        border.width: 1

        HoverHandler { id: hoverVert }

        Column {
            anchors.centerIn: parent
            spacing: 2
            Text {
                text: "▲"
                font.pixelSize: 8
                color: hoverVert.hovered ? "#ff6b2b" : "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: "▼"
                font.pixelSize: 8
                color: hoverVert.hovered ? "#ff6b2b" : "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // Horizontal Control Button
    Rectangle {
        x: 265 - 18
        y: 382 - 12
        width: 36
        height: 24
        radius: 12
        color: "#161820"
        opacity: 0.92
        border.color: hoverHoriz.hovered ? "#ff6b2b" : Qt.rgba(255, 255, 255, 0.3)
        border.width: 1

        HoverHandler { id: hoverHoriz }

        Row {
            anchors.centerIn: parent
            spacing: 4
            Text {
                text: "‹"
                font.pixelSize: 12
                font.bold: true
                color: hoverHoriz.hovered ? "#ff6b2b" : "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: "›"
                font.pixelSize: 12
                font.bold: true
                color: hoverHoriz.hovered ? "#ff6b2b" : "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Circle Marker
    Item {
        x: 265
        y: 435
        width: 20
        height: 20

        Rectangle {
            anchors.centerIn: parent
            width: 20
            height: 20
            radius: 10
            color: "transparent"
            border.color: Qt.rgba(255, 255, 255, 0.6)
            border.width: 1.5
        }

        Rectangle {
            anchors.centerIn: parent
            width: 8
            height: 8
            radius: 4
            color: "#ffffff"
        }
    }

    // Hub Center Pulsing Core
    Rectangle {
        x: root.hubX - 6
        y: root.hubY - 6
        width: 12
        height: 12
        radius: 6
        color: "#ff6b2b"

        SequentialAnimation on scale {
            loops: Animation.Infinite
            NumberAnimation { to: 1.3; duration: 750; easing.type: Easing.InOutQuad }
            NumberAnimation { to: 1.0; duration: 750; easing.type: Easing.InOutQuad }
        }
    }

    // Interactive Turbine Switcher Label
    Rectangle {
        x: root.hubX - 45
        y: root.hubY + 12
        width: 90
        height: 24
        radius: 12
        color: hoverLabel.hovered ? "#ff6b2b" : Qt.rgba(0, 0, 0, 0.45)
        border.color: "#ff6b2b"
        border.width: 1

        HoverHandler { id: hoverLabel }
        TapHandler {
            onTapped: {
                root.selectedTurbine = (root.selectedTurbine % 3) + 1;
            }
        }

        Behavior on color { ColorAnimation { duration: 200 } }

        Text {
            anchors.centerIn: parent
            text: "Turbine #" + root.selectedTurbine
            font.pixelSize: 12
            font.bold: true
            font.family: "Segoe UI, sans-serif"
            color: "#ffffff"
        }
    }

    // Live RPM Subtext
    Text {
        x: root.hubX - 45
        y: root.hubY + 38
        width: 90
        horizontalAlignment: Text.AlignHCenter
        text: root.liveRpm + " RPM"
        font.pixelSize: 10
        font.family: "Segoe UI, sans-serif"
        color: "#00f2fe"
    }

    // Scale Numbers & Dots around Hub
    Repeater {
        model: [
            { deg: 120, text: "80", isOrange: false },
            { deg: 72,  text: "70", isOrange: true },
            { deg: 50,  text: "60", isOrange: false },
            { deg: 30,  text: "50", isOrange: false },
            { deg: 10,  text: "40", isOrange: false },
            { deg: -10, text: "30", isOrange: false },
            { deg: -30, text: "20", isOrange: false },
            { deg: -50, text: "10", isOrange: false }
        ]

        Item {
            property real rad: modelData.deg * Math.PI / 180.0
            property real rArc: 82
            property real rText: 98
            property real pxDot: root.hubX + rArc * Math.cos(rad)
            property real pyDot: root.hubY - rArc * Math.sin(rad)
            property real pxText: root.hubX + rText * Math.cos(rad)
            property real pyText: root.hubY - rText * Math.sin(rad)

            Rectangle {
                x: pxDot - (modelData.isOrange ? 4 : 2)
                y: pyDot - (modelData.isOrange ? 4 : 2)
                width: modelData.isOrange ? 8 : 4
                height: modelData.isOrange ? 8 : 4
                radius: modelData.isOrange ? 4 : 2
                color: modelData.isOrange ? "#ff6b2b" : "#a0a2aa"
            }

            Text {
                x: pxText - 10
                y: pyText - 8
                text: modelData.text
                font.pixelSize: modelData.isOrange ? 14 : 11
                font.bold: modelData.isOrange
                font.family: "Segoe UI, sans-serif"
                color: modelData.isOrange ? "#ff6b2b" : "#a0a2aa"
            }
        }
    }
}
