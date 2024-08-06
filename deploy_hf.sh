echo `date` > last_depoy.txt
git add last_depoy.txt
git commit -m "deploy"
git push hf main