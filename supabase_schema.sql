-- FolioTrack — Supabase Schema
-- Paste this entire file into Supabase Dashboard → SQL Editor → Run

-- Enable RLS (Row Level Security) — each user sees only their own data
-- All tables use auth.uid() from Supabase Auth

-- ── Profiles ────────────────────────────────────────────────────────────────
CREATE TABLE profiles (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  name TEXT NOT NULL,
  color TEXT DEFAULT '#0d9488',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own profiles" ON profiles USING (user_id = auth.uid());
CREATE POLICY "insert profiles" ON profiles FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update profiles" ON profiles FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete profiles" ON profiles FOR DELETE USING (user_id = auth.uid());

-- ── Mutual Funds ─────────────────────────────────────────────────────────────
CREATE TABLE mutual_funds (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  name TEXT, code TEXT, type TEXT,
  units NUMERIC DEFAULT 0, nav NUMERIC DEFAULT 0,
  invested NUMERIC DEFAULT 0, current_value NUMERIC DEFAULT 0,
  profile_id TEXT, folio TEXT,
  sip NUMERIC DEFAULT 0, sip_date INT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE mutual_funds ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own mf" ON mutual_funds USING (user_id = auth.uid());
CREATE POLICY "insert mf" ON mutual_funds FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update mf" ON mutual_funds FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete mf" ON mutual_funds FOR DELETE USING (user_id = auth.uid());

-- ── Stocks ───────────────────────────────────────────────────────────────────
CREATE TABLE stocks (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  name TEXT, ticker TEXT, exchange TEXT,
  qty NUMERIC DEFAULT 0, avg_price NUMERIC DEFAULT 0,
  current_price NUMERIC DEFAULT 0, invested NUMERIC DEFAULT 0,
  profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE stocks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own stocks" ON stocks USING (user_id = auth.uid());
CREATE POLICY "insert stocks" ON stocks FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update stocks" ON stocks FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete stocks" ON stocks FOR DELETE USING (user_id = auth.uid());

-- ── Bank Accounts ────────────────────────────────────────────────────────────
CREATE TABLE bank_accounts (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  bank_name TEXT, account_no TEXT, account_type TEXT,
  balance NUMERIC DEFAULT 0, ifsc TEXT, branch TEXT,
  profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE bank_accounts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own banks" ON bank_accounts USING (user_id = auth.uid());
CREATE POLICY "insert banks" ON bank_accounts FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update banks" ON bank_accounts FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete banks" ON bank_accounts FOR DELETE USING (user_id = auth.uid());

-- ── Fixed Deposits ───────────────────────────────────────────────────────────
CREATE TABLE fixed_deposits (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  bank_name TEXT, principal NUMERIC DEFAULT 0,
  rate NUMERIC DEFAULT 0, tenure INT DEFAULT 12,
  start_date DATE, maturity_date DATE,
  current_value NUMERIC DEFAULT 0, maturity_value NUMERIC DEFAULT 0,
  fd_no TEXT, profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE fixed_deposits ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own fd" ON fixed_deposits USING (user_id = auth.uid());
CREATE POLICY "insert fd" ON fixed_deposits FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update fd" ON fixed_deposits FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete fd" ON fixed_deposits FOR DELETE USING (user_id = auth.uid());

-- ── Policies ─────────────────────────────────────────────────────────────────
CREATE TABLE policies (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  insurer TEXT, policy_name TEXT, policy_no TEXT, type TEXT,
  premium NUMERIC DEFAULT 0, frequency TEXT,
  sum_assured NUMERIC DEFAULT 0, maturity_value NUMERIC DEFAULT 0,
  maturity_date DATE, next_due DATE,
  profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE policies ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own policies" ON policies USING (user_id = auth.uid());
CREATE POLICY "insert policies" ON policies FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update policies" ON policies FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete policies" ON policies FOR DELETE USING (user_id = auth.uid());

-- ── Savings ──────────────────────────────────────────────────────────────────
CREATE TABLE savings (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  name TEXT, type TEXT,
  balance NUMERIC DEFAULT 0, rate NUMERIC DEFAULT 0,
  invested NUMERIC DEFAULT 0, account_no TEXT, pran TEXT,
  profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE savings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own savings" ON savings USING (user_id = auth.uid());
CREATE POLICY "insert savings" ON savings FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update savings" ON savings FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete savings" ON savings FOR DELETE USING (user_id = auth.uid());

-- ── Other Assets ─────────────────────────────────────────────────────────────
CREATE TABLE other_assets (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  name TEXT, type TEXT,
  quantity NUMERIC DEFAULT 0, unit TEXT,
  current_rate NUMERIC DEFAULT 0, current_value NUMERIC DEFAULT 0,
  cost_value NUMERIC DEFAULT 0, profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE other_assets ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own others" ON other_assets USING (user_id = auth.uid());
CREATE POLICY "insert others" ON other_assets FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update others" ON other_assets FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete others" ON other_assets FOR DELETE USING (user_id = auth.uid());

-- ── Credit Cards ─────────────────────────────────────────────────────────────
CREATE TABLE credit_cards (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  bank TEXT, name TEXT, card_no TEXT,
  credit_limit NUMERIC DEFAULT 0, outstanding NUMERIC DEFAULT 0,
  min_due NUMERIC DEFAULT 0, due_date DATE,
  profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE credit_cards ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own cc" ON credit_cards USING (user_id = auth.uid());
CREATE POLICY "insert cc" ON credit_cards FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update cc" ON credit_cards FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete cc" ON credit_cards FOR DELETE USING (user_id = auth.uid());

-- ── Loans ────────────────────────────────────────────────────────────────────
CREATE TABLE loans (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  lender TEXT, type TEXT, loan_no TEXT,
  principal NUMERIC DEFAULT 0, outstanding NUMERIC DEFAULT 0,
  emi NUMERIC DEFAULT 0, rate NUMERIC DEFAULT 0,
  tenure INT DEFAULT 0, paid INT DEFAULT 0,
  next_emi DATE, profile_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE loans ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own loans" ON loans USING (user_id = auth.uid());
CREATE POLICY "insert loans" ON loans FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update loans" ON loans FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete loans" ON loans FOR DELETE USING (user_id = auth.uid());

-- ── Reminders ────────────────────────────────────────────────────────────────
CREATE TABLE reminders (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL DEFAULT auth.uid(),
  title TEXT, type TEXT,
  amount NUMERIC DEFAULT 0, due_date DATE,
  priority TEXT DEFAULT 'medium',
  repeat_type TEXT, done BOOLEAN DEFAULT FALSE,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE reminders ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own reminders" ON reminders USING (user_id = auth.uid());
CREATE POLICY "insert reminders" ON reminders FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update reminders" ON reminders FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "delete reminders" ON reminders FOR DELETE USING (user_id = auth.uid());

-- ── Retirement Settings ──────────────────────────────────────────────────────
CREATE TABLE retirement_settings (
  user_id UUID PRIMARY KEY DEFAULT auth.uid(),
  current_age INT DEFAULT 30,
  retirement_age INT DEFAULT 60,
  life_expectancy INT DEFAULT 85,
  monthly_expense NUMERIC DEFAULT 50000,
  inflation NUMERIC DEFAULT 6,
  return_rate NUMERIC DEFAULT 12,
  monthly_sip NUMERIC DEFAULT 10000,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE retirement_settings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own retirement" ON retirement_settings USING (user_id = auth.uid());
CREATE POLICY "insert retirement" ON retirement_settings FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "update retirement" ON retirement_settings FOR UPDATE USING (user_id = auth.uid());
