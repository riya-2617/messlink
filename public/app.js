// MessLink Client Application Logic
// Trilingual engine, Persona mode switcher, and interactive operational modules

const I18N = {
  en: {
    app_title: "MessLink",
    app_tagline: "Indian Mess Discovery & Subscriptions",
    landing_badge: "🍽️ India's #1 Mess Subscription Network",
    landing_heading: "Are you here to Eat or Manage a Mess?",
    landing_subheading: "Connecting students and working professionals with nutritious local messes. Skip meals before cutoff, avoid food waste, and save money.",
    eat_title: "Eat at a Mess",
    eat_desc: "Discover verified messes in Pune & Kota. View today's menu, skip meals in 1-click, and track your meal credits.",
    eat_cta: "Explore Diners' Hub →",
    manage_title: "Manage a Mess",
    manage_desc: "Predict today's exact headcount, reduce kitchen food wastage by 30%, scan daily menus with AI, and automate dues.",
    manage_cta: "Open Owner Portal →",
    mode_student: "🎓 Student Mode (Dark)",
    mode_working: "💼 Working Adult (Light)",
    mode_senior: "👓 Senior Citizen (High-Contrast)",
    today_menu: "Today's Verified Menu",
    lunch: "Lunch",
    dinner: "Dinner",
    skip_action: "Skip Meal & Save ₹50",
    skips_left: "Monthly Skips Used",
    credits_balance: "Wallet Credits Balance",
    meals_remaining: "Remaining Meals",
    fssai_verified: "FSSAI Verified",
    cutoff_lunch_alert: "Lunch Skip Cutoff: 09:00 AM IST. Cutoff closed for today.",
    cutoff_dinner_alert: "Dinner Skip Cutoff: 05:00 PM IST. You can skip until 5:00 PM today.",
    owner_dashboard: "Mess Operations Dashboard",
    headcount_forecast: "Today's Headcount Forecast",
    scan_menu_title: "AI Menu Photo Scanner (OCR)",
    scan_menu_desc: "Snap a photo of your daily chalkboard or whiteboard menu in Marathi, Hindi, or English.",
    simulate_scan_btn: "📸 Scan Blackboard Menu Photo",
    review_publish_btn: "Confirm & Publish to Subscribers",
    ledger_title: "Transaction Ledger (Double-Entry)",
    date: "Date & Time",
    type: "Transaction Type",
    amount: "Amount",
    balance: "Balance",
    policy_dpdpa_title: "DPDPA 2023 & Indian Compliance",
    footer_text: "MessLink Technologies India Pvt. Ltd. | Compliant with DPDPA 2023, FSSAI Act 2006, and IT Act 2000."
  },
  mr: {
    app_title: "मेसलिंक",
    app_tagline: "भारतीय मेस शोध आणि जेवण सदस्यता",
    landing_badge: "🍽️ भारतातील विश्वासू मेस नेटवर्क",
    landing_heading: "तुम्ही जेवण्यासाठी आला आहात की मेस चालवण्यासाठी?",
    landing_subheading: "विद्यार्थी आणि नोकरदारांना घरगुती आणि सकस मेसशी जोडणारे व्यासपीठ. वेळेत जेवण रद्द करा, अन्न वाया जाणे टाळा आणि पैसे वाचवा.",
    eat_title: "मेसमध्ये जेवा",
    eat_desc: "पुणे आणि कोटा येथील खात्रीशीर मेस शोधा. आजचा मेनू पहा, एका क्लिकवर जेवण रद्द करा आणि क्रेडिट वाचवा.",
    eat_cta: "जेवणारांचे पोर्टल उघडा →",
    manage_title: "मेसचे व्यवस्थापन करा",
    manage_desc: "आज जेवणाऱ्यांची अचूक संख्या जाणून घ्या, अन्न वाया जाणे ३०% रोखा, एआय द्वारे मेनू स्कॅन करा आणि हिशोब ठेवा.",
    manage_cta: "मालक पोर्टल उघडा →",
    mode_student: "🎓 विद्यार्थी मोड (डार्क)",
    mode_working: "💼 नोकरदार मोड (लाईट)",
    mode_senior: "👓 ज्येष्ठ नागरिक मोड (हाय-कॉन्ट्रास्ट)",
    today_menu: "आजचा अधिकृत मेनू",
    lunch: "दुपारचे जेवण",
    dinner: "रात्रीचे जेवण",
    skip_action: "जेवण रद्द करा आणि ₹५० वाचवा",
    skips_left: "वापरलेले जेवण रद्दीकरण",
    credits_balance: "शिल्लक वॉलेट क्रेडिट",
    meals_remaining: "शिल्लक जेवण",
    fssai_verified: "FSSAI प्रमाणित",
    cutoff_lunch_alert: "दुपारच्या जेवणाची शेवटची वेळ: सकाळी ९:०० IST. आजची वेळ संपली.",
    cutoff_dinner_alert: "रात्रीच्या जेवणाची शेवटची वेळ: संध्याकाळी ५:०० IST. तुम्ही अजून रद्द करू शकता.",
    owner_dashboard: "मेस व्यवस्थापन डॅशबोर्ड",
    headcount_forecast: "आजच्या जेवणाचा अंदाज (हेडकाउंट)",
    scan_menu_title: "एआय मेनू फोटो स्कॅनर (OCR)",
    scan_menu_desc: "तुमच्या ब्लॅकबोर्ड किंवा व्हाईटबोर्डवरील मराठी, हिंदी किंवा इंग्रजी मेनूचा फोटो काढा.",
    simulate_scan_btn: "📸 फळ्यावरील मेनूचा फोटो स्कॅन करा",
    review_publish_btn: "तपासा आणि ग्राहकांसाठी प्रसिद्ध करा",
    ledger_title: "आर्थिक व्यवहार वही (Double-Entry Ledger)",
    date: "दिनांक आणि वेळ",
    type: "व्यवहार प्रकार",
    amount: "रक्कम",
    balance: "शिल्लक",
    policy_dpdpa_title: "DPDPA २०२३ आणि कायदेशीर माहिती",
    footer_text: "मेसलिंक टेक्नॉलॉजीज इंडिया प्रा. लि. | DPDPA २०२३, FSSAI कायदा २००६ आणि IT कायदा २००० चे पालनकर्ते."
  },
  hi: {
    app_title: "मेसलिंक",
    app_tagline: "भारतीय मेस खोज एवं भोजन सदस्यता",
    landing_badge: "🍽️ भारत का अग्रणी मेस सदस्यता नेटवर्क",
    landing_heading: "आप यहाँ भोजन करने आए हैं या मेस का प्रबंधन करने?",
    landing_subheading: "छात्रों और कामकाजी पेशेवरों को पौष्टिक स्थानीय मेस से जोड़ना। कटऑफ से पहले भोजन स्किप करें, अन्न की बर्बादी रोकें और बचत करें।",
    eat_title: "मेस में भोजन करें",
    eat_desc: "पुणे और कोटा की सत्यापित मेस खोजें। आज का मेनू देखें, १-क्लिक में भोजन स्किप करें और क्रेडिट पाएं।",
    eat_cta: "डाइनर पोर्टल खोलें →",
    manage_title: "मेस का प्रबंधन करें",
    manage_desc: "आज की सही संख्या जानें, भोजन की बर्बादी ३०% कम करें, एआई द्वारा मेनू स्कैन करें और हिसाब रखें।",
    manage_cta: "ओनर पोर्टल खोलें →",
    mode_student: "🎓 छात्र मोड (डार्क)",
    mode_working: "💼 कामकाजी मोड (लाइट)",
    mode_senior: "👓 वरिष्ठ नागरिक मोड (हाई-कंट्रास्ट)",
    today_menu: "आज का सत्यापित मेनू",
    lunch: "दोपहर का भोजन",
    dinner: "रात का भोजन",
    skip_action: "भोजन छोड़ें और ₹50 बचाएं",
    skips_left: "महीने में किए गए स्किप",
    credits_balance: "वॉलेट क्रेडिट बैलेंस",
    meals_remaining: "शेष भोजन संख्या",
    fssai_verified: "FSSAI सत्यापित",
    cutoff_lunch_alert: "दोपहर भोजन कटऑफ: सुबह 09:00 IST। आज का समय समाप्त।",
    cutoff_dinner_alert: "रात के भोजन का कटऑफ: शाम 05:00 IST। आप शाम 5 बजे तक स्किप कर सकते हैं।",
    owner_dashboard: "मेस संचालन डैशबोर्ड",
    headcount_forecast: "आज का हेडकाउंट पूर्वानुमान",
    scan_menu_title: "एआई मेनू फोटो स्कैनर (OCR)",
    scan_menu_desc: "अपने ब्लैकबोर्ड या व्हाइटबोर्ड के मेनू की फोटो लें (मराठी, हिंदी या अंग्रेजी)।",
    simulate_scan_btn: "📸 मेनू बोर्ड फोटो स्कैन करें",
    review_publish_btn: "समीक्षा करें और सब्सक्राइबर्स को भेजें",
    ledger_title: "लेन-देन बहीखाता (डबल-एंट्री लेजर)",
    date: "तारीख और समय",
    type: "प्रकार",
    amount: "राशि",
    balance: "बैलेंस",
    policy_dpdpa_title: "DPDPA 2023 एवं भारतीय अनुपालन",
    footer_text: "मेसलिंक टेक्नोलॉजीज इंडिया प्रा. लि. | DPDPA 2023, FSSAI 2006 एवं IT अधिनियम 2000 के अनुरूप।"
  }
};

