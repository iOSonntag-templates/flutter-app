

// ignore_for_file: avoid_print

import 'dart:io';

Future<void> forEachFileInDir(String dirPath, { required Future<void> Function(File file) action, bool recursive = false}) async
{
  final Directory dir = Directory(dirPath);
  final List<FileSystemEntity> files = dir.listSync(recursive: recursive);

  for (final FileSystemEntity file in files)
  {
    if (file is File)
    {
      await action(file);
    }
  }
}


Future<void> fileReplaceAll(String path, Pattern from, replace) async
{
  String? fileContent = await readFileAsString(path);

  if (fileContent == null)
  {
    throw Exception('File not found: $path');
  }

  fileContent = fileContent.replaceAll(from, replace);
  await writeFileAsString(path, fileContent);
}


Future<String?> readFileAsString(String path) async
{
  final File file = File(path);
  String? fileContent;

  if (await file.exists())
  {
    fileContent = await file.readAsString();
  }

  return fileContent;
}

Future<void> writeFileAsString(String path, String fileContent) async
{
  final File file = File(path);
  await file.writeAsString(fileContent);
}

