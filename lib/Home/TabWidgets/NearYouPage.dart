import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Utils/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/Helper.dart';

class NearYouPage extends StatefulWidget {
  const NearYouPage({super.key});

  @override
  State<NearYouPage> createState() => _NearYouPageState();
}

class _NearYouPageState extends State<NearYouPage> {
  @override
  void initState() {
    super.initState();
    getPeople();
  }

  var _loading = false;
  List<dynamic> people = [];
  getPeople(){
    requestAPI(getApiURL("api/nrm_offices"), {"districtoo":"Wakiso"}, (loading){setState(() {
      _loading = loading;
    });}, (response){
      setState(() {
        people = response;

      });
    }, (error){}, method: "GET");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "NRM Near You",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        elevation: 1,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : people.isEmpty
          ? const Center(
        child: Text(
          "contacts available",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: people.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final person = people[index];
          final latitude = person['latitude'];
          final longitude = person['longitude'];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: person['picture'] != null
                            ? NetworkImage(person['picture'])
                            : null,
                        child: person['picture'] == null
                            ? Text(
                          person['address']?[0]?.toUpperCase() ?? '?',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person['address'] ?? 'Unknown',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              person['phone'] ?? 'No phone',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${person['district'] ?? 'Unknown'}",
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  if (person['email'] != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.email, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            person['email'],
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          final mapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
                          launchUrl(Uri.parse(mapUrl));
                        },
                        icon: const Icon(Icons.location_on_rounded, size: 18),
                        label: const Text('Map'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          final phone = person['phone'] ?? '';
                          final whatsappUrl = "https://wa.me/${phone.replaceAll(' ', '').replaceAll('+', '')}";
                          launchUrl(Uri.parse(whatsappUrl));
                        },
                        icon: const Icon(Icons.chat, size: 18),
                        label: const Text('Chat'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          final phone = person['phone'] ?? '';
                          final telUrl = "tel:$phone";
                          launchUrl(Uri.parse(telUrl));
                        },
                        icon: const Icon(Icons.phone, size: 18),
                        label: const Text('Call'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
