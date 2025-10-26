import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/firebase_options.dart';
import 'package:lodz_trash_bin/services/offer_service.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/pages/profile_page.dart';
import 'package:lodz_trash_bin/views/pages/qr_scanner_page.dart';
import 'package:lodz_trash_bin/views/pages/ranking_page.dart';
import 'package:lodz_trash_bin/views/pages/root_page.dart';
import 'package:lodz_trash_bin/views/pages/shop_page.dart';
import 'package:lodz_trash_bin/views/widgets/navigation_bar/navigation_bar_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final userService = UserService();
  final offerService = OfferService();

  await userService.init();
  await offerService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>.value(value: userService),
        ChangeNotifierProvider<OfferService>.value(value: offerService),
      ],
      child: const LodzTrashBinApp(),
    ),
  );
}

class LodzTrashBinApp extends StatelessWidget {
  const LodzTrashBinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lodz trash bin',
      theme: ThemeData(
        colorScheme: ColorScheme.highContrastLight(
          primary: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      home: RootPage(),
    );
  }
}

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _selectedIndex = 1;

  final List<Widget> _pages = const [
    ShopPage(),
    QRScannerPage(),
    RankingPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 0.5),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomNavigationBarButton(
                onTap: () => setState(() => _selectedIndex = 0),
                isSelected: _selectedIndex == 0,
                icon: LucideIcons.store,
                label: 'Sklepik',
                colorScheme: colorScheme,
              ),
              CustomNavigationBarButton(
                onTap: () => setState(() => _selectedIndex = 1),
                isSelected: _selectedIndex == 1,
                icon: LucideIcons.qr_code,
                label: 'Skaner',
                colorScheme: colorScheme,
              ),
              CustomNavigationBarButton(
                onTap: () => setState(() => _selectedIndex = 2),
                isSelected: _selectedIndex == 2,
                icon: LucideIcons.trophy,
                label: 'Ranking',
                colorScheme: colorScheme,
              ),
              CustomNavigationBarButton(
                onTap: () => setState(() => _selectedIndex = 3),
                isSelected: _selectedIndex == 3,
                icon: LucideIcons.user,
                label: 'Profil',
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
