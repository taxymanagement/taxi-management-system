-- Taxi Registration schema: ₹99 per registration, paid records are admin-verified.
-- Run in Supabase SQL Editor. Keep public access disabled; verify UPI payments
-- against the merchant bank/UPI statement before setting payment_status='paid'.

create extension if not exists pgcrypto;

create table if not exists public.taxi_rent_registrations (
  id uuid primary key default gen_random_uuid(),
  registration_number text unique,
  full_name text not null,
  address text not null,
  mobile text not null check (mobile ~ '^[6-9][0-9]{9}$'),
  vehicle_name text not null,
  vehicle_year integer not null check (vehicle_year between 1980 and 2035),
  payment_amount integer not null default 99 check (payment_amount = 99),
  payment_status text not null default 'pending' check (payment_status in ('pending','paid','failed','refunded')),
  payment_reference text,
  created_at timestamptz not null default now()
);

create table if not exists public.taxi_driver_job_registrations (
  id uuid primary key default gen_random_uuid(),
  registration_number text unique,
  full_name text not null,
  address text not null,
  mobile text not null check (mobile ~ '^[6-9][0-9]{9}$'),
  license_number text not null,
  payment_amount integer not null default 99 check (payment_amount = 99),
  payment_status text not null default 'pending' check (payment_status in ('pending','paid','failed','refunded')),
  payment_reference text,
  created_at timestamptz not null default now()
);

alter table public.taxi_rent_registrations enable row level security;
alter table public.taxi_driver_job_registrations enable row level security;
-- Intentionally no public SELECT/INSERT/UPDATE/DELETE policies.
-- Create registrations and verify payment only through a trusted server/admin workflow.
