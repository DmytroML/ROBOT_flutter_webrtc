import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';



void main() {
  runApp(const MyApp());
}
// Головний клас додатка
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Визначаємо структуру додатка та його тему
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebRTC Receiver',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VideoScreen(),
    );
  }
}
// Екран для відображення відеопотоку та керування підключенням
class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});
// Створюємо стан для цього екрану, де буде логіка роботи з відео та підключенням
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}
// Стан для VideoScreen, де ми будемо керувати відео-плеєром та підключенням до Python
class _VideoScreenState extends State<VideoScreen> {
  // 1. Створюємо контролер для відео-плеєра WebRTC
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  bool _isConnected = false;

// Ініціалізуємо плеєр при старті екрану
  @override
  void initState() {
    super.initState(); // Спочатку запускаємо логіку самого Flutter
    _initRenderer();   // А потім ініціалізуємо наш плеєр
  }

// Ініціалізуємо плеєр при старті екрану
  // Ініціалізуємо плеєр при старті екрану
  void _initRenderer() async {
    await _localRenderer.initialize();
  }
// Очищаємо пам'ять при закритті додатка
  @override
  void dispose() {
    // Очищаємо пам'ять при закритті додатка
    _localRenderer.dispose();
    super.dispose();
  }

  // Функція-заглушка для майбутнього підключення до Python
  void _connectToPython() {
    setState(() {
      _isConnected = true;
    });
    print("Кнопку натиснуто! Тут буде логіка сигналінгу.");
  }
// Відображаємо інтерфейс користувача
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebRTC Receiver з Python')),
      body: Column(
        children: [
          // 2. Вікно для відображення відеопотоку
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              color: Colors.black87,
              child: _isConnected
                  ? RTCVideoView(_localRenderer) // Попередня версія плеєра
                  : const Center(
                      child: Text(
                        'Натисніть "Підключитися", щоб почати стрім',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ),
          // 3. Кнопка керування
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _connectToPython,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(_isConnected ? 'Підключено' : 'Підключитися'),
            ),
          ),
        ],
      ),
    );
  }
}