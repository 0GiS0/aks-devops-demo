#Upload the code to GitHub
echo "# aks-devops-demo" >> README.md
git init
git add .
git commit -m "added script and gitignore"
git branch -M main
git remote add origin https://github.com/0GiS0/aks-devops-demo.git
git push -u origin main
