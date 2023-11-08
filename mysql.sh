log_file="/tmp/expense.log"
colour="\e[32m"

echo -e "${colour} *****disable mysql 8 version***** \e[0m"
dnf module disable mysql -y &>>${log_file}
echo $?

echo -e "${colour} *****cpy the repo file ***** \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
echo $?

echo -e "${colour} *****install mysql 5.7***** \e[0m"
dnf install mysql-community-server -y &>>${log_file}
echo $?


echo -e "${colour} *****enable and restart mysql***** \e[0m"
systemctl enable mysqld &>>${log_file}
systemctl restart mysqld &>>${log_file}
echo $?

echo -e "${colour} *****Setup the password***** \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>${log_file}
echo $?