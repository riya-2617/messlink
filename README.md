# MessLink (मेसलिंक)
> **An Indian Mess Discovery, Meal Subscription, and Operations Management Platform**
> *Connecting hungry students & professionals with reliable local messes while preventing kitchen food waste.*

---

## 🌟 Overview
MessLink bridges the gap between commercial Indian mess operators and subscribers. It provides public discovery, flexible monthly subscriptions, automated meal skipping with credit roll-overs, and a touch-first kitchen management dashboard for mess owners.

The platform natively features:
- **Trilingual Localization**: Complete native translations for English (`en`), Marathi (`mr`), and Hindi (`hi`).
- **3 Presentation Modes**:
  - **Students (16–23)**: Dark theme, today's meal focus, 1-click meal skip, live credit counter.
  - **Working Adults (23–50)**: Light theme, monthly meal calendar, expense tracking, invoice downloads.
  - **Seniors (50+)**: High-contrast, large fonts (>= 18px), oversized touch targets (>= 48px), simplified layout.
- **Dedicated Mess Owner Portal**: Real-time headcount forecasting (Breakfast/Lunch/Dinner), cutoff management, trilingual menu publishing with AI OCR photo scanning, and subscriber ledger.
- **Double-Entry Financial Ledger**: Immutable transaction history ensuring zero double-crediting of skipped meals.
- **Indian Statutory Compliance**: Designed around DPDPA 2023, FSSAI licensing validation, GST (SAC 996333), and RBI payment aggregator mandates.

---

## 🚀 Quick Start & Local Run

### Prerequisites
- Node.js `>= 18.0.0` (Verified on `v22.20.0`)
- NPM `>= 9.0.0` (Verified on `10.9.3`)

### 1. Installation
Clone or navigate to the project directory:
```bash
cd scratch/messlink
```

### 2. Environment Configuration
Copy `.env.example` to `.env`:
```bash
cp .env.example .env
```

### 3. Launch the Application
Run the local lightweight server:
```bash
node src/server.js
```
Open your browser and navigate to:
```
http://localhost:3000
```

---

## 📂 Project Architecture & Documentation Map
All architectural details, data schemas, and regulatory matrices are strictly documented in the `docs/` folder:

- **[Master System Architecture & Project Report](docs/MESSLINK_PROJECT_REPORT.md)**: Full 20-section comprehensive specification adhering to the Master Build Prompt.
- **[Architectural Decision Records](docs/DECISIONS.md)**: Record of technical choices (ADR 001 - 006).
- **[Feature Implementation Status](docs/PROJECT_STATUS.md)**: Real-time status of all subsystems (Completed, Partial, Mocked).
- **[Indian Statutory Compliance Checklist](docs/COMPLIANCE_CHECKLIST.md)**: DPDPA 2023, FSSAI, IT Act 2000, and GST requirements.
- **[Testing Protocol & Verification Suite](docs/TESTING.md)**: Unit, integration, and security test protocols.

---

## 🛡️ Security, Privacy & Payments Notice
- **Payments**: Razorpay sandbox mode is active by default. Live payments require explicit business KYC and owner activation.
- **Secret Hygiene**: Real API keys, secret credentials, and card details are never committed.
- **Timezone**: All business operations and cutoffs strictly adhere to Indian Standard Time (`Asia/Kolkata`).

---
*Maintained under MessLink Architectural Governance.*
