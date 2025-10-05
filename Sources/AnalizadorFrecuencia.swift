class AnalizadorFrecuencia {
    static func analizar(_ texto: String) -> [Character: Double] {
        let letras: String = texto.filter { $0.isLetter }
        let total: Double = Double(letras.count)
        var conteo: [Character: Double] = [:]
        for char: Character in letras {
            conteo[char, default: 0] += 1
        }
        for (char, count) in conteo {
            conteo[char] = (count / total) * 100
        }
        return conteo.sorted(by: { $0.key < $1.key }).reduce(into: [:]) { $0[$1.key] = $1.value }
    }

    static func imprimirAnalisis(_ texto: String) {
        let analisis = analizar(texto)
        print("\n📊 Análisis de Frecuencia:")
        for (letra, porcentaje) in analisis {
            print("\(letra): \(String(format: "%.2f", porcentaje))%")
        }
    }
}
