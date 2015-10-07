users = CT_LoadModel 'users'

exports.home = (req,res)->

	usersData = false
	users.getUsers (u)-> usersData = u
	CT_Await -> usersData is false

	res.render config.static + '/main/index.jade',{
		users:usersData
	}