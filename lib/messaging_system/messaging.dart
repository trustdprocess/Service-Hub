import 'package:flutter/material.dart';

class messaging extends StatefulWidget {
  final String technicianName;
  final String technicianContactNo;
  final String technicianEmail;

  messaging({
    required this.technicianName,
    required this.technicianContactNo,
    required this.technicianEmail,
  });

  @override
  State<messaging> createState() => _messagingState();
}

class _messagingState extends State<messaging> {
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];

  void _sendMessage() {
    String message = _messageController.text;
    // Implement logic to send the message to the technician using the contact info
    // For example, you can use an API to send an email or use a messaging service.
    // For this example, we'll just add the message to the list as a local demonstration.
    setState(() {
      _messages.add(message);
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaging ${widget.technicianName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Type your message...'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
