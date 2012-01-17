/*
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
 */


#include "sharetusplugin.h"
#include "sharetusmethod.h"
 
SharetusPlugin::SharetusPlugin (QObject * parent) :
    ShareUI::PluginBase (parent) {

}

SharetusPlugin::~SharetusPlugin () {
}

QList<ShareUI::MethodBase *> SharetusPlugin::methods (QObject * parent) {

    QList<ShareUI::MethodBase *> list;
    
    list.append (new SharetusMethod(parent));
    
    return list;
}

Q_EXPORT_PLUGIN2(cmd, SharetusPlugin)
