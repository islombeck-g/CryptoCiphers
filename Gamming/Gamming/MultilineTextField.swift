import SwiftUI

struct MultilineTextField: View {
    
    @Binding var text: String
    
    var body: some View {
    
        VStack {
        
            MultiTextField(text: $text)
                .frame(height: 150)
                .padding(.horizontal, 8)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color("darkGray")))
        }
        .padding(.horizontal, 16)
    }
}

struct MultilineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextField(text: .constant("some"))
    }
}

struct MultiTextField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        
        let view = UITextView()
        view.font = .systemFont(ofSize: 19)
        view.text = text
        view.textColor = .black
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) { uiView.text = text }
    
    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiTextField
        
        init(parent: MultiTextField) { self.parent = parent }
        
        func textViewDidChange(_ textView: UITextView) { self.parent.text = textView.text }
    }
}
