echo -e "\e[33m ******disable old version nodejs and enable 18 version nodejs***** \e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[33m ******install nodejs***** \e[0m"
dnf install nodejs -y

echo -e "\e[33m ******copy service file***** \e[0m"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[33m ******add application user***** \e[0m"
useradd expense

echo -e "\e[33m ******Create app directory ***** \e[0m"
mkdir /app

echo -e "\e[33m ******downloading and extracting the  application code***** \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip

echo -e "\e[33m ******install nodejs dependencies***** \e[0m"
cd /app
npm install

echo -e "\e[33m ******install mysql client & load schema***** \e[0m"
dnf install mysql -y
mysql -h mysql-dev.praveendevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

echo -e "\e[33m ******reload, enable and restart service ***** \e[0m"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend