import SwiftUI

struct ChessPieceView: View {
    let text: String
    let color: Color
    @Binding var isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow)
                .frame(width: 40, height: 40)
            Circle()
                .stroke(color, lineWidth: 2)
                .frame(width: 38, height: 38)
            Text(text)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(color)
        }
        .scaleEffect(isSelected ? 1.2 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct ChessPiece_Previews: PreviewProvider {
    @State static var isSelected = false
    
    static var previews: some View {
        VStack {
            HStack {
                ChessPieceView(text: "帥", color: .red, isSelected: $isSelected)
                ChessPieceView(text: "仕", color: .red, isSelected: $isSelected)
                ChessPieceView(text: "相", color: .red, isSelected: $isSelected)
                ChessPieceView(text: "馬", color: .red, isSelected: $isSelected)
                ChessPieceView(text: "車", color: .red, isSelected: $isSelected)
            }
            HStack {
                ChessPieceView(text: "炮", color: .red, isSelected: $isSelected)
                ChessPieceView(text: "兵", color: .red, isSelected: $isSelected)
                ChessPieceView(text: "將", color: .black, isSelected: $isSelected)
                ChessPieceView(text: "士", color: .black, isSelected: $isSelected)
                ChessPieceView(text: "象", color: .black, isSelected: $isSelected)
            }
            HStack {
                ChessPieceView(text: "馬", color: .black, isSelected: $isSelected)
                ChessPieceView(text: "車", color: .black, isSelected: $isSelected)
                ChessPieceView(text: "炮", color: .black, isSelected: $isSelected)
                ChessPieceView(text: "卒", color: .black, isSelected: $isSelected)
            }
        }
    }
}