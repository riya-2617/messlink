# Indian Statutory Compliance & Regulatory Checklist — MessLink

## Regulatory Scope & Legal Grounding
MessLink operates as an intermediary platform connecting mess operators (food business operators) with meal subscribers across India. This document outlines applicable statutory obligations, architectural implementations, and pre-launch requirements.

---

## 1. Digital Personal Data Protection Act, 2023 (DPDPA 2023) & DPDP Rules 2025

| Section / Rule | Mandate Description | Platform Implementation | Verification Status |
| :--- | :--- | :--- | :--- |
| **Section 5 (Notice)** | Notice must accompany request for consent, specifying personal data collected, purpose, withdrawal rights, and grievance mechanism in English or any 8th Schedule language. | Trilingual consent modal rendered in English, Marathi, and Hindi before phone verification. Consent logged in `consent_records`. | **IMPLEMENTED IN SCHEMA** |
| **Section 6 (Consent)** | Consent must be free, specific, informed, unconditional, and unambiguous with clear affirmative action (unticked checkboxes). | All policy checkboxes are unticked by default. Separate checkboxes for Terms, Privacy, and Commercial Communications. | **IMPLEMENTED IN UI** |
| **Section 9 (Minors)** | Verifiable parental consent required before processing personal data of individuals under 18 years; zero tracking or behavioral monitoring of children. | Minor toggle triggers Guardian Name & Phone verification with OTP authentication. Zero targeted ads served. | **ARCHITECTED** |
| **Section 11-13 (Rights)** | Right to access summary of data, right to correction and erasure, right of grievance redressal. | Self-service data export endpoint (`GET /api/user/data-export`) and account deletion request workflow. | **ARCHITECTED** |
| **Section 8(6) (Breach)** | Mandatory notification to Data Protection Board of India and affected data principals in case of personal data breach. | Incident response protocol documented; automated security logging in `audit_events`. | **READY FOR AUDIT** |

---

## 2. Food Safety and Standards Act, 2006 (FSSAI) & Food Safety Regulations

| Mandate | Requirement | Platform Implementation | Verification Status |
| :--- | :--- | :--- | :--- |
| **Section 31 (Licensing)** | All Food Business Operators (FBOs), including mess operators, canteens, and dabba services, must hold a valid FSSAI License (14 digits) or Registration. | Mess registration form requires a valid 14-digit FSSAI number with algorithm validation (L/R prefix, state code, year, registrar, sequential). | **ENFORCED** |
| **Display of License** | E-commerce / aggregator platforms must visibly display the FSSAI license number and hygiene rating of food establishments. | FSSAI license badge prominently displayed on every mess profile card and menu header with verification status. | **ENFORCED IN UI** |
| **Food Hygiene Grievance** | Mechanism for diners to report food safety, hygiene, or foreign object complaints. | Dedicated "Food Hygiene" report category in customer feedback drawer, routed immediately to mess owner and platform QA. | **IMPLEMENTED** |

---

## 3. Information Technology Act, 2000 & Intermediary Guidelines Rules, 2021

| Mandate | Requirement | Platform Implementation | Verification Status |
| :--- | :--- | :--- | :--- |
| **Section 79 (Safe Harbor)** | Intermediary status requires due diligence, publication of Terms of Service, Privacy Policy, and non-hosting of unlawful content. | Comprehensive Terms & Privacy documentation with clear acceptable use policies published. | **DOCUMENTED** |
| **Rule 3(2) (Grievance Officer)** | Prominent publication of the name and contact details of a Grievance Officer resident in India; acknowledgement of complaints within 24-48 hours. | Grievance Officer details published in `docs/MESSLINK_PROJECT_REPORT.md` and public footer; automated ticket SLA tracking. | **DOCUMENTED** |
| **CERT-In Directions (2022)** | Mandatory 6-hour cybersecurity incident reporting; synchronization of system clocks with NTP server (National Physical Laboratory); 180-day log preservation. | Time-stamped JSON structured logging with NTP synchronization to `time.nplindia.org` (`Asia/Kolkata`). | **ARCHITECTED** |

---

## 4. Goods and Services Tax (GST) & Invoicing Compliance

| Mandate | Requirement | Platform Implementation | Verification Status |
| :--- | :--- | :--- | :--- |
| **SAC Code 996333** | Outdoor catering / mess food services provided without input tax credit (ITC) attract 5% GST. Composite mess operators under composition scheme pay 5%. | Ledger engine supports configurable tax rules: Displays gross price, SGST (2.5%), and CGST (2.5%) on digital invoices. | **ENFORCED IN LEDGER** |
| **Invoicing Rules** | Sequential digital invoice numbering, buyer GSTIN (if corporate), supplier GSTIN, and reverse-charge declaration where applicable. | System generates serial tax receipts (`ML-INV-2026-XXXX`) upon payment confirmation with downloadable PDF receipt. | **ARCHITECTED** |

---

## 5. Reserve Bank of India (RBI) Payment Aggregator Guidelines

| Mandate | Requirement | Platform Implementation | Verification Status |
| :--- | :--- | :--- | :--- |
| **Card Data Storage** | Prohibition on merchants and non-bank entities storing actual card credentials (PAN, CVV, PIN). | Zero card data captured or saved. All card and UPI interactions delegated directly to RBI-authorized Razorpay gateway. | **STRICT COMPLIANCE** |
| **Settlement Timelines** | Timely settlement to mess owners on T+1 / T+2 banking day cycle. | Settlement ledger engine tracks escrow balance and releases payouts on verified delivery. | **DESIGNED** |
