FROM ubuntu:22.04

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libxss1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libatspi2.0-0 \
    libwayland-egl1 \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-server0 \
    x11-xserver-utils \
    dbus-x11 \
    pulseaudio \
    pulseaudio-utils \
    alsa-utils \
    # OpenGL библиотеки (все необходимые)
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libglx-mesa0 \
    libgl1 \
    libglvnd0 \
    libglx0 \
    libopengl0 \
    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем MAX
RUN apt update && apt install -y curl gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.max.ru/linux/deb/public.asc | gpg --dearmor -o /etc/apt/keyrings/max.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/max.gpg] https://download.max.ru/linux/deb stable main" | tee /etc/apt/sources.list.d/max.list \
    && apt update && apt install -y max \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# Запускаем MAX
CMD ["max", "--no-sandbox"]
