import 'package:api_practice/post_model.dart';
import 'package:api_practice/update_screen.dart';
import 'package:flutter/material.dart';
import 'post_model.dart';
import 'api_service.dart';
import 'api_service.dart';


class HomePage extends StatefulWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();

  Post? post;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  void _loadPost() {
    // Dummy post (simulate fetched post)
    post = Post(
      id: 1,
      title: 'Old Title',
      body: 'Old Body',
      userId: 1,
    );
  }

  void _goToUpdate() async {
    final updatedPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdatePostPage(
          post: post!,
          token: widget.token,
        ),
      ),
    );

    if (updatedPost != null) {
      setState(() {
        post = updatedPost;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post!.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(post!.body),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _goToUpdate,
              child: const Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
}
