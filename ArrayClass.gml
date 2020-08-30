///!!!
/// For examples see Tests.gml
///!!!

// See type-conversion API at the bottom of this file


///@function	Array(*item1, *item2, ...)
///@description	Constructor funcion for Array objects
///@param		{any} *item
function Array() constructor {
	content = [];
	size = 0;
	
	// Change these if you want to avoid crashes
	// (it may or may not cause unexpected consequences)
	#macro ARRAY_SHOW_ERROR true
	#macro ARRAY_SHOW_WARNING true
	
	
	__throw = function(err) {
		if ARRAY_SHOW_ERROR {
			throw err;
		}
		else if ARRAY_SHOW_WARNING {
			show_debug_message("Array error: "+string(err))
		}
	}
	
	///@function	append(value, value2, ..)
	///@description	Adds (a) value(s) to the end of the array
	///@param		{any} value
	static append = function(value) {
		for(var i = 0; i < argument_count; ++i) {
			var val = argument[i]
			content[size] = val;
			++size;
		}
		
		return self;
	}
	
	///@function	add(value, value2, ..)
	///@description Mirrors append() method
	///@param		{any} value
	static add = function(value) {
		for(var i = 0; i < argument_count; ++i) {
			var val = argument[i]
			content[size] = val;
			++size;
		}
		
		return self;
	}
	
	///@function	concat(other)
	///@description	Adds every element of the second array to this array
	///@param		{Array/array} other
	static concat = function(_other) {
		if(!is_Array(_other)) {
			if is_array(_other) {
				_other = array_to_Array(_other)
			}
			else {
				__throw("TypeError: trying to concat "+typeof(_other)+" with Array");
				return self;
			}
		}
		
		for(var i = 0; i < _other.size; i++) {
			append(_other.get(i));
		}
		
		return self;
	}
	
	///@function	copy()
	///@description	Returns a copy of the array object
	static copy = function() {
		ans = new Array();
		
		forEach(function(el) {
			ans.append(el);
		});
		
		return ans;
	}
	
	///@function	clear()
	///@description	clears an array object
	static clear = function() {
		content = [];
		size = 0;
		
		return self;
	}
	
	///@function	remove(pos)
	///@description	removes the value at given position
	///@param		{real} pos
	static remove = function(pos) {
		if(pos < 0)
			pos += size;
		
		if(size == 0) {
			__throw("Error: trying to remove value from an empty Array");
			return self;
		}
		else if(pos < 0 or pos > size - 1) {
			__throw( "Error: index "+string(pos)+" is out of range [0, "+string(size-1)+"]");
			return self;
		}
		
		var part1 = slice(0, pos);
		var part2 = slice(pos+1);
		
		part1.concat(part2);
		
		content = part1.content;
		size--;
		
		return self;
	}
	
	///@function	empty()
	///@description	Returns true if the array is empty and false otherwise
	static empty = function() {
		return size == 0;
	}
	
	///@function	equal(other)
	///@description	Returns true if arrays are equal and false otherwise
	static equal = function(_other) {
		if(!is_Array(_other)) {
			__throw( "TypeError: trying to compare "+typeof(_other)+" with Array");
			return false;
		}
		
		if(size != _other.size)
			return false;
		
		for(var i = 0; i < size; i++) {
			var c1 = get(i);
			var c2 = _other.get(i);
			
			
			if(typeof(c1) != typeof(c2))
				return false;
			
			
			if(is_array(c1) and is_array(c2)) {
				if(!array_equals(c1, c2))
					return false;
			}
			else if(is_Array(c1) and is_Array(c2)) {
				if(!c1.equal(c2))
					return false;
			}
			else if c1 != c2
				return false;
		}
		
		return true;
	}
	
	///@function	exists(value)
	///@description	Returns true if the value exists in the array and false otherwise
	static exists = function(_val) {
		val = _val;
		ans = false;
		
		forEach(function(x, pos) {
			if(x == val) {
				ans = true;
				return 1; //Break out of forEach()
			}
		});
		
		return ans;
	}
	
	///@function	filter(func)
	///@description	Loops through the array and passes each value into a function.
	///				Returns a new array with only values, that returned true.
	///				Function func gets (x, *pos) as input
	///				Note: Clean function. Does not affect the original array!
	///@param		{function} func
	static filter = function(_func) {
		func = _func;
		ans = new Array();
		
		forEach(function(x, pos) {
			if(func(x, pos))
				ans.append(x);
		});
		
		//content = ans.content;
		//return self;
		return ans;
	}
	
	///@function	find(value)
	///@description	finds a value and returns its position. -1 if not found
	///@param		{any} value
	static find = function(_val) {
		val = _val;
		ans = -1;
		
		forEach(function(x, pos) {
			if(x == val) {
				ans = pos;
				return 1; //Break out of forEach()
			}
		});
		
		return ans;
	}
	
	///@function	findAll(value)
	///@description	finds all places a value appears and returns an Array with all the positions. empty set if not found
	///@param		{any} value
	static findAll = function(_val) {
		val = _val;
		ans = new Array();
		
		forEach(function(x, pos) {
			if(x == val)
				ans.append(pos);
		});
		
		return ans;
	}

	///@function	first()
	///@description	Returns the first value of the array
	static first = function() {
		return get(0);
	}
	
	///@function	forEach(func)
	///@description	Loops through the array and runs the function with each element as an argument
	///				Function func gets (x, *pos) as arguments
	///				Note: Loop will stop immediately if the function returns anything but zero or undefined
	///@param		{function} func(x, *pos)
	static forEach = function(func) {
		for(var i = 0; i < size; i++) {
			var res = func(get(i), i)
			if(!is_undefined(res) and res != 0) {
				break;
			}
		}
		
		return self;
	}
	
	///@function	get(pos)
	///@description	Returns value at given pos
	///@param		{real} pos
	static get = function(pos) {
		if(pos < 0)
			pos += size; //i.e. Array.get(-1) = Array.last()
		
		if(size == 0) {
			__throw( "Error: trying to achieve value from empty Array");
			return undefined;
		}
		else if(pos < 0 or pos > size-1) {
			__throw( "Error: index "+string(pos)+" is out of range [0, "+string(size-1)+"]");
			return undefined;
		}
		
		
		return content[pos];
	}
	
	///@function	insert(pos, value)
	///@description	inserts a value into the array at given position
	///@param		{real} pos
	///@param		{any} value
	static insert = function(pos, value) {
		if(pos < 0)
			pos += size;
		
		if(pos < 0 or (pos > size-1 and size != 0)) {
			show_debug_message("Warning: trying to insert a value outside of the array. Use Array.set() or Array.append() instead");
			return set(pos, value);
		}
		
		var part1 = slice(0, pos);
		var part2 = slice(pos);
		
		part1.append(value);
		part1.concat(part2);
		
		content = part1.content;
		size++;
		
		return self;
	}
	
	///@function	join(separator)
	///@description returns a string, containing all of the array values separated by 'sep'
	///@tip			to join part of the array, use array.slice().join()
	///@param		{string} separator
	///@param		{bool} show_bounds
	static join = function(sep, show_bounds) {
		if is_undefined(sep)
			sep = ", "
		if is_undefined(show_bounds)
			show_bounds = true
		
		_sep = sep
		
		if show_bounds
			str = "["
		else
			str = ""
		
		forEach(function(el, i) {
			str += string(el)
			if(i < size-1)
				str += _sep
		})
		
		if show_bounds
			str += "]"
		
		return str
	}
	
	///@function	lambda(func)
	///@description	Loops through the array and applies the function to each element
	///@param		{function} func(x, *pos)
	static lambda = function(func) {
		for(var i = 0; i < size; i++) {
			set(i, func(get(i), i) );
		}
		
		return self;
	}
	
	///@function	last()
	///@description	Returns the last value of the array
	static last = function() {
		return get(-1);
	}
	
	///@function	_max()
	///@description	Returns a maximum of the array. Only works with numbers
	static _max = function() {
		ans = get(0);
		
		forEach(function(x) {
			if(!is_numeric(x)) {
				__throw( "TypeError: Trying to calculate maximum of "+typeof(x)+"");
				ans = undefined;
				return 1 // Break out of forEach()
			}
			
			if(x > ans)
				ans = x;
		});
		
		return ans;
	}
	
	///@function	_min()
	///@description	Returns a minimum of the array. Only works with numbers
	static _min = function() {
		ans = content[0];
		
		forEach(function(x) {
			if(!is_numeric(x)) {
				__throw( "TypeError: Trying to calculate minimum of "+typeof(x)+"");
				ans = undefined;
				return 1
			}
			
			if(x < ans)
				ans = x;
		});
		
		return ans;
	}
	
	///@function	number(value)
	///@description	Returns the amount of elements equal to given value in the array
	///@note		IMPORTANT! Don't try to use this with data structures, as results may be unpredictable
	///				(Use forEach() with your own logic instead)
	///@param		{any} value
	static number = function(_val) {
		val = _val;
		ans = 0;
		
		forEach(function(x, pos) {
			if(x == val)
				ans++;
		});
		
		return ans;
	}
	
	///@function	pop()
	///@description	removes a value from the end of the array and returns it
	static pop = function() {
		ans = last();
		if(empty()) {
			__throw( "Error: trying to pop value from empty Array");
			return undefined;
		}
		
		remove(-1);
		
		return ans;
	}
	
	///@function	popBack()
	///@description	removes a value from the beginning of the array and returns it
	static popBack = function() {
		ans = first();
		remove(0);
		
		return ans;
	}
	
	///@function	push(value, value2, ..)
	///@description Mirrors append() method
	///@param		{any} value
	static push = function(value) {
		for(var i = 0; i < argument_count; ++i) {
			var val = argument[i]
			content[size] = val;
			++size;
		}
		
		return self;
	}
	
	///@function	pushBack(value)
	///@description	inserts a value to the beginning of the array
	///@param		{any} value
	static pushBack = function(val) {
		insert(0, val);
	}
	
	///@function	getRandom()
	///@description Returns a random element from the array
	static getRandom = function() {
		var idx = irandom(size-1)
		if empty() {
			var ans = undefined
		}
		else {
			var ans = get(idx)
		}
		
		return ans
	}
	
	///@function	resize(size)
	///@description	resizes the array. Sizing up leads to filling the empty spots with zeros
	///@param		{real} size
	static resize = function(size) {
		if(size < 0) {
			__throw( "Error: array size cannot be negative");
			return self;
		}
		
		while(size < size) {
			append(0);
		}
		while(size > size) {
			pop();
		}
		
		return self;
	}
	
	///@function	reverse()
	///@description	reverses the array, affecting it
	static reverse = function() {
		ans = new Array();
		forEach(function(element, pos) {
			ans.set(size-pos-1, element);
		});
		
		content = ans.content;
		return self;
	}
	
	///@function	reversed()
	///@description	Returns reversed version of the array, without affecting the original
	static reversed = function() {
		ans = new Array();
		forEach(function(element, pos) {
			ans.set(size-pos-1, element);
		});
		
		return ans;
	}
	
	///@function	set(pos, value)
	///@description	sets value in the array at given index
	///@param		{real} pos
	///@param		{any} item
	static set = function(pos, value) {
		if(pos < 0)
			pos += size;
		
		if(pos > size-1)
			size = pos+1;
		
		
		content[pos] = value;
		
		return self;
	}
	
	///@function	slice(begin, end)
	///@description	Returns a slice from the array with given boundaries. If begin > end - returns reversed version
	///@param		{real} begin
	///@param		{real} end
	static slice = function(_begin, _end) {
		if(is_undefined(_begin))
			_begin = 0;
		
		if(is_undefined(_end))
			_end = size;
		
		ans = new Array();
		
		
		if(_begin > _end) {
			for(var i = _end; i < _begin; i++) {
				ans.pushBack(content[i]);
			}
		}
		else {
			for(var i = _begin; i < _end; i++) {
				ans.append(content[i]);
			}
		}
		
		return ans;
	}
	
	///@function	sort(func, *startpos, *endpos)
	///@description	Bubble sorts through the array in given range, comparing values using provided function. 
	///Function gets (a, b) as input and must return True if A has more priority than B and False otherwise.
	///@example myarray.sort(function(a, b) { return a > b }) will sort 'myarray' in descending order
	///@param		{function} func
	///@param		{real} *startpos	Default - 0
	///@param		{real} *endpos		Default - size
	static sort = function(compare, _begin, _end) {
		if(is_undefined(_begin))
			_begin = 0;
		
		if(is_undefined(_end))
			_end = size;
		
		
		if(!is_numeric(_begin) or round(_begin) != _begin or !is_numeric(_end) or round(_end) != _end) {
			__throw( "TypeError: sort boundaries must be integers");
			return self;
		}
		
		for(var i = _begin; i < _end; i++) {	// Bubble sort LUL
			for(var j = i; j > _begin; j--) {
				if(j > 0 and compare(get(j), get(j-1))) {
					swap(j, j-1);
				}
			}
		}
		
		return self;
	}
	
	#macro SORT_ASCENDING  (function(a, b) { return a < b })
	#macro SORT_DESCENDING (function(a, b) { return a > b })
	
	
	///@function	sorted(func, *startpos, *endpos)
	///@description Mirrors .sort() function, but doesn't affect the original Array
	static sorted = function(compare, _begin, _end) {
		var ans = copy() // self.copy()
		return ans.sort(compare, _begin, _end)
	}
	
	///@function	shuffle()
	///@description shuffles the array (randomly replaces every element)
	static shuffle = function() {
		// Knuth shuffle implementation
		for(var i = size-1; i > 0; --i) {
			var j = irandom_range(0, i)
			swap(i, j)
		}
		
		
		return self
	}
	
	///@function	shuffled()
	///@description	clean version of .shuffle()
	static shuffled = function() {
		var ans = copy();
		return ans.shuffle();
	}
	
	///@function	sum()
	///@description	Returns the sum of all the elements of the array. concats strings.
	///NOTE: Works only with strings or numbars and only if all the elements are the same type.
	static sum = function() {
		if(is_string(get(0)))
			ans = "";
		else if(is_numeric(get(0)))
			ans = 0;
		else {
			__throw( "TypeError: trying to sum up elements, that aren't strings or reals");
			return undefined;
		}
		
		forEach(function(el) {
			if(typeof(el) != typeof(ans))
				__throw( "TypeError: Array elements aren't the same type: got "+typeof(el)+", "+typeof(ans)+" expected.");
			
			ans += el;
		});
		
		return ans;
	}
	
	///@function	swap(pos1, pos2)
	///@description	swaps 2 values at given positions
	///@param		{real} pos1
	///@param		{real} pos2
	static swap = function(pos1, pos2) {
		var temp = get(pos1);
		set(pos1, get(pos2));
		set(pos2, temp);
		
		return self;
	}
	
	///@function	unique()
	///@description	Returns a copy of this Array object, deleting all duplicates
	static unique = function() {
		ans = new Array();
		
		forEach(function(x) {
			if(!ans.exists(x))
				ans.append(x);
		});
		
		return ans;
	}

	for(var i = 0; i < argument_count; i++)
		append(argument[i])
	
	
	static toString = function() {
		return self.join()
	}
}


