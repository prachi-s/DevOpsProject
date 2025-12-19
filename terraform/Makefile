.PHONY: test
test:
	@echo "Testing with authentication token..."
	@URL=http://$$(gcloud compute forwarding-rules describe my-http-fr \
		--global \
		--format="value(IPAddress)"); \
	TOKEN=$$(gcloud auth print-identity-token); \
	curl -H "Authorization: Bearer $$TOKEN" $$URL