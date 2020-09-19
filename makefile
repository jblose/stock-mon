CONT:=$(shell type -p podman || echo docker)
ifeq (, $(CONT) && $(shell which docker))
	$(error "No Containerization tool podman/docker available")
endif

run:
	$(CONT) build -t stock-mon-exporter .
	$(CONT) run -p 5000:5000 stock-mon-exporter
