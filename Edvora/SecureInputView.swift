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
    private var title: String

    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text

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
                    .accentColor(.gray)
            }
        }
    }
}
