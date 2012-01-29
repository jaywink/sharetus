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


#include "sharetusmethod.h"
#include <QDebug>
#include <QProcess>
#include <QFile>
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
    return QString("sharetus");
}

QString SharetusMethod::id () {
    return QString::fromLatin1 ("org.basshero.sharetus");
}

void SharetusMethod::selected (const ShareUI::ItemContainer * items) {

    Q_UNUSED (items);

    QString cmd = "python /opt/sharetus/sharetus.py";
    QString text;
    QString url;
    QString excerpt;

    ShareUI::ItemIterator itemsIter = items->itemIterator();
    while (itemsIter.hasNext()) {
        // In reality we only should have one uri item atm

        ShareUI::SharedItem item = itemsIter.next();
        ShareUI::DataUriItem * uriItem = ShareUI::DataUriItem::toDataUriItem (item);

        if (uriItem != 0) {
            const MDataUri & dataUri = uriItem->dataUri();
            url = dataUri.textData();
            text = dataUri.attribute("title");
            excerpt = "";
        }
    }

    cmd += " \"" + url + "\" \"" + text + "\"";

    if (1) { // Debug
        QFile file("/tmp/out.txt");
        file.open(QIODevice::WriteOnly | QIODevice::Text);
        QTextStream out(&file);
        out << "url: " << url << "\n";
        out << "text: " << text << "\n";
        out << "cmd: " << cmd << "\n";
        file.close();
    }

    // Launch the command
    if (!QProcess::startDetached(cmd)) {
        // Failed to launch the command
        QString err = "Failed to launch: " + cmd;
        qCritical(err.toLatin1());
        emit(selectedFailed(err));
    } else {
        // Command successfully launched (still running)
        emit(done());
    }

}

void SharetusMethod::currentItems (const ShareUI::ItemContainer * items) {
    Q_EMIT(visible(acceptContent(items)));
}

bool SharetusMethod::acceptContent (const ShareUI::ItemContainer * items)
{

  if (items == 0 || items->count() == 0 || items->count() >= 2) {
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

