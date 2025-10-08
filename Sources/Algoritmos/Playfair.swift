class Playfair: Cripto {
    var config: ConfiguracionCripto
    
    init(config: ConfiguracionCripto = ConfiguracionCripto()) {
        self.config = config
    }
    
    func cifrar(_ texto: String, clave: String?) -> String {
        let textoLimpio = Preprocesamiento.preparar(
            texto,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: config.incluirCaracteresEspeciales,
            eliminarEspacios: true
        )
        
        guard Preprocesamiento.validar(textoLimpio, alfabeto: config.alfabeto, incluirCaracteresEspeciales: config.incluirCaracteresEspeciales) else {
            print("Texto contiene caracteres no válidos para el alfabeto definido.")
            return texto
        }
        
        guard let claveString = clave, !claveString.isEmpty else {
            print("La clave es requerida para el cifrado Playfair.")
            return texto
        }
        
        let matriz = generarMatriz(clave: claveString)
        let pares = prepararPares(texto: textoLimpio)
        var resultado = ""
        
        for par in pares {
            let (pos1, pos2) = encontrarPosiciones(par: par, matriz: matriz)
            let cifrado = cifrarPar(pos1: pos1, pos2: pos2, matriz: matriz)
            resultado.append(cifrado)
        }
        
        return resultado
    }
    
    func descifrar(_ texto: String, clave: String?) -> String {
        let textoLimpio = Preprocesamiento.preparar(
            texto,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: config.incluirCaracteresEspeciales,
            eliminarEspacios: true
        )
        
        guard Preprocesamiento.validar(textoLimpio, alfabeto: config.alfabeto, incluirCaracteresEspeciales: config.incluirCaracteresEspeciales) else {
            print("Texto contiene caracteres no válidos para el alfabeto definido.")
            return texto
        }
        
        guard let claveString = clave, !claveString.isEmpty else {
            print("La clave es requerida para el descifrado Playfair.")
            return texto
        }
        
        let matriz = generarMatriz(clave: claveString)
        let pares = prepararPares(texto: textoLimpio)
        var resultado = ""
        
        for par in pares {
            let (pos1, pos2) = encontrarPosiciones(par: par, matriz: matriz)
            let descifrado = descifrarPar(pos1: pos1, pos2: pos2, matriz: matriz)
            resultado.append(descifrado)
        }
        
        return resultado
    }
    
    // MARK: - Métodos privados
    
    private func generarMatriz(clave: String) -> [[Character]] {
        var alfabetoCompleto = config.alfabeto
        var matriz: [[Character]] = []
        var usados: Set<Character> = []
        
        // Agregar caracteres de la clave
        for char in clave.uppercased() {
            if alfabetoCompleto.contains(char) && !usados.contains(char) {
                usados.insert(char)
            }
        }
        
        // Agregar caracteres restantes del alfabeto
        for char in alfabetoCompleto {
            if !usados.contains(char) {
                usados.insert(char)
            }
        }
        
        // Crear matriz 5x5
        let caracteres = Array(usados)
        for i in 0..<5 {
            var fila: [Character] = []
            for j in 0..<5 {
                let index = i * 5 + j
                if index < caracteres.count {
                    fila.append(caracteres[index])
                }
            }
            matriz.append(fila)
        }
        
        return matriz
    }
    
    private func prepararPares(texto: String) -> [String] {
        var pares: [String] = []
        var textoProcesado = texto
        
        // Reemplazar 'J' con 'I' si está en el alfabeto
        if config.alfabeto.contains("I") && config.alfabeto.contains("J") {
            textoProcesado = textoProcesado.replacingOccurrences(of: "J", with: "I")
        }
        
        // Agregar caracteres de relleno si es necesario
        var i = 0
        while i < textoProcesado.count {
            let startIndex = textoProcesado.index(textoProcesado.startIndex, offsetBy: i)
            let endIndex = textoProcesado.index(startIndex, offsetBy: min(2, textoProcesado.count - i))
            let par = String(textoProcesado[startIndex..<endIndex])
            
            if par.count == 1 {
                // Agregar 'X' como relleno
                pares.append(par + "X")
            } else if par.count == 2 && par.first == par.last {
                // Si los caracteres son iguales, agregar 'X' entre ellos
                let char = par.first!
                pares.append(String(char) + "X")
                i -= 1 // Retroceder para procesar el segundo carácter
            } else {
                pares.append(par)
            }
            
            i += 2
        }
        
        return pares
    }
    
    private func encontrarPosiciones(par: String, matriz: [[Character]]) -> ((Int, Int), (Int, Int)) {
        var pos1 = (0, 0)
        var pos2 = (0, 0)
        
        for i in 0..<5 {
            for j in 0..<5 {
                if matriz[i][j] == par.first {
                    pos1 = (i, j)
                }
                if matriz[i][j] == par.last {
                    pos2 = (i, j)
                }
            }
        }
        
        return (pos1, pos2)
    }
    
    private func cifrarPar(pos1: (Int, Int), pos2: (Int, Int), matriz: [[Character]]) -> String {
        let (fila1, col1) = pos1
        let (fila2, col2) = pos2
        
        // Misma fila
        if fila1 == fila2 {
            return String(matriz[fila1][(col1 + 1) % 5]) + String(matriz[fila2][(col2 + 1) % 5])
        }
        // Misma columna
        else if col1 == col2 {
            return String(matriz[(fila1 + 1) % 5][col1]) + String(matriz[(fila2 + 1) % 5][col2])
        }
        // Rectángulo
        else {
            return String(matriz[fila1][col2]) + String(matriz[fila2][col1])
        }
    }
    
    private func descifrarPar(pos1: (Int, Int), pos2: (Int, Int), matriz: [[Character]]) -> String {
        let (fila1, col1) = pos1
        let (fila2, col2) = pos2
        
        // Misma fila
        if fila1 == fila2 {
            let newCol1 = col1 == 0 ? 4 : col1 - 1
            let newCol2 = col2 == 0 ? 4 : col2 - 1
            return String(matriz[fila1][newCol1]) + String(matriz[fila2][newCol2])
        }
        // Misma columna
        else if col1 == col2 {
            let newFila1 = fila1 == 0 ? 4 : fila1 - 1
            let newFila2 = fila2 == 0 ? 4 : fila2 - 1
            return String(matriz[newFila1][col1]) + String(matriz[newFila2][col2])
        }
        // Rectángulo
        else {
            return String(matriz[fila1][col2]) + String(matriz[fila2][col1])
        }
    }
}
