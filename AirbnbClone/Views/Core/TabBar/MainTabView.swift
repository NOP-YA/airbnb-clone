import SwiftUI
import Inject

struct MainTabView: View {
    @ObserveInjection var inject
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }

            
            WishlistView()
                .tabItem {
                    Label("Wishlists", systemImage: "heart")
                }
            
            ProfileView()
                .tabItem {
                    Label("profile", systemImage: "person")
                }
        }
        .enableInjection()
    }
}

#Preview {
    MainTabView()
} 