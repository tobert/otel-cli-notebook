# Build:
# docker build --rm -t tobert/otel-cli-notebook .
#
# Usage:
# docker run --rm -p 0.0.0.0:8888:8888 -p 4317:4317 tobert/otel-cli-notebook
# this needs refinement... works on my machine :)
#
# Testing:
# export OTEL_EXPORTER_OTLP_ENDPOINT=localhost:4317
# otel-cli span --name "test span" --verbose
FROM jupyter/tensorflow-notebook:latest AS base

COPY --from=ghcr.io/equinix-labs/otel-cli:v0.0.19 /otel-cli /usr/bin/otel-cli

EXPOSE 4317

RUN pip install --quiet --no-cache-dir networkx

# yes, this is horrible
# yes that 1-day timeout is for a silly bug in otel-cli
# this is just to see if it blends
ENTRYPOINT ["sh", "-c", "mkdir /home/jovyan/traces ; /usr/bin/otel-cli server json --verbose --endpoint 0.0.0.0:4317 --timeout 24h --dir /home/jovyan/traces & jupyter notebook"]
