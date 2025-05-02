import 'package:flutter_user_app/features/posts/domain/entities/post_entity.dart';

import 'post_model.dart';

final List<PostEntity> dummyPosts = [
  PostModel(
    id: 'post1',
    username: 'john_doe',
    userImage: 'https://example.com/images/user1.jpg',
    location: 'Mumbai, India',
    caption:
        'Sunset vibes 🌅 Beautiful sunset at Marine Drive! Jai Shree Ram Jai Shree Ram Jai Shree Ram Jai Shree Ram Radhe Radhe Radhe Radhe ',
    imageUrls: [
      'https://www.skmystic.in/cdn/shop/articles/1683680049609.jpg',
      'https://cdn11.bigcommerce.com/s-x49po/images/stencil/1500x1500/products/87852/251230/1663008078544_Screenshot_20220911-201613_Photos__16690.1687002981.jpg',
    ],
    likes: 152,
    likedBy: ['alice', 'bob', 'charlie'],
    timestamp: '2025-04-30 18:45:00',
  ),
  PostModel(
    id: 'post2',
    username: 'travel_guru',
    userImage:
        'https://www.justahotels.com/wp-content/uploads/2023/07/Manali-Travel-Guide.jpg',
    location: 'Manali, India',
    caption: 'Chilling in the hills ❄️ Manali is breathtaking during winter.',
    imageUrls: [
      'https://www.justahotels.com/wp-content/uploads/2023/07/Manali-Travel-Guide.jpg',
    ],
    likes: 240,
    likedBy: ['john_doe', 'emma', 'rohit'],
    timestamp: '2025-04-29 15:20:00',
  ),
  PostModel(
    id: 'post3',
    username: 'foodie_queen',
    userImage: 'https://example.com/images/user3.jpg',
    location: 'Delhi, India',
    caption: 'Street food goals 🍜 Tried the best chole bhature today!',
    imageUrls: [
      'https://krishnastore.com/images/cache/579-743x1000.webp',
      'https://ih1.redbubble.net/image.3037705125.1924/raf,360x360,075,t,fafafa:ca443f4786.jpg',
      'https://m.media-amazon.com/images/I/81uXT9fiVML.jpg',
    ],
    likes: 321,
    likedBy: ['rahul', 'sana', 'zoya'],
    timestamp: '2025-04-28 12:10:00',
  ),
];
