//
//  SqlManager.swift
//  odev_4
//
//  Created by Gürhan Kuraş on 12.11.2021.
//

import Foundation


import SQLite
import SQLite3


protocol DBManager {
    func search(key: String) -> String?
    func insert(key: String, value: String) -> Void
}


class SqlDemoManager : DBManager {
    private let databaseName = "Ders_odev3.sqlite3"
    
    private var db: Connection!
    private var table: Table = Table("table")
    
    private var keyColumn = Expression<String>("key")
    private var valueColumn = Expression<String>("value")
    
    init() {
        createDbIfNotExists()
        print("initiliazed")
    }
    
    private func createDbIfNotExists() {
        do {
            let path: String = findDatabasePath()
            db = try Connection("\(path)/\(databaseName)")
            
            if (!isDatabaseExists()) {
                try createDatabaseTable()
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func findDatabasePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    }
    
    private func isDatabaseExists() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultsKeys.isDatabaseExists.rawValue)
    }
    
    private func createDatabaseTable() throws ->  Void {
            try db.run(table.create { (t) in
                t.column(keyColumn, unique: true)
                t.column(valueColumn)
            })
            insert(key: "bil359", value: "Hello World from database")
            UserDefaults.standard.set(true, forKey: DefaultsKeys.isDatabaseExists.rawValue)
    }
    
    func search(key: String) -> String? {
        do {
            let query = table.filter(keyColumn == key)
            for row in try db.prepare(query) {
                let value = try row.get(valueColumn)
                print("val: \(value)")
                return value
            }
        }
        catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("constraint failed: \(message), in \(statement)")
        } catch let error {
            print("select failed: \(error)")
        }
        return nil
    }

    func insert(key: String, value: String) -> Void {
        do {
            let insert = table.insert(keyColumn <- key, valueColumn <- value)
            try db.run(insert)
        }
        catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("constraint failed: \(message), in \(statement)")
        } catch let error {
            print("insertion failed: \(error)")
        }
    }
    
    private enum DefaultsKeys : String {
        case isDatabaseExists = "is_database_exists"
    }
}
