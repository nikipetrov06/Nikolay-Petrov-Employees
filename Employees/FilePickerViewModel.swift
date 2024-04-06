//
//  DataHandler.swift
//  Employees
//
//  Created by Nikolay Petrov on 5.04.24.
//

import Foundation

struct LongestWorkingPair {
    let employeeOneID: String
    let employeeTwoID: String
    let projectID: String
    let daysWorked: Int
}

class FilePickerViewModel: ObservableObject {
    let fileReader = FileReader()
    @Published var isLoading = false
    @Published var longestWorkingPair: LongestWorkingPair?
    
    init() {
        fileReader.delegate = self
    }
    
    func handlerResult(_ result: Result<URL, any Error>) {
        isLoading = true
        switch result {
        case .success(let url):
            fileReader.readFileFromURL(url)
        case .failure(let error):
            print(error)
        }
    }
}

extension FilePickerViewModel: FileReaderDelegate {
    func didGetLongestWorkingPair(_ longestWorkingPair: LongestWorkingPair?) {
        guard let longestWorkingPair else {
            return
        }
        
        self.longestWorkingPair = longestWorkingPair
    }
}
