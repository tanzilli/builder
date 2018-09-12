# Builder

Set di scripts pe generare MicroSD per le schede Acme Systems

Testato su Debian Linux Stretch su [Hetzner cloud](https://console.hetzner.cloud/) (CX11 server @ Eur 2.49/mo - 0.004/h)

## Come usarlo

Creare un nuovo server su [Hetzner cloud](https://console.hetzner.cloud/) 

Installare git 

	sudo apt install git
	
e fare un clone di questo repository GitHub:

	git clone https://github.com/tanzilli/builder.git

Lanciare lo script di installazione pacchetti

	cd builder/scripts
	sudo ./packages.sh

Creare un nuovo utente Linux

	sudo adduser nomeutente

Creare un nuovo virtual host

	sudo cp acme.conf /etc/apache2/sites-available/numeutente.conf
	sudo ln -s /etc/apache2/sites-available/nomeutente.conf /etc/apache2/sites-enabled/nomeutente.conf 

Creare un link nello spazio www per vedere la directoey di lavoro dell'utente

	ln -s /home/nomeutente/builder /var/www/nomeutente

Far ripartire Apache2

	systemctl restart apache2

Installare Codiad

	su nomeutente
	(cd /home/nuovoutente/builder && git clone https://github.com/Codiad/Codiad.git)
	sudo chmod -R 777 /home/nomeutente/builder

Per creare un nuovo progetto:

	cd script
	sudo ./newproject.sh board linux-version