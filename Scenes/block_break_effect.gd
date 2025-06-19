extends Node2D

func _ready():
	$BlockBreakEffect.play("destroy")

func _on_block_break_effect_animation_finished() -> void:
	queue_free()
