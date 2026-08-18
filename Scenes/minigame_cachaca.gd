extends CanvasLayer

@export var velocidade_medidor := 300
@export var largura_medidor := 200
@export var largura_alvo := 50

var medidor_y := 0
var direcao := 1
var minigame_ativado := false

@onready var alvo = $Alvo
@onready var medidor = $Medidor
@onready var resultado_label = $ResultadoLabel
@onready var painel = $Painel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	painel.visible = false
	resultado_label.visible = false
	
	alvo.position.x = (get_viewport().size.x - largura_alvo)/2
	alvo.size = Vector2(largura_alvo, 20)
	alvo.position.y = (get_viewport().size.y / 2) - 10
	
	medidor.size = Vector2(largura_medidor, 15)
	medidor.position.x = (get_viewport().size.x - largura_medidor) / 2
	medidor.position.y = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not minigame_ativado:
		return
	
	medidor_y += velocidade_medidor * delta * direcao
	medidor.position.y = medidor_y
	
	if medidor_y <= 20:
		direcao = 1
	elif medidor_y >= get_viewport().size.y - 40:
		direcao = -1
		
func _init(event):
	if not minigame_ativado:
		return
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		verificar_timing()
		
func verificar_timing():
	var centro = alvo.position.y + (alvo.size.y/2)
	var centro_medidor = medidor.position.y + (medidor.size.y/2)
	var distancia = abs(centro_medidor - centro)
	
	var tolerancia := 30
	
	if distancia <= tolerancia:
		sucesso()
	else:
		falha()

func sucesso():
	minigame_ativado = false
	resultado_label.text = "ACERTOU!"
	resultado_label.modulate = Color.GREEN
	resultado_label.visible = true
	print("Acertou")
	
func falha():
	minigame_ativado = false
	resultado_label.text = "FALHO!"
	resultado_label.modulate = Color.RED
	resultado_label.visible = true
	print("ERROU!")
	
func ativar_minigame():
	minigame_ativado = true
	painel.visible = true
	resultado_label.visible = false
	medidor.position.y = 20
	direcao = 1
	print("MINIGAME ATIVADO")
