FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN addgroup --system --gid 10001 appgroup && \
    adduser --system --uid 10001 --gid 10001 appuser

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

USER 10001:10001

EXPOSE 5000

CMD ["python3", "app.py"]