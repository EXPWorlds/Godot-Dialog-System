extends Reference

var _story : Dictionary = {}
var _names : Dictionary = {}


func get_dids() -> Array:
	return self._story.keys()


func get_did_via_record_name(name : String) -> int:
	assert(self._names.has(name))
	return self._names[name]


func get_nid_from_slot(did : int, nid : int, slot : int) -> int:
	assert(self.has_did(did))
	assert(self.has_nid(did, nid))
	assert(self.has_slot(did, nid, slot))
	return self._story[did]["nodes"][nid]["links"][slot]


func get_nid_via_exact_text(did : int, query : String) -> int:
	assert(self.has_did(did))
	
	for nid in self._story[did]["nodes"].keys():
		if self._story[did]["nodes"][nid]["text"] == query:
			return nid
	return -1


func get_nids(did : int) -> Array:
	assert(self.has_did(did))
	return self._story[did]["nodes"].keys()


func get_slot_count(did : int, nid : int) -> int:
	assert(self.has_did(did))
	assert(self.has_nid(did, nid))
	return self._story[did]["nodes"][nid]["links"].size()


func get_slots(did : int, nid : int) -> Array:
	assert(self.has_did(did))
	assert(self.has_nid(did, nid))
	return self._story[did]["nodes"][nid]["links"].keys()


func get_text(did : int, nid : int) -> String:
	assert(self.has_did(did))
	assert(self.has_nid(did, nid))
	return self._story[did]["nodes"][nid]["text"]


func has_did(did : int) -> bool:
	return self._story.has(did)


func has_nid(did : int, nid : int) -> bool:
	assert(self.has_did(did))
	return self._story[did]["nodes"].has(nid)


func has_record_name(name : String) -> bool:
	return self._names.has(name)


func has_slot(did: int, nid : int, slot : int) -> bool:
	assert(self.has_did(did))
	assert(self.has_nid(did, nid))
	return self._story[did]["nodes"][nid]["links"].has(slot)


func read(file):
	if not "TYPE" in file:
		print_debug("Story reader failed to open file: ", str(file.filename))
		return
	if not file.TYPE == "EXP_Baked_Story" or file.TYPE == "EXP_Story_editor":
		print_debug("Story reader failed to open file: ", str(file.filename))
		return
	
	self._story = file.story
	self._names = file.names