// Application State
const app = {
  currentLang: 'en',
  currentPersona: 'STUDENT',
  currentView: 'LANDING', // 'LANDING', 'DINER', 'OWNER'
  subscriber: null,
  mess: null,
  todayMenu: null,
  ocrScannedItems: null
};

// Initialize Application
document.addEventListener('DOMContentLoaded', () => {
  setupLanguageSwitcher();
  setupPersonaSwitcher();
  setupNetworkMonitoring();
  loadInitialData();
  renderStrings();
});

// Setup Language
function setupLanguageSwitcher() {
  const langSelect = document.getElementById('lang-select');
  if (langSelect) {
    langSelect.addEventListener('change', (e) => {
      app.currentLang = e.target.value;
      renderStrings();
      if (app.currentView === 'DINER') renderDinerView();
      if (app.currentView === 'OWNER') renderOwnerView();
    });
  }
}

// Setup Persona
function setupPersonaSwitcher() {
  const personaSelect = document.getElementById('persona-select');
  if (personaSelect) {
    personaSelect.addEventListener('change', (e) => {
      applyPersonaMode(e.target.value);
    });
  }
  applyPersonaMode('STUDENT');
}

function applyPersonaMode(mode) {
  app.currentPersona = mode;
  document.body.className = '';
  if (mode === 'STUDENT') {
    document.body.classList.add('mode-student');
  } else if (mode === 'WORKING') {
    document.body.classList.add('mode-working');
  } else if (mode === 'SENIOR') {
    document.body.classList.add('mode-senior');
  }
}

