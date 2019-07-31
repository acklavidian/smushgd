extends CPUParticles2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Character =  get_node('../../Sprite')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    Character.move_node2D_to_bone(self,Character.Bone.HEAD)
