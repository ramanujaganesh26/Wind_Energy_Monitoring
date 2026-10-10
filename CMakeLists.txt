cmake_minimum_required(VERSION 3.16)

project(WindEnergyMonitoring_Dashboard VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(appWindEnergyMonitoring_Dashboard
    main.cpp
)

qt_add_qml_module(appWindEnergyMonitoring_Dashboard
    URI WindEnergyMonitoring_Dashboard
    QML_FILES
        Main.qml
        components/StatusPanel.qml
        components/WindEnergyPanel.qml
        components/TemperaturePanel.qml
        components/TemperatureIndicator.qml
        components/TurbineControl.qml
        components/ProgressBars.qml
        components/MetricCard.qml
        components/PowerGauge.qml
    RESOURCES
        assets/wind_turbine_bg.png
)

set_target_properties(appWindEnergyMonitoring_Dashboard PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWindEnergyMonitoring_Dashboard
    PRIVATE Qt6::Quick
)

install(TARGETS appWindEnergyMonitoring_Dashboard
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
