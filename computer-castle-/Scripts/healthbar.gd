extends Node2D

@onready var healthbar=  %AnimatedSprite2D
var displayed_frame: float = 0
var tween: Tween
var sounds = {
	"damage": preload("res://Audio/Sound_effects/Map_SFX/Damage_Warning.mp3")
}

func _ready() -> void:
	ResourceManager.reset_health()
	ResourceManager.connect('health_changed', on_health_changed)
	on_health_changed(ResourceManager.health)
	await get_tree().create_timer(5.0).timeout

func playsound(name):
	var player = AudioStreamPlayer.new()
	player.stream = sounds[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

func on_health_changed(new_health: int):
	playsound("damage")
	var max_frames = healthbar.sprite_frames.get_frame_count("Damage") - 1
	var percent = float(new_health) / ResourceManager.max_health
	var target_frame = percent * max_frames

	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(self, "displayed_frame", target_frame, 0.3)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)


func _process(_delta):
	healthbar.frame = int(displayed_frame)
