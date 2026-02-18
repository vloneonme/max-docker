#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

$PROJECT_DIR/scripts/stop.sh 2> /dev/null > /dev/null

# Разрешаем доступ к X11 для Docker
xhost +local:docker > /dev/null 2>&1

# Удаляем старый сокет если он есть
sudo rm -f /tmp/pulseaudio.socket

# Создаем символьную ссылку на существующий сокет PulseAudio
if [ -S "/run/user/$(id -u)/pulse/native" ]; then
    echo "🔊 Использую существующий PulseAudio сокет"
    ln -sf "/run/user/$(id -u)/pulse/native" /tmp/pulseaudio.socket
else
    echo "❌ PulseAudio сокет не найден!"
    exit 1
fi

echo "🚀 Запуск MAX Messenger..."

cd "$PROJECT_DIR"

# Запускаем контейнер
docker compose up --force-recreate
