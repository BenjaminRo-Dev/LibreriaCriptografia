class SustitucionSimple: Cripto {
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
            print("Se requiere una clave válida para el cifrado de Sustitución Simple.")
            return texto
        }

        // Generar el alfabeto de sustitución basado en la clave
        guard let alfabetoSustitucion = generarAlfabetoSustitucion(claveTexto) else {
            print("No se pudo generar un alfabeto de sustitución válido con la clave proporcionada.")
            return texto
        }

        // Crear el mapeo de sustitución
        let alfabetoOriginal = config.alfabeto
        guard alfabetoOriginal.count == alfabetoSustitucion.count else {
            print("El alfabeto de sustitución debe tener la misma longitud que el alfabeto original.")
            return texto
        }

        var mapeoSustitucion: [Character: Character] = [:]
        for i in 0..<alfabetoOriginal.count {
            mapeoSustitucion[alfabetoOriginal[i]] = alfabetoSustitucion[i]
        }

        // Aplicar la sustitución
        var resultado = ""
        for ch in textoLimpio {
            if let caracterSustituido = mapeoSustitucion[ch] {
                resultado.append(caracterSustituido)
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
            print("Se requiere una clave válida para el descifrado de Sustitución Simple.")
            return texto
        }

        // Generar el alfabeto de sustitución basado en la clave
        guard let alfabetoSustitucion = generarAlfabetoSustitucion(claveTexto) else {
            print("No se pudo generar un alfabeto de sustitución válido con la clave proporcionada.")
            return texto
        }

        // Crear el mapeo inverso de sustitución
        let alfabetoOriginal = config.alfabeto
        guard alfabetoOriginal.count == alfabetoSustitucion.count else {
            print("El alfabeto de sustitución debe tener la misma longitud que el alfabeto original.")
            return texto
        }

        var mapeoInverso: [Character: Character] = [:]
        for i in 0..<alfabetoOriginal.count {
            mapeoInverso[alfabetoSustitucion[i]] = alfabetoOriginal[i]
        }

        // Aplicar la sustitución inversa
        var resultado = ""
        for ch in textoLimpio {
            if let caracterOriginal = mapeoInverso[ch] {
                resultado.append(caracterOriginal)
            } else {
                // Carácter especial -> mantener o convertir a espacio según config
                resultado.append(config.incluirCaracteresEspeciales ? ch : " ")
            }
        }

        return resultado
    }

    // Función auxiliar para generar el alfabeto de sustitución basado en la clave
    private func generarAlfabetoSustitucion(_ clave: String) -> [Character]? {
        // Preparar la clave
        let claveLimpia = Preprocesamiento.preparar(
            clave,
            usarAlfabeto: config.alfabeto,
            conservarMayusculas: config.conservarMayusculas,
            incluirCaracteresEspeciales: false,
            eliminarEspacios: true
        )

        guard !claveLimpia.isEmpty else {
            return nil
        }

        var alfabetoSustitucion: [Character] = []
        var caracteresUsados: Set<Character> = []

        // Agregar caracteres únicos de la clave primero
        for ch in claveLimpia {
            if config.alfabeto.contains(ch) && !caracteresUsados.contains(ch) {
                alfabetoSustitucion.append(ch)
                caracteresUsados.insert(ch)
            }
        }

        // Agregar el resto de caracteres del alfabeto original que no están en la clave
        for ch in config.alfabeto {
            if !caracteresUsados.contains(ch) {
                alfabetoSustitucion.append(ch)
                caracteresUsados.insert(ch)
            }
        }

        // Verificar que el alfabeto de sustitución tenga la longitud correcta
        guard alfabetoSustitucion.count == config.alfabeto.count else {
            return nil
        }

        return alfabetoSustitucion
    }

    // Función auxiliar para mostrar el mapeo de sustitución (útil para depuración)
    func mostrarMapeo(_ clave: String) -> String {
        guard let alfabetoSustitucion = generarAlfabetoSustitucion(clave) else {
            return "No se pudo generar el alfabeto de sustitución."
        }

        var mapeo = "Mapeo de Sustitución:\n"
        mapeo += "Original:    \(String(config.alfabeto))\n"
        mapeo += "Sustitución: \(String(alfabetoSustitucion))\n"

        return mapeo
    }
}
