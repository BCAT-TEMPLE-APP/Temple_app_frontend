import 'package:flutter/material.dart';
import 'package:flutter_user_app/helper/navigation_helper.dart';
import 'package:flutter_user_app/screens/profile_screens/following_page.dart';
import 'package:flutter_user_app/screens/temple_screens/temple_page.dart';
import 'package:flutter_user_app/widgets/card_widgets/custom_creator_card.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_page_bar.dart';
import 'package:flutter_user_app/widgets/card_widgets/custom_temple_card.dart';
import 'package:flutter_user_app/widgets/follow_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  bool _isSearchActive = false;
  String _searchQuery = '';
  String selectedCategory = 'All'; // Add this variable
  // Remove the TabController since we'll use a different approach
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Define categories
  final List<String> categories = [
    'All',
    'NearBy',
    'Popular',
    'New',
    'Trending'
  ];

  // Sample data for search results
  final ApiService _apiService = ApiService();
  List<FollowItem> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Remove TabController initialization

    // Listen for focus changes to show/hide search results
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchActive = _searchFocusNode.hasFocus && _searchQuery.isNotEmpty;
        if (_isSearchActive) {
          _loadSearchResults();
        }
      });
    });

    // Add listener to search controller to handle empty text case
    _searchController.addListener(() {
      setState(() {
        // Only show search results if there's text and focus
        _isSearchActive =
            _searchController.text.isNotEmpty && _searchFocusNode.hasFocus;
      });
    });
  }

  Future<void> _loadSearchResults() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _apiService.fetchFollowItems();
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<FollowItem> get _filteredResults {
    if (_searchQuery.isEmpty) {
      return _searchResults;
    }
    return _searchResults
        .where((item) =>
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.location.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    // Remove the TabController disposal
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomPageBar(title: "Search"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  // Update _isSearchActive based on whether there's text
                  _isSearchActive =
                      value.isNotEmpty && _searchFocusNode.hasFocus;

                  // Only load results if there's something to search for
                  if (_isSearchActive) {
                    _loadSearchResults();
                  }
                });
              },
              hintText: 'Search...',
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 20)),
              leading: Icon(Icons.search, color: theme.colorScheme.onSurface),
            ),
          ),

          // Show search results or regular content based on search state
          Expanded(
            child: _isSearchActive
                ? _buildSearchResultsView(theme)
                : _buildRegularContent(theme),
          ),
        ],
      ),
    );
  }

  // Custom category button widget
  Widget buildCategory(String categoryName) {
    final isSelected = selectedCategory == categoryName;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = categoryName;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1DCAFF) // Change to the requested color #1DCAFF
              : const Color.fromRGBO(232, 241, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultsView(ThemeData theme) {
    return Column(
      children: [
        // Replace the old TabBar with the custom category tabs
        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                categories.map((category) => buildCategory(category)).toList(),
          ),
        ),

        const SizedBox(height: 8),

        // Content area
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildFilteredResults(),
        ),
      ],
    );
  }

  // New method to build filtered results based on selected category
  Widget _buildFilteredResults() {
    List<FollowItem> filteredItems;

    // Filter results based on selected category
    switch (selectedCategory) {
      case 'Temples':
        filteredItems =
            _filteredResults.where((item) => !item.isPerson).toList();
        break;
      case 'People':
        filteredItems =
            _filteredResults.where((item) => item.isPerson).toList();
        break;
      case 'Videos':
        // For demo purposes, just show some items
        filteredItems = _filteredResults.take(2).toList();
        break;
      case 'All':
      default:
        filteredItems = _filteredResults;
        break;
    }

    return _buildResultsList(filteredItems);
  }

  Widget _buildResultsList(List<FollowItem> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text("No results found"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FollowCard(
          item: items[index],
          onUnfollowPressed: () {
            // Handle follow action instead of unfollow
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Following ${items[index].name}'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRegularContent(ThemeData theme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
    );
  }
}
