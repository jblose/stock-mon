run:
	podman build -t stock-mon .
	podman run -p 5000:5000 stock-mon