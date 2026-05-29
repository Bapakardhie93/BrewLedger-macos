//
//  DashboardView.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    // Konfigurasi Grid responsif: Lebar kartu minimal 220px
    private let columns = [
        GridItem(.adaptive(minimum: 220, maximum: 350), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            // Background Dashboard
            Color(nsColor: .windowBackgroundColor)
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                // Tampilan Loading
                VStack(spacing: 16) {
                    ProgressView()
                        .controlSize(.large)
                    Text("Memuat Data...")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            } else if let dashboard = viewModel.dashboard {
                // Tampilan Data Utama
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // Header
                        Text("Dashboard")
                            .font(.system(size: 32, weight: .bold))
                            .padding(.bottom, 8)
                        
                        // Grid Kartu Metrik
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            DashboardCard(
                                title: "Produk",
                                value: "\(dashboard.totalProducts)",
                                icon: "cup.and.saucer.fill",
                                color: .blue
                            )
                            
                            DashboardCard(
                                title: "Bahan Baku",
                                value: "\(dashboard.totalIngredients)",
                                icon: "leaf.fill",
                                color: .green
                            )
                            
                            DashboardCard(
                                title: "Supplier",
                                value: "\(dashboard.totalSuppliers)",
                                icon: "truck.box.fill",
                                color: .orange
                            )
                            
                            DashboardCard(
                                title: "Transaksi",
                                value: "\(dashboard.totalTransactions)",
                                icon: "creditcard.fill",
                                color: .purple
                            )
                            
                            DashboardCard(
                                title: "Total Penjualan",
                                value: "Rp \(dashboard.totalSales)",
                                icon: "chart.line.uptrend.xyaxis",
                                color: .red
                            )
                            
                            DashboardCard(
                                title: "Mutasi Stok",
                                value: "\(dashboard.totalStockMovements)",
                                icon: "arrow.left.arrow.right.square.fill",
                                color: .teal
                            )
                        }
                    }
                    .padding(30)
                }
            } else {
                // Tampilan Error / Data Kosong
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.errorMessage ?? "Tidak ada data yang tersedia.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Button("Coba Lagi") {
                        Task { await viewModel.loadDashboard() }
                    }
                    .padding(.top, 8)
                }
            }
        }
        .task {
            await viewModel.loadDashboard()
        }
    }
}

// MARK: - Subviews
/// Komponen Kartu untuk menampilkan setiap metrik di Dashboard
struct DashboardCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Ikon di pojok kiri atas
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                    .frame(width: 44, height: 44)
                    .background(color.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
            }
            
            // Teks Nilai dan Judul
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(title)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(nsColor: .controlBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        // Shadow halus bergaya macOS
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    DashboardView()
}
