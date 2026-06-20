extends CanvasLayer

@onready var menu_buttons: VBoxContainer = $VBoxContainer
@onready var options_menu: Control = $"../Options_Menu"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	get_tree().paused = false
	if options_menu:
		options_menu.back_pressed.connect(_on_options_back_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if options_menu.visible:
			_on_options_back_pressed()
		else:
			toggle_pause()

func toggle_pause() -> void:
	self.visible = !self.visible
	get_tree().paused = self.visible
	
	if self.visible:
		menu_buttons.visible = true
		options_menu.visible = false

func _on_resume_pressed() -> void:
	toggle_pause()


func _on_options_pressed() -> void:
	menu_buttons.visible = false
	options_menu.visible = true

func _on_options_back_pressed() -> void:
	menu_buttons.visible = true
	options_menu.visible = false

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
