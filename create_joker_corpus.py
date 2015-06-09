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
import sys
from itertools import product

if __name__ == '__main__':
    # read config
    Config = ConfigParser.ConfigParser()
    Config.read("config.ini")

    server = Config.get('mainSection', 'url')+":"+Config.get('mainSection', 'port')
    userAdmin = Config.get('userSection', 'userAdmin')
    pwdAdmin = Config.get('userSection', 'pwdAdmin')
    corpusName = Config.get('ressourceSection', 'corpusName')
    mediaList = Config.get('ressourceSection', 'mediaList')
    mediaPath = Config.get('ressourceSection', 'mediaPath')

    client = Camomile(server)
    client.login(userAdmin, pwdAdmin)

    # create new corpus or get corpus id
    # id_corpus = client.createCorpus(corpusName, returns_id=True)
    id_corpus = client.getCorpora(corpusName)[0]._id;

    mediumNames = [line.rstrip('\n') for line in open(mediaList)]
    mediumPaths = [line.rstrip('\n') for line in open(mediaPath)]

    # add media to corpus
    for i in range(0, len(mediumNames)):
        client.createMedium(id_corpus, mediumNames[i], url=mediumPaths[i])
