import QtQuick
import QtQuick.Window
import QtMultimedia

Window {
    id: mainWindow
    visible: true
    title: "Camera Example"
    width: 400
    height: 300
    flags: Qt.Window | Qt.WindowTitleHint | Qt.WindowSystemMenuHint | Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint

    CaptureSession {
        id: captureSession
        camera: Camera {
            active: true
        }
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        anchors.margins: 6
        fillMode: VideoOutput.PreserveAspectCrop
    }
}
