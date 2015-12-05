users = CT_LoadModel 'users'

exports.home = (req,res)->

	users.getUsers (usersData)->
		res.render CT_Static + '/main/index.jade',{
			users:usersData
		}