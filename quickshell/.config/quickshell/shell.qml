import Quickshell
import QtQuick

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 32

    Text {
        anchors.centerIn: parent
        text: "Butter Bar :)"
        color: "#c6a0f6"
        font.pixelSize: 16
    }
}
