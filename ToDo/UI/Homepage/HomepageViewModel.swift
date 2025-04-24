//
//  HomepageViewModel.swift
//  ToDo
//
//  Created by ali cihan on 24.04.2025.
//

import Foundation
import RxSwift

class HomepageViewModel {
    var todoRepository = ToDoRepository()
    var todos = BehaviorSubject<[ToDo]>(value: [ToDo]())
    
    init() {
        loadDatabase()
        todos = todoRepository.todos
    }
    
    func save(title: String, description: String) {
        todoRepository.save(title: title, description: description)
    }
    
    func search(for text: String) {
        todoRepository.search(for: text)
    }
    
    func delete(id: Int) {
        todoRepository.delete(id: id)
        loadTodos()
    }
    
    func loadTodos() {
        todoRepository.loadTodos()
    }
    
    func loadDatabase(){
            let bundlePath = Bundle.main.path(forResource: "todo_app", ofType: ".sqlite")
            let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let copyPath = URL(fileURLWithPath: targetPath).appendingPathComponent("todo_app.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: copyPath.path){
                print("Database already loaded.")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundlePath!, toPath: copyPath.path)
                }catch{}
            }
        }
}
