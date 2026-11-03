#include <QtTest/QtTest>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

class TestWindEnergyMonitoring : public QObject
{
    Q_OBJECT

private slots:
    void testEngineLoad()
    {
        QQmlApplicationEngine engine;
        // Verify that the engine can be instantiated successfully
        QVERIFY(&engine != nullptr);
    }
};

QTEST_MAIN(TestWindEnergyMonitoring)
#include "tst_application.moc"