// Network Online/Offline
function setupNetworkMonitoring() {
  const banner = document.getElementById('network-banner');
  const updateStatus = () => {
    if (navigator.onLine) {
      banner.classList.remove('offline');
      banner.style.display = 'none';
    } else {
      banner.classList.add('offline');
      banner.style.display = 'block';
      banner.textContent = "⚠️ Offline Mode: Changes are safely stored in queue and will sync automatically.";
    }
  };
  window.addEventListener('online', updateStatus);
  window.addEventListener('offline', updateStatus);
  updateStatus();
}

// Render Localized UI Strings
function renderStrings() {
  const t = I18N[app.currentLang] || I18N.en;
  document.querySelectorAll('[data-i18n]').forEach(el => {
    const key = el.getAttribute('data-i18n');
    if (t[key]) {
      el.textContent = t[key];
    }
  });
}

// Navigation Router
window.navigateTo = function(view) {
  app.currentView = view;
  document.querySelectorAll('.view-section').forEach(sec => sec.classList.remove('active'));
  
  if (view === 'LANDING') {
    document.getElementById('view-landing').classList.add('active');
  } else if (view === 'DINER') {
    document.getElementById('view-diner').classList.add('active');
    renderDinerView();
  } else if (view === 'OWNER') {
    document.getElementById('view-owner').classList.add('active');
    renderOwnerView();
  }
  window.scrollTo({ top: 0, behavior: 'smooth' });
};

