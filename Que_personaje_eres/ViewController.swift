//
//  ViewController.swift
//  Que_personaje_eres
//
//  Created by Tsukimo on 27/01/24.
//

import UIKit

class ViewController: UIViewController {
    struct Personaje {
        let nombre: String
        let esHumano: Bool
        let tieneSombrero: Bool
        let esMujer: Bool
        let habla: Bool
        let llevaArmaDeFuego: Bool
        let descripcion: String
        let imagen: String
    }
    
    var preguntas: [String] = ["¿Es humano?", "¿Tiene sombrero?", "¿Es mujer?", "¿Habla?", "¿Lleva arma de fuego?"]
    var respuestasUsuario: [Bool] = []
    
    var personajes: [Personaje] = [
        Personaje(nombre: "Jinx", esHumano: true, tieneSombrero: false, esMujer: true, habla: true, llevaArmaDeFuego: true, descripcion: "Jinx es una caótica y excéntrica artillera. Tiene una predilección por la destrucción y el caos, disfrutando de la emoción de la batalla. Su estilo de juego se centra en el uso de armas de fuego y explosivos.", imagen: "jinx_0.jpg"),
        Personaje(nombre: "Miss Fortune", esHumano: true, tieneSombrero: true, esMujer: true, habla: true, llevaArmaDeFuego: true, descripcion: "Miss Fortune, también conocida como Sarah Fortune, es una astuta cazadora de recompensas. Utiliza sus habilidades de combate y su astucia para perseguir a los criminales. Su estilo de juego destaca por su habilidad para infligir daño a larga distancia.", imagen: "Mf_0.jpg"),
        Personaje(nombre: "Twisted Fate", esHumano: true, tieneSombrero: true, esMujer: false, habla: true, llevaArmaDeFuego: false, descripcion: "Twisted Fate es un astuto mago y jugador de cartas. Sus habilidades mágicas están relacionadas con el uso de cartas de juego para infligir daño y manipular la suerte en su favor. Su estilo de juego se basa en su versatilidad y capacidad para controlar el campo de batalla.", imagen: "Tf_0.jpg"),
        Personaje(nombre: "Teemo", esHumano: false, tieneSombrero: true, esMujer: false, habla: true, llevaArmaDeFuego: false, descripcion: "Teemo es un yordle explorador que utiliza su astucia y habilidades para sabotear a sus enemigos. Es conocido por su capacidad para colocar trampas venenosas y emboscar a sus adversarios. Su estilo de juego se centra en el sigilo y el control del terreno.", imagen: "Teemo_0.jpg"),
        Personaje(nombre: "Skarner", esHumano: false, tieneSombrero: false, esMujer: false, habla: false, llevaArmaDeFuego: false, descripcion: "Skarner es un cristalino escorpión de las llanuras de Shurima. Es un luchador robusto que utiliza sus habilidades de escorpión para inmovilizar y dañar a sus enemigos. Su estilo de juego destaca por su resistencia y capacidad para controlar las peleas.", imagen: "Skarner_0.jpg")
    ]
    
    @IBOutlet weak var page_n: UITextField!
    @IBOutlet weak var questions: UITextField!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var Instructions: UITextField!
    @IBOutlet weak var response1: UIButton!
    @IBOutlet weak var response2: UIButton!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var again: UIButton!
    @IBOutlet weak var Descripcion_text: UITextView!
    var totalQuestions = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagen.isHidden = true
        Descripcion_text.isHidden = true
        mostrarPregunta()
    }
    
    func mostrarPregunta() {
        guard let preguntaActual = preguntas.first else {
            mostrarResultado()
            return
        }
        
        questions.text = preguntaActual
    }
    
    @IBAction func response1(_ sender: Any) {
        respuestasUsuario.append(true)
        siguientePregunta()
    }
    @IBAction func response2(_ sender: Any) {
        respuestasUsuario.append(false)
        siguientePregunta()
    }
    
    func siguientePregunta() {
        preguntas.removeFirst()
        
        if preguntas.isEmpty {
            mostrarResultado()
        } else {
            mostrarPregunta()
        }
        totalQuestions += 1
        page_n.text = "\(totalQuestions)/5"    }
    
    func mostrarResultado() {
        let sumaRespuestas = respuestasUsuario.reduce(0, { $0 + ($1 ? 1 : 0) })
        // Muestra la imagen
        imagen.isHidden = false
        questions.isHidden = true
        Descripcion_text.isHidden = false
        switch sumaRespuestas {
        case 4:
            title1.text = "¡Eres \(personajes[0].nombre)!"
            Descripcion_text.text = "Descripción: \(personajes[0].descripcion)"
            imagen.image = UIImage(named: personajes[0].imagen)
        case 5:
            title1.text = "¡Eres \(personajes[1].nombre)!"
            Descripcion_text.text = "Descripción: \(personajes[1].descripcion)"
            imagen.image = UIImage(named: personajes[1].imagen)
        case 3:
            title1.text = "¡Eres \(personajes[2].nombre)!"
            Descripcion_text.text = "Descripción: \(personajes[2].descripcion)"
            imagen.image = UIImage(named: personajes[2].imagen)
        case 2:
            title1.text = "¡Eres \(personajes[3].nombre)!"
            Descripcion_text.text = "Descripción: \(personajes[3].descripcion)"
            imagen.image = UIImage(named: personajes[3].imagen)
        case 0:
            title1.text = "¡Eres \(personajes[4].nombre)!"
            Descripcion_text.text = "Descripción: \(personajes[4].descripcion)"
            imagen.image = UIImage(named: personajes[4].imagen)
        default:
            title1.text = "No se pudo determinar el personaje."
            Descripcion_text.text = ""
            imagen.image = UIImage(named: "oops.jpg")
        }
        page_n.isHidden = true
        //desactivar visibilidad de botones
        response1.isHidden = true
        response2.isHidden = true
    }
    
    @IBAction func again(_ sender: UIButton) {
        preguntas = ["¿Es humano?", "¿Tiene sombrero?", "¿Es mujer?", "¿Habla?", "¿Lleva arma de fuego?"]
        respuestasUsuario = []
        title1.text = "¿Qué personaje eres?"
        Instructions.text = "Responde a las 5 preguntas"
                
        // Desactiva la visibilidad de la imagen al volver a jugar
        imagen.isHidden = true
                
        // Activa la visibilidad de los botones response1 y response2 al volver a jugar
        response1.isHidden = false
        response2.isHidden = false
        Descripcion_text.isHidden = true
        questions.isHidden = false
        totalQuestions = 1
        page_n.text = "1/5"
        page_n.isHidden = false
        mostrarPregunta()
    }
    

}
