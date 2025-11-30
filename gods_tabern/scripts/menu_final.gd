extends Node2D


func _ready():
	$DeathMusic.play()


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/primer_nivel.tscn")


func _on_menu_main_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
