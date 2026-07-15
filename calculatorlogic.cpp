#include "calculatorlogic.h"

CalculatorLogic::CalculatorLogic(QObject *parent)
    : QObject{parent}, m_displayText("0"), m_firstOperand(0.0), m_pendingOperator(""), m_clearOnNextInput(false)
{}

QString CalculatorLogic::displayText() const{
    return m_displayText;
}
void CalculatorLogic::buttonPressed(const QString &value) {
    if (value == "C") {
        m_displayText = "0";
        m_firstOperand = 0.0;
        m_pendingOperator = "";
        m_clearOnNextInput = false;
        emit displayTextChanged();
        return;
    }

    if (value == "+" || value == "-" || value == "*" || value == "/") {
        m_firstOperand = m_displayText.toDouble();
        m_pendingOperator = value;
        m_clearOnNextInput = true;
        return;
    }

    if (value == "=") {
        performCalculation();
        m_pendingOperator = "";
        m_clearOnNextInput = true;
        return;
    }

    // Handle number inputs (0-9)
    if (m_displayText == "0" || m_clearOnNextInput) {
        m_displayText = value;
        m_clearOnNextInput = false;
    } else {
        m_displayText += value;
    }

    emit displayTextChanged();
}

void CalculatorLogic::performCalculation() {
    if (m_pendingOperator.isEmpty()) return;

    double secondOperand = m_displayText.toDouble();
    double result = 0.0;

    if (m_pendingOperator == "+") result = m_firstOperand + secondOperand;
    else if (m_pendingOperator == "-") result = m_firstOperand - secondOperand;
    else if (m_pendingOperator == "*") result = m_firstOperand * secondOperand;
    else if (m_pendingOperator == "/") {
        if (secondOperand == 0.0) {
            m_displayText = "Error"; // Prevent crash on division by zero
            emit displayTextChanged();
            return;
        }
        result = m_firstOperand / secondOperand;
    }

    m_displayText = QString::number(result);
    emit displayTextChanged();
}