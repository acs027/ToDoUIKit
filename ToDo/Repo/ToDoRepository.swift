//
//  ToDoRepository.swift
//  ToDo
//
//  Created by ali cihan on 23.04.2025.
//

import Foundation
import RxSwift

class ToDoRepository {
    var todos = BehaviorSubject<[ToDo]>(value: [ToDo]())
    
    let db: FMDatabase?
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbPathURL = URL(fileURLWithPath: path).appendingPathComponent("todo_app.sqlite")
        db = FMDatabase(path: dbPathURL.path)
    }
    
    func save(title: String, description: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO todos (title,description) VALUES (?,?)", values: [title, description])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(id: Int, title: String, description: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE todos SET title=?,description=? WHERE id=?", values: [title, description, id])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func search(for text: String) {
        
        db?.open()
        
        do {
            var list = [ToDo]()
            let result = try db!.executeQuery("SELECT * FROM todos WHERE title LIKE '%\(text)%'", values: nil)
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let title = result.string(forColumn: "title")!
                let description = result.string(forColumn: "description")!
                
                let todo = ToDo(id: id, title: title, description: description)
                
                list.append(todo)
            }
            todos.onNext(list)
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func delete(id: Int) {
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM todos WHERE id=?", values: [id])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func loadTodos() {
        
        db?.open()
        
        do {
            var list = [ToDo]()
            let result = try db!.executeQuery("SELECT * FROM todos", values: nil)
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let title = result.string(forColumn: "title")!
                let description = result.string(forColumn: "description")!
                
                let todo = ToDo(id: id, title: title, description: description)
                
                list.append(todo)
            }
            todos.onNext(list)
        } catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
    }
    
    
    
}
