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

    
    count = 0
    deleted = 0

    for l in client.getLayers():
        # if "annotateur" in l.name:
        print l.name
        annotations = client.getAnnotations(l._id)
        print('annotations : %d' % len(annotations))

        # tmp = [[(u'start', a['fragment']['start']), (u'end', a['fragment']['end']), (u'data', a['data'])] for a in annotations]
        # tmp = []
        # for a in annotations:
        #     tmp.append({'start': a['fragment']['start'], 'end': a['fragment']['end'], u'data': a['data']})

        tmp = [{'start': a['fragment']['start'], 'end': a['fragment']['end'], u'data': a['data'], 'id_medium': a['id_medium']} for a in annotations]

        cleaned = [dict(t) for t in set([tuple(d.items()) for d in tmp])]

        seen = set()
        doublons = []
        indices = []
        for i in range(0, len(tmp)):
            t = tuple(tmp[i].items())
            if t not in seen:
                seen.add(t)
            else:
                doublons.append(tmp[i])
                indices.append(i)

        print('annotations cleaned : %d' % len(cleaned))
        print('doublons : %d\n' % len(doublons))

        count += len(cleaned)

        for i in indices:
            # data = "DELETE__%s" % annotations[i].data
            # client.createAnnotation(layer=l._id, medium=annotations[i].id_medium, fragment=annotations[i].fragment, data=data)
            client.deleteAnnotation(annotations[i]._id)
            deleted += 1

        # print "\nannotations:\n\n"
        # for x in sorted(tmp, key=lambda k: k['start']):
        #     print x

        # print "\ncleaned:\n\n"

        # for x in sorted(cleaned, key=lambda k: k['start']):
        #     print x



    ans = raw_input("\nWrite 'delete' to delete annotations starting with 'DELETE__' (or press enter to continue): ")

    if(ans == "delete"):
        print "\n\tdeleting..."
        for a in client.getAnnotations():
            if 'DELETE__' in a.data:
                client.deleteAnnotation(a._id)
                deleted += 1

    
    print "\n\nComputing grand total..."
    print "\nTotal annotations: \t\t%d" % len(client.getAnnotations())
    print "Total annotations cleaned: \t%d" % count
    print "Total annotations deleted: \t%d" % deleted

