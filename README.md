# Laravel Starter com Docker

Este é um ambiente de desenvolvimento Docker completo e otimizado para aplicações Laravel.

O ambiente é configurado para espelhar o usuário do sistema host (seu usuário) dentro do contêiner da aplicação, eliminando problemas comuns de permissão de arquivos entre o host e o contêiner.

## Serviços Inclusos

-   **`app`**: Contêiner PHP-FPM 8.4 com Xdebug, Composer e o instalador do Laravel.
-   **`nginx`**: Servidor web Nginx configurado para servir a aplicação Laravel.
-   **`mariadb`**: Banco de dados MariaDB.
-   **`node`**: Contêiner Node.js para tarefas de frontend (compilação de assets, Vite).

## Pré-requisitos

1.  **Docker** e **Docker Compose** instalados.
2.  Um terminal com `bash` (padrão na maioria dos sistemas Linux e macOS).

## Como Usar

O processo de setup foi simplificado ao máximo com o uso do script `start.sh`.

### 1. Configure seu Ambiente

**a. Crie seu arquivo `.env`:**

Copie o arquivo de exemplo `.env.example` para um novo arquivo chamado `.env`. É neste arquivo que você irá configurar as variáveis específicas do seu projeto.

```bash
cp .env.example .env
```

**b. Edite o arquivo `.env`:**

Abra o arquivo `.env` e ajuste as variáveis conforme necessário, principalmente `APP_NAME` e as credenciais do banco de dados (`DB_*`).

### 2. Inicie o Ambiente Docker

Execute o script `start.sh`. Ele cuidará de tudo: exportará as variáveis de usuário necessárias e construirá e iniciará todos os contêineres.

```bash
./start.sh
```

O script de inicialização irá automaticamente:
- Instalar as dependências do Composer (`composer install`).
- Ajustar as permissões das pastas `storage` e `bootstrap`.
- Gerar a chave da aplicação (`php artisan key:generate`).
- Rodar as migrações e seeds do banco de dados.
- Iniciar o serviço `php-fpm`.

**b. Acesse a Aplicação:**

Sua aplicação Laravel estará disponível no seu navegador em [http://localhost](http://localhost).

## Comandos Úteis

-   **Executar comandos `artisan`**:
    ```bash
    docker compose exec app php artisan <seu-comando>
    ```

-   **Executar comandos `npm` ou `npx`**:
    ```bash
    docker compose exec node npm install
    docker compose exec node npx vite build
    ```

-   **Acessar o terminal do contêiner `app`**:
    ```bash
    docker compose exec app bash
    ```

-   **Parar todos os serviços**:
    ```bash
    docker compose down
    ```
