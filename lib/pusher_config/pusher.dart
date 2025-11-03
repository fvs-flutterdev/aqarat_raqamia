import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';

class LaravelEcho{
  static LaravelEcho? _singleton;
  static late Echo _echo;
  final String token;
  LaravelEcho._({required this.token}){
    _echo=createLaravelEcho(token);
  }
  factory LaravelEcho.init({required String token}){
    if(_singleton==null || token !=_singleton?.token){
      _singleton=LaravelEcho._(token: token);
    }
    return _singleton!;
  }
  static Echo get instance=>_echo;
  static String get socketId=>_echo.socketId()??'11111.11111111';
}


class PusherConfig {
  // static const appId = "1678548";
  // static const key = "b8a13ba16ad1175b50a7";
  // static const secret = "8f39051e06bec9661be7";
  // static const cluster = "ap2";
  static const appId = "1796413";
  static const key = "7ea640883d8dea66aadf";
  static const secret = "e3d1f24a56bdd3e4c879";
  static const cluster = "eu";
  static const hostEndPoint = "https://dashboard.redd.sa";
  static const hostAuthEndPoint = "$hostEndPoint/broadcasting/auth";
  static const port = 443;
}

PusherClient createPusherClient(String token) {
  PusherOptions pusherOptions = PusherOptions(
      encrypted: true,
      wsPort: PusherConfig.port,
      host: PusherConfig.hostEndPoint,
      cluster: PusherConfig.cluster,
      auth: PusherAuth(PusherConfig.hostAuthEndPoint, headers: {
        'Authorization': "Bearer $token",
        'Content-Type': "application/json",
        'accept': "application/json"
      }));
  PusherClient pusherClient = PusherClient(PusherConfig.key, pusherOptions,
      autoConnect: false, enableLogging: true);
  return pusherClient;
}
Echo createLaravelEcho(String token){
  return Echo(client: createPusherClient(token),broadcaster: EchoBroadcasterType.Pusher);
}
