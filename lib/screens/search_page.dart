import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.grey),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),  // Removed bottom padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,  // Add this
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    child: const Text('See All', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Temple Cards
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.22,  // Make height responsive
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    TempleCard(
                      image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
                      name: 'Kedarnath Mandir',
                      location: 'Uttarakhand',
                    ),
                    const SizedBox(width: 12),
                    TempleCard(
                      image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
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
                height: MediaQuery.of(context).size.height * 0.25,  // Make height responsive
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: const [
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/32.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24),  // Increased spacing between cards
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/33.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24),  // Increased spacing between cards
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/34.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24),  // Increased spacing between cards
                    CreatorCard(
                      image: 'https://randomuser.me/api/portraits/men/35.jpg',
                      name: 'Shayam',
                      subtitle: 'Shayam Verma',
                    ),
                    SizedBox(width: 24),  // Increased spacing between cards
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

class TempleCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;

  const TempleCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: screenWidth * 0.45,  // Make width responsive
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF1DCAFF),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: Color(0xFF1DCAFF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CreatorCard extends StatelessWidget {
  final String image;
  final String name;
  final String subtitle;

  const CreatorCard({
    super.key,
    required this.image,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: screenWidth * 0.15,
            height: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DCAFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                'Follow',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
