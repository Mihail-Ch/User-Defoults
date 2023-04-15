//
//  File.swift
//  UserDefoults
//
//  Created by Михаил Чертов on 16.12.2022.
//

import UIKit


extension ViewController: UITableViewDelegate {
        
    // Переводим задачу в статус выполненные
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTask[indexPath.row].status = .complited
        tableView.reloadData()
    }
    
    // Возвращаем задачу из выполненная в запланированные
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionInstance = UIContextualAction(style: .normal,
                                                title: "Не выполнена") { _, _, _ in
            self.myTask[indexPath.row].status = .planned
            self.tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [actionInstance])
    }
    
    // Удаляем задачу
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive,
                                              title: "Удалить") { _, _, _ in
            self.myTask.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