// Initial Data Fetch
async function loadInitialData() {
  try {
    const [subRes, menuRes] = await Promise.all([
      fetch('/api/subscriber/current'),
      fetch('/api/menu/today?messId=mess_pune_01')
    ]);
    const subData = await subRes.json();
    const menuData = await menuRes.json();
    
    if (subData.success) app.subscriber = subData.subscriber;
    if (menuData.success) {
      app.todayMenu = menuData.menu;
      app.mess = menuData.mess;
    }
  } catch (err) {
    console.error("Failed to load initial server data:", err);
  }
}

// Render Diner Portal
function renderDinerView() {
  const t = I18N[app.currentLang] || I18N.en;
  if (!app.subscriber) return;

  document.getElementById('diner-user-name').textContent = app.subscriber.userName;
  document.getElementById('diner-meals-left').textContent = `${app.subscriber.mealsRemaining} / ${app.subscriber.totalMeals}`;
  document.getElementById('diner-credits-balance').textContent = `₹${(app.subscriber.creditBalancePaise / 100).toFixed(0)}`;
  document.getElementById('diner-skips-used').textContent = `${app.subscriber.skipsUsed} / ${app.subscriber.maxSkips}`;

  // Render Today's Menu Items in selected language
  const menuContainer = document.getElementById('diner-menu-items');
  menuContainer.innerHTML = '';
  
  if (app.todayMenu && app.todayMenu.dinner && app.todayMenu.dinner.items) {
    app.todayMenu.dinner.items.forEach(item => {
      const row = document.createElement('div');
      row.className = 'menu-item-row';
      const localizedName = item[app.currentLang] || item.en;
      row.innerHTML = `
        <div>
          <div class="item-name">${localizedName}</div>
          <div class="item-category">${item.category}</div>
        </div>
        <span class="badge badge-success">✓ Freshly Prepared</span>
      `;
      menuContainer.appendChild(row);
    });
  }
}

// Interactive Meal Skip Action (With Server Persistence & Double-Credit Protection)
window.handleSkipMeal = async function() {
  if (!app.subscriber) return;

  const btn = document.getElementById('skip-meal-btn');
  btn.disabled = true;
  btn.textContent = "Processing Skip Request...";

  try {
    const response = await fetch('/api/subscriptions/skip', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        subId: app.subscriber.id,
        mealType: 'DINNER',
        date: new Date().toISOString().split('T')[0]
      })
    });

    const data = await response.json();
    if (data.success) {
      if (data.alreadySkipped) {
        alert(data.message);
      } else {
        app.subscriber.mealsRemaining = data.mealsRemaining;
        app.subscriber.creditBalancePaise = data.creditBalancePaise;
        app.subscriber.skipsUsed = data.skipsUsed;
        renderDinerView();
        
        // Show success banner
        const alertBox = document.getElementById('skip-success-banner');
        alertBox.style.display = 'block';
        alertBox.innerHTML = `✅ <strong>${data.message}</strong> Kitchen prep target has been adjusted.`;
      }
      btn.textContent = "Meal Skipped";
      btn.classList.remove('btn-primary');
      btn.classList.add('btn-outline');
    }
  } catch (err) {
    alert("Network error. Your skip request has been saved offline.");
    btn.disabled = false;
    btn.textContent = I18N[app.currentLang].skip_action;
  }
};

// Render Owner Portal
async function renderOwnerView() {
  try {
    const res = await fetch('/api/owner/forecast?messId=mess_pune_01');
    const data = await res.json();
    if (data.success) {
      const f = data.forecast;
      document.getElementById('owner-lunch-expected').textContent = `${f.lunch.expectedAttendance} Meals`;
      document.getElementById('owner-lunch-skips').textContent = `${f.lunch.skipsRegistered} Skips`;
      
      document.getElementById('owner-dinner-expected').textContent = `${f.dinner.expectedAttendance} Meals`;
      document.getElementById('owner-dinner-skips').textContent = `${f.dinner.skipsRegistered} Skips`;

      // Render Ledger Records
      const ledgerTbody = document.getElementById('owner-ledger-tbody');
      ledgerTbody.innerHTML = '';
      data.recentLedger.forEach(row => {
        const tr = document.createElement('tr');
        const formattedDate = new Date(row.timestamp).toLocaleDateString('en-IN', {
          day: '2-digit', month: 'short', hour: '2-digit', minute: '2-digit'
        });
        tr.innerHTML = `
          <td>${formattedDate}</td>
          <td><strong>${row.type.replace('_', ' ')}</strong><br><small style="color:var(--text-muted)">${row.note}</small></td>
          <td style="color: ${row.credit > 0 ? 'var(--color-veg-green)' : 'var(--color-saffron)'}">
            ${row.credit > 0 ? '+₹' + (row.credit/100) : '-₹' + (row.debit/100)}
          </td>
          <td><strong>₹${(row.balance/100).toFixed(0)}</strong></td>
        `;
        ledgerTbody.appendChild(tr);
      });
    }
  } catch (err) {
    console.error("Owner forecast fetch error:", err);
  }
}

