#!/bin/bash
#
# <org-bash-blog v3. Build a blog from a single orgmode file with emacs and all the bash power>
#
# Copyright (C) 2019 Angel. uGeek
# ugeekpodcast@gmail.com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#


################################################################################
# MAIN CONTENT. INDEX PAGE
INDEX=$(echo "Bienvenidos al Blog de uGeek")
#######
# MAIN CONTENT NEXT. INDEX PAGE
INDEX_NEXT=$(echo "
* Último Podcast
#+HTML:<script async src="https://telegram.org/js/telegram-widget.js?5" data-telegram-post="uGeek/3" data-width="100%"></script></div>
")
################################################################################
# FOOTER WEB. ALL PAGES
PIE_WEB=$(echo '<p style="text-align: center;"><a href="http://creativecommons.org/licenses/by-nc-sa/4.0/" rel="license"><img style="border-width: 0px; display: block; margin-left: auto; margin-right: auto;" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" alt="Licencia de Creative Commons" /></a><br />Este obra est&aacute; bajo una <a href="http://creativecommons.org/licenses/by-nc-sa/4.0/" rel="license">licencia de Creative Commons Reconocimiento-NoComercial-CompartirIgual 4.0 Internacional</a>.</p><br><br><br>')
################################################################################
# RSS
LOGO_FEED="ugeek.png"
################################################################################
# GOOGLE ANALITYCS & META TAG
GOOGLE_ANALITYCS=$(echo "#+HTML_HEAD: <!-- Global site tag (gtag.js) - Google Analytics -->
#+HTML_HEAD: <script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-131560140-1\"></script>
#+HTML_HEAD: <script>
#+HTML_HEAD:  window.dataLayer = window.dataLayer || [];
#+HTML_HEAD:  function gtag(){dataLayer.push(arguments);}
#+HTML_HEAD:  gtag('js', new Date())
#+HTML_HEAD:
#+HTML_HEAD:  gtag('config', 'UA-999999999-1');
#+HTML_HEAD: </script>
")
################################################################################
TITLE=$(grep "#+TITLE:" blog.org | cut -d " " -f2-)
LINK=$(grep "#+LINK:" blog.org | cut -d " " -f2-)
DESCRIPTION=$(grep "#+DESCRIPTION:" blog.org | cut -d " " -f2-)
grep ":TITLE:" blog.org | cut -d " " -f2- | sed 's/,/|/g' > title
grep ":EXPORT_FILE_NAME:" blog.org | cut -d " " -f2- | sed 's/ /-/g' | awk '{print tolower($0)}' > link
grep ":DESCRIPTION:" blog.org | cut -d " " -f2- | sed 's/,/|/g'> description 
grep ":EXPORT_DATE:"  blog.org | cut -d " " -f2- > date-
grep ":CATEGORY:"  blog.org | cut -d " " -f2- > category
grep ":TAG:" blog.org | cut -d " " -f2- | tr -d ' ' | sed "s|$|,,,,,,,,,|" | cut -d, -f -10 > tag
cat date- |  tr -d '-' > date
paste -d, date title link description date- category tag  > postsID.csv
cat postsID.csv | sort -r | cut -d, -f2- > posts.csv
cat postsID.csv | sort | cut -d, -f2- > posts4feed.csv
cat posts.csv | cut -d "," -f5 | sed '/^ *$/d' | uniq | sort > category.csv
cat tag | cut -d "," -f1 > tags.csv
cat tag | cut -d "," -f2 >> tags.csv 
cat tag | cut -d "," -f3 >> tags.csv
cat tag | cut -d "," -f4 >> tags.csv
cat tag | cut -d "," -f5 >> tags.csv
cat tag | cut -d "," -f6 >> tags.csv
cat tag | cut -d "," -f7 >> tags.csv
cat tag | cut -d "," -f8 >> tags.csv
cat tag | cut -d "," -f9 >> tags.csv
cat tag | cut -d "," -f10 >> tags.csv
cat tags.csv | sed '/^ *$/d' | sort | uniq > tag.csv
echo " " >> blog.org
NUM_POSTS=$(cat posts.csv |  wc -l)
TODO=$(grep -irq "* TODO" blog.org)
if [ $? -eq 0 ]; then
clear
echo ">>> org-bash-blog va a publicar el Post <<<"
grep -n "* TODO" blog.org |  cut -d ":" -f1 > TODO.txt
LINES_BLOG=$(cat blog.org  | wc -l)
cat blog.org  | wc -l >> TODO.txt
echo "Hay $NUM_POSTS Artículos y $LINES_BLOG líneas en Blog.org"
rm org/*.org
ONE_LINE=$(cat TODO.txt | head -1)
sed -i '1d' TODO.txt
while read TWO_LINE; do
LAST_LINE=$(($TWO_LINE - 1))
CATEGORY=$(cat blog.org | sed -n  "$ONE_LINE,$LAST_LINE"p | sed 's/* TODO/*/g' | grep ":CATEGORY:"  | cut -d " " -f2)
cat blog.org | sed -n  "$ONE_LINE,$LAST_LINE"p | sed 's/* TODO/*/g' >> org/$CATEGORY.org
echo "$GOOGLE_ANALITYCS" > temp_post.org
sed -n "5,20 p" blog.org >> temp_post.org
cat blog.org | sed -n  "$ONE_LINE,$LAST_LINE"p | sed 's/* TODO/*/g' >> temp_post.org
ONE_LINE=$(echo $TWO_LINE)
PUB=$(expr $PUB + 1)
echo "Publicando Artículo Nº $PUB "
echo "#+HTML: <br><br> " >> temp_post.org
echo "También te puede interesar:
 "  >> temp_post.org
CATEGORY=$(grep ":CATEGORY:" temp_post.org | cut -d " " -f2)
grep -i $CATEGORY posts.csv | sed '1d' > category_temp_post.csv
cat category_temp_post.csv | head -n10 > cat_temp.csv
cp cat_temp.csv category_temp_post.csv
while read LINEA; do  
OTHERSTITLE=$(echo $LINEA | cut -d, -f1)
OTHERSLINKS=$(echo $LINEA | cut -d, -f2)
OTHERSDATE=$(echo  $LINEA | cut -d, -f4)
echo " - [[$LINK/post/$OTHERSDATE-$OTHERSLINKS.html][$OTHERSTITLE]] " >> temp_post.org
echo " "
done < category_temp_post.csv
FILE_TITLE=$(grep ":TITLE:" temp_post.org | cut -d " " -f2- | sed 's/|/,/g')
FILE_NAME=$(grep ":EXPORT_FILE_NAME:" temp_post.org | cut -d " " -f2- |awk '{print tolower($0)}' |  sed 's/ /-/g')
FILE_DATE=$(grep ":EXPORT_DATE:" temp_post.org | cut -d " " -f2)
FILE=$(echo "$FILE_DATE-$FILE_NAME")
FILE_DESCRIPTION=$(grep ":DESCRIPTION:" temp_post.org | cut -d " " -f2-)
DESCRIPTION_P=$(echo $FILE_DESCRIPTION | sed 's/|/,/g')
sed -i "1i #+DESCRIPTION: $DESCRIPTION_P" temp_post.org
sed -i "1i #+LINK: $LINK" temp_post.org
FILE_TAG=$(grep ":TAG:" temp_post.org | cut -d " " -f2-)
TAG=$(echo $FILE_TAG | sed 's/|/,/g')
sed -i "1i #+KEYWORDS: $TAG" temp_post.org                                                                                                  
echo "#+TITLE: $FILE_TITLE" > $FILE.org
cat temp_post.org >> $FILE.org
ORG=$(echo '#+HTML:<br><br><br><p style="text-align: center;">Powered by <a href="https://github.com/ugeek/org-bash-blog" target="_blank" rel="noopener">org-bash-blog</a></p><br><p style="text-align: center;">Writing in orgmode whith emacs</p>')
echo "$ORG $PIE_WEB" >> $FILE.org
emacs $FILE.org --batch -f org-html-export-to-html --kill
rm $FILE.org
sed -i 's|./images-blog/|../images-blog/|g' $FILE.html
sed -i 's|__icon/|../icon/|g' $FILE.html
sed -i 's|__css/|../css/|g' $FILE.html
sed -i 's|href="index.html"|href="../index.html"|g' $FILE.html
sed -i 's|href="list.html"|./href="../list.html"|g' $FILE.html
sed -i 's|href="tag.html"|./href="../tag.html"|g' $FILE.html
mv $FILE.html post/$FILE.html
done < TODO.txt
rm TODO.txt
TODAY=$(date +'%A %d de %B del %Y')
echo '<?xml version="1.0" encoding="utf-8"?>
<rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
  <channel>
    <title>'$TITLE'</title>
    <link>'$LINK'</link>
    <description>'$DESCRIPTION'</description>
    <image>
       <url>'$LINK'/'$LOGO_FEED'</url>
       <title>'$TITLE'</title>
       <link>'$LINK'</link>
    </image>
    <language>es</language>
    <atom:link href="'$LINK'/feed.xml" rel="self" type="application/rss+xml" />
    <generator>org-bash-blog static site generator (https://github.com/ugeek/org-bash-blog)</generator>'> feed.xml
while read LINEA; do 
TITLE_F="$(echo $LINEA | cut -d, -f1 | sed 's/|/,/g')"
LINK_P="$(echo $LINEA | cut -d, -f2)"
DESC="$(echo $LINEA | cut -d, -f3 | sed 's/|/,/g')"
DATE="$(echo $LINEA | cut -d, -f4)"
DATEPUB="$(LANG=en_us_88591 ; date -d"$DATE" +'%a, %d %b %Y 18:00 +0100')"
LANG=locale
GUID="http://ugeek.gitlab.io"
echo "   <item>" >> feed.xml
echo "    <title>$TITLE_F</title>" >> feed.xml
echo "    <link>$LINK/post/$DATE-$LINK_P.html</link>" >> feed.xml
echo "    <description>$DESC</description>" >> feed.xml
echo "    <pubDate>$DATEPUB</pubDate>" >> feed.xml
echo "    <guid>$LINK/post/$DATE-$LINK_P.html</guid>
   </item>" >> feed.xml
done < posts.csv
echo "  </channel>
</rss>" >> feed.xml
WORD="emacs"
awk '/,emacs,/ { print }' posts.csv > emacs.csv
echo '<?xml version="1.0" encoding="utf-8"?>
<rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
  <channel>
    <title>'$TITLE'</title>
    <link>'$LINK'</link>
    <description>'$DESCRIPTION'</description>
    <image>
       <url>'$LINK'/'$LOGO_FEED'</url>
       <title>'$TITLE'</title>
       <link>'$LINK'</link>
    </image>
    <language>es</language>
    <atom:link href="'$LINK'/feed.xml" rel="self" type="application/rss+xml" />
    <generator>org-bash-blog static site generator (https://github.com/ugeek/org-bash-blog)</generator>'> $WORD.xml
while read LINEA; do 
TITLE_F="$(echo $LINEA | cut -d, -f1 | sed 's/|/,/g')"
LINK_P="$(echo $LINEA | cut -d, -f2)"
DESC="$(echo $LINEA | cut -d, -f3 | sed 's/|/,/g')"
DATE="$(echo $LINEA | cut -d, -f4)"
DATEPUB="$(LANG=en_us_88591 ; date -d"$DATE" +'%a, %d %b %Y 18:00 +0100')"
LANG=locale
GUID="http://ugeek.gitlab.io"
echo "   <item>" >> $WORD.xml
echo "    <title>$TITLE_F</title>" >> $WORD.xml
echo "    <link>$LINK/post/$DATE-$LINK_P.html</link>" >> $WORD.xml
echo "    <description>$DESC</description>" >> $WORD.xml
echo "    <pubDate>$DATEPUB</pubDate>" >> $WORD.xml
echo "    <guid>$LINK/post/$DATE-$LINK_P.html</guid>
   </item>" >> $WORD.xml
done < emacs.csv
echo "  </channel>
</rss>" >> $WORD.xml
cat posts.csv | head -n5 > posts_home.csv
sed -n "1,20 p" blog.org > index.org
echo "$GOOGLE_ANALITYCS" >> index.org
echo " " >> index.org
echo "$INDEX" >> index.org
echo " " >> index.org
echo "* Últimos Artículos Publicados" >> index.org
echo " " >> index.org
while read LINEA; do 
TPOST=$(echo $LINEA | cut -d, -f1 | sed 's/|/,/g')
UPOST=$(echo $LINEA | cut -d, -f2)
DPOST=$(echo $LINEA | cut -d, -f4)
echo "- /$DPOST/ - [[$LINK/post/$DPOST-$UPOST.html][$TPOST]] " >> index.org
echo " " >> index.org
done < posts_home.csv
echo "$INDEX_NEXT" >> index.org
echo "$ORG $PIE_WEB"  >> index.org
emacs index.org --batch -f org-html-export-to-html --kill
sed -i 's|__icon/|icon/|g' index.html
sed -i 's|__css/|css/|g' index.html
rm index.org posts_home.csv
echo "#+TITLE: Artículos. $TITLE" > list.org
echo "#+LINK: $LINK/list.html" >> list.org
echo "#+DESCRIPTION: Etiquetas de $TITLE" >> list.org
sed -n "4,20 p" blog.org >> list.org
echo "$GOOGLE_ANALITYCS" >> list.org
echo "* $NUM_POSTS Artículos Publicados" >> list.org
echo " " >> list.org
while read LINEA; do 
TPOST=$(echo $LINEA | cut -d, -f1 | sed 's/|/,/g')
UPOST=$(echo $LINEA | cut -d, -f2)
DPOST=$(echo $LINEA | cut -d, -f4)
echo "- /$DPOST/ - [[$LINK/post/$DPOST-$UPOST.html][$TPOST]] " >> list.org
echo " " >> list.org
done < posts.csv 
echo "$ORG $PIE_WEB"  >> list.org
emacs list.org --batch -f org-html-export-to-html --kill
sed -i 's|__icon/|icon/|g' list.html
sed -i 's|__css/|css/|g' list.html
rm list.org
echo "#+TITLE: Tags. $TITLE" > tag.org
echo "#+LINK: $LINK/tag.html" >> tag.org
echo "#+DESCRIPTION: Etiquetas de $TITLE" >> tag.org
sed -n "4,20 p" blog.org >> tag.org
echo "$GOOGLE_ANALITYCS" >> tag.org
echo "* Etiquetas" >> tag.org
echo " " >> tag.org
while read TAG; do 
grep -i "$TAG" posts.csv > temp_tag.csv
echo "** $TAG" >> tag.org
NUM_TAGS=$(cat tag.csv | wc -l)
while read LINEA; do 
TPOST=$(echo $LINEA | cut -d, -f1 | sed 's/|/,/g' )
UPOST=$(echo $LINEA | cut -d, -f2)
DPOST=$(echo $LINEA | cut -d, -f4)
echo "- /$DPOST/ - [[$LINK/post/$DPOST-$UPOST.html][$TPOST]] " >> tag.org
done < temp_tag.csv
done < tag.csv 
rm temp_tag.csv
echo "$ORG $PIE_WEB" >> tag.org
emacs tag.org --batch -f org-html-export-to-html --kill
sed -i 's|__icon/|icon/|g' tag.html
sed -i 's|__css/|css/|g' tag.html
rm tag.org category_temp_post.csv cat_temp.csv
rm *~
else
echo "No hay ningun Post con estado TODO"
fi
rm posts.csv emacs.csv
rm  posts4feed.csv postsID.csv 
rm tag.csv tags.csv tag temp_post.org
rm category.csv
rm title link description category date date-  
sed '$d' blog.org
