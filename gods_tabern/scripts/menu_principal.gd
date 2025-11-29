extends Node2D

func _ready() -> void:
	$MainMusic.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/primer_nivel.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_opciones.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
