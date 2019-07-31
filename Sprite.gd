extends Sprite

enum Bone {
    HEAD = 5,
    TORSO = 0,
    HIPS = 1,
    RIGHT_HAND = 26,
    RIGHT_FOOT = 46,
    RIGHT_SHOULDER = 23,
    RIGHT_FOREARM = 25,
    RIGHT_UPPERARM = 24,
    LEFT_HAND = 10,
    LEFT_FOOT = 41,
    LEFT_SHOULDER = 7,
    LEFT_FOREARM = 9,
    LEFT_UPPERARM = 8
}

export var IS_DEBUG_SKELETON_OVERLAY: bool = false
const LEFT_ARM = [Bone.LEFT_SHOULDER, Bone.LEFT_UPPERARM, Bone.LEFT_FOREARM, Bone.LEFT_HAND]
const RIGHT_ARM = [Bone.RIGHT_SHOULDER, Bone.RIGHT_UPPERARM, Bone.RIGHT_FOREARM, Bone.RIGHT_HAND]
const SPINE = [Bone.HEAD, Bone.TORSO, Bone.HIPS, Bone.LEFT_FOOT]

onready var CharacterViewport: Viewport = get_node('Viewport')
onready var CharacterAnimation: AnimationPlayer = CharacterViewport.get_node('Brute/AnimationPlayer')
onready var CharacterSkeleton: Skeleton = CharacterViewport.get_node('Brute/Armature/Skeleton')
onready var CharacterCamera: Camera = CharacterViewport.get_node('Camera')
onready var CharacterBones: Dictionary = {
    Bone.HEAD: CharacterSkeleton.get_node("HeadAttachment"),
    Bone.HIPS: CharacterSkeleton.get_node('HipsAttachment'),
    Bone.LEFT_FOOT: CharacterSkeleton.get_node('LeftFootAttachment'),
    Bone.RIGHT_FOOT: CharacterSkeleton.get_node('RightFootAttachment'),
    Bone.RIGHT_HAND: CharacterSkeleton.get_node('RightHandtAttachment'),
    Bone.LEFT_HAND: CharacterSkeleton.get_node('LeftHandAttachment')
}

onready var bone_positions: Array = []

func _ready():
    CharacterAnimation.play('Running')

func _process(delta):
    update()
    position.x += 1

func _draw():
    if (IS_DEBUG_SKELETON_OVERLAY):
        debug_skeleton_overlay()
        
func debug_skeleton_overlay():
    overlay_polyline(CharacterSkeleton.get_bone_count())
      
func overlay_circle(bone_id, color: Color = Color.red):
    var point = get_3Dbone_2Dcoord(bone_id)
    draw_circle(point, 3, color)
    
func overlay_polyline(bone_ids, color: Color = Color.red):
    var bone_poses = []
    for bone_id in bone_ids:
        var point = get_3Dbone_2Dcoord(bone_id)
        bone_poses.push_back(point)
    draw_polyline(bone_poses, color, 2)
    
func get_3Dbone_2Dcoord(bone_id: int):
    var global_origin = CharacterSkeleton.to_global(CharacterSkeleton.get_bone_global_pose(bone_id).origin)
    return CharacterCamera.unproject_position(global_origin)

func move_node2D_to_bone(node, bone):
#    print(node.to_local(node.position))
    node.position = get_3Dbone_2Dcoord(bone)
    
    