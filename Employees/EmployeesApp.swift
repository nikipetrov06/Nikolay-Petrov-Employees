//
//  EmployeesApp.swift
//  Employees
//
//  Created by Nikolay Petrov on 4.04.24.
//

import SwiftUI

@main
struct EmployeesApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = FilePickerViewModel()
            
            FilePicker(viewModel: viewModel)
        }
    }
}
