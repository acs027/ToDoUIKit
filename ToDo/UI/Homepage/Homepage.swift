//
//  ViewController.swift
//  ToDo
//
//  Created by ali cihan on 15.04.2025.
//

import UIKit

class Homepage: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var todoList = [ToDo]()
    var homepageViewModel = HomepageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "ToDo"
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(named: "mainColor")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "mainTextColor")!,
                                          .font: UIFont(name: "Lobster-Regular", size: 20)!]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .mainText
        
        
        _ = homepageViewModel.todos.subscribe(onNext: { list in
            self.todoList = list
            self.todoTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homepageViewModel.loadTodos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            print("toDetail run")
            if let todo = sender as? ToDo {
                let navigation = segue.destination as! DetailScreen
                navigation.todo = todo
            }
        }
    }
}

extension Homepage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homepageViewModel.search(for: searchText)
    }
}

extension Homepage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! ToDoCell
        cell.titleLabel.text = todoList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: todo)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            contextualAction, view, bool in
            let todo = self.todoList[indexPath.row]
            
            let alert = UIAlertController(title: "Delete Action", message: "Dou you want to delete \(todo.title!)?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { action in
                self.homepageViewModel.delete(id: todo.id!)
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}



