import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var viewModel:ViewModel
    @FocusState private var isTyping:Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //               MARK: chose alphabet
                Picker("SelectLanguage", selection: self.$viewModel.chosenLanguage) {
                    ForEach(Languages.allCases, id: \.self) { language in
                        Text(language.rawValue)
                    }
                }
                .disabled(self.viewModel.cryptResult != nil)
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top)
                
                //                MARK: textForCrypt
                Group {
                    Text("Текст для шифрования:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 16)
                    
                    TextField("Текст для шифрования", text: self.$viewModel.textForCrypt, axis: .vertical)
                        .focused($isTyping)
                        .disabled(self.viewModel.cryptResult != nil)
                        .lineLimit(6)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2)
                        }
                        .padding(.horizontal, 16)
                }
                
                //                MARK: keyForCrypt
                Group {
                    Text("Ключ:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 10)
                    TextField("Ключ", text: self.$viewModel.keyForCrypt, axis: .vertical)
                        .focused($isTyping)
                        .disabled(self.viewModel.cryptResult != nil)
                        .lineLimit(6)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                    
                }
                
                //                MARK: buttons
                Group {
                    HStack {
                        Group {
                            SaveToTxtFile(text: self.$viewModel.cryptResult)
                                .disabled(self.viewModel.cryptResult == nil)
                            
                            LoadTxtFile(result: self.$viewModel.textForCrypt)
                                .disabled(self.viewModel.cryptResult != nil)
                        }
                        .lineLimit(1)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.gray.opacity(0.2))
                        )
                        .padding(.horizontal, 16)
                        
                    }
                    HStack {
                        Group {
                            Button {
                                self.viewModel.textForCrypt = self.viewModel.clearText(viewModel.textForCrypt)
                                self.viewModel.keyForCrypt = self.viewModel.clearText(viewModel.keyForCrypt)
                            }label: {
                                Text("Clear")
                            }
                            Button {
                                self.viewModel.startCrypt()
                            }label: {
                                Text("Зашифровать")
                            }
                        }
                        .lineLimit(1)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.gray.opacity(0.2))
                        )
                        .padding(.horizontal, 16)
                        
                    }
                    HStack {
                        Group {
                            Button {
                                withAnimation {
                                    self.viewModel.ClearAll()
                                }
                            }label: {
                                Text("Очистить все поля")
                                    .foregroundStyle(.red)
                            }
                            Button {
                                self.viewModel.startUncrypt()
                            }label: {
                                Text("Расшифровать")
                            }
                            .disabled(self.viewModel.cryptResult == nil)
                        }
                        .lineLimit(1)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.gray.opacity(0.2))
                        )
                        .padding(.horizontal, 16)
                    }
                    
                    
                }
                
                //                MARK: errors
                Group {
                    if let error = self.viewModel.errorInCrypt {
                        Text("Ошибка в шифровании: \(error)")
                    }
                    if let error = self.viewModel.errorInUncrypt {
                        Text("Ошибка в расшифровке: \(error)")
                    }
                    
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundStyle(.red)
                .bold()
                
                //                MARK: results
                Group {
                    if let text = self.viewModel.cryptResult {
                        Text(text)
                        
                    }
                    if let text = self.viewModel.unCryptResult {
                        Text(text)    
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                }
                .padding(.horizontal, 16)
            }
            .toolbar {
                
                ToolbarItem(placement: .keyboard) {
                    if isTyping {
                        HStack {
                            Spacer()
                            Button("Готово") {
                                
                                    isTyping = false
                                
                            }
                            Spacer()
                                .frame(width: 16)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    MainView()
        .environmentObject(ViewModel())
}