///@function	Range(min, max, step)
///@function	Range(min, max)
///@function	Range(max)
///@description Returns a new Array object, containing numbers in certain range
function Range() : Array() constructor {
	
	if argument_count > 1 {
		var mi = argument[0];
		var ma = argument[1];
	}
	else {
		var mi = 0;
		var ma = argument[0];
	}
	
	if argument_count > 2 {
		var step = argument[2];
	}
	else {
		var step = 1;
	}

	
	// Iterate!
	if mi < ma // Normal
	{
		for(var i = mi; i <= ma; i += step) {
			append(i);
		}
	}
	else { // Reversed
		for(var i = mi; i >= ma; i += step) {
			append(i);
		}
	}
	
	return self
}


///@function	Iterator(arr)
///@description	Constructs an iterator object to allow easier iteration through Array's
function Iterator(arr) constructor {
	self.index = -1;
	self.value = undefined;
	self.array = arr
	
	///@function	next()
	next = function() {
		index++;
		try {
			value = array.get(index);
		}
		catch(e) {
			value = undefined;
		}
		
		return value;
	}
	
	get = function() {
		return value;
	}
	
	
	return self;
}

// Helper functions to convert between data types

///@function	array_to_Array(array)
///@description	Returns an instance of Array object with all the contents of an array
///@param		{array}	array
function array_to_Array(array) {
	if(!is_array(array)) {
		__throw( "TypeError: expected array, got "+typeof(array));
		return undefined;
	}
	
	ans = new Array();
	
	for(var i = 0; i < array_length(array); i++) {
		ans.append(array[i]);
	}
	
	return ans;
}

