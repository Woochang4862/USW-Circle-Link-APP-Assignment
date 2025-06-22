import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

// 백그라운드 메시지 핸들러 (Top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // pass
}

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _log = Logger('FCMService');

  Future<void> initialize() async {
    // 권한 요청
    await _firebaseMessaging.requestPermission();

    // 포그라운드 메시지 핸들링
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _log.info('Got a message whilst in the foreground!');
      if (message.notification != null) {
        _log.info(
            'Message also contained a notification: ${message.notification}');
      }
    });

    // 백그라운드 메시지 핸들러 등록
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<String?> getToken() async {
    return "dummyToken"; // 더미 토큰으로 대체
  }
}
