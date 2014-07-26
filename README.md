# Vagrant-php

Ambiente de desenvolvimento com Nginx, PHP e MySQL. Baseado no [vagrant-puppet](https://github.com/jamesmcfadden/vagrant-puppet)

## Requerimentos

Estou utilizando o plugin vagrant-dns para o acesso dos sites, para que cada site seja acessado de uma porta diferente para testes em dispositivos móveis.

[vagrant-dns](https://github.com/BerlinVagrant/vagrant-dns)

## Instalação

Faça o clone do repositório

```sh
$ git clone https://github.com/thiagosf/vagrant-php.git
```

## Configuração

Configure os sites editando o arquivos sites.yml

```yml
---
:site:
  :folder: /Users/username/Sites/site
  :port: 8881
  :virtualfolder: site
:site2:
  :folder: /Users/username/Sites/site2
  :port: 8882
  :virtualfolder: site2
```

Cada site precisa ter um arquivo de configuração do nginx, também é necessário criar um diretório na raiz do site para ser criado os logs. No final da configuração, você pode dizer que se trata de uma aplicação CakePHP, e descomentar a linha e comentar a linha acima.

```
# Crie um diretoório para salvar os logs
/Users/username/Sites/site/logs
```

```
# /Users/username/Sites/site/conf/nginx.conf
server {
  listen 8881;
  server_name www.site.dev site.dev;
  root /var/www/site;
  access_log /var/www/site/logs/access.log;
  error_log /var/www/site/logs/error.log;

  include /etc/nginx/global/common.conf;

  ## PHP
  include /etc/nginx/global/php.conf;

  ## CakePHP
  # include /etc/nginx/global/cakephp.conf;
}
```

Acesse o diretório e levente o vagrant

``` 
$ cd vagrant-php
$ vagrant up
```

Após levantar a máquina, é necessário reiniciar o nginx para conseguir ler as configurações de cada site

``` 
$ vagrant ssh -c "sudo service nginx restart"
```

Pronto, agora basta acessar a url configurada

``` 
http://site.dev
``` 

E no dispositivo móvel
``` 
http://{ip-da-sua-maquina}:8881
``` 

## Todo

* Trocar o MySQL para MariaDB
* Pré-instalar extensões do PHP (gd, imagemagick, etc)

## Como contribuir

Contribuições são sempre bem-vindas! Basta fazer um fork desse repositório e enviar um pull request com uma boa descrição.