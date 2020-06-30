#!/bin/sh
cd D:/BYUI-COVID.github.io/read-data
git add --all
timestamp() {
  date +"at %H:%M on %m/%d/%Y"
}
git commit -am "auto-commit : Update $(timestamp)"
git push origin master