//
//  SqlDemoViewModel.swift
//  odev_4
//
//  Created by Gürhan Kuraş on 12.11.2021.
//

import Foundation


class SqlDemoViewModel: ObservableObject
{
    private let sqlManager: DBManager = SqlDemoManager()
    
    @Published var keyInput: String = ""
    @Published var value: String = ""
    @Published var showNotFoundAlert = false
    
    func search() -> Void {
        if keyInput.isEmpty { return }
        
        let foundValue = sqlManager.search(key: keyInput) ?? ""
        print("fonk calisti")
        value = foundValue
        
        if value.isEmpty {
            setShowNotFoundAlert(true)
        }
    }
    
    func setShowNotFoundAlert(_ value: Bool) {
        showNotFoundAlert = value
    }
    

}
