import Foundation


class ExploreViewModel: ObservableObject {
    @Published var listings = [Listing]()
    @Published var searchedLocation : String = ""
    private let service: ExploreService
    private var listingsCopy = [Listing]() // 5

    init(service: ExploreService) {
        self.service = service

        Task {
            try await fetchListings()
        }
    }

    func fetchListings() async throws {
        do {
            self.listings =  try await service.fetchListings() 
            self.listingsCopy = listings
        } catch {
            print("DEBUG: Error fetching listings \(error.localizedDescription)")
        }
    }

    func updateListingsForLocation() {
        let filteredListings = listings.filter ( {
            $0.city.lowercased() == searchedLocation.lowercased() || $0.state.lowercased() == searchedLocation.lowercased() 
        })
        self.listings = filteredListings.isEmpty ? listingsCopy : filteredListings
    }
}