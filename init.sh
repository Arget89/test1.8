sudo apt update
sudo apt install python3.5
sudo apt install python3.5-dev
sudo unlink /usr/bin/python3
sudo ln -s /usr/bin/python3.5 /usr/bin/python3
sudo python3 -m pip install gunicorn
sudo python3 -m pip install django==2.0
sudo python3 -m pip install mysqlclient

sudo /etc/init.d/mysql start
mysql -uroot -e "create database stepic_web;"
mysql -uroot -e "grant all privileges on stepic_web.* to 'box'@'localhost' with grant option;"
cd /web/ask/
sudo python3 manage.py makemigrations qa
sudo python3 manage.py migrate qa


#1. Переименовать и перенести внутренности из тест19 в box
cd /home/box/
cp -r test1.8/* .
#2. Удалить default в nginx site-enabled и сделать своего конфига
sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-enabled/nginx.conf
sudo ln -s /home/box/web/etc/nginx.conf /etc/nginx/sites-enabled/
# Указать конфиг для gunicorn
sudo rm /etc/gunicorn.d/gunic.conf.py
sudo rm /etc/gunicorn.d/gunic2.conf.py
sudo ln -s /home/box/web/etc/gunic.conf.py /etc/gunicorn.d/
sudo ln -s /home/box/web/etc/gunic2.conf.py /etc/gunicorn.d/
# Запуск nginx
sudo nginx -s stop
sudo nginx
# Запуск gunicorn
cd /home/box/web
sudo gunicorn -c /etc/gunicorn.d/gunic.conf.py hello:app &
cd /home/box/web/ask/
sudo gunicorn -c /etc/gunicorn.d/gunic2.conf.py ask.wsgi:application &
