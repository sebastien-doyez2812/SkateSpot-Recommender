FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    git curl build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Libs installation:
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''"]


