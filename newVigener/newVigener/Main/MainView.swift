import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var viewModel:MainViewModel
    
    var body: some View {
        VStack {
            ScrollView {
//               MARK: chose alphabet
                Picker("SelectLanguage", selection: self.$viewModel.chosenLanguage) {
                    ForEach(Languages.allCases, id: \.self) { language in
                        Text(language.rawValue)
                    }
                }
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
                        .lineLimit(4)
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
                        .lineLimit(4)
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
                            Button {
                                
                            }label: {
                                Text("Сохранить в файл")
                            }
                            Button {
                                
                            }label: {
                                Text("Выбрать файл")
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
                                UIPasteboard.general.string = viewModel.cryptResult
                            }label: {
                                Text("Ctrl+C (CryptText)")
                            }
                            Button {
                                
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
                                
                            }label: {
                                Text("Расшифровать")
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
        }
    }
}

#Preview {
    MainView()
        .environmentObject(MainViewModel())
}
