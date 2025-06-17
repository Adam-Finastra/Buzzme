
import 'package:buzzme/user/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:buzzme/user/widgets/custom_widgets.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  // Demo data
  List<ChatUser> getDemoUsers() {
    return [
      ChatUser(
        id: '1',
        name: 'Emma',
        lastMessage: 'send a Gif',
        isOnline: true,
        avatarUrl: 'https://picsum.photos/150/150?random=1',
      ),
      ChatUser(
        id: '2',
        name: 'Jerome Bell',
        lastMessage: 'send a Gif',
        isOnline: false,
        avatarUrl: 'https://picsum.photos/150/150?random=2',
      ),
      ChatUser(
        id: '3',
        name: 'Kathryn Murphy',
        lastMessage: 'send a Gif',
        isOnline: true,
        avatarUrl: 'https://picsum.photos/150/150?random=3',
      ),
      ChatUser(
        id: '4',
        name: 'Jane Cooper',
        lastMessage: 'send a Gif',
        isOnline: false,
        avatarUrl: 'https://picsum.photos/150/150?random=4',
      ),
      ChatUser(
        id: '5',
        name: 'Darlene Robertson',
        lastMessage: 'send a Gif',
        isOnline: true,
        avatarUrl: 'https://picsum.photos/150/150?random=5',
      ),
      ChatUser(
        id: '6',
        name: 'Marvin McKinney',
        lastMessage: 'send a Gif',
        isOnline: false,
        avatarUrl: 'https://picsum.photos/150/150?random=6',
      ),
      ChatUser(
        id: '7',
        name: 'Courtney Henry',
        lastMessage: 'send a Gif',
        isOnline: true,
        avatarUrl: 'https://picsum.photos/150/150?random=7',
      ),
      ChatUser(
        id: '8',
        name: 'Darrell Steward',
        lastMessage: 'send a Gif',
        isOnline: false,
        avatarUrl: 'https://picsum.photos/150/150?random=8',
      ),
      ChatUser(
        id: '9',
        name: 'Cameron Williamson',
        lastMessage: 'send a Gif',
        isOnline: true,
        avatarUrl: 'https://picsum.photos/150/150?random=9',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // --- Updated Responsive Scaling Factor Calculation for iPhone 12 Pro ---
    const double baseScreenHeight = 844.0; // iPhone 12 Pro height
    double scaleFactor = screenHeight / baseScreenHeight;
    const double minScaleFactor =
        0.75; // Reduced from 0.8 for smaller UI elements
    const double maxScaleFactor = 0.95; // Added max scale to prevent oversizing

    if (scaleFactor < minScaleFactor) {
      scaleFactor = minScaleFactor;
    } else if (scaleFactor > maxScaleFactor) {
      scaleFactor = maxScaleFactor;
    }
    // --- End Updated Responsive Scaling Factor Calculation ---

    final chatUsers = getDemoUsers();

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.04 * scaleFactor, // Reduced from 0.05
                screenHeight * 0.015 * scaleFactor, // Reduced from 0.02
                screenWidth * 0.04 * scaleFactor, // Reduced from 0.05
                screenHeight * 0.008 * scaleFactor, // Reduced from 0.01
              ),
              child: Row(
                children: [
                  Text(
                    'Chats',
                    style: GoogleFonts.poppins(
                      fontSize:
                          screenWidth *
                          0.055 *
                          scaleFactor, // Reduced from 0.06
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Chat list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      screenWidth * 0.035 * scaleFactor, // Reduced from 0.04
                  vertical:
                      screenHeight * 0.008 * scaleFactor, // Reduced from 0.01
                ),
                itemCount: chatUsers.length,
                itemBuilder: (context, index) {
                  final chatUser = chatUsers[index];
                  return ChatListItem(
                    chatUser: chatUser,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    scaleFactor: scaleFactor, // Pass scaleFactor
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

// Chat List Item Widget
class ChatListItem extends StatelessWidget {
  final ChatUser chatUser;
  final double screenWidth;
  final double screenHeight;
  final double scaleFactor; // New: scaleFactor

  const ChatListItem({
    Key? key,
    required this.chatUser,
    required this.screenWidth,
    required this.screenHeight,
    required this.scaleFactor, // New: scaleFactor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatMessageScreen(
              chatUser: chatUser,
              // scaleFactor: scaleFactor, // Pass scaleFactor to ChatMessageScreen
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: screenHeight * 0.012 * scaleFactor,
        ), // Reduced from 0.015
        padding: EdgeInsets.all(
          screenWidth * 0.035 * scaleFactor,
        ), // Reduced from 0.04
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            screenWidth * 0.07 * scaleFactor,
          ), // Reduced from 0.08
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6 * scaleFactor, // Reduced from 8
              offset: Offset(0, 1.5 * scaleFactor), // Reduced from 2
            ),
          ],
          border: Border.all(
            color: AppColors.lightGray.withOpacity(0.3),
            width: 0.8 * scaleFactor, // Reduced from 1
          ),
        ),
        child: Row(
          children: [
            // Profile image with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius:
                      screenWidth * 0.055 * scaleFactor, // Reduced from 0.065
                  backgroundImage: NetworkImage(chatUser.avatarUrl),
                  backgroundColor: AppColors.lightGray,
                ),
                if (chatUser.isOnline)
                  Positioned(
                    bottom:
                        screenWidth * 0.003 * scaleFactor, // Reduced from 0.005
                    right:
                        screenWidth * 0.003 * scaleFactor, // Reduced from 0.005
                    child: Container(
                      width:
                          screenWidth *
                          0.03 *
                          scaleFactor, // Reduced from 0.035
                      height:
                          screenWidth *
                          0.03 *
                          scaleFactor, // Reduced from 0.035
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white,
                          width: 1.5 * scaleFactor, // Reduced from 2
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(
              width: screenWidth * 0.035 * scaleFactor,
            ), // Reduced from 0.04
            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatUser.name,
                    style: GoogleFonts.poppins(
                      fontSize:
                          screenWidth *
                          0.04 *
                          scaleFactor, // Reduced from 0.045
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height:
                        screenHeight *
                        0.002 *
                        scaleFactor, // Reduced from 0.003
                  ),
                  Text(
                    chatUser.lastMessage,
                    style: GoogleFonts.poppins(
                      fontSize:
                          screenWidth *
                          0.032 *
                          scaleFactor, // Reduced from 0.035
                      color: AppColors.textGray,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
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

class ChatMessageScreen extends StatefulWidget {
  final ChatUser chatUser;

  const ChatMessageScreen({Key? key, required this.chatUser}) : super(key: key);

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<Message> messages = [];

  // Define colors
  static const Color primaryYellow = Color(0xFFFFD700);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF6B7280);
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
  }

  void _initializeMessages() {
    messages.addAll([
      Message(
        id: '1',
        senderId: widget.chatUser.id,
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: false,
      ),
      Message(
        id: '2',
        senderId: 'me',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isMe: true,
      ),
      Message(
        id: '3',
        senderId: 'me',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        isMe: true,
      ),
      Message(
        id: '4',
        senderId: widget.chatUser.id,
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isMe: false,
      ),
      Message(
        id: '5',
        senderId: widget.chatUser.id,
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isMe: false,
      ),
      Message(
        id: '6',
        senderId: widget.chatUser.id,
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isMe: false,
      ),
    ]);
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: 'me',
          text: messageController.text.trim(),
          timestamp: DateTime.now(),
          isMe: true,
        ),
      );
      messageController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Updated responsive scale factor for iPhone 12 Pro
    const double baseScreenHeight = 844.0; // iPhone 12 Pro height
    double scaleFactor = screenHeight / baseScreenHeight;
    const double minScaleFactor = 0.75; // Reduced for smaller UI elements
    const double maxScaleFactor = 0.95; // Added max scale

    if (scaleFactor < minScaleFactor) {
      scaleFactor = minScaleFactor;
    } else if (scaleFactor > maxScaleFactor) {
      scaleFactor = maxScaleFactor;
    }

    final responsiveScale =
        scaleFactor * 0.85; // Further reduced for compact design

    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(screenWidth, responsiveScale),

            // User info section
            _buildUserInfo(screenWidth, screenHeight, responsiveScale),

            // Messages list
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal:
                      screenWidth *
                      0.035 *
                      responsiveScale, // Reduced from 0.04
                  vertical:
                      screenHeight *
                      0.008 *
                      responsiveScale, // Reduced from 0.01
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildMessageBubble(
                    message,
                    screenWidth,
                    screenHeight,
                    responsiveScale,
                  );
                },
              ),
            ),

            // Message input
            _buildMessageInput(screenWidth, screenHeight, responsiveScale),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double responsiveScale) {
    return Container(
      padding: EdgeInsets.all(
        screenWidth * 0.035 * responsiveScale,
      ), // Reduced from 0.04
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(
                screenWidth * 0.02 * responsiveScale,
              ), // Reduced from 0.025
              decoration: const BoxDecoration(
                color: primaryYellow,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: black,
                size:
                    screenWidth * 0.045 * responsiveScale, // Reduced from 0.05
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.035 * responsiveScale,
          ), // Reduced from 0.04
          // Title
          Text(
            'Message',
            style: GoogleFonts.poppins(
              fontSize:
                  screenWidth * 0.05 * responsiveScale, // Reduced from 0.055
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(
    double screenWidth,
    double screenHeight,
    double responsiveScale,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.035 * responsiveScale, // Reduced from 0.04
        vertical: screenHeight * 0.012 * responsiveScale, // Reduced from 0.015
      ),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.035 * responsiveScale, // Reduced from 0.04
        vertical: screenHeight * 0.008 * responsiveScale, // Reduced from 0.01
      ),
      decoration: BoxDecoration(
        color: lightGray.withOpacity(0.6),
        borderRadius: BorderRadius.circular(
          screenWidth * 0.05 * responsiveScale, // Reduced from 0.06
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.04 * responsiveScale, // Reduced from 0.045
            backgroundImage: NetworkImage(widget.chatUser.avatarUrl),
            backgroundColor: lightGray,
          ),
          SizedBox(
            width: screenWidth * 0.025 * responsiveScale,
          ), // Reduced from 0.03
          Text(
            widget.chatUser.name,
            style: GoogleFonts.poppins(
              fontSize:
                  screenWidth * 0.04 * responsiveScale, // Reduced from 0.045
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    Message message,
    double screenWidth,
    double screenHeight,
    double responsiveScale,
  ) {
    final isMe = message.isMe;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.006 * responsiveScale, // Reduced from 0.008
      ),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius:
                  screenWidth * 0.03 * responsiveScale, // Reduced from 0.035
              backgroundImage: NetworkImage(widget.chatUser.avatarUrl),
              backgroundColor: lightGray,
            ),
            SizedBox(
              width: screenWidth * 0.015 * responsiveScale,
            ), // Reduced from 0.02
          ],

          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth:
                    screenWidth * 0.68 * responsiveScale, // Reduced from 0.7
              ),
              padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.035 * responsiveScale, // Reduced from 0.04
                vertical:
                    screenHeight * 0.01 * responsiveScale, // Reduced from 0.012
              ),
              decoration: BoxDecoration(
                color: isMe ? primaryYellow : darkGray,
                borderRadius: BorderRadius.circular(
                  screenWidth * 0.045 * responsiveScale, // Reduced from 0.05
                ),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.poppins(
                  fontSize:
                      screenWidth *
                      0.032 *
                      responsiveScale, // Reduced from 0.035
                  color: isMe ? black : white,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),
            ),
          ),

          if (isMe) ...[
            SizedBox(
              width: screenWidth * 0.015 * responsiveScale,
            ), // Reduced from 0.02
            CircleAvatar(
              radius:
                  screenWidth * 0.03 * responsiveScale, // Reduced from 0.035
              backgroundImage: const NetworkImage(
                'https://picsum.photos/100/100?random=me',
              ),
              backgroundColor: lightGray,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(
    double screenWidth,
    double screenHeight,
    double responsiveScale,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.035 * responsiveScale, // Reduced from 0.04
        vertical: screenHeight * 0.012 * responsiveScale, // Reduced from 0.015
      ),
      decoration: BoxDecoration(
        color: lightBackground,
        border: Border(
          top: BorderSide(color: lightGray.withOpacity(0.5), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.035 * responsiveScale, // Reduced from 0.04
                vertical:
                    screenHeight * 0.01 * responsiveScale, // Reduced from 0.012
              ),
              decoration: BoxDecoration(
                color: darkGray,
                borderRadius: BorderRadius.circular(
                  screenWidth * 0.07 * responsiveScale, // Reduced from 0.08
                ),
              ),
              child: TextField(
                controller: messageController,
                style: GoogleFonts.poppins(
                  color: white,
                  fontSize:
                      screenWidth *
                      0.035 *
                      responsiveScale, // Reduced from 0.038
                ),
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: GoogleFonts.poppins(
                    color: white.withOpacity(0.7),
                    fontSize:
                        screenWidth *
                        0.035 *
                        responsiveScale, // Reduced from 0.038
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),

          SizedBox(
            width: screenWidth * 0.025 * responsiveScale,
          ), // Reduced from 0.03

          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(
                screenWidth * 0.025 * responsiveScale,
              ), // Reduced from 0.03
              decoration: const BoxDecoration(
                color: primaryYellow,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send,
                color: black,
                size:
                    screenWidth * 0.045 * responsiveScale, // Reduced from 0.05
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

// Data Models
class ChatUser {
  final String id;
  final String name;
  final String lastMessage;
  final bool isOnline;
  final String avatarUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.isOnline,
    required this.avatarUrl,
  });
}

class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}

// Example usage
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Chat',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: ChatMessageScreen(
        chatUser: ChatUser(
          id: '1',
          name: 'Emma',
          lastMessage: 'Hey there!',
          isOnline: true,
          avatarUrl: 'https://picsum.photos/100/100?random=1',
        ),
      ),
    );
  }
}
