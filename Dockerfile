# This Dockerfile provides the prerequisites of any xeus based kernel

# We use a multi-stage build: https://docs.docker.com/build/building/multi-stage/

FROM debian:stable-slim AS builder

COPY buildPhase.sh .

RUN sh buildPhase.sh

FROM debian:stable-slim

COPY --from=builder /local /xeusTools

COPY imagePhase.sh .

RUN sh imagePhase.sh