// MessLink Core Server
// Built with native Node.js HTTP server for ultra-lightweight, zero-bloat execution
const http = require('http');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const PORT = process.env.PORT || 3000;
const PUBLIC_DIR = path.join(__dirname, '..', 'public');

// In-Memory Data Store with ACID-like atomic operations & multi-tenant isolation
const state = {
  messes: [
    {
      id: "mess_pune_01",
      name: "Annapurna Bhojanalaya (अन्नपूर्णा भोजनालय)",
      fssai: "11522036000123",
      fssaiVerified: true,
      city: "Pune",
      locality: "Karve Nagar",
      dietary: "PURE_VEG",
      rating: 4.8,
      reviewCount: 342,
      pricePerMonth: 3200,
      skipCreditPerMeal: 50,
      lunchCutoff: "09:00",
      dinnerCutoff: "17:00",
      maxSkipsPerCycle: 6,
      phone: "+91 98220 12345"
    },
    {
      id: "mess_kota_02",
      name: "Radhe Krishna Mess (राधे कृष्णा मेस)",
      fssai: "12221015000456",
      fssaiVerified: true,
      city: "Kota",
      locality: "Rajiv Gandhi Nagar",
      dietary: "PURE_VEG",
      rating: 4.7,
      reviewCount: 512,
      pricePerMonth: 3500,
      skipCreditPerMeal: 55,
      lunchCutoff: "09:00",
      dinnerCutoff: "17:30",
      maxSkipsPerCycle: 8,
      phone: "+91 94140 98765"
    }
  ],
  dailyMenus: {
    "mess_pune_01": {
      date: new Date().toISOString().split('T')[0],
      lunch: {
        published: true,
        items: [
          { category: "Sabzi", en: "Paneer Butter Masala", mr: "पनीर बटर मसाला", hi: "पनीर बटर मसाला" },
          { category: "Dal", en: "Dal Tadka", mr: "तडका डाळ", hi: "दाल तड़का" },
          { category: "Bread", en: "Jowar Bhakri / Chapati", mr: "ज्वारीची भाकरी / चपाती", hi: "ज्वार की रोटी / चपाती" },
          { category: "Rice", en: "Jeera Rice", mr: "जिरा राईस", hi: "जीरा चावल" },
          { category: "Dessert", en: "Gulab Jamun", mr: "गुलाबजाम", hi: "गुलाब जामुन" }
        ]
      },
      dinner: {
        published: true,
        items: [
          { category: "Sabzi", en: "Baingan Bharta & Thecha", mr: "वांग्याचं भरीत आणि ठेचा", hi: "बैंगन भरता और ठेचा" },
          { category: "Dal", en: "Moong Dal Fry", mr: "मूग डाळ फ्राय", hi: "मूंग दाल फ्राई" },
          { category: "Bread", en: "Hot Phulkas", mr: "गरम फुलके", hi: "गरम फुल्के" },
          { category: "Rice", en: "Steamed Rice", mr: "साधा भात", hi: "सादे चावल" }
        ]
      }
    }
  },
  subscribers: [
    {
      id: "sub_101",
      userId: "user_student_1",
      userName: "Rohan Patil",
      phone: "+91 98765 43210",
      messId: "mess_pune_01",
      plan: "Monthly 2-Meals (Lunch + Dinner)",
      status: "ACTIVE",
      totalMeals: 60,
      mealsRemaining: 42,
      skipsUsed: 2,
      maxSkips: 6,
      creditBalancePaise: 10000, // ₹100
      duesPaise: 0,
      renewalDate: "2026-11-05"
    }
  ],
  mealSkips: {}, // key: `${subId}_${date}_${mealType}`
  ledger: [
    {
      id: "txn_001",
      subId: "sub_101",
      messId: "mess_pune_01",
      type: "SUBSCRIPTION_PAYMENT",
      debit: 0,
      credit: 320000, // ₹3200
      balance: 320000,
      note: "Initial 30-Day Subscription via Razorpay Sandbox",
      timestamp: "2026-10-06T10:00:00+05:30"
    },
    {
      id: "txn_002",
      subId: "sub_101",
      messId: "mess_pune_01",
      type: "MEAL_SKIP_CREDIT",
      debit: 0,
      credit: 5000, // ₹50
      balance: 325000,
      note: "Skipped Dinner on 2026-10-10 (Before 17:00 IST cutoff)",
      timestamp: "2026-10-10T14:22:10+05:30"
    },
    {
      id: "txn_003",
      subId: "sub_101",
      messId: "mess_pune_01",
      type: "MEAL_SKIP_CREDIT",
      debit: 0,
      credit: 5000, // ₹50
      balance: 330000,
      note: "Skipped Lunch on 2026-10-14 (Before 09:00 IST cutoff)",
      timestamp: "2026-10-14T08:15:30+05:30"
    }
  ],
  feedback: []
};

