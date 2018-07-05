## Image docker with openoffice build for application ruby

Building image
```shell
# docker build -t passenger-with-openoffice .
```

Running image 
```shell
# docker run -d --name your-app -p 80:80 -e DOMAIN=your.domain.com passenger-with-openoffice
```
