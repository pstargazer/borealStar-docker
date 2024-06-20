# copy postgres configs to PGDATA

echo "[21]: COPYING CONF to PGDATA DIR"
cp /tmp/pgconf/* --target-directory=$PGDATA
