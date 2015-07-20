# The MIT License (MIT)

# Copyright (c) 2014-2015 CNRS

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


import ConfigParser
from camomile import Camomile

if __name__ == '__main__':
    # read config
    Config = ConfigParser.ConfigParser()
    Config.read("config.ini")

    server = Config.get('mainSection', 'url')+":"+Config.get('mainSection', 'port')
    userAdmin = Config.get('userSection', 'userAdmin')
    pwdAdmin = Config.get('userSection', 'pwdAdmin')

    client = Camomile(server)
    client.login(userAdmin, pwdAdmin)

    
    ans = raw_input("Write 'delete' to delete annotations starting with 'DELETE__' (or press enter to continue): ")
    
    count = 0
    if(ans == "delete"):
        print "\n\tdeleting..."
        for a in client.getAnnotations():
            if 'DELETE__' in a.data:
                client.deleteAnnotation(a._id)
                count += 1
        print "\n\t%d annotations deleted" % count

    
    count = 0
    for l in client.getLayers():
        # print l.name
        annotations = client.getAnnotations(l._id)
        # print('annotations : %d' % len(annotations))

        # tmp = [[(u'start', a['fragment']['start']), (u'end', a['fragment']['end']), (u'data', a['data'])] for a in annotations]
        # tmp = []
        # for a in annotations:
        #     tmp.append({'start': a['fragment']['start'], 'end': a['fragment']['end'], u'data': a['data']})

        # tmp = [{'start': a['fragment']['start'], 'end': a['fragment']['end'], u'data': a['data'], 'id_medium': a['id_medium']} for a in annotations]
        tmp = [{'start': a['fragment']['start'], 'end': a['fragment']['end'], u'data': a['data']} for a in annotations]

        cleaned = [dict(t) for t in set([tuple(d.items()) for d in tmp])]

        # print('annotations cleaned : %d\n' % len(cleaned))

        count += len(cleaned)

        # print "\nannotations:\n\n"
        # for x in sorted(tmp, key=lambda k: k['start']):
        #     print x

        # print "\ncleaned:\n\n"

        # for x in sorted(cleaned, key=lambda k: k['start']):
        #     print x

    print "\n\nComputing grand total..."
    print "\nTotal annotations: \t\t%d" % len(client.getAnnotations())
    print "Total annotations cleaned: \t%d" % count