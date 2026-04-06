extends Resource
class_name TowerData

@export var tower_name: String = "Cannon Tower"
@export var cost: int = 1
@export var damage: int = 1
@export var attack_rate: float = 1.0
@export var range_radius: float = 150.0

@export var tower_texture: Texture2D
@export var projectile_scene: PackedScene
@export var shoot_audio: String

@export var targeting_mode: String = "first"
@export var attack_type: String = "projectile"
@export var projectile_count: int = 1
@export var spread_angle: float = 0.0
