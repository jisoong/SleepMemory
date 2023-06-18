//
//  DB_Manager.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//
//
import Foundation
import SQLite3

class DB_Manager {
    static let shared = DB_Manager()
    
    var db: OpaquePointer?
    var path = "mySqlite.sqlite3"
    
    init() {
        self.db = createDB()
    }
    
    func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
            if sqlite3_open(filePath.path, &db) == SQLITE_OK {
                print("Success create db Path")
                return db
            }
            
        }
        catch {
            print("error in createDB")
        }
        print("error in createDB - sqlite3_open")
        

        return nil
    }
    
    func createTable(_ tableName: String, _ columns: [String]) {
        var columnString = ""
        for column in columns {
            columnString += "\(column), "
        }
        columnString = String(columnString.dropLast(2)) // Remove the trailing comma and space

        let query = "CREATE TABLE IF NOT EXISTS \(tableName) (\(columnString))"
        var statement: OpaquePointer? = nil

        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Create table success")
            } else {
                print("Create table step fail")
            }
        } else {
            print("Create table prepare fail")
        }

        sqlite3_finalize(statement)
    }

    func deleteTable(_ tableName: String) {
        let query = "DROP TABLE \(tableName)"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("delete table success")
            } else {
                print("delete table step fail")
            }
        } else {
            print("delete table prepare fail")
        }
    }
    
    
 
    
//    func insertData(_ tableName: String, _ columm: [String], _ insertData: [String]) {
//        var columms: String {
//            var columms = "id"
//            for col in columm {
//                columms += ", \(col)"
//            }
//            return columms
//        }
//
//        var values: String {
//            var values = "?"
//            for _ in (0..<columm.count) {
//                values += ", ?"
//            }
//            return values
//        }
//
//        let query = "insert into \(tableName) (\(columms)) values (\(values))"
//        var statement: OpaquePointer? = nil
//
//
//        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
//            for i in (0..<insertData.count) {
//                sqlite3_bind_text(statement, Int32(i + 2), NSString(string: insertData[i]).utf8String, -1, nil)
//            }
//            if sqlite3_step(statement) == SQLITE_DONE {
//                print("insert data success")
//            } else {
//                print("insert data sqlite3 step fail")
//            }
//
//        } else {
//            print("insert Data prepare fail")
//        }
//        sqlite3_finalize(statement)
//    }
    func insertData(_ tableName: String, _ columm: [String], _ insertData: [String]) {
            var columms: String {
                var columms = "id"
                for col in columm {
                    columms += ", \(col)"
                }
                return columms
            }
            
            var values: String {
                var values = "?"
                for _ in (0..<columm.count) {
                    values += ", ?"
                }
                return values
            }
            
            let query = "insert into \(tableName) (\(columms)) values (\(values))"
            var statement: OpaquePointer? = nil
            

            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                for i in (0..<insertData.count) {
                    sqlite3_bind_text(statement, Int32(i + 2), NSString(string: insertData[i]).utf8String, -1, nil)
                }
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("insert data success")
                } else {
                    print("insert data sqlite3 step fail")
                }
                
            } else {
                print("insert Data prepare fail")
            }
            sqlite3_finalize(statement)
        
        }
   
    

    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }

//    func readData(_ tableName: String, _ columm: [String]) -> (Dictionary<Int, Any>) {
//            let query = "select * from \(tableName)"
//            var statement: OpaquePointer? = nil
//            var readData = Dictionary<Int,Dictionary<String, String>>()
//
//            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
//                while sqlite3_step(statement) == SQLITE_ROW {
//                    let id = sqlite3_column_int(statement, 0)
//                    var data = Dictionary<String, String>()
//                    for i in (0..<columm.count) {
//                        data[columm[i]] = String(cString: sqlite3_column_text(statement, Int32(i + 1)))
//                    }
//                    readData[Int(id)] = data
//                }
//            } else {
//                print("read Data prepare fail")
//            }
//            sqlite3_finalize(statement)
//            return readData
//        }
    
    func readData(_ tableName: String, _ column: [String]) -> Dictionary<Int, Any> {
        let query = "SELECT * FROM \(tableName)"
        var statement: OpaquePointer? = nil
        var readData = Dictionary<Int, Any>()

        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    let id = Int(sqlite3_column_int(statement, 0))
                    var data = Dictionary<String, Any>()
                    for i in 0..<column.count {
                        let columnName = column[i]
                        if let value = sqlite3_column_text(statement, Int32(i + 1)) {
                            let columnValue = String(cString: value)
                            data[columnName] = columnValue
                        }
                    }
                    readData[id] = data
                }
            } else {
                print("Read data prepare fail")
            }
            sqlite3_finalize(statement)
        return readData
    }
    
    func deleteData(_ tableName: String, _ id: Int) {
        let query = "delete from \(tableName) where id == \(id)"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("delete data success")
            } else {
                print("delete data step fail")
            }
        } else {
            print("delete data prepare fail")
        }
        sqlite3_finalize(statement)
    }
    
    func updateData(_ tableName: String) {
        let query = "update \(tableName) set id = 2 where id = 5"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("success updateData")
            } else {
                print("updataData sqlite3 step fail")
            }
        } else {
            print("updateData prepare fail")
        }
    }

    func saveAsCSV(dbPath: String, tableName: String, outputPath: String) {
        // Open the SQLite database
        var db: OpaquePointer? = nil
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            // Prepare the query to fetch all rows from the table
            let query = "SELECT * FROM \(tableName)"
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                // Create the output file
                FileManager.default.createFile(atPath: outputPath, contents: nil, attributes: nil)
                let fileHandle = FileHandle(forWritingAtPath: outputPath)
                
                // Write the column headers to the file
                var headers: [String] = []
                for i in 0..<sqlite3_column_count(statement) {
                    if let columnName = sqlite3_column_name(statement, i) {
                        headers.append(String(cString: columnName))
                    }
                }
                let headerRow = headers.joined(separator: ",")
                if let headerData = headerRow.data(using: .utf8) {
                    fileHandle?.write(headerData)
                }
                
                // Write the rows to the file
                while sqlite3_step(statement) == SQLITE_ROW {
                    var rowData: [String] = []
                    for i in 0..<sqlite3_column_count(statement) {
                        if let columnText = sqlite3_column_text(statement, i) {
                            rowData.append(String(cString: columnText))
                        }
                    }
                    let row = rowData.joined(separator: ",")
                    if let rowData = row.data(using: .utf8) {
                        fileHandle?.write(rowData)
                    }
                }
                
                // Close the file handle and finalize the statement
                fileHandle?.closeFile()
                sqlite3_finalize(statement)
                
                print("Data saved as CSV: \(outputPath)")
            } else {
                print("Failed to prepare query: \(query)")
            }
            
            // Close the SQLite database
            sqlite3_close(db)
        } else {
            print("Failed to open database: \(dbPath)")
        }
    }

}
