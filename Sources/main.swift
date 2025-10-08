// print("Hello, world!")
import Foundation

let config: ConfiguracionCripto = ConfiguracionCripto(
    alfabeto: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
    conservarMayusculas: true,
    incluirCaracteresEspeciales: true
)

// let mensaje = "Hola mundo"
let mensaje: String = "ESTATARDEVILLOVER"
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
// let claveVigenere = "NAVE"
// let cifradoVigenere = vigenere.cifrar(mensaje, clave: claveVigenere)
// let descifradoVigenere = vigenere.descifrar(cifradoVigenere, clave: claveVigenere)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoVigenere)")
// print("Descifrado: \(descifradoVigenere)")

print("\n--- CIFRADO TRANSPOSICIÓN DE COLUMNAS ---")

let transposicion = TransposicionColumnas(config: config)
let claveTransposicion = "HOLA"
let cifradoTransposicion = transposicion.cifrar(mensaje, clave: claveTransposicion)
let descifradoTransposicion = transposicion.descifrar(cifradoTransposicion, clave: claveTransposicion)

print("Texto original: \(mensaje)")
print("Cifrado: \(cifradoTransposicion)")
print("Descifrado: \(descifradoTransposicion)")


// print("\n--- CIFRADO SUSTITUCIÓN SIMPLE ---")
// let sustitucion = SustitucionSimple(config: config)
// let claveSustitucion = "QWERTYUIOPASDFGHJKLZXCVBNM"
// let cifradoSustitucion = sustitucion.cifrar(mensaje, clave: claveSustitucion)
// let descifradoSustitucion = sustitucion.descifrar(cifradoSustitucion, clave: claveSustitucion)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoSustitucion)")
// print("Descifrado: \(descifradoSustitucion)")

// print("/n--- CIFRADO ATBASH ---")
// let atbash = Atbash(config: config)
// let cifradoAtbash = atbash.cifrar(mensaje, clave: nil)
// let descifradoAtbash = atbash.descifrar(cifradoAtbash, clave: nil)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoAtbash)")
// print("Descifrado: \(descifradoAtbash)")

// print("\n--- CIFRADO RAIL FENCE ---")
// let railFence = RailFence(config: config)
// let claveRailFence = "3"
// let cifradoRailFence = railFence.cifrar(mensaje, clave: claveRailFence)
// let descifradoRailFence = railFence.descifrar(cifradoRailFence, clave: claveRailFence)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoRailFence)")
// print("Descifrado: \(descifradoRailFence)")

// print("\n--- CIFRADO PLAYFAIR ---")
// let playfair = Playfair(config: config)
// let clavePlayfair = "SEGURO"
// let cifradoPlayfair = playfair.cifrar(mensaje, clave: clavePlayfair)
// let descifradoPlayfair = playfair.descifrar(cifradoPlayfair, clave: clavePlayfair)
// print("Texto original: \(mensaje)")
// print("Cifrado: \(cifradoPlayfair)")
// print("Descifrado: \(descifradoPlayfair)")
