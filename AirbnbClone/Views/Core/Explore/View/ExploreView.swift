//
//  Created by Henry on 3/13/25.
//

import SwiftUI
import Inject

struct ExploreView: View {
    @ObserveInjection var inject

    @State private var showDestinationSearchView = false
    @StateObject var viewModel = ExploreViewModel(service: ExploreService())

    var body: some View {
        NavigationStack {

            if showDestinationSearchView {
                DestinationSearchView(show: $showDestinationSearchView, viewModel: viewModel)
            } else {
                VStack {
                    SearchAndFilterBar(location: $viewModel.searchedLocation)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showDestinationSearchView.toggle()
                            }
                        }
                    ScrollView {
                    LazyVStack(spacing: 32) {
                        ForEach(viewModel.listings) { listing in 
                            NavigationLink(value: listing) {
                                ListingItemView(listing: listing)
                                    .frame(height: 400) 
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }   
                        }
                    }
                    .padding()
                    .navigationDestination(for: Listing.self) { listing in
                            ListingDetailView(listing: listing)
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    }
                }
            }
        }
        .enableInjection()
    }
}

#Preview {
    ExploreView()
}
