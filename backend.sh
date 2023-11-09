log_file="/tmp/expense.log"
colour="\e[33m"

echo -e "${colour} ******disable old version nodejs and enable 18 version nodejs***** \e[0m"
dnf module disable nodejs -y &>>${log_file}
dnf module enable nodejs:18 -y &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} ******install nodejs***** \e[0m"
dnf install nodejs -y &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} ******copy service file***** \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

id expennse &>>/${log_file}
if [ $? -ne 0 ]; then
echo -e "${colour} ******add application user***** \e[0m"
useradd expense &>>/${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi
   fi

echo -e "${colour} ******Create app directory ***** \e[0m"
mkdir /app &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} ******delete all the application content***** \e[0m"
rm -rf /app/* &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} ******downloading and extracting the  application code***** \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>${log_file}
cd /app &>>${log_file}
unzip /tmp/backend.zip &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} ******install nodejs dependencies***** \e[0m"
npm install &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} ******install mysql client & load schema***** \e[0m"
dnf install mysql -y &>>${log_file}
mysql -h mysql-dev.praveendevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} ******reload, enable and restart service ***** \e[0m"
systemctl daemon-reload &>>${log_file}
systemctl enable backend &>>${log_file}
systemctl restart backend &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi