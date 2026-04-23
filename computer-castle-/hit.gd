extends AnimatedSprite2D

func _ready():
	play("hit")
	await animation_finished
	queue_free()
