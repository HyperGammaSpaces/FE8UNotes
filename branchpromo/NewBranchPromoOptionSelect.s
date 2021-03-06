.thumb

@hooks at CDB78 with jumpToHack

@ villager promotion table:
@ 05 0F 19 25 4E //males 06 1A 26 48 4A //females

mov r2, r4
add r2, #0x3B               @class to promote to gets stored here
cmp r1, #0x3E				@first class to receive extra branches
beq VillagerF
cmp r1, #0x3D				@second class to receive extra branches
beq VillagerM
b EndPromoSelect

VillagerF:
	ldr r3, =0x004A4826 	@class list - 3 classes + null terminator
	b VillagerPromo			@repeat for however many classes need extra branches

VillagerM:
	ldr r3, =0x004E2519 	@class list
	
VillagerPromo:
	cmp r0, #0x2
	bne VillagerPromo2
	lsl r3, r3, #0x18
	lsr r1, r3, #0x18 		@isolate the last byte
	
VillagerPromo2:
	cmp r0, #0x3
	bne VillagerPromo3
	lsr r3, r3, #0x8		@shift classlist to second entry
	lsl r3, r3, #0x18
	lsr r1, r3, #0x18 		@isolate the last byte
	
VillagerPromo3:
	cmp r0, #0x4
	bne Fallback			@if an undefined option is selected just default to current class
	lsr r3, r3, #0x10		@shift classlist to third entry
	lsl r3, r3, #0x18
	lsr r1, r3, #0x18 		@isolate the last byte
	
Fallback:
	strb r1, [r2, #0x0]

EndPromoSelect:
	ldr r0, =0x80CDBAF
	bx r0
