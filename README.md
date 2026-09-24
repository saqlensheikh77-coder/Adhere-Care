# AdhereCare AI: AI-Powered Medication Adherence & Reminder System (PS-01)

A Progressive Web App (PWA) and clinical monitoring system designed for patients managing long-term chronic diseases (Type 2 Diabetes, Hypertension, Dyslipidemia, Heart Failure) and their caregivers & pharmacists.

---

## 🌟 Key Features Addressing PS-01

### 1. Patient Companion Mobile PWA
- **Context-Aware Visual Dose Schedule**: Chronological dose timeline (Morning, Afternoon, Evening, Bedtime) with visual badges and food pairing instructions.
- **One-Tap Actions**: One-click "Mark Taken", "+15m Snooze", or "Skip Dose" with clinical rationale logging.
- **Refill Runway & Stockout Warnings**: Real-time decrementing pill counts that trigger low-stock alerts when $\le 5$ days of supply remain.

### 2. AI Adaptive Routine & Risk Intelligence
- **Dynamic Biorhythm & Routine Adaptation**: Patients with chronic diseases frequently shift waking or meal schedules. The AI dynamically calculates schedule shifts to preserve absorption kinetics (e.g., shifting morning Metformin when breakfast is delayed) while maintaining a strict $\ge 4$-hour therapeutic window before subsequent doses.
- **Predictive Adherence Risk Index (ARI)**: Models non-adherence probability by factoring in historical compliance streaks, time-of-day vulnerability, regimen complexity ($3+$ medications), and drug criticality.
- **Multi-Tier Escalation Protocol**:
  - **Level 1 (Scheduled Time)**: Gentle medical chime via browser Web Audio API.
  - **Level 2 (15m Overdue)**: Urgent alarm pulse + SpeechSynthesis voice prompt for seniors/visually impaired patients.
  - **Level 3 (45m Overdue)**: Automated emergency Caregiver WhatsApp / SMS notification with direct one-click dispatch link.

### 3. Pharmacist & Caregiver Tele-Monitoring Portal
- **Cohort Adherence Overview**: Real-time PDC (Proportion of Days Covered) compliance metric.
- **Automated Refill Management**: Pharmacists can review pending refills and click "Approve Refill (+60)" to restock patient inventory.
- **Clinical Intervention Logs**: Pharmacists can record adherence counseling notes directly on the patient profile.

### 4. Zero-Dependency Offline PWA Architecture
- **Web Audio API**: Browser-native harmonic oscillator producing medical chimes without requiring external audio files or CDNs.
- **Web Speech API**: Real-time text-to-speech for accessible voice notifications.
- **Service Worker (`sw.js`)**: Offline asset caching and local dose queueing when internet connectivity drops.

---

## 📂 Project Structure

```
C:\Users\ASUS\.gemini\antigravity\scratch\medication-adherence-pwa\
├── index.html                  # Mobile-first responsive app shell with status notch
├── manifest.json               # Progressive Web App manifest for home-screen installation
├── sw.js                       # Service worker for offline caching and dose sync
├── css/
│   └── styles.css              # Custom styling, mobile frame wrapper, animations
├── js/
│   ├── medication-data.js      # Patient seed data, chronic prescriptions, adherence logs
│   ├── audio.js                # Web Audio API synthesizers & SpeechSynthesis TTS
│   ├── ai-engine.js            # AI ARI risk scoring model & dynamic routine shifter
│   ├── caregiver.js            # Pharmacist & caregiver tele-monitoring portal logic
│   └── app.js                  # Application state controller and event handlers
└── README.md                   # Project documentation & presentation guide
```

---

## 🚀 How to Run & Test

### Option 1: Open Directly in Browser
You can open `index.html` in Chrome, Edge, Safari, or Firefox:
- Double-click `index.html` or drag and drop it into your browser.
- Install it as an app by clicking the **Install App** icon in your browser's address bar.

### Option 2: Live Interactive Preview in Antigravity
The standalone Generative UI artifact is located at:
`C:\Users\ASUS\.gemini\antigravity\brain\5905e672-b250-475e-aca0-4a9bce60fe97\adherecare_interactive_app.html`

---

## 🧪 Interactive Demo Scenarios

1. **Log a Dose**: On the **Today** tab, click **✓ Mark Taken** on Metformin. Notice the pill counter decrements, progress bar advances, and a harmonic chime plays.
2. **Test Routine Adaptation**: Go to the **AI Routine** tab and click **Woke Up Late (+45m)**. Switch back to **Today** to see morning doses dynamically shifted with safety constraints intact.
3. **Trigger Refill Alert**: Notice the banner for Glycomet-500 (4 pills left). Switch to **Meds** or **Caregiver** and click **Reorder Now** or **Approve Refill (+60)**.
4. **Test Escalation Protocol**: In the **AI Routine** tab, test Level 1 (Gentle Chime), Level 2 (Urgent Alarm + Voice), and Level 3 (Caregiver WhatsApp Alert).
