//
//  DataBase.swift
//  UserDefoults
//
//  Created by Михаил Чертов on 16.12.2022.
//

import UIKit


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        let task = myTask[indexPath.row]
        cell.symbol.text = getSymbolForTask(with: task.status)
        cell.task.text = task.task
        if task.status == .planned {
            cell.symbol.textColor = .black
            cell.task.textColor = .black
        } else {
            cell.symbol.textColor = .lightGray
            cell.task.textColor = .lightGray
        }
        return cell
    }
    
    private func getSymbolForTask(with status: TaskStatus) -> String {
        var resultSymbol: String
        if status == .planned {
            resultSymbol = status.rawValue
        } else if status == .complited {
            resultSymbol = status.rawValue
        } else {
            resultSymbol = ""
        }
        return resultSymbol
    }
    
    // Перемещаем ячейки со старой позиции на новую, в режиме редактирования
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let taskFrom = myTask[sourceIndexPath.row]
        
        guard myTask[sourceIndexPath.row] != nil else {return}
        
        myTask.remove(at: sourceIndexPath.row)
        myTask.insert(taskFrom, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}
