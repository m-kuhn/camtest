cmake_minimum_required(VERSION 3.16)
project(qml_camera_app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

# Allow static linking of Qt (when Qt is built static)
# Ensure CMake finds the static Qt libraries
if (DEFINED ENV{QT_STATIC})
    message(STATUS "Configuring for static Qt build")
    add_definitions(-DQT_STATIC)
endif()

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)

find_package(FFMPEG REQUIRED)
find_library(AVCODEC_LIBRARY avcodec)
find_library(AVDEVICE_LIBRARY avdevice)
find_library(AVFORMAT_LIBRARY avformat)
find_library(AVUTIL_LIBRARY avutil)
find_library(SWRESAMPLE_LIBRARY swresample)
find_library(SWSCALE_LIBRARY swscale)

qt_add_resources(qml_QRC qml/qml.qrc)

qt_add_executable(qml_camera_app
    main.cpp
     ${qml_QRC}
)

qt_add_qml_module(qml_camera_app
    URI qml_camera_app
    VERSION 1.0
    QML_FILES
        qml/main.qml
)

target_link_libraries(qml_camera_app
    PRIVATE
        Qt6::Quick
        Qt6::Multimedia
        ${AVCODEC_LIBRARY}
        ${AVDEVICE_LIBRARY}
        ${AVFORMAT_LIBRARY}
        ${AVUTIL_LIBRARY}
        ${SWRESAMPLE_LIBRARY}
        ${SWSCALE_LIBRARY}
)

# When statically linking, you often need to force plugins into the binary
# This ensures required Qt plugins (for QML, video, etc.) are linked.
qt_import_qml_plugins(qml_camera_app)
qt_import_plugins(qml_camera_app)
