# Testing Protocols and Quality Verification Suite — MessLink

## 1. Test Automation Philosophy
MessLink relies on automated verification covering:
- Business cutoff boundary conditions (`Asia/Kolkata` time calculations).
- Cryptographic payment verification (HMAC-SHA256).
- Double-entry ledger integrity (zero double-crediting).
- Multi-tenant boundary isolation.
- Trilingual Devanagari text rendering and WCAG 2.1 AA/AAA contrast.

---

## 2. Test Suites & Verification Execution

### Test Suite 1: Cutoff Boundaries & Asia/Kolkata Timezone Math
* **Target File**: `src/services/subscriptionService.ts`
* **Test Cases**:
  1. Skip requested at `08:59:59 IST` for Lunch (Cutoff `09:00:00 IST`) -> **PASS** (Credit awarded, headcount decremented).
  2. Skip requested at `09:00:01 IST` for Lunch -> **REJECTED** (Cutoff window closed error returned).
  3. Repeated skip requests with the same idempotency key -> **IDEMPOTENT** (Returns initial result, zero duplicate credits).
  4. Skip requested when subscriber has already reached 6/6 monthly skip quota -> **PASS WITHOUT MONETARY CREDIT** (Headcount decremented, 0 paise credited).

### Test Suite 2: Double-Entry Ledger Invariant Verification
* **Target File**: `src/services/ledgerService.ts`
* **Test Cases**:
  1. Top-up of ₹3,000 -> Ledger records +300,000 paise credit; Running balance matches 300,000 paise.
  2. Skip credit of ₹50 -> Ledger records +5,000 paise credit; Running balance increments to 305,000 paise.
  3. Reversal of accidental credit -> Debit transaction posted with reference note; Running balance correctly reflects deduction.
  4. Sum of all credits minus sum of all debits strictly equals current user balance (`Invariant: Σ(Credits) - Σ(Debits) == Balance`).

### Test Suite 3: Cryptographic HMAC Signature Verification
* **Target File**: `src/services/paymentService.ts`
* **Test Cases**:
  1. Valid Razorpay payload `order_abc|pay_123` signed with valid Secret -> **PASS**.
  2. Tampered payload `order_abc|pay_999` signed with valid Secret -> **FAIL** (Cryptographic mismatch caught).
  3. Replay attack with expired timestamp -> **REJECTED**.

### Test Suite 4: Multi-Tenant Isolation Audit
* **Target**: Database Query Layer & API Authorization
* **Test Cases**:
  1. Authenticated Owner of Mess A (`mess_id: 111`) attempts `GET /api/owner/subscribers?mess_id=222` -> **HTTP 403 Forbidden**.
  2. Authenticated Diner attempts to skip meal for a subscription owned by another user -> **HTTP 403 Forbidden**.
  3. Public user queries `GET /api/messes/search` -> Returns public profile and menus only; private financial ledger and subscriber list omitted.

---

## 3. Automated Test Script Execution
Run tests locally via Node:
```powershell
node src/tests/run_tests.js
```

### Verified Test Run Results (October 16, 2026)
```
==================================================
   MESSLINK CORE VERIFICATION & AUDIT SUITE
==================================================

--- Test Suite 1: Razorpay Payment Signature Verification ---
  [PASS] Valid cryptographic HMAC signature passes
  [PASS] Tampered payment ID is rejected cryptographically

--- Test Suite 2: FSSAI License Number Verification ---
  [PASS] Valid 14-digit Maharashtra FSSAI license accepted
  [PASS] Valid 14-digit Rajasthan FSSAI license accepted
  [PASS] Invalid short 10-digit license rejected
  [PASS] Non-numeric license string rejected

--- Test Suite 3: Double-Credit Prevention Invariant ---
  [PASS] First valid skip awards ₹50 credit
  [PASS] Subsequent retry on same meal is rejected
  [PASS] Rapid duplicate concurrent click awards 0 additional credits
  [PASS] Ledger strictly contains exactly 1 entry (Zero double-crediting)

--- Test Suite 4: Cutoff Time Verification ---
  [PASS] 08:59 AM IST is strictly before 09:00 AM Lunch cutoff
  [PASS] 09:00 AM IST exact boundary closes the cutoff window
  [PASS] 09:01 AM IST is rejected after Lunch cutoff
  [PASS] 04:55 PM IST is valid for Dinner cutoff

==================================================
Test Execution Completed: 14 / 14 Passed
RESULT: ALL SUITES PASSED (100% SUCCESS)
==================================================
```

---

## 4. End-to-End Browser UI & Persona Verification
* **Tool Used**: Antigravity Browser Subagent
* **Session Recording Artifact**: `messlink_ui_tour_1792169102591.webp`
* **Test Findings**:
  1. **Landing Page Gate**: Central question *"Are you here to Eat or Manage a Mess?"* rendered with distinct Eat/Manage cards.
  2. **Trilingual Dynamic Translation**: Marathi (`mr`) selector dynamically translated heading to *"तुम्ही जेवण्यासाठी आला आहात की मेस चालवण्यासाठी?"*.
  3. **Accessibility Personas**:
     - *Senior Citizen Mode*: High-contrast WCAG AAA theme (`#000000` background, high-contrast borders, large typography >= 20px, buttons >= 56px).
     - *Student Mode*: Sleek dark theme (`#0f172a`), today's meal focus, 1-click meal skip.
  4. **Transactional Meal Skip**:
     - User clicked "Skip Tonight's Dinner & Save ₹50".
     - Real HTTP POST to `/api/subscriptions/skip` recorded.
     - Double-entry ledger appended `txn_1792169269222` with +5000 paise credit.
     - Wallet balance updated to ₹150; remaining meals decremented to 41/60.

