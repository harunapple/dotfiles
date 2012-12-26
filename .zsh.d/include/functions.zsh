##
# functions
##

# alc
function alc() {
    if [ $# != 0 ]; then
        lynx -dump -nonumbers "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +38
    else
        lynx -dump -nonumbers "http://www.alc.co.jp/"
    fi
}

# google
function ggl() {
    w3m "https://www.google.co.jp/search?hl=ja&q=$*"
}

# dir open
function o() {
    if [ $# != 0 ]; then
        open $*
    else
        open .
    fi
}

# todo
function todo() {
    if [ $# != 0 ]; then
        grep -ri 'todo' $* | grep -v .svn | grep -i 'todo'
    else
        grep -ri 'todo' . | grep -v .svn  | grep -i 'todo'
    fi
}
