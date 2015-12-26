from GetEUser import getEffectiveUser

if getEffectiveUser() == 'root':
    pass
else:
    print "Error: Permission denied"
