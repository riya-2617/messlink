import 'package:flutter/material.dart';
import 'localization/app_strings.dart';
import 'models/models.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MessLinkApp());
}

class MessLinkApp extends StatefulWidget {
  const MessLinkApp({super.key});

  @override
  State<MessLinkApp> createState() => _MessLinkAppState();
}

class _MessLinkAppState extends State<MessLinkApp> {
  String _currentLang = 'en';

  // Active Authenticated Role
  UserRole _currentRole = UserRole.diner;

  // Active Logged-In Subscriber ID (for Diner Portal)
  String _activeSubscriberId = "sub_101";

  // For Diner Role: Dynamic Persona (Adapts UI according to logged-in diner)
  DinerPersona _dinerPersona = DinerPersona.student;

  void _updateLanguage(String lang) {
    setState(() {
      _currentLang = lang;
    });
  }

  void _updateRole(UserRole role) {
    setState(() {
      _currentRole = role;
    });
  }

  void _updateDinerPersona(DinerPersona persona) {
    setState(() {
      _dinerPersona = persona;
    });
  }

  void _updateActiveSubscriber(String subId) {
    final sub = ApiService.getSubscriber(subId);
    setState(() {
      _activeSubscriberId = subId;
      _dinerPersona = sub.dinerPersona;
    });
  }

