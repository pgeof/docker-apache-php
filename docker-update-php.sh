#! /bin/bash

for v in "5.6" "7.1" "7.0" ; do
    (
        cd ${v}
        docker build -t pgeof/apache-php:${v} .
        docker push pgeof/apache-php:${v}
    )
    latest=${v}
done
docker tag pgeof/apache-php:${v} pgeof/apache-php:latest
docker push pgeof/apache-php:latest