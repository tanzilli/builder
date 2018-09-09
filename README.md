# Builder

Set of simple scripts to generate bootable MicroSD for the Acme Systems boards

Tested on Debian Linux Stretch on [Hetzner cloud](https://console.hetzner.cloud/) (CX11 server @ Eur 2.49/mo - 0.004/h)

Work in progress !


## How to use it

Create a new server on [Hetzner cloud](https://console.hetzner.cloud/) 

Install git 

	apt install git
	
Clone the repository in your home directory

	git clone https://github.com/tanzilli/builder.git

Launch the packages installation:

	cd builder
	./packages.sh

Edit create.sh to select the version of Kernel and Debian you want to use then generate the
MicroSD contents by typing:

	./create.sh 		