import 'package:flutter/material.dart';
import 'post_model.dart';
import 'api_service.dart';

class UpdatePostPage extends StatefulWidget {
  final Post post;
  final String token;

  const UpdatePostPage({
    super.key,
    required this.post,
    required this.token,
  });

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  final ApiService _apiService = ApiService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _bodyController = TextEditingController(text: widget.post.body);
  }

  void _updatePost() async {
    setState(() => isLoading = true);

    try {
      final updatedPost = await _apiService.updatePost(
        postId: widget.post.id,
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        token: widget.token,
      );

      Navigator.pop(context, updatedPost);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update failed')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : _updatePost,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
