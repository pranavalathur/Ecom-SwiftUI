import SwiftUI



struct DashboardView: View {
    var body: some View {
        TabView {
            // Home Tab
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Section 1 Tab
            CategoryView()
                .tabItem {
                    Label("Categories", image:  "categories")
                }
            
            // Section 2 Tab
            CartView()
                .tabItem {
                    Label("Cart", image: "cart")
                }
            
            // Section 3 Tab
            OffersView()
                .tabItem {
                    Label("Offers", image: "offers")
                }
            
            // Section 3 Tab
            AccountsView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
    }
}

// Example Views for Sections
struct CategoryView: View {
    var body: some View {
        VStack {
            Text("Categories")
                .font(.largeTitle)
            Text("Content for Section 1")
        }
    }
}

struct CartView: View {
    var body: some View {
        VStack {
            Text("Cart")
                .font(.largeTitle)
            Text("Content for Section 2")
        }
    }
}

struct OffersView: View {
    var body: some View {
        VStack {
            Text("Offers")
                .font(.largeTitle)
            Text("Content for Section 3")
        }
    }
}

struct AccountsView: View {
    var body: some View {
        VStack {
            Text("Account")
                .font(.largeTitle)
            Text("Content for Account")
        }
    }
}

#Preview {
    DashboardView()
}

