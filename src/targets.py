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


class TargetWrapper(QtCore.QObject):
    def __init__(self, target):
        QtCore.QObject.__init__(self)
        self._target = target

    def _name(self):
        return str(self._target)
        
    def _desc(self):
        return self._target.desc

    changed = QtCore.Signal()

    name = QtCore.Property(unicode, _name, notify=changed)
    desc = QtCore.Property(unicode, _desc, notify=changed)

class TargetListModel(QtCore.QAbstractListModel):
    COLUMNS = ('target',)
 
    def __init__(self, targets):
        QtCore.QAbstractListModel.__init__(self)
        self._targets = targets
        self.setRoleNames(dict(enumerate(TargetListModel.COLUMNS)))
 
    def rowCount(self, parent=QtCore.QModelIndex()):
        return len(self._targets)
 
    def data(self, index, role):
        if index.isValid() and role == TargetListModel.COLUMNS.index('target'):
            return self._targets[index.row()]
        return None
        
    def addItem(self, target):
        self.beginInsertRows(QtCore.QModelIndex(), len(self._targets), len(self._targets)+1)
        self._targets.append(TargetWrapper(Target(target)))
        self.endInsertRows()


class TargetController(QtCore.QObject):
    
    targets = []
    
    def __init__(self, target_model):
        QtCore.QObject.__init__(self)
        #self.log = log
        #self.sharer = sharer
        #self.connection = connection
        self.target_model = target_model
    
    @QtCore.Slot(QtCore.QObject)
    def targetSelected(self, wrapper):
        self.toggle_target(wrapper._target.name)
        
    def toggle_target(self, target):
        if target in self.targets:
            self.targets.remove(target)
        else:
            self.targets.append(target)
                
    @QtCore.Slot(str, result=str)
    def targetStatus(self, target):
        if target in self.targets:
            return "on"
        else:
            return "off"


class Target(object):
    def __init__(self, name, desc, order):
        self.name = name
        self.desc = desc
        self.order = order
 
    def __str__(self):
        return self.name
        
