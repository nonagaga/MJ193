extends Resource
class_name CardDataClass
@export var title:String
@export var texture:Texture2D
#how expensive is this to buy from the shop
@export var price:int = 0
#how many enemies can this card target
@export var maxTargets:int = 0
#does the card target all enemies
@export var targetAll:bool
#does this card target random enemies
@export var targetRandom:bool
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
signal select_targets(maxTar:int,card:CardDataClass)
signal card_played(card:CardDataClass)
signal draw(amount:int)
signal force_discard(amount:int)
signal normal_discard(amount:int)
signal grave_to_deck(amount:int)
signal grave_to_hand(amount:int)
var selectingTargets:bool = false

@export var text:String
#array of enemies the card is targetting
var targets:Array[Enemy]

func die():
	pass

func setUpCard():
	for i in drawActions:
		i.card = self
	for i in playActions:
		i.card = self
	for i in discardActions:
		i.card = self
	compileCardText()
	print(text)

#when drawn execute all draw effects
func drawEffect():
	if targetRandom == true:
		for i in range(maxTargets):
			targets.append(Globals.gameManager.enemy_list.pick_random())
	for i:Tag in drawTags:
		await i.resolve()
	for i:Action in drawActions:
		await i.resolve(targets)

#when played execute all play effects
func playEffect():
	Globals.gameManager.discard(self)
	if targetRandom == true:
		for i in range(maxTargets):
			targets.append(Globals.gameManager.enemy_list.pick_random())
	for i:Tag in playTags:
		await i.resolve()
	for i:Action in playActions:
		await i.resolve(targets)

#when discarded execute all discard effects
func discardEffect():
	if targetRandom == true:
		for i in range(maxTargets):
			targets.append(Globals.gameManager.enemy_list.pick_random())
	for i:Tag in discardTags:
		await i.resolve()
	for i:Action in discardActions:
		await i.resolve(targets)

#special case for tags who's functions only effect the card when they're added, ie halving a cards damage.
func applyTag(tag:Tag):
	await tag.resolve()
	appliedTags.append(tag)

#updates  Text
func compileCardText():
	text = text%discardCost
	for i in drawActions:
		i.updateText()
		text += i.actualText
	for i in playActions:
		i.updateText()
		text += i.actualText
	for i in discardActions:
		i.updateText()
		text += i.actualText
	
func playCard():
	card_played.emit(self)
	playEffect()
	Globals.discard.append(self)
	Globals.hand.erase(self)
		
	Globals.gameManager.check_room_cleared()

func canPlayCard() -> Error:
	#check if the card has play actions to actually play
	if !playActions.is_empty():
		#check if the card requires you to discard cards before playing it
		if discardCost != 0:
			#check if you have enough cards to discard to play the card
			if Globals.hand.size() >= discardCost:
				#discard the cards
				for i in range(discardCost):
					force_discard.emit(discardCost)
			else:
				#add can't play card function here
				return FAILED
	
	return OK

func selectCard():
	if canPlayCard():
		doesCardTarget()

func doesCardTarget():
	if !targetAll && maxTargets >0:
		#tell the UI to select targets for this card
		select_targets.emit(maxTargets,self)
	else:
		playCard()
