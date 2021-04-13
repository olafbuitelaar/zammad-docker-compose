vcl 4.1;

backend default {
  .host = "127.0.0.1:3000";
}

sub vcl_req_cookie {    
  //allow for caching with cookies
  return;
}

sub vcl_recv {
  if(req.method == "GET"){
    //We only expect cachable url's
    if(req.url ~ "api/v1/ticket_attachment/\d+/\d+/\d+\?view=(inline|preview)"){
      //TODO: validate session

      return (hash);
    }
  }
  return (pipe);//otherwise just pipe
}

sub vcl_hash {    
  hash_data(req.url);//just use the url as cache key
  return(lookup);
}

sub vcl_miss {
  return (fetch);
}

sub vcl_hit{
  return (deliver);
}

sub vcl_deliver{  
}

sub vcl_backend_response{
  unset beresp.http.Cache-Control;
  unset beresp.http.Expires;
  unset beresp.http.Pragma;

  set beresp.http.Cache-Control = "max-age=86400";//tell browser to keep it local for a day  

  set beresp.ttl = 7d;//inline-image's cannot be changed, so we keep them for a while
  set beresp.grace = 24h;
  set beresp.keep = 120s;

  return (deliver);
}



