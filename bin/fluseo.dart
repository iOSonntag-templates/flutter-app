



// ignore_for_file: avoid_print

import 'dart:io' show Directory, File;

import 'package:rename/enums.dart';
import 'package:rename/rename.dart';
import 'package:yaml/yaml.dart';

import 'util/file_util.dart';
import 'util/yaml_util.dart';

class FluseoConfig {

  String? _appName;
  String get appName => _appName ?? (throw Exception('Error in fluseo.yaml: key app_name is missing.'));

  String? _appPackage;
  String get appPackage => _appPackage ?? (throw Exception('Error in fluseo.yaml: key app_package is missing.'));

  String? _appId;
  String get appId => _appId ?? (throw Exception('Error in fluseo.yaml: key app_id is missing.'));

  FluseoConfig(Map? yamlFile)
  {
    _appName = yamlFile?['app_name'];
    _appPackage = yamlFile?['app_package'];
    _appId = yamlFile?['app_id'];
  }

  @override
  String toString()
  {
    return '''app_name: $_appName
> app name (shown to users)

app_package: $_appPackage
> dart package name (used in import statements)

app_id: $_appId
> the application id or bundle id


''';
  }
}



Future<void> main() async
{
  print('Running fluseo...\n');

  final Map pubspecConfig = loadPubspecConfig();
  final FluseoConfig config = FluseoConfig(loadYamlConfig('fluseo.yaml'));
  print('[fluseo.yaml]');
  print(config);

  await renameAppIdAndNameIfNeeded(config);

  final String? appPackage = pubspecConfig['name'];

  if (appPackage == null)
  {
    throw Exception('Error: key name is missing in pubspec.yaml.');
  }

  if (appPackage != config.appPackage)
  {
    print('app_package changed from $appPackage to ${config.appPackage}');

    final String importOld = 'import \'package:$appPackage/';
    final String importNew = 'import \'package:${config.appPackage}/';

    print('Updating import statements in dart files...');
    int dartFilesCount = 0;
    int noneDartFilesCount = 0;

    await forEachFileInDir('lib/', 
      recursive: true,
      action: (file) async
      {
        if (file.path.endsWith('.dart'))
        {
          dartFilesCount++;
          await fileReplaceAll(file.path, importOld, importNew);
        }
        else
        {
          noneDartFilesCount++;
        }
      }
    );

    print('Updated $dartFilesCount dart files');
    print('Skipped $noneDartFilesCount files because of missing .dart extension');

    print('Updating package name in pubspec.yaml');
    await fileReplaceAll('pubspec.yaml', 'name: $appPackage', 'name: ${config.appPackage}');
  }




  print('fluseo complete');
}

FluseoConfig getFluseoConfig()
{
  final File fluseoYamlFile = File('fluseo.yaml');

  final Map? fluseoConfig = loadYaml(fluseoYamlFile.readAsStringSync());

  if (fluseoConfig == null)
  {
    throw Exception('Error: file fluseo.yaml is missing.');
  }

  return FluseoConfig(fluseoConfig);
}

Future<void> renameAppIdAndNameIfNeeded(FluseoConfig config) async
{
  const Map<String, RenamePlatform> platformMap = {
    'android': RenamePlatform.android,
    'ios': RenamePlatform.ios,
    'linux': RenamePlatform.linux,
    'macos': RenamePlatform.macOS,
    'web': RenamePlatform.web,
    'windows': RenamePlatform.windows,
  };
  
  List<RenamePlatform> platforms = [];

  for (var platform in platformMap.keys)
  {
    if (Directory(platform).existsSync())
    {
      platforms.add(platformMap[platform]!);
    }
  }

  print('platforms: ${platforms.map((e) => e.name).toList()}');


  final rename = Rename.fromTargets(targets: platforms);

  for (var platformFileEditor in rename.platformFileEditors.values)
  {
    final String? currentName = await platformFileEditor.getAppName();
    final String? currentId = await platformFileEditor.getBundleId();

    if (currentName == null || currentName != config.appName)
    {
      print('Updating app_name of ${platformFileEditor.platform.name} to ${config.appName}');
      await platformFileEditor.setAppName(appName: config.appName);
    }

    if (currentId == null || currentId != config.appId)
    {
      print('Updating app_id of ${platformFileEditor.platform.name} to ${config.appId}');
      await platformFileEditor.setBundleId(bundleId: config.appId);
    }
  }
}

