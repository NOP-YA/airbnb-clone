//
//  SearchAndFilter.swift
//  AirbnbClone
//
//  Created by Henry on 3/14/25.
//

import SwiftUI
import Inject

struct SearchAndFilterBar: View {
    @ObserveInjection var inject
    @Binding var location : String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            VStack(alignment: .leading, spacing: 2) {
                Text(location.isEmpty ? "Where to?" : location)
                    .font(.footnote)
                    .fontWeight(.semibold)

                Text("\(location.isEmpty ? "Anywhere - " : "") - Any week - Add guests")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            Spacer()

            Button {
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundStyle(.black)
            }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(Color(.systemGray4))
                    .shadow(color: .black.opacity(0.4), radius: 2)
            )
        .padding()
        .enableInjection()
    }
}

#Preview {
    SearchAndFilterBar(location: .constant("Los Angeles"))
}
