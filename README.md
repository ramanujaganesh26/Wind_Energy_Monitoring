# New Windmill Unit Software - Wind Energy Monitoring Dashboard

A full-screen industrial HMI (Human-Machine Interface) desktop dashboard built using **Qt 6.8**, **C++**, and **Qt Quick / QML**. Designed for real-time wind turbine telemetry and power generation analytics, featuring dark glassmorphism, dynamic visual gauges, animated spectrum bars, and interactive HUD controls over an atmospheric turbine background photograph.

---

## 🌟 Key Features

- **Interactive Turbine Hub HUD**: Features a rotating tech ring, pulsing core indicator, interactive scale arc (`10`–`80`), live RPM readout, and multi-turbine switcher (`Turbine #1`, `#2`, `#3`).
- **Real-Time Wind Energy Analytics**: Animated spectrum equalizer display simulating live wind turbulence harmonics with instantaneous power (`423.8 kW`) and wind speed (`17.4 m/s`) peak readouts.
- **Thermal & Environmental Telemetry**: 4-column glass temperature gauges (`Bearing`, `Ambient`, `Rotor`, `Stator`) with live thermal fluctuations, alongside sulfur (`0.29 mt`) and carbon dioxide (`6.24 mt`) impact tracking.
- **Power Output & Metric Gauge**: Custom semicircular canvas gauge with smooth needle pointer animation, dual-tone glowing track (`#f7b131` to `#ff5500`), digital kW readout (`64.8 kW`), and `Total Energy (4.2 GWh)` metrics.
- **Full-Screen Responsive HMI**: Edge-to-edge dark glass design with dynamic multi-resolution scaling and full-screen controls (`F11` / `Esc`).

---

## 🚀 Technology Stack

- **GUI Framework**: Qt 6.8.3 / Qt Quick (C++20 & QML)
- **Rendering Engine**: Qt Quick Canvas 2D & QML Shapes
- **Build System**: CMake 3.16+
- **Platform**: Windows 11 / Desktop HMI

---

## 🛠️ Build & Run Instructions

### Prerequisites
- Qt 6.8+ (with Qt Quick & Qt Quick Controls)
- CMake 3.16+
- MSVC 2022 or MinGW 64-bit compiler

### Building with CMake
```bash
# Configure project with Qt6 CMake path
cmake -B build -S . -DCMAKE_PREFIX_PATH="C:/Qt/6.8.3/msvc2022_64"

# Build Release binary
cmake --build build --config Release
```

### Running the Executable
```bash
./build/Release/appWindEnergyMonitoring_Dashboard.exe
```

---

## 📄 License
This project is open source and available under the [MIT License](LICENSE).