  ThemeData _buildTheme() {
    if (_currentRole == UserRole.admin) {
      // Executive Admin Theme
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0F1D),
        primaryColor: const Color(0xFF3B82F6),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF10B981),
          surface: Color(0xFF161F33),
          onSurface: Color(0xFFF8FAFC),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF161F33),
          elevation: 4,
        ),
      );
    }

    if (_currentRole == UserRole.messOwner) {
      // Kitchen Operations Theme
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1510),
        primaryColor: const Color(0xFFE65100),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE65100),
          secondary: Color(0xFF2E7D32),
          surface: Color(0xFF2A1F17),
          onSurface: Color(0xFFFFF3E0),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF2A1F17),
          elevation: 4,
        ),
      );
    }

    // Role 3: Diner / Customer (Dynamic UI based on Persona)
    switch (_dinerPersona) {
      case DinerPersona.student:
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
      case DinerPersona.working:
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
      case DinerPersona.senior:
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
        currentRole: _currentRole,
        activeSubscriberId: _activeSubscriberId,
        dinerPersona: _dinerPersona,
        onLanguageChanged: _updateLanguage,
        onRoleChanged: _updateRole,
        onPersonaChanged: _updateDinerPersona,
        onSubscriberChanged: _updateActiveSubscriber,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String currentLang;
  final UserRole currentRole;
  final String activeSubscriberId;
  final DinerPersona dinerPersona;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<UserRole> onRoleChanged;
  final ValueChanged<DinerPersona> onPersonaChanged;
  final ValueChanged<String> onSubscriberChanged;

  const HomeScreen({
    super.key,
    required this.currentLang,
    required this.currentRole,
    required this.activeSubscriberId,
    required this.dinerPersona,
    required this.onLanguageChanged,
    required this.onRoleChanged,
    required this.onPersonaChanged,
    required this.onSubscriberChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeViewIndex = 0; // 0: Landing, 1: Diner Hub, 2: Owner Portal, 3: Admin Console
  bool _isSkipping = false;
  bool _isOcrScanning = false;
  bool _isOcrScanned = false;
  String? _statusMessage;

  // Platform Messes Managed by Admin
  final List<Mess> _platformMesses = [
    Mess(
      id: "mess_pune_01",
      name: "Annapurna Bhojanalaya (अन्नपूर्णा भोजनालय)",
      fssai: "11522036000123",
      fssaiVerified: true,
      city: "Pune",
      locality: "Karve Nagar",
      dietary: "PURE_VEG",
      rating: 4.8,
      pricePerMonth: 3200,
      skipCreditPerMeal: 50,
      phone: "+91 98220 12345",
    ),
    Mess(
      id: "mess_kota_02",
      name: "Radhe Krishna Mess (राधे कृष्णा मेस)",
      fssai: "12221015000456",
      fssaiVerified: false,
      city: "Kota",
      locality: "Rajiv Gandhi Nagar",
      dietary: "PURE_VEG",
      rating: 4.7,
      pricePerMonth: 3500,
      skipCreditPerMeal: 55,
      phone: "+91 94140 98765",
    ),
  ];

  // Editable OCR scanned items for Mess Owner
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
    final isSenior = widget.currentRole == UserRole.diner &&
        widget.dinerPersona == DinerPersona.senior;

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
                  color: widget.currentRole == UserRole.admin
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFFE65100),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('M',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
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
          // 1. Role Selector
          DropdownButton<UserRole>(
            value: widget.currentRole,
            underline: const SizedBox(),
            isDense: true,
            items: const [
              DropdownMenuItem(
                value: UserRole.diner,
                child: Text('🍛 Diner'),
              ),
              DropdownMenuItem(
                value: UserRole.messOwner,
                child: Text('👨‍🍳 Owner'),
              ),
              DropdownMenuItem(
                value: UserRole.admin,
                child: Text('🛡️ Admin'),
              ),
            ],
            onChanged: (role) {
              if (role != null) {
                widget.onRoleChanged(role);
                setState(() {
                  if (role == UserRole.admin) _activeViewIndex = 3;
                  if (role == UserRole.messOwner) _activeViewIndex = 2;
                  if (role == UserRole.diner) _activeViewIndex = 1;
                });
              }
            },
          ),
          const SizedBox(width: 6),

          // 2. If Diner Role: Persona Selector
          if (widget.currentRole == UserRole.diner) ...[
            DropdownButton<DinerPersona>(
              value: widget.dinerPersona,
              underline: const SizedBox(),
              isDense: true,
              items: const [
                DropdownMenuItem(
                  value: DinerPersona.student,
                  child: Text('🎓 Student'),
                ),
                DropdownMenuItem(
                  value: DinerPersona.working,
                  child: Text('💼 Working'),
                ),
                DropdownMenuItem(
                  value: DinerPersona.senior,
                  child: Text('👓 Senior'),
                ),
              ],
              onChanged: (persona) {
                if (persona != null) widget.onPersonaChanged(persona);
              },
            ),
            const SizedBox(width: 6),
          ],

          // 3. Language Selector
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
              // Active Role Status Banner
              _buildRoleBanner(),

              const SizedBox(height: 12),

              // Main Active View
              _buildCurrentView(isSenior),

              const SizedBox(height: 36),
              const Divider(),
              const SizedBox(height: 12),

              // Footer & Compliance
              _buildFooter(isSenior),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleBanner() {
    String roleLabel = tr('role_diner');
    Color bannerColor = const Color(0xFFE65100);
    IconData icon = Icons.person;

    if (widget.currentRole == UserRole.admin) {
      roleLabel = '${tr('role_admin')} (Full Platform Access)';
      bannerColor = const Color(0xFF3B82F6);
      icon = Icons.admin_panel_settings;
    } else if (widget.currentRole == UserRole.messOwner) {
      roleLabel = '${tr('role_owner')} (Annapurna Bhojanalaya)';
      bannerColor = const Color(0xFFE65100);
      icon = Icons.restaurant;
    } else {
      final currentSub = ApiService.getSubscriber(widget.activeSubscriberId);
      String personaTag = 'Student Profile';
      if (widget.dinerPersona == DinerPersona.working) {
        personaTag = 'Working Adult Profile';
      } else if (widget.dinerPersona == DinerPersona.senior) {
        personaTag = 'Senior Citizen Profile';
      }
      roleLabel = '${currentSub.userName} (${currentSub.phone}) • $personaTag';
      bannerColor = const Color(0xFF2E7D32);
      icon = Icons.account_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bannerColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: bannerColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: bannerColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              roleLabel,
              style: TextStyle(
                color: bannerColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          if (widget.currentRole == UserRole.diner)
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => _showDinerLoginDialog(),
              child: const Text('Switch Account',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentView(bool isSenior) {
    switch (_activeViewIndex) {
      case 1:
        return _buildDinerView(isSenior);
      case 2:
        return _buildOwnerView(isSenior);
      case 3:
        return _buildAdminView(isSenior);
      default:
        return _buildLandingView(isSenior);
    }
  }

  // ==========================================
  // VIEW 0: HERO & DECISION GATE
  // ==========================================
  Widget _buildLandingView(bool isSenior) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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

        // Path A: Eat (Diner Hub)
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
                      widget.onRoleChanged(UserRole.diner);
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
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  '🔑 Direct Diner Sign In by Persona:',
                  style: TextStyle(
                    fontSize: isSenior ? 18 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // 1. Student Persona Login
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE65100).withValues(alpha: 0.4)),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE65100),
                      child: Text('🎓', style: TextStyle(fontSize: 16)),
                    ),
                    title: Text(
                      tr('login_as_student'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSenior ? 18 : 14,
                      ),
                    ),
                    subtitle: Text(
                      'Rohan Patil • COEP Pune • Dark Mode UI',
                      style: TextStyle(fontSize: isSenior ? 14 : 11, color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.arrow_forward, size: 16),
                    onTap: () {
                      widget.onRoleChanged(UserRole.diner);
                      widget.onSubscriberChanged('sub_101');
                      setState(() => _activeViewIndex = 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFFE65100),
                          content: Text('Logged in as Rohan Patil (Student Mode & Dark Theme Active)'),
                        ),
                      );
                    },
                  ),
                ),
                // 2. Working Adult Persona Login
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF2E7D32).withValues(alpha: 0.4)),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF2E7D32),
                      child: Text('💼', style: TextStyle(fontSize: 16)),
                    ),
                    title: Text(
                      tr('login_as_working'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSenior ? 18 : 14,
                      ),
                    ),
                    subtitle: Text(
                      'Priya Sharma • Infosys Hinjawadi • Light Corporate UI',
                      style: TextStyle(fontSize: isSenior ? 14 : 11, color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.arrow_forward, size: 16),
                    onTap: () {
                      widget.onRoleChanged(UserRole.diner);
                      widget.onSubscriberChanged('sub_102');
                      setState(() => _activeViewIndex = 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF2E7D32),
                          content: Text('Logged in as Priya Sharma (Working Adult Mode & Light Theme Active)'),
                        ),
                      );
                    },
                  ),
                ),
                // 3. Senior Citizen Persona Login
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFF9800).withValues(alpha: 0.5)),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFF9800),
                      child: Text('👓', style: TextStyle(fontSize: 16)),
                    ),
                    title: Text(
                      tr('login_as_senior'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSenior ? 18 : 14,
                      ),
                    ),
                    subtitle: Text(
                      'Nana Saheb Joshi • High-Contrast WCAG AAA • Soft Diet',
                      style: TextStyle(fontSize: isSenior ? 14 : 11, color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.arrow_forward, size: 16),
                    onTap: () {
                      widget.onRoleChanged(UserRole.diner);
                      widget.onSubscriberChanged('sub_103');
                      setState(() => _activeViewIndex = 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFFFF9800),
                          content: Text('Logged in as Nana Saheb Joshi (Senior Citizen Mode & High Contrast Active)'),
                        ),
                      );
                    },
                  ),
                ),
                // Open Full Login Modal button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.login, size: 16),
                    label: const Text('Other Diner Sign In (OTP / Roll No) →'),
                    onPressed: () => _showDinerLoginDialog(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Path B: Manage a Mess (Owner Portal)
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
                      widget.onRoleChanged(UserRole.messOwner);
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
        const SizedBox(height: 16),

        // Path C: Platform Admin Console
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🛡️', style: TextStyle(fontSize: 36)),
                const SizedBox(height: 8),
                Text(
                  tr('admin_title'),
                  style: TextStyle(
                    fontSize: isSenior ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tr('admin_desc'),
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
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      widget.onRoleChanged(UserRole.admin);
                      setState(() => _activeViewIndex = 3);
                    },
                    child: Text(
                      tr('admin_cta'),
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
      ],
    );
  }

  // =========================================================================
  // ROLE 1: PLATFORM ADMIN CONSOLE
  // =========================================================================
  Widget _buildAdminView(bool isSenior) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('admin_dashboard'),
                    style: TextStyle(
                      fontSize: isSenior ? 24 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    tr('admin_subtitle'),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () => setState(() => _activeViewIndex = 0),
              child: Text(tr('back_home')),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const Text('Total Messes',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '${_platformMesses.length}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                      const Text('Active in Pune & Kota',
                          style: TextStyle(fontSize: 9, color: Colors.grey)),
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
                      const Text('FSSAI Verified',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '${_platformMesses.where((m) => m.fssaiVerified).length} / ${_platformMesses.length}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF10B981),
                        ),
                      ),
                      const Text('Strict 14-Digit Check',
                          style: TextStyle(fontSize: 9, color: Colors.grey)),
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
                      const Text('Complaints',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      const Text(
                        '0 Pending',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const Text('SLA Redressal < 48h',
                          style: TextStyle(fontSize: 9, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.add_business),
            label: Text(tr('register_mess_btn'),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () => _showAddMessDialog(),
          ),
        ),
        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('registered_messes'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                ..._platformMesses.map((mess) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mess.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15)),
                              Text('${mess.locality}, ${mess.city} • ${mess.dietary}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text('FSSAI: ${mess.fssai}',
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.grey)),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: mess.fssaiVerified
                                          ? const Color(0xFFE8F5E9)
                                          : const Color(0xFFFFF3E0),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      mess.fssaiVerified
                                          ? tr('fssai_verified_status')
                                          : tr('fssai_pending_status'),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: mess.fssaiVerified
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            minimumSize: Size.zero,
                          ),
                          onPressed: () {
                            setState(() {
                              mess.fssaiVerified = !mess.fssaiVerified;
                            });
                          },
                          child: Text(mess.fssaiVerified ? 'Revoke' : 'Verify'),
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

  // =========================================================================
  // ROLE 2: MESS OWNER PORTAL (Kitchen Forecast, AI OCR, SUBSCRIBERS & ORDERS)
  // =========================================================================
  Widget _buildOwnerView(bool isSenior) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('owner_dashboard'),
                    style: TextStyle(
                      fontSize: isSenior ? 24 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    'Annapurna Bhojanalaya | FSSAI: 11522036000123 (Verified)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
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
                          style: TextStyle(
                              fontSize: isSenior ? 13 : 11, color: Colors.grey)),
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
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey)),
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
                          style: TextStyle(
                              fontSize: isSenior ? 13 : 11, color: Colors.grey)),
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
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey)),
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
                          style: TextStyle(
                              fontSize: isSenior ? 13 : 11, color: Colors.grey)),
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
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // ===================================================================
        // NEW FEATURE: SUBSCRIBERS & INDIVIDUAL MEAL ORDERS (Requested by User)
        // ===================================================================
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF2E7D32), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('subscriber_orders_title'),
                      style: TextStyle(
                          fontSize: isSenior ? 22 : 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${ApiService.subscribers.length} Active Diners',
                        style: const TextStyle(
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tr('subscriber_orders_desc'),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Divider(),

                // List of individual subscribers with meals and orders
                ...ApiService.subscribers.map((subscriber) {
                  final isSkipped = subscriber.todayDinnerStatus == 'SKIPPED';
                  final isAttended = subscriber.todayDinnerStatus == 'ATTENDED';

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      border: Border.all(
                          color: isSkipped
                              ? Colors.red.shade400
                              : Colors.grey.withValues(alpha: 0.3),
                          width: isSkipped ? 1.5 : 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color(0xFFE65100),
                                  child: Text(
                                    subscriber.userName[0],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subscriber.userName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      '${subscriber.phone} • ${subscriber.planName}',
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                minimumSize: Size.zero,
                              ),
                              icon: const Icon(Icons.receipt_long, size: 14),
                              label: Text(tr('view_orders'),
                                  style: const TextStyle(fontSize: 11)),
                              onPressed: () =>
                                  _showIndividualOrdersDialog(subscriber),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Today's Individual Meal Status for this Subscriber
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('Lunch Today',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey)),
                                  const SizedBox(height: 2),
                                  Text(
                                    subscriber.todayLunchStatus == 'ATTENDED'
                                        ? 'Attended ✓'
                                        : 'Scheduled ⏳',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: subscriber.todayLunchStatus ==
                                              'ATTENDED'
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  height: 24,
                                  width: 1,
                                  color: Colors.grey.withValues(alpha: 0.3)),
                              Column(
                                children: [
                                  const Text('Dinner Tonight',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey)),
                                  const SizedBox(height: 2),
                                  Text(
                                    isSkipped
                                        ? 'Skipped ❌ (₹50 credited)'
                                        : isAttended
                                            ? 'Attended ✓'
                                            : 'Scheduled ⏳ (Prep needed)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: isSkipped
                                          ? Colors.red
                                          : isAttended
                                              ? Colors.green
                                              : const Color(0xFFE65100),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  height: 24,
                                  width: 1,
                                  color: Colors.grey.withValues(alpha: 0.3)),
                              Column(
                                children: [
                                  const Text('Meals Left',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey)),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${subscriber.mealsRemaining} / ${subscriber.totalMeals}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
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
                          fontWeight: FontWeight.bold,
                          fontSize: isSenior ? 18 : 14),
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

  // =========================================================================
  // ROLE 3: DINER / SUBSCRIBER HUB (With Login / Profile Switcher)
  // =========================================================================
  Widget _buildDinerView(bool isSenior) {
    final sub = ApiService.getSubscriber(widget.activeSubscriberId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 500;
            final greetingWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Namaste, ${sub.userName} 🙏',
                  style: TextStyle(
                    fontSize: isSenior ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${sub.planName} • Annapurna Bhojanalaya',
                  style: TextStyle(
                    fontSize: isSenior ? 16 : 13,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (sub.institutionOrOrg.isNotEmpty)
                  Text(
                    '🏢 ${sub.institutionOrOrg}',
                    style: TextStyle(
                      fontSize: isSenior ? 14 : 11,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            );

            final buttonsWidget = Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  icon: const Icon(Icons.switch_account, size: 16),
                  label: const Text('Login / Switch'),
                  onPressed: () => _showDinerLoginDialog(),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: Text(tr('back_home')),
                  onPressed: () => setState(() => _activeViewIndex = 0),
                ),
              ],
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  greetingWidget,
                  const SizedBox(height: 10),
                  buttonsWidget,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: greetingWidget),
                const SizedBox(width: 8),
                buttonsWidget,
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        // Senior Citizen Quick Call Button
        if (isSenior) ...[
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                const Text(
                  'Need Help? Call Mess Manager:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.phone),
                  label: const Text('Call Now'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Dialing Mess Manager: +91 98220 12345')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],

        // 3 Key Metrics Cards
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
                              fontSize: isSenior ? 14 : 11, color: Colors.grey)),
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
                              fontSize: isSenior ? 14 : 11, color: Colors.grey)),
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
                              fontSize: isSenior ? 14 : 11, color: Colors.grey)),
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
                    sub.todayDinnerStatus == 'SKIPPED'
                        ? 'Dinner Already Skipped (₹50 Credited)'
                        : tr('skip_action'),
                    style: TextStyle(
                        fontSize: isSenior ? 20 : 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: (_isSkipping || sub.todayDinnerStatus == 'SKIPPED')
                      ? null
                      : () => _handleSkipMeal(sub.id),
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
                          style: const TextStyle(
                              fontSize: 11, color: Colors.green)),
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
  // FOOTER & DIALOGS
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

  void _handleSkipMeal(String subId) async {
    setState(() => _isSkipping = true);
    final result = await ApiService.skipMeal(subId);
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

  // Dialog: Diner Login / Dedicated Persona Sign-In Flow
  void _showDinerLoginDialog() {
    final phoneCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.account_circle, color: Color(0xFFE65100)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                tr('diner_login_title'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('diner_login_desc'),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 14),

                const Text(
                  'Select Diner Login Persona:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 10),

                // ==========================================
                // 1. STUDENT LOGIN CARD (Rohan Patil)
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: widget.activeSubscriberId == 'sub_101'
                          ? const Color(0xFFE65100)
                          : const Color(0xFFE65100).withValues(alpha: 0.3),
                      width: widget.activeSubscriberId == 'sub_101' ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Color(0xFFE65100),
                                child: Text('🎓', style: TextStyle(fontSize: 13)),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Student Persona',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFFE65100),
                                ),
                              ),
                            ],
                          ),
                          if (widget.activeSubscriberId == 'sub_101')
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('ACTIVE',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Rohan Patil • +91 98765 43210',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const Text(
                        '🏫 COEP Technological University, Pune',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const Text(
                        '📋 Monthly 2-Meals • 42 Meals Left • ₹100 Credit',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 4,
                        children: const [
                          Chip(
                            label: Text('Dark UI', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Chip(
                            label: Text('1-Click Skip', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Chip(
                            label: Text('Exam Pause', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE65100),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          icon: const Icon(Icons.login, size: 16),
                          label: const Text('Sign In as Student (Rohan)'),
                          onPressed: () {
                            widget.onSubscriberChanged('sub_101');
                            widget.onRoleChanged(UserRole.diner);
                            setState(() => _activeViewIndex = 1);
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xFFE65100),
                                content: Text(
                                  'Logged in as Rohan Patil! 🎓 Student Mode & Dark Theme Activated.',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ==========================================
                // 2. WORKING ADULT LOGIN CARD (Priya Sharma)
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: widget.activeSubscriberId == 'sub_102'
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFF2E7D32).withValues(alpha: 0.3),
                      width: widget.activeSubscriberId == 'sub_102' ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Color(0xFF2E7D32),
                                child: Text('💼', style: TextStyle(fontSize: 13)),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Working Adult Persona',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                            ],
                          ),
                          if (widget.activeSubscriberId == 'sub_102')
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('ACTIVE',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Priya Sharma • +91 98111 22233',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const Text(
                        '🏢 Infosys Campus, Hinjawadi Phase 2',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const Text(
                        '📋 Executive Lunch Box • 24 Meals Left • ₹50 Credit',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 4,
                        children: const [
                          Chip(
                            label: Text('Corporate Light UI', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Chip(
                            label: Text('Desk Delivery', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Chip(
                            label: Text('GST Invoices', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          icon: const Icon(Icons.login, size: 16),
                          label: const Text('Sign In as Working Adult (Priya)'),
                          onPressed: () {
                            widget.onSubscriberChanged('sub_102');
                            widget.onRoleChanged(UserRole.diner);
                            setState(() => _activeViewIndex = 1);
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xFF2E7D32),
                                content: Text(
                                  'Logged in as Priya Sharma! 💼 Working Adult Mode & Light Theme Activated.',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ==========================================
                // 3. SENIOR CITIZEN LOGIN CARD (Nana Saheb)
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: widget.activeSubscriberId == 'sub_103'
                          ? const Color(0xFFFF9800)
                          : const Color(0xFFFF9800).withValues(alpha: 0.4),
                      width: widget.activeSubscriberId == 'sub_103' ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Color(0xFFFF9800),
                                child: Text('👓', style: TextStyle(fontSize: 13)),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Senior Citizen Persona',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFFFF9800),
                                ),
                              ),
                            ],
                          ),
                          if (widget.activeSubscriberId == 'sub_103')
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('ACTIVE',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Nana Saheb Joshi • +91 94220 55566',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const Text(
                        '🏡 Senior Citizens Forum, Kothrud, Pune',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const Text(
                        '📋 Senior Nutritional Care • 54 Meals Left',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 4,
                        children: const [
                          Chip(
                            label: Text('High Contrast AAA', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Chip(
                            label: Text('Mild Spice Diet', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Chip(
                            label: Text('1-Tap Help Call', style: TextStyle(fontSize: 9)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9800),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          icon: const Icon(Icons.login, size: 16),
                          label: const Text(
                            'Sign In as Senior Citizen (Nana Saheb)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            widget.onSubscriberChanged('sub_103');
                            widget.onRoleChanged(UserRole.diner);
                            setState(() => _activeViewIndex = 1);
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xFFFF9800),
                                content: Text(
                                  'Logged in as Nana Saheb Joshi! 👓 Senior Citizen Mode & WCAG AAA Contrast Activated.',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),
                const SizedBox(height: 6),
                const Text(
                  'Or Sign In with Any Mobile Number (OTP):',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixText: '+91 ',
                    labelText: '10-Digit Mobile Number',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              if (phoneCtrl.text.isNotEmpty) {
                widget.onRoleChanged(UserRole.diner);
                setState(() => _activeViewIndex = 1);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('OTP Verified! Signed in as Diner with +91 ${phoneCtrl.text}'),
                  ),
                );
              }
            },
            child: const Text('Sign In via OTP'),
          ),
        ],
      ),
    );
  }

  // Dialog: Individual Orders & Meal History (For Mess Owner)
  void _showIndividualOrdersDialog(Subscriber subscriber) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${subscriber.userName} — Meal Orders'),
            Text(
              '${subscriber.phone} • Plan: ${subscriber.planName}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Remaining: ${subscriber.mealsRemaining}/${subscriber.totalMeals}'),
                    Text('Wallet: ₹${subscriber.creditBalancePaise ~/ 100}'),
                    Text('Skips: ${subscriber.skipsUsed}/${subscriber.maxSkips}'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text('Recent Individual Orders & Actions:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),

              // Orders list
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: subscriber.orders.length,
                  itemBuilder: (context, idx) {
                    final order = subscriber.orders[idx];
                    final isSkipped = order.status == 'SKIPPED';
                    final isAttended = order.status == 'ATTENDED';

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          isSkipped
                              ? Icons.cancel
                              : isAttended
                                  ? Icons.check_circle
                                  : Icons.schedule,
                          color: isSkipped
                              ? Colors.red
                              : isAttended
                                  ? Colors.green
                                  : Colors.orange,
                        ),
                        title: Text('${order.mealType} — ${order.date}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(order.notes,
                            style: const TextStyle(fontSize: 11)),
                        trailing: Text(
                          order.status,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSkipped
                                ? Colors.red
                                : isAttended
                                    ? Colors.green
                                    : Colors.orange,
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
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddMessDialog() {
    final nameCtrl = TextEditingController();
    final fssaiCtrl = TextEditingController();
    final cityCtrl = TextEditingController(text: 'Pune');
    final localityCtrl = TextEditingController(text: 'Karve Nagar');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Register New Mess (Admin Control)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Mess Name'),
              ),
              TextField(
                controller: fssaiCtrl,
                decoration: const InputDecoration(
                    labelText: '14-Digit FSSAI License Number'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: cityCtrl,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: localityCtrl,
                decoration: const InputDecoration(labelText: 'Locality'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && fssaiCtrl.text.length == 14) {
                setState(() {
                  _platformMesses.add(Mess(
                    id: 'mess_${DateTime.now().millisecondsSinceEpoch}',
                    name: nameCtrl.text,
                    fssai: fssaiCtrl.text,
                    fssaiVerified: true,
                    city: cityCtrl.text,
                    locality: localityCtrl.text,
                    dietary: 'PURE_VEG',
                    rating: 5.0,
                    pricePerMonth: 3200,
                    skipCreditPerMeal: 50,
                    phone: '+91 98000 00000',
                  ));
                });
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ New Mess registered & FSSAI verified!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('⚠️ Please enter valid name and 14-digit FSSAI number.')),
                );
              }
            },
            child: const Text('Register & Verify'),
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
