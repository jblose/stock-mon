CONT:=$(shell type -p podman || echo docker)
ifeq (, $(CONT) && $(shell which docker))
	$(error "No Containerization tool podman/docker available")
endif

run:
	$(CONT) build -t stock-mon-exporter .
	$(CONT) run -p 5000:5000 stock-mon-exporter

# No clue yet what the podman equivalent is.
compose-up:
	$(CONT) build -t stock-mon-exporter .
	docker-compose up

ifdef ENCRYPTION_PASS
decrypt-secrets:
	@openssl enc -d -aes-256-cbc -pass "pass:${ENCRYPTION_PASS}" -in "secret-api-key-json.enc" -out "api-key.json"

encrypt-secrets:
	@openssl enc -aes-256-cbc -pass "pass:${ENCRYPTION_PASS}" -in "api-key.json" -out "secret-api-key-json.enc"

else
decrypt-secrets:
	@echo "ENCRYPTION_PASS is not set."

encrypt-secrets:
	@echo "ENCRYPTION_PASS is not set."

endif