import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:post_gram_ui/data/repositories/database_repository.dart';
import 'package:post_gram_ui/firebase_options.dart';

Future initApp() async {
  await DatabaseRepository.initialize();
  await initFireBase();
}

Future initFireBase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true);

  FirebaseMessaging.onMessage.listen(catchMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(catchMessage);
  try {
    print(await messaging.getToken() ?? "no token");
  } catch (e) {
    print(e.toString());
  }
}

void catchMessage(RemoteMessage message) {
  print("${message.data} ${message.notification}");
}
