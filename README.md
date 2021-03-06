# Drupal + Composer + Docker

Implementa docker su installazione Drupal via Composer

* clone repository
* Modifica variabile in `.tt/.env`
* run `get_drupal.sh`
* `cd .tt/ && docker-compose up -d --build`
* `docker-compose exec -u www-data app bash`
* `./init.sh`

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

**attenzione** In caso di errore "max depth exceeded" fare riferimento a [questo post](https://stackoverflow.com/questions/47272611/docker-max-depth-exceeded).
Al momento la solzione pare essere quella di rimuovere tutte le immagini collegate al dockerfile `docker rmi -f $(docker images -a -q)`

## Note

Sono presenti esempi di `settings.local.php` e `services.local.yml` nella directory `.tt/config/drupal/docker`

Per usare MailHog è necessario attivare il modulo SMTP `composer require drupal/smtp`

* SMTP Host: mail
* SMTP Port: 1025

## TODO

Proedure di deploy su altri ambienti e CI