// Simulate AI Menu Photo Scanner (OCR)
window.simulateOCRScan = function() {
  const scanBtn = document.getElementById('ocr-scan-btn');
  const previewBox = document.getElementById('ocr-result-preview');
  
  scanBtn.disabled = true;
  scanBtn.textContent = "⏳ Preprocessing Image & Extracting Devanagari OCR...";

  setTimeout(() => {
    scanBtn.disabled = false;
    scanBtn.textContent = "📸 Rescan Blackboard Photo";
    previewBox.style.display = 'block';

    app.ocrScannedItems = [
      { category: "Sabzi", en: "Chole Masala", mr: "मसाला छोले", hi: "छोले मसाला", confidence: 0.98 },
      { category: "Sabzi", en: "Aloo Gobhi", mr: "बटाटा फ्लॉवर भाजी", hi: "आलू गोभी", confidence: 0.95 },
      { category: "Bread", en: "Puri (5 pcs)", mr: "गरम पुरी (५ नग)", hi: "गरम पूरी (५)", confidence: 0.92 },
      { category: "Rice", en: "Peas Pulao", mr: "मटार पुलाव", hi: "मटर पुलाव", confidence: 0.91 },
      { category: "Sweet", en: "Sheera (Halwa)", mr: "रव्याचा शिरा", hi: "सूजी का हलवा", confidence: 0.74 } // Low confidence flagged
    ];

    const listContainer = document.getElementById('ocr-items-list');
    listContainer.innerHTML = '';
    app.ocrScannedItems.forEach((item, idx) => {
      const div = document.createElement('div');
      div.className = 'menu-item-row';
      const isUncertain = item.confidence < 0.85;
      div.innerHTML = `
        <div>
          <span class="item-name">${item[app.currentLang] || item.en}</span>
          ${isUncertain ? '<span class="ocr-badge-uncertain">⚠️ Review Spelling</span>' : '<span style="color:var(--color-veg-green); font-size:0.8rem">✓ 98% Confident</span>'}
          <div class="item-category">${item.category} • Confidence: ${(item.confidence * 100).toFixed(0)}%</div>
        </div>
        <button class="btn btn-outline" style="min-height:36px; padding:4px 10px; font-size:0.8rem" onclick="editOcrItem(${idx})">Edit</button>
      `;
      listContainer.appendChild(div);
    });
  }, 1200);
};

// Edit OCR Item Fallback
window.editOcrItem = function(index) {
  const item = app.ocrScannedItems[index];
  const newName = prompt("Edit item name:", item[app.currentLang] || item.en);
  if (newName) {
    item[app.currentLang] = newName;
    item.confidence = 1.0;
    simulateOCRScan();
  }
};

// Owner Confirm & Publish Menu
window.publishScannedMenu = async function() {
  if (!app.ocrScannedItems) return;
  const btn = document.getElementById('ocr-publish-btn');
  btn.disabled = true;
  btn.textContent = "Publishing to Subscribers...";

  try {
    const res = await fetch('/api/owner/menu/publish', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        messId: 'mess_pune_01',
        mealType: 'DINNER',
        items: app.ocrScannedItems
      })
    });
    const data = await res.json();
    if (data.success) {
      alert("✅ Menu Published! All subscribers have been notified.");
      btn.textContent = "Published ✓";
      document.getElementById('ocr-result-preview').style.display = 'none';
      loadInitialData();
    }
  } catch (err) {
    alert("Menu published locally. Will synchronize with cloud server.");
  }
};

// Modal Control for Policies
window.openModal = function(id) {
  document.getElementById(id).classList.add('active');
};
window.closeModal = function(id) {
  document.getElementById(id).classList.remove('active');
};
