-- Migration: Add subscription fields to profiles table
-- Run this in Supabase SQL Editor: https://supabase.com/dashboard/project/YOUR_PROJECT/sql

-- Add subscription columns to profiles table
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS stripe_customer_id TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS stripe_subscription_id TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS subscription_status TEXT DEFAULT 'free';
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS subscription_tier TEXT DEFAULT 'free';
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS subscription_ends_at TIMESTAMPTZ;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_profiles_stripe_customer_id ON profiles(stripe_customer_id);
CREATE INDEX IF NOT EXISTS idx_profiles_subscription_status ON profiles(subscription_status);

-- Add check constraint for valid subscription statuses
ALTER TABLE profiles DROP CONSTRAINT IF EXISTS valid_subscription_status;
ALTER TABLE profiles ADD CONSTRAINT valid_subscription_status
  CHECK (subscription_status IN ('free', 'active', 'cancelled', 'past_due', 'trialing'));

-- Add check constraint for valid tiers
ALTER TABLE profiles DROP CONSTRAINT IF EXISTS valid_subscription_tier;
ALTER TABLE profiles ADD CONSTRAINT valid_subscription_tier
  CHECK (subscription_tier IN ('free', 'pro', 'enterprise'));
