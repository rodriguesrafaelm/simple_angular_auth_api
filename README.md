# SimpleAuthApi



##### Estou desenvolvendo essa API para consumir no meu projeto pessoal com angular.
##### <a href="https://github.com/rodriguesrafaelm/simple_angular_auth">Link do front-end do projeto com Angular.</a>
\
\
Por enquanto o objetivo é fazer um app simples para autenticar e publicar textos no seu perfil.\
A estrutura de front-end Angular e a API com Phoenix.
\
\
Em fase experimental pois estou estudando algumas coisas importantes com o angular.\
Aceito qualquer tipo de feedback, na verdade seria de grande ajuda e eu agradeceria muito.

## Rotas disponíveis:
 
 #### Autenticação e cadastro
- `POST` /user/login
- `POST` /user/signup

#### Consultas sem autenticação
- `POST` /user/get-user
- `GET`  /user/get-profile/:id
- `GET`  /user/get-post/:id

#### Apenas usuários autenticados

- `POST` /user/post
- `GET`  /user/get-posts/:id

\
\
\
\
\
\
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
