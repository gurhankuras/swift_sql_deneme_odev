//
//  SqlDemoView.swift
//  odev_4
//
//  Created by Gürhan Kuraş on 13.11.2021.
//

import Foundation
import SwiftUI

struct SqlDemoView: View {
    @StateObject var viewModel: SqlDemoViewModel = SqlDemoViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Key", text: $viewModel.keyInput)
                    .lineLimit(1)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SearchButton(viewModel: viewModel)
            }
            .padding()
            Text(viewModel.value)
        }
    }
}
