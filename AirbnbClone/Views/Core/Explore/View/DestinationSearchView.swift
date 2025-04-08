//
//  DestinationSearchView.swift
//  AirbnbClone
//
//  Created by Henry on 3/24/25.
//

import SwiftUI
import Inject

enum DestinationSearchOptions {
    case locations
    case dates
    case guests
}

struct DestinationSearchView: View {
    @ObserveInjection var inject
    @Binding var show: Bool
    @State private var destination = ""
    @State private var selectedOption: DestinationSearchOptions = .locations
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var numGuests = 1
    @ObservedObject var viewModel : ExploreViewModel

    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.updateListingsForLocation()
                        show.toggle()
                    }
                } label : {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.black)
                        .imageScale(.large)
                }

                Spacer()
                
                if !viewModel.searchedLocation.isEmpty {
                    Button("Clear") { 
                        viewModel.searchedLocation = ""
                        viewModel.updateListingsForLocation()
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
            .padding()
            
            VStack(alignment: .leading) {
                if selectedOption == .locations {
                    Text("Where to?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.small)
                        
                        TextField("Search destination", text: $viewModel.searchedLocation)
                            .font(.subheadline)
                            .onSubmit {
                                 viewModel.updateListingsForLocation()
                                 show.toggle()
                            }
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.0)
                            // .foregroundStyle(Color(.systemGray4))
                    }
                } else {
                    CollapsedPickerView(title: "Where", description: "Add destination")
                }
            }
            .modifier(CollapsibleDestinationViewModifier()) 
            .frame(height: selectedOption == .locations ? 120 : 64)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selectedOption = .locations
                }
            }
            
            // date selection view
            
            VStack {
                if selectedOption == .dates {
                    Text("When's your trip?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading) {
                        DatePicker("From", selection: $startDate, displayedComponents: .date)
                        
                        Divider()
                        
                        DatePicker("To", selection: $endDate, displayedComponents: .date)
                    }
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                } else {
                    CollapsedPickerView(title: "When", description: "Add dates")
                }
            }
            .modifier(CollapsibleDestinationViewModifier()) 
            .frame(height: selectedOption == .dates ? 180 : 64)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selectedOption = .dates
                }
            }
            // num guests view
            VStack(alignment: .leading) {
                if selectedOption == .guests {
                    Text("Who's coming?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading) {
                        Text("Who's coming?")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Stepper {
                            Text("\(numGuests) Adults")
                        } onIncrement: {
                            numGuests += 1
                        } onDecrement: {
                            guard numGuests > 1 else { return }
                            numGuests -= 1
                        }
                    }
                    
                } else {
                    CollapsedPickerView(title: "Who", description: "Add guests")
                }
            }
            .modifier(CollapsibleDestinationViewModifier()) 
            .frame(height: selectedOption == .guests ? 120 : 64)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) { selectedOption = .guests }
            }
            .enableInjection()
            Spacer()
        }
    }
}
#Preview {
    DestinationSearchView(show: .constant(false), viewModel: ExploreViewModel(service: ExploreService()))
}

struct CollapsibleDestinationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
    }
}

struct CollapsedPickerView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(description)
            }
            .font(.subheadline)
            .fontWeight(.semibold)
        }
    }
}
