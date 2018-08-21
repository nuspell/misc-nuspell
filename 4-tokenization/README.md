# wiki-corpora

Corpora from Wikipedia, Wiktionary, Wikinieuws et cetera


## 1 Installation Python NLTK

    cd ~
    sudp apt-get install python3-nltk
    sudo python3
    import nltk
    nltk.download('punkt')
    CTRL+D
    sudo mv /root/nltk_data /usr/local/share/
    sudo ln -s /usr/local/share/nltk_data

See also https://nltk.org


## 2 Installation Python WikiExtractor

    cd ~/workspace
    git clone https://github.com/attardi/wikiextractor.git
    cd wikiextractor
    sudo python3 setup.py install

See also https://github.com/attardi/wikiextractor


## 3 Installation Python uniseg

    sudo pip3 install uniseg

See also https://pypi.org/project/uniseg


## Tokenize and count

Counting of unique words will stop at 1048576 (2<sup>20</sup>) to limit the processing power needed. On contemporary computers, this still takes over 48 hours to complete!
