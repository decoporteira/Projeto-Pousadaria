require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Owner confirma o check in do hóspede ' do
   
    it 'e vê todas as hospedagens ativas' do
        #Arrange
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  
        room_two = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)

        guest_one = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        guest_two = Guest.create!(name: 'Lily', cpf: 'Rossini', email: 'lily@guest.com', password: 'password')

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        Reservation.create!(guest_number: 2, start_date: 20.day.from_now, final_date:  24.day.from_now, room_id: room_two.id,  guest_id: guest_two.id, total_price: 400, status: :'active stay', check_in_date:Date.today, check_in_time: Time.zone.now)
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        reservation = Reservation.create!(guest_number: 1, start_date:  Date.today, final_date:  7.day.from_now, room_id: room_one.id,  guest_id: guest_one.id, total_price: 300, status: :'active stay', check_in_date:Date.today, check_in_time: Time.zone.now)
        
        #act
        login_as(owner_one, scope: :owner)
        visit(root_path)
        click_on 'Estadias ativas'
        
        #assert
        expect(page).to have_content('Todas as reservas')
        expect(page).to have_content('Código da reserva: 12345678')
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 
        expect(page).to have_content('Quantidade de hóspedes: 1')
        expect(page).to have_content("Check in: #{I18n.l(0.day.from_now.to_date)}") 
        expect(page).to have_content("Check out: #{I18n.l(7.day.from_now.to_date)}") 
        expect(page).to have_content('Nome do quarto: Quarto Pokémon')
        expect(page).to have_content('Código da reserva: 98765432') 
        expect(page).to have_content('Quantidade de hóspedes: 2')
        expect(page).to have_content("Check in: #{I18n.l(20.day.from_now.to_date)}") 
        expect(page).to have_content("Check out: #{I18n.l(24.day.from_now.to_date)}") 
        
            
    end

    it 'e ve os detalhes de uma estadia ativa' do
        #Arrange
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        reservation = Reservation.create!(guest_number: 1, start_date:  Date.today, final_date:  7.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 300, status: :'active stay', check_in_date:Date.today, check_in_time: Time.zone.now)
        
        #act
        login_as(owner_one, scope: :owner)
        visit(root_path)
        click_on 'Estadias ativas'
        click_on 'Quarto Zelda'
        
        #assert
        expect(page).to have_content('Detalhes da estadia')
        expect(page).to have_content('Código da reserva: 12345678')
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 
        expect(page).to have_content('Número de hóspedes: 1')
        expect(page).to have_content("Check in: #{I18n.l(0.day.from_now.to_date)}") 
        expect(page).to have_content("Check out: #{I18n.l(7.day.from_now.to_date)}") 
        expect(page).to have_content("Dia real do check in: #{I18n.l(0.day.from_now.to_date)}")
        expect(page).to have_content("Hora real do check in: #{Time.zone.now.strftime('%H:%M')}")

        expect(page).to have_button('Check out')
            
            
        
        
    end

    it 'e dá check out com sucesso antes do horário do Check out da pousada' do
        travel_to Time.zone.parse("#{Date.current} 08:00:30") do

            #Arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
            room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

            guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
            
            allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
            reservation = Reservation.create!(guest_number: 1, start_date:  Date.today, final_date:  7.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 300, status: :'active stay', check_in_date:Date.today, check_in_time: Time.zone.now)
            
            #act
            
        
            login_as(owner_one, scope: :owner)
            visit(stay_room_reservation_path(room_one, reservation))
            fill_in 'payment', with: 'Pix'
            click_on 'Check out'
            
            #assert
            expect(page).to have_content('Detalhes da estadia')
            expect(page).to have_content('Código da reserva: 12345678')
            expect(page).to have_content('Nome do quarto: Quarto Zelda') 
            expect(page).to have_content('Número de hóspedes: 1')
            expect(page).to have_content('Preço total da estadia: R$ 30,00')
            expect(page).to have_content('Status da reserva: finalizada')
            expect(page).to have_content("Check in: #{I18n.l(0.day.from_now.to_date)}") 
            expect(page).to have_content("Check out: #{I18n.l(7.day.from_now.to_date)}") 
            expect(page).to have_content("Dia real do check in: #{I18n.l(0.day.from_now.to_date)}")
            expect(page).to have_content("Hora real do check in: #{Time.zone.now.strftime('%H:%M')}")
            expect(page).to have_content("Dia real do check out: #{I18n.l(0.day.from_now.to_date)}")
            expect(page).to have_content("Hora real do check out: #{Time.zone.now.strftime('%H:%M')}")
            expect(page).to have_content('Método de pagamento usado: Pix')

        end
    end

    it 'e dá check out com sucesso depois do horário do Check out da pousada, sem preço especial de temporada' do
        travel_to Time.zone.parse("#{Date.current} 16:00:30") do

            #Arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
            room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

            guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
            
            allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
            reservation = Reservation.create!(guest_number: 1, start_date:  Date.today, final_date:  7.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 300, status: :'active stay', check_in_date:Date.today, check_in_time: Time.zone.now)
            
            #act
            
            login_as(owner_one, scope: :owner)
            visit(stay_room_reservation_path(room_one, reservation))
            fill_in 'payment', with: 'Pix'
            click_on 'Check out'
            
            #assert
            expect(page).to have_content('Detalhes da estadia')
            expect(page).to have_content('Código da reserva: 12345678')
            expect(page).to have_content('Nome do quarto: Quarto Zelda') 
            expect(page).to have_content('Número de hóspedes: 1')
            expect(page).to have_content('Preço total da estadia: R$ 60,00')
            expect(page).to have_content('Status da reserva: finalizada')
            expect(page).to have_content("Check in: #{I18n.l(0.day.from_now.to_date)}") 
            expect(page).to have_content("Check out: #{I18n.l(7.day.from_now.to_date)}") 
            expect(page).to have_content("Dia real do check in: #{I18n.l(0.day.from_now.to_date)}")
            expect(page).to have_content("Hora real do check in: #{Time.zone.now.strftime('%H:%M')}")
            expect(page).to have_content("Dia real do check out: #{I18n.l(0.day.from_now.to_date)}")
            expect(page).to have_content("Hora real do check out: #{Time.zone.now.strftime('%H:%M')}")
            expect(page).to have_content('Método de pagamento usado: Pix')

        end
    end

    it 'e dá check out com sucesso depois do horário do Check out da pousada, com preço especial de temporada' do
        travel_to Time.zone.parse("#{Date.current} 16:00:30") do

            #Arrange
            owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
            inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
            room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

            guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
            Price.create!(new_rate: 230, start_date: Date.today, final_date: 4.day.from_now, room_id: room_one.id)  

            allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
            reservation = Reservation.create!(guest_number: 1, start_date:  Date.today, final_date:  7.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 300, status: :'active stay', check_in_date:Date.today, check_in_time: Time.zone.now)
            
            #act
            
        
            login_as(owner_one, scope: :owner)
            visit(stay_room_reservation_path(room_one, reservation))
            fill_in 'payment', with: 'Pix'
            click_on 'Check out'
            
            #assert
            expect(page).to have_content('Detalhes da estadia')
            expect(page).to have_content('Código da reserva: 12345678')
            expect(page).to have_content('Nome do quarto: Quarto Zelda') 
            expect(page).to have_content('Número de hóspedes: 1')
            expect(page).to have_content('Preço total da estadia: R$ 460,00')
            expect(page).to have_content('Status da reserva: finalizada')
            expect(page).to have_content("Check in: #{I18n.l(0.day.from_now.to_date)}") 
            expect(page).to have_content("Check out: #{I18n.l(7.day.from_now.to_date)}") 
            expect(page).to have_content("Dia real do check in: #{I18n.l(0.day.from_now.to_date)}")
            expect(page).to have_content("Hora real do check in: #{Time.zone.now.strftime('%H:%M')}")
            expect(page).to have_content("Dia real do check out: #{I18n.l(0.day.from_now.to_date)}")
            expect(page).to have_content("Hora real do check out: #{Time.zone.now.strftime('%H:%M')}")
            expect(page).to have_content('Método de pagamento usado: Pix')

        end
    end


end