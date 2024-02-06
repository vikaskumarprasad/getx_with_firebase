import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMManager {
  //initialising firebase message plugin
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising flutter local notification plugin
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static initFCM() async {
    requestNotificationPermission();
    forgroundMessage();
    firebaseInit();
    setupInteractMessage();
    isTokenRefresh();

    getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  static void initLocalNotifications(RemoteMessage message) async {
    //ANDROID Setting
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    //IOS Setting
    const DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //Initialize android and iOS Settings
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIos);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      _navigate(message);
    });
  }

  static void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification!.android;
      log("In Foreground Call ");

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        // print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      initLocalNotifications(message);
      showNotification(message);
    });
  }

  //Request For Permissions
  static requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  static Future<void> showNotification(RemoteMessage message) async {
    String? _title = message.notification?.title ?? "";
    String? _body = message.notification?.body ?? "";

    // String? _title = message.data["title"];
    // String? _body = message.data["message"];
    // AndroidNotificationChannel channel = AndroidNotificationChannel(
    //     message.notification!.android!.channelId.toString(),
    //     message.notification!.android!.channelId.toString(),
    //     importance: Importance.max,
    //     showBadge: true,
    //     playSound: true,
    //     sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'));

    log("In Show Notification Call${message.data}");

    ///TODO : Change Your Image URL which was passing from the Notification Side
    String largeImage =
        "https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png";
    String bigImage =
        "https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png";
    final ByteArrayAndroidBitmap largeIcon =
        ByteArrayAndroidBitmap(await _getByteArrayFromUrl(largeImage));
    final ByteArrayAndroidBitmap bigPicture =
        ByteArrayAndroidBitmap(await _getByteArrayFromUrl(bigImage));

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture,
            largeIcon: largeIcon,
            contentTitle: _title,
            hideExpandedLargeIcon: true,
            htmlFormatContentTitle: true,
            summaryText: _body,
            htmlFormatSummaryText: true);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_ID',
      'channel name',
      enableLights: true,
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //Get image using dio to show in foreground Notifications
  static Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final d.Dio dio = d.Dio();

    try {
      final d.Response response = await dio.get<Uint8List>(url,
          options: d.Options(responseType: d.ResponseType.bytes));

      return response.data;
    } on d.DioException catch (e) {
      // Handle errors appropriately
      throw Exception('Failed to fetch data: ${e.message}');
    }
  }

  //Token
  //function to get device token on which we will send the notifications
  static Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  static isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  static Future<void> setupInteractMessage() async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _navigate(initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("In Background Call ");
      _navigate(event);
    });
  }

  static _navigate(RemoteMessage message) {
    // if(message.data['type'] =='msj'){
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => MessageScreen(
    //         id: message.data['id'] ,
    //       )));
    // }
    log("navigate $message");
    String notificationType = message.data['type'] ?? "";

    if (notificationType == "/testScreen") {
      // Get.toNamed(SignUpScreen.routeName);
    }
  }

  static Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
