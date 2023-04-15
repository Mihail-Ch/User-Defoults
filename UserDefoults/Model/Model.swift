//
//  Model.swift
//  UserDefoults
//
//  Created by Михаил Чертов on 16.12.2022.
//

import Foundation

enum TaskStatus: String {
    case planned = "\u{25CB}"
    case complited = "\u{25C9}"
}

protocol TaskProtocol {
    var status: TaskStatus {get set}
    var task: String {get set}
    
}

struct Task: TaskProtocol {
    var status: TaskStatus
    var task: String
}


protocol TaskStorageProtocol {
    
    func load() -> [TaskProtocol]
    func save(tasks: [TaskProtocol])
}


class TaskStorage: TaskStorageProtocol {
    
    private var storage = UserDefaults.standard
    private var storageKey = "task"
    
    private enum TaskKey: String {
        case task
        case status
    }
    
    func load() -> [TaskProtocol] {
        var resultTask: [TaskProtocol] = []
        let taskFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for task in taskFromStorage {
            guard let symbol  = task[TaskKey.status.rawValue],
                  let title = task[TaskKey.task.rawValue] else {
                continue
            }
            resultTask.append(Task(status: TaskStatus(rawValue: symbol) ?? .planned, task: title))
        }
        return resultTask
    }
    
    func save(tasks: [TaskProtocol]) {
        var arrayForStorage: [[String:String]] = []
        tasks.forEach { task in
            var newElementForStorage: Dictionary<String,String> = [:]
            newElementForStorage[TaskKey.status.rawValue] = task.status.rawValue
            newElementForStorage[TaskKey.task.rawValue] = task.task
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
