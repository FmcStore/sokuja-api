FROM python:3.12-slim

LABEL org.opencontainers.image.title="sokuja-api" \
      org.opencontainers.image.description="REST API JSON untuk SOKUJA (x6.sokuja.uk) — anime subtitle Indonesia" \
      org.opencontainers.image.source="https://github.com/FmcStore/sokuja-api"

WORKDIR /app

COPY sokuja_api.py ./

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8787

EXPOSE 8787

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:8787/', timeout=8).status==200 else 1)"

CMD ["python", "sokuja_api.py", "8787"]
