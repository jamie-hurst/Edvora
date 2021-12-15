//
//  SecureInputView.swift
//  Edvora
//
//  Created by Jameson Hurst on 12/13/21.
//

import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    @State private var isFocused: Bool
    private var title: String

    
    init(_ title: String, text: Binding<String>, isFocused: Bool) {
        self.title = title
        self._text = text
        self.isFocused = isFocused
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
            }
                        
            Button {
                isSecured.toggle()
                
            } label: {
                Image(systemName: self.isSecured ? "eye.slash.fill" : "eye.fill")
                    .accentColor(.edvoraMaroonSecondary)
            }
        }
    }
}
