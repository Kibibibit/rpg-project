@abstract
extends Resource
class_name IdentifiedResource

## The current instance id of this object.
## Note that these are not persisted between runs,
## and should only be used for runtime checks
var id: int:
	get:
		return get_instance_id()
