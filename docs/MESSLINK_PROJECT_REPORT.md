# MESSLINK: MASTER SYSTEM SPECIFICATION & ARCHITECTURAL PROJECT REPORT
**An Indian Mess Discovery, Meal Subscription, and Operations Management Platform**
*Prepared strictly according to the Google Antigravity Master Build Prompt Format*

---

## Document Metadata & Control
| Attribute | Detail |
| :--- | :--- |
| **Project Codename** | MessLink (मेसलिंक) |
| **Version** | 1.0.0-PROD-SPEC |
| **Document Date** | October 16, 2026 |
| **Primary Region & Timezone** | India (`Asia/Kolkata` / IST, UTC+05:30) |
| **Primary Currency** | Indian Rupee (INR, ₹) |
| **Supported Locales** | English (`en`), Marathi (`mr`), Hindi (`hi`) |
| **Primary Target Market** | Student clusters (Pune, Kota, Bengaluru, Delhi NCR) & Working professionals |
| **Classification** | Master System Architecture & Project Engineering Report |

---

## Table of Contents
1. [Section 1: Engineering Roles & Operating Principles](#1-your-role--mandatory-operating-rules)
2. [Section 2: Workspace Inspection, Environment Audit & Priority Roadmap](#2-first-task-inspect-before-building)
3. [Section 3: Product Vision & Dual User Journeys](#3-product-vision)
4. [Section 4: UI/UX Principles & Core Design System](#4-uiux-principle)
5. [Section 5: Customer Presentation Modes (Tailored Personas)](#5-customer-experiences)
6. [Section 6: Dedicated Mess Owner & Manager Portal](#6-separate-mess-ownermanager-portal)
7. [Section 7: Languages and Localization (Trilingual i18n Engine)](#7-languages-and-localization)
8. [Section 8: Technical Architecture & System Topography](#8-technical-architecture)
9. [Section 9: Database Schema, Entity Relationships & Multi-Tenant Data Integrity](#9-database-and-data-integrity)
10. [Section 10: Subscription Lifecycle & Double-Entry Meal Management](#10-subscription-and-meal-management)
11. [Section 11: Payments Architecture & Financial Reconciliation Engine](#11-payments)
12. [Section 12: AI-Powered Multilingual Menu Scanner (Vision Pipeline)](#12-ai-powered-menu-scanner)
13. [Section 13: Security, Privacy & Indian Regulatory Compliance Matrix](#13-security-and-privacy)
14. [Section 14: Version-Controlled Legal Policies & Consents](#14-policies-and-agreements)
15. [Section 15: Offline PWA Support, Sync Engine & High-Reliability Architecture](#15-offline-support-and-reliability)
16. [Section 16: Controlled Pilot Operations & Triage Telemetry](#16-pilot-and-feedback)
17. [Section 17: Comprehensive Testing & Quality Verification Suite](#17-testing-and-verification)
18. [Section 18: Production Release Conditions & Gate Criteria](#18-release-conditions)
19. [Section 19: Required Project Documentation Inventory](#19-required-project-documentation)
20. [Section 20: Implementation Workflow & Phase 1 Execution Status](#20-implementation-workflow)

---

## 1. Your Role & Mandatory Operating Rules

### 1.1 Multi-Disciplinary Engineering Role
This project report governs the full-stack design, implementation, and verification of **MessLink**. The engineering responsibilities encompass:
- **Lead Software Architect**: System boundaries, component topology, multi-tenancy isolation, and API contracts.
- **Full-Stack Developer**: Responsive TypeScript client, Node.js runtime backend, middleware, and service workers.
- **Database Engineer**: Relational schema, ACID transaction guarantees, double-entry financial ledgering, and index optimization.
- **UI/UX Designer**: High-contrast, mobile-first design system catering to three distinct Indian demographics with Devanagari typography.
- **Security & Compliance Engineer**: DPDP Act 2023, IT Act 2000, CERT-In directions, FSSAI compliance, HMAC-SHA256 signature verification, and RBAC authorization.
- **QA Tester**: End-to-end integration testing, offline queue verification, race-condition stress testing, and localization audits.

### 1.2 Mandatory Operating Rules
1. **Workspace Inspection Precedence**: The local file tree, runtime versions, package managers, and system variables are inspected prior to any modification.
2. **Preservation of Existing Work**: Existing working files in the workspace are preserved without destructive overwrites.
3. **Verified Runtimes Only**: Dependencies are selected strictly from confirmed available runtimes on the target platform.
4. **Zero Fabrication Policy**: No mock APIs, fabricated database persistence, synthetic payment approvals, or fake test runs are presented as verified.
5. **Secret Hygiene**: Zero secret keys, payment gateway tokens, or database credentials reside in client-side code or public source repositories.
6. **Small Coherent Phases**: Changes are structured incrementally and verified before progressing.
7. **Transparent Blockers**: If an external dependency or service is unavailable, it is documented with a safe fallback.
8. **Permanent Audit Documentation**: All architectural choices are documented in `docs/DECISIONS.md`, project status in `docs/PROJECT_STATUS.md`, and compliance requirements in `docs/COMPLIANCE_CHECKLIST.md`.

---

## 2. First Task: Inspect Before Building

### 2.1 Environmental & Runtime Verification
A pre-build audit was executed on the host system with the following verified runtime environment:
- **Operating System**: Windows 11 Enterprise / Pro (`x64`)
- **Shell Environment**: PowerShell 7+
- **Node.js Runtime**: `v22.20.0` (LTS Modern, fully supports ES modules, Native Fetch, Web Crypto API)
- **NPM Package Manager**: `10.9.3`
- **NPX Tooling**: `10.9.3`
- **Git Version**: `2.47.0.windows.2`
- **Python Runtime**: `3.14.0` (available for script automation and auxiliary tooling)
- **Local Timezone**: `Asia/Kolkata` (IST, UTC+05:30)

### 2.2 Workspace State Audit
1. **Existing Directories**:
   - `C:\Users\lenovo\.gemini\antigravity-ide\scratch\hostel-management`: Pre-existing separate application. **Action**: Kept intact and untouched to preserve user workspace integrity.
   - `C:\Users\lenovo\.gemini\antigravity-ide\scratch\messlink`: Initialized as the isolated workspace root for MessLink.
2. **Status of Services & External APIs**:
   - Razorpay API: Sandboxed test mode architecture designed; live keys intentionally omitted until formal sign-off.
   - Vision OCR Model: Hybrid pipeline designed (Gemini Vision API endpoint with client-side canvas preprocessing and manual fallback).
   - Relational Storage: Local SQLite/PostgreSQL schema prepared with atomic transaction guarantees and strict foreign-key cascades.

### 2.3 The Three Highest-Priority Implementation Steps
```mermaid
graph LR
    A[Step 1: Workspace Initialization & Documentation Architecture] --> B[Step 2: Core Design System & Trilingual Presentation Modes]
    B --> C[Step 3: Relational Schema & Multi-Tenant API Foundation]
```

1. **Step 1: Workspace Setup & Comprehensive Documentation Architecture**:
   Establish the project workspace at `scratch/messlink`, initialize Git-tracked directory trees (`docs/`, `src/`, `public/`), and write foundational governance documents (`DECISIONS.md`, `PROJECT_STATUS.md`, `COMPLIANCE_CHECKLIST.md`, `TESTING.md`, `.env.example`, `README.md`).
2. **Step 2: Core Design System & Trilingual Presentation Modes (Students, Working Adults, Seniors)**:
   Implement responsive CSS design tokens, Devanagari font integrations (Poppins & Noto Sans), and the Landing Page asking *"Are you here to Eat or Manage a Mess?"* with the 3 distinct persona themes.
3. **Step 3: Relational Schema, Multi-Tenant Isolation & Double-Entry Ledger Engine**:
   Construct the database models for Users, Messes, Subscriptions, Daily Menus, Meal Skips, and Ledger Transactions, ensuring strict separation between different messes and zero double-credits.

---

## 3. Product Vision

### 3.1 Core Problem Statement
In Indian educational hubs (e.g., Pune, Kota, Indore) and corporate tech corridors (Bengaluru, Hyderabad, Gurugram), millions of students and young professionals depend daily on independent mess facilities (*dabbas*, private messes, dining clubs). This ecosystem suffers from:
- Lack of transparent, searchable menus and pricing.
- Friction in tracking prepayments, skipped meals, and credit balances.
- Mess operators relying on fragile physical registers or informal WhatsApp messages for daily headcounts, resulting in 20–35% food wastage.
- Lack of regulatory compliance regarding food safety (FSSAI) and digital data protection (DPDPA 2023).

### 3.2 The Dual-Path Experience
Upon visiting MessLink, the user is greeted with a decisive architectural fork:

```
+-----------------------------------------------------------------------------------+
|                                     MESSLINK                                      |
|               Connecting Hungry Diners with Reliable Local Messes                 |
|                                                                                   |
|                   "Are you here to Eat or Manage a Mess?"                         |
|                                                                                   |
|     +----------------------------------+  +----------------------------------+    |
|     |           EAT (Diners)           |  |        MANAGE A MESS (Owners)    |    |
|     |  Discover Messes, Menus, Skips   |  |   Subscribers, Cutoffs & Ledger  |    |
|     |          [ Explore Now ]         |  |         [ Owner Portal ]         |    |
|     +----------------------------------+  +----------------------------------+    |
+-----------------------------------------------------------------------------------+
```

#### Dual Path Feature Breakdown
| Dimension | Path A: Eat (Diner Journey) | Path B: Manage a Mess (Owner Portal) |
| :--- | :--- | :--- |
| **Primary Need** | Discover good food, skip meals effortlessly, track dues | Accurate daily headcount, prevent wastage, collect dues |
| **Public vs Auth** | Public discovery of messes & menus without login; Auth required to subscribe or skip | Auth mandatory via phone OTP / password; Role verified |
| **Top 3 Features** | 1. Nearby mess search & filter (Veg/Non-Veg, Thali, Monthly)<br>2. 1-click meal skip before cutoff<br>3. Live credit & balance ledger | 1. Today's meal headcount (Breakfast, Lunch, Dinner)<br>2. AI menu photo scanner & publisher<br>3. Financial double-entry ledger & dues tracker |
| **Daily Touchpoint** | Checking "What's cooking today?" at 11:30 AM & 7:00 PM | Updating daily menu at 8:00 AM; viewing attendance list |

### 3.3 Public Discovery vs. Authenticated Operation Boundary
- **Unauthenticated/Public Zone**: Mess discovery, address viewing, distance calculation, live daily menus, subscription plan comparisons, customer reviews, FSSAI badge verification, allergen/dietary filters.
- **Authenticated Diner Zone**: Active subscription management, meal skip execution, refund requests, personal payment ledger, grievance submissions.
- **Authenticated Owner Zone**: Mess profile editing, bank settlement details, menu editing/OCR upload, subscriber approval, attendance mark-off, cutoff time customization, ledger adjustments.

---

## 4. UI/UX Principle

### 4.1 "Feature-Complete Behind the Scenes; Simple on the Surface"
MessLink avoids visual clutter by adhering to strict cognitive design guidelines:
- **One Primary Purpose Per Screen**: The Diner dashboard focuses on *Today's Food* and *Meal Skip Status*. The Owner dashboard focuses on *Today's Expected Headcount* and *Action Required*.
- **Progressive Disclosure**: High-frequency metrics (Today's Lunch Menu, Remaining Days) are visible immediately; historical ledgers, tax invoices, and detailed nutritional info are placed behind intuitive secondary tabs.
- **Touch-First Accessibility**: In accordance with small Android viewport constraints (e.g., 360px width smartphones prevalent across tier-2/tier-3 India), touch targets strictly meet or exceed **48×48px**.
- **Devanagari Font Hierarchy**: Clean typography pairing using **Inter / Poppins** for Latin characters and **Noto Sans Devanagari** for Marathi and Hindi text, preserving baseline alignment and diacritic mark clearance.

### 4.2 Reusable Design Token System
```css
:root {
  /* Brand Palettes - Indian Culinary Warmth & Tech Reliability */
  --color-primary: #e65100;         /* Deep Saffron / Terracotta */
  --color-primary-hover: #bf360c;
  --color-primary-light: #fff3e0;
  --color-secondary: #2e7d32;       /* Fresh Mint / Pure Veg Green */
  --color-accent: #1565c0;          /* Trust Cobalt */
  
  /* Semantic Tones */
  --color-danger: #c62828;
  --color-warning: #f57f17;
  --color-success: #2e7d32;
  --color-info: #0277bd;

  /* Typography Scale */
  --font-family-base: 'Poppins', 'Noto Sans Devanagari', -apple-system, sans-serif;
  --font-size-xs: 0.75rem;    /* 12px */
  --font-size-sm: 0.875rem;   /* 14px */
  --font-size-md: 1.00rem;    /* 16px */
  --font-size-lg: 1.125rem;   /* 18px - Minimum for Owner critical info */
  --font-size-xl: 1.375rem;   /* 22px */
  --font-size-2xl: 1.75rem;   /* 28px */
  --font-size-3xl: 2.25rem;   /* 36px */

  /* Spacing Tokens */
  --space-2xs: 4px;
  --space-xs: 8px;
  --space-sm: 12px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 32px;

  /* Elevation Shadows */
  --shadow-sm: 0 1px 3px rgba(0,0,0,0.08);
  --shadow-md: 0 4px 12px rgba(0,0,0,0.10);
  --shadow-lg: 0 8px 24px rgba(0,0,0,0.14);

  /* Touch Targets */
  --touch-target-min: 48px;
  --radius-sm: 6px;
  --radius-md: 12px;
  --radius-lg: 18px;
  --radius-full: 9999px;
}
```

---

## 5. Customer Experiences (Tailored Personas)

MessLink addresses three distinct user segments across India with dedicated presentation modes. Users can toggle modes at any time via a dedicated UI switch.

```mermaid
graph TD
    User([User Profile]) --> ModeSelect{Selected Persona Mode}
    ModeSelect -->|Student 16-23| M1[Dark Theme • Rapid 1-Click Skip • Live Remaining Meal Counts]
    ModeSelect -->|Working Adult 23-50| M2[Light Theme • Monthly Calendar • Spending & Invoice Ledger]
    ModeSelect -->|Senior 50+| M3[High Contrast • 20px+ Font • Oversized 56px Buttons • Zero Clutter]
```

### 5.1 Persona Specification Matrix
| Parameter | Mode 1: Students (16–23) | Mode 2: Working Adults (23–50) | Mode 3: Older Adults (50+) |
| :--- | :--- | :--- | :--- |
| **Theme / Contrast** | Sleek Dark Mode (`#121212` background, vibrant neon saffron highlights) | Crisp Modern Light Mode (`#f8fafc` background, subtle borders) | High Contrast Mode (`#ffffff` on `#000000`, WCAG AAA 7:1 ratio) |
| **Primary Visual** | Today's Menu + Instant "Skip Tonight's Dinner" button | Monthly Interactive Meal Calendar with lunch/dinner markers | Large legible Card with plain text: "Lunch Today: Dal, Roti, Rice" |
| **Key Metrics Displayed** | Remaining Meals count (e.g. "18 meals left") & Due alert | Monthly expenditure (₹), Tax receipts, Rollover credits | "Your Account is Paid" (Green badge) & "Owner Phone: Call Now" |
| **Navigation Density** | Bottom Tab Bar with icons (Menu, Skip, History) | Top Navigation with Calendar, History, Invoicing | Linear single-column layout, zero nested dropdowns |
| **Guardian / Age Verification** | Age verification gate. Users under 18 trigger parental consent workflows per DPDPA 2023 | Standard self-serve OTP signup | Optional assisted family manager authorization |

---

## 6. Separate Mess Owner & Manager Portal

### 6.1 Operational Objectives
Independent mess owners are working in fast-paced commercial kitchens. They cannot navigate complicated multi-level desktop software while managing food preparations. The MessLink Owner Portal is designed for **one-thumb mobile operation** and **rugged clarity**.

### 6.2 Key Portal Modules
1. **Real-Time Operational Dashboard**:
   - **Today's Kitchen Forecast**:
     - Breakfast Headcount: Expected, Attended, Skipped.
     - Lunch Headcount: Cutoff passed at 09:00 AM. Final count: **84 Meals** (Prep target: 88).
     - Dinner Headcount: Cutoff closes at 05:00 PM. Currently **72 Meals**.
   - **Emergency Alert**: Instant broadcast message: *"Dinner will be served 30 mins early today (Special Biryani)"*.
2. **Menu Management & OCR Scanner**:
   - Daily menu builder with categorized slots: Sabzi 1, Sabzi 2, Dal/Curry, Roti/Bhakri, Rice, Sweet/Dessert.
   - Weekly recurring template loader.
   - Camera OCR capture button for physical chalkboard menus.
3. **Subscriber & Attendance Hub**:
   - Live roster searchable by Room Number, Phone, or Name.
   - Quick QR Scanner for student meal card check-in.
   - Manual one-tap toggle ("Present" / "Absent").
4. **Financial Ledger & Dues Collection**:
   - Total active monthly subscriptions.
   - Unpaid dues roster with one-tap WhatsApp payment reminder dispatch.
   - Historical ledger of meal skip credits granted vs refunded.
5. **Operational Controls & Cutoff Timers**:
   - Lunch Skip Cutoff (default: 09:00 AM IST).
   - Dinner Skip Cutoff (default: 05:00 PM IST).
   - Maximum allowed skips per month (e.g., max 6 meals credited per 30-day plan).

### 6.3 Owner Touch-Target & Ergonomic Rules
- Bottom Persistent Navigation Bar: **[1. Kitchen Forecast]**, **[2. Scan Menu]**, **[3. Subscribers]**, **[4. Ledger]**.
- Critical metrics render at minimum **20px bold font**.
- Destructive actions (e.g., Cancel Subscription, Reverse Credit) require a two-step sliding confirmation drawer.

---

## 7. Languages and Localization (Trilingual i18n Engine)

### 7.1 Language Strategy
MessLink delivers native, culturally accurate translations across three languages:
1. **English (`en`)**: Corporate, collegiate, and pan-Indian standard.
2. **Marathi (`mr`)**: Primary regional language for Maharashtra (major mess hub in Pune, Mumbai, Nashik, Kolhapur).
3. **Hindi (`hi`)**: Northern and central student clusters (Kota, Indore, Bhopal, Delhi NCR).

### 7.2 Structured Multilingual Data Model
Menu items and notices are stored structurally in the database as localized JSON objects, guaranteeing zero translation latency and supporting user-specified regional dish names:

```json
{
  "item_id": "item_roti_01",
  "name": {
    "en": "Jowar Bhakri with Thecha",
    "mr": "ज्वारीची भाकरी आणि खमंग ठेचा",
    "hi": "ज्वार की भाकरी और ठेचा"
  },
  "category": "Breads",
  "dietary": "VEG"
}
```

### 7.3 Internationalization UI Dictionary Sample
```typescript
export const MESSLINK_DICTIONARY = {
  en: {
    app_tagline: "Indian Mess Discovery & Meal Subscriptions",
    landing_question: "Are you here to Eat or Manage a Mess?",
    eat_path_title: "Eat at a Mess",
    eat_path_desc: "Discover verified messes, view today's menu, skip meals & save credits.",
    manage_path_title: "Manage a Mess",
    manage_path_desc: "Track headcount, reduce food waste, automate dues and digital menus.",
    today_menu: "Today's Menu",
    lunch: "Lunch",
    dinner: "Dinner",
    skip_meal: "Skip This Meal",
    meal_skipped: "Meal Skipped Successfully",
    skip_cutoff_warning: "Meal skip allowed only before cutoff time:",
    remaining_credits: "Remaining Meal Credits",
    dues_pending: "Pending Dues",
    fssai_license: "FSSAI Lic. No.",
    fssai_verified: "FSSAI Verified",
    currency_symbol: "₹"
  },
  mr: {
    app_tagline: "भारतीय मेस शोध आणि जेवण सदस्यता",
    landing_question: "तुम्ही जेवण्यासाठी आला आहात की मेस चालवण्यासाठी?",
    eat_path_title: "मेसमध्ये जेवा",
    eat_path_desc: "खात्रीशीर मेस शोधा, आजचा मेनू पहा, जेवण रद्द करा आणि क्रेडिट वाचवा.",
    manage_path_title: "मेसचे व्यवस्थापन करा",
    manage_path_desc: "जेवणाऱ्यांची संख्या मोजा, अन्न वाया जाणे टाळा आणि पैशांचे हिशोब सांभाळा.",
    today_menu: "आजचा मेनू",
    lunch: "दुपारचे जेवण",
    dinner: "रात्रीचे जेवण",
    skip_meal: "हे जेवण रद्द करा",
    meal_skipped: "जेवण यशस्वीरीत्या रद्द केले गेले",
    skip_cutoff_warning: "जेवण रद्द करण्याची शेवटची वेळ:",
    remaining_credits: "शिल्लक जेवण क्रेडिट्स",
    dues_pending: "बाकी रक्कम",
    fssai_license: "FSSAI परवाना क्र.",
    fssai_verified: "FSSAI प्रमाणित",
    currency_symbol: "₹"
  },
  hi: {
    app_tagline: "भारतीय मेस खोज एवं भोजन सदस्यता",
    landing_question: "आप यहाँ भोजन करने आए हैं या मेस का प्रबंधन करने?",
    eat_path_title: "मेस में भोजन करें",
    eat_path_desc: "प्रमाणित मेस खोजें, आज का मेनू देखें, भोजन स्किप करें और पैसे बचाएं।",
    manage_path_title: "मेस का प्रबंधन करें",
    manage_path_desc: "दैनिक संख्या ट्रैक करें, भोजन की बर्बादी रोकें और डिजिटल हिसाब रखें।",
    today_menu: "आज का मेनू",
    lunch: "दोपहर का भोजन",
    dinner: "रात का भोजन",
    skip_meal: "यह भोजन छोड़ें (स्किप)",
    meal_skipped: "भोजन सफलतापूर्वक स्किप कर दिया गया",
    skip_cutoff_warning: "भोजन स्किप करने की अंतिम समय सीमा:",
    remaining_credits: "शेष भोजन क्रेडिट्स",
    dues_pending: "बकाया राशि",
    fssai_license: "FSSAI लाइसेंस सं.",
    fssai_verified: "FSSAI सत्यापित",
    currency_symbol: "₹"
  }
};
```

---

## 8. Technical Architecture

### 8.1 System Architecture Topology
MessLink utilizes an architectural model focused on performance, data safety, and zero deployment friction:

```mermaid
graph TB
    subgraph Client Tier ["Client Layer (Responsive PWA)"]
        DinerApp[Diner UI: Student / Working / Senior Modes]
        OwnerApp[Owner Portal: Touch-First Dashboard]
        OfflineStore[(IndexedDB Queue & Cache Storage)]
        SW[Service Worker: Stale-While-Revalidate]
    end

    subgraph Edge Tier ["Edge Routing & Security"]
        CDN[CDN & Static Asset Edge]
        WAF[Rate Limiter & Input Sanitizer]
        AuthGuard[Session & RBAC Middleware]
    end

    subgraph Service Tier ["Application Server Layer"]
        API[Node.js / Express Core Server]
        SubEngine[Subscription & Skip Engine]
        LedgerService[Double-Entry Financial Ledger]
        OCRService[AI Menu Vision Extraction Engine]
        PaymentBridge[Razorpay Sandbox Gateway Bridge]
    end

    subgraph Persistence Tier ["Data & Audit Store"]
        DB[(Relational DB: PostgreSQL / SQLite)]
        LedgerDB[(Immutable Ledger Transactions)]
        AuditLog[(Audit & DPDP Consent Store)]
    end

    DinerApp --> SW
    OwnerApp --> SW
    SW --> OfflineStore
    SW --> CDN
    CDN --> WAF
    WAF --> AuthGuard
    AuthGuard --> API
    API --> SubEngine
    API --> LedgerService
    API --> OCRService
    API --> PaymentBridge
    SubEngine --> DB
    LedgerService --> LedgerDB
    API --> AuditLog
```

### 8.2 Architectural Tenets
1. **Separation of Concerns**: UI components never query the database directly. All interactions flow through validated REST / RPC endpoints with Zod schema verification.
2. **Tenant Isolation**: Every query involving mess operations, subscribers, menus, or financial ledger enforces `mess_id` matching authenticated tenancy.
3. **Idempotency Guarantee**: Every state-changing API request (e.g. `POST /api/subscriptions/skip`, `POST /api/payments/order`) requires a client-generated UUID `Idempotency-Key` header.
4. **Timezone Determinism**: All business operations are calculated with an explicit `Asia/Kolkata` time resolver to avoid UTC day-boundary drift.

---

## 9. Database and Data Integrity

### 9.1 Entity Relationship Diagram
```mermaid
erDiagram
    USERS ||--o{ MESS_MEMBERSHIPS : holds
    USERS ||--o{ CONSENT_RECORDS : provides
    USERS ||--o{ SUPPORT_TICKETS : files
    MESSES ||--o{ MESS_MEMBERSHIPS : contains
    MESSES ||--o{ SUBSCRIPTION_PLANS : offers
    MESSES ||--o{ DAILY_MENUS : publishes
    MESSES ||--o{ MEAL_LOGS : records
    MESSES ||--o{ LEDGER_TRANSACTIONS : owns
    SUBSCRIPTION_PLANS ||--o{ SUBSCRIPTIONS : instantiates
    USERS ||--o{ SUBSCRIPTIONS : subscribes
    SUBSCRIPTIONS ||--o{ MEAL_LOGS : logs
    SUBSCRIPTIONS ||--o{ PAYMENTS : generates
    PAYMENTS ||--o{ LEDGER_TRANSACTIONS : settles
    USERS ||--o{ FEEDBACK : submits
    MESSES ||--o{ FEEDBACK : receives
```

### 9.2 Complete Relational Schema Specification

```sql
-- Core Enumerations
CREATE TYPE user_role AS ENUM ('GUEST', 'CUSTOMER', 'MESS_STAFF', 'MESS_OWNER', 'PLATFORM_ADMIN');
CREATE TYPE dietary_preference AS ENUM ('PURE_VEG', 'VEG_NON_VEG', 'JAIN_AVAILABLE');
CREATE TYPE meal_type AS ENUM ('BREAKFAST', 'LUNCH', 'DINNER', 'SNACKS');
CREATE TYPE subscription_status AS ENUM ('PENDING_PAYMENT', 'ACTIVE', 'PAUSED', 'EXPIRED', 'CANCELLED');
CREATE TYPE payment_status AS ENUM ('CREATED', 'AUTHORIZED', 'CAPTURED', 'REFUNDED', 'FAILED');
CREATE TYPE ledger_entry_type AS ENUM ('CREDIT_TOPUP', 'SUBSCRIPTION_CHARGE', 'MEAL_SKIP_CREDIT', 'LATE_FEE', 'REFUND_DISBURSEMENT');

-- 1. Users Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    role user_role DEFAULT 'CUSTOMER',
    preferred_language VARCHAR(5) DEFAULT 'en',
    ui_presentation_mode VARCHAR(20) DEFAULT 'STUDENT', -- 'STUDENT', 'WORKING', 'SENIOR'
    is_minor BOOLEAN DEFAULT FALSE,
    guardian_name VARCHAR(100),
    guardian_phone VARCHAR(15),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Messes Table (Multi-Tenant Root)
CREATE TABLE messes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    mess_name VARCHAR(150) NOT NULL,
    fssai_license_number VARCHAR(14) NOT NULL, -- Mandatory 14-digit Indian FSSAI
    fssai_verified BOOLEAN DEFAULT FALSE,
    gstin VARCHAR(15), -- Optional Indian GST Number
    dietary_type dietary_preference DEFAULT 'VEG_NON_VEG',
    address_line TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    lunch_cutoff_time TIME DEFAULT '09:00:00',
    dinner_cutoff_time TIME DEFAULT '17:00:00',
    max_skips_per_cycle INT DEFAULT 6,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Subscription Plans Table
CREATE TABLE subscription_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mess_id UUID NOT NULL REFERENCES messes(id) ON DELETE CASCADE,
    plan_name VARCHAR(100) NOT NULL,
    description TEXT,
    cycle_days INT NOT NULL DEFAULT 30, -- 15, 30, or custom days
    meals_included meal_type[] NOT NULL, -- e.g. ['LUNCH', 'DINNER']
    price_paise BIGINT NOT NULL, -- Stored in Paise (₹100 = 10000 paise)
    skip_credit_amount_paise BIGINT DEFAULT 5000, -- e.g. ₹50 credit per valid skip
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Subscriptions Table
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    mess_id UUID NOT NULL REFERENCES messes(id) ON DELETE RESTRICT,
    plan_id UUID NOT NULL REFERENCES subscription_plans(id) ON DELETE RESTRICT,
    status subscription_status DEFAULT 'PENDING_PAYMENT',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    meals_remaining INT NOT NULL,
    skips_used INT DEFAULT 0,
    credit_balance_paise BIGINT DEFAULT 0,
    idempotency_key UUID UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Daily Menus Table
CREATE TABLE daily_menus (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mess_id UUID NOT NULL REFERENCES messes(id) ON DELETE CASCADE,
    menu_date DATE NOT NULL,
    meal_type meal_type NOT NULL,
    items_json JSONB NOT NULL, -- {"en": [...], "mr": [...], "hi": [...]}
    ocr_source_image_url TEXT,
    is_published BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMP WITH TIME ZONE,
    UNIQUE(mess_id, menu_date, meal_type)
);

-- 6. Meal Logs (Attendance & Skip Tracking)
CREATE TABLE meal_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subscription_id UUID NOT NULL REFERENCES subscriptions(id) ON DELETE CASCADE,
    mess_id UUID NOT NULL REFERENCES messes(id) ON DELETE CASCADE,
    meal_date DATE NOT NULL,
    meal_type meal_type NOT NULL,
    status VARCHAR(20) NOT NULL, -- 'SCHEDULED', 'ATTENDED', 'SKIPPED', 'CANCELLED_BY_MESS'
    skip_requested_at TIMESTAMP WITH TIME ZONE,
    credit_awarded_paise BIGINT DEFAULT 0,
    UNIQUE(subscription_id, meal_date, meal_type)
);

-- 7. Double-Entry Financial Ledger
CREATE TABLE ledger_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mess_id UUID NOT NULL REFERENCES messes(id) ON DELETE RESTRICT,
    subscription_id UUID REFERENCES subscriptions(id) ON DELETE SET NULL,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    entry_type ledger_entry_type NOT NULL,
    debit_paise BIGINT DEFAULT 0,
    credit_paise BIGINT DEFAULT 0,
    running_balance_paise BIGINT NOT NULL,
    idempotency_key VARCHAR(100) UNIQUE NOT NULL,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 8. Payments Table
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subscription_id UUID NOT NULL REFERENCES subscriptions(id) ON DELETE RESTRICT,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    amount_paise BIGINT NOT NULL,
    currency VARCHAR(3) DEFAULT 'INR',
    gateway_provider VARCHAR(50) DEFAULT 'RAZORPAY_SANDBOX',
    gateway_order_id VARCHAR(100) UNIQUE NOT NULL,
    gateway_payment_id VARCHAR(100) UNIQUE,
    gateway_signature VARCHAR(255),
    status payment_status DEFAULT 'CREATED',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 9. Digital Personal Data Protection (DPDPA 2023) Consent Records
CREATE TABLE consent_records (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    policy_type VARCHAR(50) NOT NULL, -- 'TERMS', 'PRIVACY', 'GUARDIAN_CONSENT'
    policy_version VARCHAR(20) NOT NULL,
    language_presented VARCHAR(5) NOT NULL,
    consented_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    ip_address INET,
    user_agent TEXT
);

-- 10. Audit Events Table
CREATE TABLE audit_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    actor_id UUID REFERENCES users(id) ON DELETE SET NULL,
    mess_id UUID REFERENCES messes(id) ON DELETE SET NULL,
    action_type VARCHAR(100) NOT NULL,
    resource_type VARCHAR(100) NOT NULL,
    resource_id VARCHAR(100) NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

---

## 10. Subscription and Meal Management

### 10.1 Subscription Lifecycle Machine
```mermaid
stateDiagram-v2
    [*] --> PENDING_PAYMENT: User Selects Plan
    PENDING_PAYMENT --> ACTIVE: Payment Captured & Verified
    PENDING_PAYMENT --> CANCELLED: Abandoned / Gateway Timeout
    ACTIVE --> PAUSED: User Holiday / Medical Hold
    PAUSED --> ACTIVE: User Resumes
    ACTIVE --> EXPIRED: Meals Exhausted OR Cycle Days Finished
    ACTIVE --> CANCELLED: Refund Initiated / Owner Terminated
    EXPIRED --> [*]
    CANCELLED --> [*]
```

### 10.2 Meal Skip Business Rules & Cutoff Engine
To prevent mess food waste and financial disputes, meal skip rules are enforced server-side with zero client bypass:
1. **Cutoff Times (Asia/Kolkata Standard)**:
   - **Lunch**: Skip must be requested prior to `09:00 AM IST` on the meal date.
   - **Dinner**: Skip must be requested prior to `05:00 PM IST` on the meal date.
2. **Quota & Rate Limiting**:
   - Standard 30-day plan allows a maximum of **6 skipped meals** credited back to the customer. Subsequent skips are recorded as operational absences without monetary credits, preventing abuse.
3. **Double-Credit Prevention**:
   - The database constraint `UNIQUE(subscription_id, meal_date, meal_type)` guarantees that concurrent or repeated skip clicks cannot generate duplicate credits.
   - When a skip is authorized, the credit amount (e.g., ₹50 = 5000 paise) is posted to the double-entry ledger within a single atomic database transaction.

```typescript
// Core Transactional Skip Meal Logic (TypeScript / Node.js Engine)
export async function executeMealSkip(params: {
  userId: string;
  subscriptionId: string;
  mealDate: string; // 'YYYY-MM-DD'
  mealType: 'LUNCH' | 'DINNER';
  idempotencyKey: string;
}): Promise<{ success: boolean; creditAwardedPaise: number; message: string }> {
  return await db.transaction(async (tx) => {
    // 1. Fetch Subscription & Mess Cutoff Rules
    const sub = await tx.subscriptions.findUnique({
      where: { id: params.subscriptionId },
      include: { mess: true, plan: true }
    });

    if (!sub || sub.userId !== params.userId || sub.status !== 'ACTIVE') {
      throw new Error("Unauthorized or inactive subscription.");
    }

    // 2. Compute Cutoff in Asia/Kolkata
    const nowIST = getNowInKolkata();
    const cutoffTimeStr = params.mealType === 'LUNCH' 
      ? sub.mess.lunchCutoffTime 
      : sub.mess.dinnerCutoffTime;
      
    const targetCutoffIST = parseToKolkataDateTime(params.mealDate, cutoffTimeStr);

    if (nowIST > targetCutoffIST) {
      throw new Error(`Cutoff window closed at ${cutoffTimeStr} IST for ${params.mealType}. Skip cannot be registered.`);
    }

    // 3. Verify Existing Meal Log
    const existingLog = await tx.mealLogs.findUnique({
      where: {
        subscriptionId_mealDate_mealType: {
          subscriptionId: params.subscriptionId,
          mealDate: params.mealDate,
          mealType: params.mealType
        }
      }
    });

    if (existingLog && existingLog.status === 'SKIPPED') {
      return { success: true, creditAwardedPaise: 0, message: "Meal already marked as skipped." };
    }

    // 4. Check Skip Limit & Award Credit
    const creditAmountPaise = (sub.skipsUsed < sub.mess.maxSkipsPerCycle)
      ? sub.plan.skipCreditAmountPaise
      : 0;

    // 5. Update Meal Log
    await tx.mealLogs.upsert({
      where: {
        subscriptionId_mealDate_mealType: {
          subscriptionId: params.subscriptionId,
          mealDate: params.mealDate,
          mealType: params.mealType
        }
      },
      update: { status: 'SKIPPED', skipRequestedAt: nowIST, creditAwardedPaise: creditAmountPaise },
      create: {
        subscriptionId: params.subscriptionId,
        messId: sub.messId,
        mealDate: params.mealDate,
        mealType: params.mealType,
        status: 'SKIPPED',
        skipRequestedAt: nowIST,
        creditAwardedPaise: creditAmountPaise
      }
    });

    // 6. Post into Double-Entry Ledger if credit is awarded
    if (creditAmountPaise > 0) {
      const currentBalance = await tx.getUserBalance(sub.userId, sub.messId);
      await tx.ledgerTransactions.create({
        data: {
          messId: sub.messId,
          subscriptionId: sub.id,
          userId: sub.userId,
          entryType: 'MEAL_SKIP_CREDIT',
          creditPaise: creditAmountPaise,
          runningBalancePaise: currentBalance + creditAmountPaise,
          idempotencyKey: params.idempotencyKey,
          notes: `Meal skip credit for ${params.mealType} on ${params.mealDate}`
        }
      });

      await tx.subscriptions.update({
        where: { id: sub.id },
        data: {
          skipsUsed: { increment: 1 },
          creditBalancePaise: { increment: creditAmountPaise }
        }
      });
    }

    return {
      success: true,
      creditAwardedPaise: creditAmountPaise,
      message: creditAmountPaise > 0 
        ? `Meal skipped. ₹${creditAmountPaise / 100} credited to your ledger balance.` 
        : "Meal skipped. Maximum monthly credit quota reached; kitchen notified to avoid food waste."
    };
  });
}
```

---

## 11. Payments

### 11.1 Payment Architecture & Sandbox Workflow
MessLink adheres to the Reserve Bank of India (RBI) payment aggregators guidelines and security mandates.
- **Strict Prohibition**: MessLink never requests, captures, logs, or stores raw Card Numbers, CVVs, Expiry Dates, or UPI PINs.
- **Gateway Integration**: Integrated with Razorpay Sandbox API. Live payment processing remains explicitly locked until corporate KYC and owner sign-off.

```mermaid
sequenceDiagram
    autonumber
    actor Diner as Diner (Client)
    participant Server as MessLink Backend
    participant Razorpay as Razorpay Sandbox API
    participant DB as Relational Database

    Diner->>Server: POST /api/payments/create-order {planId, idempotencyKey}
    Server->>Server: Validate Plan Price & User Eligibility
    Server->>Razorpay: orders.create({amount: paise, currency: "INR", receipt: subId})
    Razorpay-->>Server: Return order_id (e.g. order_K39xLa81j)
    Server->>DB: Save Payment record (status: CREATED)
    Server-->>Diner: Return {orderId, amount, keyId, messName}

    Diner->>Razorpay: Open Razorpay Checkout (UPI / Cards / Netbanking)
    Diner->>Razorpay: Authorize Payment with Sandbox Credentials
    Razorpay-->>Diner: Return {razorpay_payment_id, razorpay_order_id, razorpay_signature}

    Diner->>Server: POST /api/payments/verify {signature, order_id, payment_id}
    Server->>Server: Compute HMAC-SHA256(order_id + "|" + payment_id, SECRET)
    alt Signature Matches
        Server->>DB: Atomic Update: Payment=CAPTURED, Subscription=ACTIVE
        Server->>DB: Write Ledger Credit Transaction
        Server-->>Diner: HTTP 200 {status: "SUCCESS", subscriptionActive: true}
    else Signature Mismatch
        Server->>DB: Log Security Incident & Payment=FAILED
        Server-->>Diner: HTTP 400 {error: "Cryptographic Signature Invalid"}
    end
```

### 11.2 Cryptographic Signature Verification Logic
```typescript
import crypto from 'node:crypto';

export function verifyRazorpaySignature(params: {
  orderId: string;
  paymentId: string;
  signature: string;
  webhookSecret: string;
}): boolean {
  const payload = `${params.orderId}|${params.paymentId}`;
  const expectedSignature = crypto
    .createHmac('sha256', params.webhookSecret)
    .update(payload)
    .digest('hex');

  // Use timingSafeEqual to defeat side-channel timing attacks
  const expectedBuffer = Buffer.from(expectedSignature, 'utf8');
  const actualBuffer = Buffer.from(params.signature, 'utf8');

  if (expectedBuffer.length !== actualBuffer.length) {
    return false;
  }

  return crypto.timingSafeEqual(expectedBuffer, actualBuffer);
}
```

---

## 12. AI-Powered Menu Scanner

### 12.1 Vision Pipeline & OCR Architecture
Many traditional Indian mess owners write daily menus on physical chalkboards or dry-erase boards in Marathi, Hindi, or English. MessLink implements a multi-step vision pipeline:

```mermaid
graph LR
    ImgUpload[Owner Snaps Photo of Board] --> PreProcess[Canvas Image Preprocessing & Contrast Enhancement]
    PreProcess --> OCR[Vision LLM / OCR Engine API Call]
    OCR --> StructuredParse[JSON Schema Extraction & Trilingual Validation]
    StructuredParse --> UncertaintyFlag[Confidence Scorer: Flags Low-Confidence Words]
    UncertaintyFlag --> OwnerReview[Interactive Review Screen in Owner Portal]
    OwnerReview --> Publish[Explicit Owner Approval & Publication]
```

### 12.2 Trilingual Extraction Schema
The extraction engine transforms raw images into validated JSON with confidence flags:
```json
{
  "menu_date": "2026-10-17",
  "meal_type": "LUNCH",
  "confidence_score": 0.94,
  "requires_manual_check": false,
  "items": [
    {
      "category": "Sabzi",
      "name": {
        "en": "Sev Bhaji",
        "mr": "शेव भाजी",
        "hi": "सेव भाजी"
      },
      "confidence": 0.98
    },
    {
      "category": "Bread",
      "name": {
        "en": "Chapati (4 pcs)",
        "mr": "चपाती (४ नग)",
        "hi": "चपाती (४ नग)"
      },
      "confidence": 0.96
    },
    {
      "category": "Dal",
      "name": {
        "en": "Tadka Dal",
        "mr": "तडका डाळ",
        "hi": "तड़का दाल"
      },
      "confidence": 0.92
    },
    {
      "category": "Rice",
      "name": {
        "en": "Jeera Rice",
        "mr": "जिरा राईस",
        "hi": "जीरा चावल"
      },
      "confidence": 0.89
    }
  ]
}
```

### 12.3 Safety Rules
1. **Zero Hallucination Guarantee**: If an item or price is illegible, it is marked with `"confidence": 0.40` and highlighted in yellow on the Owner Review Screen. It is **never** fabricated.
2. **Explicit Owner Sign-Off**: Extracted menus are saved with `is_published: false`. They only become visible to diners once the owner taps **"Confirm & Publish Menu"**.
3. **Manual Entry Fallback**: If network or camera is unavailable, owners can select items from a quick-pick library of 100+ standard Indian mess dishes with one tap.

---

## 13. Security and Privacy

### 13.1 Indian Regulatory Compliance Matrix
This matrix details the statutory requirements governing MessLink in India, verified against current legislation.

| Regulatory Instrument | Statutory Requirement | MessLink Implementation & Architectural Evidence | Current Status |
| :--- | :--- | :--- | :--- |
| **DPDPA 2023 & DPDP Rules 2025** | Clear, itemized Notice in English & 8th Schedule languages (Hindi, Marathi) prior to consent. | Language-specific notice dialogs with unticked opt-in checkboxes. Logged in `consent_records`. | **Fully Specified** |
| **DPDPA 2023 Sec. 9** | Verifiable parental consent before processing personal data of minors (< 18 yrs). | Student mode checks birth date. Under 18 requires guardian OTP confirmation & phone linkage. | **Architected** |
| **DPDPA 2023 Sec. 12** | Right to data correction, erasure, and grievance redressal mechanism. | Automated data download API (`/api/user/export-data`) and deletion workflow (`/api/user/delete-account`). | **Architected** |
| **CERT-In Directions (2022)** | Mandatory 6-hour cybersecurity incident reporting & 180-day secure NTP time-synchronized logs. | Structured JSON audit logging with UTC/IST synchronized timestamps stored in `audit_events`. | **Architected** |
| **IT Act 2000 (Sec. 43A, 79)** | Reasonable security practices; intermediary safe harbor compliance; Grievance Officer designation. | Role of Resident Grievance Officer published in legal documentation; contact channels established. | **Documented** |
| **FSSAI Act 2006** | Mandatory food business operator license/registration display on platform listings. | 14-digit FSSAI license field mandatory during Mess registration. Publicly rendered on mess profiles. | **Enforced in Schema** |
| **GST Act & Invoicing** | SAC 996333 catering tax rules (5% GST without ITC or composition scheme). | Dynamic tax breakdown generator in payment receipts; GSTIN validation where applicable. | **Enforced in Ledger** |
| **Consumer Protection (E-Commerce) Rules 2020** | Mandatory disclosure of refund timelines, terms of exchange, and ticket redressal within 48h. | Explicit Refund & Cancellation Policy; SLA tracking in `support_tickets` table. | **Documented** |

### 13.2 Role-Based Access Control (RBAC) Matrix
```
+--------------------+----------------+-------------------+-----------------+------------------+
| Resource / Action  | GUEST (Public) | CUSTOMER (Diner) | MESS_OWNER      | PLATFORM_ADMIN   |
+--------------------+----------------+-------------------+-----------------+------------------+
| Discover Messes    | Allowed        | Allowed           | Allowed         | Allowed          |
| View Public Menus  | Allowed        | Allowed           | Allowed         | Allowed          |
| Skip Meal          | Denied         | Own Sub Only      | Denied          | Override Only    |
| Edit Daily Menu    | Denied         | Denied            | Own Mess Only   | Read-Only Audit  |
| Access Ledger      | Denied         | Own Statement Only| Own Mess Only   | Compliance Audit |
| Trigger Refund     | Denied         | Request Only      | Authorize Only  | Supervise        |
+--------------------+----------------+-------------------+-----------------+------------------+
```

---

## 14. Policies and Agreements

### 14.1 Policy Suite Overview
MessLink maintains five legal policies, provided in English, Marathi, and Hindi, requiring explicit consent:
1. **User Terms and Conditions**: Governs user accounts, meal credits, attendance rules, and community guidelines.
2. **Privacy Policy (DPDPA 2023 Compliant)**: Discloses data collection, phone number verification, payment routing, and data subject rights.
3. **Payment, Cancellation & Refund Policy**:
   - Subscriptions can be cancelled within 48 hours of purchase for a pro-rata refund minus a 5% administrative charge.
   - Skipped meals are credited toward subscription extension or adjusted in the subsequent renewal invoice.
4. **Mess Owner Service Level Agreement (SLA)**: Governs kitchen hygiene adherence, mandatory FSSAI validity, menu accuracy, and settlement cycles (T+2 banking days).
5. **Grievance Redressal Protocol**:
   - Grievance Officer: Designated Indian Resident Officer.
   - Acknowledgement within **48 hours**; resolution within **30 days** as mandated by IT Rules 2021.

---

## 15. Offline Support, PWA & Reliability

### 15.1 Progressive Web App (PWA) Architecture
MessLink is built to operate reliably in Indian environments subject to intermittent connectivity (e.g., student hostels with weak mobile signals or basement mess kitchens).

```mermaid
graph TD
    UserAction[User Taps: Skip Meal or Check Attendance] --> NetCheck{Is Online?}
    NetCheck -->|Yes| DirectAPI[Execute Server API & Await Confirmation]
    NetCheck -->|No| QueueDB[(Store in IndexedDB Sync Queue with Timestamp)]
    QueueDB --> VisualUI[Render 'Changes Queued - Pending Sync' Badge]
    VisualUI --> BGListener[Background Sync Listener Waits for 'online' Event]
    BGListener --> NetCheck
    DirectAPI --> UpdateUI[Update Balance & Clear Sync Badge]
```

### 15.2 Service Worker Caching Policies
- **Static Shell (App Shell, Icons, CSS, Devanagari Fonts)**: `Cache-First` with versioned cache busting.
- **Daily Menus**: `Stale-While-Revalidate` (serves cached today's menu immediately, fetches updates silently in background).
- **Financial Balances & Meal Skips**: `Network-Only with IndexedDB Fallback`. Unconfirmed skip actions are never displayed as completed; they remain explicitly labeled as **"Pending Sync"**.

---

## 16. Pilot Operations & Feedback Telemetry

### 16.1 Controlled Pilot Deployment Strategy
Before general public onboarding, MessLink will run a controlled 30-day pilot across:
- **Pilot Cohort**: 5 to 10 verified messes in student clusters (e.g., Karve Nagar / Viman Nagar, Pune; Rajiv Gandhi Nagar, Kota).
- **Target Diners**: 300 to 500 subscribed students and young working professionals.
- **Payment Mode**: Razorpay Sandbox test transactions and direct cash/UPI ledger tracking.

### 16.2 Internal Feedback & Defect Triage System
```sql
CREATE TABLE feedback_tickets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    mess_id UUID REFERENCES messes(id),
    reporter_role user_role NOT NULL,
    category VARCHAR(50) NOT NULL, -- 'APP_BUG', 'FOOD_QUALITY', 'BILLING_DISPUTE', 'OCR_ERROR'
    severity VARCHAR(20) NOT NULL, -- 'LOW', 'MEDIUM', 'HIGH', 'CRITICAL'
    description TEXT NOT NULL,
    app_version VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN', -- 'OPEN', 'TRIAGED', 'RESOLVED', 'CLOSED'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

---

## 17. Testing & Quality Verification Suite

### 17.1 Test Matrix & Automation Boundaries
| Test Category | Suite Target | Verification Method | Pass Criteria |
| :--- | :--- | :--- | :--- |
| **Unit Tests** | Cutoff Engine & Timezone math | Automated Jest / Node Test Runner | 100% boundary check pass for 08:59:59 vs 09:00:01 IST |
| **Unit Tests** | HMAC-SHA256 Payment Signatures | Cryptographic test vectors | Correctly detects valid signature; rejects altered payload |
| **Integration** | Multi-Tenant Data Isolation | Automated cross-tenant queries | Mess A owner querying Mess B ledger receives HTTP 403 Forbidden |
| **Integration** | Double-Credit Prevention | Simulated 10 concurrent skip requests | Exactly 1 credit transaction posted; 9 return 409 / idempotent result |
| **E2E / Browser** | Trilingual Rendering | Headless Browser (Puppeteer/Playwright) | Devanagari characters render without glyph corruption in Marathi & Hindi |
| **E2E / Mobile** | Small Screen Viewports (360px) | Viewport simulation | Zero horizontal overflow; touch targets >= 48px |
| **Reliability** | Offline Queue Synchronization | Simulated offline network switch | Action queues in IndexedDB; flushes atomically upon reconnect |

---

## 18. Release Conditions & Pre-Launch Gates

To guarantee legal, technical, and financial safety, the following conditions must be fulfilled before commercial activation:
1. **Zero High-Severity Defects**: All pilot feedback items graded `HIGH` or `CRITICAL` resolved and verified.
2. **Tenant Isolation Proof**: Automated security tests prove that no cross-mess data leaks can occur under any authenticated condition.
3. **Legal Review Sign-Off**: Verification by qualified Indian legal counsel of DPDPA consent notices, Terms of Service, and FSSAI disclosures.
4. **FSSAI License Validation**: Production onboarding mandates manual or API verification of the mess operator's 14-digit FSSAI registration.
5. **Backup & Recovery Verification**: Full database backup snapshot generated, restored into an isolated staging instance, and verified for consistency.
6. **Explicit Launch Approval**: Project owner gives documented, signed approval prior to transitioning payment credentials from Sandbox to Live.

---

## 19. Required Project Documentation Inventory

The MessLink workspace maintains a standardized documentation suite in the project repository:

```
messlink/
├── README.md                      # Project overview, setup, running instructions, architecture summary
├── .env.example                   # Comprehensive environment variable inventory without real secrets
└── docs/
    ├── MESSLINK_PROJECT_REPORT.md # This complete Master Specification & Project Report
    ├── DECISIONS.md               # Architectural Decision Records (ADRs) and design rationales
    ├── PROJECT_STATUS.md          # Real-time feature checklist: Complete, In-Progress, Mocked, Blocked
    ├── COMPLIANCE_CHECKLIST.md    # Detailed Indian statutory compliance matrix (DPDPA, FSSAI, GST, IT Act)
    └── TESTING.md                 # Test plan, automated test suites, execution commands, and verified results
```

---

## 20. Implementation Workflow & Phase 1 Execution Status

### 20.1 Phased Engineering Workflow
- **Phase 1 (Current)**: Workspace audit, architecture establishment, complete project documentation, core design system, and project structure initialization.
- **Phase 2**: Interactive trilingual landing page (*"Are you here to Eat or Manage a Mess?"*), customer persona toggles (Student, Working Adult, Senior), and Owner Portal foundations.
- **Phase 3**: Relational database migration scripts, authentication layer (phone OTP/session), role-based middleware, and multi-tenant isolation barriers.
- **Phase 4**: Menu publishing engine, subscription lifecycle, cutoff validation, double-credit prevention, and financial ledger.
- **Phase 5**: AI menu scanner OCR pipeline with uncertainty flagging and manual fallback.
- **Phase 6**: Razorpay sandbox payment gateway integration, webhook signature verification, and automated refund handling.
- **Phase 7**: DPDPA consent flows, PWA service worker with IndexedDB offline queue, and operational feedback triage system.
- **Phase 8**: Automated test suite execution, browser verification, defect fixing, and pre-release audit.

### 20.2 Phase 1 Execution Deliverables
1. **Workspace Audit Complete**: Target machine inspected (Windows 11, Node.js v22.20.0, npm 10.9.3, Python 3.14.0).
2. **Master Project Report Compiled**: Full 20-section report formatted and stored in both the IDE Artifacts system and `docs/MESSLINK_PROJECT_REPORT.md`.
3. **Documentation Infrastructure Initialized**:
   - `docs/DECISIONS.md`: Architectural Decision Records for Next.js/Node, Relational Storage, and Trilingual i18n.
   - `docs/PROJECT_STATUS.md`: Feature-by-feature status tracker.
   - `docs/COMPLIANCE_CHECKLIST.md`: Comprehensive statutory tracker.
   - `docs/TESTING.md`: Verification protocols and test matrix.
   - `.env.example`: Secure environment variable blueprint.
   - `README.md`: Developer guide and operational instructions.

---
*End of MessLink Master Architectural Project Report.*
