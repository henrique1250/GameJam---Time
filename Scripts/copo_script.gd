extends Area3D

@export var minigame_ui: CanvasLayer

var pode_interagir: bool = false
var npc_dono: NpcGeneric = null

func _ready() -> void:
	input_event.connect(_on_input_event)
	
	npc_dono = _encontrar_npc_dono()
	
	EventBus.npc_iniciou_interacao.connect(_on_npc_iniciou_interacao)
	EventBus.npc_finalizou_interacao.connect(_on_npc_finalizou_interacao)

func _encontrar_npc_dono() -> NpcGeneric:
	var atual: Node = self
	while atual:
		if atual is NpcGeneric:
			return atual
		atual = atual.get_parent()
	push_warning("AreaCopo não encontrou um NpcGeneric como ancestral!")
	return null

func _on_npc_iniciou_interacao(npc: NpcGeneric) -> void:
	if npc == npc_dono:
		pode_interagir = true

func _on_npc_finalizou_interacao(npc: NpcGeneric) -> void:
	if npc == npc_dono:
		pode_interagir = false
		if minigame_ui:
			minigame_ui.visible = false

func _on_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if not pode_interagir:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		abrir_minigame()
		
		

func abrir_minigame() -> void:
	if minigame_ui:
		pode_interagir = false
		minigame_ui.visible = true
		if minigame_ui.has_method("ativar_minigame"):
			minigame_ui.ativar_minigame()
		print("Minigame do copo iniciado!")
