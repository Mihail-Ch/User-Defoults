//
//  ViewController.swift
//  UserDefoults
//
//  Created by Михаил Чертов on 16.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var storage: TaskStorageProtocol!
    var myTask = [TaskProtocol]() {
        didSet {
            myTask.sort { $0.status.rawValue > $1.status.rawValue }
                storage.save(tasks: myTask)
            }
    }
    
    let cell = UINib(nibName: "TableViewCell", bundle: nil)
   
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    //MARK: - Live Cicle
    
    override func loadView() {
        super.loadView()
        // Кнопка редактирования
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell.self, forCellReuseIdentifier: "TaskCell")
        storage = TaskStorage()
        loadTask()

    }
    
    //MARK: - Method
  
    private func loadTask() {
        myTask = storage.load()
    }
   
    // Разрешаем контроллеру производить изменения в таблице
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    
    //MARK: - Action
    
    @IBAction func addTask(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Новая задача",
                                                message: "Введите название задачи",
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "название задачи"
            
            let alertActionAdd = UIAlertAction(title: "Добавить",
                                               style: .default) {
                _ in
                guard let titleTask = alertController.textFields?[0].text else {
                    return
                }
                
                let newTask = Task(status: .planned, task: titleTask)
                self.myTask.append(newTask)
                self.tableView.reloadData()
            }
            
            let alertActionCancel = UIAlertAction(title: "Отменить",
                                                  style: .cancel)
            alertController.addAction(alertActionAdd)
            alertController.addAction(alertActionCancel)
            self.present(alertController, animated: true)
        }
    }
   
}

