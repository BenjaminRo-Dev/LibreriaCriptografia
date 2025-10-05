class ConfiguracionCripto {
    var alfabeto: [Character]
    var conservarMayusculas: Bool
    var incluirCaracteresEspeciales: Bool

    init(
        alfabeto: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        conservarMayusculas: Bool = true,
        incluirCaracteresEspeciales: Bool = true
    ) {
        self.alfabeto = Array(alfabeto)
        self.conservarMayusculas = conservarMayusculas
        self.incluirCaracteresEspeciales = incluirCaracteresEspeciales
    }
}
