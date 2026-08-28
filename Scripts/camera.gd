extends Camera3D

@export var tempo_transicao: float = 0.8
@export var marker_geral: Marker3D

@onready var SelecCamera: AudioStreamPlayer2D = $SelecCamera

var tween: Tween
var foco_atual: Marker3D = null

func _ready() -> void:
	if marker_geral:
		global_position = marker_geral.global_position
		global_rotation = marker_geral.global_rotation

func mover_para(alvo: Marker3D) -> void:
	if foco_atual == alvo:
		return

	foco_atual = alvo

	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(self, "global_position", alvo.global_position, tempo_transicao)
	tween.tween_property(self, "global_rotation", alvo.global_rotation, tempo_transicao)
	
	tocar_som_selecionar()
func voltar_para_geral() -> void:
	mover_para(marker_geral)
	
func tocar_som_selecionar() -> void:
	SelecCamera.play()
