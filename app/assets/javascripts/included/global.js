function hostname() {
    return "http://localhost:3000"
}

function add_query_string_param(url, key, value) {
    
    if(url.indexOf("?") == -1) {
	url += "?";
    }
    else {
	url += "&";
    }

    return url + key + "=" + value;    
}