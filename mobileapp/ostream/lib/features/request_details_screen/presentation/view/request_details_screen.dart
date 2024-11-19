import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ostream/utils/resources/app_colors.dart';
import 'package:ostream/utils/resources/constants.dart';

import '../../../../common_widgets/input_field.dart';
import '../../../../utils/helper/localization_helper.dart';
import '../../../my_requests_screen/data/model/my_request_model.dart';
import 'widgets/gradient_header.dart';
import 'widgets/project_overview_card.dart';
import 'widgets/responses_timeline.dart';

class RequestDetailsScreen extends StatefulWidget {
  static const routeName = "/RequestDetailsScreen";

  RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final TextEditingController _replyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MyRequestsModel data =
        ModalRoute.of(context)!.settings.arguments as MyRequestsModel;

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            requestTitle: data.title,
            requestStatus: data.status,
            lastUpdate: data.lastUpdate,
          ),
          const SizedBox(height: 16),
          ProjectOverviewCard(
            description: data.description,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ResponsesTimeline(
              responses: data.responses,
            ),
          ),
          if (data.status == "Rejected")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.pagePadding).copyWith(bottom: 20),
              child: Form(
                key: _formKey,
                child: MyInputFiled(
                  hint: 'Write your review ...',
                  label: 'Reply to Project Review',
                  keyboard: TextInputType.multiline,
                  action: TextInputAction.newline,
                  controller: _replyController,
                  inputIcon: IconlyLight.chat,
                  suffixIcon: IconlyBold.send,
                  minLine: 2,
                  maxLine: 3,
                  onSuffixPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Create a new response with the user's input
                      final newResponse = {
                        "author": "Current User", // Replace with actual user name or ID
                        "date": DateTime.now().toString(), // Replace with formatted date as needed
                        "response": _replyController.text.trim(),
                      };

                      // Add the new response to the responses list
                      setState(() {
                        data.responses.add(newResponse);
                      });

                      // Clear the text field after submission
                      _replyController.clear();

                      // Optionally, show a confirmation message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Reply sent successfully")),
                      );
                    }
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return translate(context).please_fill_req_field; // Replace with your translation or message
                    }
                    return null;
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
