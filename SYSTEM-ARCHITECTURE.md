# BrewLedger System Architecture

Version: 1.0

---

# High Level Architecture

┌────────────────────────────┐
│ BrewLedger macOS App │
│ SwiftUI │
└─────────────┬──────────────┘
│
│ HTTPS + JWT
│
┌─────────────▼──────────────┐
│ Backend API │
│ Node.js / Spring Boot │
└─────────────┬──────────────┘
│
│ ORM
│
┌─────────────▼──────────────┐
│ Supabase PostgreSQL │
└────────────────────────────┘

---

# Client Layer

Technology:

SwiftUI

Responsibilities:

- Render UI
- Authentication state
- Local cache
- Offline queue
- Token storage

Suggested Structure:

App

Models
Services
ViewModels
Views
Components
Utilities

---

# Token Flow

Login

POST:

/api/auth/login

↓

Response:

token

↓

Store:

Keychain

↓

Subsequent Request:

Authorization:

Bearer TOKEN

↓

Backend validates token

↓

Response

---

# API Layer

AuthService

DashboardService

ProductService

InventoryService

PurchaseOrderService

TransactionService

ReportService

---

# Backend Layer

Responsibilities:

Authentication

Business Rules

Inventory deduction

Role validation

Audit log

Reporting

Stock movement

---

# Database Layer

Tables:

users

roles

products

categories

ingredients

suppliers

product_recipes

purchase_orders

purchase_order_items

transactions

transaction_items

stock_movements

---

# Transaction Flow

Cashier checkout

↓

POST /transactions

↓

Validate stock

↓

Validate recipe

↓

Reduce inventory

↓

Create stock movement

↓

Save transaction

↓

Return success

---

# Offline Strategy

Internet disconnected

↓

Save transaction locally

↓

Sync queue

↓

Reconnect

↓

Upload pending transaction

---

# Security Layer

JWT Authentication

HTTPS

Password hashing

Keychain token storage

Role-based access control

---

# Deployment

Development:

SwiftUI Local

↓

Backend Local

↓

Supabase Cloud

Production:

macOS App

↓

api.brewledger.com

↓

Backend VPS

↓

Supabase PostgreSQL

---

# Future Scaling

Kitchen Display System

Realtime dashboard

Barcode scanner

Receipt printing

Multi outlet

Multi cashier

Analytics

Cloud synchronization
