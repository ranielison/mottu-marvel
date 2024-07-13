import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';
import 'package:mottu_marvel/app/core/di/injection_container.dart' as di;
import 'package:mottu_marvel/app/data/models/character_model.dart';
import 'package:mottu_marvel/app/data/models/comic_item_model.dart';
import 'package:mottu_marvel/app/data/models/comic_model.dart';
import 'package:mottu_marvel/app/data/models/thumbnail_model.dart';
import 'package:mottu_marvel/app/presentation/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.init();

  await Hive.initFlutter();
  Hive.registerAdapter(CharacterResponseModelAdapter());
  Hive.registerAdapter(CharacterModelAdapter());
  Hive.registerAdapter(ComicModelAdapter());
  Hive.registerAdapter(ComicItemModelAdapter());
  Hive.registerAdapter(ThumbnailModelAdapter());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const App());
}
