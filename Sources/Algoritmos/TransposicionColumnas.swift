class TransposicionColumnas: Cripto {
    var config: ConfiguracionCripto

    init(config: ConfiguracionCripto = ConfiguracionCripto()) {
        self.config = config
    }

    func cifrar(_ texto: String, clave: String?) -> String {
        // Limpieza y validación
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

        // Validar que la clave exista y no esté vacía
        guard let claveTexto = clave, !claveTexto.isEmpty else {
            print("Se requiere una clave válida para el cifrado de Transposición de Columnas.")
            return texto
        }

        // Preparar la clave y obtener el orden de las columnas
        let claveLimpia = Preprocesamiento.preparar(
            claveTexto,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: false,
            eliminarEspacios: true
        )

        guard !claveLimpia.isEmpty else {
            print("La clave no contiene caracteres válidos para el alfabeto definido.")
            return texto
        }

        let numColumnas = claveLimpia.count
        let ordenColumnas = obtenerOrdenColumnas(String(claveLimpia))

        // Calcular número de filas necesarias
        let numFilas = (textoLimpio.count + numColumnas - 1) / numColumnas

        // Crear matriz y llenarla por filas
        var matriz: [[Character]] = Array(repeating: Array(repeating: "X", count: numColumnas), count: numFilas)
        
        var indice = 0
        for fila in 0..<numFilas {
            for columna in 0..<numColumnas {
                if indice < textoLimpio.count {
                    let caracter = textoLimpio[textoLimpio.index(textoLimpio.startIndex, offsetBy: indice)]
                    matriz[fila][columna] = caracter
                    indice += 1
                } else {
                    // Rellenar con 'X' si es necesario
                    matriz[fila][columna] = "X"
                }
            }
        }

        // Leer las columnas en el orden determinado por la clave
        var resultado = ""
        for ordenColumna in ordenColumnas {
            for fila in 0..<numFilas {
                resultado.append(matriz[fila][ordenColumna])
            }
        }

        return resultado
    }

    func descifrar(_ texto: String, clave: String?) -> String {
        // Limpieza y validación
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

        // Validar que la clave exista y no esté vacía
        guard let claveTexto = clave, !claveTexto.isEmpty else {
            print("Se requiere una clave válida para el descifrado de Transposición de Columnas.")
            return texto
        }

        // Preparar la clave y obtener el orden de las columnas
        let claveLimpia = Preprocesamiento.preparar(
            claveTexto,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: false,
            eliminarEspacios: true
        )

        guard !claveLimpia.isEmpty else {
            print("La clave no contiene caracteres válidos para el alfabeto definido.")
            return texto
        }

        let numColumnas = claveLimpia.count
        let ordenColumnas = obtenerOrdenColumnas(String(claveLimpia))

        // Calcular número de filas
        let numFilas = textoLimpio.count / numColumnas

        guard textoLimpio.count % numColumnas == 0 else {
            print("La longitud del texto no es compatible con la clave para descifrar.")
            return texto
        }

        // Crear matriz vacía
        var matriz: [[Character]] = Array(repeating: Array(repeating: " ", count: numColumnas), count: numFilas)

        // Llenar la matriz columna por columna según el orden de la clave
        var indice = 0
        for ordenColumna in ordenColumnas {
            for fila in 0..<numFilas {
                if indice < textoLimpio.count {
                    let caracter = textoLimpio[textoLimpio.index(textoLimpio.startIndex, offsetBy: indice)]
                    matriz[fila][ordenColumna] = caracter
                    indice += 1
                }
            }
        }

        // Leer la matriz por filas para obtener el texto original
        var resultado = ""
        for fila in 0..<numFilas {
            for columna in 0..<numColumnas {
                resultado.append(matriz[fila][columna])
            }
        }

        // Eliminar caracteres de relleno 'X' al final
        while resultado.hasSuffix("X") {
            resultado.removeLast()
        }

        return resultado
    }

    // Función auxiliar para obtener el orden de las columnas basado en la clave
    private func obtenerOrdenColumnas(_ clave: String) -> [Int] {
        let caracteres = Array(clave)
        let caracteresOrdenados = caracteres.sorted()
        var orden: [Int] = []

        for caracterOrdenado in caracteresOrdenados {
            if let indice = caracteres.firstIndex(of: caracterOrdenado) {
                if !orden.contains(indice) {
                    orden.append(indice)
                }
            }
        }

        // Agregar cualquier índice faltante (en caso de caracteres duplicados)
        for i in 0..<caracteres.count {
            if !orden.contains(i) {
                orden.append(i)
            }
        }

        return orden
    }
}
