def app(env, start_response):
    getparams = env['QUERY_STRING']
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return  [getparams]