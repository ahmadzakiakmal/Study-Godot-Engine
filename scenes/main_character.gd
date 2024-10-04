extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -900.0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if (velocity.x > 1 || velocity.x < -1):
		if sprite_2d.animation != "attack":
			sprite_2d.animation = "walking"
		sprite_2d.play()
	else:
		if sprite_2d.animation != "attack":
			sprite_2d.animation = "default"
		sprite_2d.play()
		
	if Input.is_action_just_pressed("attack"):
		sprite_2d.animation = "attack"
		sprite_2d.play()
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if sprite_2d.animation != "attack":
			sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)

	move_and_slide()

	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
		


func _on_tile_map_ready() -> void:
	pass # Replace with function body.


func _on_sprite_2d_animation_finished() -> void:
	print("animation_finished signal")
	if sprite_2d.animation == "attack":
		print(sprite_2d.animation)
		if velocity.x == 0:
			sprite_2d.animation = "default"
		else:
			sprite_2d.animation = "walking"
		print(sprite_2d.animation)
	else:
		return


#func _on_sprite_2d_animation_looped() -> void:
	#print_debug("animation_looped signal")
