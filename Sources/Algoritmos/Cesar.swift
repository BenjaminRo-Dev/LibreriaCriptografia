class Cesar: Cripto {
    var config: ConfiguracionCripto

    init(config: ConfiguracionCripto = ConfiguracionCripto()) {
        self.config = config
    }

    func cifrar(_ texto: String, clave: String?) -> String {
        // limpieza y validación 
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

        let desplazamiento = Int(clave ?? "3") ?? 3
        let alfabeto = config.alfabeto
        let tamaño = alfabeto.count
        var resultado = ""

        for ch in textoLimpio {
            if let index = alfabeto.firstIndex(of: ch) {
                let nuevoIndex = (index + desplazamiento) % tamaño
                resultado.append(alfabeto[nuevoIndex])
            } else {
                // carácter especial -> mantener o convertir a espacio según config
                resultado.append(config.incluirCaracteresEspeciales ? ch : " ")
            }
        }
        return resultado
    }

    func descifrar(_ texto: String, clave: String?) -> String {
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

        let desplazamiento = Int(clave ?? "3") ?? 3
        let alfabeto = config.alfabeto
        let tamaño = alfabeto.count
        var resultado = ""

        for ch in textoLimpio {
            if let index = alfabeto.firstIndex(of: ch) {
                let nuevoIndex = (index - desplazamiento + tamaño) % tamaño
                resultado.append(alfabeto[nuevoIndex])
            } else {
                resultado.append(config.incluirCaracteresEspeciales ? ch : " ")
            }
        }
        return resultado
    }
}