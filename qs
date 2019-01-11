#!/bin/bash

dc=$(which docker-compose) # docker-compose command with full path

if [[ -x "$dc" ]]; then
    :
else
    echo "Please install Docker before run this command."
    exit 2
fi

rm="--rm" # To destroy a container

app="web" # describe $application service name from docker-compose.yml

db="db" # describe database service name from docker-compose.yml

front="webpack" # describe webpacker service name from docker-compose.yml

echoing() {
    echo "========================================================"
    echo "$1"
    echo "========================================================"
}

create_project() {
  echoing "Exec Bundle Install for executing rails new command"
  bundle_cmd install

  echoing "Exec rails new with postgresql and webpack"
  bundle_exec rails new . -f -M -C -S -T --skip-spring --skip-turbolinks --skip-coffee --webpack -d=postgresql

  echoing "Update config/database.yml"
  mv database.default.yml config/database.yml

  echoing "Exec db create"
  bundle_exec rails db:create

  echoing "docker-compose up"
  $dc up -d

  echo "You can access to localhost:3000"
}

init_services() {
    echoing "Building containers"
    compose_up --build

    bundle_cmd install
    rake_reset_db
    npm_install
    yarn_cmd
    rake_cmd "frontend:import"

    compose_ps
}

compose_up() {
    echoing "Create and start containers $*"
    $dc up -d "$1"
}

compose_down() {
    echoing "Stop and remove containers $*"
    $dc down $*
}

compose_build() {
    echoing "Build containers $*"
    $dc build $*
}

compose_start() {
    echoing "Start services $*"
    $dc start $*
}

compose_stop() {
    echoing "Stop services $*"
    $dc stop $*
}

compose_restart() {
    echoing "Restart services $*"
    $dc restart $*
}

compose_ps() {
    echoing "Showing running containers"
    $dc ps
}

logs() {
    echoing "Logs $*"
    $dc logs -f $1
}

invoke_bash() {
    $dc run $rm -u root $1 bash
}

invoke_run() {
    renv=""
    if [ -n "$RAILS_ENV" ]; then
        renv="-e RAILS_ENV=$RAILS_ENV "
    fi

    if [ -n "$TRUNCATE_LOGS" ]; then
        renv="$renv -e TRUNCATE_LOGS=$TRUNCATE_LOGS "
    fi

    dbenv=""
    if [ -n "$DISABLE_DATABASE_ENVIRONMENT_CHECK" ]; then
        dbenv="-e DISABLE_DATABASE_ENVIRONMENT_CHECK=$DISABLE_DATABASE_ENVIRONMENT_CHECK "
    fi

    $dc run $rm ${renv}${dbenv}$*
}

run_app() {
    invoke_run $app $*
}

run_db() {
    invoke_run $db $*
}

run_front() {
    invoke_run $front $*
}

rails_server() {
    compose_stop $app
    rm tmp/pids/server.pid

    renv=""
    if [ -n "$RAILS_ENV" ]; then
        renv="-e RAILS_ENV=$RAILS_ENV "
    fi

    $dc run $rm ${renv}--service-ports $app rails s -p 3000 -b 0.0.0.0
}

rails_cmd() {
    bundle_exec rails $*
}

rake_cmd() {
    bundle_exec rake $*
}

rspec_cmd() {
    bundle_exec rspec $*
}

bundle_cmd() {
    run_app bundle $*
}

bundle_exec() {
    run_app bundle exec $*
}

yarn_cmd() {
    run_app bin/yarn $*
}

rubocop_cmd() {
    bundle_exec rubocop $*
}

rails_console() {
    bundle_exec rails s $*
}

rake_reset_db() {
    echoing "Running reset db"
    compose_stop $app
    DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rake_cmd "db:reset"
    rake_cmd "db:fdw:setup"
    RAILS_ENV=test rake_cmd "db:fdw:setup"
    compose_up $app
}

db_console() {
    # from config/database.yml
    database="development"
    username="postgres"
    port="5432"
    container="quickstart_db_1"

    run_db psql -h $container -p $port -U $username $database
}

db_dump() {
    # from config/database.yml
    database="development"
    username="postgres"
    port="5432"
    container="quickstart_db_1"

    tm=$(date +\%Y\%m\%d-\%H\%M)
    dump_file=tmp/dbdump-${dbname}-${tm}.dump

    echoing "Dump database $dbname data to $dump_file"

    run_db pg_dump -h $container -p $port -U $username --disable-triggers $database > $dump_file
    echo "done"
}

npm_install() {
  run_front npm install
}

run_webpack() {
  run_front webpack $*
}

cmd=$1
shift
case "$cmd" in
    setup)
        create_project && exit 0
        ;;
    init)
        init_services && exit 0
        ;;
    ps)
        compose_ps && exit 0
        ;;
    up)
        compose_up $* && compose_ps && exit 0
        ;;
    build)
        compose_build $* && exit 0
        ;;
    start)
        compose_start $* && exit 0
        ;;
    stop)
        compose_stop $* && exit 0
        ;;
    restart)
        compose_restart $* && exit 0
        ;;
    down)
        compose_down $* && exit 0
        ;;
    logs)
        logs $*
        ;;
    bash)
        invoke_bash $*
        ;;
    run)
        invoke_run $*
        ;;
    server)
        rails_server $*
        ;;
    rails)
        rails_cmd $*
        ;;
    cons)
        rails_console $*
        ;;
    rake)
        rake_cmd $*
        ;;
    rspec)
        rspec_cmd $*
        ;;
    bundle)
        bundle_cmd $*
        ;;
    yarn)
        yarn_cmd $*
        ;;
    rubocop)
        rubocop_cmd $*
        ;;
    reset-db)
        rake_reset_db
        ;;
    psql)
        db_console $*
        ;;
    db-dump)
        db_dump $*
        ;;
    npm-install)
        npm_install $*
        ;;
    webpack)
        run_webpack $*
        ;;
    *)
        read -d '' help <<-EOF
Usage: $0 command

Service:
  setup    Create new rails application
  init     Initialize backend services then run
  ps       Show status of services
  up       Create service containers and start backend services
  down     Stop backend services and remove service containers
  start    Start services
  stop     Stop services
  logs     [options] default: none. View output from containers
  bash     [service] invoke bash
  run      [service] [command] run command in given container

Rails:
  server   Run rails server
  rails    [args] Run rails command in application container
  rake     [args] Run rake command in application container
  rspec    [args] Run rspec command in application container
  bundle   [args] Run bundle command in application container
  cons     Run rails console
  yarn     [args] Run yarn command in application container
  rubocop  [args] Run rubocop

Frontend
  npm-install run npm install
  webpack     run webpack

DB:
  reset-db                reset database
  psql                    launch psql console
  pg-dump                 dump database data as sql file
EOF
        echo "$help"
        exit 2
        ;;
esac
