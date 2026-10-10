import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import "components"

ApplicationWindow {
    id: window
    width: 1280
    height: 800
    visible: true
    title: qsTr("New Windmill Unit Software - Wind Energy Monitoring Dashboard")

    // Fullscreen Shortcuts
    Shortcut {
        sequence: "F11"
        onActivated: {
            if (window.visibility === Window.FullScreen)
                window.showNormal();
            else
                window.showFullScreen();
        }
    }

    Shortcut {
        sequence: "Esc"
        onActivated: {
            if (window.visibility === Window.FullScreen)
                window.showNormal();
        }
    }

    // Edge-to-Edge Dark Background Layer
    Rectangle {
        anchors.fill: parent
        color: "#101217"

        // Full Screen Wind Turbine Image Backdrop
        Image {
            id: bgImage
            anchors.fill: parent
            source: Qt.resolvedUrl("assets/wind_turbine_bg.png")
            fillMode: Image.PreserveAspectCrop
            smooth: true
            asynchronous: true
        }

        // Dark Radial Vignette
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.rgba(0.04, 0.05, 0.07, 0.15) }
                GradientStop { position: 0.6; color: Qt.rgba(0.04, 0.05, 0.07, 0.05) }
                GradientStop { position: 1.0; color: Qt.rgba(0.02, 0.02, 0.03, 0.45) }
            }
        }

        // Dynamic Animated Wind Vector Lines floating across background
        Canvas {
            id: windParticleCanvas
            anchors.fill: parent

            property real particlePhase: 0.0

            Timer {
                interval: 35
                running: true
                repeat: true
                onTriggered: {
                    windParticleCanvas.particlePhase += 1.5;
                    windParticleCanvas.requestPaint();
                }
            }

            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, width, height);
                ctx.strokeStyle = "rgba(255, 255, 255, 0.06)";
                ctx.lineWidth = 1.2;

                var particleCount = 18;
                for (var p = 0; p < particleCount; p++) {
                    var py = (p * 45 + 30) % height;
                    var px = (particlePhase * (1.0 + p * 0.1) + p * 120) % (width + 200) - 100;

                    ctx.beginPath();
                    ctx.moveTo(px, py);
                    ctx.lineTo(px + 90, py + Math.sin((px + py) * 0.01) * 8);
                    ctx.stroke();
                }
            }
        }
    }

    // Edge-to-Edge Responsive Dashboard Layer
    Item {
        id: container
        anchors.fill: parent
        anchors.margins: 30

        // 1. Technical HUD Overlay & Turbine Controls (positioned over background turbine hub)
        TurbineControl {
            id: turbineOverlay
            hubX: parent.width * 0.27
            hubY: parent.height * 0.33
        }

        // 2. Right Column: Stacked Panels aligned right to edge
        Column {
            id: rightColumn
            anchors.top: parent.top
            anchors.right: parent.right
            spacing: 16

            // Top Row: StatusPanel + WindEnergyPanel side-by-side
            Row {
                anchors.right: parent.right
                spacing: 16

                StatusPanel {
                    id: statusPanel
                }

                WindEnergyPanel {
                    id: windEnergyPanel
                }
            }

            // Middle-Right Temperatures Panel
            TemperaturePanel {
                id: temperaturePanel
                anchors.right: parent.right
            }

            // Lower-Right Row: Stacked Metric Cards + Power Gauge Card
            Row {
                anchors.right: parent.right
                spacing: 14

                Column {
                    spacing: 12
                    MetricCard {
                        labelText: "Total Energy"
                        mainValue: "4"
                        subValue: ".2 GWh"
                    }
                    MetricCard {
                        labelText: "Power (10m)"
                        mainValue: "157"
                        subValue: ".2 k/W"
                    }
                }

                PowerGauge {
                    currentValue: 64
                    maxValue: 100
                }
            }
        }

        // 3. Lower-Left Section: Main Title, Subtitle, Progress Bar & Metrics
        Column {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            spacing: 24

            Column {
                spacing: 10

                Text {
                    text: "New Windmill Unit Software"
                    font.pixelSize: 42
                    font.weight: Font.Light
                    font.family: "Segoe UI, -apple-system, sans-serif"
                    color: "#ffffff"
                }

                Column {
                    spacing: 4
                    Text {
                        text: "Wind power generation uses wind turbines to"
                        font.pixelSize: 14
                        font.family: "Segoe UI, sans-serif"
                        color: Qt.rgba(1, 1, 1, 0.88)
                    }
                    Text {
                        text: "convert kinetic energy into electricity, offering a clean."
                        font.pixelSize: 14
                        font.family: "Segoe UI, sans-serif"
                        color: Qt.rgba(1, 1, 1, 0.88)
                    }
                }
            }

            ProgressBars {
                activeRatio: 0.61
            }
        }
    }

    // Auto-capture screenshot on launch for verification
    Timer {
        id: autoScreenshotTimer
        interval: 1400
        running: true
        repeat: false
        onTriggered: {
            container.grabToImage(function(result) {
                var savePath = "C:/Users/RAM/.gemini/antigravity-ide/brain/6b00ea54-00b7-4043-8409-0a5d2538a506/scratch/actual_render.png";
                result.saveToFile(savePath);
                console.log("QML grabToImage saved render to: " + savePath);
            });
        }
    }
}
