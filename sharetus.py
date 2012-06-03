#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
/**
 * Part of Sharetus, Share UI plugin for Harmattan
 *
 * See: https://github.com/jaywink/sharetus
 *
 * Copyright (c) 2012 Jason Robinson (jaywink@basshero.org).
 * Except for exceptions mentioned in README, All rights reserved.
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
 */
'''

#from BeautifulSoup import BeautifulSoup
from PySide import QtCore
from PySide import QtGui
from PySide import QtDeclarative
import QtSparql
import gconf
import urllib
import re
import sys
 
class Sharer(QtCore.QObject):
    
    share_url = ""
    share_title = ""
    tags = []
    
    version = "0.5.1"
    
    params_to_clean = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_content', 'utm_term']
    target_url = {  "diaspora" : "{{pod}}/bookmarklet?url={{url}}&title={{title}}&notes={{tags}}{{text}}&v=1&noui=1&jump=doclose",
                    "facebook" : "https://www.facebook.com/sharer/sharer.php?m2w&u={{url}}&t={{title}}",
                        # note facebook forced to desktop view as it has better privacy and image controls
                    "twitter"  : "https://twitter.com/intent/tweet?url={{url}}&text={{title}}+{{tags}}",
                    "gplus"    : "https://plus.google.com/share?url={{url}}",
                    "gbookmarks":"https://www.google.com/bookmarks/mark?op=edit&bkmk={{url}}&title={{title}}&annotation=",
                    "delicious": "http://delicious.com/save?url={{url}}&title={{title}}&notes={{text}}",
                    "linkedin" : "http://www.linkedin.com/shareArticle?mini=true&url={{url}}&title={{title}}&summary=http://www.stumbleupon.com/submit?url=[URL]&title=[TITLE]",
                    "gtranslate":"http://translate.google.com/translate?u={{url}}&sl=auto",
                    "tumblr"   : "http://www.tumblr.com/share?v=3&u={{url}}&s=",
                    "dzone"    : "http://www.dzone.com/links/add.html?url={{url}}&title={{title}}",
                    "pingfm"   : "http://ping.fm/ref/?link={{url}}&title={{title}}+{{tags}}",
                    "digg"     : "http://www.digg.com/submit?phase=2&url={{url}}&title={{title}}",
                    "stumble"  : "http://www.stumbleupon.com/submit?url={{url}}&title={{title}}"
                 }                      
                 
    title_styles = {'diaspora'  : ['markdown_bold']}
    url_styles = {'diaspora'    : ['markdown']}
    
    def __init__(self, share_url, share_title):
        QtCore.QObject.__init__(self)
        self.share_url = self.clean_url(share_url)
        self.share_title = share_title
        
    @QtCore.Slot(str)
    def share(self, service):
        #page = urllib.urlopen(self.share_url.replace(' ','+')).read()
        #soup = BeautifulSoup(page)
        if service == 'diaspora':
            try:
                pod_url = gconf.client_get_default().get_string("/apps/ControlPanel/Sharetus/diaspora_pod")
                self.target_url[service] = self.target_url[service].replace('{{pod}}', pod_url)
            except:
                self.target_url[service] = 'http://iliketoast.net/dshare.html?url={{url}}&title={{title}}&notes={{tags}}{{text}}&shorten=no'
        share_url = self.target_url[service].replace('{{url}}',urllib.quote(self.process_url(service))).replace('{{title}}',urllib.quote(self.process_title(service))).replace('{{tags}}',urllib.quote(self.process_tags(service))).replace('{{text}}',urllib.quote(self.process_notes(service)))
        QtGui.QDesktopServices.openUrl(share_url)

    def process_title(self, service):
        title = self.share_title
        if service in self.title_styles.keys():
            styles = self.title_styles[service]
            for style in styles:
                if style == 'markdown_bold':
                    title = '**'+title+'**'
        return title
    
    def process_url(self, service):
        url = self.share_url
        if service in self.url_styles.keys():
            styles = self.url_styles[service]
            for style in styles:
                if style == 'markdown':
                    url = '[link]('+url+')'
        return url

    def process_notes(self, service):
        notes = ''
        return notes
        
    def process_tags(self, service):
        return " ".join(["#"+tag for tag in self.tags])
        
    def get_share_url(self):
        return self.share_url
        
    def get_share_title(self):
        return self.share_title.decode(sys.getfilesystemencoding())
        
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
        
    def toggle_tag(self, tag):
        if tag in self.tags:
            self.tags.remove(tag)
        else:
            self.tags.append(tag)
            
    @QtCore.Slot()
    def contact(self):
        QtGui.QDesktopServices.openUrl(QtCore.QUrl("mailto:jaywink@basshero.org?subject=Feedback: Sharetus, version "+self.version));

    @QtCore.Slot()
    def homepage(self):
        QtGui.QDesktopServices.openUrl("https://github.com/jaywink/sharetus");
        
    @QtCore.Slot(result=str)    
    def get_diaspora_pod(self):
        try:
            return gconf.client_get_default().get_string("/apps/ControlPanel/Sharetus/diaspora_pod")
        except:
            log.write("Couldn't get pod info\n")
            return ""
            
    @QtCore.Slot(str, result=int)    
    def save_diaspora_pod(self, pod_url):
        try:
            client = gconf.client_get_default()
            client.set_string('/apps/ControlPanel/Sharetus/diaspora_pod', pod_url)
            return 0
        except:
            log.write("Couldn't set pod url\n")
            return 1
    
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
        
    def addItem(self, tag):
        self.beginInsertRows(QtCore.QModelIndex(), len(self._tags), len(self._tags)+1)
        self._tags.append(TagWrapper(Tag(tag)))
        self.endInsertRows()


class TagController(QtCore.QObject):
    
    def __init__(self, log, sharer, connection, tag_model):
        QtCore.QObject.__init__(self)
        self.log = log
        self.sharer = sharer
        self.connection = connection
        self.tag_model = tag_model
    
    @QtCore.Slot(QtCore.QObject)
    def tagSelected(self, wrapper):
        log.write('User clicked on:'+ wrapper._tag.name)
        self.sharer.toggle_tag(wrapper._tag.name)
        
    @QtCore.Slot(str, str)
    def save_tags(self, tags, to_database):
        for tag in tags.split(','):
            log.write('Adding tag: '+tag)
            self.sharer.toggle_tag(tag)
            # add to model
            self.tag_model.addItem(tag)
            # save to database
            if to_database == 'true':
                query = QtSparql.QSparqlQuery("insert { _:a a nao:Tag ; nao:prefLabel '"+tag+"' . }", QtSparql.QSparqlQuery.InsertStatement)
                result = connection.exec_(query)
                result.waitForFinished()
                log.write('Tag '+tag+' added to database')
                
    @QtCore.Slot(str, result=str)
    def tagStatus(self, tag):
        if tag in sharer.tags:
            return "on"
        else:
            return "off"


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

# init sharer
sharer = Sharer(share_url, share_title)

# get tags from tracker  
tag_list = []  
try:
    connection = QtSparql.QSparqlConnection("QTRACKER")    
    query = QtSparql.QSparqlQuery("select nao:prefLabel(?d) where { ?d a nao:Tag} order by nao:prefLabel(?d)")
    result = connection.exec_(query)
    result.waitForFinished()
    if result.hasError():
        log.write("Executing query failed")
    else:
        log.write(str(result.size()))
    while result.next():
        if len(result.binding(0).value()) > 0:
            log.write(result.binding(0).value())
            tag_list.append(Tag(result.binding(0).value()))
except:
    log.write("Error! Could not get tags from tracker")

# debug
#tag_list = tag_list + [Tag('debug1'), Tag('debug2')]

# set tag model
tags = [TagWrapper(tag) for tag in tag_list]
tag_model = TagListModel(tags)
controller = TagController(log, sharer, connection, tag_model)

# set contexts
context.setContextProperty('sharer', sharer)
context.setContextProperty('controller', controller)
context.setContextProperty('tagListModel', tag_model)
view.setSource(QtCore.QUrl('/opt/sharetus/qml/main.qml'))
view.showFullScreen()
app.exec_()

log.close()

