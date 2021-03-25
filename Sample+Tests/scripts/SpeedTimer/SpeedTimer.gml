function SpeedTimer() constructor {
    start_time = get_timer();
    last_time = start_time;
    last_split = undefined;
    running = false;
    splits = new Array();
    
    static startSplit = function() {
        running = true;
        last_time = get_timer();
        return get_timer();
    }
    
    static endSplit = function() {
        running = false;
        var _split = get_timer() - last_time;
        splits.append(_split);
        
        return _split;
    }
    
    static split = function() {
        var ans = endSplit();
        startSplit();
        
        return ans;
    }
}