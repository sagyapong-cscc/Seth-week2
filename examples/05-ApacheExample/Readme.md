Run the below commands to start this container:
```
docker build -t apache:1 .
docker run -p 8080:80 apache:1
```

Now, you can open a simple apache webpage from your browser at localhost:8080

Review the dockerfile provided to see how we tell apache what html document to serve.  This example will be useful for homework ex01
