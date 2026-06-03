import SwiftUI

struct UserFormView: View {
    @Environment(\.dismiss) var dismiss
    
    var user: UserResponse?
    @ObservedObject var viewModel: UserViewModel
    
    @State private var fullName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var roleId: Int = 1
    
    @State private var isSaving = false
    @State private var errorMessage: String? = nil
    
    let roles = [
        (1, "ADMIN"),
        (2, "MANAGEMENT"),
        (3, "GUDANG"),
        (4, "KASIR")
    ]
    
    var isEditing: Bool {
        user != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(isEditing ? "Edit Pengguna" : "Tambah Pengguna")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(NSColor.windowBackgroundColor))
            
            Divider()
            
            Form {
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Section {
                    TextField("Nama Lengkap", text: $fullName)
                    TextField("Username", text: $username)
                    
                    if isEditing {
                        SecureField("Password (Kosongkan jika tidak diubah)", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Picker("Role", selection: $roleId) {
                        ForEach(roles, id: \.0) { role in
                            Text(role.1).tag(role.0)
                        }
                    }
                }
            }
            .padding()
            
            Divider()
            
            HStack {
                Button("Batal") {
                    dismiss()
                }
                .keyboardShortcut(.cancelAction)
                
                Spacer()
                
                Button("Simpan") {
                    Task {
                        await saveUser()
                    }
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
                .disabled(isSaving || fullName.isEmpty || username.isEmpty || (!isEditing && password.isEmpty))
            }
            .padding()
            .background(Color(NSColor.windowBackgroundColor))
        }
        .frame(width: 400, height: 350)
        .onAppear {
            if let user = user {
                fullName = user.fullName
                username = user.username
                
                if let matchedRole = roles.first(where: { $0.1 == user.role.name }) {
                    roleId = matchedRole.0
                }
            }
        }
    }
    
    private func saveUser() async {
        isSaving = true
        errorMessage = nil
        
        do {
            if let user = user {
                let request = UpdateUserRequest(
                    fullName: fullName,
                    username: username,
                    password: password.isEmpty ? nil : password,
                    roleId: roleId
                )
                _ = try await UserService.shared.updateUser(id: user.id, request: request)
            } else {
                let request = CreateUserRequest(
                    fullName: fullName,
                    username: username,
                    password: password,
                    roleId: roleId
                )
                _ = try await UserService.shared.createUser(request: request)
            }
            
            await viewModel.fetchUsers()
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isSaving = false
    }
}
