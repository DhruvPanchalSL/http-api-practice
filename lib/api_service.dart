import 'dart:convert';

import 'package:api_practice/post_model.dart';
import 'package:api_practice/post_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
 Future<PostResponse>fetchPosts()async{
   final url=Uri.parse('https://dummyjson.com/posts');
   final response=await http.get(url);

    if(response.statusCode==200){
      final jsonData=jsonDecode(response.body);
      return PostResponse.fromJson(jsonData);
    }
    else{
      throw Exception('Failed to fetch');
    }
  }
  
  Future<Post>createPost()async{
   final response=await http.post(
     Uri.parse('https://dummyjson.com/posts/add'),
     headers: {
       'Content-type':'application/json',
     },
     body: jsonEncode({
        'title':'Learning Flutter',
        'body':'Post Api is easy',
        'userId':1,
     }),
   );
   if(response.statusCode==201){
     final jsonData=jsonDecode(response.body);
     return Post.fromJson(jsonData);
    }else{
     throw Exception('Failed to create post');
    }
  }

  Future<String>login({required String username,
    required String password,})async{
  final url=Uri.parse('https://dummyjson.com/auth/login');
   final response=await http.post(url,
   headers: {
     'Content-Type':'application/json'
   },
     body: jsonEncode({
       'username':username,
       'password':password,
     }),
   );
   if(response.statusCode==200){
     final data=jsonDecode(response.body);
     return data['accessToken'];
   }
   else{
     throw Exception('Login Failed');
   }

  }
  
}
