//
//  LoginView.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var session: SessionManager
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color(nsColor: .windowBackgroundColor)
                .ignoresSafeArea()
            
            HStack(spacing: 0) {
                
                // MARK: - Left Panel (Branding)
                VStack(alignment: .leading, spacing: 32) {
                    
                    // Logo & Title Group
                    VStack(alignment: .leading, spacing: 12) {
                        Image(systemName: "storefront.fill")
                            .font(.system(size: 42))
                            .foregroundStyle(.white)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.white.opacity(0.2))
                                    .shadow(color: .black.opacity(0.1), radius: 5, y: 5)
                            )
                        
                        Text("BrewLedger") // Disesuaikan dengan nama project
                            .font(.system(size: 38, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Sistem Point of Sale Modern")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.85))
                    }
                    
                    // Feature List
                    VStack(alignment: .leading, spacing: 16) {
                        FeatureRow(icon: "chart.pie.fill", text: "Manajemen Penjualan")
                        FeatureRow(icon: "cube.box.fill", text: "Kontrol Inventori")
                        FeatureRow(icon: "bolt.horizontal.fill", text: "Laporan Real-time")
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Demo Credentials (Menggunakan Material Blur)
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Demo Credentials", systemImage: "info.circle.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Admin: satriyadm9311 / admin9311")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .textSelection(.enabled) // Agar user bisa copy text
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .dark) // Memaksa blur menjadi gelap/elegan di atas gradient
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(40)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [Color.orange, Color.red],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                
                // MARK: - Right Panel (Login Form)
                VStack(alignment: .leading, spacing: 24) {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Selamat Datang")
                            .font(.system(size: 32, weight: .bold))
                        
                        Text("Silakan login untuk melanjutkan")
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 8)
                    
                    // Form Fields
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Username")
                                .font(.callout)
                                .fontWeight(.medium)
                            
                            TextField("Masukkan username", text: $vm.username)
                                .textFieldStyle(.roundedBorder)
                                .controlSize(.large) // Ukuran input yang lebih nyaman di macOS
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.callout)
                                .fontWeight(.medium)
                            
                            SecureField("Masukkan password", text: $vm.password)
                                .textFieldStyle(.roundedBorder)
                                .controlSize(.large)
                        }
                    }
                    
                    // Error Message
                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.callout)
                            .transition(.opacity)
                    }
                    
                    // Login Button
                    Button {
                        Task {
                            await vm.login(session: session)
                        }
                    } label: {
                        Text("Masuk")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                LinearGradient(
                                    colors: [Color.orange, Color.red],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: .orange.opacity(0.3), radius: 5, y: 3)
                    }
                    .buttonStyle(.plain) // Mencegah gaya default button macOS yang kaku
                    .padding(.top, 12)
                    
                    Spacer()
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 40)
                .frame(width: 420) // Lebar tetap untuk form login agar proporsional
                .background(Color(nsColor: .controlBackgroundColor))
            }
            .frame(width: 850, height: 500) // Ukuran window diperkecil sedikit agar lebih solid
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.2), radius: 30, x: 0, y: 15) // Bayangan macOS
        }
        .frame(minWidth: 1000, minHeight: 650) // Area aman untuk meletakkan window
    }
}

// MARK: - Subviews
/// Komponen reusable untuk list fitur di panel kiri
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .frame(width: 24)
                .foregroundColor(.white)
            
            Text(text)
                .font(.title3)
                .foregroundColor(.white.opacity(0.9))
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(SessionManager())
}
