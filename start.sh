#!/bin/bash

update_env_var() {
    local var_name=$1
    local var_value=$2
    local env_file=".env"

    if grep -q "^${var_name}=" "$env_file"; then
        sed -i "s|^${var_name}=.*|${var_name}=${var_value}|" "$env_file"
    else
        echo "${var_name}=${var_value}" >> "$env_file"
    fi
}

HOST_IP=$(hostname -I | awk '{print $1}')
NODE_PORT=${VITE_HMR_PORT:-5173}

update_env_var "VITE_HMR_HOST" "$HOST_IP"
update_env_var "VITE_HMR_PORT" "$NODE_PORT"
update_env_var "UNAME" "$USER"
update_env_var "UID" "$(id -u)"
update_env_var "GID" "$(id -g)"

docker compose down
docker compose up -d --build
