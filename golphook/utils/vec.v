module utils

pub struct Matrix {
	m [4][4]f32
}

// present for fucntion which only allow a vec of 2 value
pub struct Vec2 {
pub mut:
	x f32
	y f32
}

[inline]
pub fn (v &Vec2) vec_3() Vec3 {
	return Vec3 {x: v.x, y: v.y, z:0.0}
}

pub struct Angle {
pub mut:
	pitch f32
	yaw f32
	roll f32
}

[inline]
pub fn (a &Angle) vec_3() Vec3 {
	return Vec3 {x: a.yaw, y: a.pitch, z: a.roll}
}

pub struct Vec3 {
pub mut:
	x f32
	y f32
	z f32
}

[inline]
pub fn (v &Vec3) vec_2() Vec2 {
	return Vec2{x: v.x, y: v.y}
}

[inline]
pub fn (v &Vec3) angle() Angle {
	return Angle{yaw: v.x, pitch: v.y, roll: v.z}
}

[inline]
pub fn (v &Vec3) lenght_sqr() f32 {
	return f32((v.x * v.x) + (v.y * v.y) + (v.z * v.z))
}


[inline]
pub fn (l &Vec3) + (r &Vec3) Vec3 {
	return Vec3{x: l.x + r.x, y: l.y + r.y, z: l.z + r.z}
}

[inline]
pub fn (l &Vec3) - (r &Vec3) Vec3 {
	return Vec3{l.x - r.x, l.y - r.y, l.z - r.z}
}

[inline]
pub fn (l &Vec3) * (r &Vec3) Vec3 {
	return Vec3{l.x * r.x, l.y * r.y, l.z * r.z}
}

[inline]
pub fn (l &Vec3) / (r &Vec3) Vec3 {
	return Vec3{l.x / r.x, l.y / r.y, l.z / r.z}
}

[inline]
pub fn (l &Vec3) == (r &Vec3) bool {
	return l.x == r.x && l.y == r.y && l.z == r.z
}

[inline]
pub fn (l &Vec3) < (r &Vec3) bool {
	return l.x < r.x && l.y < r.y && l.z < r.z
}

// !=, >, <= and >= are auto generated by v :)


// dince you can overlaod an operator with different args ex:(Vec * 3)
// this fuction a vec with all the member with the same value and it allow you to
// do Vec * op_vec(3) which is the same as Vec * 3
pub fn op_vec(withVal f32) Vec3 {
	return Vec3{x: withVal, y:withVal, z:withVal}
}


pub fn new_angle<T>(x T, y T, z T) Angle {
	return Angle{ pitch: f32(x), yaw: f32(y), roll: f32(z) }
}

pub fn new_vec3<T>(x T, y T, z T) Vec3 {
	return Vec3{ x: f32(x), y: f32(y), z: f32(z) }
}

pub fn new_vec2<T>(x T, y T) Vec2 {
	return Vec2{ x: f32(x), y: f32(y)}
}
