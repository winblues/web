serve-docs:
  just mkdocs serve -a 0.0.0.0:8000
mkdocs +args:
  #!/bin/bash
  podman run \
    --rm \
    -it \
    -v $PWD:/app:Z \
    --publish 8000:8000 \
    python:3.13 bash -c 'cd /app; pip install mkdocs mkdocs-terminal && mkdocs {{args}}'
