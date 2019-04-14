// Early thoughts on a JavaScript implementation.
// Aim is to encourage k-like programming patterns. Fast and 'generic/composable' (eg beauty of where).
// https://v8.dev/blog/elements-kinds

// Idea: uppercase is lazy, lowercase is eager.
// So that fns don't have to care about whether their input is lazy or eager,
// fns could consume inputs using iterator syntax, or else check and do different things depending on arg type.
function WHERE(cs) {const o = []; for (let i in cs) for (let c=0,C=cs[i]; c<C; c++) o.push(i); return o}
function* where(cs) {for (let i in cs) for (let c=0,C=cs[i]; c<C; c++) yield i}

console.log(WHERE([]))
console.log(WHERE([0,1,2]))
console.log(Array.from(where([])))
console.log(Array.from(where([0,1,2])))

// Idea: split library into two files, one EAGER (uc) and one lazy (lc)? Then ES5 users can just use the former.
// (But what if code was written with the lowercase fns in mind? Maybe after a failed feature detection for generators,
// 'where' can be routed to point to 'WHERE's fn and the generators file can avoid being loaded. Object.defineProperties or something.) 

// Would be interesting to see performance benchmarks vs standard Array.prototype.filter, etc.

// Integrate with Mesh? Becomes mesh stdlib?
