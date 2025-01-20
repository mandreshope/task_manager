//
//  SearchBar.swift
//  TaskManager
//
//  Created by Mandresy on 20/01/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search...", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())

    }
}
