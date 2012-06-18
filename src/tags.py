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

from PySide import QtCore
import QtSparql


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
        self.log.write('User clicked on:'+ wrapper._tag.name)
        self.sharer.toggle_tag(wrapper._tag.name)
        
    @QtCore.Slot(str, str)
    def save_tags(self, tags, to_database):
        for tag in tags.split(','):
            self.log.write('Adding tag: '+tag)
            self.sharer.toggle_tag(tag)
            # add to model
            self.tag_model.addItem(tag)
            # save to database
            if to_database == 'true':
                query = QtSparql.QSparqlQuery("insert { _:a a nao:Tag ; nao:prefLabel '"+tag+"' . }", QtSparql.QSparqlQuery.InsertStatement)
                result = self.connection.exec_(query)
                result.waitForFinished()
                self.log.write('Tag '+tag+' added to database')
                
    @QtCore.Slot(str, result=str)
    def tagStatus(self, tag):
        if tag in self.sharer.tags:
            return "on"
        else:
            return "off"


class Tag(object):
    def __init__(self, name):
        self.name = name
 
    def __str__(self):
        return self.name
        
