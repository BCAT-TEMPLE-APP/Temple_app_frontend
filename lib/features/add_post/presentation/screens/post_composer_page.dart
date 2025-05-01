import 'dart:io';
import 'package:flutter/material.dart';

class PostComposerPage extends StatefulWidget {
  final String imagePath;

  const PostComposerPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<PostComposerPage> createState() => _PostComposerPageState();
}

class _PostComposerPageState extends State<PostComposerPage> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isPrivate = false;

  @override
  void dispose() {
    _captionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _sharePost() {
    // Implement post sharing functionality
    // This would typically involve uploading the image and post data to a server

    // For now, just print the information and navigate back to home
    print('Sharing post with:');
    print('Image: ${widget.imagePath}');
    print('Caption: ${_captionController.text}');
    print('Location: ${_locationController.text}');
    print('Private: $_isPrivate');

    // Navigate back to home/feed
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back button and header with share action
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 24),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Make the content scrollable to handle keyboard appearance
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select Image',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
            
                      // Selected image preview
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(widget.imagePath),
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
            
                      // Location field
                      const SizedBox(height: 24),
                      TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Add Location',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          prefixIcon: const Icon(Icons.location_on_outlined,
                              color: Colors.grey),
                        ),
                      ),
            
                      // Caption field
                      const SizedBox(height: 16),
                      TextField(
                        controller: _captionController,
                        decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        maxLines: 5,
                        minLines: 5,
                      ),
                      
                      // Add extra space at the bottom for scrolling when keyboard appears
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
            
            // Continue button stays at bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  
                  return SizedBox(
                    width: double.infinity,
                    height: screenWidth > 600 ? 56 : 48,
                    child: ElevatedButton(
                      onPressed: _sharePost,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: screenWidth > 600 ? 16 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth > 600 ? 28 : 24),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 18 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Add resizeToAvoidBottomInset to handle keyboard better
      resizeToAvoidBottomInset: false,
    );
  }
}
