extends Resource
class_name Card
@export var title:String
@export var texture:Texture2D
#how expensive is this to buy from the shop
@export var price:int = 0
#how many enemies must this card target
@export var maxTargets:int = 0
#number of other cards that must be discarded to play this card
@export var discardCost:int = 0
@export_group("Card Effects")
@export var drawActions:Array[Action]
@export var playActions:Array[Action]
@export var discardActions:Array[Action]
#applied tags are tags that resolve their effects when they are applied
@export_group("Card Tags")
@export var appliedTags:Array[Tag]
@export var drawTags:Array[Tag]
@export var playTags:Array[Tag]
@export var discardTags:Array[Tag]
@export_group("")
@export var text:String

#array of enemies the card is targetting
var targets:Array[Enemy]

#when drawn execute all draw effects
func drawEffect():
	for i:Tag in drawTags:
		i.resolve()
	for i:Action in drawActions:
		i.resolve(targets)

#when played execute all play effects
func playEffect():
	for i:Tag in drawTags:
		i.resolve()
	for i:Action in playActions:
		i.resolve(targets)

#when discarded execute all discard effects
func discardEffect():
	for i:Tag in drawTags:
		i.resolve()
	for i:Action in discardActions:
		i.resolve(targets)

#special case for tags who's functions only effect the card when they're added, ie halving a cards damage.
func applyTag(tag:Tag):
	tag.resolve()
	appliedTags.append(tag)
	
func compileCard():
	pass
