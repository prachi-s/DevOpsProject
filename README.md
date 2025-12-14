# SimpleTimeService


### Steps to pull the container from artifact registry
```bash
docker pull us-central1-docker.pkg.dev/myproject-481217/myregistry/simpletimeservice:v1.0.0
docker run -p 8000:8080 -d us-central1-docker.pkg.dev/myproject-481217/myregistry/simpletimeservice:v1.0.0
curl http://localhost:8000
```


### Steps to build and run the container
```bash
cd app
docker build -t myapp:v1.0.0 .
docker run -p 8000:8080 -d myapp:v1.0.0
curl http://localhost:8000
```

