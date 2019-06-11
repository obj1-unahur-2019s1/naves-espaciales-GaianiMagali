class NaveEspacial {

	var velocidad = 0
	var direccion = 0
	var combustible = 0

	method velocidad(cuanto) {
		velocidad = cuanto
	}

	method acelerar(cuanto) {
		velocidad = (velocidad + cuanto).min(100000)
	}

	method desacelerar(cuanto) {
		velocidad -= cuanto
	}

	method irHaciaElSol() {
		direccion = 10
	}

	method escaparDelSol() {
		direccion = -10
	}

	method ponerseParaleloAlSol() {
		direccion = 0
	}

	method acercarseUnPocoAlSol() {
		direccion += 1
	}

	method alejarseUnPocoDelSol() {
		direccion -= 1
	}
	
	method direccion(){
		return direccion
	}

	method cagarCombustible(cantidad) {
		combustible += cantidad
	}

	method descargarCombustible(cantidad) {
		combustible -= cantidad
	}
	
	method combustible(){
		return combustible
	}
	
	method velocidad(){
		return velocidad
	}

	method prepararViaje() {
		self.cagarCombustible(30000)
		self.acelerar(5000)
	}

	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}

	method escapar()

	method avisar()

	method estaTranquila() {
		return combustible >= 4000 and velocidad <= 12000
	}

}

class NaveBaliza inherits NaveEspacial {

	var property color = "azul"

	override method prepararViaje() {
		super()
		self.color("verde")
		self.ponerseParaleloAlSol()
	}

	override method escapar() {
		self.irHaciaElSol()
	}

	override method avisar() {
		self.color("rojo")
	}

	override method estaTranquila() {
		return super() and color != "rojo"
	}

}

class NavePasajeros inherits NaveEspacial {

	var property cantPasajeros = 0
	var property racionesComida = 0
	var property racionesBebida = 0

	method agregarComida(cuanto) {
		racionesComida += cuanto
	}

	method descargarComida(cuanto) {
		racionesComida -= cuanto
	}

	method agregarBebida(cuanto) {
		racionesBebida += cuanto
	}

	method descargarBebida(cuanto) {
		racionesBebida -= cuanto
	}

	override method prepararViaje() {
		super()
		self.agregarComida(4 * cantPasajeros)
		self.agregarBebida(6 * cantPasajeros)
		self.acercarseUnPocoAlSol()
	}

	override method escapar() {
		self.velocidad(velocidad * 2)
	}

	override method avisar() {
		self.descargarComida(racionesComida - 1)
		self.descargarBebida(racionesBebida - 2)
	}

}

class NaveCombate inherits NaveEspacial {

	var estaInvisible = false
	var misilesDesplegados = false
	var mensajesEmitidos = []

	method ponerseVisible() {
		estaInvisible = false
	}

	method ponerseInvisible() {
		estaInvisible = true
	}

	method estaInvisible() {
		return estaInvisible
	}

	method desplegarMisiles() {
		misilesDesplegados = true
	}

	method replegarMisiles() {
		misilesDesplegados = false
	}

	method misilesDesplegados() {
		return misilesDesplegados
	}

	method emitirMensaje(mensaje){
		mensajesEmitidos.add(mensaje)
	}

	method mensajesEmitidos(){
		return mensajesEmitidos
	}

	method primerMensajeEmitido(){
		return mensajesEmitidos.first()
	}

	method ultimoMensajeEmitido(){
		return mensajesEmitidos.last()
	}

	method esEscueta(){
		return not mensajesEmitidos.any({ mensaje => mensaje.size() > 30})
	}
   // return mensajesEmitidos.all{m => m.size() <= 30 }
   
	method emitioMensaje(mensaje) {
		return mensajesEmitidos.contains(mensaje)
	}

	// mensajesEmitidos.any{ m => m == mensaje}
	
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}

	override method escapar() {
		// Lo hace dos veces
		2.times{ i => self.acercarseUnPocoAlSol()}
	}

	override method avisar() {
		self.emitirMensaje("Amenaza recibida")
	}

	override method estaTranquila() {
		return super() and not self.desplegarMisiles()
	}

}

//variante de NavePasajeros
class NaveHospital inherits NavePasajeros {

	var quirofanoPreparado = true

	method noQuirofanoPreparado() {
		quirofanoPreparado = false
	}

	method QuirofanoPreparado() {
		quirofanoPreparado = true
	}
    
    method elQuirofanoEstaPreparado(){
    	return quirofanoPreparado 
    }
	override method recibirAmenaza() {
		super()
		self.QuirofanoPreparado()
	}

	override method estaTranquila() = super() and not quirofanoPreparado

}

//Variante de NaveCombate
class NaveSigilosa inherits NaveCombate {

	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}

	override method estaTranquila() = super() and not self.ponerseVisible()

}



