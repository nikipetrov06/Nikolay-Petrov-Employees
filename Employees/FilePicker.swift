//
//  ContentView.swift
//  Employees
//
//  Created by Nikolay Petrov on 4.04.24.
//

import SwiftUI

struct FilePicker: View {
    @State var isShowing = false
    var body: some View {
        Button {
            isShowing.toggle()
        } label: {
            Text("Documents")
        }.fileImporter(isPresented: $isShowing, allowedContentTypes: [.item]) { result in
            switch result {
            case.success(let url):
                print(url)
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    FilePicker()
}
