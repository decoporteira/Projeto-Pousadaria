require 'rails_helper'

describe 'Pousadaria API' do
    context 'Get /api/v1/inns/' do
        it 'success' do
            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            owner_two = Owner.create!(name: 'Juvenal', last_name: 'Antunes', email: 'juvenal@pousadaria.com', password: 'password')
            inn_two = Inn.create!(trade_name: 'Pousada Pokemon', company_name: 'Pousada do Pikachu LTDA', registration_number: '545434354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua Almeida, 34', neighborhood: 'Barra', city: 'São Paulo', zip_code: '389434-345', description: 'A melhor pousada de Hyrule.', payment_methods: 'todos os cartões de crédito', pet: 'permitidos', rules: 'Não deve evoluir usando pedras.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_two.id)
            owner_three = Owner.create!(name: 'Carla', last_name: 'Marcieira', email: 'carla@pousadaria.com', password: 'password')
            inn_three = Inn.create!(trade_name: 'Pousada Digimon', company_name: 'Pousada Melhor Que Pokemon', registration_number: '09346854221343', phone: '32999223456', email: 'pousada@digimon.com', address: 'Rua das Casas, 1', neighborhood: 'Santo Antonio', city: 'Muriaé', zip_code: '36038030', description: 'Uma pousada digital.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode falar de Pokemon.',check_in: '11:00', check_out: '15:00', status: "desativada", owner_id: owner_three.id)
            # act
            get "/api/v1/inns/"

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response[0]['trade_name']).to eq('Pousada Nintendo')
            expect(json_response[1]['trade_name']).to eq('Pousada Pokemon')
            expect(json_response[0]['trade_name']).not_to eq('Pousada Digimon')
            expect(json_response[0].keys).not_to include('created_at')
            expect(json_response[0].keys).not_to include('updated_at')
        end

    end

    context 'Get /api/v1/inns/?query=juiz+de+fora' do
        it 'success' do
            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            owner_two = Owner.create!(name: 'Juvenal', last_name: 'Antunes', email: 'juvenal@pousadaria.com', password: 'password')
            inn_two = Inn.create!(trade_name: 'Pousada Pokemon', company_name: 'Pousada do Pikachu LTDA', registration_number: '545434354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua Almeida, 34', neighborhood: 'Barra', city: 'São Paulo', zip_code: '389434-345', description: 'A melhor pousada de Hyrule.', payment_methods: 'todos os cartões de crédito', pet: 'permitidos', rules: 'Não deve evoluir usando pedras.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_two.id)
            owner_three = Owner.create!(name: 'Carla', last_name: 'Marcieira', email: 'carla@pousadaria.com', password: 'password')
            inn_three = Inn.create!(trade_name: 'Pousada Digimon', company_name: 'Pousada Melhor Que Pokemon', registration_number: '09346854221343', phone: '32999223456', email: 'pousada@digimon.com', address: 'Rua das Casas, 1', neighborhood: 'Santo Antonio', city: 'Juiz de Fora', zip_code: '36038030', description: 'Uma pousada digital.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode falar de Pokemon.',check_in: '11:00', check_out: '15:00', status: "ativa", owner_id: owner_three.id)
            # act
            get "/api/v1/inns/?query=juiz+de+fora"

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response[0]['trade_name']).to eq('Pousada Digimon')
            expect(json_response[0]['trade_name']).not_to eq('Pousada Pokemon')
            expect(json_response[0].keys).not_to include('created_at')
            expect(json_response[0].keys).not_to include('updated_at')
        end

    end

    context 'Get /api/v1/inns/rooms?id=1' do
        it 'success' do
            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            Room.create!(name: 'Quarto Pokémon', description: 'Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 150, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id) 
            Room.create!(name: 'Quarto Zelda', description: 'Quarto da Princesa Zelda', size: 30, guest: 1, daily_rate: 120, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id) 
            # act
            get "/api/v1/inns/rooms?id=1"

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response[0]['name']).to eq('Quarto Pokémon')
            expect(json_response[0]['description']).to eq('Quarto idéntico ao quarto de Ash.')
            expect(json_response[1]['name']).to eq('Quarto Zelda')
            expect(json_response[1]['description']).to eq('Quarto da Princesa Zelda')
         
        end

    end

    context 'Get /api/v1/inns/inn_details/?id=1' do
        it 'success' do
            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada da Nintendo LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@pokemon.com', address: 'Rua da Arbok, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            room_one = Room.create!(name: 'Quarto Pokémon', description: 'Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 150, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id) 
            guest_one = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
            reservation_one = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  10.day.from_now, room_id: room_one.id,  guest_id: guest_one.id, total_price: 400, status: :ended)
            review_one = Review.create!(rating: 3, comment: 'Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!', reservation_id: reservation_one.id)
            
            # act
            get "/api/v1/inns/inn_details/?id=1"

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response['trade_name']).to eq('Pousada Nintendo')
            expect(json_response['nota']).to eq(3)
            expect(json_response['phone']).to eq('23243423432')
            expect(json_response['email']).to eq('pousada@pokemon.com')
            expect(json_response['address']).to eq('Rua da Arbok, 123')
            expect(json_response['city']).to eq('São Paulo')
           
         
        end

    end

    context 'Get /api/v1/inns/room?id=1&start=23-10-2023&end=25-10-2023&guests=2' do
        it 'success' do
            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada da Nintendo LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@pokemon.com', address: 'Rua da Arbok, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            room_one = Room.create!(name: 'Quarto Pokémon', description: 'Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 150, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id) 
            guest_one = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
            reservation_one = Reservation.create!(guest_number: 2, start_date: 11.day.from_now, final_date:  20.day.from_now, room_id: room_one.id,  guest_id: guest_one.id, total_price: 400, status: :ended)
            review_one = Review.create!(rating: 3, comment: 'Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!', reservation_id: reservation_one.id)
            
            # act
            get "/api/v1/inns/room?id=1&start=#{Date.today}&end=#{10.day.from_now}&guests=2"

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response['total_price']).to eq('1650.0')
           
        end

        it 'fail' do
            #arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada Nintendo', company_name: 'Pousada da Nintendo LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@pokemon.com', address: 'Rua da Arbok, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A pousada oficial da Nintendo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)            
            room_one = Room.create!(name: 'Quarto Pokémon', description: 'Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 150, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id) 
            guest_one = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
            reservation_one = Reservation.create!(guest_number: 2, start_date: 0.day.from_now, final_date:  20.day.from_now, room_id: room_one.id,  guest_id: guest_one.id, total_price: 400, status: :active)
            review_one = Review.create!(rating: 3, comment: 'Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!', reservation_id: reservation_one.id)
            
            # act
            get "/api/v1/inns/room?id=1&start=#{Date.today}&end=#{10.day.from_now}&guests=2"

            #assert
            expect(response.status).to eq 422
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response['error']).to eq('Reverva não pode ser feita nessa dia ou número de hóspedes é maior que o quarto comporta.')
           
        end

    end

end
