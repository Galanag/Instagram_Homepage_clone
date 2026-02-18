import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Use a ValueNotifier to handle Theme Switching globally
final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          title: 'Flutter Insta Clone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            // Material 3 style buttons
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          themeMode: mode,
          home: const InstagramHome(),
        );
      },
    );
  }
}

class InstagramHome extends StatefulWidget {
  const InstagramHome({super.key});

  @override
  State<InstagramHome> createState() => _InstagramHomeState();
}

class _InstagramHomeState extends State<InstagramHome> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    const HomeFeed(),       // Index 0: The Feed
    const Center(child: Text("Search Page")), // Index 1: Placeholder
    const Center(child: Text("Add Post")),    // Index 2: Placeholder
    const Center(child: Text("Reels")),       // Index 3: Placeholder
    const ProfileView(),    // Index 4: The New Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 4 ? "ryujin_itzy" : "Instagram",
          style: TextStyle(
            fontFamily: _selectedIndex == 4 ? null : 'Cursive',
            fontWeight: FontWeight.bold,
            fontSize: _selectedIndex == 4 ? 20 : 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              _themeNotifier.value =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          // Show different icons based on the page
          if (_selectedIndex == 0) ...[
            IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
            IconButton(icon: const Icon(Icons.message_outlined), onPressed: () {}),
          ] else if (_selectedIndex == 4) ...[
            IconButton(icon: const Icon(Icons.add_box_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          ]
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 🏠 HOME FEED WIDGET (Your Previous Assignment)
// ---------------------------------------------------------
class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {"username": "You", "image": "https://i.pravatar.cc/150?u=You"},
      {"username": "Ryujin", "image": "https://i.pravatar.cc/150?u=Ryujin"},
      {"username": "New Jeans", "image": "https://i.pravatar.cc/150?u=NewJeans"},
      {"username": "Niki", "image": "https://i.pravatar.cc/150?u=Niki"},
      {"username": "Twice", "image": "https://i.pravatar.cc/150?u=Twice"},
      {"username": "Lisa", "image": "https://i.pravatar.cc/150?u=Lisa"},
      {"username": "Jennie", "image": "https://i.pravatar.cc/150?u=Jennie"},
    ];

    final List<Map<String, dynamic>> posts = [
      {
        "username": "itzy.all.in.us",
        "profile": "https://i.pravatar.cc/150?u=Ryujin",
        "post": "https://picsum.photos/id/1011/600/600",
        "caption": "bubble update 🌼🤍 #ITZY #MIDZY",
        "likes": "1.2M",
      },
      {
        "username": "NWJS_official",
        "profile": "https://i.pravatar.cc/150?u=NewJeans",
        "post": "https://picsum.photos/id/1015/600/700",
        "caption": "New release coming soon! 🐰👖",
        "likes": "850K",
      },
      {
        "username": "enhypen",
        "profile": "https://i.pravatar.cc/150?u=Niki",
        "post": "https://picsum.photos/id/1025/600/600",
        "caption": "Practice room selfies 📸",
        "likes": "2.1M",
      },
    ];

    return ListView.builder(
      itemCount: posts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SizedBox(
            height: 115,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.orange, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(story['image']!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(story['username']!, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          final post = posts[index - 1];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(post['profile']),
                  radius: 18,
                ),
                title: Row(
                  children: [
                    Text(post['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (post['username'] == 'itzy.all.in.us')
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(Icons.verified, color: Colors.blue, size: 14),
                      ),
                  ],
                ),
                trailing: const Icon(Icons.more_horiz),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    post['post'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(height: 300, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: const [
                    Icon(Icons.favorite_border, size: 28),
                    SizedBox(width: 16),
                    Icon(Icons.chat_bubble_outline, size: 28),
                    SizedBox(width: 16),
                    Icon(Icons.send, size: 28),
                    Spacer(),
                    Icon(Icons.bookmark_border, size: 28),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Liked by ${post['likes']} others", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(text: "${post['username']} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: post['caption']),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

// ---------------------------------------------------------
// 👤 PROFILE PAGE (New Assignment 2)
// ---------------------------------------------------------
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // 🌈 Stretch Goal: Gradient Background
    // Using a subtle gradient for the Container background
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [Colors.black, Colors.grey[900]!]
              : [Colors.white, Colors.grey[100]!],
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Profile Section & User Stats
                        Row(
                          children: [
                            // Profile Image
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.purple, Colors.orange],
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=Ryujin"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Stats (Expanded to fill space)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatColumn("120", "Posts"),
                                  _buildStatColumn("15.4K", "Followers"),
                                  _buildStatColumn("150", "Following"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        // 2. Bio Section
                        const SizedBox(height: 12),
                        const Text(
                          "Shin Ryujin (류진)",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Artist • ITZY Main Rapper\nJust keep on dreaming ✨\nSeoul, South Korea",
                          style: TextStyle(fontSize: 14),
                        ),

                        // 3. Contact Info (Assignment Requirement)
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Row(
                              children: [
                                Icon(Icons.email_outlined, size: 16, color: Colors.grey),
                                SizedBox(width: 6),
                                Text("itzy.mgmt@jyp.com", style: TextStyle(color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                             const SizedBox(height: 4),
                             Row(
                              children: [
                                Icon(Icons.link, size: 16, color: Colors.blue),
                                SizedBox(width: 6),
                                Text("itzy.jype.com", style: TextStyle(color: Colors.blue, fontSize: 13)),
                              ],
                            ),
                          ],
                        ),

                        // 4. Buttons (Edit Profile)
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text("Edit Profile"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text("Share Profile"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.grey[800] : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.person_add_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ];
          },
          // 5. User Posts Section (Grid)
          body: Column(
            children: [
               const TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.person_pin_outlined)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Grid Tab
                    GridView.builder(
                      padding: const EdgeInsets.only(top: 2),
                      itemCount: 21, // Generate dummy posts
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Image.network(
                          "https://picsum.photos/id/${100 + index}/300/300",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    // Tagged Tab (Placeholder)
                    const Center(child: Text("No photos yet")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}