log_file="/tmp/expense.log"
colour="\e[31m"

echo -e "${colour} *****install nginx****** \e[0m"
dnf install nginx -y &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****copy expense configuration file ****** \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****remove nginx content****** \e[0m"
rm -rf /usr/share/nginx/html/* &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****download the content Zip file****** \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****Extract the downloaded zip file ****** \e[0m"
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi

echo -e "${colour} *****Enable and restart nginx****** \e[0m"
systemctl enable nginx &>>${log_file}
systemctl restart nginx &>>${log_file}
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
   fi