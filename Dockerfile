# Defina a imagem base
FROM elixir:1.14.3-alpine

# Instale as dependências do sistema operacional
RUN apk add --no-cache bash

# Crie um diretório de trabalho para a aplicação
WORKDIR /app

# Copie o código fonte para o contêiner
COPY . .

# Instale as dependências do Mix
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix compile

# Compile a aplicação Phoenix
RUN mix phx.digest

# Defina a variável de ambiente MIX_ENV para o ambiente de produção
ENV MIX_ENV=prod
ENV DATABASE_URL=ecto://postgres:postgres@localhost:5432/simple_auth_api_dev

# Exponha a porta em que a aplicação está executando
EXPOSE 4000

# Inicie a aplicação Phoenix
CMD ["mix", "phx.server"]