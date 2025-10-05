import Foundation

struct Preprocesamiento {
    static func preparar(
        _ texto: String,
        usarAlfabeto: [Character],
        conservarMayusculas: Bool = true,
        incluirCaracteresEspeciales: Bool = true,
        eliminarEspacios: Bool = false
    ) -> String {
        var resultado = ""

        for ch in texto {
            // Convertir según la configuración
            let letraProcesada = conservarMayusculas ? Character(String(ch).uppercased()) : Character(String(ch).lowercased())

            if usarAlfabeto.contains(letraProcesada) {
                resultado.append(letraProcesada)
            } else if !eliminarEspacios && ch == " " && usarAlfabeto.contains(" ") {
                resultado.append(" ")
            } else if incluirCaracteresEspeciales {
                resultado.append(ch)
            }
            // si no cumple nada, se descarta
        }

        return resultado
    }

    static func validar(_ texto: String, alfabeto: [Character], incluirCaracteresEspeciales: Bool = true) -> Bool {
        for ch in texto {
            if ch.isWhitespace { continue }
            if alfabeto.contains(ch) { continue }
            if incluirCaracteresEspeciales { continue }
            return false
        }
        return true
    }
}