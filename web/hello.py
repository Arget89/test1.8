def app(env, start_response):
    getparams = env['QUERY_STRING']
    getcanc = getparams.split('&')
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return [bytes(x, 'utf-8') for x in getcanc]