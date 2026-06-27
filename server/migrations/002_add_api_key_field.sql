-- Migration: Add api_key field to profiles table
-- Run this in Supabase SQL Editor: https://supabase.com/dashboard/project/vxleqperdjyqnbucqnkt/sql

ALTER TABLE profiles ADD COLUMN IF NOT EXISTS api_key TEXT UNIQUE;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_profiles_api_key ON profiles(api_key);
