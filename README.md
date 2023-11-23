# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

API
Para pegar os dados de todas as pousadas:
http://127.0.0.1:3000/api/v1/inns/

Para pegar os dados de todas as pousadas com infomações específicas:
http://127.0.0.1:3000/api/v1/inns/?query=ParametroDeBusca

Exemplo: Pousadas no Rio de Janeiro:
http://127.0.0.1:3000/api/v1/inns/?query=rio de janeiro

---

Pegar dados dos quarto de uma pousada:
http://127.0.0.1:3000/api/v1/inns/rooms?id=IdDaPousada

Exemplo:
http://127.0.0.1:3000/api/v1/inns/rooms?id=1

---

Pegar Detalhes de uma pousada:
http://127.0.0.1:3000/api/v1/inns/inn_details/?id=IdDaPousada

Exemplo:
http://127.0.0.1:3000/api/v1/inns/inn_details/?id=1

---

# Projeto-Pousadaria
