#!/bin/sh
cd D:/COVID-project
git add --all
timestamp() {
  date +"at %H:%M on %m/%d/%Y"
}
git commit -am "auto-commit : Update $(timestamp)"
git push origin master