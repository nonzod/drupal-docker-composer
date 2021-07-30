# Drupal + Composer + Docker

Implementa docker su installazione Drupal via Composer

`create-project drupal/recommended-project:9.2.1 project-dir --no-interaction`

Da usare per creazione, avvio, arresto, rimozione e validazione dello stack docker.

* `docker-compose up -d --build` crea e inizializza lo stack
* `docker-compose down` rimuove lo stack mantenendo i databases e i logs, non rimuove i sorgenti della webapp
* `docker-compose start` avvia lo stack
* `docker-compose stop` arresta lo stack
* `docker-compose down --volumes` come down ma rimuove anche i volumi quindi cancella anche i databases
* `docker-compose config` verifica che le impostazione di ambiente e dello stack siano corrette e non ci siano errori all’interno del file docker-compose.yml
* `docker-compose exec SERVICE_NAME bash` entra con il termianle bash al’interno del container dichiarato
