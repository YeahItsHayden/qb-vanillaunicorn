# QBCore Vanilla Unicorn Job - In Development
This is a Vanilla Unicorn Job designed exclusively for QBCore at the request of the community

## Requirements
- [QBCore](https://github.com/qbcore-framework/qb-core)
- [zf_context](https://github.com/zf-development/zf_context)

## Showcase
Coming Soon

## Features
- Completely Translatable
- Fully commented
- Almost everything is configureable

## Setup
1) Add the following into your qb-core > shared.lua, under the Items section:
```
-- Vanilla Unicorn
	['vodka'] 					 = {['name'] = 'vodka', 			  	  		['label'] = 'Vodka', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'vodka.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ever been so drunk you start speaking Russian? This will do the trick'},
	['whiskey'] 					 = {['name'] = 'whiskey', 			  	  		['label'] = 'Whiskey', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'whiskey.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'The fine mans drink, not something most people can afford'},
	['rum'] 					 = {['name'] = 'rum', 			  	  		['label'] = 'Rum', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'whiskey.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'A beverage that seems to make you think you can fight anybody'},
	['cocacola'] 					 = {['name'] = 'cocacola', 			  	  		['label'] = 'CocaCola', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'cocacola.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Probably have some issues with your blood suger level'},
```
2) Once added, add the job into your qb-core > shared.lua like so:
```
['vu'] = {
	label = 'Vanilla Unicorn',
	defaultDuty = true,
	grades = {
		['0'] = {
			name = 'Trainee',
			payment = 50
		},
		['1'] = {
			name = 'Employee',
			payment = 75
		},
		['2'] = {
			name = 'Management',
			isboss = true,
			payment = 100
		},
	},
},
```

3) If you've never edited qb-bossmenu before, or have never touched it in general, please install my fork of it:

4) [qb-bossmenu](https://github.com/YeahItsHayden/qb-bossmenu) This fork has all of the VU stuff added by default for you.

5) If you have edited qb-bossmenu before, follow these steps: <br>
		- go into accounts.json, add another account labelled "vu":0, it should then look something like so:
			```{"realestate":0,"ambulance":10,"police":1000000,"taxi":0,"cardealer":0,"mechanic":0,"vu":0}```
		- Once completed, go to your config.lua and add this:
			['vu'] = vector3(93.84, -1291.87, 29.27)
		- Finally, within client.lua on line 170 > where it says "if #(pos - v) < 2.0" add the following:
			```and not Config.Jobs['vu']``` so it should look like: 	
				```if #(pos - v) < 2.0 and not Config.Jobs['vu'] then```

4) That's pretty much it, enjoy utilising the VU!

