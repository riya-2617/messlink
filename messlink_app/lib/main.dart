import 'package:flutter/material.dart';
import 'localization/app_strings.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MessLinkApp());
}

enum PersonaMode { student, working, senior }

class MessLinkApp extends StatefulWidget {
  const MessLinkApp({super.key});

  @override
  State<MessLinkApp> createState() => _MessLinkAppState();
}

class _MessLinkAppState extends State<MessLinkApp> {
  String _currentLang = 'en';
  PersonaMode _currentPersona = PersonaMode.student;

  void _updateLanguage(String lang) {
    setState(() {
      _currentLang = lang;
    });
  }

  void _updatePersona(PersonaMode mode) {
    setState(() {
      _currentPersona = mode;
    });
  }

  ThemeData _buildTheme() {
    switch (_currentPersona) {
      case PersonaMode.student:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          primaryColor: const Color(0xFFE65100),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFE65100),
            secondary: Color(0xFF2E7D32),
            surface: Color(0xFF1E293B),
            onSurface: Color(0xFFF1F5F9),
          ),
          cardTheme: const CardThemeData(
            color: Color(0xFF1E293B),
            elevation: 4,
          ),
        );
      case PersonaMode.working:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF8FAFC),
          primaryColor: const Color(0xFFE65100),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFE65100),
            secondary: Color(0xFF2E7D32),
            surface: Colors.white,
            onSurface: Color(0xFF0F172A),
          ),
          cardTheme: const CardThemeData(
            color: Colors.white,
            elevation: 2,
          ),
        );
      case PersonaMode.senior:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFFF9800),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFF9800),
            secondary: Color(0xFF00E676),
            surface: Color(0xFF1A1A1A),
            onSurface: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 20, color: Colors.white),
            titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF121212),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessLink',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: HomeScreen(
        currentLang: _currentLang,
        currentPersona: _currentPersona,
        onLanguageChanged: _updateLanguage,
        onPersonaChanged: _updatePersona,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String currentLang;
  final PersonaMode currentPersona;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<PersonaMode> onPersonaChanged;

  const HomeScreen({
    super.key,
    required this.currentLang,
    required this.currentPersona,
    required this.onLanguageChanged,
    required this.onPersonaChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeViewIndex = 0; // 0: Landing, 1: Diner Hub, 2: Owner Portal
  bool _isSkipping = false;
  bool _isOcrScanning = false;
  bool _isOcrScanned = false;
  String? _statusMessage;

  // Editable OCR scanned items
  final List<Map<String, dynamic>> _ocrDishes = [
    {
      'category': 'Sabzi',
      'en': 'Chole Masala',
      'mr': 'मसाला छोले',
      'hi': 'छोले मसाला',
      'confidence': 0.98,
      'isUncertain': false,
    },
    {
      'category': 'Sabzi',
      'en': 'Aloo Gobhi',
      'mr': 'बटाटा फ्लॉवर भाजी',
      'hi': 'आलू गोभी',
      'confidence': 0.95,
      'isUncertain': false,
    },
    {
      'category': 'Bread',
      'en': 'Puri (5 pcs)',
      'mr': 'गरम पुरी (५ नग)',
      'hi': 'गरम पूरी (५)',
      'confidence': 0.92,
      'isUncertain': false,
    },
    {
      'category': 'Rice',
      'en': 'Peas Pulao',
      'mr': 'मटार पुलाव',
      'hi': 'मटर पुलाव',
      'confidence': 0.91,
      'isUncertain': false,
    },
    {
      'category': 'Sweet',
      'en': 'Sheera (Halwa)',
      'mr': 'रव्याचा शिरा',
      'hi': 'सूजी हलवा',
      'confidence': 0.74,
      'isUncertain': true,
    },
  ];

  String tr(String key) => AppStrings.get(key, widget.currentLang);

  @override
  Widget build(BuildContext context) {
    final isSenior = widget.currentPersona == PersonaMode.senior;

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => setState(() => _activeViewIndex = 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE65100),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('M',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  tr('app_title'),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        actions: [
          // Persona Switcher
          DropdownButton<PersonaMode>(
            value: widget.currentPersona,
            underline: const SizedBox(),
            isDense: true,
            items: const [
              DropdownMenuItem(
                value: PersonaMode.student,
                child: Text('🎓 Student'),
              ),
              DropdownMenuItem(
                value: PersonaMode.working,
                child: Text('💼 Working'),
              ),
              DropdownMenuItem(
                value: PersonaMode.senior,
                child: Text('👓 Senior'),
              ),
            ],
            onChanged: (mode) {
              if (mode != null) widget.onPersonaChanged(mode);
            },
          ),
          const SizedBox(width: 6),
          // Language Switcher
          DropdownButton<String>(
            value: widget.currentLang,
            underline: const SizedBox(),
            isDense: true,
            items: const [
              DropdownMenuItem(value: 'en', child: Text('EN')),
              DropdownMenuItem(value: 'mr', child: Text('मराठी')),
              DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
            ],
            onChanged: (lang) {
              if (lang != null) widget.onLanguageChanged(lang);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isSenior ? 20.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Main Active View
              _buildCurrentView(isSenior),

              const SizedBox(height: 36),
              const Divider(),
              const SizedBox(height: 12),

              // Full Footer & Compliance
              _buildFooter(isSenior),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentView(bool isSenior) {
    switch (_activeViewIndex) {
      case 1:
        return _buildDinerView(isSenior);
      case 2:
        return _buildOwnerView(isSenior);
      default:
        return _buildLandingView(isSenior);
    }
  }

  // ==========================================
  // VIEW 0: HERO & DUAL PATH GATE
  // ==========================================
  Widget _buildLandingView(bool isSenior) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Landing Badge
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tr('landing_badge'),
              style: const TextStyle(
                color: Color(0xFFBF360C),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Central Master Question
        Text(
          tr('landing_heading'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isSenior ? 28 : 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          tr('landing_subheading'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isSenior ? 20 : 15,
            color: isSenior ? Colors.white70 : Colors.grey,
          ),
        ),
        const SizedBox(height: 24),

        // Dual Gate Cards (Path A & Path B)
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🍛', style: TextStyle(fontSize: 36)),
                const SizedBox(height: 8),
                Text(
                  tr('eat_title'),
                  style: TextStyle(
                    fontSize: isSenior ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tr('eat_desc'),
                  style: TextStyle(
                    fontSize: isSenior ? 18 : 14,
                    color: isSenior ? Colors.white70 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: isSenior ? 56 : 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE65100),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() => _activeViewIndex = 1);
                    },
                    child: Text(
                      tr('eat_cta'),
                      style: TextStyle(
                          fontSize: isSenior ? 20 : 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('👨‍🍳', style: TextStyle(fontSize: 36)),
                const SizedBox(height: 8),
                Text(
                  tr('manage_title'),
                  style: TextStyle(
                    fontSize: isSenior ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tr('manage_desc'),
                  style: TextStyle(
                    fontSize: isSenior ? 18 : 14,
                    color: isSenior ? Colors.white70 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: isSenior ? 56 : 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() => _activeViewIndex = 2);
                    },
                    child: Text(
                      tr('manage_cta'),
                      style: TextStyle(
                          fontSize: isSenior ? 20 : 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Featured Active Mess Discovery Banner (Exact Parity with Website)
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFE65100), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('featured_mess_title'),
                  style: TextStyle(
                    fontSize: isSenior ? 20 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tr('featured_mess_subtitle'),
                  style: TextStyle(
                    fontSize: isSenior ? 16 : 13,
                    color: isSenior ? Colors.white70 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton(
                  onPressed: () => setState(() => _activeViewIndex = 1),
                  child: Text(tr('view_menu_cta')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // VIEW 1: DINER / CUSTOMER HUB
  // ==========================================
  Widget _buildDinerView(bool isSenior) {
    final sub = ApiService.fallbackSubscriber;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Namaste, ${sub.userName} 🙏',
                  style: TextStyle(
                    fontSize: isSenior ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Annapurna Bhojanalaya • Pune',
                  style: TextStyle(
                    fontSize: isSenior ? 18 : 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () => setState(() => _activeViewIndex = 0),
              child: Text(tr('back_home')),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 3 Key Metrics Cards (Remaining, Wallet Credits, Monthly Skips Used)
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('remaining_meals'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: isSenior ? 14 : 11,
                              color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '${sub.mealsRemaining} / ${sub.totalMeals}',
                        style: TextStyle(
                          fontSize: isSenior ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('wallet_credits'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: isSenior ? 14 : 11,
                              color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '₹${sub.creditBalancePaise ~/ 100}',
                        style: TextStyle(
                          fontSize: isSenior ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('skips_used'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: isSenior ? 14 : 11,
                              color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '${sub.skipsUsed} / ${sub.maxSkips}',
                        style: TextStyle(
                          fontSize: isSenior ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Skip Success Notification Banner
        if (_statusMessage != null)
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2E7D32)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _statusMessage!,
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Cutoff Warning Alert & 1-Click Action
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
            border: const Border(
              left: BorderSide(color: Color(0xFFE65100), width: 4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⏰ ${tr('cutoff_dinner_alert')}',
                style: const TextStyle(
                  color: Color(0xFFBF360C),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: isSenior ? 56 : 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65100),
                    foregroundColor: Colors.white,
                  ),
                  icon: _isSkipping
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Icon(Icons.cancel_schedule_send),
                  label: Text(
                    tr('skip_action'),
                    style: TextStyle(
                        fontSize: isSenior ? 20 : 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _isSkipping ? null : _handleSkipMeal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Today's Verified Menu Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('today_menu'),
                      style: TextStyle(
                        fontSize: isSenior ? 22 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      label: Text(tr('fresh_veg_badge'),
                          style: const TextStyle(fontSize: 11, color: Colors.green)),
                      backgroundColor: const Color(0xFFE8F5E9),
                    ),
                  ],
                ),
                const Divider(),
                ...ApiService.fallbackDinnerMenu.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.getLocalizedName(widget.currentLang),
                              style: TextStyle(
                                fontSize: isSenior ? 20 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item.category,
                              style: TextStyle(
                                fontSize: isSenior ? 16 : 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.check_circle_outline,
                            color: Colors.green, size: 20),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // VIEW 2: MESS OWNER OPERATIONS PORTAL
  // ==========================================
  Widget _buildOwnerView(bool isSenior) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('owner_dashboard'),
                  style: TextStyle(
                    fontSize: isSenior ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Annapurna Bhojanalaya | FSSAI: 11522036000123',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () => setState(() => _activeViewIndex = 0),
              child: Text(tr('back_home')),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 3 Operational Headcount Metrics Cards
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('lunch_headcount'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: isSenior ? 13 : 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      const Text(
                        '84 Meals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(tr('lunch_cutoff_passed'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('dinner_headcount'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: isSenior ? 13 : 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      const Text(
                        '87 Meals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(tr('dinner_cutoff_active'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('kitchen_savings'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: isSenior ? 13 : 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      const Text(
                        '~₹1,240',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(tr('kitchen_savings_desc'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // AI Menu Photo Scanner (OCR)
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE65100), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Text(
                  tr('scan_menu_title'),
                  style: TextStyle(
                    fontSize: isSenior ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tr('scan_menu_desc'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSenior ? 18 : 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: isSenior ? 56 : 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE65100),
                      foregroundColor: Colors.white,
                    ),
                    icon: _isOcrScanning
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Icon(Icons.camera_alt),
                    label: Text(
                      _isOcrScanning
                          ? 'Extracting Devanagari OCR...'
                          : tr('scan_button'),
                      style: TextStyle(
                          fontSize: isSenior ? 18 : 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: _isOcrScanning ? null : _simulateOcrScan,
                  ),
                ),

                // OCR Extracted Items Review Drawer
                if (_isOcrScanned) ...[
                  const SizedBox(height: 18),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Extracted Menu Items for Dinner (Please Review):',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: isSenior ? 18 : 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._ocrDishes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final dish = entry.value;
                    String name = dish[widget.currentLang] ?? dish['en'];
                    bool isUncertain = dish['isUncertain'] ?? false;
                    double confidence = dish['confidence'] ?? 1.0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSenior ? 18 : 14)),
                              const SizedBox(width: 8),
                              if (isUncertain)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(tr('review_spelling'),
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.orange)),
                                )
                              else
                                Text(tr('confident_badge'),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.green)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${(confidence * 100).toInt()}%',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => _editDishDialog(index),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(tr('edit_dish')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isOcrScanned = false;
                          _statusMessage =
                              '✅ Menu verified & published to all subscribers!';
                        });
                      },
                      child: Text(
                        tr('confirm_publish'),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Financial Ledger Card (Double-Entry)
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('ledger_title'),
                  style: TextStyle(
                    fontSize: isSenior ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                ...ApiService.fallbackLedger.map((record) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(record.type.replaceAll('_', ' '),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13)),
                            Text(record.note,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                            Text(record.timestamp,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                        Text(
                          '+₹${record.credit ~/ 100}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // FOOTER & LEGAL MODAL
  // ==========================================
  Widget _buildFooter(bool isSenior) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          children: [
            TextButton(
              onPressed: () => _showComplianceDialog(),
              child: Text(tr('privacy_policy')),
            ),
            TextButton(
              onPressed: () => _showComplianceDialog(),
              child: Text(tr('fssai_compliance')),
            ),
            TextButton(
              onPressed: () => _showComplianceDialog(),
              child: Text(tr('terms_refund')),
            ),
            TextButton(
              onPressed: () => _showComplianceDialog(),
              child: Text(tr('grievance_officer')),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          tr('footer_text'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isSenior ? 16 : 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void _handleSkipMeal() async {
    setState(() => _isSkipping = true);
    final result = await ApiService.skipMeal('sub_101');
    setState(() {
      _isSkipping = false;
      _statusMessage = result['message'];
    });
  }

  void _simulateOcrScan() {
    setState(() => _isOcrScanning = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isOcrScanning = false;
          _isOcrScanned = true;
        });
      }
    });
  }

  void _editDishDialog(int index) {
    final dish = _ocrDishes[index];
    final currentVal = dish[widget.currentLang] ?? dish['en'];
    final controller = TextEditingController(text: currentVal);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${tr('edit_dish')}: $currentVal'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Dish Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                dish[widget.currentLang] = controller.text;
                dish['isUncertain'] = false;
                dish['confidence'] = 1.0;
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showComplianceDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr('policy_dpdpa_title')),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• FSSAI: License 11522036000123 verified.'),
            SizedBox(height: 8),
            Text('• DPDPA 2023: Strict data privacy with zero raw card/UPI PIN storage.'),
            SizedBox(height: 8),
            Text('• Parental Consent: Required for minors (< 18 yrs).'),
            SizedBox(height: 8),
            Text('• Double-Entry Ledger: Prevents duplicate meal credits.'),
            SizedBox(height: 8),
            Text('• Grievance Officer: Registered Indian Resident Officer.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
