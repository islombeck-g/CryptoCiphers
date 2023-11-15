import SwiftUI

struct CrackView: View {
    
    @StateObject private var viewModel = SecondViewModel()
    
    @State private var languages:[String] = ["EN", "RU"]
    @State private var textForUNCrypt:String = ""
    @State private var letter:String = ""
    
    var body: some View {
        ScrollView {
            HStack {
                LoadTxtFile(result: $textForUNCrypt)
            }
            
            Group {
            
                Spacer().frame(height: 40)
                
                Picker("Tip percentage", selection: $viewModel.language) {
                    ForEach(languages, id: \.self) { i in Text(i) }
                }
                .frame(width: UIScreen.main.bounds.width - 32)
                .pickerStyle(.segmented)
                
                Spacer().frame(height: 25)
            }
            
            Group {
                HStack {
                    Text("Текст для шифрования:")
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .background(Color("gray"))
                .cornerRadius(4)
                .padding(.horizontal, 16)

                MultilineTextField(text: $textForUNCrypt)
                
                Spacer().frame(height: 25)
            }
            
            Group {
                HStack {
                    
                    Spacer().frame(width: 16)
                    
                    Button {
                        self.viewModel.language = "EN"
                        self.viewModel.errorMessage = ""
                        self.viewModel.result = ""
                        self.viewModel.resyltIsReady = false
                        self.textForUNCrypt = ""
                        self.letter = ""
                    }label: {
                        Text("Очистить все поля")
                            .foregroundColor(.red)
                            .padding(.all, 8)
                            .background(Color("gray"))
                            .cornerRadius(4)
                    }
                    
                    Spacer()

                    Button {
                        self.viewModel.tryCrack(self.textForUNCrypt, " ")
                    } label: {
                            Text("Постараться...")
                                .foregroundColor(.blue)
                                .padding(.all, 8)
                                .background(Color("gray"))
                                .cornerRadius(4)
                    }
                    Spacer().frame(width: 16)
                }
            }

            Group {
                if viewModel.resyltIsReady == true { Text("key = \(viewModel.rightKey)") }
                
                HStack {
                    if viewModel.resyltIsReady == true {
                        
                        Text(viewModel.result)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                                .padding(.horizontal, 16)
                        
                        Spacer()
                    }

                    if viewModel.errorMessage != "" {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    }
                }
                Spacer().frame(height: 10)
            }
        }
    }
}

#Preview {
    CrackView()
}
