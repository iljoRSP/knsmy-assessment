var pruneRepeats = (word) => {
	return word
		.split('')  // split into array of chars
        .filter((item, pos, w) => {         // keep only characters that
            return w.indexOf(item) == pos;  // have their position as the pos of the first instance of that char
        })                                  // effectively, any occurences after the first (dupes) will be filtered out
        .join('');  // rejoin into string
}