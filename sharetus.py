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
import QtSparql
import urllib
import re
import sys
 
class Sharer(QtCore.QObject):
    
    share_url = ""
    share_title = ""
    
    params_to_clean = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_content', 'utm_term']
    target_url = {  "diaspora" : "http://iliketoast.net/dshare.html?url={{url}}&title={{title}}&v=1&noui=1&jump=doclose",
                    "facebook" : "https://www.facebook.com/sharer/sharer.php?u={{url}}&t={{title}}",
                    "twitter"  : "https://twitter.com/intent/tweet?url={{url}}&text={{title}}",
                    "gplus"    : "https://m.google.com/app/plus/x/?content={{url}}+-+{{title}}&v=compose&hideloc=1",
                    "gbookmarks":"https://www.google.com/bookmarks/mark?op=edit&bkmk={{url}}&title={{title}}&annotation=",
                    "delicious": "http://delicious.com/save?url={{url}}&title={{title}}&notes=",
                    "linkedin" : "http://www.linkedin.com/shareArticle?mini=true&url={{url}}&title={{title}}&summary=",
                    "gtranslate":"http://translate.google.com/translate?u={{url}}&sl=auto",
                    "tumblr"   : "http://www.tumblr.com/share?v=3&u={{url}}&s=",
                    "dzone"    : "http://www.dzone.com/links/add.html?url={{url}}&title={{title}}",
                    "pingfm"   : "http://ping.fm/ref/?link={{url}}&title={{title}}"
                 }                            
    hashtag_targets = ['twitter', 'diaspora', 'gplus']
    
    def __init__(self, share_url, share_title):
        QtCore.QObject.__init__(self)
        self.log = open('/tmp/sharetus.debug', 'w')
        self.share_url = self.clean_url(share_url)
        self.share_title = share_title
        self.app = QtGui.QApplication(sys.argv)
        self.view = QtDeclarative.QDeclarativeView()
        self.context = self.view.rootContext()
        self.context.setContextProperty('sharer', self)
        self.tracker = self.get_tracker_conn()
        self.view.setSource(QtCore.QUrl('/opt/sharetus/qml/main.qml'))
        self.view.showFullScreen()
        self.app.exec_()
        self.log.close()
        
    def get_tracker_conn(self):
        connection = QtSparql.QSparqlConnection("QTRACKER")
        if connection.isValid():
            self.log.write("Driver found\n")
        else:
            self.log.write( "Driver not found\n")
        return connection
        
    def get_tracker_tags(self):
        query = QtSparql.QSparqlQuery("select nao:prefLabel(?d) where { ?d a nao:Tag}")
        result = self.tracker.exec_(query)
        result.waitForFinished()
        if not result.hasError():
            self.log.write( "Executing query ok\n")
        else: 
            self.log.write( "Executing query failed\n")
            return []
        tags = []
        while result.next():
            self.log.write( result.binding(0).value() +'\n')
            if len(result.binding(0).value()) > 0:
                tags.append(result.binding(0).value())
        self.log.write(','.join(tags))
        return ','.join(tags)
        
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
    tags = QtCore.Property(str, get_tracker_tags, notify=on_get)
    
    def clean_url(self, url):
        # cleans url of unnecessary parameters
        final_params = []
        try:
            if url.find('?') > -1:
                # params found
                params = url[url.find('?')+1:].split('&')
                for param in params:
                    key = param.split('=')[0]
                    if key not in self.params_to_clean:
                        final_params.append(param)
                if len(final_params) > 0:
                    url = url[0:url.find('?')+1] + '&'.join(final_params)
                else:
                    url = url[0:url.find('?')]
        except:
            #never fail due to exception
            pass
        return url
    

# INIT APP

try:
    share_url = sys.argv[1].replace("'","")
    share_title = sys.argv[2].replace("'","")
except:
    sys.exit("Please supply url and title as parameters")

sharer = Sharer(share_url, share_title)

