extends CPUParticles2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Character =  get_node('../../2D3D-Sprite')
onready var offset = position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    Character.move_node2D_to_bone(self,Character.Bone.HEAD, Vector2(4, -4))    