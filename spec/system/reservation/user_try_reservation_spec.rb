require 'rails_helper'

describe 'Usuário tenta fazer uma pre-reserva' do
    it 'mas falha pelo numero de hospedes' do
    #Arrange
    user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
    inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
    room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
    Reservation.create!(guest_number: 2, start_date: '2023-11-28', final_date: '2023-11-29', room_id: room.id)

    #act
    visit(root_path)
    click_on 'Pousada Nerd'
    click_on 'Quarto Pokémon'
    click_on 'Reservar'
    fill_in 'Guest number', with: 3
    fill_in 'Start date', with: '2023-12-28'
    fill_in 'Start date', with: '2023-12-30'
    click_on 'Fazer pre-reserva'
 
    #assert
    expect(page).to have_content('Pre-reserva não pode ser feita, mais hóspedes do que o quarto comporta.')
    expect(page).to have_content('Nome: Quarto Pokémon') 
    end

    it 'mas falha pelo por já ter a data reservada' do
        #Arrange
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Reservation.create!(guest_number: 2, start_date: '2023-12-28', final_date: '2023-12-29', room_id: room.id)
    
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
        expect(page).to have_content('Pre-reserva não pode ser feita, data já foi reservada.')
        expect(page).to have_content('Nome: Quarto Pokémon') 
    end


    it 'Com sucesso estando deslogado' do
        #Arrange
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Reservation.create!(guest_number: 2, start_date: '2023-12-28', final_date: '2023-12-29', room_id: room.id)
    
        #act
        visit(root_path)
        click_on 'Pousada Nerd'
        click_on 'Quarto Pokémon'
        click_on 'Reservar'
        fill_in 'Guest number', with: 1
        fill_in 'Start date', with: '2023-01-20'
        fill_in 'Final date', with: '2023-01-31'
        click_on 'Fazer pre-reserva'
     
        #assert
        expect(page).to have_content('Log in') 
        end

        
end