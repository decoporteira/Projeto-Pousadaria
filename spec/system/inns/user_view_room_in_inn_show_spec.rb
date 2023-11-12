require 'rails_helper'

describe 'Usuário vê os quartos da pousada dentro dos detalhes da pousada' do
    it 'e vê o quarto com sucesso' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 150, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id) 
        Price.create!(new_rate: 230, start_date: 5.day.from_now, final_date: 10.day.from_now, room_id: room.id)  
        
        visit(root_path)
        
        click_on 'Pousada de Teste'
      
                        
        expect(page).to have_content('Pousada de Teste')
        expect(page).to have_content('Nome: Quarto Pokémon')
        expect(page).to have_content('Descrição: Quarto idéntico ao quarto de Ash.')
        expect(page).to have_content('Diária: R$ 150,00')
        expect(page).not_to have_content('Diária: R$ 230,00')
    end


    it 'e vê o quarto e os preços por período com sucesso' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 150, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id) 
        Price.create!(new_rate: 230, start_date: Date.today, final_date: 5.day.from_now, room_id: room.id)  
        
        visit(root_path)
        
        click_on 'Pousada de Teste'

                        
        expect(page).to have_content('Pousada de Teste')
        expect(page).to have_content('Nome: Quarto Pokémon')
        expect(page).to have_content('Diária: R$ 230,00')
        expect(page).to have_content('Descrição: Quarto idéntico ao quarto de Ash.')
        expect(page).not_to have_content('Diária: R$ 150,00')
    end

end