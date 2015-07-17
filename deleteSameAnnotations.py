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

    for l in client.getLayers():
        annotations = client.getAnnotations(l._id)
        print('annotations : %d' % len(annotations))

        fragments = [tuple(a['fragment'].items()) for a in annotations]
        ids = [tuple(a['_id']) for a in annotations]
        datas = [tuple(a['data']) for a in annotations]

        # for i in range(0, len(annotations)):
        #     print tuple(annotations[i]['fragment'].items())
        #     if annotations[i][fragments] not in fragments:
        #         fragments.append(tuple(annotations[i][fragments].items()))

        print('fragments : %d' % len(fragments))
        print fragments[0]
        print('ids : %d' % len(ids))
        print ids[0]
        print('datas : %d' % len(datas))
        print datas[0]

        # cleaned = [dict(t) for t in set([tuple(d.items()) for d in annotations])]

        # duplicates = []

        # for i in range(0, len(annotations)-1):
        #     start_i = annotations[i]['fragment']['start']
        #     end_i   = annotations[i]['fragment']['end']
        #     for j in range(i+1, len(annotations)):
        #         start_j = annotations[j]['fragment']['start']
        #         end_j   = annotations[j]['fragment']['end']
        #         if start_i == start_j and end_i == end_j:
        #             duplicates.append(annotations[i])

        # print('duplicates : %d' % len(duplicates))

        # cleaned = [dict(t) for t in set([tuple(d.items()) for d in annotations])]

        # seen = set()
        # new_l = []
        # for d in annotations:
        #     t = tuple(d.items())
        #     if t not in seen:
        #         seen.add(t)
        #         new_l.append(d)

        # print len(new_l)



