#1. Переименовать и перенести внутренности из тест19 в box
mv test1.8/* .
#2. Удалить default в nginx site-enabled и сделать своего конфига
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /home/box/etc/nginx.conf /etc/nginx/sites-enabled/
# Указать конфиг для gunicorn
sudo ln -s /home/box/etc/gunic.conf.py /etc/gunicorn.d/
# Запуск nginx
sudo nginx
# Запуск gunicorn
cd /home/box/web
sudo gunicorn -c /etc/gunicorn.d/gunic.conf.py hello:app
