extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# verifica se está no chão (função nativa is_on_floor), se não está no chão aplica gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# aplica força para cima para pular
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# identifica direção que o jogador está apertando no teclado
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# verifica para qual lado o sprite tem que estar virado com base na direção
	# a direção pode assumir -1, 0 ou 1 
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction >0 : 
		animated_sprite.flip_h = false
	
	# aplica a animação correta de acordo com a ação sendo executada
	# jump, idle ou run
	if not is_on_floor():
		animated_sprite.play("jump")
	elif velocity.x !=0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
	# aplica movimento
	move_and_slide()
