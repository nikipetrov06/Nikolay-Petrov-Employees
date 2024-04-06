//
//  FileReader.swift
//  Employees
//
//  Created by Nikolay Petrov on 5.04.24.
//

import Foundation

protocol FileReaderDelegate: AnyObject {
    func didGetLongestWorkingPair(_ longestWorkingPair: LongestWorkingPair?)
}

class FileReader {
    
    weak var delegate: FileReaderDelegate?
    
    func readFileFromURL(_ url: URL) {
        do {
            let data = try Data(contentsOf: url)
            guard let content = String(data: data, encoding: .utf8) else {
                return
            }
            
            var employees: [Employee] = []
            let employeesRows = content.components(separatedBy: "\n")
            for employeeRow in employeesRows {
                let employeesColumns = employeeRow.components(separatedBy: ",").map {
                    $0.trimmingCharacters(in: .whitespaces)
                }
                let empID = employeesColumns[0]
                let projectID = employeesColumns[1]
                guard let dateFrom = convertStringIntoDate(employeesColumns[2]),
                      let dateTo = convertStringIntoDate(employeesColumns[3]) else {
                    continue
                }
                let employee = Employee(empID: empID, projectID: projectID, dateFrom: dateFrom, dateTo: dateTo)
                employees.append(employee)
            }
            getLongestWorkingPair(employees: employees)
        } catch {
            print(error)
        }
    }
    
    private func convertStringIntoDate(_ dateString: String) -> Date? {
        if dateString == "NULL" {
            return Date()
        }
        
        let dateFormats = [
            "yyyy-MM-dd",
            "yyyy/MM/dd",
            "MM/dd/yyyy",
            "dd/MM/yyyy",
            "yyyyMMdd",
            "yyMMdd"
        ]
        
        let dateFormatter = DateFormatter()
        
        
        for format in dateFormats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
        }
        
        return nil
    }
    
    private func getLongestWorkingPair(employees: [Employee]) {
        var longestWorkingPair: LongestWorkingPair? = nil
        for i in 0..<employees.count {
            for y in i+1..<employees.count {
                let employeeOne = employees[i]
                let employeeTwo = employees[y]
                
                if employeeOne.dateTo < employeeTwo.dateFrom || employeeOne.dateFrom > employeeTwo.dateTo {
                    continue
                }
                
                if employeeOne.projectID == employeeTwo.projectID && employeeOne.empID != employeeTwo.empID {
                    let laterDateFrom = max(employeeOne.dateFrom, employeeTwo.dateFrom)
                    let earliertDateTo = min(employeeOne.dateTo, employeeTwo.dateTo)
                    let secondsBetween = earliertDateTo.timeIntervalSince(laterDateFrom)
                    let numberOfDays = Int(secondsBetween / 86400)
                    
                    if longestWorkingPair == nil || longestWorkingPair?.daysWorked ?? 0 < numberOfDays {
                        longestWorkingPair = LongestWorkingPair(employeeOneID: employeeOne.empID,
                                                                employeeTwoID: employeeTwo.empID,
                                                                projectID: employeeOne.projectID,
                                                                daysWorked: numberOfDays)
                    }
                }
            }
        }
        delegate?.didGetLongestWorkingPair(longestWorkingPair)
    }
}
