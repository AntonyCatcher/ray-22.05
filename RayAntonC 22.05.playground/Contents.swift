import UIKit

func nearestMatrixDistance(_ matrix: [[Int]]) -> [[Int]] {
    let rowsCount = matrix.count
    let colsCount = matrix[0].count
    
    guard rowsCount >= 1 && rowsCount <= 1000 && colsCount >= 1 && colsCount <= 1000 && rowsCount * colsCount <= 1000 else {
        print("Некорректный размер матрицы")
        return []
    }
    
    for row in matrix {
        guard row.count == colsCount else {
            print("Количество элементов в строке матрицы не совпадает")
            return []
        }
        for element in row {
            guard element == 0 || element == 1 else {
                print("Элементы матрицы должны быть 0 или 1")
                return []
            }
        }
    }
    
    var result = Array(repeating: Array(repeating: Int.max, count: colsCount), count: rowsCount)
    
    // Обход матрицы слева направо и сверху вниз
    for i in 0..<rowsCount {
        for j in 0..<colsCount {
            if matrix[i][j] == 1 {
                result[i][j] = 0 // Расстояние до себя же равно 0
            } else {
                if i > 0 {
                    result[i][j] = min(result[i][j], result[i-1][j] + 1) // Из верхней ячейки
                }
                if j > 0 {
                    result[i][j] = min(result[i][j], result[i][j-1] + 1) // Из левой ячейки
                }
            }
        }
    }
    
    // Обход матрицы справа налево и снизу вверх
    for i in (0..<rowsCount).reversed() {
        for j in (0..<colsCount).reversed() {
            if i < rowsCount - 1 {
                result[i][j] = min(result[i][j], result[i+1][j] + 1) // Из нижней ячейки
            }
            if j < colsCount - 1 {
                result[i][j] = min(result[i][j], result[i][j+1] + 1) // Из правой ячейки
            }
        }
    }
    
    return result
}

// Пример использования
let testMatrix = [[1,0,1],
                  [0,1,0],
                  [0,0,0]]
let resultMatrix = nearestMatrixDistance(testMatrix)

print(resultMatrix)



