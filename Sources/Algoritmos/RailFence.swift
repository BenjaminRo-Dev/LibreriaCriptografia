class RailFence: Cripto {
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
        
        let numeroRieles = Int(clave ?? "3") ?? 3
        
        guard numeroRieles > 1 else {
            print("El número de rieles debe ser mayor a 1.")
            return texto
        }
        
        return cifrarRailFence(texto: textoLimpio, numeroRieles: numeroRieles)
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
        
        let numeroRieles = Int(clave ?? "3") ?? 3
        
        guard numeroRieles > 1 else {
            print("El número de rieles debe ser mayor a 1.")
            return texto
        }
        
        return descifrarRailFence(texto: textoLimpio, numeroRieles: numeroRieles)
    }
    
    // MARK: - Métodos privados
    
    private func cifrarRailFence(texto: String, numeroRieles: Int) -> String {
        guard numeroRieles > 1 && !texto.isEmpty else {
            return texto
        }
        
        // Crear matriz de rieles
        var rieles: [[Character]] = Array(repeating: [], count: numeroRieles)
        
        var rielActual = 0
        var direccion = 1 // 1 para abajo, -1 para arriba
        
        // Distribuir caracteres en los rieles
        for caracter in texto {
            rieles[rielActual].append(caracter)
            
            // Cambiar dirección en los extremos
            if rielActual == 0 {
                direccion = 1
            } else if rielActual == numeroRieles - 1 {
                direccion = -1
            }
            
            rielActual += direccion
        }
        
        // Concatenar todos los rieles
        var resultado = ""
        for riel in rieles {
            resultado += String(riel)
        }
        
        return resultado
    }
    
    private func descifrarRailFence(texto: String, numeroRieles: Int) -> String {
        guard numeroRieles > 1 && !texto.isEmpty else {
            return texto
        }
        
        let longitud = texto.count
        var resultado = Array(repeating: Character(" "), count: longitud)
        
        // Calcular patrones de índices para cada riel
        var indicesPorRiel: [[Int]] = Array(repeating: [], count: numeroRieles)
        
        var rielActual = 0
        var direccion = 1
        
        // Generar patrones de índices
        for i in 0..<longitud {
            indicesPorRiel[rielActual].append(i)
            
            // Cambiar dirección en los extremos
            if rielActual == 0 {
                direccion = 1
            } else if rielActual == numeroRieles - 1 {
                direccion = -1
            }
            
            rielActual += direccion
        }
        
        // Distribuir caracteres del texto cifrado según los patrones
        var indiceTexto = 0
        for riel in 0..<numeroRieles {
            for posicion in indicesPorRiel[riel] {
                if indiceTexto < texto.count {
                    let index = texto.index(texto.startIndex, offsetBy: indiceTexto)
                    resultado[posicion] = texto[index]
                    indiceTexto += 1
                }
            }
        }
        
        return String(resultado)
    }
    
    // MARK: - Métodos de utilidad para análisis
    
    /// Muestra la estructura de los rieles para análisis visual
    static func mostrarEstructuraRieles(texto: String, numeroRieles: Int) {
        guard numeroRieles > 1 && !texto.isEmpty else {
            print("Parámetros inválidos para mostrar estructura de rieles.")
            return
        }
        
        var estructura: [[Character?]] = Array(repeating: Array(repeating: nil, count: texto.count), count: numeroRieles)
        
        var rielActual = 0
        var direccion = 1
        
        for (index, caracter) in texto.enumerated() {
            estructura[rielActual][index] = caracter
            
            if rielActual == 0 {
                direccion = 1
            } else if rielActual == numeroRieles - 1 {
                direccion = -1
            }
            
            rielActual += direccion
        }
        
        print("\nEstructura de Rail Fence (\(numeroRieles) rieles):")
        for riel in 0..<numeroRieles {
            var linea = "Riel \(riel + 1): "
            for col in 0..<texto.count {
                if let caracter = estructura[riel][col] {
                    linea += String(caracter)
                } else {
                    linea += "."
                }
                linea += " "
            }
            print(linea)
        }
    }
}
