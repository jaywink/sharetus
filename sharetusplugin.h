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



#ifndef _SHARE_UI_SHARETUS_PLUGIN_H_
#define _SHARE_UI_SHARETUS_PLUGIN_H_

#include <QObject>
#include <ShareUI/PluginBase>

/*!
   \class CmdPlugin
   \brief Plugin class for ShareUI to provide cmdline method
   \author Tuomas Kulve <tuomas@kulve.fi>
  */
class SharetusPlugin : public ShareUI::PluginBase {

Q_OBJECT    

public:
    
    /*!
      \brief Constructor
      \param parent QObject parent
     */
    SharetusPlugin (QObject * parent = 0);
    
    virtual ~SharetusPlugin ();
    
    /*!
      \brief See ShareUI::MethodPluginInterface
      \return Will return method for command line
     */
    QList <ShareUI::MethodBase *> methods (QObject * parent = 0);

};

#endif
