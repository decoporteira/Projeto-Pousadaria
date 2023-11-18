require 'rails_helper'

describe 'Guest cancela a reserva' do
    it 'com sucesso' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        owner_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: owner_two.id)
        room_two = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)  

        Reservation.create!(guest_number: guest.id, start_date: 20.day.from_now , final_date: 25.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400)
        Reservation.create!(guest_number: guest.id, start_date: 8.day.from_now , final_date: 12.day.from_now, room_id: room_two.id,  guest_id: guest.id, total_price: 300)
        
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Pokémon'
        click_on 'Cancelar Reserva'
       
        #assert
        expect(page).to have_content('Status da reserva: cancelada') 
        expect(page).to have_content('Nome: Quarto Pokémon') 
        expect(page).to have_content('Preço total da estadia: R$ 300,00') 
    end

    it 'mas dá errado pois a reserva começa em menos de 7 dias' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        owner_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: owner_two.id)
        room_two = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)  

        Reservation.create!(guest_number: guest.id, start_date: '2023-12-28', final_date: '2023-12-29', room_id: room_one.id,  guest_id: guest.id, total_price: 400)
        Reservation.create!(guest_number: guest.id, start_date: '2023-11-20', final_date: '2023-11-25', room_id: room_two.id,  guest_id: guest.id, total_price: 300)
        
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Pokémon'
        click_on 'Cancelar Reserva'
    
        #assert
        expect(page).to have_content('A reserva não pode ser cancelada com menos de 7 dias para o check in.')
        expect(page).to have_content('Status da reserva: ativa') 
        expect(page).to have_content('Nome: Quarto Pokémon') 
        expect(page).to have_content('Preço total da estadia: R$ 300,00') 
    end

end