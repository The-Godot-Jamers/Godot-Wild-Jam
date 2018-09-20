extends Area2D

var can_act = true
export var talk_value = 1
export var yell_value = 2
var yell_icon = preload("res://Art/Characters and Animations/speech_bubbles/speech yell.png")
var question_icon = preload("res://Art/Characters and Animations/speech_bubbles/speech question.png")


func talk(who):
	if can_act:
		$Sprite.modulate = Color(1,1,1,1)
		$Sprite.texture = question_icon
		$AnimationPlayer.play("talk")
		can_act = false
		var influenced = get_overlapping_bodies()
		who.police_interest += talk_value * 3
		for i in influenced:
			if i != who:
				if not i.is_in_group("POLICE"):
					i.care_about_issue += talk_value
					i.care_about_issue = clamp(i.care_about_issue,0,100)
					#Globals.conga_line.append(i)
					i.conga(who)

func yell(who):
	if can_act:
		$Sprite.modulate = Color(0.7,0.15,0.15,1)
		$Sprite.texture = yell_icon
		$AnimationPlayer.play("yell")
		can_act = false
		var influenced = get_overlapping_bodies()
		who.police_interest += yell_value * 3
		for i in influenced:
			if i != who:
				if not i.is_in_group("POLICE"):
					if i.care_about_issue > 70:
						i.hot_headedness += yell_value
						i.hot_headedness = clamp(i.hot_headedness,0,100)
					else:
						i.care_about_issue -= yell_value
						i.care_about_issue = clamp(i.care_about_issue,0,100)
					#Globals.conga_line.append(i)
					i.conga(who)


func _on_AnimationPlayer_animation_finished(anim_name):
	can_act = true
	
