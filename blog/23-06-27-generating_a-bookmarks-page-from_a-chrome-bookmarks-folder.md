---
title: 23-06-27 - Generating a Bookmarks Page From a Chrome Bookmarks Folder
section: misc
---

I wanted a bookmark web page I could switch to (using `CTRL-<Tab Number>`) and then quickly open a bookmarked site.

I created a bash script to read the bookmarks from a folder in the Chrome bookmark bar (folder name: `Page`) and create a web page.

I added Javascript (from this site) that allows me to go to a bookmark (link) by typing in the associated number.  I can also search the bookmarks by typing `/` and then entering part of the name.  Pressing Return opens the first matching bookmark.

All bookmarks are opened in a new tab meaning the bookmark page can be used again.

The bash script is [here](https://mjnurse.github.io/LinuxBash-L/Script_gen-bookmark-page_-_Generates_a_bookmark_web_page_from_a_folder_in_the_Chrome_bookmarks_bar.html).

Bookmark page shown below.

| ![](/Blog-B/images/gen-bookmarks-page.png) |

