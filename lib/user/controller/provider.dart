// lib/controller/provider.dart
import 'package:buzzme/user/view/screens/home/homescreen.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int _currentIndex = 0;
  List<Profile> _likedProfiles = [];
  List<Profile> _rejectedProfiles = [];
  List<ChatUser> _chatUsers = [];

  int get currentIndex => _currentIndex;
  List<Profile> get likedProfiles => _likedProfiles;
  List<Profile> get rejectedProfiles => _rejectedProfiles;
  List<ChatUser> get chatUsers => _chatUsers;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void initializeDemoData() {
    if (_likedProfiles.isEmpty) {
      _likedProfiles = [
        Profile(
          id: 'p1',
          name: 'Sarah',
          age: 28,
          location: 'New York, USA',
          imageUrl: 'assets/img1.jpg',
          interests: ['Reading', 'Hiking', 'Photography'],
        ),
        Profile(
          id: 'p2',
          name: 'David',
          age: 30,
          location: 'Los Angeles, USA',
          imageUrl: 'assets/img2.jpg',
          interests: ['Gaming', 'Coding', 'Movies'],
        ),
        Profile(
          id: 'p3',
          name: 'Jessica',
          age: 25,
          location: 'London, UK',
          imageUrl: "assets/img3.jpg",
          interests: ['Art', 'Dancing', 'Cooking'],
        ),
        Profile(
          id: 'p4',
          name: 'Michael',
          age: 29,
          location: 'Toronto, Canada',
          imageUrl: 'assets/img17.png',
          interests: ['Sports', 'Travel', 'Music'],
        ),
        Profile(
          id: 'p5',
          name: 'Emma',
          age: 27,
          location: 'Sydney, Australia',
          imageUrl: 'assets/img1.jpg',
          interests: ['Yoga', 'Coffee', 'Books'],
        ),
        Profile(
          id: 'p6',
          name: 'Alex',
          age: 26,
          location: 'Berlin, Germany',
          imageUrl: 'assets/img12.png',
          interests: ['Tech', 'Cycling', 'Beer'],
        ),
      ];
    }

    if (_rejectedProfiles.isEmpty) {
      _rejectedProfiles = [
        Profile(
          id: 'r1',
          name: 'Olivia',
          age: 24,
          location: 'Paris, France',
          imageUrl: 'assets/img4.png',
          interests: ['Fashion', 'Wine', 'Art'],
        ),
        Profile(
          id: 'r2',
          name: 'James',
          age: 31,
          location: 'Rome, Italy',
          imageUrl: 'assets/img14.png',
          interests: ['Food', 'History', 'Photography'],
        ),
        Profile(
          id: 'r3',
          name: 'Sophia',
          age: 26,
          location: 'Madrid, Spain',
          imageUrl: 'assets/img5.png',
          interests: ['Dance', 'Music', 'Travel'],
        ),
        Profile(
          id: 'r4',
          name: 'Lucas',
          age: 28,
          location: 'Amsterdam, Netherlands',
          imageUrl: 'assets/img17.png',
          interests: ['Cycling', 'Coffee', 'Design'],
        ),
        Profile(
          id: 'r5',
          name: 'Isabella',
          age: 23,
          location: 'Barcelona, Spain',
          imageUrl: 'assets/img6.png',
          interests: ['Beach', 'Fitness', 'Books'],
        ),
        Profile(
          id: 'r6',
          name: 'Noah',
          age: 32,
          location: 'Vienna, Austria',
          imageUrl: 'assets/img8.png',
          interests: ['Classical Music', 'Wine', 'Architecture'],
        ),
      ];
    }

    if (_chatUsers.isEmpty) {
      _chatUsers = [
        ChatUser(
          id: 'c1',
          name: 'Alice',
          lastMessage: 'Hey, how are you?',
          isOnline: true,
          imageUrl: 'https://randomuser.me/api/portraits/women/20.jpg',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        ChatUser(
          id: 'c2',
          name: 'Bob',
          lastMessage: 'Sounds good!',
          isOnline: false,
          imageUrl: 'https://randomuser.me/api/portraits/men/21.jpg',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        ChatUser(
          id: 'c3',
          name: 'Charlie',
          lastMessage: 'See you tomorrow!',
          isOnline: true,
          imageUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        ChatUser(
          id: 'c4',
          name: 'Diana',
          lastMessage: 'Thanks for the recommendation!',
          isOnline: false,
          imageUrl: 'assets/img8.png',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
    }
    notifyListeners();
  }

  void addLikedProfile(Profile profile) {
    if (!_likedProfiles.any((p) => p.id == profile.id)) {
      _likedProfiles.insert(0, profile); // Add to beginning for recent first
      notifyListeners();
    }
  }

  void addRejectedProfile(Profile profile) {
    if (!_rejectedProfiles.any((p) => p.id == profile.id)) {
      _rejectedProfiles.insert(0, profile); // Add to beginning for recent first
      notifyListeners();
    }
  }

  void removeLikedProfile(String profileId) {
    _likedProfiles.removeWhere((profile) => profile.id == profileId);
    notifyListeners();
  }

  void removeRejectedProfile(String profileId) {
    _rejectedProfiles.removeWhere((profile) => profile.id == profileId);
    notifyListeners();
  }

  void clearLikedProfiles() {
    _likedProfiles.clear();
    notifyListeners();
  }

  void clearRejectedProfiles() {
    _rejectedProfiles.clear();
    notifyListeners();
  }

  // Chat related methods
  void addChatUser(ChatUser chatUser) {
    if (!_chatUsers.any((user) => user.id == chatUser.id)) {
      _chatUsers.insert(0, chatUser);
      notifyListeners();
    }
  }

  void updateLastMessage(String userId, String message) {
    final userIndex = _chatUsers.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      _chatUsers[userIndex] = _chatUsers[userIndex].copyWith(
        lastMessage: message,
        timestamp: DateTime.now(),
      );
      // Move to top of list
      final updatedUser = _chatUsers.removeAt(userIndex);
      _chatUsers.insert(0, updatedUser);
      notifyListeners();
    }
  }
}

// lib/models/data_models.dart

// Profile Model
// class Profile {
//   final String id;
//   final String name;
//   final int age;
//   final String location;
//   final String imageUrl;
//   final List<String> interests;
//   final String? bio;

//   Profile({
//     required this.id,
//     required this.name,
//     required this.age,
//     required this.location,
//     required this.imageUrl,
//     this.interests = const [],
//     this.bio,
//   });

//   Profile copyWith({
//     String? id,
//     String? name,
//     int? age,
//     String? location,
//     String? imageUrl,
//     List<String>? interests,
//     String? bio,
//   }) {
//     return Profile(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       age: age ?? this.age,
//       location: location ?? this.location,
//       imageUrl: imageUrl ?? this.imageUrl,
//       interests: interests ?? this.interests,
//       bio: bio ?? this.bio,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'age': age,
//       'location': location,
//       'imageUrl': imageUrl,
//       'interests': interests,
//       'bio': bio,
//     };
//   }

//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       age: json['age'] ?? 0,
//       location: json['location'] ?? '',
//       imageUrl: json['imageUrl'] ?? '',
//       interests: List<String>.from(json['interests'] ?? []),
//       bio: json['bio'],
//     );
//   }
// }

// ChatUser Model
class ChatUser {
  final String id;
  final String name;
  final String lastMessage;
  final bool isOnline;
  final String? imageUrl;
  final DateTime timestamp;

  ChatUser({
    required this.id,
    required this.name,
    required this.lastMessage,
    this.isOnline = false,
    this.imageUrl,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  ChatUser copyWith({
    String? id,
    String? name,
    String? lastMessage,
    bool? isOnline,
    String? imageUrl,
    DateTime? timestamp,
  }) {
    return ChatUser(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      isOnline: isOnline ?? this.isOnline,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${(difference.inDays / 7).floor()}w ago';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastMessage': lastMessage,
      'isOnline': isOnline,
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      isOnline: json['isOnline'] ?? false,
      imageUrl: json['imageUrl'],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }
}

// Message Model
class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final MessageType type;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.type = MessageType.text,
  });

  Message copyWith({
    String? id,
    String? senderId,
    String? text,
    DateTime? timestamp,
    bool? isMe,
    MessageType? type,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isMe: isMe ?? this.isMe,
      type: type ?? this.type,
    );
  }

  String get timeString {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isMe': isMe,
      'type': type.toString(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      text: json['text'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isMe: json['isMe'] ?? false,
      type: MessageType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => MessageType.text,
      ),
    );
  }
}

enum MessageType { text, image, emoji }
