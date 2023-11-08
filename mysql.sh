echo -e "\e[32m *****disable mysql 8 version***** \e[0m"
dnf module disable mysql -y

echo -e "\e[32m *****cpy the repo file ***** \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[32m *****install mysql 5.7***** \e[0m"
dnf install mysql-community-server -y


echo -e "\e[32m *****enable and restart mysql***** \e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[32m *****Setup the password***** \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1