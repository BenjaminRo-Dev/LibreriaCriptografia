// print("Hello, world!")
import Foundation

let config: ConfiguracionCripto = ConfiguracionCripto(
    alfabeto: "ABCDEFGHIJKLMNOPQRSTUVWXYZ ",
    conservarMayusculas: true,
    incluirCaracteresEspeciales: true
)

// let mensaje = "Hola mundo"
let mensaje = "HOLAMUNDO"
// let mensaje = "¡Hola, mundo 123! ¿Cómo estás?"

// let claveCesar = "3"

// print("\n--- CIFRADO CÉSAR ---")
// let cesar = Cesar(config: config)
// let cifradoCesar = cesar.cifrar(mensaje, clave: claveCesar)
// let descifradoCesar = cesar.descifrar(cifradoCesar, clave: claveCesar)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoCesar)")
// print("Descifrado: \(descifradoCesar)")

// AnalizadorFrecuencia.imprimirAnalisis(mensaje)

// print("\n---- CIFRADO VIGENERE ----")
// let vigenere = Vigenere(config: config)
// let claveVigenere = "CLAVE"
// let cifradoVigenere = vigenere.cifrar(mensaje, clave: claveVigenere)
// let descifradoVigenere = vigenere.descifrar(cifradoVigenere, clave: claveVigenere)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoVigenere)")
// print("Descifrado: \(descifradoVigenere)")

// print("\n--- CIFRADO TRANSPOSICIÓN DE COLUMNAS ---")

// let transposicion = TransposicionColumnas(config: config)
// let claveTransposicion = "CLAVE"
// let cifradoTransposicion = transposicion.cifrar(mensaje, clave: claveTransposicion)
// let descifradoTransposicion = transposicion.descifrar(cifradoTransposicion, clave: claveTransposicion)

// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoTransposicion)")
// print("Descifrado: \(descifradoTransposicion)")


// print("\n--- CIFRADO SUSTITUCIÓN SIMPLE ---")
// let sustitucion = SustitucionSimple(config: config)
// let claveSustitucion = "QWERTYUIOPASDFGHJKLZXCVBNM"
// let cifradoSustitucion = sustitucion.cifrar(mensaje, clave: claveSustitucion)
// let descifradoSustitucion = sustitucion.descifrar(cifradoSustitucion, clave: claveSustitucion)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoSustitucion)")
// print("Descifrado: \(descifradoSustitucion)")

print("/n--- CIFRADO ATBASH ---")
let atbash = Atbash(config: config)
let cifradoAtbash = atbash.cifrar(mensaje, clave: nil)
let descifradoAtbash = atbash.descifrar(cifradoAtbash, clave: nil)
print("Texto original: \(mensaje)")
print("Cifrado: \(cifradoAtbash)")
print("Descifrado: \(descifradoAtbash)")

