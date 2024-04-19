Building a Redmine development environment with Docker
=======================================================

The environment for developing Redmine (with webpack installed) in a docker environment.

## Prerequisites

Docker must be installed.

## How to use

1. clone the repository and build the image.

````
$ git clone https://github.com/tohosaku/docker-redmine-dev.git

$ git clone -b simpacker https://github.com/redmine/redmine

$ cd dorecker-redmine-dev
$ ./redmine build
````

2. Add the database password to database.yml.tmpl and copy it to ../redmine/config/
3. Add the database password to dbpass.env.tmpl and save it as .dbpass.env
4. Start the service.

```
$ ./redmine
```

6. Open localhost:3000 and verify that redmine is running.
