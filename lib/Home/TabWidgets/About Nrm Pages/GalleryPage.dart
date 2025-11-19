import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AlbumDetailPage.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<Album>> albums;

  @override
  void initState() {
    super.initState();
    albums = fetchAlbums();
  }

  Future<List<Album>> fetchAlbums() async {
    final url = Uri.parse(
      'https://nrm.afrosoftug.com/api/albums',
    ); // Replace with your API endpoint
    ;

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> albumsJson =
          jsonResponse['data']; // Extract `data` list
      return albumsJson.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFFD401),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Album>>(
        future: albums,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No albums available.'));
          } else {
            final albumList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two albums per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: albumList.length,
                itemBuilder: (context, index) {
                  final album = albumList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumDetailPage(album: album),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                album.coverImage,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.broken_image,
                                      size: 48,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  album.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text('${album.pictureCount} pictures'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class Album {
  final String id;
  final String title;
  final List<Picture> pictures;

  Album({required this.id, required this.title, required this.pictures});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      pictures:
          (json['pictures'] as List)
              .map((picture) => Picture.fromJson(picture))
              .toList(),
    );
  }

  String get coverImage => pictures.isNotEmpty ? pictures[0].imageUrl : '';
  int get pictureCount => pictures.length;
}

class Picture {
  final String id;
  final String imageUrl;
  final String? description;

  Picture({required this.id, required this.imageUrl, this.description});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      imageUrl: json['image'],
      description: json['description'],
    );
  }
}
