import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'apiKey', obfuscate: true)
  static final String apiKey = _Env.apiKey;

  @EnviedField(varName: 'appId', obfuscate: true)
  static final String appId = _Env.appId;

  @EnviedField(varName: 'messagingSenderId', obfuscate: true)
  static final String messagingSenderId = _Env.messagingSenderId;
  
  @EnviedField(varName: 'projectId', obfuscate: true)
  static final String projectId = _Env.projectId;
}
