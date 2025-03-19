import 'package:flutter/material.dart';
import 'package:flutter_intern_template/helper/navigation_helper.dart';
import 'package:flutter_intern_template/screens/temple_screens/temple_page.dart';
import 'package:flutter_intern_template/widgets/card_widgets/custom_creator_card.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_page_bar.dart';
import 'package:flutter_intern_template/widgets/card_widgets/custom_temple_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomPageBar(title: "Search"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              16, 16, 16, 0), // Removed bottom padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Add this
            children: [
              // Search Bar
              SearchBar(
                hintText: 'Search...',
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 20)),
                leading: Icon(Icons.search, color: theme.colorScheme.onSurface),
              ),

              const SizedBox(height: 24),

              // Most Popular Temple Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Most Popular Temple',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See All',
                        style: TextStyle(color: theme.colorScheme.primary)),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Temple Cards
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.22, // Make height responsive
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        navigateToPage(context, TemplePage());
                      },
                      child: TempleCard(
                        image:
                            'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
                        name: 'Kedarnath Mandir',
                        location: 'Uttarakhand',
                      ),
                    ),
                    const SizedBox(width: 12),
                    TempleCard(
                      image:
                          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
                      name: 'Kedarnath Ma',
                      location: 'Uttarakhand',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Most Popular Creator Section
              const Text(
                'Most Popular Creator',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Creator Cards with Horizontal Scroll
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.25, // Make height responsive
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: const [
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/32.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24), // Increased spacing between cards
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/33.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24), // Increased spacing between cards
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/34.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24), // Increased spacing between cards
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/35.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24), // Increased spacing between cards
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/36.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
