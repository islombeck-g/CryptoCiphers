import SwiftUI

struct First: View {
    
    @StateObject private var viewModel:FirstViewModel = FirstViewModel()
    
    @State private var languages:[String] = ["EN", "RU"]
    
    
    var body: some View {
        ScrollView {
//             languageChose
            Group {
                
                Spacer()
                    .frame(height: 40)
                
                Picker("Tip percentage", selection: $viewModel.chosenLanguage) {
                    ForEach(languages, id: \.self) { i in Text(i) }
                }
                .frame(width: UIScreen.main.bounds.width - 32)
                .pickerStyle(.segmented)
                
                Spacer()
                    .frame(height: 25)
            }
//            input text for crypt
            Group {
                HStack {
                    
                    Text("Текст для шифрования:")
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .background(Color("gray"))
                .cornerRadius(4)
                .padding(.horizontal, 16)
                
                
                MultilineTextField(text: self.$viewModel.textForCrypt)
                
                Spacer().frame(height: 25)
                
                MultilineTextField(text: self.$viewModel.binaryTextForCrypt)
                
                Spacer().frame(height: 25)
            }
//            input key
            Group {
                HStack{
                    
                    Text("Ключ:")
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                    .background(Color("gray"))
                    .cornerRadius(4)
                    .padding(.horizontal, 16)

                TextField("Ведите ключ", text: self.$viewModel.keyForCrypt)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color("darkGray")))
                    .padding(.horizontal, 16)
                
                Spacer().frame(height: 20)
                
                MultilineTextField(text: self.$viewModel.binaryKeyForCrypt)
                
                Spacer().frame(height: 20)
            }
//            button
            Group {
                HStack {
                    Spacer().frame(width: 16)
                    
                    Button {
                        self.viewModel.toBinar()
                    }
                    label: {
                        Text("Перевести")
                            .foregroundColor(.black)
                            .padding(.all, 8)
                            .background(Color("gray"))
                            .cornerRadius(4)
                    }
                    
                    Spacer()
                    
                    Button {
                        self.viewModel.tryCrypt()
                    }
                    label: {
                            Text("Гамировать")
                                .foregroundColor(.blue)
                                .padding(.all, 8)
                                .background(Color("gray"))
                                .cornerRadius(4)
                    }
                    Spacer().frame(width: 16)
                }
                
                HStack {
                    
                    Spacer().frame(width: 16)
                    
                    Button {
                        self.viewModel.clear()
                    } label: {
                        Text("Очистить всё")
                            .padding(.all, 8)
                            .foregroundStyle(.red)
                            .background(Color("gray"))
                            .cornerRadius(4)
                    }
                    
                    Spacer()
                    
                }
            }
            
//            printResult
            Group {
                
                if self.viewModel.error != "" {
                    Text(viewModel.error)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                    Spacer().frame(height: 25)
                }
                
                if self.viewModel.resultIsReady == true {
                    Text(viewModel.resultText)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                            .padding(.horizontal, 16)
                    Spacer().frame(height: 25)
                    
                    Text(viewModel.resultBinarText)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                            .padding(.horizontal, 16)
                }
            }
            
//            uncrypt
            Group {
                if self.viewModel.resultIsReady {
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            self.viewModel.unCrypt()
                        }
                        label: {
                                Text("Расшифровать")
                                    .foregroundColor(.blue)
                                    .padding(.all, 8)
                                    .background(Color("gray"))
                                    .cornerRadius(4)
                        }
                        Spacer().frame(width: 16)
                    }
                }
                
            }
            Group {
                
                if self.viewModel.uncError != "" {
                    Text(viewModel.uncError)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                    Spacer().frame(height: 25)
                }
                
                if self.viewModel.uncryptIsReady == true {
                    Text(viewModel.uncryptResultText)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                            .padding(.horizontal, 16)
                    Spacer().frame(height: 25)
                    
                    Text(viewModel.uncryptResultBinarText)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                            .padding(.horizontal, 16)
                }
            }
        }
    }
}

#Preview {
    First()
}
