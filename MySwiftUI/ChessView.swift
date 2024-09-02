import SwiftUI

struct ChessView: View {
    let boardSize = 9
    let pieceSize: CGFloat = 40
    @State private var pieces: [ChessPiece] = []
    @State private var selectedPiece: ChessPiece? = nil

    var body: some View {
        VStack {
            ZStack {
                // 绘制棋盘
                ForEach(0..<boardSize) { row in
                    ForEach(0..<boardSize) { col in
                        if row != 4 { // 河界不绘制横线
                            Path { path in
                                path.move(to: CGPoint(x: CGFloat(col) * pieceSize, y: CGFloat(row) * pieceSize))
                                path.addLine(to: CGPoint(x: CGFloat(col) * pieceSize, y: CGFloat(row + 1) * pieceSize))
                            }
                            .stroke(Color.black, lineWidth: 1)
                        }
                        if col < boardSize - 1 { // 最右边不绘制竖线
                            Path { path in
                                path.move(to: CGPoint(x: CGFloat(col) * pieceSize, y: CGFloat(row) * pieceSize))
                                path.addLine(to: CGPoint(x: CGFloat(col + 1) * pieceSize, y: CGFloat(row) * pieceSize))
                            }
                            .stroke(Color.black, lineWidth: 1)
                        }
                    }
                }
                // 绘制河界文字
                Text("楚河")
                    .position(x: CGFloat(1.5) * pieceSize, y: CGFloat(4.5) * pieceSize)
                    .foregroundColor(.blue)
                Text("汉界")
                    .position(x: CGFloat(7.5) * pieceSize, y: CGFloat(4.5) * pieceSize)
                    .foregroundColor(.blue)
                
                // 绘制九宫格
                Path { path in
                    path.move(to: CGPoint(x: 3 * pieceSize, y: 0))
                    path.addLine(to: CGPoint(x: 5 * pieceSize, y: 2 * pieceSize))
                    path.move(to: CGPoint(x: 5 * pieceSize, y: 0))
                    path.addLine(to: CGPoint(x: 3 * pieceSize, y: 2 * pieceSize))
                    path.move(to: CGPoint(x: 3 * pieceSize, y: 7 * pieceSize))
                    path.addLine(to: CGPoint(x: 5 * pieceSize, y: 9 * pieceSize))
                    path.move(to: CGPoint(x: 5 * pieceSize, y: 7 * pieceSize))
                    path.addLine(to: CGPoint(x: 3 * pieceSize, y: 9 * pieceSize))
                }
                .stroke(Color.black, lineWidth: 1)
                
                // 绘制棋子
                ForEach(pieces) { piece in
                    ChessPieceView(text: piece.text, color: piece.color, isSelected: Binding(
                        get: { selectedPiece?.id == piece.id },
                        set: { isSelected in
                            if isSelected {
                                selectedPiece = piece
                            } else if selectedPiece?.id == piece.id {
                                selectedPiece = nil
                            }
                        }
                    ))
                    .position(x: CGFloat(piece.col) * pieceSize, y: CGFloat(piece.row) * pieceSize)
                }
                
                // 棋盘点击手势
                ForEach(0..<boardSize) { row in
                    ForEach(0..<boardSize) { col in
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: pieceSize, height: pieceSize)
                            .position(x: CGFloat(col) * pieceSize, y: CGFloat(row) * pieceSize)
                            .onTapGesture {
                                if let selectedPiece = selectedPiece {
                                    movePiece(selectedPiece, to: (row, col))
                                }
                            }
                    }
                }
            }
            .frame(width: pieceSize * CGFloat(boardSize - 1), height: pieceSize * CGFloat(boardSize - 1))
        }
        .onAppear {
            setupPieces()
        }
    }

    // 设置棋子
    func setupPieces() {
        pieces = [
            // 红方棋子
            ChessPiece(row: 0, col: 0, text: "車", color: .red),
            ChessPiece(row: 0, col: 1, text: "馬", color: .red),
            ChessPiece(row: 0, col: 2, text: "相", color: .red),
            ChessPiece(row: 0, col: 3, text: "仕", color: .red),
            ChessPiece(row: 0, col: 4, text: "帥", color: .red),
            ChessPiece(row: 0, col: 5, text: "仕", color: .red),
            ChessPiece(row: 0, col: 6, text: "相", color: .red),
            ChessPiece(row: 0, col: 7, text: "馬", color: .red),
            ChessPiece(row: 0, col: 8, text: "車", color: .red),
            ChessPiece(row: 2, col: 1, text: "炮", color: .red),
            ChessPiece(row: 2, col: 7, text: "炮", color: .red),
            ChessPiece(row: 3, col: 0, text: "兵", color: .red),
            ChessPiece(row: 3, col: 2, text: "兵", color: .red),
            ChessPiece(row: 3, col: 4, text: "兵", color: .red),
            ChessPiece(row: 3, col: 6, text: "兵", color: .red),
            ChessPiece(row: 3, col: 8, text: "兵", color: .red),
            
            // 黑方棋子
            ChessPiece(row: 9, col: 0, text: "車", color: .black),
            ChessPiece(row: 9, col: 1, text: "馬", color: .black),
            ChessPiece(row: 9, col: 2, text: "象", color: .black),
            ChessPiece(row: 9, col: 3, text: "士", color: .black),
            ChessPiece(row: 9, col: 4, text: "將", color: .black),
            ChessPiece(row: 9, col: 5, text: "士", color: .black),
            ChessPiece(row: 9, col: 6, text: "象", color: .black),
            ChessPiece(row: 9, col: 7, text: "馬", color: .black),
            ChessPiece(row: 9, col: 8, text: "車", color: .black),
            ChessPiece(row: 7, col: 1, text: "炮", color: .black),
            ChessPiece(row: 7, col: 7, text: "炮", color: .black),
            ChessPiece(row: 6, col: 0, text: "卒", color: .black),
            ChessPiece(row: 6, col: 2, text: "卒", color: .black),
            ChessPiece(row: 6, col: 4, text: "卒", color: .black),
            ChessPiece(row: 6, col: 6, text: "卒", color: .black),
            ChessPiece(row: 6, col: 8, text: "卒", color: .black)
        ]
    }

    // 移动棋子
    func movePiece(_ piece: ChessPiece, to position: (Int, Int)) {
        if let index = pieces.firstIndex(where: { $0.id == piece.id }) {
            pieces[index].row = position.0
            pieces[index].col = position.1
            selectedPiece = nil
        }
    }
}

struct ChessPiece: Identifiable {
    let id = UUID()
    var row: Int
    var col: Int
    var text: String
    var color: Color
}

struct ChessView_Previews: PreviewProvider {
    static var previews: some View {
        ChessView()
    }
}