extends CanvasLayer

@export var velocidade_medidor := 300
@export var largura_medidor := 200
@export var largura_alvo := 50

@export var contador: Label

var medidor_y := 0
var direcao := 1
var minigame_ativado := false

@onready var alvo = $Alvo
@onready var medidor = $Medidor
@onready var resultado_label = $ResultadoLabel
@onready var painel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	painel.visible = false
	resultado_label.visible = false
	alvo.visible = false
	medidor.visible = false
	
	var tela = get_viewport().size
	
	#Posição do Painel
	var painel_largura = 400
	var painel_altura = 1000
	painel.size = Vector2(painel_largura, painel_altura)
	painel.position = Vector2((tela.x - painel_largura)/2, (tela.y - painel_altura)/2) 
	
	#Posição da label do final do game
	var label_largura = 300
	var label_altura = 60
	resultado_label.size = Vector2(label_largura, label_altura)
	resultado_label.position = Vector2((tela.x - label_largura)/2, (tela.y - label_altura)/2)
	resultado_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	resultado_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	resultado_label.add_theme_font_size_override("font_size", 32)
	
	#Posição do alvo
	alvo.position.x = (get_viewport().size.x - largura_alvo)/2
	alvo.size = Vector2(largura_alvo, 20)
	alvo.position.y = (get_viewport().size.y / 2) - 10
	
	#Posição do medidor
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
		
func _input(event: InputEvent):
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
	
	ContadorGlobal.incrementar(5)
	print("Acertou")
	
	await get_tree().create_timer(1.0).timeout
	
	fechar_minigame()
	
func falha():
	minigame_ativado = false
	resultado_label.text = "FALHOU!"
	resultado_label.modulate = Color.RED
	resultado_label.visible = true
	print("ERROU!")
	
	await get_tree().create_timer(1.0).timeout
	
	fechar_minigame()
	
func ativar_minigame():
	minigame_ativado = true
	alvo.visible = true
	medidor.visible = true
	painel.visible = true
	resultado_label.visible = false
	medidor.position.y = 20
	direcao = 1
	print("MINIGAME ATIVADO")
	
func fechar_minigame():
	minigame_ativado = false
	painel.visible = false
	alvo.visible = false
	medidor.visible = false
	resultado_label.visible = false
	print("Jogo Fechado")