///@function	array_from_Array(Arr)
///@description	Mirrors function Array_to_array()
///@param		{Array} Arr
function array_from_Array(Arr) {
	return Array_to_array(Arr)
}

///@function	ds_list_to_Array(list)
///@description	Returns an instance of Array object with all the contents of an array
///@param		{real} list
function ds_list_to_Array(list) {
	if(!ds_exists(list, ds_type_list)) {
		__throw( "Error: ds_list with given index does not exist");
		return undefined;
	}
	
	ans = new Array();
	
	for(var i = 0; i < ds_list_size(list); i++) {
		ans.append(list[| i]);
	}
	
	return ans;
}

///@function	is_Array(Arr)
///@description	Checks if a variable holds reference to an Array object
///@param		{any} arr
function is_Array(Arr) {
	return is_struct(Arr) and (instanceof(Arr) == "Array" or instanceof(Arr) == "Range");
}

///@function	Array_to_array(Arr)
///@description	Returns contents of an Array object in format of regular array
///@param		{Array} Arr
function Array_to_array(Arr) {
	if !is_Array(Arr) {
		__throw("Error in function Array_to_array(): expected Array(), got "+typeof(Arr))
		return undefined;
	}
	return Arr.content
}

///@function	ds_list_from_Array(Arr)
///@description	Returns contents of an Array object in format of ds_list
///@param		{Array} Arr
function ds_list_from_Array(Arr) {
	if !is_Array(Arr) {
		__throw("Error in function ds_list_from_Array(): expected Array(), got "+typeof(Arr))
		return undefined;
	}
	
	_list = ds_list_create()
	Arr.forEach(function(item) {
		ds_list_add(_list, item)
	})
	return _list
}

