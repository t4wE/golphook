module golphook

pub struct RenderQueue {
pub mut:
	queue shared []Drawable

}

pub fn (mut r RenderQueue) push(drawable Drawable) {
	lock r.queue {
		r.queue << drawable
	}
}

pub fn (r RenderQueue) len() int {
	mut to_ret := 0
	rlock r.queue {
		to_ret = r.queue.len
	}
	return to_ret
}

pub fn (r RenderQueue) at(index int) &Drawable {
	mut to_ret := &Drawable(voidptr(0))
	rlock r.queue {
		to_ret = &r.queue[index]
	}
	return to_ret
}

pub fn (mut r RenderQueue) clear() {
	lock r.queue {
		r.queue.clear()
		// r.queue.delete_many(0, r.queue.len)
	}
}

pub fn (mut r RenderQueue) draw_queue() {
	queue_lenght := r.len()
	for i in 0..queue_lenght -1 {
		r.at(i).draw()
	}

	r.clear()
}
