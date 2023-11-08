echo -e "\e[31m *****install nginx****** \e[0m"
dnf install nginx -y &>>/tmp/expense.log

echo -e "\e[31m *****copy expense configuration file ****** \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log

echo -e "\e[31m *****remove nginx content****** \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log

echo -e "\e[31m *****download the content Zip file****** \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log

echo -e "\e[31m *****Extract the downloaded zip file ****** \e[0m"
cd /usr/share/nginx/html &>>/tmp/expense.log
unzip /tmp/frontend.zip &>>/tmp/expense.log

echo -e "\e[31m *****Enable and restart nginx****** \e[0m"
systemctl enable nginx &>>/tmp/expense.log
systemctl restart nginx &>>/tmp/expense.log