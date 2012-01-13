/*
 *
 * Copyright (C) 2012 Tuomas Kulve <tuomas@kulve.fi>
 * Copyright (C) 2010-2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to 
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense,     
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS  
 * IN THE SOFTWARE. 
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
