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

from tags import *
from targets import *
#from BeautifulSoup import BeautifulSoup
from PySide import QtCore
from PySide import QtGui
from PySide import QtDeclarative
import QtSparql
import urllib
import json
import re
import sys
import os
import traceback

class Settings(dict):	
    def __init__(self, file_name, template=None):
        self.file_name = file_name
        try:
            file_object = open(file_name)
        except IOError, e:
            if template:
                # create missing file from template
                # check first that location exists, if not try to create
                try:
                    if not os.path.isdir(file_name[:file_name.rfind('/')]):
                        os.mkdir(file_name[:file_name.rfind('/')])
                except:
                    raise IOError("Could not determine or create settings folder "+file_name[:file_name.rfind('/')])
                template_file = open(template)
                file_object = open(file_name, 'w')
                for char in template_file:
                    file_object.write(char)
                template_file.close()
                file_object.close()
                file_object = open(file_name)
            else:
                raise IOError("Settings file "+file_name+" is missing!")
        data = json.load(file_object)
        file_object.close()
        for i in range(len(data)):
            self[data.keys()[i]] = data[data.keys()[i]]
            
    def save(self):
        file_object = open(self.file_name, 'w')
        json.dump(self, file_object, indent=5)
        file_object.close()

class Sharer(QtCore.QObject):
    share_url = ""
    share_title = ""
    tags = []
    
    params_to_clean = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_content', 'utm_term']
                 
    title_styles = {'diaspora'  : ['markdown_bold']}
    url_styles = {'diaspora'    : ['markdown']}
    
    def __init__(self, share_url, share_title):
        QtCore.QObject.__init__(self)
        self.share_url = self.clean_url(share_url)
        self.share_title = share_title
        
    @QtCore.Slot(str, result=str)
    def share(self, service):
        #page = urllib.urlopen(self.share_url.replace(' ','+')).read()
        #soup = BeautifulSoup(page)
        if service == 'diaspora':
            try:
                pod_url = preferences['targets']['diaspora']['pod']
                if pod_url == None or len(pod_url) == 0:
					raise Exception()
                settings['targets'][service]['url'] = settings['targets'][service]['url'].replace('{{pod}}', pod_url)
            except:
                settings['targets'][service]['url'] = 'http://sharetodiaspora.github.com/?url={{url}}&title={{title}}&notes={{tags}}{{text}}&shorten=no'        
        if service == 'clipboard':
            share_url = settings['targets'][service]['url'].replace('{{url}}',self.process_url(service)).replace('{{title}}',self.process_title(service)).replace('{{tags}}',self.process_tags(service)).replace('{{text}}',self.process_notes(service))
            clipboard = QtGui.QClipboard()
            clipboard.setText(share_url)
            return "Copied to clipboard"
        else:
            try:
                share_url = settings['targets'][service]['url'].replace('{{url}}',urllib.quote(self.process_url(service))).replace('{{title}}',urllib.quote(self.process_title(service))).replace('{{tags}}',urllib.quote(self.process_tags(service))).replace('{{text}}',urllib.quote(self.process_notes(service)))
            except:
                share_url = preferences['custom_targets'][service]['url'].replace('{{url}}',urllib.quote(self.process_url(service))).replace('{{title}}',urllib.quote(self.process_title(service))).replace('{{tags}}',urllib.quote(self.process_tags(service))).replace('{{text}}',urllib.quote(self.process_notes(service)))
            QtGui.QDesktopServices.openUrl(share_url)
            return "Opening window for sharing"

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
        
    def get_version(self):
        return settings['version']
        
    on_get = QtCore.Signal()
    share_url_str = QtCore.Property(str, get_share_url, notify=on_get)
    share_title_str = QtCore.Property(str, get_share_title, notify=on_get)
    version_str = QtCore.Property(str, get_version, notify=on_get)
    
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
        QtGui.QDesktopServices.openUrl(QtCore.QUrl("mailto:jaywink@basshero.org?subject=Feedback: Sharetus, version "+settings['version']));

    @QtCore.Slot()
    def homepage(self):
        QtGui.QDesktopServices.openUrl("https://github.com/jaywink/sharetus");
        
    @QtCore.Slot(result=str)    
    def get_diaspora_pod(self):
        try:
            return preferences['targets']['diaspora']['pod']
        except:
            log.write("Couldn't get pod info\n")
            return ""
            
    @QtCore.Slot(str, result=int)    
    def save_diaspora_pod(self, pod_url):
        try:
            preferences['targets']['diaspora']['pod'] = pod_url
            preferences.save()
            return 0
        except:
            log.write("Couldn't set pod url\n")
            return 1
            
# INIT APP

log = open('/tmp/sharetus.debug', 'w')

global settings
settings = Settings('/opt/sharetus/sharetus.json')
global preferences
preferences = Settings(os.environ['HOME']+'/.sharetus/preferences.json', '/opt/sharetus/templates/preferences_template.json')

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

# get targets from settings
target_list = []
try:
    # built-in targets
    for i in range(len(settings['targets'])):
        if preferences['targets'][settings['targets'].keys()[i]]['visible'] == 1:
            target_list.append(Target(settings['targets'].keys()[i], settings['targets'][settings['targets'].keys()[i]]['name'], preferences['targets'][settings['targets'].keys()[i]]['order']))
    # custom targets
    for i in range(len(preferences['custom_targets'])):
        if preferences['custom_targets'][preferences['custom_targets'].keys()[i]]['visible'] == 1:
            target_list.append(Target(preferences['custom_targets'].keys()[i], preferences['custom_targets'][preferences['custom_targets'].keys()[i]]['name'], preferences['custom_targets'][preferences['custom_targets'].keys()[i]]['order']))
except:
    log.write("Error! Problem getting targets!")
    log.write(traceback.format_exc())
target_list.sort(key=lambda x: x.order)
    
# set target model
targets = [TargetWrapper(target) for target in target_list]
target_model = TargetListModel(targets)
target_controller = TargetController(target_model)

# set contexts
context.setContextProperty('sharer', sharer)
context.setContextProperty('controller', controller)
context.setContextProperty('tagListModel', tag_model)
context.setContextProperty('targetListModel', target_model)
context.setContextProperty('targetController', target_controller)

# show app
view.setSource(QtCore.QUrl('/opt/sharetus/qml/main.qml'))
view.showFullScreen()
app.exec_()

log.close()

