#ifndef CALCULATORLOGIC_H
#define CALCULATORLOGIC_H

#include <QObject>
#include <QString>
#include <QtQml/qqmlregistration.h>

class CalculatorLogic : public QObject
{
    Q_OBJECT
    QML_ELEMENT // Tells CMake to automatically register this class to QML

    // Exposes the calculator's screen text to QML
    Q_PROPERTY(QString displayText READ displayText NOTIFY displayTextChanged)

public:
    explicit CalculatorLogic(QObject *parent = nullptr);

    QString displayText() const;

    // Callable from QML when any button is pressed
    Q_INVOKABLE void buttonPressed(const QString &value);

signals:
    void displayTextChanged();

private:
    void performCalculation();

    QString m_displayText;
    double m_firstOperand;
    QString m_pendingOperator;
    bool m_clearOnNextInput;
};

#endif // CALCULATORLOGIC_H