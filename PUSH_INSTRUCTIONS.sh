# Push 2 repo baru ke GitHub
# Jalankan SETELAH create kedua repo di GitHub (public, tanpa init files)

# 1. role-manager
cd ~/Documents/role-manager
git remote add origin git@github.com:aidizzackyharizulfadly/role-manager.git
git push -u origin main

# 2. role-owner
cd ~/Documents/role-owner
git remote add origin git@github.com:aidizzackyharizulfadly/role-owner.git
git push -u origin main
