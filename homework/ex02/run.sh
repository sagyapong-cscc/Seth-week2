# You should replace the next line with your command to create a network
docker run -d --name web --network cscc-network --mount source=cscc-storage,target=/usr/local/apache2/htdocs/ --rm httpd:2.4

