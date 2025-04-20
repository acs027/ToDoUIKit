//
//  ViewController.swift
//  ToDo
//
//  Created by ali cihan on 15.04.2025.
//

import UIKit

class HomePage: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var todoList = [ToDo]()
    
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
        
        let t1 = ToDo(title: "ToDo1", description: "ToDo1")
        let t2 = ToDo(title: "ToDo2", description: "ToDo2")
        let t3 = ToDo(title: "ToDo3", description: "ToDo3")
        todoList += [t1, t2, t3]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createVC = segue.destination as? CreateScreen {
            createVC.onSave = { [weak self] newToDo in
                self?.todoList.append(newToDo)
                self?.todoTableView.reloadData()
                // You can also reload a tableView here if needed
            }
        }
        
        if segue.identifier == "toDetail" {
            print("toDetail run")
            if let todo = sender as? ToDo {
                let navigation = segue.destination as! DetailScreen
                navigation.todo = todo
            }
        }
    }
}

extension HomePage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Searching")
    }
}

extension HomePage: UITableViewDelegate, UITableViewDataSource {
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
    
    
}



