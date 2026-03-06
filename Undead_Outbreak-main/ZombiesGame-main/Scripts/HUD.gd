extends CanvasLayer


func _ready():
	Global.hud=self
	Global.visuals_folder=$"../VisualEffects"
	Global.player_inv=$Inventory
	Global.Control_Hud=$Hud
	#Global.player_inv.add_item(Data.shotgun_item,1)
	Global.antidote_syringe_display=$Hud/Nr_of_Antidote/Sprite2D
	
	
	#Global.player_inv.add_item(Data.uzzi_item,1)
	
	#Global.player_inv.add_item(Data.sniper_item,1)
	#Global.player_inv.add_item(Data.minigun_item,1)
	#Global.player_inv.add_item(Data.shotgun_bullets,100)
	#Global.player_inv.add_item(Data.small_bullets,200)
	#Global.player_inv.add_item(Data.sniper_bullets,100)

@onready var inv_ref = $Inventory
@onready var fps_display = $Hud/Fps_Display
@onready var score = $Hud/Score
@onready var nr_antiode := $Hud/Nr_of_Antidote
func _process(delta):
	fps_display.text=str(int(Engine.get_frames_per_second()))
	if Input.is_action_just_pressed("inventory"):
		if inv_ref.visible:
			inv_ref.hide_inventory()
		else:
			inv_ref.show_inventory()
	if Input.is_action_just_pressed("ui_accept"):
		inv_ref.sorting_amounts()
	score.text='Score : '+str(Data.score)
	
	
	fps_display.visible = Global.show_fps
	
	nr_antiode.text=str(Global.antidote_parts_found)+'/4 parts of antidote found'
	
	update_hud()


@onready var h_bar = $Hud/health_bar
@onready var stam_bar = $Hud/stamina_bar
@onready var rel_percentage = $Hud/Loaded_Bullets/reload_percentage
@onready var hunger_bar = $Hud/hunger_bar
@onready var thirst_bar = $Hud/thirst_bar
@onready var loaded_bullets = $Hud/Loaded_Bullets

func update_hud()->void:
	loaded_bullets.text=str(Data.nr_of_loaded_bullets)+'/'+ str(Data.mag_size)
	rel_percentage.value=Data.reload_percentage
	stam_bar.value=Data.stamina-2
	h_bar.value=Data.health
	hunger_bar.value=Data.hunger
	thirst_bar.value=Data.thirst
