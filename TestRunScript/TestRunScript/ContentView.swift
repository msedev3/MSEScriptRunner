//
//  ContentView.swift
//  TestRunScript
//
//  Created by Moosa Mir on 11/14/1403 AP.
//

import SwiftUI

struct ContentView: View {
    private let viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
