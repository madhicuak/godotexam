extends CanvasLayer

var contador = 0
func _ready():
	for moneda in get_tree().get_first_node_in_group("monedas"):
		moneda.connect("moneditas" , callable(self, "handlemoneditas"))
		$Contador.text = str (contador)

func handlmoneitas():
	print("monedas")
	contador +=1 
	
