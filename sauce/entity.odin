package main

/*

This is a nice lil cosy spot for the backbone of the entity system.

Entity structure can vary greatly or subtly from game to game depending on the constraints.
So it doesn't really make sense to abstract this away into a package.
It adds too much friction.

*/

MAX_ENTITIES :: 2048 // increase this as needed.

import "base:runtime"
import "core:fmt"
import "core:log"
import "core:slice"

Entity_Handle :: struct {
	index: int,

	// I prefer assigning a unique ID to each entity, instead of going the generational
	// handle route. Makes trying to debug things a bit easier if we know for a fact
	// an entity cannot have the same ID as another one.
	id:    int,
}

zero_entity: Entity // #readonlytodo

get_all_ents :: proc() -> []Entity_Handle {
	return ctx.gs.scratch.all_entities
}

get_all_ents_y_sorted :: proc() -> []^Entity {
	entities: [dynamic]^Entity

	for &e in ctx.gs.entities[1:ctx.gs.entity_top_count + 1] {
		if e.kind == .nil {
			continue
		}

		append_elem(&entities, &e)
	}

	// TODO: maybe a for loop instead of lambda?
	slice.sort_by(entities[:], proc(a: ^Entity, b: ^Entity) -> bool {
		return a^.pos.y > b^.pos.y
	})

	return entities[:]
}

is_valid :: proc {
	entity_is_valid,
	entity_is_valid_ptr,
}
entity_is_valid :: proc(entity: Entity) -> bool {
	return entity.handle.id != 0
}
entity_is_valid_ptr :: proc(entity: ^Entity) -> bool {
	return entity != nil && entity_is_valid(entity^)
}

entity_init_core :: proc() {
	// make sure the zero entity has good defaults, so we don't crash on stuff like functions pointers
	entity_setup(&zero_entity, .nil)
}

entity_from_handle :: proc(handle: Entity_Handle) -> (entity: ^Entity, ok: bool) #optional_ok {
	if handle.index <= 0 || handle.index > ctx.gs.entity_top_count {
		return &zero_entity, false
	}

	ent := &ctx.gs.entities[handle.index]
	if ent.handle.id != handle.id {
		return &zero_entity, false
	}

	return ent, true
}

entity_create :: proc(kind: Entity_Kind) -> ^Entity {

	index := -1
	if len(ctx.gs.entity_free_list) > 0 {
		index = pop(&ctx.gs.entity_free_list)
	}

	if index == -1 {
		assert(ctx.gs.entity_top_count + 1 < MAX_ENTITIES, "ran out of entities, increase size")
		ctx.gs.entity_top_count += 1
		index = ctx.gs.entity_top_count
	}

	ent := &ctx.gs.entities[index]
	ent.handle.index = index
	ent.handle.id = ctx.gs.latest_entity_id + 1
	ctx.gs.latest_entity_id = ent.handle.id

	entity_setup(ent, kind)
	fmt.assertf(ent.kind != nil, "entity %v needs to define a kind during setup", kind)

	return ent
}

entity_destroy :: proc(e: ^Entity) {
	append(&ctx.gs.entity_free_list, e.handle.index)
	e^ = {}
}

