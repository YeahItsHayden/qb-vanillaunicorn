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
Add the following into your qb-core > shared.lua, under the Items section:
```
	-- Vanilla Unicorn
	['vodka'] 					 = {['name'] = 'vodka', 			  	  		['label'] = 'Vodka', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'vodka.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ever been so drunk you start speaking Russian? This will do the trick'},
	['whiskey'] 					 = {['name'] = 'whiskey', 			  	  		['label'] = 'Whiskey', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'whiskey.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'The fine mans drink, not something most people can afford'},
	['rum'] 					 = {['name'] = 'rum', 			  	  		['label'] = 'Rum', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'whiskey.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'A beverage that seems to make you think you can fight anybody'},
	['cocacola'] 					 = {['name'] = 'cocacola', 			  	  		['label'] = 'Whiskey', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'whiskey.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Probably have some issues with your blood suger level'},
```
