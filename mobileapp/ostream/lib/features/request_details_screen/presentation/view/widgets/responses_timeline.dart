import 'package:flutter/material.dart';

import '../request_details_screen.dart';

class ResponsesTimeline extends StatelessWidget {
  final List<Map<String, String>> responses;

  const ResponsesTimeline({required this.responses, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: responses.length,
      itemBuilder: (context, index) {
        final response = responses[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Indicator
            const CircleAvatar(
              radius: 8,
              backgroundColor: Colors.green,
            ),
            const SizedBox(width: 16),

            // Response Content
            Expanded(
              child: ResponseCard(response: response),
            ),
          ],
        );
      },
    );
  }
}


class ResponseCard extends StatelessWidget {
  final Map<String, String> response;

  const ResponseCard({required this.response, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  response["author"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  response["date"]!,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(response["response"]!),
          ],
        ),
      ),
    );
  }
}
