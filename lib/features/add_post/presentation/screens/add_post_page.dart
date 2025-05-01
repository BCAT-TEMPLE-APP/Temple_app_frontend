import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'crop_page.dart'; // Import the crop page

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  AddPostPageState createState() => AddPostPageState();
}

class AddPostPageState extends State<AddPostPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final ImagePicker _picker = ImagePicker();
  List<CameraDescription> cameras = [];
  int _selectedCameraIndex = 0;
  bool _isInitialized = false;
  bool _isRecording = false;
  bool _isPhotoMode = true;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _initializeCamera();
  }

  Future<void> _requestPermissions() async {
    // Request camera and storage permissions
    await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ].request();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _initCamera(cameras[_selectedCameraIndex]);
      } else {
        setState(() {
          _isInitialized = false;
        });
      }
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _initCamera(CameraDescription camera) {
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _isInitialized = true;
      });
    }).catchError((error) {
      print('Error initializing camera controller: $error');
      setState(() {
        _isInitialized = false;
      });
    });
  }

  void _switchCamera() {
    if (cameras.isEmpty || cameras.length < 2) return;

    _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
    _isInitialized = false;

    _controller.dispose();
    _initCamera(cameras[_selectedCameraIndex]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      // Check if storage permission is granted
      var status = await Permission.storage.status;
      if (status.isDenied) {
        status = await Permission.storage.request();
        if (status.isDenied) {
          // Show message that permission is required
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Storage permission is required to pick images')),
          );
          return;
        }
      }

      final XFile? pickedFile = await _picker
          .pickImage(
        source: ImageSource.gallery,
      )
          .catchError((error) {
        print('Error picking image: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $error')),
        );
        return null;
      });

      if (pickedFile != null && mounted) {
        print('Image selected: ${pickedFile.path}');
        _navigateToCropPage(pickedFile.path);
      }
    } catch (e) {
      print('Image picker error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> _takePicture() async {
    if (!_isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera is not initialized')),
      );
      return;
    }

    try {
      await _initializeControllerFuture;
      final XFile image = await _controller.takePicture();
      print('Picture taken: ${image.path}');

      if (mounted) {
        _navigateToCropPage(image.path);
      }
    } catch (e) {
      print('Error taking picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take picture: $e')),
      );
    }
  }

  Future<void> _navigateToCropPage(String imagePath) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CropPage(imagePath: imagePath),
      ),
    );
  }

  void _toggleCameraMode() {
    setState(() {
      _isPhotoMode = !_isPhotoMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_isInitialized
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Initializing camera...',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          : Stack(
              children: <Widget>[
                // Camera Preview
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_controller),
                ),

                // Top Controls
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Settings button
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {},
                      ),

                      // Flash button
                      IconButton(
                        icon: const Icon(Icons.flash_off, color: Colors.white),
                        onPressed: () {},
                      ),

                      // Close button
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),

                // Bottom Controls
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Camera button and gallery access
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Gallery thumbnail button
                          GestureDetector(
                            onTap: _pickImageFromGallery,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.photo_library, size: 20),
                            ),
                          ),

                          // Capture button
                          GestureDetector(
                            onTap: _isPhotoMode
                                ? _takePicture
                                : () {
                                    // Handle video recording
                                    setState(() {
                                      _isRecording = !_isRecording;
                                    });
                                    if (_isRecording) {
                                      // Start recording
                                    } else {
                                      // Stop recording
                                    }
                                  },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        _isRecording ? Colors.red : Colors.cyan,
                                    width: 4),
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _isRecording
                                        ? Colors.red
                                        : Colors.cyan.shade800,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Switch camera button
                          IconButton(
                            icon: const Icon(Icons.flip_camera_ios,
                                color: Colors.white),
                            onPressed: _switchCamera,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Photo/Video mode selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Photo button
                          GestureDetector(
                            onTap: () {
                              if (!_isPhotoMode) _toggleCameraMode();
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _isPhotoMode
                                    ? Colors.cyan
                                    : Colors.transparent,
                                border: _isPhotoMode
                                    ? null
                                    : Border.all(color: Colors.grey.shade800),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'Photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: _isPhotoMode
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // Video button
                          GestureDetector(
                            onTap: () {
                              if (_isPhotoMode) _toggleCameraMode();
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: !_isPhotoMode
                                    ? Colors.cyan
                                    : Colors.transparent,
                                border: !_isPhotoMode
                                    ? null
                                    : Border.all(color: Colors.grey.shade800),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'Videos',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: !_isPhotoMode
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
