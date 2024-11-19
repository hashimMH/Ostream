import 'package:dio/dio.dart';
import 'package:ostream/utils/app/my_app.dart';
import 'package:ostream/utils/resources/app_colors.dart';
import 'package:quickalert/quickalert.dart';

Future<String?> uploadPDF(String filePath, String apiKey) async {
  final dio = Dio();
  try {
    print("success");
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath,
          filename: filePath
              .split('/')
              .last),
    });
    QuickAlert.show(
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.info,
        title: 'Full version feature',
        text: "This feature will be available in the full version",
        confirmBtnColor: AppColors.mainColor
    );
    // print('before1');
    // final response = await dio.post(
    //   'https://api.chatpdf.com/sources/add-file',
    //   data: formData,
    //   options: Options(
    //     headers: {
    //       'Authorization': 'Bearer $apiKey',
    //     },
    //   ),
    // );
    // print('before2');
    // if (response.statusCode == 200) {
    //   print('hjhghjgjhg');
    //   return response.data['fileId']; // Assuming the API returns a fileId
    // }
  } catch (e) {
    print('Error uploading PDF: $e');
  }
  return null;
}
