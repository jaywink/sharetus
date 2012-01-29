#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
 * S H A R E T U S
 *
 * Plugin for Harmattan Share UI for sharing to various social
 * and bookmarking sites.
 *
 * See Github for details: https://github.com/jaywink/sharetus
 *
 * Copyright (c) 2012 Jason Robinson (jaywink@basshero.org).
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that the above copyright notice and this paragraph are
 * duplicated in all such forms and that any documentation,
 * advertising materials, and other materials related to such
 * distribution and use acknowledge that the software was developed
 * by the Jason Robinson.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 *
'''

#from BeautifulSoup import BeautifulSoup
from PySide import QtCore
from PySide import QtGui
from PySide import QtDeclarative
import urllib
import re
import sys
 
class Sharer(QtCore.QObject):
    
    share_url = ""
    share_title = ""
    
    def __init__(self, share_url, share_title):
        QtCore.QObject.__init__(self)
        self.share_url = share_url
        self.share_title = share_title
        self.app = QtGui.QApplication(sys.argv)
        self.view = QtDeclarative.QDeclarativeView()
        self.context = self.view.rootContext()
        self.context.setContextProperty('sharer', self)
        self.view.setSource(QtCore.QUrl('/opt/sharetus/qml/main.qml'))
        self.view.showFullScreen()
        
        self.target_url = { "diaspora" : "http://iliketoast.net/dshare.html?url={{url}}&title={{title}}&v=1&noui=1&jump=doclose",
                            "facebook" : "https://www.facebook.com/sharer/sharer.php?u={{url}}&t={{title}}",
                            "twitter"  : "https://twitter.com/intent/tweet?url={{url}}&text={{title}}",
                            "gbookmarks":"https://www.google.com/bookmarks/mark?op=edit&bkmk={{url}}&title={{title}}&annotation=",
                            "delicious": "http://delicious.com/save?url={{url}}&title={{title}}&notes=",
                            "linkedin" : "http://www.linkedin.com/shareArticle?mini=true&url={{url}}&title={{title}}&summary=",
                            "gtranslate":"http://translate.google.com/translate?u={{url}}&sl=auto",
                            "tumblr"   : "http://www.tumblr.com/share?v=3&u={{url}}&s=",
                            "dzone"    : "http://www.dzone.com/links/add.html?url={{url}}&title={{title}}",
                            "pingfm"   : "http://ping.fm/ref/?link={{url}}&title={{title}}"
                        }
        self.app.exec_()
                
        
    @QtCore.Slot(str)
    def share(self, service):
        #page = urllib.urlopen(self.share_url.replace(' ','+')).read()
        #soup = BeautifulSoup(page)
        share_url = self.target_url[service].replace('{{url}}',urllib.quote(self.share_url)).replace('{{title}}',urllib.quote(self.share_title))
        QtGui.QDesktopServices.openUrl(share_url)
        
    def get_share_url(self):
        return self.share_url
        
    def get_share_title(self):
        return self.share_title
        
    on_get = QtCore.Signal()
    share_url_str = QtCore.Property(str, get_share_url, notify=on_get)
    share_title_str = QtCore.Property(str, get_share_title, notify=on_get)
    

# INIT APP

try:
    share_url = sys.argv[1].replace("'","")
    share_title = sys.argv[2].replace("'","")
except:
    sys.exit("Please supply url and title as parameters")

sharer = Sharer(share_url, share_title)

