// print("Hello, world!")
import Foundation

let config: ConfiguracionCripto = ConfiguracionCripto(
    alfabeto: "ABCDEFGHIJKLMNOPQRSTUVWXYZ ",
    conservarMayusculas: true,
    incluirCaracteresEspeciales: true
)

let mensaje = "Hola mundo"
// let mensaje = "¡Hola, mundo 123! ¿Cómo estás?"

let claveCesar = "3"
let claveVigenere = "CLAVE"

print("\n--- CIFRADO CÉSAR ---")
let cesar = Cesar(config: config)
let cifradoCesar = cesar.cifrar(mensaje, clave: claveCesar)
let descifradoCesar = cesar.descifrar(cifradoCesar, clave: claveCesar)
print("Texto original: \(mensaje)")
print("Cifrado: \(cifradoCesar)")
print("Descifrado: \(descifradoCesar)")

// AnalizadorFrecuencia.imprimirAnalisis(mensaje)

