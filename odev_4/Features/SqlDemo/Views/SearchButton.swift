//
//  SearchButton.swift
//  odev_4
//
//  Created by Gürhan Kuraş on 13.11.2021.
//

import Foundation
import SwiftUI

struct SearchButton: View {
    @ObservedObject var viewModel: SqlDemoViewModel
    
    var body: some View {
        AppTextButton(text: "Search", action: viewModel.search)
            .alert("Key not found!",
                   isPresented: $viewModel.showNotFoundAlert) {
                        Button("Dismiss", role: .cancel) { }
                    }
    }
}


struct AppTextButton: View {
    let text: String
    let action: () -> Void
    let color: Color = Color.purple
    
    var body: some View {
        Button(action: action,
               label: {
                Text(text)
                    .font(.footnote)
                    .bold()
        })
            .padding(.all, 10)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(30)
    }
}
