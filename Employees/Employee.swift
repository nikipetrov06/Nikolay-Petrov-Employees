//
//  Employee.swift
//  Employees
//
//  Created by Nikolay Petrov on 5.04.24.
//

import Foundation

struct Employee: Identifiable {
    var id: String = UUID().uuidString
    let empID: String
    let projectID: String
    let dateFrom: Date
    let dateTo: Date
}
