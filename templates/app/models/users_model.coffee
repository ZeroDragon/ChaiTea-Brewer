exports.getUsers = (cb)->
	dummyData = [
		{username:'Zero',birthday:'1984-07-17'}
		{username:'Not Zero',birthday:'1984-07-17'}
		{username:'Totaly Not Zero',birthday:'1984-07-17'}
	]
	cb dummyData