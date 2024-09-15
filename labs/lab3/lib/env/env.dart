import 'package:envied/envied.dart';
import 'package:flutter/material.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'GOOGLE_MAPS_API_KEY', obfuscate: true)
  static final Key googleMapsApiKey = _Env.googleMapsApiKey as Key;
}
