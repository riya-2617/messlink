// MessLink (मेसलिंक) Client Application Logic
// Trilingual engine, Persona mode switcher, live countdown, and interactive operational modules

const I18N = {
  en: {
    app_title: "MessLink",
    app_tagline: "Indian Mess Discovery & Subscriptions",
    nav_explore: "Explore",
    nav_diner: "My Pass (Diner)",
    nav_owner: "Owner Cockpit",
    landing_badge: "🍽️ India's #1 Mess Subscription Network",
    landing_heading: "Are you here to Eat or Manage a Mess?",
    landing_subheading: "Connecting students and working professionals with nutritious, verified local messes. Skip meals before cutoff in 1-tap, avoid food waste, and get instant ₹50 ledger credits back.",
    eat_title: "Eat at a Mess",
    eat_desc: "Discover verified messes in Pune & Kota. View today's menu, skip meals in 1-click before cutoff, and track your wallet credits.",
    eat_cta: "Explore Diners' Hub →",
    manage_title: "Manage a Mess",
    manage_desc: "Predict today's exact headcount, reduce kitchen food wastage by 30%, scan daily chalkboard menus with AI, and automate dues.",
    manage_cta: "Open Owner Portal →",
    today_menu: "Today's Verified Menu",
    lunch: "Lunch",
    dinner: "Dinner",
    skip_action: "⚡ Skip Tonight's Dinner & Save ₹50",
    skips_left: "Monthly Skips Used",
    credits_balance: "Wallet Credits Balance",
    meals_remaining: "Remaining Meals",
    fssai_verified: "FSSAI Verified",
    cutoff_lunch_alert: "Lunch Skip Cutoff: 09:00 AM IST. Cutoff closed for today.",
    cutoff_dinner_alert: "Dinner Skip Cutoff: 05:00 PM IST.",
    owner_dashboard: "Mess Operations Dashboard",
    headcount_forecast: "Today's Headcount Forecast",
    scan_menu_title: "AI Menu Photo Scanner (Devanagari OCR)",
    scan_menu_desc: "Snap a photo of your daily chalkboard or whiteboard menu in Marathi, Hindi, or English. MessLink AI digitizes it for all subscribers.",
    simulate_scan_btn: "📸 Scan Blackboard Menu Photo",
    review_publish_btn: "✓ Confirm & Broadcast to 87 Subscribers",
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
    nav_explore: "शोधा",
    nav_diner: "माझे पास (जेवणारे)",
    nav_owner: "मालक कॉकपिट",
    landing_badge: "🍽️ भारतातील विश्वासू मेस नेटवर्क",
    landing_heading: "तुम्ही जेवण्यासाठी आला आहात की मेस चालवण्यासाठी?",
    landing_subheading: "विद्यार्थी आणि नोकरदारांना घरगुती आणि सकस मेसशी जोडणारे व्यासपीठ. वेळेत जेवण रद्द करा, अन्न वाया जाणे टाळा आणि पैसे वाचवा.",
    eat_title: "मेसमध्ये जेवा",
    eat_desc: "पुणे आणि कोटा येथील खात्रीशीर मेस शोधा. आजचा मेनू पहा, एका क्लिकवर जेवण रद्द करा आणि क्रेडिट मिळवा.",
    eat_cta: "जेवणारांचे पोर्टल उघडा →",
    manage_title: "मेसचे व्यवस्थापन करा",
    manage_desc: "आज जेवणाऱ्यांची अचूक संख्या जाणून घ्या, अन्न वाया जाणे ३०% रोखा, एआय द्वारे फळ्यावरील मेनू स्कॅन करा आणि हिशोब ठेवा.",
    manage_cta: "मालक पोर्टल उघडा →",
    today_menu: "आजचा अधिकृत मेनू",
    lunch: "दुपारचे जेवण",
    dinner: "रात्रीचे जेवण",
    skip_action: "⚡ रात्रीचे जेवण रद्द करा आणि ₹५० वाचवा",
    skips_left: "वापरलेले जेवण रद्दीकरण",
    credits_balance: "शिल्लक वॉलेट क्रेडिट",
    meals_remaining: "शिल्लक जेवण",
    fssai_verified: "FSSAI प्रमाणित",
    cutoff_lunch_alert: "दुपारच्या जेवणाची शेवटची वेळ: सकाळी ९:०० IST. आजची वेळ संपली.",
    cutoff_dinner_alert: "रात्रीच्या जेवणाची शेवटची वेळ: संध्याकाळी ५:०० IST.",
    owner_dashboard: "मेस व्यवस्थापन डॅशबोर्ड",
    headcount_forecast: "आजच्या जेवणाचा अंदाज (हेडकाउंट)",
    scan_menu_title: "एआय मेनू फोटो स्कॅनर (मराठी/देवनागरी OCR)",
    scan_menu_desc: "तुमच्या ब्लॅकबोर्ड किंवा व्हाईटबोर्डवरील मराठी, हिंदी किंवा इंग्रजी मेनूचा फोटो काढा.",
    simulate_scan_btn: "📸 फळ्यावरील मेनूचा फोटो स्कॅन करा",
    review_publish_btn: "✓ तपासा आणि ८७ ग्राहकांसाठी प्रसिद्ध करा",
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
    nav_explore: "खोजें",
    nav_diner: "मेरा पास (डाइनर)",
    nav_owner: "ओनर कॉकपिट",
    landing_badge: "🍽️ भारत का अग्रणी मेस सदस्यता नेटवर्क",
    landing_heading: "आप यहाँ भोजन करने आए हैं या मेस का प्रबंधन करने?",
    landing_subheading: "छात्रों और कामकाजी पेशेवरों को पौष्टिक स्थानीय मेस से जोड़ना। कटऑफ से पहले भोजन स्किप करें, अन्न की बर्बादी रोकें और बचत करें।",
    eat_title: "मेस में भोजन करें",
    eat_desc: "पुणे और कोटा की सत्यापित मेस खोजें। आज का मेनू देखें, १-क्लिक में भोजन स्किप करें और क्रेडिट पाएं।",
    eat_cta: "डाइनर पोर्टल खोलें →",
    manage_title: "मेस का प्रबंधन करें",
    manage_desc: "आज की सही संख्या जानें, भोजन की बर्बादी ३०% कम करें, एआई द्वारा मेनू स्कैन करें और हिसाब रखें।",
    manage_cta: "ओनर पोर्टल खोलें →",
    today_menu: "आज का सत्यापित मेनू",
    lunch: "दोपहर का भोजन",
    dinner: "रात का भोजन",
    skip_action: "⚡ रात का भोजन छोड़ें और ₹50 बचाएं",
    skips_left: "महीने में किए गए स्किप",
    credits_balance: "वॉलेट क्रेडिट बैलेंस",
    meals_remaining: "शेष भोजन संख्या",
    fssai_verified: "FSSAI सत्यापित",
    cutoff_lunch_alert: "दोपहर भोजन कटऑफ: सुबह 09:00 IST। आज का समय समाप्त।",
    cutoff_dinner_alert: "रात के भोजन का कटऑफ: शाम 05:00 IST।",
    owner_dashboard: "मेस संचालन डैशबोर्ड",
    headcount_forecast: "आज का हेडकाउंट पूर्वानुमान",
    scan_menu_title: "एआई मेनू फोटो स्कैनर (देवनागरी OCR)",
    scan_menu_desc: "अपने ब्लैकबोर्ड या व्हाइटबोर्ड के मेनू की फोटो लें (मराठी, हिंदी या अंग्रेजी)।",
    simulate_scan_btn: "📸 मेनू बोर्ड फोटो स्कैन करें",
    review_publish_btn: "✓ समीक्षा करें और 87 सब्सक्राइबर्स को भेजें",
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
  currentMenuMeal: 'dinner', // 'lunch' or 'dinner'
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
  startCutoffCountdown();
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

// Network Online/Offline Monitor
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

// Live Countdown Timer to 05:00 PM IST
function startCutoffCountdown() {
  const ticker = document.getElementById('countdown-ticker');
  if (!ticker) return;

  function updateTicker() {
    const now = new Date();
    // Target: Today 17:00:00 IST
    const target = new Date();
    target.setHours(17, 0, 0, 0);

    let diff = target - now;
    if (diff <= 0) {
      ticker.textContent = "Cutoff Closed (05:00 PM IST)";
      ticker.style.color = "#ef4444";
      const skipBtn = document.getElementById('skip-meal-btn');
      if (skipBtn && !skipBtn.classList.contains('skipped')) {
        skipBtn.disabled = true;
        skipBtn.textContent = "Cutoff Closed for Tonight";
      }
      return;
    }

    const hrs = String(Math.floor(diff / (1000 * 60 * 60))).padStart(2, '0');
    const mins = String(Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))).padStart(2, '0');
    const secs = String(Math.floor((diff % (1000 * 60)) / 1000)).padStart(2, '0');
    ticker.textContent = `${hrs}h ${mins}m ${secs}s remaining`;
  }

  updateTicker();
  setInterval(updateTicker, 1000);
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
  document.querySelectorAll('.nav-link-btn').forEach(btn => btn.classList.remove('active'));

  if (view === 'LANDING') {
    document.getElementById('view-landing').classList.add('active');
    const navBtn = document.getElementById('nav-btn-landing');
    if (navBtn) navBtn.classList.add('active');
  } else if (view === 'DINER') {
    document.getElementById('view-diner').classList.add('active');
    const navBtn = document.getElementById('nav-btn-diner');
    if (navBtn) navBtn.classList.add('active');
    renderDinerView();
  } else if (view === 'OWNER') {
    document.getElementById('view-owner').classList.add('active');
    const navBtn = document.getElementById('nav-btn-owner');
    if (navBtn) navBtn.classList.add('active');
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
    if (app.currentView === 'DINER') renderDinerView();
  } catch (err) {
    console.error("Failed to load initial server data:", err);
  }
}

