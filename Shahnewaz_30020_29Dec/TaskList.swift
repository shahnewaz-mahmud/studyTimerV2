//
//  TaskList.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 29/12/22.
//

import Foundation


struct Task: Encodable, Decodable {
    let taskId: String?
    let userId: String
    let subject: String
    let topic: String
    let duration: Int
    var progress: Int
    let priority: String
    var isDone: Bool
}


extension Task
{
    static var taskList = [Task]()
}
