// Early thoughts on a JavaScript implementation.
// Aim is to encourage k-like programming patterns. Fast and 'generic/composable' (eg beauty of where).
// https://v8.dev/blog/elements-kinds

function where() {return 123}
function WHERE() {return 321}

where()
WHERE()

// they are different. so uppercase fns could return an array, lowercase a generator.
// functions could consume their inputs using iterator syntax, or else check and do different things depending on arg type.

// would be interesting to see performance benchmarks vs standard Array.prototype.filter, etc.

// integrate with Mesh? Becomes mesh stdlib?
