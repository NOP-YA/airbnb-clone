
//
//  Created by Henry on 3/13/25.
//

import SwiftUI
import Inject

struct ContentView: View {
    @ObserveInjection var inject

    var body: some View {
            VStack {
                Text("Hello, world!")
            }
            .padding()
            .enableInjection()
    }
}

#Preview {
    ContentView()
}
