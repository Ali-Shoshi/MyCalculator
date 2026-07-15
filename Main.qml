import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Calculator

ApplicationWindow {
    id: window
    width: 375
    height: 550
    minimumWidth: 375
    minimumHeight: 550
    maximumWidth: 375
    maximumHeight: 550
    visible: true
    title: qsTr("My Calculator")

    property bool lightMode: Application.styleHints.colorScheme === Qt.Light
    property color reallyDark: "#1f1f1f"
    property color dark: "#262626"
    property color reallyLight: "#e7e7e7"
    property color light: "#e0e0e0"

    CalculatorLogic {
        id: calcLogic
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 10

        component CalcButton : Button {
            id: control
            property color btnColor: "#4a4a4a"
            property color hoverColor: "#5a5a5a"
            property color pressColor: "#3a3a3a"
            property color textColor: "white"

            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: calcLogic.buttonPressed(control.text)

            contentItem: Text {
                text: control.text
                font.pointSize: 20
                color: control.textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                radius: 10
                color: control.pressed ? control.pressColor :
                       (control.hovered ? control.hoverColor : control.btnColor)

                Behavior on color { ColorAnimation { duration: 100 } }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "#f0f0f0"
            border.color: "#ccc"

            Text {
                text: calcLogic.displayText
                font.pointSize: 24
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
            }
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 4
            columnSpacing: 6
            rowSpacing: 6

            CalcButton { text: "7" }
            CalcButton { text: "8" }
            CalcButton { text: "9" }
            CalcButton { text: "/"; btnColor: "#ff9f0a"; hoverColor: "#d4d4d4"; pressColor: "#7c7c7c"; textColor: "black" }

            CalcButton { text: "4" }
            CalcButton { text: "5" }
            CalcButton { text: "6" }
            CalcButton { text: "*"; btnColor: "#ff9f0a"; hoverColor: "#d4d4d4"; pressColor: "#7c7c7c"; textColor: "black" }

            CalcButton { text: "1" }
            CalcButton { text: "2" }
            CalcButton { text: "3" }
            CalcButton { text: "-"; btnColor: "#ff9f0a"; hoverColor: "#d4d4d4"; pressColor: "#7c7c7c"; textColor: "black" }

            CalcButton { text: "C"; btnColor: "#ff9f0a"; hoverColor: "#d4d4d4"; pressColor: "#7c7c7c"; textColor: "black" }
            CalcButton { text: "0" }
            CalcButton { text: "="; btnColor: "#ff9f0a"; hoverColor: "#d4d4d4"; pressColor: "#7c7c7c"; textColor: "black" }
            CalcButton { text: "+"; btnColor: "#ff9f0a"; hoverColor: "#d4d4d4"; pressColor: "#7c7c7c"; textColor: "black" }
        }
    }
}