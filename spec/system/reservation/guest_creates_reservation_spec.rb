require 'rails_helper'

describe 'Usuário tenta fazer uma pre-reserva' do
    it 'mas falha pelo numero de hospedes' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  

        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 3
        fill_in 'Start date', with: 2.day.from_now.to_date
        fill_in 'Final date', with: 9.day.from_now.to_date
        click_on 'Fazer pre-reserva'
    
        #assert
        expect(page).to have_content('Pre-reserva não pode ser feita, data já foi reservada ou número hóspedes é maior do que a o quarto suporta.')
        expect(page).to have_content('Nome: Quarto Pokémon') 
    end

    it 'mas falha pelo por já ter a data reservada' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)        
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Reservation.create!(guest_number: 2, start_date: '2023-12-28', final_date: '2023-12-29', room_id: room.id,  guest_id: guest.id)
    
        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 1
        fill_in 'Start date', with: '2023-12-28'
        fill_in 'Final date', with: '2023-12-30'
        click_on 'Fazer pre-reserva'
     
        #assert
        expect(page).to have_content('Pre-reserva não pode ser feita, data já foi reservada ou número hóspedes é maior do que a o quarto suporta.')
        expect(page).to have_content('Nome: Quarto Pokémon') 
    end


    it 'Com sucesso' do
        #Arrange
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Price.create!(new_rate: 50, start_date: '2023-11-01', final_date: '2023-11-05', room_id: room.id)  
        Price.create(new_rate: 300, start_date: '2023-02-03', final_date: '2023-02-03', room_id: room.id)
        Reservation.create!(guest_number: 2, start_date: 10.day.from_now, final_date: 12.day.from_now, room_id: room.id, guest_id: guest.id)
            
        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 1
        fill_in 'Start date', with: 2.day.from_now
        fill_in 'Final date', with: 8.day.from_now
        click_on 'Fazer pre-reserva'
     
        #assert
        expect(page).to have_content('Pre-reserva feita com sucesso.')
        expect(page).to have_content('Preço da reserva: R$ 140,00')
        expect(page).to have_content("Check-in: #{I18n.l(2.day.from_now.to_date)}")
        expect(page).to have_content("Check-out: #{I18n.l(8.day.from_now.to_date)}")
        expect(page).to have_content('Hóspedes: 1')
    end

    

    it 'faz login e é redirecionado para a new' do
        #Arrange
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Price.create!(new_rate: 50, start_date: '2023-11-01', final_date: '2023-11-05', room_id: room.id)  
        Price.create(new_rate: 300, start_date: '2023-02-03', final_date: '2023-02-03', room_id: room.id)
            
        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 2
        fill_in 'Start date', with: 8.day.from_now
        fill_in 'Final date', with: 12.day.from_now
        click_on 'Fazer pre-reserva'
        click_on 'Fazer Reserva'
        fill_in 'E-mail', with: 'bianca@guest.com'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
        
     
        #assert
        expect(page).to have_content('Login efetuado com sucesso.') 
        expect(page).to have_content('Nome: Quarto Pokémon') 
        expect(page).to have_content('Nome: Quarto Pokémon') 
        expect(page).to have_content('Número de hóspedes: 2')
        expect(page).to have_content("Dia da entranda: #{I18n.l(8.day.from_now.to_date)}")
        expect(page).to have_content("Dia da saída: #{I18n.l(12.day.from_now.to_date)}")
        expect(page).to have_content('Métodos de Pagamento: Apenas PIX')
        expect(page).to have_content('Preço total da estadia: R$ 100,00')
        
    end

    it 'cria cadastro e é redirecionado pra new' do
        #Arrange
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Price.create!(new_rate: 50, start_date: 8.day.from_now, final_date: 10.day.from_now, room_id: room.id)  
        Price.create!(new_rate: 300, start_date: '2023-02-03', final_date: '2023-02-03', room_id: room.id)
            
        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 2
        fill_in 'Start date', with: 8.day.from_now
        fill_in 'Final date', with: 11.day.from_now
        click_on 'Fazer pre-reserva'
        click_on 'Fazer Reserva'
        click_on 'Criar conta'
        fill_in 'Nome', with: 'Bianca Rossini'
        fill_in 'E-mail', with: 'bianca@guest.com'
        fill_in 'Cpf', with: '32132131221'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        
     
        #assert
        expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.') 
        expect(page).to have_content('Nome: Quarto Pokémon') 
        expect(page).to have_content('Número de hóspedes: 2')
        expect(page).to have_content("Dia da entranda: #{I18n.l(8.day.from_now.to_date)}")
        expect(page).to have_content("Dia da saída: #{I18n.l(11.day.from_now.to_date)}")
        expect(page).to have_content('Métodos de Pagamento: Apenas PIX')
        expect(page).to have_content('Preço total da estadia: R$ 170,00')

    end

    it 'cria cadastro e faz uma reserva com sucesso' do
        #Arrange
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Price.create!(new_rate: 300, start_date: '2023-02-03', final_date: '2023-02-03', room_id: room.id)
        guest = Guest.create!(name: 'Lily', cpf: '23456789', email: 'lily@guest.com', password: 'password')

        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 2
        fill_in 'Start date', with:  20.day.from_now
        fill_in 'Final date', with:  25.day.from_now
        click_on 'Fazer pre-reserva'
        click_on 'Fazer Reserva'
        click_on 'Criar conta'
        fill_in 'Nome', with: 'Bianca Rossini'
        fill_in 'E-mail', with: 'bianca@guest.com'
        fill_in 'Cpf', with: '32132131221'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        click_on 'Confirmar Reserva'
        
        #assert
        expect(current_path).to eq list_path
        expect(page).to have_content('Reserva confirmada com sucesso.')
        expect(page).to have_content('Nome do quarto: Quarto Pokémon')
        expect(page).to have_content('Número de hóspedes: 2')
        expect(page).to have_content("Dia da entranda: #{I18n.l(20.day.from_now.to_date)}")
        expect(page).to have_content("Dia da saída: #{I18n.l(25.day.from_now.to_date)}")
        expect(page).to have_content('Status da reserva: ativa')


    end
    it 'cria cadastro e tenta fazer uma reserva com data já ocupada' do
        #Arrange
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Price.create!(new_rate: 300, start_date: '2023-02-03', final_date: '2023-02-03', room_id: room.id)
        guest = Guest.create!(name: 'Lily', cpf: '23456789', email: 'lily@guest.com', password: 'password')

        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 2
        fill_in 'Start date', with: 20.day.from_now
        fill_in 'Final date',  with: 25.day.from_now
        click_on 'Fazer pre-reserva'
        click_on 'Fazer Reserva'
        click_on 'Criar conta'
        fill_in 'Nome', with: 'Bianca Rossini'
        fill_in 'E-mail', with: 'bianca@guest.com'
        fill_in 'Cpf', with: '32132131221'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        Reservation.create!(room_id: room.id, start_date: 20.day.from_now, final_date: 25.day.from_now, guest_number: 1, total_price: 200, guest_id: guest.id)
        click_on 'Confirmar Reserva'
        
     
        #assert
        expect(current_path).to eq room_reservations_path(room)
        expect(page).to have_content('Reserva não foi confirmada, tente novamente.')


    end
    
end