require 'rails_helper'

describe 'Pousadaria API' do
    context 'Get /api/v1/cities/' do
        it 'success' do

            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada Nintendo LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            owner_two = Owner.create!(name: 'Juvenal', last_name: 'Antunes', email: 'juvenal@pousadaria.com', password: 'password')
            inn_two = Inn.create!(trade_name: 'Pousada Pokemon', company_name: 'Pousada do Pikachu LTDA', registration_number: '545434354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua Almeida, 34', neighborhood: 'Barra', city: 'Muriaé', zip_code: '389434-345', description: 'A melhor pousada de Hyrule.', payment_methods: 'todos os cartões de crédito', pet: 'permitidos', rules: 'Não deve evoluir usando pedras.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_two.id)
            owner_three = Owner.create!(name: 'Carla', last_name: 'Marcieira', email: 'carla@pousadaria.com', password: 'password')
            inn_three = Inn.create!(trade_name: 'Pousada Digimon', company_name: 'Pousada Melhor Que Pokemon', registration_number: '09346854221343', phone: '32999223456', email: 'pousada@digimon.com', address: 'Rua das Casas, 1', neighborhood: 'Santo Antonio', city: 'Juiz de Fora', zip_code: '36038030', description: 'Uma pousada digital.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode falar de Pokemon.',check_in: '11:00', check_out: '15:00', status: "desativada", owner_id: owner_three.id)
            # act
            get "/api/v1/cities/"
            

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response[0]['city']).to eq('Muriaé')
            expect(json_response[1]['city']).to eq('São Paulo')
            expect(json_response).not_to eq('Juiz de Fora')
            expect(json_response[0].keys).not_to include('trade_name')
            expect(json_response[0].keys).not_to include('email')

        end
    end
    context 'Get /api/v1/inns_by_city/' do
        it 'success' do

            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada Nintendo LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@nintendo.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            owner_two = Owner.create!(name: 'Juvenal', last_name: 'Antunes', email: 'juvenal@pousadaria.com', password: 'password')
            inn_two = Inn.create!(trade_name: 'Pousada Pokemon', company_name: 'Pousada do Pikachu LTDA', registration_number: '545434354355435', phone: '23243423432', email: 'pousada@pokemon.com', address: 'Rua Almeida, 34', neighborhood: 'Barra', city: 'Juiz de Fora', zip_code: '389434-345', description: 'A melhor pousada de Kanto.', payment_methods: 'todos os cartões de crédito', pet: 'permitidos', rules: 'Não deve evoluir usando pedras.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_two.id)
            owner_three = Owner.create!(name: 'Carla', last_name: 'Marcieira', email: 'carla@pousadaria.com', password: 'password')
            inn_three = Inn.create!(trade_name: 'Pousada Digimon', company_name: 'Pousada Melhor Que Pokemon', registration_number: '09346854221343', phone: '32999223456', email: 'pousada@digimon.com', address: 'Rua das Casas, 1', neighborhood: 'Santo Antonio', city: 'Muriaé', zip_code: '36038030', description: 'Uma pousada digital.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode falar de Pokemon.',check_in: '11:00', check_out: '15:00', status: "ativa", owner_id: owner_three.id)
            # act
            get "/api/v1/inns_by_city?city=Juiz+de+Fora"
          
            

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response[0]['city']).to eq('Juiz de Fora')
            expect(json_response[0]['trade_name']).to eq('Pousada Nintendo')
            expect(json_response[0]['email']).to eq('pousada@nintendo.com')
            expect(json_response[1]['city']).to eq('Juiz de Fora')
            expect(json_response[1]['trade_name']).to eq('Pousada Pokemon')
            expect(json_response[1]['email']).to eq('pousada@pokemon.com')
            expect(json_response[2]).to eq(nil)
          
         
           

        end
    end
end