import SwiftUI

struct UserManagementView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var showingForm = false
    @State private var selectedUser: UserResponse? = nil
    
    var body: some View {
        VStack {
            HStack {
                Text("Manajemen Akun")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    selectedUser = nil
                    showingForm = true
                }) {
                    Label("Tambah Pengguna", systemImage: "person.badge.plus")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else {
                Table(viewModel.users) {
                    TableColumn("ID") { user in
                        Text("\(user.id)")
                    }
                    TableColumn("Nama Lengkap", value: \.fullName)
                    TableColumn("Username", value: \.username)
                    TableColumn("Role") { user in
                        Text(user.role.name)
                    }
                    TableColumn("Status") { user in
                        Text(user.active ? "Aktif" : "Nonaktif")
                            .foregroundColor(user.active ? .green : .red)
                    }
                    TableColumn("Aksi") { user in
                        HStack {
                            Button("Edit") {
                                selectedUser = user
                                showingForm = true
                            }
                            Button(user.active ? "Nonaktifkan" : "Aktifkan") {
                                Task {
                                    await viewModel.toggleUserStatus(user: user)
                                }
                            }
                            Button("Hapus") {
                                Task {
                                    await viewModel.deleteUser(id: user.id)
                                }
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchUsers()
        }
        .sheet(isPresented: $showingForm) {
            UserFormView(user: selectedUser, viewModel: viewModel)
        }
    }
}
