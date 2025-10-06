class Atbash: Cripto {
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
            incluirCaracteresEspeciales: config.incluirCaracteresEspeciales
        )

        guard Preprocesamiento.validar(textoLimpio, alfabeto: config.alfabeto, incluirCaracteresEspeciales: config.incluirCaracteresEspeciales) else {
            print("Texto contiene caracteres no válidos para el alfabeto definido.")
            return texto
        }

        // Nota: Atbash no requiere clave, pero respetamos la interfaz
        if let claveTexto = clave, !claveTexto.isEmpty {
            print("Información: El cifrado Atbash no utiliza clave, pero se procesará el texto normalmente.")
        }

        return aplicarTransformacionAtbash(textoLimpio)
    }

    func descifrar(_ texto: String, clave: String?) -> String {
        // Limpieza y validación
        let textoLimpio = Preprocesamiento.preparar(
            texto,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: config.incluirCaracteresEspeciales
        )

        guard Preprocesamiento.validar(textoLimpio, alfabeto: config.alfabeto, incluirCaracteresEspeciales: config.incluirCaracteresEspeciales) else {
            print("Texto contiene caracteres no válidos para el alfabeto definido.")
            return texto
        }

        // Nota: En Atbash, cifrar y descifrar son la misma operación (es simétrico)
        if let claveTexto = clave, !claveTexto.isEmpty {
            print("Información: El cifrado Atbash no utiliza clave, pero se procesará el texto normalmente.")
        }

        return aplicarTransformacionAtbash(textoLimpio)
    }

    // Función auxiliar que aplica la transformación Atbash
    private func aplicarTransformacionAtbash(_ texto: String) -> String {
        let alfabeto = config.alfabeto
        let tamaño = alfabeto.count
        var resultado = ""

        for ch in texto {
            if let index = alfabeto.firstIndex(of: ch) {
                // Calcular la posición inversa: primera letra ↔ última letra
                let posicionOriginal = alfabeto.distance(from: alfabeto.startIndex, to: index)
                let posicionInversa = tamaño - 1 - posicionOriginal
                let caracterInverso = alfabeto[alfabeto.index(alfabeto.startIndex, offsetBy: posicionInversa)]
                resultado.append(caracterInverso)
            } else {
                // Carácter especial -> mantener o convertir a espacio según config
                resultado.append(config.incluirCaracteresEspeciales ? ch : " ")
            }
        }

        return resultado
    }

    // Función auxiliar para mostrar el mapeo Atbash (útil para comprensión)
    func mostrarMapeoAtbash() -> String {
        let alfabeto = config.alfabeto
        let tamaño = alfabeto.count
        
        var mapeo = "Mapeo Atbash:\n"
        mapeo += "Original: "
        for ch in alfabeto {
            mapeo += String(ch)
        }
        mapeo += "\n"
        
        mapeo += "Atbash:   "
        for ch in alfabeto {
            if let index = alfabeto.firstIndex(of: ch) {
                let posicionOriginal = alfabeto.distance(from: alfabeto.startIndex, to: index)
                let posicionInversa = tamaño - 1 - posicionOriginal
                let caracterInverso = alfabeto[alfabeto.index(alfabeto.startIndex, offsetBy: posicionInversa)]
                mapeo += String(caracterInverso)
            }
        }
        mapeo += "\n"

        return mapeo
    }

    // Función auxiliar para verificar que un texto y su transformación Atbash son correctos
    func verificarSimetria(_ texto: String) -> Bool {
        let textoCifrado = cifrar(texto, clave: nil)
        let textoDescifrado = descifrar(textoCifrado, clave: nil)
        return texto.uppercased() == textoDescifrado.uppercased()
    }
}
