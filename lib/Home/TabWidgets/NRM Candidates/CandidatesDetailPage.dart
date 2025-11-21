import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/NRM%20Candidates/CandidatesListPage.dart';

class CandidatesDetailPage extends StatefulWidget {
  const CandidatesDetailPage({super.key});

  @override
  State<CandidatesDetailPage> createState() => _CandidatesDetailPageState();
}

class _CandidatesDetailPageState extends State<CandidatesDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _districts = [
    "Abim",
    "Adjumani",
    "Agago",
    "Alebtong",
    "Amolatar",
    "Amudat",
    "Amuria",
    "Amuru",
    "Apac",
    "Arua",
    "Budaka",
    "Bududa",
    "Bugiri",
    "Bugweri",
    "Buhweju",
    "Buikwe",
    "Bukedea",
    "Bukomansimbi",
    "Bukwo",
    "Bulambuli",
    "Buliisa",
    "Bundibugyo",
    "Bunyangabu",
    "Bushenyi",
    "Busia",
    "Butaleja",
    "Butambala",
    "Butebo",
    "Buvuma",
    "Buyende",
    "Dokolo",
    "Gomba",
    "Gulu",
    "Hoima",
    "Ibanda",
    "Iganga",
    "Isingiro",
    "Jinja",
    "Kaabong",
    "Kabale",
    "Kabarole",
    "Kaberamaido",
    "Kagadi",
    "Kakumiro",
    "Kalangala",
    "Kaliro",
    "Kalungu",
    "Kamuli",
    "Kamwenge",
    "Kanungu",
    "Kapchorwa",
    "Kapelebyong",
    "Karenga",
    "Kasese",
    "Kassanda",
    "Katakwi",
    "Kayunga",
    "Kazo",
    "Kibaale",
    "Kiboga",
    "Kibuku",
    "Kikube",
    "Kiruhura",
    "Kiryandongo",
    "Kisoro",
    "Kitagwenda",
    "Kitgum",
    "Koboko",
    "Kole",
    "Kotido",
    "Kumi",
    "Kwania",
    "Kween",
    "Kyankwanzi",
    "Kyegegwa",
    "Kyenjojo",
    "Kyotera",
    "Lamwo",
    "Lira",
    "Luuka",
    "Luwero",
    "Lwengo",
    "Lyantonde",
    "Madi Okollo",
    "Manafwa",
    "Maracha",
    "Masaka",
    "Masindi",
    "Mayuge",
    "Mbale",
    "Mbarara",
    "Mitooma",
    "Mityana",
    "Moroto",
    "Moyo",
    "Mpigi",
    "Mubende",
    "Mukono",
    "Nabilatuk",
    "Nakapiripirit",
    "Nakaseke",
    "Nakasongola",
    "Namayingo",
    "Namisindwa",
    "Namutumba",
    "Napak",
    "Nebbi",
    "Ngora",
    "Ntoroko",
    "Ntungamo",
    "Nwoya",
    "Obongi",
    "Omoro",
    "Otuke",
    "Oyam",
    "Pader",
    "Rakai",
    "Rubanda",
    "Rubirizi",
    "Rukiga",
    "Rukungiri",
    "Rwampara",
    "Sembabule",
    "Serere",
    "Sheema",
    "Sironko",
    "Soroti",
    "Tororo",
    "Wakiso",
    "Yumbe",
    "Zombo",
    "Kampala"
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter districts based on search query
    final filteredDistricts =
        _districts
            .where(
              (district) =>
                  district.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select District',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search district',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // Districts list
          Expanded(
            child: ListView.builder(
              itemCount: filteredDistricts.length,
              itemBuilder: (context, index) {
                final district = filteredDistricts[index];
                return GestureDetector(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => CandidatesListPage( district : district ) ) );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: const Color(0xFFFFD401),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            district,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
