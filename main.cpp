#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QTimer>
#include <QImage>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    bool isScreenshot = false;
    for (int i = 1; i < argc; ++i) {
        if (QString(argv[i]) == "--screenshot") {
            isScreenshot = true;
        }
    }

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    if (isScreenshot) {
        QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
            [&app](QObject *object, const QUrl &url) {
                QQuickWindow *window = qobject_cast<QQuickWindow*>(object);
                if (window) {
                    window->show();
                    window->requestActivate();
                    QTimer::singleShot(1500, [window, &app]() {
                        QImage img = window->grabWindow();
                        QString savePath = "C:/Users/RAM/.gemini/antigravity-ide/brain/6b00ea54-00b7-4043-8409-0a5d2538a506/scratch/actual_render.png";
                        if (img.save(savePath)) {
                            qInfo() << "SUCCESS: Screenshot saved to:" << savePath;
                        } else {
                            qWarning() << "FAIL: Could not save screenshot to:" << savePath;
                        }
                        app.quit();
                    });
                }
            });
    }

    engine.loadFromModule("WindEnergyMonitoring_Dashboard", "Main");

    return QGuiApplication::exec();
}
