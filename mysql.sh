source common.sh

if [ -z "$1" ]; then
  echo password is missing
  exit
  fi
MYSQL_SET_PASSWORD=$1

echo -e "${colour} *****disable mysql 8 version***** \e[0m"
dnf module disable mysql -y &>>${log_file}
status_check

echo -e "${colour} *****cpy the repo file ***** \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
status_check

echo -e "${colour} *****install mysql 5.7***** \e[0m"
dnf install mysql-community-server -y &>>${log_file}
status_check


echo -e "${colour} *****enable and restart mysql***** \e[0m"
systemctl enable mysqld &>>${log_file}
systemctl restart mysqld &>>${log_file}
status_check

echo -e "${colour} *****Setup the password***** \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_SET_PASSWORD} &>>${log_file}
status_check