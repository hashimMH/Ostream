import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> pickPDFFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  return result?.files.single;
}
