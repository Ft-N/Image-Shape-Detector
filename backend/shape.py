def get_facts(env):
	facts = []
	for fact in env.facts():
		facts.append(str(fact))
	return facts

def get_rules(env):
	rules = []
	for rule in env.rules():
		rules.append(str(rule))
	return rules

def get_activations(env):
	activations = []
	for activation in env.activations():
		activations.append(str(activation))
	return activations

def insert_angle(env, angles):
	for x in range(0,len(angles)):
		string = "(sudut-" + str(x+1) + " " + str(angles[x]) + ")"
		fact = env.assert_string(string)
	if len(angles) == 3:
		env.assert_string("(segitiga yes)")
	elif len(angles) == 4:
		env.assert_string("(segiempat yes)")
	elif len(angles) == 5:
		env.assert_string("(segilima yes)")
	elif len(angles) == 6:
		env.assert_string("(segienam yes)")