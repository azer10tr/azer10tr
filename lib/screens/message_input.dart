import 'package:flutter/material.dart';


class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final String receiverId;
  final VoidCallback onSend;

  const MessageInput({
    super.key,
    required this.controller,
    required this.receiverId,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Écrire un message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onSubmitted: (value) { // Modification clé ici
                if (value.trim().isNotEmpty) onSend();
              },
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              tooltip: 'Envoyer',
              onPressed: onSend,
            ),
          ),
        ],
      ),
    );
  }
}
