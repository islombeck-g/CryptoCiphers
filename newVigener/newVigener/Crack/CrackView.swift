import SwiftUI

struct CrackView: View {
    @EnvironmentObject var viewModel:ViewModel
    @FocusState private var isTyping:Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //               MARK: chose alphabet
                Picker("SelectLanguage", selection: self.$viewModel.chosenLanguageForHack) {
                    ForEach(Languages.allCases, id: \.self) { language in
                        Text(language.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top)
                
                //                MARK: textForUnCrypt
                Group {
                    Text("Текст для расшифровки:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 16)
                    TextField("Текст для расшифровки", text: self.$viewModel.textforUncrypt, axis: .vertical)
                        .focused(self.$isTyping)
                        .lineLimit(4)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2)
                        }
                        .padding(.horizontal, 16)
                }
                
                //              MARK: buttons
                Group {
                    LoadTxtFile(result: self.$viewModel.textforUncrypt)
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.gray.opacity(0.2)))
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    
                    HStack {
                        Group {
                            Button {
                                self.viewModel.clearCryptView()
                            } label: {
                                Text("Очистить")
                            }
                            Button {
                                self.viewModel.tryHack()
                            }label: {
                                Text("Постараться Взломать")
                                    .foregroundStyle(.red)
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.gray.opacity(0.2)))
                        .padding(.horizontal, 16)
                    }
                }
                
                //                MARK: result
                if self.viewModel.resultOFCrack != "" {
                    Text("Ключ:")
                    Text(self.viewModel.resultKey)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 3)
                        }
                        .padding()
                    Text("Результат:")
                    Text(self.viewModel.resultOFCrack)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 3)
                        }
                        .padding()
                    
                }
                
                
                //                MARK: errors
                Group {
                    if  self.viewModel.hackError != nil {
                        Text(self.viewModel.hackError!)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 3)
                            }
                            .padding()
                    }
                }
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
    CrackView()
        .environmentObject(ViewModel())
}