///@function	Array_to_ds_list(Arr)
///@description	Mirrors function ds_list_from_Array()
///@param		{Array} Arr
function Array_to_ds_list(Arr) {
	return ds_list_from_Array(Arr)
}

///@function	ds_list_to_array(ds_list)
///@description	IMPORTANT: Used for native gm arrays, not Array Class!!!
//				use ds_list_to_Array() for Array Class support
///@param		{real} ds_list
function ds_list_to_array(_list) {
	var arr = []
	
	// ah yes, performance
	for(var i = ds_list_size(_list) - 1; i >= 0; --i) {
		arr[i] = _list[| i]
	}
	
	return arr
}

///@function	ds_list_from_array(gm_array)
///@description	IMPORTANT: Used for native gm arrays, not Array Class!!!
//				use ds_list_from_Array() for Array Class support
///@param		{array} arr
function ds_list_from_array(arr) {
	var _list = ds_list_create()
	
	for(var i = array_length(arr) - 1; i >= 0; --i) {
		_list[| i] = arr[i]
	}
	
	return _list
}

///@function	array_to_ds_list(gm_array)
///@description	IMPORTANT: Used for native gm arrays, not Array Class!!!
//				use ds_list_from_Array() for Array Class support
///@param		{array} arr
function array_to_ds_list(arr) {
	return ds_list_from_array(arr)
}