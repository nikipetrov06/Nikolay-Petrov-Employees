//
//  ContentView.swift
//  Employees
//
//  Created by Nikolay Petrov on 4.04.24.
//

import SwiftUI

struct FilePicker: View {
    @State var isShowing = false
    @StateObject var viewModel: FilePickerViewModel
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            VStack {
                if let longestWorkingPair = viewModel.longestWorkingPair {
                    EmployeePair(longestWorkingPair: longestWorkingPair)
                }
                
                button
            }
        }
    }
    
    var button: some View {
        Button {
            isShowing.toggle()
        } label: {
            Text("Documents")
        }.fileImporter(isPresented: $isShowing, allowedContentTypes: [.item]) { result in
            viewModel.handlerResult(result)
        }
    }
}

struct EmployeePair: View {
    let longestWorkingPair: LongestWorkingPair
    var body: some View {
        HStack(alignment: .top) {
            TitledInfo(title: "Employee ID #1", info: longestWorkingPair.employeeOneID)
            TitledInfo(title: "Employee ID #2", info: longestWorkingPair.employeeTwoID)
            TitledInfo(title: "Project ID", info: longestWorkingPair.projectID)
            TitledInfo(title: "Days Worked", info: "\(longestWorkingPair.daysWorked)")
        }
        .padding()
    }
}

struct TitledInfo: View {
    let title: String
    let info: String
    var body: some View {
        VStack {
            Text("Employee ID #1")
                .multilineTextAlignment(.center)
            Text(info)
        }
    }
}

#Preview {
    let viewModel = FilePickerViewModel()
    viewModel.longestWorkingPair = LongestWorkingPair(employeeOneID: "1",
                                                      employeeTwoID: "2",
                                                      projectID: "3",
                                                      daysWorked: 4)
    return FilePicker(viewModel: viewModel)
}
