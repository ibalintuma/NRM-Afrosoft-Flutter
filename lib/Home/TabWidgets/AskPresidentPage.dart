import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AskPage.dart';

class AskPresidentPage extends StatefulWidget {
  const AskPresidentPage({super.key});

  @override
  State<AskPresidentPage> createState() => _AskPresidentPageState();
}

class _AskPresidentPageState extends State<AskPresidentPage> {
  late YoutubePlayerController _youtubeController;
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    super.initState();
    // Replace with your YouTube video ID
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'n3wTLsvzTSc',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFFFFD401),
            foregroundColor: Colors.black87,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(
                            'assets/drawable/logo.png',
                            height: 50, // smaller height
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(
                            'assets/drawable/hero.png',
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    bottom: -5,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle "ASK THE PRESIDENT" action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AskPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          94,
                          128,
                          186,
                        ),
                        foregroundColor: const Color(0xFFFFD401),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'ASK THE PRESIDENT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // YouTube video
                  YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.green,
                  ),
                  const SizedBox(height: 16),

                  // Headings
                  const Text(
                    'H.E Yoweri Kaguta Museveni',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'President of Uganda',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/drawable/sevo6.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text content
                  const Text('''
President Yoweri Kaguta Museveni is a man of strong convictions and rare courage. He takes risks and pursues national interests above his personal comfort and safety. He is a result-oriented leader, whose calling to politics is borne out of a deep and unwavering commitment to finding lasting solutions to the challenges of society.

He displays exceptional understanding of the historical and social challenges of African societies. This is what inspired his direct involvement in the liberation and emancipation of his countrymen and women.

Museveni has been politically active since his school days. He started waking up Banyankole from poverty as early as 1959 when he joined Mbarara High School. He strongly discouraged nomadism. Later when he joined Ntare School, he doubled as president of the debating society and scripture union. These helped perfect his convictions and shaped him for leadership.

His political awareness and ideological orientation became more focused during the three years (1967 to 1970) he spent at the University of Dar es Salaam. The university provided a very conducive atmosphere for pan-Africanism and anti-imperialism. While there, he became the president of the University Students’ African Revolutionary Front (USARF), providing an opportunity for him to gain mentorship from President Julius Nyerere. It is while at this university that he developed far-reaching pan-Africanist and revolutionary ideas.

Museveni was instrumental in forming Front for National Salvation (FRONASA), which was the core of Ugandan fighting groups that, together with the Tanzanian People’s Defence Forces, ousted Idi Amin’s regime in April 1979.

On 29th January 1986, Museveni became President of the Republic of Uganda after leading a protracted five-year liberation struggle. This was a people’s resistance, with no external base, relying entirely on popular community support, to save their country from total collapse and abuse of the dignity of human life.
''', style: TextStyle(fontSize: 16, height: 1.5, ), textAlign: TextAlign.justify,),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/drawable/sevo7.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text content
                  const Text('''
On 29th January 1986, Museveni became President of the Republic of Uganda after leading a protracted five-year liberation struggle that started out with only 27 guns. This was a people’s resistance, with no external base, relying entirely on popular community support, to save their country from total collapse and abuse of the dignity of human life. The only other liberation struggle to achieve so much with so little was the Cuban Revolution of 1953 to 1958.
Upon coming to power, he laid a firm foundation for reconciliation and national harmony, proving that people of differing cultural, religious and political allegiances can form a broad-based government.

Since 1986, the NRM, under the leadership of President Museveni has demonstrated the revolutionary effect that good leadership can have on a country. He inherited a country and an economy in ruins. The colonial enclave economy had almost disappeared by the time the NRM took power. Under Museveni’s leadership, the NRM initiated socio-economic policies designed to combat key challenges, including insecurity of person and property, extra-judicial killings, and rampant shortages of essential commodities.

 

''', style: TextStyle(fontSize: 16, height: 1.5)),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/drawable/sevo1.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text content
                  const Text('''
Uganda, under Museveni’s leadership, has registered tremendous and steady progress in all sectors of the economy. The size of the economy has grown close to tenfold since 1986. The GDP per capita has quadrupled. Ugandans today live healthier and longer lives. They are better educated. Children no longer die of preventable diseases, and are attending school free of charge. Infrastructure has tremendously improved. The total tarmacked road network has increased five-fold. Electricity shortages are no more, instead the country is struggling to consume the surplus power generated. Tele-communication has improved, almost every adult has a phone.

''', style: TextStyle(fontSize: 16, height: 1.5)),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/drawable/sevo2.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text content
                  const Text('''
Under President Museveni’s leadership, Uganda has significantly contributed to regional peace, security and stability. For instance, Uganda supported the African National Congress (ANC) of South Africa by hosting ANC fighters and training them for the liberation of South Africa against apartheid. Uganda also contributed to the restoration of peace in Rwanda, resettlement of refugees who had spread across East Africa and ending the genocide.

Today, Uganda is a host to about 1.5 million refugees because it is a safe country, unlike the days when her own people filled the refugee camps in the region. Uganda has been lauded internationally as a model for its refugee hosting policy. During his time as President, the Uganda Uganda People’s Defence Forces (UPDF) has played a vital and positive role in ensuring peace in the Democratic Republic of Congo, South Sudan, Somalia, Sierra Leone, Liberia and Central African Republic. President Museveni is a strong advocate of African unity and integration.

He is among the African statesmen increasingly credited for championing African unity. Indeed, African diplomats fondly refer to him as “the African Bismarck”. He is driven by the urgent need to permanently cure Africa’s vulnerable position in the global arena of economic and political giants.

Uganda, under Museveni’s leadership, has registered tremendous and steady progress in all sectors of the economy. The size of the economy has grown close to tenfold since 1986. The GDP per capita has quadrupled. Ugandans today live healthier and longer lives. They are better educated. Children no longer die of preventable diseases, and are attending school free of charge. Infrastructure has tremendously improved. The total tarmacked road network has increased five-fold. Electricity shortages are no more, instead the country is struggling to consume the surplus power generated. Tele-communication has improved, almost every adult has a phone.

Under President Museveni’s leadership, Uganda has significantly contributed to regional peace, security and stability. For instance, Uganda supported the African National Congress (ANC) of South Africa by hosting ANC fighters and training them for the liberation of South Africa against apartheid. Uganda also contributed to the restoration of peace in Rwanda, resettlement of refugees who had spread across East Africa and ending the genocide.
Today, Uganda is a host to about 1.5 million refugees because it is a safe country, unlike the days when her own people filled the refugee camps in the region. Uganda has been lauded internationally as a model for its refugee hosting policy. During his time as President, the Uganda Uganda People’s Defence Forces (UPDF) has played a vital and positive role in ensuring peace in the Democratic Republic of Congo, South Sudan, Somalia, Sierra Leone, Liberia and Central African Republic. President Museveni is a strong advocate of African unity and integration.

He is among the African statesmen increasingly credited for championing African unity. Indeed, African diplomats fondly refer to him as “the African Bismarck”. He is driven by the urgent need to permanently cure Africa’s vulnerable position in the global arena of economic and political giants.

 



''', style: TextStyle(fontSize: 16, height: 1.5)),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/drawable/sevo3.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text content
                  const Text('''
As one who dedicated his youthful years to Africa’s liberation struggles against oppressive regimes, Museveni is deeply concerned that Africa is still an easy prey for plunder and marginalisation, as long as the strides towards economic and political integration remain lethargic. This explains his passionate fight against the subsistence mindset of our communities, and championing prioritisation of infrastructural development, in addition to his efforts towards the pacification of conflict-ridden neighbours and tireless call for regional integration.

Museveni’s transformative leadership has earned him several accolades. New York University and World Bank experts have ranked him among the most transformative leaders in the world who have presided over their countries’ rapid economic growth. He was awarded the Global Peace Award from the Global Peace Foundation for his display of courage, exemplary democratic and global leadership.

In addition, he received the AfrikaVerein Award for excellence in leadership from the German-Africa Business Association. Museveni was the first African president to receive this prestigious award. He has been awarded several honorary doctorates, including; Humphrey School of Public Affairs – Minnesota, Latin University of Theology-USA, University of Dar es Salaam – Tanzania, Makerere University and Mbarara University – Uganda.

One of Museveni’s most widely noted accomplishment has been his government’s successful campaign against HIV/AIDS. Uganda has a unique success story in the global battle against the virus. On the 21st of January, 2020, President Museveni received The African Leadership Magazine Award, in London, in honour of his contribution to the liberation struggles of Africa and good leadership skills.

He has also been recently credited for championing a decisive battle against the COVID-19 pandemic in Uganda by taking quick and bold measures to combat its spread. The Prestigious Lancet Medical journal credited Uganda among the ten best countries in the world and the best country in Africa in responding to the COVID-19 pandemic.

''', style: TextStyle(fontSize: 16, height: 1.5)),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/drawable/sevo4.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text content
                  const Text('''
Museveni has successfully ensured security, democracy and delivery of social services for the betterment of Ugandans. It is no accident, therefore, that Uganda is today enjoying peace from corner to corner of the country and with its neighbours. The country is now seen as a beacon of peace. Museveni is happily married to Janet Kataha Museveni, with children and bazzukulu (grandchildren).


''', style: TextStyle(fontSize: 16, height: 1.5)),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/drawable/sevo5.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text content
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Born',
                              style: TextStyle(
                                fontSize: 14,

                                height: 1.5,
                                color: Color.fromARGB(255, 94, 128, 186),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'September 15, 1944, Ntungamo',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Spouse',
                              style: TextStyle(
                                fontSize: 14,

                                height: 1.5,
                                color: Color.fromARGB(255, 94, 128, 186),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Janet Museveni',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Children',
                              style: TextStyle(
                                fontSize: 14,

                                height: 1.5,
                                color: Color.fromARGB(255, 94, 128, 186),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Muhoozi, Natasha Karugire, Patience, Diana',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Education',
                              style: TextStyle(
                                fontSize: 14,

                                height: 1.5,
                                color: Color.fromARGB(255, 94, 128, 186),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'University of Dar es Salaam, Ntare School',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: const Text(
                      'Reach the President',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Divider(
                    color: Color.fromARGB(255, 94, 128, 186),
                    thickness: 2,
                  ),
                  const SizedBox(height: 12),

                  // Placeholder for social media buttons (can replace with icons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialItem(
                        imagePath: 'assets/drawable/icons8_youtube_100.png',
                        label: 'YouTube',
                        color: Colors.red,
                        url: 'https://www.youtube.com/@NrmUgOnline',
                      ),
                      const SizedBox(width: 25),
                      _socialItem(
                        imagePath: 'assets/drawable/facebook_white.png',
                        label: 'Facebook',
                        color: Colors.blue,
                        url: 'https://www.facebook.com/NRMPartyUganda/',
                      ),
                      const SizedBox(width: 25),
                      _socialItem(
                        imagePath: 'assets/drawable/icons8_instagram_100.png',
                        label: 'Instagram',
                        color: Colors.deepOrange,
                        url: 'https://www.instagram.com/nrmuganda/?hl=en',
                      ),
                      const SizedBox(width: 25),
                      _socialItem(
                        imagePath: 'assets/drawable/icons8_twitter_24.png',
                        label: 'Twitter',
                        color: Colors.lightBlue,
                        url:
                            'https://x.com/NRMOnline?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor',
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialItem({
    required String imagePath,
    required String label,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(imagePath, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
