import 'package:flutter/material.dart';
import 'package:flutter_user_app/core/helper/navigation_helper.dart';
import 'package:flutter_user_app/features/creator/presentation/screens/creator_page.dart';
import 'package:flutter_user_app/features/profile/presentation/screens/following_page.dart';
import 'package:flutter_user_app/features/temples/data/dummy/temples_dummy_data.dart';
import 'package:flutter_user_app/features/creator/data/dummy/creators_dummy_data.dart';
import 'package:flutter_user_app/features/temples/presentation/screens/temple_page.dart';
import 'package:flutter_user_app/widgets/card_widgets/custom_creator_card.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_page_bar.dart';
import 'package:flutter_user_app/widgets/card_widgets/custom_temple_card.dart';
import 'package:flutter_user_app/widgets/custom_widgets/follow_card.dart';

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
              elevation: WidgetStateProperty.all(1),
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
    final theme = Theme.of(context);
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
              ? theme.colorScheme.primary
              : theme.colorScheme.primaryContainer.withAlpha(100),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onPrimaryContainer,
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

            const SizedBox(height: 8),

            // Temple Cards
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dummyTemples.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final temple = dummyTemples[index];
                  return Hero(
                    tag: temple.imageUrl,
                    createRectTween: (Rect? begin, Rect? end) {
                      return CustomRectTween(begin: begin, end: end);
                    },
                    child: TempleCard(
                      templeModel: temple,
                      onTap: () {
                        navigateToPage(
                            context,
                            TemplePage(
                              templeModel: temple,
                            )); // Pass temple if needed
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Most Popular Creator Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Most Popular Creator',
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

            const SizedBox(height: 18),

            // Creator Cards with Horizontal Scroll
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dummyCreators.length,
                separatorBuilder: (_, __) => const SizedBox(width: 24),
                itemBuilder: (context, index) {
                  final creator = dummyCreators[index];

                  return CreatorCard(
                    creatorsModel: creator,
                    onTap: () {
                      navigateToPage(
                          context,
                          CreatorPage(
                            creatorsModel: creator,
                          )); // Pass temple if needed
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRectTween extends RectTween {
  CustomRectTween({required super.begin, required super.end});

  @override
  Rect lerp(double t) {
    // Ensure begin and end are not null
    final Rect start = begin ?? Rect.zero;
    final Rect endRect = end ?? Rect.zero;

    return Rect.fromLTWH(
      start.left + (endRect.left - start.left) * t,
      start.top + (endRect.top - start.top) * t,
      start.width + (endRect.width - start.width) * t,
      start.height + (endRect.height - start.height) * t,
    );
  }
}
