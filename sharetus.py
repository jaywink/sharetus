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
 * Contributions from elsewhere:
 *   - Python classes TagWrapper, TagListModel, TagController
 *     and Tag, which are based on the example from
 *     http://developer.qt.nokia.com/wiki/Selectable_list_of_Python_objects_in_QML
 *   - C++ classes SharetusPlugin and SharetusMethod, which are based
 *     on CmdShare by Tuomas Kulve
 *     http://tuomas.kulve.fi/blog/2012/01/12/command-line-sharing-for-harmattan/
 *
 * Otherwise the following licence is valid:
 *
 * Copyright (c) 2012 Jason Robinson (jaywink@basshero.org).
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that the above copyright notice and this paragraph are
 * duplicated in all such forms and that any documentation,
 * advertising materials, and other materials related to such
 * distribution and use acknowledge that the software was developed
 * by Jason Robinson.
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
        self.share_url = self.clean_url(share_url)
        self.share_title = share_title
        
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
    
    
class TagWrapper(QtCore.QObject):
    def __init__(self, tag):
        QtCore.QObject.__init__(self)
        self._tag = tag

    def _name(self):
        return str(self._tag)

    changed = QtCore.Signal()

    name = QtCore.Property(unicode, _name, notify=changed)


class TagListModel(QtCore.QAbstractListModel):
    COLUMNS = ('tag',)
 
    def __init__(self, tags):
        QtCore.QAbstractListModel.__init__(self)
        self._tags = tags
        self.setRoleNames(dict(enumerate(TagListModel.COLUMNS)))
 
    def rowCount(self, parent=QtCore.QModelIndex()):
        return len(self._tags)
 
    def data(self, index, role):
        if index.isValid() and role == TagListModel.COLUMNS.index('tag'):
            return self._tags[index.row()]
        return None


class TagController(QtCore.QObject):
    
    def __init__(self, log):
        QtCore.QObject.__init__(self)
        self.log = log
    
    @QtCore.Slot(QtCore.QObject)
    def tagSelected(self, wrapper):
        log.write('User clicked on:'+ wrapper._tag.name)


class Tag(object):
    def __init__(self, name):
        self.name = name
 
    def __str__(self):
        return self.name


# INIT APP

log = open('/tmp/sharetus.debug', 'w')

try:
    share_url = sys.argv[1].replace("'","")
    share_title = sys.argv[2].replace("'","")
except:
    log.write("Please supply url and title as parameters")
    sys.exit("Please supply url and title as parameters")

app = QtGui.QApplication(sys.argv)
view = QtDeclarative.QDeclarativeView()
context = view.rootContext()

# get tags from tracker    
connection = QtSparql.QSparqlConnection("QTRACKER")    
query = QtSparql.QSparqlQuery("select nao:prefLabel(?d) where { ?d a nao:Tag}")
result = connection.exec_(query)
result.waitForFinished()

if result.hasError():
    log.write("Executing query failed")
    
tag_list = []
log.write(str(result.size()))
while result.next():
    if len(result.binding(0).value()) > 0:
        log.write(result.binding(0).value())
        tag_list.append(Tag(result.binding(0).value()))

# set tag model
tags = [TagWrapper(tag) for tag in tag_list]
controller = TagController(log)
tag_model = TagListModel(tags)

# init sharer
sharer = Sharer(share_url, share_title)

context.setContextProperty('sharer', sharer)
context.setContextProperty('controller', controller)
context.setContextProperty('tagListModel', tag_model)
view.setSource(QtCore.QUrl('/opt/sharetus/qml/main.qml'))
view.showFullScreen()
app.exec_()

log.close()

