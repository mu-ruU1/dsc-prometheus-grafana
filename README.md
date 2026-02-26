# dsc-prometheus-grafana

## Setup

### dsc-datatool

```bash
git clone https://codeberg.org/DNS-OARC/dsc-datatool.git
cd dsc-datatool
python3 -m venv venv --system-site-packages
. venv/bin/activate
pip install -r requirements.txt
pip install -e . --no-deps
```

## docker

### 環境変数変更後

```bash
docker compose up -d --force-recreate
```

### コンテナイメージの更新

```bash
docker compose up -d --pull always --force-recreate
```

## docs

- <https://codeberg.org/DNS-OARC/dsc/src/branch/main>
- <https://codeberg.org/DNS-OARC/dsc-datatool>
- <https://dev.dns-oarc.net/packages/>
