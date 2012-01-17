
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




#ifndef _SHARE_UI_SHARETUS_METHOD_H_
#define _SHARE_UI_SHARETUS_METHOD_H_

#include <QObject>
#include <ShareUI/MethodBase>

class SharetusMethod : public ShareUI::MethodBase {

Q_OBJECT

public:

    SharetusMethod (QObject * parent = 0);
    virtual ~SharetusMethod ();

    /*!
      \brief See MethodBase
     */
    virtual QString title();

    /*!
      \brief See MethodBase
     */
    virtual QString icon();

    /*!
      \brief See MethodBase::id
     */
    virtual QString id ();

public Q_SLOTS:

    /*!
      \brief See ShareUI::MethodBase
     */
    void currentItems (const ShareUI::ItemContainer * items);

    /*!
      \brief See ShareUI::MethodBase
     */
    void selected (const ShareUI::ItemContainer * items);

private:

    /*!
      \brief If given content is Ok for command line sharing
      \return true if content is accepted, false if not
     */
    bool acceptContent (const ShareUI::ItemContainer * items);

};

#endif
