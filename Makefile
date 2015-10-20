NAME = securecom/nginx-guacamole
VERSION = 0.1.0

.PHONY: all build tag_latest release 

all: build

build: image/Dockerfile
	docker build -t $(NAME):$(VERSION) --rm image

run: build
	docker run -ti --rm $(NAME):$(VERSION)

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: build tag_latest
	# @if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"
