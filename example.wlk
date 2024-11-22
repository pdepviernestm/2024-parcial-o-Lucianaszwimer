class Emocion {
  var property intensidad
  var property contEventos=0
  
  method modificarIntensidad(nuevaIntensidad) {
    intensidad = nuevaIntensidad
  }
  method intensidadElevada() = intensidad > 80 

  method puedeLiberarse(){}
  method liberarse(evento){}
}

class Persona{
  var property anios 
  var property emociones=[]

  method esAdolescente() = anios >= 12 && anios < 19

  method agregarEmocion(emocion) {
    emociones.add(emocion)
  }

  method liberarEmociones(evento){
    emociones.forEach({emocion => emocion.liberarse(evento)})
  }

  method estaPorExplotar() {
    return emociones.all({e => e.puedeLiberarse()})
  }
}
class Evento {
  var property impacto
  var property descripcion
  method impactoEvento(num){
    impacto = num.abs()
  }

}
class Furia inherits Emocion{
  const property palabrotas = []

  method aprenderPalabrota(palabrota) {
    palabrotas.add(palabrota)
  }
  method olvidarPalabrota() {
    palabrotas.remove(palabrotas.first())  
 }
  
  method palabrotaGrande()=palabrotas.any({palabrota => palabrota.length() > 7})
  
  override method puedeLiberarse()= self.intensidadElevada() && self.palabrotaGrande()
 override method liberarse(evento){
    if (self.puedeLiberarse()) {
      self.modificarIntensidad(intensidad - evento.impacto()) 
      self.olvidarPalabrota()
    }
  }
}

class Alegria inherits Emocion{
  override method puedeLiberarse()=self.intensidadElevada() && contEventos % 2 == 0
  override method liberarse(evento){
    if (self.puedeLiberarse()) { 
      self.modificarIntensidad(intensidad - evento.impacto()) 
    }
  }

  override method modificarIntensidad(num){
    if (num < 0) {
      intensidad = num.abs()
    } else {
      intensidad = num
    }
  }
}

class Tristeza inherits Emocion{
  var property causa = "melancolia" 
  override method modificarIntensidad(num){}

  method modificarCausa(motivo){
    causa = motivo
  }

  override method puedeLiberarse()= self.intensidadElevada() && causa != "melancolia"
  override method liberarse(evento){
    if (self.puedeLiberarse()) {
      self.modificarCausa(evento.descripcion())
      self.modificarIntensidad(intensidad - evento.impacto()) 
    }
  }
}

class Desagrado inherits Emocion{
  override method puedeLiberarse()=self.intensidadElevada() && contEventos > intensidad
  override method liberarse(evento){
    if (self.puedeLiberarse()) {
      self.modificarIntensidad(intensidad - evento.impacto()) 
    }
  }
}
class Temor inherits Emocion{
  override method puedeLiberarse()=self.intensidadElevada() && contEventos > intensidad
  override method liberarse(evento){
    if (self.puedeLiberarse()) {
      self.modificarIntensidad(intensidad - evento.impacto()) 
    }
  }
}

 class Ansiedad inherits Emocion{
  var property causa = "parciales" 
  var property consecuencias = ["felicidad", "paz", "libre de estres"]
  override method modificarIntensidad(num){}
  override method puedeLiberarse()= self.intensidadElevada() && causa == "parciales" //(vivo con ansiedad xd)
  override method liberarse(evento){
    if (self.puedeLiberarse()) {
      self.modificarIntensidad(intensidad - evento.impacto())
      consecuencias.remove(0) //la ansiedad como consecuencia te saca cosas lindas
    }
  }
 }
 /*Aparece una nueva emoción que toda persona puede tener: ansiedad. Inventar una implementación que tenga algo diferente a las otras
 emociones, utilizando el concepto de polimorfismo y herencia. Explica para qué fueron útiles dichos conceptos. */

 /*
 El polimorfismo y la herencia practicamente estan siendo utilizados en el 90% del codigo. 
El polimorfimos es cuando una misma funcion, aplicada en diferentes clases, tiene un mismo resultado pero el "como llego a ese resultado"
de cada uno es diferente. Es decir, que por ejemplo la funcion puedeLiberarse() dependiendo la emocion cambia la manera de calcular si puede ser liberado o no
pero el resultado que da tanto la funcion en Alegria como en Furia es el mismo (true o false). El ejemplo que me gusto acerca del polimorfismo es
el de youtube con un toca discos, donde los dos la fin y a cabo reproducen musica pero lo hacen de distinta manera, bueno aca lo mismo.
Y la herencia es hacer como una "subclase" donde hereda los atributos de la clase suprema. En este caso, la clase suprema seria Emociones y las clases de
Alegria, Furia, Tristeza, Desagrado, Temor y Ansiedad serian las subclases porque estan heredando sus atributos.
*/