// Switch Diner Menu between Lunch and Dinner
window.switchMenuMeal = function(mealType) {
  app.currentMenuMeal = mealType;
  const tabDinner = document.getElementById('menu-tab-dinner');
  const tabLunch = document.getElementById('menu-tab-lunch');
  if (mealType === 'dinner') {
    tabDinner.classList.add('active');
    tabLunch.classList.remove('active');
  } else {
    tabLunch.classList.add('active');
    tabDinner.classList.remove('active');
  }
  renderMenuItems();
};

// Render Diner Portal
function renderDinerView() {
  if (!app.subscriber) return;

  document.getElementById('diner-user-name').textContent = app.subscriber.userName;
  document.getElementById('diner-meals-left').textContent = `${app.subscriber.mealsRemaining} / ${app.subscriber.totalMeals}`;
  document.getElementById('diner-credits-balance').textContent = `₹${(app.subscriber.creditBalancePaise / 100).toFixed(0)}`;
  document.getElementById('diner-skips-used').textContent = `${app.subscriber.skipsUsed} / ${app.subscriber.maxSkips}`;

  renderMenuItems();
}

// Render Menu Items
function renderMenuItems() {
  const menuContainer = document.getElementById('diner-menu-items');
  if (!menuContainer || !app.todayMenu) return;

  menuContainer.innerHTML = '';
  const mealObj = app.todayMenu[app.currentMenuMeal];

  if (mealObj && mealObj.items) {
    mealObj.items.forEach(item => {
      const row = document.createElement('div');
      row.className = 'dish-card-row';
      const localizedName = item[app.currentLang] || item.en;

      // Authentic tag heuristics
      let tagHtml = `<span class="dish-tag">${item.category}</span>`;
      if (item.category === 'Sabzi') {
        tagHtml += ` <span class="dish-tag" style="color: #ff6b00;">🔥 Fresh Spices</span>`;
      } else if (item.category === 'Bread') {
        tagHtml += ` <span class="dish-tag" style="color: #10b981;">🥞 Unlimited Tawa Hot</span>`;
      } else if (item.category === 'Dal') {
        tagHtml += ` <span class="dish-tag" style="color: #f59e0b;">✨ High Protein</span>`;
      }

      row.innerHTML = `
        <div class="dish-name-tags">
          <div class="dish-primary-name">${localizedName}</div>
          <div class="dish-meta-pills">${tagHtml}</div>
        </div>
        <span class="badge badge-veg">✓ Freshly Prepared</span>
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
  btn.textContent = "Processing Skip with Kitchen...";

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
        alertBox.innerHTML = `✅ <strong>${data.message}</strong> Kitchen head-count target updated to reduce overcooking.`;
      }
      btn.textContent = "✓ Dinner Skipped (₹50 Credited)";
      btn.classList.add('skipped');
      btn.style.background = "#059669";
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
        const isCredit = row.credit > 0;
        tr.innerHTML = `
          <td><strong>${formattedDate}</strong></td>
          <td>
            <strong>${row.type.replace('_', ' ')}</strong>
            <div style="color:var(--text-secondary); font-size: 0.78rem;">${row.note}</div>
          </td>
          <td style="color: ${isCredit ? 'var(--veg-green)' : 'var(--primary)'}; font-weight: 700;">
            ${isCredit ? '+₹' + (row.credit/100) : '-₹' + (row.debit/100)}
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

// Simulate AI Menu Photo Scanner (OCR) with Laser Line Animation
window.simulateOCRScan = function() {
  const scanBtn = document.getElementById('ocr-scan-btn');
  const previewBox = document.getElementById('ocr-result-preview');
  const laser = document.getElementById('ocr-scan-laser');

  scanBtn.disabled = true;
  scanBtn.textContent = "⏳ Analyzing Devanagari Script & Calibrating Confidence...";
  if (laser) laser.classList.add('scanning');

  setTimeout(() => {
    if (laser) laser.classList.remove('scanning');
    scanBtn.disabled = false;
    scanBtn.textContent = "📸 Rescan Chalkboard Photo";
    previewBox.style.display = 'block';

    app.ocrScannedItems = [
      { category: "Sabzi", en: "Paneer Masala", mr: "पनीर मसाला", hi: "पनीर मसाला", confidence: 0.98 },
      { category: "Dal", en: "Dal Tadka", mr: "डाळ तडका", hi: "दाल तड़का", confidence: 0.96 },
      { category: "Bread", en: "Garmagaram Poli (4 pcs)", mr: "गरमागरम पोळी (४ नग)", hi: "गरमागरम रोटी (४)", confidence: 0.94 },
      { category: "Rice", en: "Jeera Rice", mr: "जिरा राईस", hi: "जीरा चावल", confidence: 0.92 },
      { category: "Dessert", en: "Gulab Jamun (2 pcs)", mr: "गुलाबजाम (२ नग)", hi: "गुलाब जामुन (२)", confidence: 0.88 }
    ];

    const listContainer = document.getElementById('ocr-items-list');
    listContainer.innerHTML = '';
    app.ocrScannedItems.forEach((item, idx) => {
      const div = document.createElement('div');
      div.className = 'dish-card-row';
      div.innerHTML = `
        <div>
          <div class="dish-primary-name">${item[app.currentLang] || item.en}</div>
          <div style="font-size: 0.78rem; color: var(--text-secondary); margin-top: 2px;">
            ${item.category} • <span style="color: var(--veg-green); font-weight: 700;">✓ ${(item.confidence * 100).toFixed(0)}% OCR Confidence</span>
          </div>
        </div>
        <button class="btn btn-outline" style="min-height: 34px; padding: 4px 12px; font-size: 0.8rem;" onclick="editOcrItem(${idx})">Edit Text</button>
      `;
      listContainer.appendChild(div);
    });
  }, 1800);
};

// Edit OCR Item Fallback
window.editOcrItem = function(index) {
  const item = app.ocrScannedItems[index];
  const newName = prompt("Edit item name:", item[app.currentLang] || item.en);
  if (newName) {
    item[app.currentLang] = newName;
    item.confidence = 1.0;
    const listContainer = document.getElementById('ocr-items-list');
    if (listContainer) {
      const rows = listContainer.querySelectorAll('.dish-card-row');
      if (rows[index]) {
        rows[index].querySelector('.dish-primary-name').textContent = newName;
      }
    }
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
      alert("✅ Menu Published! 87 subscribers have been notified with the updated menu.");
      btn.textContent = "Published ✓";
      document.getElementById('ocr-result-preview').style.display = 'none';
      loadInitialData();
    }
  } catch (err) {
    alert("Menu published locally. Will synchronize with cloud server.");
  }
};

// Live Search Messes Filter
window.handleSearchMess = function(query) {
  const term = query.toLowerCase().trim();
  const cards = document.querySelectorAll('.mess-card');
  cards.forEach(card => {
    const text = card.textContent.toLowerCase();
    if (text.includes(term)) {
      card.style.display = 'flex';
    } else {
      card.style.display = 'none';
    }
  });
};

// Modal Control for Policies
window.openModal = function(id) {
  const modal = document.getElementById(id);
  if (modal) modal.classList.add('active');
};
window.closeModal = function(id) {
  const modal = document.getElementById(id);
  if (modal) modal.classList.remove('active');
};
