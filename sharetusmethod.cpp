

/*
 * This file is part of Handset UX Share user interface
 *
 * Copyright (C) 2010-2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 * Contact: Jukka Tiihonen <jukka.t.tiihonen@nokia.com>
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




#include "sharetusmethod.h"
#include <QDebug>
#include <QProcess>
#include <ShareUI/ItemContainer>
#include <ShareUI/DataUriItem>
#include <ShareUI/FileItem>

SharetusMethod::SharetusMethod (QObject * parent) : ShareUI::MethodBase (parent) {
}

SharetusMethod::~SharetusMethod () {
}

QString SharetusMethod::title () {
    return QLatin1String ("Sharetus");
}

QString SharetusMethod::icon () {
    return QString();
}

QString SharetusMethod::id () {
    return QString::fromLatin1 ("org.basshero.sharetus");
}

void SharetusMethod::selected (const ShareUI::ItemContainer * items) {

    Q_UNUSED (items);

    Q_EMIT (done());

    return;
}

void SharetusMethod::currentItems (const ShareUI::ItemContainer * items) {
    Q_EMIT(visible(acceptContent(items)));
}

bool SharetusMethod::acceptContent (const ShareUI::ItemContainer * items)
{

  if (items == 0 || items->count() == 0) {
    return false;
  }

  ShareUI::ItemIterator itemsIter = items->itemIterator();

  // False if fileitems
  while (itemsIter.hasNext()) {

    ShareUI::SharedItem item = itemsIter.next();
    ShareUI::FileItem * fileItem = ShareUI::FileItem::toFileItem (item);

    if (fileItem) {
      return false;
    }
  }

  return true;
}

