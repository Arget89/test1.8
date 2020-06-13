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
sudo nginx
Запуск gunicorn
cd /home/box/web
sudo gunicorn -c /etc/gunicorn.d/gunic.conf.py hello:app &
cd /home/box/web/ask/
sudo gunicorn -c /etc/gunicorn.d/gunic2.conf.py ask.wsgi:application &
