import SwiftUI

struct MainView: View {
    @AppStorage("jwt_token") var token: String = ""
    @AppStorage("user_role") var role: String = ""
    
    @State private var selectedTab: String? = "dashboard"
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DashboardView(), tag: "dashboard", selection: $selectedTab) {
                    Label("Dashboard", systemImage: "chart.bar")
                }
                
                // Nanti bisa ditambahkan menu lainnya seperti POS, Products, dll
                // NavigationLink(destination: POSView(), tag: "pos", selection: $selectedTab) {
                //     Label("POS", systemImage: "cart")
                // }
                
                Spacer()
                
                Button(action: {
                    logout()
                }) {
                    Label("Logout", systemImage: "arrow.right.square")
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 10)
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200)
            
            // Default view jika tidak ada yang dipilih
            DashboardView()
        }
    }
    
    private func logout() {
        token = ""
        role = ""
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
