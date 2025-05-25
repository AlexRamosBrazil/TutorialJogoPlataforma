extends Area2D


# função associada ao sinal de body_entered
# quando o jogador(body) entra ná área da moeda(entered) executa a função abaixo
func _on_body_entered(body: Node2D) -> void:
	print("+1 moeda")
	queue_free()
	
