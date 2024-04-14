Building a Redmine development environment with Docker
=======================================================

The environment for developing Redmine (with webpack installed) in a docker environment.

## Prerequisites

Docker must be installed. (repository name is "wsl2", but should be fine in other environments).

## How to use

1. clone the repository.

````
$ git clone https://github.com/tohosaku/redmine-docker-wsl2.git

# clone the webpack installed branch.
$ git clone -b simpacker https://github.com/tohosaku/redmine

$ cd redmine-docker-wsl2
````

2. Add the database password to database.yml.tmpl and copy it to ../redmine/config/
3. Add the database password to dbpass.env.tmpl and save it as .dbpass.env
4. install rubygems and npm packages.

```
# redmine checks for the existence of "node_modules" directory, so we'll introduce the npm package first.
$ ./dc.sh run --rm webpack webpack.sh
$ ./dc.sh run --rm redmine redmine.sh
```

5. Start the service.

```
$ ./dc.sh up -d
```

6. Open localhost:3000 and verify that redmine is running.

## Compiling assets

You can also compile assets for the production environment.
```
$ ./dc_prod.sh run --rm webpack yarn release
```

You can compile assets for the production environment.
