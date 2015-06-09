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
    pathToVideo = Config.get('ressourceSection', 'pathToVideo')
    mediaList = Config.get('ressourceSection', 'mediaList')

    client = Camomile(server)
    client.login(userAdmin, pwdAdmin)

    # create new corpus
    # id_corpus = client.createCorpus(corpusName, returns_id=True)
    id_corpus = client.getCorpora(corpusName);

    # add media to corpus
    for mediumName in open(mediaList).read().splitlines():
        for id, cat in product(range(0, 36), {'00_defi', '01_blague', '02_cuisine', '03_woz'}):
            print '{0:05d}/Video/front/{1}/mediumName'.format(id, cat)
            # client.createMedium(id_corpus, mediumName, url=pathToVideo.format(id=id, cat=cat, name=mediumName))


# pathToVideo: {id}/Video/front/{cat}/{name}

# 00/Video/front/00_defi/00_Video_front_00defi_0
# 00/Video/front/01_blague/00_Video_front_01blague_0
# 00/Video/front/02_cuisine/00_Video_front_02cuisine_0
# 00/Video/front/03_woz/00_Video_front_03woz_0
# 01/Video/front/00_defi/01_Video_front_00defi_0
# 01/Video/front/01_blague/01_Video_front_01blague_0
# 01/Video/front/02_cuisine/01_Video_front_02cuisine_0
# 01/Video/front/03_woz/01_Video_front_03woz_0
