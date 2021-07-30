# Drupal + Composer + Docker

Implementa docker su installazione Drupal via Composer

* clone repository
* run `get_drupal.sh`
* `cd .tt/ && docker-compose up -d --build`

## Network

* Drupal [http://localhost:8080](http://localhost:8080)
* Adminer [http://localhost:8081](http://localhost:8081)
* Mailhog [http://localhost:8082](http://localhost:8082)

## Docker

Da usare per creazione, avvio, arresto, rimozione e validazione dello stack docker.

* `docker-compose up -d --build` crea e inizializza lo stack
* `docker-compose down` rimuove lo stack mantenendo i databases e i logs, non rimuove i sorgenti della webapp
* `docker-compose start` avvia lo stack
* `docker-compose stop` arresta lo stack
* `docker-compose down --volumes` come down ma rimuove anche i volumi quindi cancella anche i databases
* `docker-compose config` verifica che le impostazione di ambiente e dello stack siano corrette e non ci siano errori all’interno del file docker-compose.yml
* `docker-compose exec SERVICE_NAME bash` entra con il termianle bash al’interno del container dichiarato

## Note

Sono presenti esempi di `settings.local.php` e `services.local.yml` nella directory `.tt/config/drupal/docker`

Per usare MailHog è necessario attivare il modulo SMTP `composer require drupal/smtp`

* SMTP Host: mail
* SMTP Port: 1025

## TODO

Proedure di deploy su altri ambienti e CI
