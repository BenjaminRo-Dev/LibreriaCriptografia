class Vigenere: Cripto {
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

        // Validar que la clave exista y no esté vacía
        guard let claveTexto = clave, !claveTexto.isEmpty else {
            print("Se requiere una clave válida para el cifrado Vigenère.")
            return texto
        }

        // Preparar la clave con la misma configuración que el texto
        let claveLimpia = Preprocesamiento.preparar(
            claveTexto,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: false
        )

        guard !claveLimpia.isEmpty else {
            print("La clave no contiene caracteres válidos para el alfabeto definido.")
            return texto
        }

        let alfabeto = config.alfabeto
        let tamaño = alfabeto.count
        var resultado = ""
        var indiceTexto = 0

        for ch in textoLimpio {
            if let indexTexto = alfabeto.firstIndex(of: ch) {
                // Obtener el carácter correspondiente de la clave (cíclica)
                let caracterClave = claveLimpia[claveLimpia.index(claveLimpia.startIndex, offsetBy: indiceTexto % claveLimpia.count)]
                
                if let indexClave = alfabeto.firstIndex(of: caracterClave) {
                    // Aplicar el desplazamiento de Vigenère
                    let nuevoIndex = (indexTexto + indexClave) % tamaño
                    resultado.append(alfabeto[nuevoIndex])
                    indiceTexto += 1
                }
            } else {
                // Carácter especial -> mantener o convertir a espacio según config
                resultado.append(config.incluirCaracteresEspeciales ? ch : " ")
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
            incluirCaracteresEspeciales: config.incluirCaracteresEspeciales
        )

        guard Preprocesamiento.validar(textoLimpio, alfabeto: config.alfabeto, incluirCaracteresEspeciales: config.incluirCaracteresEspeciales) else {
            print("Texto contiene caracteres no válidos para el alfabeto definido.")
            return texto
        }

        // Validar que la clave exista y no esté vacía
        guard let claveTexto = clave, !claveTexto.isEmpty else {
            print("Se requiere una clave válida para el cifrado Vigenère.")
            return texto
        }

        // Preparar la clave con la misma configuración que el texto
        let claveLimpia = Preprocesamiento.preparar(
            claveTexto,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: false
        )

        guard !claveLimpia.isEmpty else {
            print("La clave no contiene caracteres válidos para el alfabeto definido.")
            return texto
        }

        let alfabeto = config.alfabeto
        let tamaño = alfabeto.count
        var resultado = ""
        var indiceTexto = 0

        for ch in textoLimpio {
            if let indexTexto = alfabeto.firstIndex(of: ch) {
                // Obtener el carácter correspondiente de la clave (cíclica)
                let caracterClave = claveLimpia[claveLimpia.index(claveLimpia.startIndex, offsetBy: indiceTexto % claveLimpia.count)]
                
                if let indexClave = alfabeto.firstIndex(of: caracterClave) {
                    // Aplicar el desplazamiento inverso de Vigenère
                    let nuevoIndex = (indexTexto - indexClave + tamaño) % tamaño
                    resultado.append(alfabeto[nuevoIndex])
                    indiceTexto += 1
                }
            } else {
                // Carácter especial -> mantener o convertir a espacio según config
                resultado.append(config.incluirCaracteresEspeciales ? ch : " ")
            }
        }

        return resultado
    }
}
