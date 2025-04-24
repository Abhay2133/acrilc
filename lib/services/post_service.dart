import 'dart:convert';
import 'dart:io';
import 'package:acrilc/constants/env.dart';
import 'package:acrilc/util.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:acrilc/models/post.dart';

/// Service to manage posts
class PostService {
  static Future<PostData?> getPost(String postId, [http.Client? client]) async {
    final url = Uri.parse('${ENV.baseUrl}/api/posts/$postId');

    final httpClient = client ?? http.Client();
    final request = http.Request('GET', url);

    String? token = await getAuthToken();
    if (token == null) {
      throw Exception("jwt token missing");
    }
    request.headers['Authorization'] = "Bearer $token";
    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      Map<String, dynamic> payload = jsonDecode(response.body);
      return PostData.fromJson(payload['data']);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<PostData> create(
    PostUploadData data, {
    http.Client? client,
  }) async {
    final url = Uri.parse('${ENV.baseUrl}/api/posts');
    final httpClient = client ?? http.Client();
    final request = http.MultipartRequest('POST', url);
    String? token = await getAuthToken();
    if (token == null) {
      throw Exception("jwt token missing");
    }
    request.headers['Authorization'] = "Bearer $token";
    // Add text fields
    Map<String, String> uploadData = data.normalize();
    uploadData.forEach((key, value) {
      if (value.trim().isNotEmpty) {
        request.fields[key] = value;
      }
    });

    // Add files
    for (var filePath in data.files) {
      final file = File(filePath);
      final fileName = path.basename(filePath);

      request.files.add(
        await http.MultipartFile.fromPath(
          'media', // must match backend field name
          file.path,
          filename: fileName,
          contentType: _detectMimeType(filePath),
        ),
      );
    }

    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseJson = jsonDecode(response.body);
      return PostData.fromJson(responseJson['data']);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<PostData> update(
    String postId,
    PostUploadData data, {
    http.Client? client,
  }) async {
    final url = Uri.parse('${ENV.baseUrl}/api/posts/$postId');
    final httpClient = client ?? http.Client();
    final request = http.MultipartRequest('PATCH', url);
    String? token = await getAuthToken();
    if (token == null) {
      throw Exception("jwt token missing");
    }
    request.headers['Authorization'] = "Bearer $token";
    // Add text fields
    Map<String, String> uploadData = data.normalize();
    uploadData.forEach((key, value) {
      if (value.trim().isNotEmpty) {
        request.fields[key] = value;
      }
    });

    // Add files
    for (var filePath in data.files) {
      final file = File(filePath);
      final fileName = path.basename(filePath);

      request.files.add(
        await http.MultipartFile.fromPath(
          'media', // must match backend field name
          file.path,
          filename: fileName,
          contentType: _detectMimeType(filePath),
        ),
      );
    }

    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseJson = jsonDecode(response.body);
      return PostData.fromJson(responseJson['data']);
    } else {
      throw Exception(response.body);
    }
  }

  // Optional: guess content type based on file extension
  static MediaType? _detectMimeType(String pathURL) {
    final mimeStr = lookupMimeType(pathURL);
    if (mimeStr != null) {
      return MediaType.parse(mimeStr);
    }
    return null;
  }

  // delete post
  static Future<void> deletePost(String postId, {http.Client? client}) async {
    final url = Uri.parse('${ENV.baseUrl}/api/posts/$postId');
    final httpClient = client ?? http.Client();
    final request = http.MultipartRequest('DELETE', url);

    String? token = await getAuthToken();
    if (token == null) {
      throw Exception("jwt token missing");
    }

    request.headers['Authorization'] = "Bearer $token";

    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<Map<String, dynamic>>?> getTrendingPosts([
    http.Client? client,
  ]) async {
    final url = Uri.parse('${ENV.baseUrl}/api/discover/trending');

    final httpClient = client ?? http.Client();
    final request = http.Request('GET', url);

    String? token = await getAuthToken();
    if (token == null) {
      throw Exception("jwt token missing");
    }
    request.headers['Authorization'] = "Bearer $token";
    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      List<dynamic> payload = jsonDecode(response.body);
      return convertToMapList(payload); //["data"];
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<Map<String, dynamic>>?> getPostsByForte(
    String forte, [
    http.Client? client,
  ]) async {
    final url = Uri.parse('${ENV.baseUrl}/api/discover/forte?forte=$forte');

    final httpClient = client ?? http.Client();
    final request = http.Request('GET', url);

    String? token = await getAuthToken();
    if (token == null) {
      throw Exception("jwt token missing");
    }
    request.headers['Authorization'] = "Bearer $token";
    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      List<dynamic> payload = jsonDecode(response.body);
      return convertToMapList(payload); //["data"];
    } else {
      throw Exception(response.body);
    }
  }


  static Future<List<Map<String, dynamic>>?> getPostsByUserId(
    String userId, [
    http.Client? client,
  ]) async {
    final url = Uri.parse('${ENV.baseUrl}/api/posts/user/$userId');

    final httpClient = client ?? http.Client();
    final request = http.Request('GET', url);

    String? token = await getAuthToken();
    if (token == null) {
      throw Exception("jwt token missing");
    }
    request.headers['Authorization'] = "Bearer $token";
    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      List<dynamic> payload = jsonDecode(response.body)['data'];
      return convertToMapList(payload); //["data"];
    } else {
      throw Exception(response.body);
    }
  }

}
