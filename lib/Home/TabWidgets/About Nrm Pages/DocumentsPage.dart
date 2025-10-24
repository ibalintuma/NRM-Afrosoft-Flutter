import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/Constants.dart';
import '../../../Utils/Helper.dart';

class DocumentsPage extends StatefulWidget {
  @override
  State<DocumentsPage> createState() {
    return _DocumentsPage();
  }
}

class _DocumentsPage extends State<DocumentsPage> {
  // A helper function to open document URLs
  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getDocument();
  }

  var _loadingDocument = false;
  var _documents = [];
  void getDocument() {
    requestAPI(
      getApiURL("api/document_resources"),
      {"": ""},
      (loading) {
        setState(() {
          _loadingDocument = loading;
        });
      },
      (response) {
        setState(() {
          _documents = response["data"];
        });
      },
      (error) {},
      method: "GET",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        foregroundColor: Colors.black,
        title: const Text(
          'Documents',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child:
            _loadingDocument
                ? bossBaseLoader()
                : Column(
                  children:
                      _documents.map((doc) {
                        return Column(
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12.0,
                                      left: 12,
                                      right: 12,
                                    ),
                                    child: Text(
                                      doc['title']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        doc['image']!,
                                        height: 220,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ElevatedButton.icon(
                                      onPressed: () => _openUrl(doc['image']!),

                                      label: const Text(
                                        'View Document',
                                        style: TextStyle(
                                          color: const Color(0xFFFFD401),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        minimumSize: const Size(
                                          double.infinity,
                                          45,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                ),
      ),
    );
  }
}
