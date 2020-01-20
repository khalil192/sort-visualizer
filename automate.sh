git add .
git commit -m "$1"
git push origin master

flutter pub global activate peanut
flutter pub get
flutter pub global run peanut
git push origin --set-upstream gh-pages

