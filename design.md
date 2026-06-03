# BrewLedger macOS Design Specification

Version: 1.0
Target Platform: macOS (SwiftUI)
Architecture: SwiftUI + Node/Spring Backend + Supabase PostgreSQL

---

# 1. Design Goals

BrewLedger harus:

- Cepat digunakan kasir
- Mudah digunakan staf gudang
- Menyediakan dashboard manajemen
- Memiliki workflow minimal
- Menampilkan informasi penting secara realtime
- Menyesuaikan tampilan berdasarkan role user

Design principles:

- Minimal click workflow
- Editorial modern UI
- Large spacing
- Soft shadows
- Context-aware navigation
- Keyboard shortcut friendly
- Native macOS behavior

---

# 2. Application Structure

App
│
├── Authentication
│
├── Dashboard
│
├── POS
│
├── Product Management
│
├── Inventory
│
├── Suppliers
│
├── Purchase Orders
│
├── Reports
│
├── Audit Logs
│
└── Profile

---

# 3. Role-Based Navigation

ADMIN

Dashboard
POS
Products
Inventory
Suppliers
Purchase Orders
Reports
Audit
Users
Settings

MANAGEMENT

Dashboard
Products
Reports

GUDANG

Inventory
Suppliers
Purchase Orders
Audit

KASIR

POS
Transactions

---

# 4. Authentication Flow

Launch App

↓

Check token

↓

If token exists:

Validate token

↓

Dashboard

Else:

Show Login Screen

---

Login request:

POST /api/auth/login

Response:

token
role
username

Store:

- Keychain (JWT)
- AppStorage (lightweight preferences)

---

# 5. Dashboard Screen

Layout:

Top Header

- greeting
- profile
- notifications

Statistics Cards

- Total Products
- Total Sales
- Total Transactions
- Total Ingredients

Middle Section

Sales Chart

Low Stock Alerts

Recent Transactions

Recent Purchase Orders

---

# 6. POS Screen

Layout:

LEFT

Categories

CENTER

Product Grid

RIGHT

Cart

BOTTOM

Checkout section

Features:

Search product

Keyboard shortcuts

Quick quantity editing

Discount support

Tax display

Multiple payment:

- CASH
- QRIS

Auto stock validation

---

Checkout flow:

Add product

↓

Add quantity

↓

Checkout

↓

POST /api/transactions

↓

Success popup

↓

Print receipt

↓

Clear cart

---

# 7. Inventory Screen

Sections:

Ingredients table

Columns:

Name
Current Stock
Minimum Stock
Supplier
Unit

Indicators:

Green

Safe stock

Yellow

Low stock warning

Red

Critical stock

Actions:

Create
Edit
Delete
Restock

---

# 8. Purchase Order Screen

Layout:

PO List

↓

PO Detail

↓

Items

↓

Receive

Workflow:

Create Purchase Order

↓

Add Items

↓

Send Order

↓

Receive Goods

↓

Automatic stock update

---

# 9. Reports Screen

Cards:

Daily Sales

Weekly Sales

Monthly Sales

Top Selling Products

Low Stock Products

Charts:

Line chart

Bar chart

Pie chart

Export:

PDF

CSV

---

# 10. Notification System

Low stock alerts

Purchase received

Transaction success

Error notifications

Display:

Top-right notification center

---

# 11. Error Handling

401:

Logout

Redirect Login

400:

Show validation message

409:

Show:

"Stok tidak mencukupi"

500:

Show:

"Terjadi kesalahan server"

---

# 12. Suggested SwiftUI Folder Structure

App/
│
├── Models
├── Services
├── ViewModels
├── Views
│
├── Auth
├── Dashboard
├── POS
├── Inventory
├── Product
├── PurchaseOrder
├── Reports
│
├── Components
│
├── Utilities
│
└── Resources

---

# 13. API Layer

AuthService

DashboardService

ProductService

InventoryService

PurchaseOrderService

TransactionService

ReportService

---

# 14. Future Features

Offline mode

Sync queue

Receipt printing

Barcode scanner

Kitchen display

Customer loyalty

Analytics

Multi outlet

Multi cashier

Dark mode customization

Realtime dashboard
