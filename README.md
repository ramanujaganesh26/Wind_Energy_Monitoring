<div align="center">

# New Windmill Unit Software
### *Next-Generation Industrial Wind Energy HMI & Telemetry Dashboard*

[![Release](https://img.shields.io/github/v/release/ramanujaganesh26/Wind_Energy_Monitoring?color=ff6b2b&label=Latest%20Release)](https://github.com/ramanujaganesh26/Wind_Energy_Monitoring/releases/tag/v1.0.0)
[![Qt Version](https://img.shields.io/badge/Qt-6.8.3-41CD52?logo=qt)](https://www.qt.io/)
[![Language](https://img.shields.io/badge/C%2B%2B-20-00599C?logo=c%2B%2B)](https://isocpp.org/)
[![QML](https://img.shields.io/badge/UI-Qt%20Quick%20%2F%20QML-00d0d0)](https://doc.qt.io/qt-6/qtquick-index.html)

---

</div>

## Application Interface

![New Windmill Unit Software Dashboard Preview](assets/IMG/software_preview.png)

> **Demonstration Video**: [Watch System Demonstration Clip](assets/IMG/Software_gif.mp4)

---

## Executive Summary

**New Windmill Unit Software** is a full-screen, high-performance industrial Human-Machine Interface (HMI) desktop monitoring system developed using **Qt 6.8**, **C++20**, and **Qt Quick / QML**. Engineered for real-time wind turbine telemetry tracking and power generation analytics, the system features dark glassmorphism, animated visual indicators, high-DPI canvas telemetry gauges, and interactive HUD controls layered over an atmospheric wind farm background.

---

## Download & Release Package

- **[Latest Release v1.0.0](https://github.com/ramanujaganesh26/Wind_Energy_Monitoring/releases/tag/v1.0.0)**
- **[Download Source Code Archive (.zip)](https://github.com/ramanujaganesh26/Wind_Energy_Monitoring/releases/download/v1.0.0/New_Windmill_Unit_Software_v1.0.0_SourceCode.zip)**
- **[View All Tags](https://github.com/ramanujaganesh26/Wind_Energy_Monitoring/tags)**

---

## Key System Capabilities

| Feature Component | Description & Visual Highlight |
| :--- | :--- |
| **Turbine Hub HUD** | Rotating tech ring with 60° notches, pulsing core indicator, interactive scale arc (`10`–`80`), live RPM readout (`14.8 RPM`), and multi-turbine switcher (`Turbine #1`, `#2`, `#3`). |
| **Wind Energy Analytics** | Dynamic spectrum equalizer displaying live wind turbulence harmonics with instantaneous peak power (`423.8 kW`) and wind velocity (`17.4 m/s`). |
| **Thermal Gauges** | 4-column glass temperature columns (`Bearing 69.0 °C`, `Ambient 9.8 °C`, `Rotor 15.0 °C`, `Stator 37.0 °C`) with live micro-fluctuations and diagonal hatch textures. |
| **Power Output Gauge** | Semicircular Canvas gauge with smooth spring needle pointer, dual-tone glowing gradient track (`#f7b131` to `#ff5500`), digital readout (`64.8 kW`), and environmental impact badges (`SO₂ 0.29 mt`, `CO₂ 6.24 mt`). |
| **Segmented Metrics Bar** | Glowing 3D-pill segmented progress bar with real-time target metrics (`150,000 kW Target`, `123,547 kW Power Generation`, `87.59% Degree of Completion`). |
| **Glass Metric Cards** | Elevated light off-white cards (`Total Energy 4.2 GWh` & `Power 157.2 k/W`) with subtle hover elevation feedback. |

---

## Control & Interaction Matrix

| Input | Action |
| :--- | :--- |
| `F11` | Toggle Full-Screen Borderless Mode |
| `Esc` | Exit Full-Screen Mode |
| `Click` on Hub Switcher | Toggle active turbine telemetry (`Turbine #1` -> `#2` -> `#3`) |
| `Hover` on Cards | Highlight glass borders & elevate visual depth |

---

## Project Architecture

```
Wind_Energy_Monitoring/
├── CMakeLists.txt                # Root CMake build specification (Qt 6.8)
├── main.cpp                      # C++ entry point & QQmlApplicationEngine
├── Main.qml                      # Root edge-to-edge QML ApplicationWindow
├── assets/
│   ├── wind_turbine_bg.png       # High-res atmospheric turbine photo asset
│   └── IMG/
│       ├── software_preview.png  # Interface screenshot preview
│       └── Software_gif.mp4      # System demonstration video clip
├── components/
│   ├── StatusPanel.qml           # Translucent status card with pulsing Active pill
│   ├── WindEnergyPanel.qml       # Animated wind spectrum equalizer card
│   ├── TemperaturePanel.qml      # 4-column thermal telemetry container
│   ├── TemperatureIndicator.qml  # Animated temperature column with hatch fill
│   ├── TurbineControl.qml        # Technical HUD overlay, rotating ring & scale arc
│   ├── ProgressBars.qml          # Segmented pill progress bar & target metrics
│   ├── MetricCard.qml            # Elevated off-white glass metric card
│   └── PowerGauge.qml            # Semicircular Canvas power gauge with needle
└── README.md                     # Project documentation
```

---

## Build & Installation Guide

### System Prerequisites
- **Qt SDK**: Qt 6.8.0 or higher (Qt Quick, Qt Quick Controls 2)
- **Compiler**: MSVC 2022 (64-bit) or MinGW 11+
- **Build Tool**: CMake 3.16+

### Step-by-Step Compilation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ramanujaganesh26/Wind_Energy_Monitoring.git
   cd Wind_Energy_Monitoring
   ```

2. **Configure with CMake**:
   ```bash
   cmake -B build -S . -DCMAKE_PREFIX_PATH="C:/Qt/6.8.3/msvc2022_64"
   ```

3. **Build the Release Executable**:
   ```bash
   cmake --build build --config Release
   ```

4. **Launch Application**:
   ```bash
   ./build/Release/appWindEnergyMonitoring_Dashboard.exe
   ```
