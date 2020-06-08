#/usr/bin/env bash

rm -rf html 2> /dev/null

#create html export path and add reveals.js, img and custom_css dir
find slideshow/* -name 'slides.md' | sed 's|\(.*\)/.*|\1|' | sort | uniq | xargs -L1 |  sed 's/slideshow/html/' | xargs -L1 mkdir -m 775 -p
find slideshow/* -name 'slides.md' | sed 's|\(.*\)/.*|\1|' | sort | uniq | xargs -L1 |  sed 's/slideshow/html/' | xargs -L1 cp -prn $(realpath reveal.js) 
find slideshow/* -name 'slides.md' | sed 's|\(.*\)/.*|\1|' | sort | uniq | xargs -L1 |  sed 's/slideshow/html/' | xargs -L1 cp -prn $(realpath custom_css) 
find slideshow/* -name 'slides.md' | sed 's|\(.*\)/.*|\1|' | sort | uniq | xargs -L1 |  sed 's/slideshow/html/' | xargs -L1 cp -prn $(realpath img) 

# copy data dirs from slideshow to html
find slideshow/* -name 'data' -type d | sed 's|\(.*\)/.*|\1|' | sort | uniq | xargs -L1 | awk '{print "cp -r "$1"/data \t" $1"/data"}' | sed 's/\tslideshow/\thtml/' > cp_data_dirs.sh
bash cp_data_dirs.sh 2> /dev/null
rm cp_data_dirs.sh

# adding a revealjs_option.txt copy (if not exist) in all dir with content
find slideshow/* -name 'slides.md' | sed 's|\(.*\)/.*|\1|' | sort | uniq | xargs -L1 cp -n slideshow/revealjs_option.txt 2> /dev/null # 2> /dev/null to not see cp: ‘slideshow/revealjs_option.txt’ and ‘slideshow/revealjs_option.txt’ are the same file

#generate html files
find slideshow/* -name 'slides.md' -exec sh -c 'pandoc {} -t revealjs -s -o $(dirname {}| sed 's/slideshow/html/')/index.html -V revealjs-url=./reveal.js $(cat $(dirname {})/revealjs_option.txt ) ' \;

# add custom css link in generated html
find html/* -name 'index.html' -exec sed -i 's!</head>!<link rel="stylesheet" href="./custom_css/innolea.css"></head>!' {} \;
# add div for personnalized slides
find html/* -name 'index.html' -exec sed -i 's!</body>!<div id="header-left"></div><div id="footer-up-left">CONFIDENTIEL</div><div id="footer-left"></div><div id="footer-line" ><hr /></div></body>!' {} \;
