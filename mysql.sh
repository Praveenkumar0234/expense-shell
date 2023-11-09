log_file="/tmp/expense.log"
colour="\e[32m"

MYSQL_SET_PASSWORD = "$*"

echo -e "${colour} *****disable mysql 8 version***** \e[0m"
dnf module disable mysql -y &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****cpy the repo file ***** \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****install mysql 5.7***** \e[0m"
dnf install mysql-community-server -y &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi


echo -e "${colour} *****enable and restart mysql***** \e[0m"
systemctl enable mysqld &>>${log_file}
systemctl restart mysqld &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****Setup the password***** \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_SET_PASSWORD} &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi