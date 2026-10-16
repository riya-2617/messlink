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

  String tr(String key) => AppStrings.get(key, widget.currentLang);

  @override
  Widget build(BuildContext context) {
    final isSenior = widget.currentPersona == PersonaMode.senior;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE65100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('M',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Text(tr('app_title'),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          // Persona Switcher
          DropdownButton<PersonaMode>(
            value: widget.currentPersona,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                value: PersonaMode.student,
                child: Text(tr('student_mode')),
              ),
              DropdownMenuItem(
                value: PersonaMode.working,
                child: Text(tr('working_mode')),
              ),
              DropdownMenuItem(
                value: PersonaMode.senior,
                child: Text(tr('senior_mode')),
              ),
            ],
            onChanged: (mode) {
              if (mode != null) widget.onPersonaChanged(mode);
            },
          ),
          const SizedBox(width: 8),
          // Language Switcher
          DropdownButton<String>(
            value: widget.currentLang,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: 'en', child: Text('EN')),
              DropdownMenuItem(value: 'mr', child: Text('मराठी')),
              DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
            ],
            onChanged: (lang) {
              if (lang != null) widget.onLanguageChanged(lang);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isSenior ? 20.0 : 16.0),
          child: _buildCurrentView(isSenior),
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

  // --- View 0: Landing Hero & Dual Path Gate ---
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

        // Card 1: Eat at a Mess
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

        // Card 2: Manage a Mess
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
        // FSSAI & Legal Notice
        Center(
          child: TextButton.icon(
            icon: const Icon(Icons.verified, color: Color(0xFF2E7D32)),
            label: Text(
              'FSSAI Lic. 11522036000123 • DPDPA 2023 Compliant',
              style: TextStyle(fontSize: isSenior ? 18 : 13),
            ),
            onPressed: () => _showComplianceDialog(),
          ),
        ),
      ],
    );
  }

  // --- View 1: Customer / Diner Hub ---
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
            TextButton(
              onPressed: () => setState(() => _activeViewIndex = 0),
              child: Text(tr('back_home')),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Key Metrics Row
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('remaining_meals'),
                          style: TextStyle(
                              fontSize: isSenior ? 16 : 12,
                              color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '${sub.mealsRemaining} / ${sub.totalMeals}',
                        style: TextStyle(
                          fontSize: isSenior ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(tr('wallet_credits'),
                          style: TextStyle(
                              fontSize: isSenior ? 16 : 12,
                              color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '₹${sub.creditBalancePaise ~/ 100}',
                        style: TextStyle(
                          fontSize: isSenior ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E7D32),
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

        // Status Notification
        if (_statusMessage != null)
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF2E7D32)),
            ),
            child: Text(
              _statusMessage!,
              style: const TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        // Cutoff Alert & 1-Click Skip Button
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
                '⏰ ${tr('cutoff_alert')}',
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
                    tr('skip_dinner'),
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

        // Today's Menu
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                    const Chip(
                      label: Text('✓ Pure Veg',
                          style: TextStyle(fontSize: 12, color: Colors.green)),
                      backgroundColor: Color(0xFFE8F5E9),
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

  // --- View 2: Mess Owner Portal ---
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
            TextButton(
              onPressed: () => setState(() => _activeViewIndex = 0),
              child: Text(tr('back_home')),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Headcount Forecast Grid
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      const Text('Lunch Headcount',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 4),
                      const Text(
                        '84 Meals',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('11 Skips registered',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      const Text('Dinner Headcount',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 4),
                      const Text(
                        '87 Meals',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('Cutoff closes 5:00 PM',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
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

                // OCR Extracted Items Review
                if (_isOcrScanned) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Extracted Dishes (Review before publishing):',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildOcrDishRow('Chole Masala', 'मसाला छोले', 'छोले मसाला', 0.98),
                  _buildOcrDishRow('Aloo Gobhi', 'बटाटा फ्लॉवर भाजी', 'आलू गोभी', 0.95),
                  _buildOcrDishRow('Puri (5 pcs)', 'गरम पुरी (५ नग)', 'पूरी (५)', 0.92),
                  _buildOcrDishRow('Sheera (Halwa)', 'रव्याचा शिरा', 'सूजी हलवा', 0.74, isUncertain: true),
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
                          _statusMessage = '✅ Menu verified & published to all subscribers!';
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

        // Financial Ledger Card
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
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(record.note,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            Text(record.timestamp,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                        Text(
                          '+₹${record.credit ~/ 100}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                            fontSize: 16,
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

  Widget _buildOcrDishRow(
      String en, String mr, String hi, double confidence,
      {bool isUncertain = false}) {
    String dishName = en;
    if (widget.currentLang == 'mr') dishName = mr;
    if (widget.currentLang == 'hi') dishName = hi;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(dishName,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              if (isUncertain)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('⚠️ Check spelling',
                      style: TextStyle(fontSize: 11, color: Colors.orange)),
                ),
            ],
          ),
          Text('${(confidence * 100).toInt()}%',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
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
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) {
        setState(() {
          _isOcrScanning = false;
          _isOcrScanned = true;
        });
      }
    });
  }

  void _showComplianceDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('DPDPA 2023 & FSSAI Compliance'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• FSSAI: License 11522036000123 verified.'),
            SizedBox(height: 6),
            Text('• DPDPA 2023: Strict data privacy with zero raw card/UPI PIN storage.'),
            SizedBox(height: 6),
            Text('• Parental Consent: Required for minors (< 18 yrs).'),
            SizedBox(height: 6),
            Text('• Double-Entry Ledger: Prevents duplicate meal credits.'),
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
