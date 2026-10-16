# Architectural Decision Records (ADR) — MessLink

## ADR 001: Selection of Full-Stack Architecture & TypeScript Runtime
* **Status**: Accepted
* **Date**: October 16, 2026
* **Context**:
  MessLink requires a responsive frontend serving three diverse demographic personas (Students, Working Adults, Seniors), high performance on low-end Android mobile devices (360px width), offline service worker caching, and a robust server-side API handling transaction-safe meal skips and double-entry financial ledgering.
* **Decision**:
  Adopt a modern TypeScript-based full-stack architecture running on Node.js (verified v22.20.0). The client utilizes standard web standards (HTML5 semantic elements, Vanilla CSS with custom property tokens, and modular TypeScript) to ensure near-instant load times, zero bundle bloat on 3G/4G networks, and complete control over Devanagari typography rendering without heavyweight UI framework overhead.
* **Consequences**:
  - Extremely fast First Contentful Paint (< 800ms) on budget Android smartphones.
  - Predictable, native Service Worker lifecycle for offline capabilities.
  - Clear separation between public discovery endpoints and authenticated tenant boundaries.

---

## ADR 002: Relational Schema & Strict Multi-Tenant Isolation
* **Status**: Accepted
* **Date**: October 16, 2026
* **Context**:
  Each mess business is an independent commercial entity. Data leakage between competing messes (subscriber phone numbers, revenue, daily attendance, pricing models) would represent a critical security violation. Furthermore, meal skipping and subscriptions require strict ACID guarantees.
* **Decision**:
  Implement a relational database schema with PostgreSQL / SQLite compatibility. Multi-tenancy is enforced at the query level using composite foreign keys and mandatory `mess_id` filtering on all operational queries. Financial updates use explicit database transactions with serializable / atomic isolation.
* **Consequences**:
  - Accidental cross-tenant access is structurally prevented by authorization middleware and database constraints.
  - Enables atomic rollbacks if payment or attendance logs fail during batch updates.

---

## ADR 003: Double-Entry Ledger for All Financial and Skip Operations
* **Status**: Accepted
* **Date**: October 16, 2026
* **Context**:
  Subscribers earn credits when skipping meals before cutoffs. Mess owners collect upfront subscription fees or settle postpaid balances. Modifying a single mutable balance field in the database leads to untraceable discrepancies, reconciliation failures, and race conditions.
* **Decision**:
  Implement an immutable, append-only double-entry ledger (`ledger_transactions`). Any top-up, subscription payment, meal skip credit, refund, or adjustment writes a new debit/credit record with an associated idempotency key and running balance calculation.
* **Consequences**:
  - Full audit trail compliant with Indian accounting standards and GST record-keeping rules.
  - Double-crediting from rapid repeated clicks or network retries is rendered impossible through unique idempotency keys.

---

## ADR 004: Trilingual Localization Architecture (English, Marathi, Hindi)
* **Status**: Accepted
* **Date**: October 16, 2026
* **Context**:
  MessLink operates heavily across Maharashtra (Pune, Mumbai) and North/Central India (Kota, Indore, NCR). Diners and mess cooks speak and read English, Marathi, and Hindi. Menu items also feature specific regional delicacies (e.g. "Pithla Bhakri", "Kadhi Pakoda").
* **Decision**:
  1. UI strings are governed by a centralized dictionary with locale fallbacks (`en` -> `hi` / `mr`).
  2. Dynamic menu content is stored in the database as localized JSON objects (`{"en": "...", "mr": "...", "hi": "..."}`).
  3. Typography is powered by Google Fonts *Poppins* and *Noto Sans Devanagari*, ensuring correct conjuncts, matras, and baseline alignment.
* **Consequences**:
  - Native Devanagari reading experience for older adults and local cooks.
  - No hardcoded English strings in UI components.

---

## ADR 005: AI-Powered OCR Menu Scanner with Owner Verification Gate
* **Status**: Accepted
* **Date**: October 16, 2026
* **Context**:
  Mess owners write daily menus by hand on chalkboards or whiteboards. Typing menus on a phone keyboard every morning is high friction. However, raw OCR results can hallucinate prices, misread handwriting, or miss items.
* **Decision**:
  A multi-step pipeline: (1) Image upload with client-side canvas contrast adjustment, (2) OCR/Vision API extraction into trilingual structured JSON, (3) Confidence scoring flagging uncertain words, (4) Mandatory Owner Review & Edit screen, (5) Owner explicit publication.
* **Consequences**:
  - Zero hallucinatory menus published to subscribers.
  - Manual dish selection library provided as an instant offline/fallback alternative.

---

## ADR 006: Indian Regulatory Compliance Strategy (DPDPA 2023, FSSAI, GST)
* **Status**: Accepted
* **Date**: October 16, 2026
* **Context**:
  India's Digital Personal Data Protection Act, 2023 and DPDP Rules, 2025 impose strict duties on Data Fiduciaries, including parental consent for minors, explicit multi-language notice, and data principal rights. Additionally, food safety requires FSSAI compliance, and catering requires GST compliance.
* **Decision**:
  Embed regulatory compliance directly into the data model and workflows:
  - `consent_records` logs explicit policy version consents with IP and timestamps.
  - Minor age check enforces guardian consent verification.
  - FSSAI 14-digit license validation is mandatory on all mess listings.
  - Standard SAC 996333 tax receipts generated for subscriptions.
* **Consequences**:
  - Complete legal auditability prior to commercial launch.
  - Ready for formal Indian legal counsel sign-off.
