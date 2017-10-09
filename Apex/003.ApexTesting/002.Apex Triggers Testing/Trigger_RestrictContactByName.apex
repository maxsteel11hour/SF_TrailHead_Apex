trigger RestrictContactByName on Contact (before insert, before update) {
//source - https://github.com/developerforce/trailhead-code-samples/blob/master/RestrictContactByName.cls	
	//check contacts prior to insert or update for invalid data
	For (Contact c : Trigger.New) {
		if(c.LastName == 'INVALIDNAME') {	//invalidname is invalid
			c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
		}

	}



}