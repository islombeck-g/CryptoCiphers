import Foundation

final class CrackViewModel:ObservableObject {
    @Published var chosenLanguage: Languages = .english
    @Published var textForUnCrypt: String = ""
}
