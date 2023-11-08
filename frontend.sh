echo -e "\e[31m *****install nginx****** \e[0m"
dnf install nginx -y

echo -e "\e[31m *****copy expense configuration file ****** \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[31m *****remove nginx content****** \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[31m *****download the content Zip file****** \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[31m *****Extract the downloaded zip file ****** \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[31m *****Enable and restart nginx****** \e[0m"
systemctl enable nginx
systemctl restart nginx