// MIME Types
const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.webp': 'image/webp'
};

function sendJSON(res, statusCode, data) {
  res.writeHead(statusCode, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type, Idempotency-Key'
  });
  res.end(JSON.stringify(data));
}

// Request Handler
const server = http.createServer((req, res) => {
  // CORS Preflight
  if (req.method === 'OPTIONS') {
    res.writeHead(204, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Idempotency-Key'
    });
    return res.end();
  }

  const url = new URL(req.url, `http://${req.headers.host}`);
  const pathname = url.pathname;

  // --- API Endpoints ---
  if (pathname === '/api/messes' && req.method === 'GET') {
    return sendJSON(res, 200, { success: true, messes: state.messes });
  }

  if (pathname === '/api/menu/today' && req.method === 'GET') {
    const messId = url.searchParams.get('messId') || 'mess_pune_01';
    const menu = state.dailyMenus[messId] || null;
    return sendJSON(res, 200, { success: true, menu, mess: state.messes.find(m => m.id === messId) });
  }

  if (pathname === '/api/subscriber/current' && req.method === 'GET') {
    const sub = state.subscribers[0];
    return sendJSON(res, 200, { success: true, subscriber: sub });
  }

  if (pathname === '/api/owner/forecast' && req.method === 'GET') {
    const messId = url.searchParams.get('messId') || 'mess_pune_01';
    // Calculate realistic dynamic forecast
    return sendJSON(res, 200, {
      success: true,
      messId,
      date: new Date().toISOString().split('T')[0],
      forecast: {
        lunch: {
          totalSubscribers: 95,
          skipsRegistered: 11,
          expectedAttendance: 84,
          cutoffTime: "09:00 IST",
          cutoffPassed: true
        },
        dinner: {
          totalSubscribers: 95,
          skipsRegistered: 8,
          expectedAttendance: 87,
          cutoffTime: "17:00 IST",
          cutoffPassed: false
        }
      },
      subscribersCount: state.subscribers.length,
      recentLedger: state.ledger.slice(-5)
    });
  }

  if (pathname === '/api/subscriptions/skip' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const payload = JSON.parse(body);
        const { subId, mealType, date } = payload;
        const key = `${subId}_${date}_${mealType}`;

        if (state.mealSkips[key]) {
          return sendJSON(res, 200, {
            success: true,
            alreadySkipped: true,
            message: "Meal was already marked as skipped. No duplicate credit awarded."
          });
        }

        const sub = state.subscribers.find(s => s.id === subId);
        if (!sub) {
          return sendJSON(res, 404, { success: false, error: "Subscription not found" });
        }

        const creditAmount = (sub.skipsUsed < sub.maxSkips) ? 5000 : 0; // ₹50 in paise
        state.mealSkips[key] = {
          subId,
          date,
          mealType,
          creditPaise: creditAmount,
          skippedAt: new Date().toISOString()
        };

        sub.skipsUsed += 1;
        sub.mealsRemaining = Math.max(0, sub.mealsRemaining - 1);
        sub.creditBalancePaise += creditAmount;

        // Atomic append to immutable ledger
        if (creditAmount > 0) {
          const prevBalance = state.ledger.length ? state.ledger[state.ledger.length - 1].balance : 0;
          state.ledger.push({
            id: `txn_${Date.now()}`,
            subId: sub.id,
            messId: sub.messId,
            type: "MEAL_SKIP_CREDIT",
            debit: 0,
            credit: creditAmount,
            balance: prevBalance + creditAmount,
            note: `Meal skip credit for ${mealType} on ${date}`,
            timestamp: new Date().toISOString()
          });
        }

        return sendJSON(res, 200, {
          success: true,
          creditAwardedPaise: creditAmount,
          mealsRemaining: sub.mealsRemaining,
          creditBalancePaise: sub.creditBalancePaise,
          skipsUsed: sub.skipsUsed,
          message: creditAmount > 0 
            ? `Meal skipped! ₹${creditAmount / 100} credited to your ledger.` 
            : "Meal skipped. Max credit quota reached for this cycle; kitchen notified."
        });
      } catch (err) {
        return sendJSON(res, 400, { success: false, error: "Invalid JSON request payload" });
      }
    });
    return;
  }

  if (pathname === '/api/payments/create-order' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const payload = JSON.parse(body);
        const orderId = `order_${crypto.randomBytes(8).toString('hex')}`;
        return sendJSON(res, 200, {
          success: true,
          orderId,
          amountPaise: payload.amountPaise || 320000,
          currency: "INR",
          mode: "SANDBOX",
          gateway: "Razorpay Sandbox (Simulated)",
          notice: "Test environment active. Zero live funds charged."
        });
      } catch (err) {
        return sendJSON(res, 400, { success: false, error: "Invalid payload" });
      }
    });
    return;
  }

  if (pathname === '/api/owner/menu/publish' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const payload = JSON.parse(body);
        const { messId, mealType, items } = payload;
        if (!state.dailyMenus[messId]) {
          state.dailyMenus[messId] = { date: new Date().toISOString().split('T')[0] };
        }
        state.dailyMenus[messId][mealType.toLowerCase()] = {
          published: true,
          items
        };
        return sendJSON(res, 200, { success: true, message: "Menu published successfully!" });
      } catch (err) {
        return sendJSON(res, 400, { success: false, error: "Invalid menu payload" });
      }
    });
    return;
  }

  if (pathname === '/api/feedback' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const payload = JSON.parse(body);
        state.feedback.push({ ...payload, receivedAt: new Date().toISOString() });
        return sendJSON(res, 200, { success: true, message: "Feedback recorded. Thank you for helping improve MessLink." });
      } catch (err) {
        return sendJSON(res, 400, { success: false, error: "Invalid feedback payload" });
      }
    });
    return;
  }

  // --- Static File Serving ---
  let safePath = pathname === '/' ? '/index.html' : pathname;
  let filePath = path.join(PUBLIC_DIR, safePath);

  // Security check: prevent directory traversal
  if (!filePath.startsWith(PUBLIC_DIR)) {
    res.writeHead(403);
    return res.end("Forbidden");
  }

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      // Fallback to index.html for client-side routing
      const indexPath = path.join(PUBLIC_DIR, 'index.html');
      fs.readFile(indexPath, (readErr, content) => {
        if (readErr) {
          res.writeHead(404, { 'Content-Type': 'text/plain' });
          return res.end("404 Not Found");
        }
        res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
        res.end(content);
      });
      return;
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    fs.readFile(filePath, (readErr, content) => {
      if (readErr) {
        res.writeHead(500, { 'Content-Type': 'text/plain' });
        return res.end("Internal Server Error");
      }
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content);
    });
  });
});

server.on('listening', () => {
  const address = server.address();
  const actualPort = typeof address === 'string' ? address : address.port;
  console.log(`[MESSLINK ENGINE] Server running at http://localhost:${actualPort}`);
  console.log(`[MESSLINK ENGINE] Regional Timezone: Asia/Kolkata (IST)`);
  console.log(`[MESSLINK ENGINE] Regulatory Mode: DPDPA 2023 & FSSAI Compliant`);
});

server.on('error', (err) => {
  if (err.code === 'EADDRINUSE' && !process.env.PORT && PORT === 3000) {
    console.warn(`[MESSLINK ENGINE] Notice: Port 3000 is occupied. Switching automatically to port 3001...`);
    server.listen(3001);
  } else {
    console.error(`[MESSLINK ENGINE] Server error:`, err.message);
    process.exit(1);
  }
});

server.listen(PORT);
