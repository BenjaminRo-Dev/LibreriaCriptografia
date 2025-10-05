protocol Cripto {
    var config: ConfiguracionCripto { get set }
    func cifrar(_ texto: String, clave: String?) -> String
    func descifrar(_ texto: String, clave: String?) -> String
}

