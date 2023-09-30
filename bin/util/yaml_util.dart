


import 'dart:io';

import 'package:yaml/yaml.dart';

Map loadPubspecConfig()
{
  return loadYamlConfig('pubspec.yaml');
}

Map loadYamlConfig(String yamlPath)
{
  final File yamlFile = File(yamlPath);

  if (!yamlFile.existsSync())
  {
    throw Exception('Error: file $yamlPath is missing.');
  }

  final Map? yamlData = loadYaml(yamlFile.readAsStringSync());

  if (yamlData == null)
  {
    throw Exception('Error: file $yamlPath is missing.');
  }

  return yamlData;
}

