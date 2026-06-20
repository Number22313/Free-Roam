extends Control

const HOVER_SCALE = Vector2(1.07, 1.07)
const NORMAL_SCALE = Vector2(1.0, 1.0)
const ANIMATION_SPEED = 0.1

@onready var Options_Menu = $Options_Menu

var play_original_pos: Vector2
var options_original_pos: Vector2
var quit_original_pos: Vector2
var is_hovering: bool = false
var play_button: bool = false
var options_button: bool = false
var quit_button: bool = false

func _ready():
	play_original_pos = $Play.position
	options_original_pos = $Options.position
	quit_original_pos = $Quit.position
	
	$Play.pivot_offset = $Play.size / 2
	$Options.pivot_offset = $Options.size / 2
	$Quit.pivot_offset = $Quit.size / 2
	
	if Options_Menu:
		Options_Menu.back_pressed.connect(_on_options_closed_at_main_menu)
	

func _on_play_mouse_entered():
	animate_button_scale($Play, HOVER_SCALE)
	play_button = true
	is_hovering = true

func _on_play_mouse_exited():
	animate_button_scale($Play, NORMAL_SCALE)
	is_hovering = false
	play_button = false
	$Play.position = play_original_pos

func _on_options_mouse_entered():
	animate_button_scale($Options, HOVER_SCALE)
	is_hovering = true
	options_button = true

func _on_options_mouse_exited():
	animate_button_scale($Options, NORMAL_SCALE)
	is_hovering = false
	options_button = false
	$Options.position = options_original_pos

func _on_quit_mouse_entered():
	animate_button_scale($Quit, HOVER_SCALE)
	is_hovering = true
	quit_button = true

func _on_quit_mouse_exited():
	animate_button_scale($Quit, NORMAL_SCALE)
	is_hovering = false
	quit_button = false
	$Quit.position = quit_original_pos

func animate_button_scale(button: Button, target_scale: Vector2):
	var tween = create_tween().set_parallel(false)
	tween.tween_property(button, "scale", target_scale, ANIMATION_SPEED)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)

func _process(_delta):
	var random_offset = Vector2(randf_range(-1.5,1.5), randf_range(-1.5,1.5))
	if play_button == true:
		$Play.position = play_original_pos + random_offset
	if options_button == true:
		$Options.position = options_original_pos + random_offset
	if quit_button == true:
		$Quit.position = quit_original_pos + random_offset


func _on_options_pressed() -> void:
	$Title.visible = false
	$Play.visible = false
	$Options.visible = false
	$Quit.visible = false
	
	Options_Menu.visible = true
	options_button = false

func _on_options_closed_at_main_menu() -> void:
	$Title.visible = true
	$Play.visible = true
	$Options.visible = true
	$Quit.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_play_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")
