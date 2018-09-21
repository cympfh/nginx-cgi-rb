CODENAME=cgi_rb

build:
	docker build -t $(CODENAME) .

run:
	docker run --rm -d -p 8088:80 --name $(CODENAME) $(CODENAME)

stop:
	docker ps -a | grep postman | awk '{print "docker stop ",$$1}' | sh
