-- Taxi Registration database schema (Supabase / PostgreSQL)
-- Run this in Supabase SQL Editor after creating a project.
-- Payment must be verified server-side by a payment-provider webhook before
-- changing payment_status to 'paid' or exposing records to Taxi Management.

create extension if not exists pgcrypto;

create table if not exists public.taxi_rent_registrations (
  id uuid primary key default gen_random_uuid(),
  vehicle_number text not null,
  model_number text not null,
  full_name text not null,
  mobile text not null check (mobile ~ '^[6-9][0-9]{9}$'),
  start_date date not null,
  end_date date not null,
  payment_amount integer not null default 99 check (payment_amount = 99),
  payment_status text not null default 'pending' check (payment_status in ('pending','paid','failed','refunded')),
  payment_reference text,
  created_at timestamptz not null default now(),
  constraint rent_dates_valid check (end_date >= start_date)
);

create table if not exists public.taxi_driver_job_registrations (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  mobile text not null check (mobile ~ '^[6-9][0-9]{9}$'),
  start_date date not null,
  end_date date not null,
  payment_amount integer not null default 99 check (payment_amount = 99),
  payment_status text not null default 'pending' check (payment_status in ('pending','paid','failed','refunded')),
  payment_reference text,
  created_at timestamptz not null default now(),
  constraint driver_dates_valid check (end_date >= start_date)
);

-- Enable Row Level Security. Public visitors must not read registration data.
alter table public.taxi_rent_registrations enable row level security;
alter table public.taxi_driver_job_registrations enable row level security;

-- No public SELECT/UPDATE/DELETE policies are intentionally created.
-- Add narrowly scoped server-side policies only after authentication and
-- payment webhook verification have been implemented.
