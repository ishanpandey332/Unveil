# 🔍 Unveil — Enterprise AI Content Detection Platform

> **Unveil** is a comprehensive, production-grade SaaS platform designed to detect synthetic media across **text, URLs, images, videos, and news claims**. Backed by advanced statistical heuristics, vision classifiers, and LLMs, Unveil helps organizations and developers establish trust in a digital-first world.

---

## 🚀 Live Demo

**Web Application**: **[https://unveil-drab-chi.vercel.app](https://unveil-drab-chi.vercel.app)**  
**Developer Hub**: `/docs` (API access console)  
**Accuracy Benchmarks**: `/benchmarks` (ROC curves and evaluation datasets)

---

## 🖼️ User Interface Preview

| Landing Page | Dashboard | Detect Page |
| :---: | :---: | :---: |
| ![Landing Page](assets/landing.png) | ![Dashboard](assets/dashboard.png) | ![Detect Page](assets/detect.png) |

---

## ✨ Features

- 📝 **Text Analysis** — Deep structural and burstiness checks powered by LLaMA 3.3 70B with interactive phrase highlighting.
- 🖼️ **Image Vision Scanner** — Identifies synthetic patterns and metadata markers from generators like Midjourney v6 and DALL-E 3.
- 🎬 **Video Deepfake Analyzer** — Decomposes video files or streams frame-by-frame via `ffmpeg` sampling and scores keyframes with LLaMA 4 Scout.
- 📰 **Fake News claim Checker** — Integrates Google Fact Check API to compare inputs against verified journalistic claims.
- 🧩 **Chrome Extension** — MV3 browser companion to scan web content directly via the right-click context menu.

---

## 🛠️ Tech Stack

- **Frontend**: React + Vite + Tailwind CSS + Recharts (data visualization) + jsPDF (report generation)
- **Backend**: Node.js + Express + Razorpay SDK (subscriptions)
- **Database & Auth**: Supabase (PostgreSQL) + Row-Level Security
- **Core AI models**: LLaMA-3.3-70B, LLaMA-4-Scout-17B, Sightengine, ZeroGPT API

---

## ⚙️ Setup & Installation

### Prerequisites
- Node.js v18+
- `ffmpeg` installed on the system and added to your environmental `PATH`

### 1. Clone & Install
```bash
git clone https://github.com/ishanpandey332/Unveil.git
cd Unveil
```

### 2. Configure Backend
```bash
cd server
npm install
```

Create a `server/.env` file with the following variables:
```env
PORT=5000
SUPABASE_URL=your_supabase_project_url
SUPABASE_KEY=your_supabase_service_role_or_anon_key
GROQ_API_KEY=your_groq_api_key
SIGHTENGINE_USER=your_sightengine_user_id
SIGHTENGINE_SECRET=your_sightengine_secret
GOOGLE_FACT_CHECK_KEY=your_google_fact_check_api_key
JWT_SECRET=your_jwt_secret_signing_key



Start the backend:
```bash
npm run dev
```

### 3. Configure Frontend
```bash
cd ../client
npm install
npm run dev
```
Open **http://localhost:5173** to view the app.

---

## 🗄️ Database Schema & Migrations

Run these scripts in your **Supabase SQL Editor** to set up the tables:

### 1. Base Tables
```sql
create table profiles (
  id uuid references auth.users on delete cascade,
  name text,
  email text,
  created_at timestamp default now(),
  stripe_customer_id text,
  stripe_subscription_id text,
  subscription_status text default 'free',
  subscription_tier text default 'free',
  subscription_ends_at timestamp,
  primary key (id)
);

create table scans (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade,
  type text check (type in ('text', 'url', 'image', 'video', 'news')),
  input_preview text,
  result text check (result in ('ai', 'human')),
  confidence float,
  created_at timestamp default now()
);
```

### 2. Add Developer API Support (Migration)
```sql
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS api_key TEXT UNIQUE;
CREATE INDEX IF NOT EXISTS idx_profiles_api_key ON profiles(api_key);
```

---

## 🧩 Developer API Example
Authenticate by passing `x-api-key` in your headers.

**Request**:
```bash
curl -X POST "http://localhost:5000/api/detect/text" \
  -H "Content-Type: application/json" \
  -H "x-api-key: uv_live_your_key_here" \
  -d '{"text": "Your textual snippet to analyze..."}'
```

**Response**:
```json
{
  "success": true,
  "verdict": "ai",
  "confidence": 98.4,
  "scores": {
    "ai": 98,
    "human": 2
  }
}
```

---

## 👥 Team
Built by **Ishan Pandey** — B.Tech CSE, GL Bajaj Institute of Technology and Management.
*GitHub*: [ishanpandey332](https://github.com/ishanpandey332)

---

## 📄 License
MIT License
