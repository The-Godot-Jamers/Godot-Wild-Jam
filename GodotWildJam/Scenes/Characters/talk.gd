extends Area2D

var can_talk = true
export var talk_value = 5

func talk(who):
	if can_talk:
		$AnimationPlayer.play("talk")
		can_talk = false
		var influenced = get_overlapping_bodies()
		for i in influenced:
			if i != who:
				i.care_about_issue += talk_value
				i.care_about_issue = clamp(i.care_about_issue,0,100)
				print(i)
				print(i.care_about_issue)

func _on_AnimationPlayer_animation_finished(anim_name):
	can_talk = true
